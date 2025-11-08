Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F023CCF9E3
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Nov 2025 01:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ex7KmVmmHchUnDxrQcGjgsUS4id9AH2f4Oc18yis+7Y=; b=p8RUAlu/pFiiw0CDvRHMOzI369
	BRoFNezRL22lAaBpGENqTenOqSFX05+09Ymvd5C0Qb0f49SnQb3pIyOKC0grqQWioGg6Y9KDgGNX+
	m7HEAT6vZlRIMNsil91e7bN5MgSdnyk3wJk4w1RBotTtLx+jfSJDIAg5wjOpToAWWwB6KL6xfk5QW
	uInj3FyGPa72wrxG44ZOo6rnrb5LpxV+inm69L1W7X0tywfo3vVJwBp/XDx2bq3kiOTm9OVp5LnE5
	3qFhkKIPVSb8dzjTle2YXqnjUV9ciRDrUA0xVYEKRm/TtsaWZ4hl0zKxac34KpjryvWBuwG29H+wU
	IprqQTIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHXZf-00000001ubo-1uT2;
	Sat, 08 Nov 2025 01:17:03 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHXZX-00000001uay-3vRJ
	for linux-nvme@lists.infradead.org;
	Sat, 08 Nov 2025 01:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762564616; x=1794100616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2R2Y+Y7iYLIBfc+xrkSR2Yr7K6yCTnIgBnYqJBs2Pw=;
  b=DTI2R3CaRMtym0vVJSp6BGd9wM2kG5pKjr9X3XXo/IANeI7qMiWgpKaN
   QANaKpVsCmTw+NNpyXtJ/ZsliHkzA7oo/NLwznAHZxgAKxeDgNRekbqVU
   1i5jQiJSR0AKVVf01SbTJNUXyjYgfpKitJkjPkKSrjpMkH0W/5Aglkv6w
   82JcsdS4+Guj8ewhXuWenm2HdbbgvAYE1NNuiqAWBB7QoZtDjzny/HgZF
   JpFXTLwdiHE/VQnCebH0GlWBjamB6piApOecXXDyN0Jzrf3UT4r2gWvvQ
   k+qB6TKPvMwJBDH9ovKOxqgbigxV+2IVDjlknawhugYD6FHlnwgz0NYcv
   g==;
X-CSE-ConnectionGUID: GLi+Q1EPT9+q1oH+TF/wIQ==
X-CSE-MsgGUID: bcb4pBHdS1WlymOLaHK5bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="52281203"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="52281203"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 17:16:54 -0800
X-CSE-ConnectionGUID: JxjCYdpvSpqW/a7GIPacDA==
X-CSE-MsgGUID: 8XFmiRmJTaC5TUgp0Bwudg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="193209633"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2025 17:16:50 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHXZQ-0000ZL-1W;
	Sat, 08 Nov 2025 01:16:48 +0000
Date: Sat, 8 Nov 2025 09:15:48 +0800
From: kernel test robot <lkp@intel.com>
To: Fengnan Chang <changfengnan@bytedance.com>, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	asml.silence@gmail.com, willy@infradead.org, djwong@kernel.org,
	hch@infradead.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 1/2] block: use bio_alloc_bioset for passthru IO by
 default
Message-ID: <202511080837.qd2MmgFS-lkp@intel.com>
References: <20251107020557.10097-2-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107020557.10097-2-changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251107_171655_990954_01176B5C 
X-CRM114-Status: GOOD (  12.05  )
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

Hi Fengnan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4a0c9b3391999818e2c5b93719699b255be1f682]

url:    https://github.com/intel-lab-lkp/linux/commits/Fengnan-Chang/block-use-bio_alloc_bioset-for-passthru-IO-by-default/20251107-100851
base:   4a0c9b3391999818e2c5b93719699b255be1f682
patch link:    https://lore.kernel.org/r/20251107020557.10097-2-changfengnan%40bytedance.com
patch subject: [PATCH v2 1/2] block: use bio_alloc_bioset for passthru IO by default
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251108/202511080837.qd2MmgFS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251108/202511080837.qd2MmgFS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511080837.qd2MmgFS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/ioctl.c:500:3: warning: variable 'rq_flags' is uninitialized when used here [-Wuninitialized]
     500 |                 rq_flags |= REQ_NOWAIT;
         |                 ^~~~~~~~
   drivers/nvme/host/ioctl.c:449:20: note: initialize the variable 'rq_flags' to silence this warning
     449 |         blk_opf_t rq_flags;
         |                           ^
         |                            = 0
   1 warning generated.


vim +/rq_flags +500 drivers/nvme/host/ioctl.c

