Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA48BCCD1BC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LcFysJnNgZCT/SQYYoMSP+JkQvvuW7ZmqZ9909GZ9nQ=; b=cP7VXdI40o+d0vM1vNXfCBz3ff
	CAnH48zXm/JmQsNcIXWv8ar8I8bGH56DH87abBJyzdtdqIREwqcZ5Jf45G5hYRLn1ZH16Njd0M2X7
	48yr8PpLx0ZaDD9x+x2DYM5ccmdKy2gmYmRTWxmwlYHHnozmfgOz3ChrWOm3pNKjIW9KG6HTJn+85
	NuSa5S1iiCbaLMOd1TG3hV0Xmr4AUVkwnfmgzaVG2M/H/9w3QsaY3xJyoWVTbkM8SN30is0XVLu0Q
	kc0oJWywMjgrO3aSRRayjA5Q+xl5kugEOMONpngnC52xcKbxaoTfK/qLbczx70REme3RNQo+UOLuh
	+iDe5jHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBu5f-00000006BEr-3SPQ;
	Thu, 23 Oct 2025 12:06:47 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBu5d-00000006BEW-3S1e
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 12:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761221206; x=1792757206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kxw75anzo26d/gWdMfSPCv4TNV0xnDe2ItxmgjbDW8E=;
  b=CWh8dmEgVHNtsWCKs0BJqIWedlJuLS3NsHNV9EOXh/dWSQLo+gec8aye
   +dzjX2/wbWp60ppwcICSj2e0Gq+ba1rFRXu4cf36pheN33Vl/EUIGN3n+
   woGQ+xI4pzIP8pcTPjMjc3hXFCvHIXScwySQmJcUfVj5acq9qj0ozPPBH
   eRuntmW94LnRf6ZljNPgA/z16QPnGRPrATZ8Qx9Odqntr9nPzmzvKTel5
   jostGM3axw7ogeU3zLX9ZRC9FPbXyIsDg1s6WvrcJ5Otj8n19YNxZvjER
   +h0niZKSgvyqQ0gCx6uDHC0LMQlmDBD0kUcZW/O5E+Ib2Obq76kb7d6HU
   g==;
X-CSE-ConnectionGUID: Po9+4/CAS12pI3c+8ArAMA==
X-CSE-MsgGUID: kApNLb1KRVWaQk4CeRTk6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74733311"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="74733311"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 05:06:46 -0700
X-CSE-ConnectionGUID: tSitkFo/QTyDESIgSNDvwA==
X-CSE-MsgGUID: 0Auo8vX1RCWbkqL2ng1u1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184916161"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2025 05:06:37 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBu5S-000DRp-2V;
	Thu, 23 Oct 2025 12:06:34 +0000
Date: Thu, 23 Oct 2025 20:05:39 +0800
From: kernel test robot <lkp@intel.com>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <chris.mason@fusionio.com>,
	David Sterba <dsterba@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
