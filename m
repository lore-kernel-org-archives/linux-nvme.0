From: elliott@hpe.com (Elliott, Robert (Persistent Memory))
Date: Fri, 30 Jun 2017 12:44:11 +0000
Subject: [PATCHv2] nvme: Remove SCSI translations
In-Reply-To: <1497987223-3119-1-git-send-email-keith.busch@intel.com>
References: <1497987223-3119-1-git-send-email-keith.busch@intel.com>
Message-ID: <AT5PR84MB00825BA1A84C313BE26C1099ABD30@AT5PR84MB0082.NAMPRD84.PROD.OUTLOOK.COM>

> Subject: [PATCHv2] nvme: Remove SCSI translations
> 
> The SCSI-to-NVMe translations were added to assist storage applications
> utilizing SG_IO transitioning to NVMe. It was always recommended,
> however, to use native NVMe for device management as too much is lost
> in translation and the maintenance burden in keeping this kludgey
> layer around has been neglected such that much of the translations are
> completely broken.
> 
> This patch removes SG_IO handling from NVMe to avoid any confusion
> regarding maintenance support for this interface. The config option for
> NVMe SCSI emulation has been disabled by default since 4.5. The driver
> has supported native nvme user commands since the beginning, and native
> tooling is publicly available for use or as reference for anyone writing
> their own tools, so there's no excuse for hanging onto a broken crutch.

As Linda and Micah mentioned, this violates a cardinal linux kernel rule -
it breaks user space.

Please:
1. Incorporate the TEST UNIT READY bug fix now.
2. Add a WARN_ONCE printing a message that the interface that was just
used is deprecated and will go away, and modify the CONFIG description
to include that warning too.
3. Wait a few kernel cycles before really removing it.


---
Robert Elliott, HPE Persistent Memory
