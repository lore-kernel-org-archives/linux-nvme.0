Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBF4D0EE12
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3dP0gbmurNfrA4ZMr5Zt+HBgJmQtMkNr3N+OwJEO4k=; b=kGUk+bUPyvh8pQU4Rp8eLYbck4
	AvMF5bvuLcbVTtuT/ASGRE29aU+e1Nw7C12H9SVLFH1Hytk2Ko/DmFole+YgIW4fiISmizE59Nxl8
	81FJKdrZ2HIyYDCVFC1+7WyjqzyD0nRk6niTxHuqjE7R0bIzTH4jRVRBcBVUKU9TdvJXzBqjbyeZZ
	o0lJzTUsUtC1VHue0YJpA/RfIn/liCL6zoqyqBmskngGdxNRBt2ZDRDt7WZ7PMlwlbkoozwldaMQo
	qvp7WZjC16KqvxrsqLvSuh0C13Kc8oaL+dqbHMGVfYk2Zbnz2vBEjSXNFrAibAgea5EsRHhLxzvUy
	OuZpwT0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szJBs-0000000H4Qj-19H6;
	Fri, 11 Oct 2024 17:12:36 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szJBo-0000000H4P7-3mOQ
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 17:12:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728666753; x=1760202753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bp3RXhYCSr41eXrHdNkF5Ty/7bBo7bu9rMhEzmkm/5A=;
  b=GyRTMtEOu9dW5IVKM+zhe0Q4cAamKyvii0/rqxHOGz/DZSjo0Qk75hJU
   Fq7N8GC4RkmJ7lQZ+JuWxUml9Q+rh2iQ1RE1Yt0+hmC0PSAedrAh4zQEY
   Hr/AVxfSVd62APx33VGCbe7sSjN13qcTBV/yGrw+Dy4W4NTeLHWeR5RcQ
   vTq20ca2FWW9KjHcp+x1lfAEXX86yaPYaCbzEr/F+LEuINMLC3D/SIjlw
   ludslkywfsAWjcAP+P3IDXQT0ueGNL8qvgouwD/s33GCOBzn860G98+Nh
   dzHkiK/RxkNDZAyoN259Wcuwh/bjuEI8hoPzWggBFuXgKk1ltcKg5oFl9
   g==;
X-CSE-ConnectionGUID: XCWNe+YHQ3eZpDU4VJDSsw==
X-CSE-MsgGUID: TS/DMSTBTuWJg9jO+QnAtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39199847"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="39199847"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:12:32 -0700
X-CSE-ConnectionGUID: PTlI3y8yRcS0Sxbx54d+1Q==
X-CSE-MsgGUID: HDc5vyy2Q/WeJAj6ESrd0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="114426529"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Oct 2024 10:12:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szJBi-000CXb-1G;
	Fri, 11 Oct 2024 17:12:26 +0000
Date: Sat, 12 Oct 2024 01:11:43 +0800
From: kernel test robot <lkp@intel.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>, kbusch@kernel.org,
	hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3 v2] nvmet: add rotational support
Message-ID: <202410120113.A3HaEkbg-lkp@intel.com>
References: <20241010123951.1226105-4-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010123951.1226105-4-m@bjorling.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_101233_013598_6C5A6367 
X-CRM114-Status: GOOD (  11.06  )
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

Hi Matias,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12-rc2]
[also build test WARNING on linus/master next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matias-Bj-rling/nvme-make-independent-ns-identify-default/20241010-204205
base:   v6.12-rc2
patch link:    https://lore.kernel.org/r/20241010123951.1226105-4-m%40bjorling.me
patch subject: [PATCH 3/3 v2] nvmet: add rotational support
config: i386-randconfig-062-20241011 (https://download.01.org/0day-ci/archive/20241012/202410120113.A3HaEkbg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241012/202410120113.A3HaEkbg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410120113.A3HaEkbg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/admin-cmd.c:704:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] anagrpid @@     got unsigned int [usertype] anagrpid @@
   drivers/nvme/target/admin-cmd.c:704:22: sparse:     expected restricted __le32 [usertype] anagrpid
   drivers/nvme/target/admin-cmd.c:704:22: sparse:     got unsigned int [usertype] anagrpid

vim +704 drivers/nvme/target/admin-cmd.c

   687	
   688	static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
   689	{
   690		struct nvme_id_ns_cs_indep *id;
   691		u16 status;
   692	
   693		status = nvmet_req_find_ns(req);
   694		if (status)
   695			goto out;
   696	
   697		id = kzalloc(sizeof(*id), GFP_KERNEL);
   698		if (!id) {
   699			status = NVME_SC_INTERNAL;
   700			goto out;
   701		}
   702	
   703		id->nstat = NVME_NSTAT_NRDY;
 > 704		id->anagrpid = req->ns->anagrpid;
   705		id->nmic = NVME_NS_NMIC_SHARED;
   706		if (req->ns->readonly)
   707			id->nsattr |= NVME_NS_ATTR_RO;
   708		if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
   709			id->nsfeat |= NVME_NS_ROTATIONAL;
   710	
   711		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
   712		kfree(id);
   713	out:
   714		nvmet_req_complete(req, status);
   715	}
   716	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