Message-ID: <202510231952.gAXMcT2A-lkp@intel.com>
References: <20251022231326.2527838-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022231326.2527838-4-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_050645_903117_2CD21BC1 
X-CRM114-Status: GOOD (  14.83  )
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
config: x86_64-buildonly-randconfig-005-20251023 (https://download.01.org/0day-ci/archive/20251023/202510231952.gAXMcT2A-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251023/202510231952.gAXMcT2A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510231952.gAXMcT2A-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/ioctl.c:783:1: error: invalid storage class specifier in function declarator
     783 | static void bio_cmd_bio_end_io(struct bio *bio)
         | ^
>> block/ioctl.c:783:13: error: parameter named 'bio_cmd_bio_end_io' is missing
     783 | static void bio_cmd_bio_end_io(struct bio *bio)
         |             ^
>> block/ioctl.c:783:48: error: expected ';' at end of declaration
     783 | static void bio_cmd_bio_end_io(struct bio *bio)
         |                                                ^
         |                                                ;
>> block/ioctl.c:781:38: error: parameter 'blk_cmd_complete' was not declared, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     781 | static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
         |                                      ^
     782 | 
     783 | static void bio_cmd_bio_end_io(struct bio *bio)
     784 | {
>> block/ioctl.c:781:8: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     781 | static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
         | ~~~~~~ ^
         | int
>> block/ioctl.c:785:29: error: use of undeclared identifier 'bio'
     785 |         struct io_uring_cmd *cmd = bio->bi_private;
         |                                    ^
   block/ioctl.c:788:15: error: use of undeclared identifier 'bio'
     788 |         if (unlikely(bio->bi_status) && !bic->res)
         |                      ^
   block/ioctl.c:789:34: error: use of undeclared identifier 'bio'
     789 |                 bic->res = blk_status_to_errno(bio->bi_status);
         |                                                ^
>> block/ioctl.c:791:2: error: call to undeclared function 'IO_URING_CMD_TASK_WORK'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     791 |         io_uring_cmd_do_in_task_lazy(cmd, blk_cmd_complete);
         |         ^
   include/linux/io_uring/cmd.h:149:7: note: expanded from macro 'io_uring_cmd_do_in_task_lazy'
     149 |                                   IO_URING_CMD_TASK_WORK(uring_cmd_cb),         \
         |                                   ^
   block/ioctl.c:791:2: note: did you mean 'DEFINE_IO_URING_CMD_TASK_WORK'?
   include/linux/io_uring/cmd.h:149:7: note: expanded from macro 'io_uring_cmd_do_in_task_lazy'
     149 |                                   IO_URING_CMD_TASK_WORK(uring_cmd_cb),         \
         |                                   ^
   block/ioctl.c:781:8: note: 'DEFINE_IO_URING_CMD_TASK_WORK' declared here
     781 | static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
         |        ^
>> block/ioctl.c:791:2: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'io_req_tw_func_t' (aka 'void (*)(struct io_kiocb *, struct io_tw_state)') [-Wint-conversion]
     791 |         io_uring_cmd_do_in_task_lazy(cmd, blk_cmd_complete);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/io_uring/cmd.h:149:7: note: expanded from macro 'io_uring_cmd_do_in_task_lazy'
     149 |                                   IO_URING_CMD_TASK_WORK(uring_cmd_cb),         \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/io_uring/cmd.h:123:25: note: passing argument to parameter 'task_work_cb' here
     123 |                             io_req_tw_func_t task_work_cb, unsigned flags)
         |                                              ^
   block/ioctl.c:792:10: error: use of undeclared identifier 'bio'; did you mean 'bic'?
     792 |         bio_put(bio);
         |                 ^~~
         |                 bic
   block/ioctl.c:786:22: note: 'bic' declared here
     786 |         struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
         |                             ^
>> block/ioctl.c:781:8: error: a function definition without a prototype is deprecated in all versions of C and is not supported in C23 [-Werror,-Wdeprecated-non-prototype]
     781 | static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
         |        ^
>> block/ioctl.c:847:20: error: use of undeclared identifier 'bio_cmd_bio_end_io'
     847 |         prev->bi_end_io = bio_cmd_bio_end_io;
         |                           ^
   13 errors generated.
--
>> drivers/nvme/host/ioctl.c:412:1: error: invalid storage class specifier in function declarator
     412 | static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
         | ^
>> drivers/nvme/host/ioctl.c:412:27: error: parameter named 'nvme_uring_cmd_end_io' is missing
     412 | static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
         |                           ^
>> drivers/nvme/host/ioctl.c:413:24: error: expected ';' at end of declaration
     413 |                                                 blk_status_t err)
         |                                                                  ^
         |                                                                  ;
