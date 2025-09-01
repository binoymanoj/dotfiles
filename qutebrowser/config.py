# Qutebrowser Config
# Author: Binoy Manoj
# GitHub: https://github.com/binoymanoj

# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'devtools://*')

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{upstream_browser_version_short}`: The
# corresponding Safari/Chrome   version, but only with its major
# version. * `{qutebrowser_version}`: The currently running qutebrowser
# version.  The default value is equal to the default user agent of
# QtWebKit/QtWebEngine, but with the `QtWebEngine/...` part removed for
# increased compatibility.  Note that the value read from JavaScript is
# always the global value.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:136.0) Gecko/20100101 Firefox/139.0', 'https://accounts.google.com/*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow locally loaded documents to access remote URLs.
# Type: Bool
config.set('content.local_content_can_access_remote_urls', True, 'file:///home/cyph3r/.local/share/qutebrowser/userscripts/*')

# Allow locally loaded documents to access other local URLs.
# Type: Bool
config.set('content.local_content_can_access_file_urls', False, 'file:///home/cyph3r/.local/share/qutebrowser/userscripts/*')

# CSS border value for hints.
# Type: String
c.hints.border = '1px solid #fff'

# Rounding radius (in pixels) for the edges of hints.
# Type: Int
c.hints.radius = 1

# When/how to show the scrollbar.
# Type: String
# Valid values:
#   - always: Always show the scrollbar.
#   - never: Never show the scrollbar.
#   - when-searching: Show the scrollbar when searching for text in the webpage. With the QtWebKit backend, this is equal to `never`.
#   - overlay: Show an overlay scrollbar. On macOS, this is unavailable and equal to `when-searching`; with the QtWebKit backend, this is equal to `never`. Enabling/disabling overlay scrollbars requires a restart.
c.scrolling.bar = 'never'

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'multiple'

# Block ads
c.content.blocking.enabled = True
c.content.blocking.method = 'both'

# Search engines which can be used via the address bar.  Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` braces.  The following further
# placeholds are defined to configure how special characters in the
# search terms are replaced by safe characters (called 'quoting'):  *
# `{}` and `{semiquoted}` quote everything except slashes; this is the
# most   sensible choice for almost all search engines (for the search
# term   `slash/and&amp` this placeholder expands to `slash/and%26amp`).
# * `{quoted}` quotes all characters (for `slash/and&amp` this
# placeholder   expands to `slash%2Fand%26amp`). * `{unquoted}` quotes
# nothing (for `slash/and&amp` this placeholder   expands to
# `slash/and&amp`). * `{0}` means the same as `{}`, but can be used
# multiple times.  The search engine named `DEFAULT` is used when
# `url.auto_search` is turned on and something else than a URL was
# entered to be opened. Other search engines can be used by prepending
# the search engine name to the search term, e.g. `:open google
# qutebrowser`.
# Type: Dict
c.url.searchengines = {'DEFAULT': 'https://www.google.com/search?q={}'}

# ===== APPEARANCE SETTINGS =====
# Fonts
c.fonts.default_family = 'JetBrains Mono'
c.fonts.default_size = '11pt'
c.fonts.completion.entry = 'default_size default_family'
c.fonts.completion.category = 'bold default_size default_family'
c.fonts.debug_console = 'default_size default_family'
c.fonts.downloads = 'default_size default_family'
c.fonts.hints = 'bold 12pt default_family'
c.fonts.keyhint = 'default_size default_family'
c.fonts.messages.error = 'default_size default_family'
c.fonts.messages.info = 'default_size default_family'
c.fonts.messages.warning = 'default_size default_family'
c.fonts.prompts = 'default_size sans-serif'
c.fonts.statusbar = 'default_size default_family'
c.fonts.tabs.selected = 'bold default_size default_family'
c.fonts.tabs.unselected = 'default_size default_family'
c.fonts.web.family.standard = 'Liberation Serif'
c.fonts.web.family.fixed = 'Liberation Mono'
c.fonts.web.family.serif = 'Liberation Serif'
c.fonts.web.family.sans_serif = 'Liberation Sans'
c.fonts.web.size.default = 16
c.fonts.web.size.default_fixed = 13
c.fonts.web.size.minimum = 10
c.fonts.web.size.minimum_logical = 8

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = '#1A1D23'

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = '#1A1D23'

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = '#1A1D23'

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = 'black'

# Foreground color of the matched text in the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.match.fg = '#9199CB'

# Foreground color of the matched text in the completion.
# Type: QtColor
c.colors.completion.match.fg = '#9199CB'

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = '#fff'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = '#1A1D23'

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = '#9199CB'

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = '#1A1D23'

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = '#9199CB'

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = '#9199CB'

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = '#9199CB'

c.colors.statusbar.url.hover.fg = '#9199CB'

# Background color of the tab bar.
# Type: QssColor
c.colors.tabs.bar.bg = '#1A1D23'

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = '#1A1D23'

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = 'white'

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = '#1A1D23'

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = '#9199CB'

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = '#9199CB'

# Render all web contents using a dark theme. On QtWebEngine < 6.7, this
# setting requires a restart and does not support URL patterns, only the
# global setting is applied. Example configurations from Chromium's
# `chrome://flags`: - "With simple HSL/CIELAB/RGB-based inversion": Set
# `colors.webpage.darkmode.algorithm` accordingly, and   set
# `colors.webpage.darkmode.policy.images` to `never`.  - "With selective
# image inversion": qutebrowser default settings.
# Type: Bool
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'

# Font used for the hints.
# Type: Font
c.fonts.hints = 'normal default_size default_family'

# URL and search
c.url.default_page = 'https://google.com'
c.url.start_pages = 'https://start.duckduckgo.com'
# c.url.searchengines = {
#     'DEFAULT': 'https://www.google.com/search?q={}',
#     'g': 'https://www.google.com/search?q={}',
#     'ddg': 'https://duckduckgo.com/?q={}',
#     'gh': 'https://github.com/search?q={}',
#     'so': 'https://stackoverflow.com/search?q={}',
#     'yt': 'https://www.youtube.com/results?search_query={}',
#     'w': 'https://en.wikipedia.org/wiki/{}',
#     'r': 'https://www.reddit.com/search/?q={}',
#     'a': 'https://wiki.archlinux.org/index.php?search={}',
# }
c.url.auto_search = 'naive'

# Unbind 'd' from tab closing
config.unbind('d')

# Bind 'd' to scroll down (half page)
config.bind('d', 'scroll-page 0 0.5')

# Bind 'u' to scroll up (half page)  
config.bind('u', 'scroll-page 0 -0.5')

# Bind 'x' to close current tab
config.bind('x', 'tab-close')

# Enable smooth scrolling for web pages. Note smooth scrolling does not
# work with the `:scroll-px` command.
# Type: Bool
c.scrolling.smooth = True

# Performance 
c.qt.chromium.low_end_device_mode = 'auto'
c.qt.chromium.process_model = 'process-per-site-instance'
