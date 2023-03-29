Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F900C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RyrDjOE1zXEibwVRlMOGvQpWgUuj8arW8E9+U9DqAnM=; b=wh5hsWbAPgCM3sckekDiRQzcL7
	2I+RdAO0uXzIYKAAF8RFD+KWzVdXyYiOdppHYGTvYsjpOL7IfyE6YgTVOo4EUhqraq5KuSeLAxS/+
	24y7+H8BOo+sSuk/5sBOwoxPbT8JwVoDHeUP65zLLwy9ew6QaLwuj/GyCBsLR+yDSrjHxhgH5yAzm
	eEQlYge60k0hI5JqWAj6Am8byYAgyqFYGzV6Znnev8PB4RbOzY5lVDP3TgmTlwYpUjDV1GOyKTK/s
	R18j344+XJnj11hUXwaNBlcEQuLl3E6MPD9x4cpQXfgOatqS5nFg2jdparGcz9VqOWYmjXVZpODFx
	mJyLqLkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phafe-001UK7-02;
	Wed, 29 Mar 2023 18:37:18 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phafb-001UIS-28
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 18:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680115035; x=1711651035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FbAW5hJcEPp+g9Ac5hrxCsaF479gOltUGf/yQKYrhw8=;
  b=V/pCsW4C4EqSj40/RJ+SNrlB2gxwJKLb5WUTv4uUUUVBkWIe2FJLrbwi
   Dzfr9i5Q4Jor/fh2eb0GUNNmDdLAA7cG3mlcocl60690KwMHi3phVPdvY
   +WzUIHIg0l4tsXrJvdU6+GFPYteadkZN6yfNT/qYwdB9Ot2/gRWbc9VwZ
   /vVXnJca+gCk8vV/Y3iJFBstJrGK0aXWiavYu0MG6a9iHeSQqH7+CLVZr
   a39zYCgJxuIw2JzqKYZB3N3ju4kgOYmIBow90Tenk3xQzl0AWaFy2kqnZ
   sCz9WFB4H5s//qbgu4KTU+IMexaKihFlSXwj1gZCAqzN0Q/VIp+XmrEZ0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427243794"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427243794"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 11:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="1014137919"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="1014137919"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2023 11:37:07 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1phafS-000Jp4-2L;
	Wed, 29 Mar 2023 18:37:06 +0000
Date: Thu, 30 Mar 2023 02:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bvanassche@acm.org, hare@suse.de,
	ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 6/9] nvmet: add copy command support for bdev and file
 ns
Message-ID: <202303300238.vmt9ne37-lkp@intel.com>
References: <20230327084103.21601-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327084103.21601-7-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_113715_723700_924B5DD3 
X-CRM114-Status: GOOD (  16.29  )
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

Hi Anuj,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.3-rc4 next-20230329]
[cannot apply to device-mapper-dm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anuj-Gupta/block-Add-copy-offload-support-infrastructure/20230329-162018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230327084103.21601-7-anuj20.g%40samsung.com
patch subject: [PATCH v8 6/9] nvmet: add copy command support for bdev and file ns
config: arm64-randconfig-s041-20230329 (https://download.01.org/0day-ci/archive/20230330/202303300238.vmt9ne37-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/f846a8ac40882d9d42532e9e2b43560650ef8510
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anuj-Gupta/block-Add-copy-offload-support-infrastructure/20230329-162018
        git checkout f846a8ac40882d9d42532e9e2b43560650ef8510
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303300238.vmt9ne37-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/admin-cmd.c:539:29: sparse: sparse: cast from restricted __le16

vim +539 drivers/nvme/target/admin-cmd.c

   490	
   491	static void nvmet_execute_identify_ns(struct nvmet_req *req)
   492	{
   493		struct nvme_id_ns *id;
   494		u16 status;
   495	
   496		if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
   497			req->error_loc = offsetof(struct nvme_identify, nsid);
   498			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
   499			goto out;
   500		}
   501	
   502		id = kzalloc(sizeof(*id), GFP_KERNEL);
   503		if (!id) {
   504			status = NVME_SC_INTERNAL;
   505			goto out;
   506		}
   507	
   508		/* return an all zeroed buffer if we can't find an active namespace */
   509		status = nvmet_req_find_ns(req);
   510		if (status) {
   511			status = 0;
   512			goto done;
   513		}
   514	
   515		if (nvmet_ns_revalidate(req->ns)) {
   516			mutex_lock(&req->ns->subsys->lock);
   517			nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
   518			mutex_unlock(&req->ns->subsys->lock);
   519		}
   520	
   521		/*
   522		 * nuse = ncap = nsze isn't always true, but we have no way to find
   523		 * that out from the underlying device.
   524		 */
   525		id->ncap = id->nsze =
   526			cpu_to_le64(req->ns->size >> req->ns->blksize_shift);
   527		switch (req->port->ana_state[req->ns->anagrpid]) {
   528		case NVME_ANA_INACCESSIBLE:
   529		case NVME_ANA_PERSISTENT_LOSS:
   530			break;
   531		default:
   532			id->nuse = id->nsze;
   533			break;
   534		}
   535	
   536		if (req->ns->bdev)
   537			nvmet_bdev_set_limits(req->ns->bdev, id);
   538		else {
 > 539			id->msrc = (u8)to0based(BIO_MAX_VECS - 1);
   540			id->mssrl = cpu_to_le16(BIO_MAX_VECS <<
   541					(PAGE_SHIFT - SECTOR_SHIFT));
   542			id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl));
   543		}
   544	
   545		/*
   546		 * We just provide a single LBA format that matches what the
   547		 * underlying device reports.
   548		 */
   549		id->nlbaf = 0;
   550		id->flbas = 0;
   551	
   552		/*
   553		 * Our namespace might always be shared.  Not just with other
   554		 * controllers, but also with any other user of the block device.
   555		 */
   556		id->nmic = NVME_NS_NMIC_SHARED;
   557		id->anagrpid = cpu_to_le32(req->ns->anagrpid);
   558	
   559		memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
   560	
   561		id->lbaf[0].ds = req->ns->blksize_shift;
   562	
   563		if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
   564			id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
   565				  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
   566				  NVME_NS_DPC_PI_TYPE3;
   567			id->mc = NVME_MC_EXTENDED_LBA;
   568			id->dps = req->ns->pi_type;
   569			id->flbas = NVME_NS_FLBAS_META_EXT;
   570			id->lbaf[0].ms = cpu_to_le16(req->ns->metadata_size);
   571		}
   572	
   573		if (req->ns->readonly)
   574			id->nsattr |= NVME_NS_ATTR_RO;
   575	done:
   576		if (!status)
   577			status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
   578	
   579		kfree(id);
   580	out:
   581		nvmet_req_complete(req, status);
   582	}
   583	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

