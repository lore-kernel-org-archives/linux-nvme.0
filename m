From: mundu2510@gmail.com (Mundu)
Date: Tue, 22 Jul 2014 22:55:38 +0530
Subject: NVMe: Invalid controller status value, device hotplug out
Message-ID: <1406049939-29310-1-git-send-email-mundu2510@gmail.com>

 If device hotplug out, controller status become 0xFFFF_FFFF
 1. Controller fatal status become true in nvme_kthread()
 2. Ready bit nvere reset to 0 in nvme_wait_ready() for
    controller disable.
    above two scenarios controller status data is not a valid
    data, since device/controller is already removed (hotplug)
