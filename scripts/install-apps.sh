#!/bin/bash

# Application Installation script for automating installation for pacman & yay(AUR) packages
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_FILE="${SCRIPT_DIR}/pacman.txt"
YAY_FILE="${SCRIPT_DIR}/yay.txt"

# Log functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should NOT be run as root!"
        exit 1
    fi
}

# Check if files exist
check_files() {
    if [[ ! -f "$PACMAN_FILE" ]]; then
        log_error "pacman.txt not found in $SCRIPT_DIR"
        exit 1
    fi
    
    if [[ ! -f "$YAY_FILE" ]]; then
        log_error "yay.txt not found in $SCRIPT_DIR"
        exit 1
    fi
    
    log_success "Found package list files"
}

# Parse package list from file (ignore comments and empty lines)
parse_packages() {
    local file="$1"
    grep -v '^#' "$file" | grep -v '^[[:space:]]*$' | tr '\n' ' '
}

# Check if yay is installed
check_yay() {
    if ! command -v yay &> /dev/null; then
        log_warning "yay (AUR helper) is not installed"
        read -p "Do you want to install yay? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_yay
        else
            log_error "yay is required for AUR packages. Exiting."
            exit 1
        fi
    else
        log_success "yay is already installed"
    fi
}

# Install yay
install_yay() {
    log_info "Installing yay..."
    
    # Install dependencies
    sudo pacman -S --needed --noconfirm git base-devel
    
    # Clone and build yay
    local temp_dir=$(mktemp -d)
    cd "$temp_dir"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$SCRIPT_DIR"
    rm -rf "$temp_dir"
    
    log_success "yay installed successfully"
}

# Update system
update_system() {
    log_info "Updating system..."
    sudo pacman -Syu --noconfirm
    log_success "System updated"
}

# Install pacman packages
install_pacman_packages() {
    log_info "Reading pacman packages from $PACMAN_FILE..."
    
    local packages=$(parse_packages "$PACMAN_FILE")
    
    if [[ -z "$packages" ]]; then
        log_warning "No pacman packages to install"
        return
    fi
    
    log_info "Packages to install: $packages"
    read -p "Proceed with installation? (Y/n): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        log_info "Installing pacman packages..."
        sudo pacman -S --needed --noconfirm $packages
        log_success "Pacman packages installed successfully"
    else
        log_warning "Skipped pacman packages installation"
    fi
}

# Install AUR packages
install_aur_packages() {
    log_info "Reading AUR packages from $YAY_FILE..."
    
    local packages=$(parse_packages "$YAY_FILE")
    
    if [[ -z "$packages" ]]; then
        log_warning "No AUR packages to install"
        return
    fi
    
    log_info "AUR packages to install: $packages"
    read -p "Proceed with installation? (Y/n): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        log_info "Installing AUR packages..."
        yay -S --needed --noconfirm $packages
        log_success "AUR packages installed successfully"
    else
        log_warning "Skipped AUR packages installation"
    fi
}

# Create necessary directories
create_directories() {
    log_info "Creating necessary directories..."
    
    mkdir -p ~/Pictures/Screenshots
    mkdir -p ~/.config/hypr/scripts
    
    log_success "Directories created"
}

# Enable services
enable_services() {
    log_info "Enabling services..."
    
    # Enable Docker if installed
    if command -v docker &> /dev/null; then
        sudo systemctl enable --now docker.service
        sudo usermod -aG docker $USER
        log_success "Docker service enabled and user added to docker group"
    fi
    
    # Enable Bluetooth if installed
    if command -v bluetoothctl &> /dev/null; then
        sudo systemctl enable --now bluetooth.service
        log_success "Bluetooth service enabled"
    fi
}

# Post-installation message
post_install_message() {
    echo
    log_success "Installation completed!"
    echo
    echo -e "${YELLOW}Post-installation steps:${NC}"
    echo "1. Log out and log back in for group changes to take effect (especially for Docker)"
    echo "2. Configure your Hyprland config at ~/.config/hypr/"
    echo "3. Make sure to set up your wallpapers in ~/Pictures/"
    echo "4. Run 'hyprctl reload' to reload Hyprland configuration"
    echo
    log_info "You may need to install additional fonts and themes based on your preference"
}

# Main function
main() {
    echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║   Hyprland Application Installer          ║${NC}"
    echo -e "${BLUE}║   Author: Binoy Manoj                     ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
    echo
    
    check_root
    check_files
    
    # Ask for confirmation
    read -p "This will install packages from pacman.txt and yay.txt. Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_warning "Installation cancelled by user"
        exit 0
    fi
    
    update_system
    check_yay
    install_pacman_packages
    install_aur_packages
    create_directories
    enable_services
    post_install_message
}

# Run main function
main
