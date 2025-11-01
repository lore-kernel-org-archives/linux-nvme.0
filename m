Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A78CCF9F0
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Nov 2025 03:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7dt3GjdM2IsyI73aC5thAl6T7igc/rpXJNvggxzbNa0=; b=Zzs/KiHwH6BU7VzZS7P6VOup4D
	R/PgOFpFTack3teq9URE8XFjQ/ZgaPizwzQohm8oF59u0ZOwAaOCKVVNsEuA+uM+gK8suxQI/q16r
	y9YO3Or2R9mullEFqmxjrwa4U+nSNyRgbihgcZemX7FVQKPq5jlQozzV0cx0XshZXV1RGW2mzjBD7
	+QqtC1mq/T3wVUi0TkpAyAPCot35Xx+lhZo6k3RktSc0SJF5+i4ctJPqKAh6ZGswAQhoHntXj5PAI
	Bwg+NlFrfTN33ULquD6+unHQZ0k9xLSEF8gXDpmWduhqaI23aDMd/H5ekE0vQjkrINVNgFLy3tcQh
	CjWp9Pkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vF2g2-000000072YF-3JR8;
	Sat, 01 Nov 2025 03:53:18 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vF2fz-000000072Xd-24Rf
	for linux-nvme@lists.infradead.org;
	Sat, 01 Nov 2025 03:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761969196; x=1793505196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/GFc4IeKEqkqId6cYy+XZp7qHAD5i2mvQkTWC/3rfh8=;
  b=lPUPw2F/RQN8MXIA4l1x0q/BoVRaj/S9H0PNhirwDSTZHRzhFNWPL8pC
   QPSNdElh65aZygvZ0n4zWDiqYRTVfM+x88uGcx7/H1OW50R2WdHl1S7eb
   sS53I0Wf9QHRtkb8mh7Jgc8gK7Q1X6yLQDoKYUbq+kXvxVI6UmnUxJoYi
   0SN/0VMUlys0y910bi24CT8nUAp5v/9I4XZD7LpyNO8q2GdlB5b0f9K75
   dSnbhGF70llBX/8LwjhYFb+Kme9W/Sd1prlYDxIh6bIEH9lk3DOXkHWY3
   roRXqLVQosrFERsO62HilqDpP76TYk4sH5DEcSfGDIV6NoywHXZ5r1meH
   g==;
X-CSE-ConnectionGUID: U2KuYdC1TByOaLvcwMq3FQ==
X-CSE-MsgGUID: UyuSr1EzSoa1TI4jsQgyqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67968460"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67968460"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 20:53:11 -0700
X-CSE-ConnectionGUID: WIVQOmJeTwC4/u7mr/D7Gg==
X-CSE-MsgGUID: TFCdTNcWTEWvD4sgVQvtlw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 31 Oct 2025 20:53:09 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF2fr-000Nu8-0k;
	Sat, 01 Nov 2025 03:53:07 +0000
Date: Sat, 1 Nov 2025 11:52:47 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [linux-nvme:nvme-6.19 4/21] include/linux/nvme-keyring.h:57:4:
 warning: no previous prototype for 'nvme_dhchap_psk_hash'
Message-ID: <202511011105.ef5UauN7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_205315_665927_C65AD60E 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
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

tree:   git://git.infradead.org/nvme.git nvme-6.19
head:   453ba3089d4570c2be2e230e1e7a287eac4b306b
commit: 8d9937531a4d3cb6d2d352c46dd807bfa52988b6 [4/21] nvme-keyring: add 'dhchap' key type
config: i386-randconfig-061-20251101 (https://download.01.org/0day-ci/archive/20251101/202511011105.ef5UauN7-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011105.ef5UauN7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011105.ef5UauN7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/fabrics.c:15:
>> include/linux/nvme-keyring.h:57:4: warning: no previous prototype for 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]
      57 | u8 nvme_dhchap_psk_hash(struct key *key)
         |    ^~~~~~~~~~~~~~~~~~~~


vim +/nvme_dhchap_psk_hash +57 include/linux/nvme-keyring.h

    26	
    27	#else
    28	static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
    29			u8 *data, size_t data_len, const char *digest)
    30	{
    31		return ERR_PTR(-ENOTSUPP);
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
    44		return ERR_PTR(-ENOTSUPP);
    45	}
    46	static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
    47			const char *hostnqn, const char *subnqn,
    48			u8 *data, size_t data_len)
    49	{
    50		return ERR_PTR(-ENOTSUPP);
    51	}
    52	static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
    53			const char *hostnqn, const char *subnqn, u8 hmac)
    54	{
    55		return ERR_PTR(-ENOTSUPP);
    56	}
  > 57	u8 nvme_dhchap_psk_hash(struct key *key)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

