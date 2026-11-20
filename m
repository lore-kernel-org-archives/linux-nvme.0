Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F71606A6E2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t1XaXf0o;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bq2och5C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=syyZAgghFB2yjz7QtPWEK++I+aqJL7nnvgK0Mbb84ng=; b=t1XaXf0oH3kuruwaDmpyh45Vm1
	/q0sT4QkfYev02Dg84YxKtD2eIva+uTUbkrs5udFbrEOszn6qy/QIQUu9x/nLDess0slYYkynKfLE
	pQnSqV/XzM+/aAbPGZgIu3JQbWtiilNOLkdCfiiMbG2mBRnKW7tSUSE+wZ9RvaN7u2fgf8u2biKna
	GwJ1pPFQwr6nK4rUUHEaUfO8wQO7DxGIxfkJuYsjUj5N4Q+pRCIjnqis/KJnK9ybkcol4qZ2RjRrt
	hOqByBmAlMNXvF8Fa6Ygm6OthUvcjESRpko6Ein8BnOlIpheS0CeT6S9bGgjm3u/ITu93voMKsRBR
	cHNUl0tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUxd-0000000GD18-44zY;
	Fri, 20 Nov 2026 20:11:53 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUxa-0000000GD0O-47FJ
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 20:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795205511; x=1826741511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lRCQ9KCfOnRrOzZOd8tvpwzEbJUwz8+OaC9XkgymjfQ=;
  b=bq2och5CbOt5tJkZblQQO7beFY/CobrsDFllopZZraur8ipX3xtiop3z
   If06HnpeUgQ0Lf7q1ksbaSlw7UU2sY/tCiyn27TdX5VX9iZ1lVbWIRqOn
   mHIS3Bi/qTPFn14ZZxgCMNttWMgfKfXHiXEOtwBkEbqRZlajTgG4jz1QC
   WUszg1P7WOD8JYrMFRPXqOaRlkgdB1Ysql2N3JGksvv0eOABVBB8+VMy2
   Q8WLTt4W7iW6Xwm3q9rPJxWv9FYq/4wKrpDuM99VXpv40Lv/aWkBF3i5P
   D/QsXgBnD+o/QVHhF8Pv88bMl7yq9AB8z5xXnvZFdnlw1sOFozEX/RFSA
   Q==;
X-CSE-ConnectionGUID: LmTOeNKhRzSLVUxHE8tuOw==
X-CSE-MsgGUID: 0+TqMB7kRDS47MZ6JSf7OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3974431"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3974431"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 12:11:50 -0800
X-CSE-ConnectionGUID: /kkF4C2URWe94BSTH3GAQw==
X-CSE-MsgGUID: FsYu6pzwR4i9zVs7DyEr0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11042550"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Nov 2026 12:11:47 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUUxU-00000001ISg-2ph0;
	Fri, 20 Nov 2026 20:11:44 +0000
Date: Sat, 21 Nov 2026 04:11:20 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] nvme-keyring: add 'dhchap' key type
Message-ID: <202611210348.KYpQPgoE-lkp@intel.com>
References: <20261120-dhchap-keyring-v4-v4-2-5f8c7d9926ee@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-dhchap-keyring-v4-v4-2-5f8c7d9926ee@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_121151_084201_D78F101F 
X-CRM114-Status: GOOD (  16.50  )
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

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/nvme-auth-modify-nvme_auth_transform_key-to-return-status/20261120-121400
base:   68099cf27253a8c89d703a282d3d811446d9453b
patch link:    https://lore.kernel.org/r/20261120-dhchap-keyring-v4-v4-2-5f8c7d9926ee%40kernel.org
patch subject: [PATCH v4 2/9] nvme-keyring: add 'dhchap' key type
config: s390-defconfig (https://download.01.org/0day-ci/archive/20261121/202611210348.KYpQPgoE-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611210348.KYpQPgoE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611210348.KYpQPgoE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/common/keyring.c:348:19: warning: variable 'keylen' is uninitialized when used here [-Wuninitialized]
     348 |         prep->quotalen = keylen;
         |                          ^~~~~~
   drivers/nvme/common/keyring.c:310:40: note: initialize the variable 'keylen' to silence this warning
     310 |         size_t datalen = prep->datalen, keylen;
         |                                               ^
         |                                                = 0
   1 warning generated.


vim +/keylen +348 drivers/nvme/common/keyring.c

   293	
   294	/**
   295	 * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
   296	 * @prep: preparsed payload of the key data
   297	 *
   298	 * Decode the DH-HMAC-CHAP key data passed in @prep and
   299	 * store the resulting binary data. The binary data includes
   300	 * space for the CRC, the version, and the hmac identifier,
   301	 * but the data length is just the key data without the CRC.
   302	 * This allows the user to read the key data via the
   303	 * 'user_read()' function. The additional 'version' ahd 'hmac'
   304	 * data is used in the ->read() callback to generate the
   305	 * base64 encoded key.
   306	 */
   307	static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
   308	{
   309		struct user_key_payload *upayload;
   310		size_t datalen = prep->datalen, keylen;
   311		int ret;
   312		u32 crc;
   313		u8 version, hmac;
   314	
   315		if (!prep->data) {
   316			pr_debug("%s: Empty data", __func__);
   317			prep->payload.data[0] = NULL;
   318			prep->quotalen = 0;
   319			return -EINVAL;
   320		}
   321	
   322		if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
   323			   &version, &hmac) != 2) {
   324			pr_debug("%s: invalid key data '%s'\n", __func__,
   325				 (char *)prep->data);
   326			prep->payload.data[0] = NULL;
   327			prep->quotalen = 0;
   328			return -EINVAL;
   329		}
   330	
   331		/* skip header and final ':' character */
   332		datalen -= 11;
   333	
   334		/*
   335		 * payload is < key | version | hmac >
   336		 * base64 decode will always return less data
   337		 * than the encoded data, so allocating the size
   338		 * of the encoded data will be large enough.
   339		 */
   340		upayload = kzalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
   341		if (!upayload) {
   342			prep->payload.data[0] = NULL;
   343			prep->quotalen = 0;
   344			return -ENOMEM;
   345		}
   346	
   347		/* decode the data */
 > 348		prep->quotalen = keylen;
   349		prep->payload.data[0] = upayload;
   350		ret = base64_decode(prep->data + 10, datalen, upayload->data,
   351				    true, BASE64_STD);
   352		if (ret < 0) {
   353			pr_debug("%s: Failed to decode key %s\n",
   354				 __func__, (char *)prep->data + 10);
   355			return ret;
   356		}
   357		ret -= 4;
   358		crc = ~crc32(~0, upayload->data, ret);
   359		if (get_unaligned_le32(upayload->data + ret) != crc) {
   360			pr_debug("%s: CRC mismatch for key\n", __func__);
   361			/* CRC mismatch */
   362			return -EKEYREJECTED;
   363		}
   364		/* append version and hmac to the payload */
   365		upayload->data[ret + 4] = version;
   366		upayload->data[ret + 5] = hmac;
   367		upayload->datalen = ret;
   368		return 0;
   369	}
   370	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

