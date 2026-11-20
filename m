Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84D606A6E1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CXetzBfc;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FIbDB3i+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rfT7b44eGFQl63K3Nrm5FgFOoT0OPnciJuyqBNbWLLw=; b=CXetzBfc77XDYxRZ1Q8cmcRnOt
	yMDWPWnmGY0KebOgwnzrFNAP5h1Wv7WjFLuIE5mYjgQh4In6JzK1InEbZiTH9X/oBDi4mK6EJQ6nv
	sSJYFcb6+HBOuntuU/U7hg87ddHvexBVC1BB8wfM2e7igK6c4ftJiSUx/PconIa1EGVBEFHUlu5S7
	xrej/y4q4f9f3VDipNsKnApi5ywCEI4Ls28sam3kQmee9vPDemA5IGvFqLIIi5QeuME12GMpR+Mc6
	L0m/k9eED6UuwgkUBNXsMCpO4BjQOGxk9snYRcWylM45lJAh8/rNTzIOV7IVU9coYmp2bf4638fxb
	Y3/lOCQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUF3-0000000G5Pl-276K;
	Fri, 20 Nov 2026 19:25:49 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUEw-0000000G5MV-0m8F
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:25:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795202743; x=1826738743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NEkkbgMF1325z917jEFqYfGZWDZCnvP2bGGuwDpk3UE=;
  b=FIbDB3i+icpF+IJmK5FXPcLQYuNZwESV/aqtElkXS5RO+DBuLHMPNKY8
   gqttCDOrVXVOLWKhB2eMDhYmRz88kIrGxXkJD1fxztPXSyoobmq/AE+Wq
   k8fLkzD8j5N3cozif8ZAZ59wgoEBV9FJ2qTgccfrcerI3a6iaDwDJllx1
   16rU4lhxGpL01whEPcupoJncQqWylA67BNQqa7SG1uZUw98pRB9KOcVtI
   UOsr+8AdaIzCnecXlYdx9oGRAecFp/f2W+ZzYtu/DXK0Y05VkYx7NRVg+
   /Y52UrMab7bAXqZ9AUihNtSkpGBeZ3Mj/PUTbrNBKRS1b1hirQ7yqajY8
   g==;
X-CSE-ConnectionGUID: C2FNcdGSTvWxOBn6klD6dg==
X-CSE-MsgGUID: cUEoEFSjQniKtbNAN0H8AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3988476"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3988476"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 11:25:42 -0800
X-CSE-ConnectionGUID: kpLVHNV6RAWMYeic5lm32Q==
X-CSE-MsgGUID: DeS9GAfrT4SdueBAksKt6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10672305"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Nov 2026 11:25:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUUEq-00000001INT-11Le;
	Fri, 20 Nov 2026 19:25:36 +0000
Date: Sat, 21 Nov 2026 03:24:57 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] nvme-auth: switch to use 'struct key'
Message-ID: <202611210318.EedT1DJk-lkp@intel.com>
References: <20261120-dhchap-keyring-v4-v4-3-5f8c7d9926ee@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-dhchap-keyring-v4-v4-3-5f8c7d9926ee@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_112542_904962_EB28A37C 
X-CRM114-Status: GOOD (  12.95  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on 68099cf27253a8c89d703a282d3d811446d9453b]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/nvme-auth-modify-nvme_auth_transform_key-to-return-status/20261120-121400
base:   68099cf27253a8c89d703a282d3d811446d9453b
patch link:    https://lore.kernel.org/r/20261120-dhchap-keyring-v4-v4-3-5f8c7d9926ee%40kernel.org
patch subject: [PATCH v4 3/9] nvme-auth: switch to use 'struct key'
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20261121/202611210318.EedT1DJk-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 3b14d7c370558b46e5f0c6494a05c492e59bf32c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611210318.EedT1DJk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611210318.EedT1DJk-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/fabrics.c:15:
>> include/linux/nvme-keyring.h:54:1: error: expected identifier or '('
      54 | {
         | ^
>> include/linux/nvme-keyring.h:57:4: warning: no previous prototype for function 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]
      57 | u8 nvme_dhchap_psk_hash(struct key *key)
         |    ^
   include/linux/nvme-keyring.h:57:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      57 | u8 nvme_dhchap_psk_hash(struct key *key)
         | ^
         | static 
   1 warning and 1 error generated.


vim +54 include/linux/nvme-keyring.h

    26	
    27	#else
    28	static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
    29			u8 *data, size_t data_len, const char *digest)
    30	{
    31		return ERR_PTR(-EOPNOTSUPP);
    32	}
    33	static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
    34			const char *hostnqn, const char *subnqn)
    35	{
    36		return 0;
    37	}
    38	static inline key_serial_t nvme_keyring_id(void)
    39	{
    40		return 0;
    41	}
    42	static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
    43	{
    44		return ERR_PTR(-EOPNOTSUPP);
    45	}
    46	static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
    47			const char *hostnqn, const char *subnqn,
    48			u8 *data, size_t data_len)
    49	{
    50		return ERR_PTR(-EOPNOTSUPP);
    51	}
    52	static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
    53			const char *hostnqn, const char *subnqn, u8 hmac);
  > 54	{
    55		return ERR_PTR(-EOPNOTSUPP);
    56	}
  > 57	u8 nvme_dhchap_psk_hash(struct key *key)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

