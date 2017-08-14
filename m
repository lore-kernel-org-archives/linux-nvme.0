From: mwilck@suse.com (Martin Wilck)
Date: Mon, 14 Aug 2017 22:12:36 +0200
Subject: [PATCH v4 0/3] Improve readbility of NVME "wwid" attribute (target
 side)
In-Reply-To: <20170810084541.bawqaebfycnguomx@infradead.org>
References: <20170810084541.bawqaebfycnguomx@infradead.org>
Message-ID: <20170814201239.15255-1-mwilck@suse.com>

Hi Christoph,

I'm reposting the target-side of my patch rebased against 4.13-rc
as requested.

NOTE: an error has occurred while merging the previous version of my patch.
This is fixed by patch 1/3 in the series - that's an important fix for 4.13,
please push forward. 2/3 and 3/3 move the "copy_and_pad" functionality to a generic
helper, as requested. I've split this off in case the generic function meets
criticism elsewhere.

Original cover letter:

With the current implementation, the default "fallback" WWID generation
code (if no nguid, euid etc. are defined) for Linux NVME host and target
results in the following WWID format:

nvme.0000-3163653363666438366239656630386200-4c696e75780000000000000000000000000000000000000000000000000000000000000000000000-00000002

This is not only hard to read, it poses real problems e.g. for multipath
(dm WWIDs are limited to 128 characters).

With this patch series, the WWID on a Linux host connected to a Linux target
looks like this:

nvme.0000-65613435333665653738613464363961-4c696e7578-00000001

Changes wrt v1:
 * 1/3: new, moved helper to include/linux/string.h (Christoph Hellwig)
        (you suggested kernel.h, but I think this matches string.h better)      
 * Dropped the last patch from the v1 series that would have changed valid WWIDs for
   HW NVME controllers.

Changes wrt v2:
 * 3/3: Make sure no underflow occurs (Joe Perches)

Changes wrt v3:
 * Rebased on 4.13-rc3.
 * Dropped client-side patch which was merged in nvme-4.13 already.
 * Split off bug fix (patch 1/3).

Martin Wilck (3):
  nvmet_execute_identify_ctrl: don't overwrite with 0-bytes
  string.h: add memcpy_and_pad()
  nvmet_execute_identify_ctrl: use memcpy_and_pad()

 drivers/nvme/target/admin-cmd.c | 20 +++-----------------
 include/linux/string.h          | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 17 deletions(-)

-- 
2.14.0
