Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457BCCCD183
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kzvq9ZvrHVLJZ8tZ8ksA0ia9sYrwRFf1OIE0xkEimhI=; b=Cpa0vU2EpOWrcoYa8OvaIoRNZB
	o615YCNJh6U12Um76eh/VykU3TmmxswvI2kvOSnoblcTZwkxxqJEqFedt+xK5hv9Rzu/L4RX8DbWz
	51WHKDwvbSIBxy3Z2wXbrbj2Qk4AJLhaTl2H09wLOqk2dC3vM04pYWu0ex5Z4p56LbwFm6xcFRPi9
	4UXp1c8v5IDQBc9Fbn5AGN+RUZWjzlqVccR5ipNCvtpM9EerbKZwSONe7KY+TDszHL4bLYTClIRZf
	s638ho/PJKhhfTC9C6/YYDaZ7pha09SB7rjYjmP9wmK7pVLr8MBq8Al/WlHd6z3HqbufKCNemugTR
	hdzoeLAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6uKH-00000006o81-3nQ1;
	Thu, 09 Oct 2025 17:21:13 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6uKG-00000006o7f-13Iv
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 17:21:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760030472; x=1791566472;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VSfn8pNXuGMVE+fCuSyar2iZCdmp1Khi5fJSnUlHE9Q=;
  b=AYQtu5EHSyyJOCULAzE4g/64wys7dyt3cvUh90usSeDLPAEC0aAkYkB8
   NjlAjRUeYxJtcO9knkIvnLN/89VpEIEUBu5WXsSSM6vUUM67ryrihMG5C
   kZ4NRvteytkA/XVfF5FV9Jn6clNW2aD7TfJKnFCPv6ZpO0mo2e2BYEOOB
   m7sykdyDxg0fDdDlWHh0MzF9H9HsRpWeck7fIS268VW1ppRLqjwyKa5FX
   APRqcZdPowwO0m6FOp6ySnX2z0aX5zU+jpidX2r0x9XjcWWSEqP9uCOUq
   5cgc90ecTrYFto+p10b/BqNQdynjODh0yNxYUPw4G9ZVFOn7Hoyx8ug/d
   A==;
X-CSE-ConnectionGUID: MnwaOctJT0CcTZ6zzFkBkw==
X-CSE-MsgGUID: GsiUo/EMTcC9fQ+rdFkShw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="72930571"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="72930571"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 10:21:11 -0700
X-CSE-ConnectionGUID: bjwOxSAASW+mWE0uQpXl4A==
X-CSE-MsgGUID: kudzUTmUSDCuAxWd9tCaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180365339"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2025 10:21:09 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6uKA-00015i-2B;
	Thu, 09 Oct 2025 17:21:06 +0000
Date: Fri, 10 Oct 2025 01:20:48 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: [linux-nvme:nvme-6.19 6/13]
 drivers/nvme/target/../host/nvme.h:1205:27: error: static declaration of
 'nvme_auth_extract_key' follows non-static declaration
Message-ID: <202510100105.cibujuUJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_102112_304050_7EF89DF1 
X-CRM114-Status: UNSURE (   9.79  )
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
head:   00e104767fe39da1798a35eb0e63663621b77556
commit: f59ae5c9e356b5eb50342ce962eb35799aa5c552 [6/13] nvme: parse dhchap keys during option parsing
config: hexagon-randconfig-002-20251009 (https://download.01.org/0day-ci/archive/20251010/202510100105.cibujuUJ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510100105.cibujuUJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510100105.cibujuUJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/nvme/target/loop.c:13:
>> drivers/nvme/target/../host/nvme.h:1205:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    1205 | static inline struct key *nvme_auth_extract_key(struct key *keyring,
         |                           ^
   drivers/nvme/target/nvmet.h:896:13: note: previous declaration is here
     896 | struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
         |             ^
   1 error generated.


vim +/nvme_auth_extract_key +1205 drivers/nvme/target/../host/nvme.h

  1170	
  1171	#ifdef CONFIG_NVME_HOST_AUTH
  1172	int __init nvme_init_auth(void);
  1173	void __exit nvme_exit_auth(void);
  1174	int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
  1175	void nvme_auth_stop(struct nvme_ctrl *ctrl);
  1176	int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
  1177	int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
  1178	void nvme_auth_free(struct nvme_ctrl *ctrl);
  1179	void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl);
  1180	struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
  1181					  size_t secret_len, bool *generated);
  1182	#else
  1183	static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
  1184	{
  1185		return 0;
  1186	}
  1187	static inline int __init nvme_init_auth(void)
  1188	{
  1189		return 0;
  1190	}
  1191	static inline void __exit nvme_exit_auth(void)
  1192	{
  1193	}
  1194	static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
  1195	static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
  1196	{
  1197		return -EPROTONOSUPPORT;
  1198	}
  1199	static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
  1200	{
  1201		return -EPROTONOSUPPORT;
  1202	}
  1203	static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
  1204	static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
> 1205	static inline struct key *nvme_auth_extract_key(struct key *keyring,
  1206							const u8 *secret,
  1207							size_t secret_len,
  1208							bool *generated)
  1209	{
  1210		return ERR_PTR(-ENOKEY);
  1211	}
  1212	#endif
  1213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

