Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95118606A326
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ei/68hPM;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHjmqacD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=U06Pm+QNLCfQEC/0EPTt5m6/AIUiEW5bix7eerP4ShM=; b=ei/68hPMv91zmnT7azCW54LF7t
	EzyVPcX2n8OYdJA195j1Nzj05rYhN9wKlADfdapG0/54nrOHC798wGSQruoGYgYXrS5ucCURjgTEO
	Iy3Yl6BQoLJYmGo4KV7PQViEI/NRFzeA7yewXYZIbCLoKYqkqrwGnMf6RhVcjNH+1Kf1riWE8S8FK
	KVNTF3GMB0q2zRZYAjUg4EVA32Dvk3N43XQWM3X6XMmHGehqRGmGwsf+jYBFdUcOyBaJ8Elh5LAjc
	IlWVDHNPrp0S92TzHrUpR3KD6A7hM4/FZ0OoxPqtV6lztaWdbJDEIIMQ77Tnx6k6KnRGmyFk9qBn/
	U4GiN4Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWg0H-0000000ERxF-3tk3;
	Thu, 26 Nov 2026 20:23:37 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWg0E-0000000ERwf-3QpP
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 20:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795724615; x=1827260615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/dNvAQSpVvJI3DOV3ndv6IHH3ZCcFMm5U2yS/NNIk8o=;
  b=eHjmqacDQ5/M9dFPo5AJ5+UaOACVWYDOfqbwgrATK/XQSbB3p2rIP1ON
   w3aEqtmMaiYF2EL8Qnb2NKnFC+vWRzyLm7915zu0VeWmcqXdZicvfRQO0
   5QyWFHTLnplVm6OTB8bePdy2+UAv20NCcAgilGkGB9i7WI0SkLZ/ZqqeS
   fPgNh8Vyc6cnizFiTDp39d++vDPMzNIybKrGqxcBcTsuNOhEWL2HkKl+d
   cLvjGR6dS8Ig40xADJRtuRhWRhNlzPHkOBCmXoFI8GrlTtos+zc/HA3g1
   Y3BmuGFUB19DUtg49dB4E06/SiecI68UlAAx1xg+Hit1wnQ7l5BYSctJF
   A==;
X-CSE-ConnectionGUID: qq/o3CCOQF6VH9pTVPeR0Q==
X-CSE-MsgGUID: okLDxkETSoOWbOy4rbLsEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4534789"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4534789"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 12:23:33 -0800
X-CSE-ConnectionGUID: OvdX03tQSPe00cOodiFvLQ==
X-CSE-MsgGUID: pljUvq+7S6KkPcSYVDwl7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12129448"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Nov 2026 12:23:29 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWg05-00000001UmI-43U4;
	Thu, 26 Nov 2026 20:23:25 +0000
Date: Fri, 27 Nov 2026 04:22:34 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 05/14] nvme-keyring: link addtional keyring into .nvme
 keyring
Message-ID: <20261127041445.UXBLiTUG-lkp@intel.com>
References: <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_122334_996373_8CACF2C8 
X-CRM114-Status: GOOD (  13.65  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 68099cf27253a8c89d703a282d3d811446d9453b]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/nvme-auth-modify-nvme_auth_transform_key-to-return-status/20261126-151219
base:   68099cf27253a8c89d703a282d3d811446d9453b
patch link:    https://lore.kernel.org/r/20261126-dhchap-keyring-v4-v7-5-ee438ffea527%40kernel.org
patch subject: [PATCH v7 05/14] nvme-keyring: link addtional keyring into .nvme keyring
config: i386-randconfig-1003-20261126 (https://download.01.org/0day-ci/archive/20261127/20261127041445.UXBLiTUG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127041445.UXBLiTUG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127041445.UXBLiTUG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/sysfs.c:9:
>> include/linux/nvme-keyring.h:47:5: warning: no previous prototype for 'nvme_keyring_unlink' [-Wmissing-prototypes]
      47 | int nvme_keyring_unlink(struct key *keyring)
         |     ^~~~~~~~~~~~~~~~~~~
>> include/linux/nvme-keyring.h:43:12: warning: 'nvme_keyring_link' defined but not used [-Wunused-function]
      43 | static int nvme_keyring_link(struct key *keyring)
         |            ^~~~~~~~~~~~~~~~~
>> include/linux/nvme-keyring.h:39:20: warning: 'nvme_keyring_name' defined but not used [-Wunused-function]
      39 | static const char *nvme_keyring_name(void)
         |                    ^~~~~~~~~~~~~~~~~


vim +/nvme_keyring_unlink +47 include/linux/nvme-keyring.h

    22	
    23	#else
    24	static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
    25			const char *hostnqn, const char *subnqn, u8 hmac_id,
    26			u8 *data, size_t data_len, const char *digest)
    27	{
    28		return ERR_PTR(-EOPNOTSUPP);
    29	}
    30	static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
    31			const char *hostnqn, const char *subnqn)
    32	{
    33		return 0;
    34	}
    35	static inline key_serial_t nvme_keyring_id(void)
    36	{
    37		return 0;
    38	}
  > 39	static const char *nvme_keyring_name(void)
    40	{
    41		return NULL;
    42	}
  > 43	static int nvme_keyring_link(struct key *keyring)
    44	{
    45		return 0;
    46	}
  > 47	int nvme_keyring_unlink(struct key *keyring)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

