Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15FECCA468
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+RhFe7wdWh/TGbPnOAUZ6K9z76xS86QmrQUzjEK37+0=; b=Mz+MnuinKHWoSIt78/ItCq2Gek
	AFgKpiLK6IPjuBckE7pm5SR+B6YUeR1k2hrtdtYwTQTa8hoMxgoBcTl0uD8oZCL3MkyYImTEvbqaQ
	p5wllwCLWRPAVe1NK061iP4+Zo4kZhnDQijB75NpHtK8/yht8IudQeOkl9ubPFrO7+TojC4lEwPzg
	QYj4Gm9XDjE+frWEAGbUNLQueEMCChGL2bqCJ8I9P+1wHdNBFMeDprrJsOcUxYsexgdD6vYTKtLrr
	H0yM445qDpd3xCDNbzi+f+kRNbMZo+FedB2RI5DlzuFljHu5W3dqMJGSRExjfjDjyUtzGEjUF+8t+
	5vSoTtxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3bR6-00000005Vhe-3TTt;
	Tue, 30 Sep 2025 14:34:36 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3bR4-00000005Vgz-2np8
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 14:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759242875; x=1790778875;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PIZYDGLB/EvkvEb0kX4IRMqFUE4mUfaQpfC4QTkZzbo=;
  b=MCizKUfuzJIgXvEemGex2hUFJHcI/Pj8rYp/hRvu4DCEWET0oOGtZlGq
   PSf+kmyvd/SbnNwnBid/e94MMK5xqegZFYO7PEJl9g6xZG3b5mPzKaMKh
   3ZloWUQKRRklePmrPSz5sTHTWOXYD7c4Cz3VRd+G1iuDR2arkbkbolu6H
   a25h137MViUB15dMT1B1eDGSHjMFcVj3Rvj6Gwu1NtQG3Onhr/F6s3hg8
   8QawisMt0OdhK4tBan60/JNyKE2cp3Q+A3kfTmq3vz/OckYghTTvSeTll
   UGxDpbE3DI1N+JOOE6CRc1I5GSvXdygYpCq/BSgfUtA+6jr7RijZ1PEje
   A==;
X-CSE-ConnectionGUID: CjgaTR33T+uDgI9gcDIUww==
X-CSE-MsgGUID: T/UIwhw+Q7ehCAVYP1Eheg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65140430"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="65140430"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 07:34:30 -0700
X-CSE-ConnectionGUID: 4HXVOdTQSW6O6ZXwhKVi8Q==
X-CSE-MsgGUID: iCUDpUu4Tyi6J8RQ8D0C5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178570816"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Sep 2025 07:34:28 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3bQw-0001QB-0A;
	Tue, 30 Sep 2025 14:34:26 +0000
Date: Tue, 30 Sep 2025 22:33:33 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [linux-nvme:nvme-6.18 4/11] include/linux/nvme-keyring.h:54:1:
 error: expected identifier or '(' before '{' token
Message-ID: <202509302259.Yku13u90-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_073434_750926_B770AA4C 
X-CRM114-Status: UNSURE (   9.73  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.18
head:   876f5e3e3b1e3e78aec9b7e53bec4b949a13ce09
commit: 2907c26f418da9a46deae686598e3006958fb1c5 [4/11] nvme-keyring: add 'dhchap' key type
config: arm-randconfig-001-20250930 (https://download.01.org/0day-ci/archive/20250930/202509302259.Yku13u90-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250930/202509302259.Yku13u90-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509302259.Yku13u90-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/fabrics.c:15:
>> include/linux/nvme-keyring.h:54:1: error: expected identifier or '(' before '{' token
      54 | {
         | ^
>> include/linux/nvme-keyring.h:57:4: warning: no previous prototype for 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]
      57 | u8 nvme_dhchap_psk_hash(struct key *key)
         |    ^~~~~~~~~~~~~~~~~~~~
>> include/linux/nvme-keyring.h:52:27: warning: 'nvme_dhchap_psk_lookup' declared 'static' but never defined [-Wunused-function]
      52 | static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
         |                           ^~~~~~~~~~~~~~~~~~~~~~


vim +54 include/linux/nvme-keyring.h

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
  > 52	static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
    53			const char *hostnqn, const char *subnqn, u8 hmac);
  > 54	{
    55		return ERR_PTR(-ENOTSUPP);
    56	}
  > 57	u8 nvme_dhchap_psk_hash(struct key *key)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

