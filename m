Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1839DC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:17:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA6F613CA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA6F613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2bUdnhPWNOtHA2N4kTxVDfSrPFj/saj3w3uGI4O6+ks=; b=Ztq+G0/Fv3JyGTTcvUPTlsxVy
	tgZHCPDOWgPCvCZHez319keLlBSJRkW2EJ2zr0t/IQB4CZ/GwukPGA9CG8hVYLGGzar3yp47rTO+H
	65n19z6akWX8uYcOledpg83nLGj2fBYdIEIQO7IP2YS9BoLmdVKbuF3iXpjECqGiIOoLfh627XDo1
	VZBhDDyaWOZ2S3TjDdcuswmKcvm9NvHuw33dZdfNLhR7vg7h1/MDeiDgbvjduGNSvdfLR8rtBflhE
	BX432m/YlfywUTWQilc6XgxjvS5+JlC9ynLBdXx5IhZSi05dXQ32nuYw87qMQ/pzD1ULNL3CP9dY7
	NxTg2SNbA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgojH-002riR-Ax; Wed, 12 May 2021 13:16:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiW-002rb2-Q9
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 13:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/Xxahg6d5e2h8lgRCUeor2iyIxxoQM8/d2XM4XtyBE8=; b=jO87N3E9uM6brBfINXx5/jjJPU
 WriKjfclXqRtOwcrRN9SalZA7f03QoRBgFXzmOqcZ0YwWgcmLmlhqj+pAZqjDLwuiQkfeEAnqFyjg
 4I1s28LHNFcSn99h+G+fMew/SKZggUc6aP/nQwyyoyC9dhCAEhGbyjSd8xIzzE595VzmK71sZD0ln
 qHxNWLVWrk7V+tKtRDUFZOR+4s2e4xAULVENrSJKgh2yVnA8GOulfNZQX8J2TMutIwvIdsS4rNiDh
 h+J1MzzVSkFdCTyAXOJw8X3uTSsGi9fKuoSpojedmv+edQEzayJfPK/tPEFTX9Ae53xSl9iDCnP/s
 IKuux/gg==;
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiQ-00AO1r-7r
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 13:15:58 +0000
IronPort-SDR: 0xYzxCQ7RiLaGeWf9RaUyaTihjFZvDdVtiS0DSWusvWjBqh4GAOV+2f4vZT0fR83LgrsC5r3cD
 +MmJq8YwcFDg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="187126463"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
 d="gz'50?scan'50,208,50";a="187126463"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 06:15:50 -0700
IronPort-SDR: Wpa1HuCu0mol7W9l2upX26GbJ/zv8wkhDwYHjrg2CGdqAZ9tnfVBlD81roqTqqDInV5S+veFNi
 AkhVZcEPFMbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
 d="gz'50?scan'50,208,50";a="542060999"
Received: from lkp-server01.sh.intel.com (HELO 1e931876798f) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 12 May 2021 06:15:47 -0700
Received: from kbuild by 1e931876798f with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lgoiJ-0000JC-2T; Wed, 12 May 2021 13:15:47 +0000
Date: Wed, 12 May 2021 21:14:46 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH] nvmet: Reset ns->file when open fails
Message-ID: <202105122110.m7UwxYz4-lkp@intel.com>
References: <20210512101352.23725-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20210512101352.23725-1-dwagner@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_061554_471775_30509B9C 
X-CRM114-Status: GOOD (  18.41  )
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


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on hch-configfs/for-next linus/master v5.13-rc1 next-20210512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Wagner/nvmet-Reset-ns-file-when-open-fails/20210512-181435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd860052c99b1e088352bdd4fb7aef46f8d2ef47
config: microblaze-randconfig-r024-20210512 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/406c65a33980a0f58f21c897d9283d9fff9a4eb5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daniel-Wagner/nvmet-Reset-ns-file-when-open-fails/20210512-181435
        git checkout 406c65a33980a0f58f21c897d9283d9fff9a4eb5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvme/target/io-cmd-file.c: In function 'nvmet_file_ns_enable':
>> drivers/nvme/target/io-cmd-file.c:54:7: warning: assignment to 'int' from 'struct file *' makes integer from pointer without a cast [-Wint-conversion]
      54 |   ret = ns->file;
         |       ^
>> drivers/nvme/target/io-cmd-file.c:56:18: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
      56 |   return PTR_ERR(ret);
         |                  ^~~
         |                  |
         |                  int
   In file included from include/linux/kernfs.h:10,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/dma-mapping.h:7,
                    from drivers/nvme/target/nvmet.h:9,
                    from drivers/nvme/target/io-cmd-file.c:11:
   include/linux/err.h:29:61: note: expected 'const void *' but argument is of type 'int'
      29 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~


vim +54 drivers/nvme/target/io-cmd-file.c

    41	
    42	int nvmet_file_ns_enable(struct nvmet_ns *ns)
    43	{
    44		int flags = O_RDWR | O_LARGEFILE;
    45		int ret;
    46	
    47		if (!ns->buffered_io)
    48			flags |= O_DIRECT;
    49	
    50		ns->file = filp_open(ns->device_path, flags, 0);
    51		if (IS_ERR(ns->file)) {
    52			pr_err("failed to open file %s: (%ld)\n",
    53					ns->device_path, PTR_ERR(ns->file));
  > 54			ret = ns->file;
    55			ns->file = NULL;
  > 56			return PTR_ERR(ret);
    57		}
    58	
    59		ret = nvmet_file_ns_revalidate(ns);
    60		if (ret)
    61			goto err;
    62	
    63		/*
    64		 * i_blkbits can be greater than the universally accepted upper bound,
    65		 * so make sure we export a sane namespace lba_shift.
    66		 */
    67		ns->blksize_shift = min_t(u8,
    68				file_inode(ns->file)->i_blkbits, 12);
    69	
    70		ns->bvec_cache = kmem_cache_create("nvmet-bvec",
    71				NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
    72				0, SLAB_HWCACHE_ALIGN, NULL);
    73		if (!ns->bvec_cache) {
    74			ret = -ENOMEM;
    75			goto err;
    76		}
    77	
    78		ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
    79				mempool_free_slab, ns->bvec_cache);
    80	
    81		if (!ns->bvec_pool) {
    82			ret = -ENOMEM;
    83			goto err;
    84		}
    85	
    86		return ret;
    87	err:
    88		ns->size = 0;
    89		ns->blksize_shift = 0;
    90		nvmet_file_ns_disable(ns);
    91		return ret;
    92	}
    93	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--VbJkn9YxBvnuCH5J--

