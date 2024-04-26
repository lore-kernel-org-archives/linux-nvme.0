Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF419C4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Apr 2024 10:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1L5WvF4VPpCM1xNz/IP7F3ajqORhxsU78kSA541GKWI=; b=O5N/sMPtaExoKCJxjjTPZAF0C0
	H4HpNlxRUFAipYDjaBdbpX4qmDVGK2+SfO31lK0OJ55SkWEh4bdnmZU11rBuYS6G4ii2Irod08WCO
	3OgDwIJZQ3FIkYqY8YDGSpxSy5TnkAESXmgLIl4HWVEXAlgIaYm37rFWZR/+aiUAn81Hwa5rVH5QK
	R3LxXN05JDnrea+NqmTHwR3v2jT5tfNyJR/Jwz/z44zMo3pHOMHJ8BbR8gubx43daLOTdWIaqWzeK
	vuaHBO2u12UGji+7Tmq0lzVLCIo17+cp754POdO6zzuv6WZpDYuKqnbmh2+sxAxeMOOD532wWpR9Z
	EAwbe8OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0JIA-0000000CG4G-2T4o;
	Fri, 26 Apr 2024 10:58:58 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0JI4-0000000CG2R-0VvL
	for linux-nvme@lists.infradead.org;
	Fri, 26 Apr 2024 10:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129132; x=1745665132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=huF0ExFgsepJp65/LgFBeJslQGlknYDeyxkOEhJEQXQ=;
  b=jBnxbk6Heaf2FV+M7uVD+mF1ykZ/Ifc0giQ9Nfq+3o0WXWyddsT8/Hlh
   CG8Hd8pLCpOzyyM5UXMPTbKwXGMOG/nfPDcLWkApF05+oABH065Q2RQuM
   TeoKDVmuSlG04J/eBFE59VsPlcedntEZxy+3DuFdqA+KlNISkz7NbvTtr
   SeeHa0Al6l/U4Y50o3LRjTPSi7Sg8JQJRDOApoOftu5mHCQc5q5b93RVw
   HrvkaX+vEAOYxPVYFDP3SyC4M0M8HsxHJYxO37fO4QqP/5UmFVMfwQEiH
   uXXUegZG0oZahXW+XIgS6bRTBx37PXeXvv5q7F/p4jWmZ6sp+vtYYTJdo
   Q==;
X-CSE-ConnectionGUID: 6/qPz/YbRYyvrz3/dwKFIA==
X-CSE-MsgGUID: 1ZdsRWK2ScuCxBKce3Eg8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10392662"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="10392662"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 03:58:50 -0700
X-CSE-ConnectionGUID: sXGMn23tQF2eCCFEw7Rqhw==
X-CSE-MsgGUID: zKSID86WTWqpID8gkQOvfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="62863083"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Apr 2024 03:58:46 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0JHv-0003ck-2K;
	Fri, 26 Apr 2024 10:58:43 +0000
Date: Fri, 26 Apr 2024 18:57:50 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, kbusch@kernel.org, hch@lst.de,
	brauner@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 10/10] nvme: add separate handling for user integrity
 buffer
Message-ID: <202404261859.n3J0awuF-lkp@intel.com>
References: <20240425183943.6319-11-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-11-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_035852_204262_D53E97ED 
X-CRM114-Status: GOOD (  11.84  )
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

Hi Kanchan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 24c3fc5c75c5b9d471783b4a4958748243828613]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/block-set-bip_vcnt-correctly/20240426-024916
base:   24c3fc5c75c5b9d471783b4a4958748243828613
patch link:    https://lore.kernel.org/r/20240425183943.6319-11-joshi.k%40samsung.com
patch subject: [PATCH 10/10] nvme: add separate handling for user integrity buffer
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240426/202404261859.n3J0awuF-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404261859.n3J0awuF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404261859.n3J0awuF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/core.c:1014:31: error: member reference base type 'void' is not a structure or union
    1014 |                         if (bio_integrity(req->bio)->bip_flags &
         |                             ~~~~~~~~~~~~~~~~~~~~~~~^ ~~~~~~~~~
   1 error generated.


vim +/void +1014 drivers/nvme/host/core.c

   971	
   972	static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
   973			struct request *req, struct nvme_command *cmnd,
   974			enum nvme_opcode op)
   975	{
   976		u16 control = 0;
   977		u32 dsmgmt = 0;
   978	
   979		if (req->cmd_flags & REQ_FUA)
   980			control |= NVME_RW_FUA;
   981		if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
   982			control |= NVME_RW_LR;
   983	
   984		if (req->cmd_flags & REQ_RAHEAD)
   985			dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
   986	
   987		cmnd->rw.opcode = op;
   988		cmnd->rw.flags = 0;
   989		cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
   990		cmnd->rw.cdw2 = 0;
   991		cmnd->rw.cdw3 = 0;
   992		cmnd->rw.metadata = 0;
   993		cmnd->rw.slba =
   994			cpu_to_le64(nvme_sect_to_lba(ns->head, blk_rq_pos(req)));
   995		cmnd->rw.length =
   996			cpu_to_le16((blk_rq_bytes(req) >> ns->head->lba_shift) - 1);
   997		cmnd->rw.reftag = 0;
   998		cmnd->rw.apptag = 0;
   999		cmnd->rw.appmask = 0;
  1000	
  1001		if (ns->head->ms) {
  1002			/*
  1003			 * If formated with metadata, the block layer always provides a
  1004			 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
  1005			 * we enable the PRACT bit for protection information or set the
  1006			 * namespace capacity to zero to prevent any I/O.
  1007			 */
  1008			if (!blk_integrity_rq(req)) {
  1009				if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
  1010					return BLK_STS_NOTSUPP;
  1011				control |= NVME_RW_PRINFO_PRACT;
  1012			} else {
  1013				/* process user-created integrity */
> 1014				if (bio_integrity(req->bio)->bip_flags &
  1015						BIP_INTEGRITY_USER) {
  1016					nvme_setup_user_integrity(ns, req, cmnd,
  1017								  &control);
  1018					goto out;
  1019				}
  1020			}
  1021	
  1022			switch (ns->head->pi_type) {
  1023			case NVME_NS_DPS_PI_TYPE3:
  1024				control |= NVME_RW_PRINFO_PRCHK_GUARD;
  1025				break;
  1026			case NVME_NS_DPS_PI_TYPE1:
  1027			case NVME_NS_DPS_PI_TYPE2:
  1028				control |= NVME_RW_PRINFO_PRCHK_GUARD |
  1029						NVME_RW_PRINFO_PRCHK_REF;
  1030				if (op == nvme_cmd_zone_append)
  1031					control |= NVME_RW_APPEND_PIREMAP;
  1032				nvme_set_ref_tag(ns, cmnd, req);
  1033				break;
  1034			}
  1035		}
  1036	out:
  1037		cmnd->rw.control = cpu_to_le16(control);
  1038		cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
  1039		return 0;
  1040	}
  1041	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

