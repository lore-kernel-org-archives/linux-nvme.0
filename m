Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D2606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aQ29byix;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d3Uwx51F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PApAgSiln+hh6JflyYnfRekc/2BSzRX8bTBW8ZT3ly4=; b=aQ29byix7sD0lTa0rAveTX2T4+
	eEU21raLxwUZeEWgCU+yGuYG7gJ2Un/HhG9I0lmtL1PW3QfykbzDDI07tRrFSqizeCZnV+D3M2XbI
	4he7hLWg9wRVQpcgfgI2C2zBXmPk+bIwlIba85Ws8G+rtXvOmTI+kOl83eAz/kPG6rq29tyEM5ATD
	dpPfCujyEmmzsUwcYeOJWWhMAF0dt9TeNp3ExP3VVwT81WgpDtQLuPK8kEORY9fKSdy4uKlZelEuC
	c8cv1Ww0qOsj2RdKt6pj4gQMJoxp7Hloyhn/nJYdPgt2/CdjfbP9W03hGBZ2oFBtUe/YRnRu3nW4d
	TAMwScmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWfUN-0000000ENxT-0F38;
	Thu, 26 Nov 2026 19:50:39 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWfUH-0000000ENwt-19CO
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 19:50:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795722634; x=1827258634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7XbhYgmt9VIR+gaczvT2AxUQBvDrnRwFqc75UL7ToJo=;
  b=d3Uwx51F/lELROwLy5DFwjkZ006Sd2OHUd2pOzC6FKycdaAV5iIVKqz0
   Ld/bqBO385ZcfpEHAJabJtd8xJoYXnMHsvp1AlDjgvU7lPY+i9TsJsQpH
   8zA6hd9fs0GMiE3Up0ALD5I8tqmhCIMYRhlt+QgmSdd9+GCXCJR2dctdu
   BOezEwe3xSa8EfhBhkmMAWq6YpCPZpxNdRdwG3Kso9RGmakMqoECWkzId
   6AAHpsS9YvUGRiDN2kH9WZlx9BeEPKR32SwehyTk7p1VF/edtQXgMxUyI
   cHs98yv2Jl0XSaEoRelV1c4Lz1yzjM677qnJGu9dgeQteN8QPxireVCIK
   g==;
X-CSE-ConnectionGUID: svQck0BKSmu+xxDI4i+2lQ==
X-CSE-MsgGUID: By2+R9+KTL2Q9mSx5EPkFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4607425"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4607425"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 11:50:32 -0800
X-CSE-ConnectionGUID: o83//Om2QLucrqmvDUMgkQ==
X-CSE-MsgGUID: 5IP6TDIYQaaw1vayA23NAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12657769"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Nov 2026 11:50:28 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWfU8-00000001Uj6-0ghg;
	Thu, 26 Nov 2026 19:50:24 +0000
Date: Fri, 27 Nov 2026 03:49:52 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 05/14] nvme-keyring: link addtional keyring into .nvme
 keyring
Message-ID: <20261127034638.jk3QPDaD-lkp@intel.com>
References: <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_115033_325511_5C6049F0 
X-CRM114-Status: GOOD (  14.59  )
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

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/nvme-auth-modify-nvme_auth_transform_key-to-return-status/20261126-151219
base:   68099cf27253a8c89d703a282d3d811446d9453b
patch link:    https://lore.kernel.org/r/20261126-dhchap-keyring-v4-v7-5-ee438ffea527%40kernel.org
patch subject: [PATCH v7 05/14] nvme-keyring: link addtional keyring into .nvme keyring
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20261127/20261127034638.jk3QPDaD-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project fb29ca8163c3309160711e5a14eb46bc6d4fdad2)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127034638.jk3QPDaD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127034638.jk3QPDaD-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/sysfs.c:9:
>> include/linux/nvme-keyring.h:47:5: warning: no previous prototype for function 'nvme_keyring_unlink' [-Wmissing-prototypes]
      47 | int nvme_keyring_unlink(struct key *keyring)
         |     ^
   include/linux/nvme-keyring.h:47:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      47 | int nvme_keyring_unlink(struct key *keyring)
         | ^
         | static 
   include/linux/nvme-keyring.h:39:20: warning: unused function 'nvme_keyring_name' [-Wunused-function]
      39 | static const char *nvme_keyring_name(void)
         |                    ^~~~~~~~~~~~~~~~~
   include/linux/nvme-keyring.h:43:12: warning: unused function 'nvme_keyring_link' [-Wunused-function]
      43 | static int nvme_keyring_link(struct key *keyring)
         |            ^~~~~~~~~~~~~~~~~
   3 warnings generated.
--
   In file included from drivers/nvme/host/fabrics.c:15:
>> include/linux/nvme-keyring.h:47:5: warning: no previous prototype for function 'nvme_keyring_unlink' [-Wmissing-prototypes]
      47 | int nvme_keyring_unlink(struct key *keyring)
         |     ^
   include/linux/nvme-keyring.h:47:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      47 | int nvme_keyring_unlink(struct key *keyring)
         | ^
         | static 
   include/linux/nvme-keyring.h:39:20: warning: unused function 'nvme_keyring_name' [-Wunused-function]
      39 | static const char *nvme_keyring_name(void)
         |                    ^~~~~~~~~~~~~~~~~
   2 warnings generated.
--
   In file included from drivers/nvme/host/tcp.c:15:
>> include/linux/nvme-keyring.h:47:5: warning: no previous prototype for function 'nvme_keyring_unlink' [-Wmissing-prototypes]
      47 | int nvme_keyring_unlink(struct key *keyring)
         |     ^
   include/linux/nvme-keyring.h:47:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      47 | int nvme_keyring_unlink(struct key *keyring)
         | ^
         | static 
>> drivers/nvme/host/tcp.c:2420:34: error: too few arguments to function call, expected 3, have 2
    2419 |                         pskid = nvme_tls_psk_default(ctrl->opts->host->nqn,
         |                                 ~~~~~~~~~~~~~~~~~~~~
    2420 |                                                       ctrl->opts->subsysnqn);
         |                                                                            ^
   include/linux/nvme-keyring.h:30:28: note: 'nvme_tls_psk_default' declared here
      30 | static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
         |                            ^                    ~~~~~~~~~~~~~~~~~~~~
      31 |                 const char *hostnqn, const char *subnqn)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.
--
   In file included from tcp.c:15:
>> include/linux/nvme-keyring.h:47:5: warning: no previous prototype for function 'nvme_keyring_unlink' [-Wmissing-prototypes]
      47 | int nvme_keyring_unlink(struct key *keyring)
         |     ^
   include/linux/nvme-keyring.h:47:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      47 | int nvme_keyring_unlink(struct key *keyring)
         | ^
         | static 
   tcp.c:2420:34: error: too few arguments to function call, expected 3, have 2
    2419 |                         pskid = nvme_tls_psk_default(ctrl->opts->host->nqn,
         |                                 ~~~~~~~~~~~~~~~~~~~~
    2420 |                                                       ctrl->opts->subsysnqn);
         |                                                                            ^
   include/linux/nvme-keyring.h:30:28: note: 'nvme_tls_psk_default' declared here
      30 | static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
         |                            ^                    ~~~~~~~~~~~~~~~~~~~~
      31 |                 const char *hostnqn, const char *subnqn)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +2420 drivers/nvme/host/tcp.c

3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2409  
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2410  static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2411  {
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2412  	int ret;
be8e82caa68599 Hannes Reinecke 2023-08-24  2413  	key_serial_t pskid = 0;
be8e82caa68599 Hannes Reinecke 2023-08-24  2414  
363895767fbfa0 Hannes Reinecke 2024-07-22  2415  	if (nvme_tcp_tls_configured(ctrl)) {
adf22c520b5ec4 Hannes Reinecke 2023-08-24  2416  		if (ctrl->opts->tls_key)
adf22c520b5ec4 Hannes Reinecke 2023-08-24  2417  			pskid = key_serial(ctrl->opts->tls_key);
e88a7595b57f2a Hannes Reinecke 2025-02-24  2418  		else if (ctrl->opts->tls) {
83137991c12380 Hannes Reinecke 2026-11-26  2419  			pskid = nvme_tls_psk_default(ctrl->opts->host->nqn,
be8e82caa68599 Hannes Reinecke 2023-08-24 @2420  						      ctrl->opts->subsysnqn);
be8e82caa68599 Hannes Reinecke 2023-08-24  2421  			if (!pskid) {
be8e82caa68599 Hannes Reinecke 2023-08-24  2422  				dev_err(ctrl->device, "no valid PSK found\n");
ef184b8844bf98 Guixin Liu      2023-12-31  2423  				return -ENOKEY;
be8e82caa68599 Hannes Reinecke 2023-08-24  2424  			}
be8e82caa68599 Hannes Reinecke 2023-08-24  2425  		}
363895767fbfa0 Hannes Reinecke 2024-07-22  2426  	}
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2427  
be8e82caa68599 Hannes Reinecke 2023-08-24  2428  	ret = nvme_tcp_alloc_queue(ctrl, 0, pskid);
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2429  	if (ret)
ef184b8844bf98 Guixin Liu      2023-12-31  2430  		return ret;
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2431  
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2432  	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2433  	if (ret)
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2434  		goto out_free_queue;
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2435  
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2436  	return 0;
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2437  
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2438  out_free_queue:
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2439  	nvme_tcp_free_queue(ctrl, 0);
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2440  	return ret;
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2441  }
3f2304f8c6d6ed Sagi Grimberg   2018-12-03  2442  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

