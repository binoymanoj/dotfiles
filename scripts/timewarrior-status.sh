#!/bin/bash
# Shows current timewarrior tracking status for HyprPanel

if timew 2>/dev/null | grep -q "Tracking"; then
    TAG=$(timew get dom.active.tag.1 2>/dev/null)
    DURATION=$(timew 2>/dev/null | grep "Total" | awk '{print $2}')
    echo "⏱️ $TAG $DURATION"
else
    echo ""
fi