c0a7ba77e81b84 Jens Axboe          2022-09-21  437  
456cba386e94f2 Kanchan Joshi       2022-05-11  438  static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
f569add47119fa Anuj Gupta          2022-05-11  439  		struct io_uring_cmd *ioucmd, unsigned int issue_flags, bool vec)
456cba386e94f2 Kanchan Joshi       2022-05-11  440  {
456cba386e94f2 Kanchan Joshi       2022-05-11  441  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
fd9b8547bc5c34 Breno Leitao        2023-05-04  442  	const struct nvme_uring_cmd *cmd = io_uring_sqe_cmd(ioucmd->sqe);
456cba386e94f2 Kanchan Joshi       2022-05-11  443  	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
456cba386e94f2 Kanchan Joshi       2022-05-11  444  	struct nvme_uring_data d;
456cba386e94f2 Kanchan Joshi       2022-05-11  445  	struct nvme_command c;
38808af53c6e72 Caleb Sander Mateos 2025-03-28  446  	struct iov_iter iter;
38808af53c6e72 Caleb Sander Mateos 2025-03-28  447  	struct iov_iter *map_iter = NULL;
456cba386e94f2 Kanchan Joshi       2022-05-11  448  	struct request *req;
070157fe67aee9 Fengnan Chang       2025-11-07  449  	blk_opf_t rq_flags;
456cba386e94f2 Kanchan Joshi       2022-05-11  450  	blk_mq_req_flags_t blk_flags = 0;
470e900c8036ff Kanchan Joshi       2022-09-30  451  	int ret;
456cba386e94f2 Kanchan Joshi       2022-05-11  452  
456cba386e94f2 Kanchan Joshi       2022-05-11  453  	c.common.opcode = READ_ONCE(cmd->opcode);
456cba386e94f2 Kanchan Joshi       2022-05-11  454  	c.common.flags = READ_ONCE(cmd->flags);
456cba386e94f2 Kanchan Joshi       2022-05-11  455  	if (c.common.flags)
456cba386e94f2 Kanchan Joshi       2022-05-11  456  		return -EINVAL;
456cba386e94f2 Kanchan Joshi       2022-05-11  457  
456cba386e94f2 Kanchan Joshi       2022-05-11  458  	c.common.command_id = 0;
456cba386e94f2 Kanchan Joshi       2022-05-11  459  	c.common.nsid = cpu_to_le32(cmd->nsid);
456cba386e94f2 Kanchan Joshi       2022-05-11  460  	if (!nvme_validate_passthru_nsid(ctrl, ns, le32_to_cpu(c.common.nsid)))
456cba386e94f2 Kanchan Joshi       2022-05-11  461  		return -EINVAL;
456cba386e94f2 Kanchan Joshi       2022-05-11  462  
456cba386e94f2 Kanchan Joshi       2022-05-11  463  	c.common.cdw2[0] = cpu_to_le32(READ_ONCE(cmd->cdw2));
456cba386e94f2 Kanchan Joshi       2022-05-11  464  	c.common.cdw2[1] = cpu_to_le32(READ_ONCE(cmd->cdw3));
456cba386e94f2 Kanchan Joshi       2022-05-11  465  	c.common.metadata = 0;
456cba386e94f2 Kanchan Joshi       2022-05-11  466  	c.common.dptr.prp1 = c.common.dptr.prp2 = 0;
456cba386e94f2 Kanchan Joshi       2022-05-11  467  	c.common.cdw10 = cpu_to_le32(READ_ONCE(cmd->cdw10));
456cba386e94f2 Kanchan Joshi       2022-05-11  468  	c.common.cdw11 = cpu_to_le32(READ_ONCE(cmd->cdw11));
456cba386e94f2 Kanchan Joshi       2022-05-11  469  	c.common.cdw12 = cpu_to_le32(READ_ONCE(cmd->cdw12));
456cba386e94f2 Kanchan Joshi       2022-05-11  470  	c.common.cdw13 = cpu_to_le32(READ_ONCE(cmd->cdw13));
456cba386e94f2 Kanchan Joshi       2022-05-11  471  	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
456cba386e94f2 Kanchan Joshi       2022-05-11  472  	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
456cba386e94f2 Kanchan Joshi       2022-05-11  473  
7d9d7d59d44b7e Christoph Hellwig   2023-06-08  474  	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
855b7717f44b13 Kanchan Joshi       2022-10-31  475  		return -EACCES;
855b7717f44b13 Kanchan Joshi       2022-10-31  476  
456cba386e94f2 Kanchan Joshi       2022-05-11  477  	d.metadata = READ_ONCE(cmd->metadata);
456cba386e94f2 Kanchan Joshi       2022-05-11  478  	d.addr = READ_ONCE(cmd->addr);
456cba386e94f2 Kanchan Joshi       2022-05-11  479  	d.data_len = READ_ONCE(cmd->data_len);
456cba386e94f2 Kanchan Joshi       2022-05-11  480  	d.metadata_len = READ_ONCE(cmd->metadata_len);
456cba386e94f2 Kanchan Joshi       2022-05-11  481  	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
456cba386e94f2 Kanchan Joshi       2022-05-11  482  
38808af53c6e72 Caleb Sander Mateos 2025-03-28  483  	if (d.data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
3c12a8939e0474 Pavel Begunkov      2025-05-20  484  		int ddir = nvme_is_write(&c) ? WRITE : READ;
38808af53c6e72 Caleb Sander Mateos 2025-03-28  485  
3c12a8939e0474 Pavel Begunkov      2025-05-20  486  		if (vec)
3c12a8939e0474 Pavel Begunkov      2025-05-20  487  			ret = io_uring_cmd_import_fixed_vec(ioucmd,
3c12a8939e0474 Pavel Begunkov      2025-05-20  488  					u64_to_user_ptr(d.addr), d.data_len,
3c12a8939e0474 Pavel Begunkov      2025-05-20  489  					ddir, &iter, issue_flags);
3c12a8939e0474 Pavel Begunkov      2025-05-20  490  		else
38808af53c6e72 Caleb Sander Mateos 2025-03-28  491  			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
3c12a8939e0474 Pavel Begunkov      2025-05-20  492  					ddir, &iter, ioucmd, issue_flags);
38808af53c6e72 Caleb Sander Mateos 2025-03-28  493  		if (ret < 0)
38808af53c6e72 Caleb Sander Mateos 2025-03-28  494  			return ret;
38808af53c6e72 Caleb Sander Mateos 2025-03-28  495  
38808af53c6e72 Caleb Sander Mateos 2025-03-28  496  		map_iter = &iter;
38808af53c6e72 Caleb Sander Mateos 2025-03-28  497  	}
38808af53c6e72 Caleb Sander Mateos 2025-03-28  498  
456cba386e94f2 Kanchan Joshi       2022-05-11  499  	if (issue_flags & IO_URING_F_NONBLOCK) {
888545cb43d763 Anuj Gupta          2023-01-17 @500  		rq_flags |= REQ_NOWAIT;
456cba386e94f2 Kanchan Joshi       2022-05-11  501  		blk_flags = BLK_MQ_REQ_NOWAIT;
456cba386e94f2 Kanchan Joshi       2022-05-11  502  	}
585079b6e42538 Kanchan Joshi       2022-08-23  503  	if (issue_flags & IO_URING_F_IOPOLL)
585079b6e42538 Kanchan Joshi       2022-08-23  504  		rq_flags |= REQ_POLLED;
456cba386e94f2 Kanchan Joshi       2022-05-11  505  
470e900c8036ff Kanchan Joshi       2022-09-30  506  	req = nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
456cba386e94f2 Kanchan Joshi       2022-05-11  507  	if (IS_ERR(req))
456cba386e94f2 Kanchan Joshi       2022-05-11  508  		return PTR_ERR(req);
470e900c8036ff Kanchan Joshi       2022-09-30  509  	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
470e900c8036ff Kanchan Joshi       2022-09-30  510  
99fde895ff56ac Xinyu Zhang         2025-02-27  511  	if (d.data_len) {
38808af53c6e72 Caleb Sander Mateos 2025-03-28  512  		ret = nvme_map_user_request(req, d.addr, d.data_len,
38808af53c6e72 Caleb Sander Mateos 2025-03-28  513  			nvme_to_user_ptr(d.metadata), d.metadata_len,
c4b680ac286382 Pavel Begunkov      2025-05-20  514  			map_iter, vec ? NVME_IOCTL_VEC : 0);
470e900c8036ff Kanchan Joshi       2022-09-30  515  		if (ret)
cd683de63e1d7c Caleb Sander Mateos 2025-03-28  516  			goto out_free_req;
470e900c8036ff Kanchan Joshi       2022-09-30  517  	}
456cba386e94f2 Kanchan Joshi       2022-05-11  518  
456cba386e94f2 Kanchan Joshi       2022-05-11  519  	/* to free bio on completion, as req->bio will be null at that time */
456cba386e94f2 Kanchan Joshi       2022-05-11  520  	pdu->bio = req->bio;
d6aacee9255e7f Keith Busch         2023-11-30  521  	pdu->req = req;
c0a7ba77e81b84 Jens Axboe          2022-09-21  522  	req->end_io_data = ioucmd;
c0a7ba77e81b84 Jens Axboe          2022-09-21  523  	req->end_io = nvme_uring_cmd_end_io;
e2e530867245d0 Christoph Hellwig   2022-05-24  524  	blk_execute_rq_nowait(req, false);
456cba386e94f2 Kanchan Joshi       2022-05-11  525  	return -EIOCBQUEUED;
cd683de63e1d7c Caleb Sander Mateos 2025-03-28  526  
cd683de63e1d7c Caleb Sander Mateos 2025-03-28  527  out_free_req:
cd683de63e1d7c Caleb Sander Mateos 2025-03-28  528  	blk_mq_free_request(req);
cd683de63e1d7c Caleb Sander Mateos 2025-03-28  529  	return ret;
456cba386e94f2 Kanchan Joshi       2022-05-11  530  }
456cba386e94f2 Kanchan Joshi       2022-05-11  531  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

