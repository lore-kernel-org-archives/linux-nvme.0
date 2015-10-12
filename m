From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 12 Oct 2015 17:05:07 -0400
Subject: Block integrity registration update
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
Message-ID: <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>

As requested, here's the integrity registration update for 4.4. Only
delta is patch 5 which retains the non-PI metadata check as requested by
Keith as well as the DM rework by Mike. I rebased on top of
block/for-4.4/drivers to accommodate the NVMe shuffle.

[PATCH 1/5] block: Move integrity kobject to struct gendisk
[PATCH 2/5] block: Consolidate static integrity profile properties
[PATCH 3/5] block: Reduce the size of struct blk_integrity
[PATCH 4/5] block: Export integrity data interval size in sysfs
[PATCH 5/5] block: Inline blk_integrity in struct gendisk

-- 
Martin K. Petersen	Oracle Linux Engineering
