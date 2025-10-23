Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA742CCF9E3
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jx8bl9MSI65C0YD1qCFEDAVitXRmWb7T3dt/MIHgYAk=; b=iSzutJxBXfak1aBS5l73Gbv0Bm
	xSRAKLssPFvYyLkCaPrJhrCPfkGatKl9d8v472ZuAJm2IvqvcURLQHDr4Ec6grRizzQ+qghAdbqyX
	FD9idVUiw4lhV+C/tjxBbYV0Q+E6MJjMDp5rWw3MQOc61pSF1AUi+jWEDsfUnshgTB+hVQTd8zRv4
	IjgSatSLty7G5Uw6fZEQdcHtvCUbtfXssmvBLKry/p/YQgPaPNmz4JuOhbjBWwSmUu3fvcLUwe9ls
	PRDqIfA5UMtEuk0LGmqE9D3oeBmytHmmXQVAkL0M/5dWOMXs1+5F+5QjEDQs3i+od1IpkbgNF/sk9
	SpDaWH8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1K3-00000007PP5-2utY;
	Thu, 23 Oct 2025 19:50:07 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1K0-00000007POe-3Im0
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 19:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761249005; x=1792785005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Skua1k2e3mB8SWqi2ga5oqhkJAG1HZvPfRJSsVS0qSs=;
  b=JczYdxEF320kS1L5lhHkTEL3IHL91yazze3RtRVCViexktbnrUc/egnL
   RsIfB0hUn4nqi2iY3sgb9p7TCeME9yYYCh0AZUUYKrvR6Y1M7osmAdBTM
   2r34uGZcbSNU3yD9kUienMOkd8QNIAc+F+JuhVOeicOBFPfrtt9N/lSSV
   JTbbvYS9GKMpQ1Jn1L8qx/KWtByutSootBUeFuwVes/QUSKPQTx3deDew
   FBT7tbrfi1uC7VlGN23EEUvPv5xO0jU/Y0nxL/IQ/rE4CoRt2gBojNInr
   4fvhE55oFHA33w/hLV1TfOvLq1sPlzQCIn4DT9zdmY6uY/RE2ztPRwtA9
   Q==;
X-CSE-ConnectionGUID: jb8hR6VpTLa0fwiQES+GRA==
X-CSE-MsgGUID: CFeuBPUuTuy8qh5YXKnGfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74550626"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="74550626"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 12:50:04 -0700
X-CSE-ConnectionGUID: 2Rs/IhRhSS2PSn3gAgtgDQ==
X-CSE-MsgGUID: 6Y2P8BYzRYeQpitDQCe9ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="207894922"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 23 Oct 2025 12:50:00 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vC1Jj-000Dp7-15;
	Thu, 23 Oct 2025 19:49:50 +0000
Date: Fri, 24 Oct 2025 03:49:09 +0800
From: kernel test robot <lkp@intel.com>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <chris.mason@fusionio.com>,
	David Sterba <dsterba@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