>> drivers/nvme/host/ioctl.c:410:38: error: parameter 'nvme_uring_task_cb' was not declared, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     410 | static DEFINE_IO_URING_CMD_TASK_WORK(nvme_uring_task_cb)
         |                                      ^
     411 | 
     412 | static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
     413 |                                                 blk_status_t err)
     414 | {
>> drivers/nvme/host/ioctl.c:410:8: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     410 | static DEFINE_IO_URING_CMD_TASK_WORK(nvme_uring_task_cb)
         | ~~~~~~ ^
         | int
>> drivers/nvme/host/ioctl.c:415:32: error: use of undeclared identifier 'req'
     415 |         struct io_uring_cmd *ioucmd = req->end_io_data;
         |                                       ^
   drivers/nvme/host/ioctl.c:418:15: error: use of undeclared identifier 'req'
     418 |         if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
         |                      ^
   drivers/nvme/host/ioctl.c:421:26: error: use of undeclared identifier 'req'
     421 |                 pdu->status = nvme_req(req)->status;
         |                                        ^
>> drivers/nvme/host/ioctl.c:423:38: error: use of undeclared identifier 'err'
     423 |                         pdu->status = blk_status_to_errno(err);
         |                                                           ^
   drivers/nvme/host/ioctl.c:425:37: error: use of undeclared identifier 'req'
     425 |         pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
         |                                            ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
>> drivers/nvme/host/ioctl.c:435:2: error: call to undeclared function 'IO_URING_CMD_TASK_WORK'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     435 |         io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
         |         ^
   include/linux/io_uring/cmd.h:149:7: note: expanded from macro 'io_uring_cmd_do_in_task_lazy'
     149 |                                   IO_URING_CMD_TASK_WORK(uring_cmd_cb),         \
         |                                   ^
   drivers/nvme/host/ioctl.c:435:2: note: did you mean 'DEFINE_IO_URING_CMD_TASK_WORK'?
   include/linux/io_uring/cmd.h:149:7: note: expanded from macro 'io_uring_cmd_do_in_task_lazy'
     149 |                                   IO_URING_CMD_TASK_WORK(uring_cmd_cb),         \
         |                                   ^
   drivers/nvme/host/ioctl.c:410:8: note: 'DEFINE_IO_URING_CMD_TASK_WORK' declared here
     410 | static DEFINE_IO_URING_CMD_TASK_WORK(nvme_uring_task_cb)
         |        ^
>> drivers/nvme/host/ioctl.c:435:2: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'io_req_tw_func_t' (aka 'void (*)(struct io_kiocb *, struct io_tw_state)') [-Wint-conversion]
     435 |         io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/io_uring/cmd.h:149:7: note: expanded from macro 'io_uring_cmd_do_in_task_lazy'
     149 |                                   IO_URING_CMD_TASK_WORK(uring_cmd_cb),         \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/io_uring/cmd.h:123:25: note: passing argument to parameter 'task_work_cb' here
     123 |                             io_req_tw_func_t task_work_cb, unsigned flags)
         |                                              ^
>> drivers/nvme/host/ioctl.c:410:8: error: a function definition without a prototype is deprecated in all versions of C and is not supported in C23 [-Werror,-Wdeprecated-non-prototype]
     410 | static DEFINE_IO_URING_CMD_TASK_WORK(nvme_uring_task_cb)
         |        ^
>> drivers/nvme/host/ioctl.c:524:16: error: use of undeclared identifier 'nvme_uring_cmd_end_io'; did you mean 'nvme_uring_cmd_io'?
     524 |         req->end_io = nvme_uring_cmd_end_io;
         |                       ^~~~~~~~~~~~~~~~~~~~~
         |                       nvme_uring_cmd_io
   drivers/nvme/host/ioctl.c:439:12: note: 'nvme_uring_cmd_io' declared here
     439 | static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
         |            ^
   14 errors generated.


vim +783 block/ioctl.c

