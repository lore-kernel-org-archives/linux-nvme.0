Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8236CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cLX3krKZMaAWT8ujO9N3dqm8YUZ243DWN6ZZeJAz8M=; b=U0w2w0n5Elkuks9Gu64wrxmADq
	zmyfhj311Off8/rCSoeRhUKGER47UjWP4Pvq7eP/S4eveHFnIPw9DRW/VBRSDa7xbXP5jN2Ux18sd
	scwUTjzFaTR9knZ4MKD6j2YgH2s44oV2fNqvlzXSnBSNH+S2NycFeVqhnhfM/GOkWM9I3nqzq1pii
	3lxQrF9uHcABAeEzbtyoCfX+j8/JktuCH2rJxvuc9PpUJdQOkxiaAgp3RgZSPYoNUTPSHviObK9js
	+B33yxgKZszwCeaL/QDFcETosldzSuWD1CI13ZhkGihCj8HUJTXj9DwAKtZwHwvf82yIC2z0iH32U
	DXMvt+PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk5iI-007aO5-Et; Thu, 28 Apr 2022 15:05:50 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk4jL-007IWo-6J
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 14:02:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651154571; x=1682690571;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=h4skWhp2zeIZpA2ClyYBwaM9S88S0lAXDPHsSUH0YyA=;
 b=Rp4bSB/eX54CyNzwNDs8HctGfVsyU52e6UhcJVgK22eAKMWKmnKyNLwV
 xVQmX4miDkWvXRsWgwAxyQgUmsQWXxwXoFHJdOVTSistRqH+RPl7ruiEF
 afOG2quyKR9C/mnCEgPpK7pR/eeLGoWF7GP8BfaOKD8WhA7vbMmxgj7m5
 NIgyQZl0WEgm+jmwN9N+HhvosFKE9nbWMEd6HSgmF8yu+XKxkSAvuuC38
 zrkOQxnjxdYucLQoPiyNSJfCbhmLvliaOeDZm4RNQfcg7T34/mdueNzYB
 dVnKEe7LGSwAfRTWd7KhN/B8Ux3wcUi3254HRa5TWVKcfJkOgmPcqCuIy g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="253680563"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="253680563"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 07:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="541312589"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 28 Apr 2022 07:02:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nk4jA-0005Qa-9F;
 Thu, 28 Apr 2022 14:02:40 +0000
Date: Thu, 28 Apr 2022 22:02:28 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: kbuild-all@lists.01.org, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com,
 bvanassche@acm.org, martin.petersen@oracle.com, hare@suse.de,
 kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
 osandov@fb.com, lsf-pc@lists.linux-foundation.org,
 djwong@kernel.org, josef@toxicpanda.com, clm@fb.com,
 dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Arnav Dawn <arnav.dawn@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 05/10] nvme: add copy offload support
Message-ID: <202204282136.kqIaq8aK-lkp@intel.com>
References: <20220426101241.30100-6-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-6-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_070251_365213_D66D7109 
X-CRM114-Status: GOOD (  15.06  )
X-Mailman-Approved-At: Thu, 28 Apr 2022 08:05:49 -0700
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

Hi Nitesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220422]
[cannot apply to axboe-block/for-next device-mapper-dm/for-next linus/master v5.18-rc4 v5.18-rc3 v5.18-rc2 v5.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
base:    e7d6987e09a328d4a949701db40ef63fbb970670
config: s390-randconfig-s032-20220427 (https://download.01.org/0day-ci/archive/20220428/202204282136.kqIaq8aK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e029014185aff1d7c8facf6e19447487c6ce2b93
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout e029014185aff1d7c8facf6e19447487c6ce2b93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/ drivers/nvme/host/ drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/core.c:803:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] dspec @@     got restricted __le32 [usertype] @@
   drivers/nvme/host/core.c:803:26: sparse:     expected restricted __le16 [usertype] dspec
   drivers/nvme/host/core.c:803:26: sparse:     got restricted __le32 [usertype]

vim +803 drivers/nvme/host/core.c

   739	
   740	static inline blk_status_t nvme_setup_copy_write(struct nvme_ns *ns,
   741		       struct request *req, struct nvme_command *cmnd)
   742	{
   743		struct nvme_ctrl *ctrl = ns->ctrl;
   744		struct nvme_copy_range *range = NULL;
   745		struct bio *bio = req->bio;
   746		struct nvme_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
   747		sector_t src_sector, dst_sector, n_sectors;
   748		u64 src_lba, dst_lba, n_lba;
   749		unsigned short nr_range = 1;
   750		u16 control = 0;
   751		u32 dsmgmt = 0;
   752	
   753		if (unlikely(memcmp(token->subsys, "nvme", 4)))
   754			return BLK_STS_NOTSUPP;
   755		if (unlikely(token->ns != ns))
   756			return BLK_STS_NOTSUPP;
   757	
   758		src_sector = token->src_sector;
   759		dst_sector = bio->bi_iter.bi_sector;
   760		n_sectors = token->sectors;
   761		if (WARN_ON(n_sectors != bio->bi_iter.bi_size >> 9))
   762			return BLK_STS_NOTSUPP;
   763	
   764		src_lba = nvme_sect_to_lba(ns, src_sector);
   765		dst_lba = nvme_sect_to_lba(ns, dst_sector);
   766		n_lba = nvme_sect_to_lba(ns, n_sectors);
   767	
   768		if (unlikely(nvme_lba_to_sect(ns, src_lba) != src_sector) ||
   769				unlikely(nvme_lba_to_sect(ns, dst_lba) != dst_sector) ||
   770				unlikely(nvme_lba_to_sect(ns, n_lba) != n_sectors))
   771			return BLK_STS_NOTSUPP;
   772	
   773		if (WARN_ON(!n_lba))
   774			return BLK_STS_NOTSUPP;
   775	
   776		if (req->cmd_flags & REQ_FUA)
   777			control |= NVME_RW_FUA;
   778	
   779		if (req->cmd_flags & REQ_FAILFAST_DEV)
   780			control |= NVME_RW_LR;
   781	
   782		memset(cmnd, 0, sizeof(*cmnd));
   783		cmnd->copy.opcode = nvme_cmd_copy;
   784		cmnd->copy.nsid = cpu_to_le32(ns->head->ns_id);
   785		cmnd->copy.sdlba = cpu_to_le64(dst_lba);
   786	
   787		range = kmalloc_array(nr_range, sizeof(*range),
   788				GFP_ATOMIC | __GFP_NOWARN);
   789		if (!range)
   790			return BLK_STS_RESOURCE;
   791	
   792		range[0].slba = cpu_to_le64(src_lba);
   793		range[0].nlb = cpu_to_le16(n_lba - 1);
   794	
   795		cmnd->copy.nr_range = 0;
   796	
   797		req->special_vec.bv_page = virt_to_page(range);
   798		req->special_vec.bv_offset = offset_in_page(range);
   799		req->special_vec.bv_len = sizeof(*range) * nr_range;
   800		req->rq_flags |= RQF_SPECIAL_PAYLOAD;
   801	
   802		cmnd->copy.control = cpu_to_le16(control);
 > 803		cmnd->copy.dspec = cpu_to_le32(dsmgmt);
   804	
   805		return BLK_STS_OK;
   806	}
   807	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

