From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 10 Mar 2016 14:38:36 +0200
Subject: [PATCH v3 for-4.6 0/4] Provide better active I/O termination
 handlers
In-Reply-To: <1457611129-8036-1-git-send-email-sagig@mellanox.com>
References: <1457611129-8036-1-git-send-email-sagig@mellanox.com>
Message-ID: <56E16ACC.7090108@dev.mellanox.co.il>


> This patchset adds helper to active IO termination to block layer
> based on the pci nvme_clear_queues() functionality. This is needed
> for live shutdowns and resets during live IO and it's not nvme/pci
> specific and will be needed for other transports as well.
>
> This patchset applies on top of "for-4.6-drivers" patchset.

Actually, it applies against for-next now...