Message-ID: <202510240319.bLypyxx1-lkp@intel.com>
References: <20251022231326.2527838-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022231326.2527838-4-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_125004_899734_A605A100 
X-CRM114-Status: GOOD (  16.57  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Caleb,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on kdave/for-next linus/master v6.18-rc2]
[cannot apply to mszeredi-fuse/for-next linux-nvme/for-next next-20251023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Caleb-Sander-Mateos/io_uring-expose-io_should_terminate_tw/20251023-071617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20251022231326.2527838-4-csander%40purestorage.com
patch subject: [PATCH 3/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
config: arm-randconfig-002-20251024 (https://download.01.org/0day-ci/archive/20251024/202510240319.bLypyxx1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240319.bLypyxx1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510240319.bLypyxx1-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> block/ioctl.c:781:8: error: return type defaults to 'int' [-Wimplicit-int]
     781 | static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> block/ioctl.c:781:8: error: function declaration isn't a prototype [-Werror=strict-prototypes]
   block/ioctl.c: In function 'DEFINE_IO_URING_CMD_TASK_WORK':
>> block/ioctl.c:784:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     784 | {
         | ^
   block/ioctl.c:798:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     798 | {
         | ^
   block/ioctl.c:853:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     853 | {
         | ^
>> block/ioctl.c:781:8: error: type of 'blk_cmd_complete' defaults to 'int' [-Wimplicit-int]
     781 | static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> block/ioctl.c:876: error: expected '{' at end of input
   block/ioctl.c: At top level:
>> block/ioctl.c:781:8: warning: 'DEFINE_IO_URING_CMD_TASK_WORK' defined but not used [-Wunused-function]
     781 | static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> block/ioctl.c:772:13: warning: 'blk_cmd_complete' defined but not used [-Wunused-function]
     772 | static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
         |             ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> drivers/nvme/host/ioctl.c:410:8: error: return type defaults to 'int' [-Wimplicit-int]
     410 | static DEFINE_IO_URING_CMD_TASK_WORK(nvme_uring_task_cb)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/ioctl.c:410:8: error: function declaration isn't a prototype [-Werror=strict-prototypes]
   drivers/nvme/host/ioctl.c: In function 'DEFINE_IO_URING_CMD_TASK_WORK':
>> drivers/nvme/host/ioctl.c:414:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     414 | {
         | ^
   drivers/nvme/host/ioctl.c:441:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     441 | {
         | ^
   drivers/nvme/host/ioctl.c:534:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     534 | {
         | ^
   drivers/nvme/host/ioctl.c:544:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     544 | {
         | ^
   drivers/nvme/host/ioctl.c:575:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     575 | {
         | ^
   drivers/nvme/host/ioctl.c:605:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     605 | {
         | ^
   drivers/nvme/host/ioctl.c:620:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     620 | {
         | ^
   drivers/nvme/host/ioctl.c:632:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     632 | {
         | ^
   drivers/nvme/host/ioctl.c:643:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     643 | {
         | ^
   drivers/nvme/host/ioctl.c:666:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     666 | {
         | ^
   drivers/nvme/host/ioctl.c:676:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     676 | {
         | ^
   drivers/nvme/host/ioctl.c:777:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     777 | {
         | ^
   drivers/nvme/host/ioctl.c:805:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     805 | {
         | ^
   drivers/nvme/host/ioctl.c:842:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     842 | {
         | ^
>> drivers/nvme/host/ioctl.c:410:8: error: type of 'nvme_uring_task_cb' defaults to 'int' [-Wimplicit-int]
     410 | static DEFINE_IO_URING_CMD_TASK_WORK(nvme_uring_task_cb)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/ioctl.c:872: error: expected '{' at end of input
   drivers/nvme/host/ioctl.c: At top level:
>> drivers/nvme/host/ioctl.c:410:8: warning: 'DEFINE_IO_URING_CMD_TASK_WORK' defined but not used [-Wunused-function]
     410 | static DEFINE_IO_URING_CMD_TASK_WORK(nvme_uring_task_cb)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/ioctl.c:401:13: warning: 'nvme_uring_task_cb' defined but not used [-Wunused-function]
     401 | static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/ioctl.c:329:12: warning: 'nvme_user_cmd64' defined but not used [-Wunused-function]
     329 | static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
         |            ^~~~~~~~~~~~~~~
>> drivers/nvme/host/ioctl.c:281:12: warning: 'nvme_user_cmd' defined but not used [-Wunused-function]
     281 | static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
         |            ^~~~~~~~~~~~~
>> drivers/nvme/host/ioctl.c:206:12: warning: 'nvme_submit_io' defined but not used [-Wunused-function]
     206 | static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
         |            ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/int +781 block/ioctl.c

   771	
 > 772	static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
   773	{
   774		struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
   775	
   776		if (bic->res == -EAGAIN && bic->nowait)
   777			io_uring_cmd_issue_blocking(cmd);
   778		else
   779			io_uring_cmd_done(cmd, bic->res, issue_flags);
   780	}
 > 781	static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
   782	
   783	static void bio_cmd_bio_end_io(struct bio *bio)
 > 784	{
   785		struct io_uring_cmd *cmd = bio->bi_private;
   786		struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
   787	
   788		if (unlikely(bio->bi_status) && !bic->res)
   789			bic->res = blk_status_to_errno(bio->bi_status);
   790	
   791		io_uring_cmd_do_in_task_lazy(cmd, blk_cmd_complete);
   792		bio_put(bio);
   793	}
   794	
   795	static int blkdev_cmd_discard(struct io_uring_cmd *cmd,
   796				      struct block_device *bdev,
   797				      uint64_t start, uint64_t len, bool nowait)
 > 798	{
   799		struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
   800		gfp_t gfp = nowait ? GFP_NOWAIT : GFP_KERNEL;
   801		sector_t sector = start >> SECTOR_SHIFT;
   802		sector_t nr_sects = len >> SECTOR_SHIFT;
   803		struct bio *prev = NULL, *bio;
   804		int err;
   805	
   806		if (!bdev_max_discard_sectors(bdev))
   807			return -EOPNOTSUPP;
   808		if (!(file_to_blk_mode(cmd->file) & BLK_OPEN_WRITE))
   809			return -EBADF;
   810		if (bdev_read_only(bdev))
   811			return -EPERM;
   812		err = blk_validate_byte_range(bdev, start, len);
   813		if (err)
   814			return err;
   815	
   816		err = filemap_invalidate_pages(bdev->bd_mapping, start,
   817						start + len - 1, nowait);
   818		if (err)
   819			return err;
   820	
   821		while (true) {
   822			bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects, gfp);
   823			if (!bio)
   824				break;
   825			if (nowait) {
   826				/*
   827				 * Don't allow multi-bio non-blocking submissions as
   828				 * subsequent bios may fail but we won't get a direct
   829				 * indication of that. Normally, the caller should
   830				 * retry from a blocking context.
   831				 */
   832				if (unlikely(nr_sects)) {
   833					bio_put(bio);
   834					return -EAGAIN;
   835				}
   836				bio->bi_opf |= REQ_NOWAIT;
   837			}
   838	
   839			prev = bio_chain_and_submit(prev, bio);
   840		}
   841		if (unlikely(!prev))
   842			return -EAGAIN;
   843		if (unlikely(nr_sects))
   844			bic->res = -EAGAIN;
   845	
   846		prev->bi_private = cmd;
   847		prev->bi_end_io = bio_cmd_bio_end_io;
   848		submit_bio(prev);
   849		return -EIOCBQUEUED;
   850	}
   851	
   852	int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 > 853	{
   854		struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
   855		struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
   856		const struct io_uring_sqe *sqe = cmd->sqe;
   857		u32 cmd_op = cmd->cmd_op;
   858		uint64_t start, len;
   859	
   860		if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
   861			     sqe->rw_flags || sqe->file_index))
   862			return -EINVAL;
   863	
   864		bic->res = 0;
   865		bic->nowait = issue_flags & IO_URING_F_NONBLOCK;
   866	
   867		start = READ_ONCE(sqe->addr);
   868		len = READ_ONCE(sqe->addr3);
   869	
   870		switch (cmd_op) {
   871		case BLOCK_URING_CMD_DISCARD:
   872			return blkdev_cmd_discard(cmd, bdev, start, len, bic->nowait);
   873		}
   874		return -EINVAL;
   875	}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