50c52250e2d74b Pavel Begunkov      2024-09-11  771  
50c52250e2d74b Pavel Begunkov      2024-09-11  772  static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
50c52250e2d74b Pavel Begunkov      2024-09-11  773  {
50c52250e2d74b Pavel Begunkov      2024-09-11  774  	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
50c52250e2d74b Pavel Begunkov      2024-09-11  775  
50c52250e2d74b Pavel Begunkov      2024-09-11  776  	if (bic->res == -EAGAIN && bic->nowait)
50c52250e2d74b Pavel Begunkov      2024-09-11  777  		io_uring_cmd_issue_blocking(cmd);
50c52250e2d74b Pavel Begunkov      2024-09-11  778  	else
ef9f603fd3d4b7 Caleb Sander Mateos 2025-09-22  779  		io_uring_cmd_done(cmd, bic->res, issue_flags);
50c52250e2d74b Pavel Begunkov      2024-09-11  780  }
c004e50b1d8661 Caleb Sander Mateos 2025-10-22 @781  static DEFINE_IO_URING_CMD_TASK_WORK(blk_cmd_complete)
50c52250e2d74b Pavel Begunkov      2024-09-11  782  
50c52250e2d74b Pavel Begunkov      2024-09-11 @783  static void bio_cmd_bio_end_io(struct bio *bio)
50c52250e2d74b Pavel Begunkov      2024-09-11  784  {
50c52250e2d74b Pavel Begunkov      2024-09-11 @785  	struct io_uring_cmd *cmd = bio->bi_private;
50c52250e2d74b Pavel Begunkov      2024-09-11  786  	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
50c52250e2d74b Pavel Begunkov      2024-09-11  787  
50c52250e2d74b Pavel Begunkov      2024-09-11  788  	if (unlikely(bio->bi_status) && !bic->res)
50c52250e2d74b Pavel Begunkov      2024-09-11  789  		bic->res = blk_status_to_errno(bio->bi_status);
50c52250e2d74b Pavel Begunkov      2024-09-11  790  
50c52250e2d74b Pavel Begunkov      2024-09-11 @791  	io_uring_cmd_do_in_task_lazy(cmd, blk_cmd_complete);
50c52250e2d74b Pavel Begunkov      2024-09-11  792  	bio_put(bio);
50c52250e2d74b Pavel Begunkov      2024-09-11  793  }
50c52250e2d74b Pavel Begunkov      2024-09-11  794  
50c52250e2d74b Pavel Begunkov      2024-09-11  795  static int blkdev_cmd_discard(struct io_uring_cmd *cmd,
50c52250e2d74b Pavel Begunkov      2024-09-11  796  			      struct block_device *bdev,
50c52250e2d74b Pavel Begunkov      2024-09-11  797  			      uint64_t start, uint64_t len, bool nowait)
50c52250e2d74b Pavel Begunkov      2024-09-11  798  {
50c52250e2d74b Pavel Begunkov      2024-09-11  799  	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
50c52250e2d74b Pavel Begunkov      2024-09-11  800  	gfp_t gfp = nowait ? GFP_NOWAIT : GFP_KERNEL;
50c52250e2d74b Pavel Begunkov      2024-09-11  801  	sector_t sector = start >> SECTOR_SHIFT;
50c52250e2d74b Pavel Begunkov      2024-09-11  802  	sector_t nr_sects = len >> SECTOR_SHIFT;
50c52250e2d74b Pavel Begunkov      2024-09-11  803  	struct bio *prev = NULL, *bio;
50c52250e2d74b Pavel Begunkov      2024-09-11  804  	int err;
50c52250e2d74b Pavel Begunkov      2024-09-11  805  
50c52250e2d74b Pavel Begunkov      2024-09-11  806  	if (!bdev_max_discard_sectors(bdev))
50c52250e2d74b Pavel Begunkov      2024-09-11  807  		return -EOPNOTSUPP;
50c52250e2d74b Pavel Begunkov      2024-09-11  808  	if (!(file_to_blk_mode(cmd->file) & BLK_OPEN_WRITE))
50c52250e2d74b Pavel Begunkov      2024-09-11  809  		return -EBADF;
50c52250e2d74b Pavel Begunkov      2024-09-11  810  	if (bdev_read_only(bdev))
50c52250e2d74b Pavel Begunkov      2024-09-11  811  		return -EPERM;
50c52250e2d74b Pavel Begunkov      2024-09-11  812  	err = blk_validate_byte_range(bdev, start, len);
50c52250e2d74b Pavel Begunkov      2024-09-11  813  	if (err)
50c52250e2d74b Pavel Begunkov      2024-09-11  814  		return err;
50c52250e2d74b Pavel Begunkov      2024-09-11  815  
50c52250e2d74b Pavel Begunkov      2024-09-11  816  	err = filemap_invalidate_pages(bdev->bd_mapping, start,
50c52250e2d74b Pavel Begunkov      2024-09-11  817  					start + len - 1, nowait);
50c52250e2d74b Pavel Begunkov      2024-09-11  818  	if (err)
50c52250e2d74b Pavel Begunkov      2024-09-11  819  		return err;
50c52250e2d74b Pavel Begunkov      2024-09-11  820  
50c52250e2d74b Pavel Begunkov      2024-09-11  821  	while (true) {
50c52250e2d74b Pavel Begunkov      2024-09-11  822  		bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects, gfp);
50c52250e2d74b Pavel Begunkov      2024-09-11  823  		if (!bio)
50c52250e2d74b Pavel Begunkov      2024-09-11  824  			break;
50c52250e2d74b Pavel Begunkov      2024-09-11  825  		if (nowait) {
50c52250e2d74b Pavel Begunkov      2024-09-11  826  			/*
50c52250e2d74b Pavel Begunkov      2024-09-11  827  			 * Don't allow multi-bio non-blocking submissions as
50c52250e2d74b Pavel Begunkov      2024-09-11  828  			 * subsequent bios may fail but we won't get a direct
50c52250e2d74b Pavel Begunkov      2024-09-11  829  			 * indication of that. Normally, the caller should
50c52250e2d74b Pavel Begunkov      2024-09-11  830  			 * retry from a blocking context.
50c52250e2d74b Pavel Begunkov      2024-09-11  831  			 */
50c52250e2d74b Pavel Begunkov      2024-09-11  832  			if (unlikely(nr_sects)) {
50c52250e2d74b Pavel Begunkov      2024-09-11  833  				bio_put(bio);
50c52250e2d74b Pavel Begunkov      2024-09-11  834  				return -EAGAIN;
50c52250e2d74b Pavel Begunkov      2024-09-11  835  			}
50c52250e2d74b Pavel Begunkov      2024-09-11  836  			bio->bi_opf |= REQ_NOWAIT;
50c52250e2d74b Pavel Begunkov      2024-09-11  837  		}
50c52250e2d74b Pavel Begunkov      2024-09-11  838  
50c52250e2d74b Pavel Begunkov      2024-09-11  839  		prev = bio_chain_and_submit(prev, bio);
50c52250e2d74b Pavel Begunkov      2024-09-11  840  	}
50c52250e2d74b Pavel Begunkov      2024-09-11  841  	if (unlikely(!prev))
50c52250e2d74b Pavel Begunkov      2024-09-11  842  		return -EAGAIN;
50c52250e2d74b Pavel Begunkov      2024-09-11  843  	if (unlikely(nr_sects))
50c52250e2d74b Pavel Begunkov      2024-09-11  844  		bic->res = -EAGAIN;
50c52250e2d74b Pavel Begunkov      2024-09-11  845  
50c52250e2d74b Pavel Begunkov      2024-09-11  846  	prev->bi_private = cmd;
50c52250e2d74b Pavel Begunkov      2024-09-11 @847  	prev->bi_end_io = bio_cmd_bio_end_io;
50c52250e2d74b Pavel Begunkov      2024-09-11  848  	submit_bio(prev);
50c52250e2d74b Pavel Begunkov      2024-09-11  849  	return -EIOCBQUEUED;
50c52250e2d74b Pavel Begunkov      2024-09-11  850  }
50c52250e2d74b Pavel Begunkov      2024-09-11  851  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

