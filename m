From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Jun 2016 11:26:28 +0800
Subject: [PATCH v2 02/12] genhd: Honor gen_uevent and add disk_gen_uevents
In-Reply-To: <20160630015953.6888-3-famz@redhat.com>
Message-ID: <201606301124.3nwuTwiP%fengguang.wu@intel.com>

Hi,

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.7-rc5]
[cannot apply to next-20160629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Fam-Zheng/gendisk-Generate-uevent-after-attribute-available/20160630-100720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   lib/crc32.c:148: warning: No description found for parameter 'tab)[256]'
   lib/crc32.c:148: warning: Excess function parameter 'tab' description in 'crc32_le_generic'
   lib/crc32.c:293: warning: No description found for parameter 'tab)[256]'
   lib/crc32.c:293: warning: Excess function parameter 'tab' description in 'crc32_be_generic'
   lib/crc32.c:1: warning: no structured comments found
   mm/memory.c:2881: warning: No description found for parameter 'old'
>> block/genhd.c:575: warning: No description found for parameter 'disk'
>> block/genhd.c:575: warning: No description found for parameter 'disk'

vim +/disk +575 block/genhd.c

   559		blkdev_put(bdev, FMODE_READ);
   560	
   561	exit:
   562		/* announce disk after possible partitions are created */
   563		dev_set_uevent_suppress(ddev, 0);
   564		if (gen_uevent)
   565			disk_gen_uevents(disk);
   566	}
   567	
   568	/**
   569	 * disk_gen_uevents
   570	 * @disk - the disk to generate uevent
   571	 *
   572	 * Generate KOBJ_ADD uevents on the disk and partitions.
   573	 */
   574	void disk_gen_uevents(struct gendisk *disk)
 > 575	{
   576		struct device *ddev = disk_to_dev(disk);
   577		struct disk_part_iter piter;
   578		struct hd_struct *part;
   579	
   580		kobject_uevent(&ddev->kobj, KOBJ_ADD);
   581	
   582		/* announce possible partitions */
   583		disk_part_iter_init(&piter, disk, 0);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160630/31e38911/attachment-0001.obj>
