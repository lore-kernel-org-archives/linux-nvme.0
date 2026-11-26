Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1872606A326
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=V3Z3A8Bi;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GM9maxD0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5nCW4MAO5U33E60itT1BNYSCNPq+U7Gmtnf0gOZEkcs=; b=V3Z3A8BiZOjrYjxthOi53rG2xS
	yHD/dSfGkjhq5DySr5Gou8NiGknVq+/YD1pDSU1wM3VaZBv+NhbWWiZ+wStUOXjObvw4BSFRSjeGE
	1Tz5zxDJwmIvV5hNXrhXWvnmZbBlmJRgIjiUraacwWCdUwr/IxuS5XoZxAuDBO9zOewVG5xj2mtR7
	9BmC2kMMCIU6lf/4sAPuntmc2ntfjLcHqjozKtCirgwDoVNfNjoitmwoWGC4Mp7thKHtYTQR91PCm
	SUXO+4FGCN8XI7KqEBvczyRfTQSdibSRrdiDKPm1zKO6g0zYfv99uH8Bsc0Xu6Kzkf51Wqqy5TAYj
	+P4AtZAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWgpj-0000000EXfC-2x9z;
	Thu, 26 Nov 2026 21:16:47 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWgpg-0000000EXep-2jb7
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 21:16:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795727804; x=1827263804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+b15UN31lbPZUO5Fe6FPuB2I9AA36yHOS5UK/Pyl0sw=;
  b=GM9maxD0kfN0aP+t89p0JO2KkNWhEYsaRZidX69pddzw1Vkd/fvJ3l/C
   aCA8qOMkl5ntVglMK6JGYiWu+kkdX3dh5lDSM7ZoQmQHWS55yWSy7ivXn
   JAVW+twhmGWA6Al0yTLQ+CuLpMmrkOJVPuTp982ejWycsgtv0oHdyqJEH
   xGj++QfYC0ceep3Lv37gtye3od/vUvrFzdXymKCPTBFpADVCRfhPtjdQU
   m9eOQo51sGbkldRoToB/ThphGVEmAjI9Liz3RcKOivnSSesymLriYE3CC
   8YcoTfzQA0kX0JYYi5djvcW/xeerFuXMc0av/f1P36H4y85DizGl7e1+3
   w==;
X-CSE-ConnectionGUID: U3CKUEhNRG+nZMozvZeCbQ==
X-CSE-MsgGUID: I/BotxXBRYinYJLZMqyw5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4599565"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4599565"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 13:16:39 -0800
X-CSE-ConnectionGUID: 9EmEOJZOQTioQ3ydyd6Vhg==
X-CSE-MsgGUID: D3JfsdMOTOOZuFRZPvpAsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12167196"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Nov 2026 13:16:35 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWgpT-00000001Uu6-3uKA;
	Thu, 26 Nov 2026 21:16:31 +0000
Date: Fri, 27 Nov 2026 05:15:40 +0800
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
	linux-hardening@vger.kernel.org,
	Martin Belanger <martin.nvme.dev@gmail.com>
Subject: Re: [PATCH v7 14/14] nvme-auth: allow to update pre-provisioned keys
Message-ID: <20261127044024.YlqHcQQx-lkp@intel.com>
References: <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_131644_746525_5BB080D8 
X-CRM114-Status: GOOD (  13.05  )
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
patch link:    https://lore.kernel.org/r/20261126-dhchap-keyring-v4-v7-14-ee438ffea527%40kernel.org
patch subject: [PATCH v7 14/14] nvme-auth: allow to update pre-provisioned keys
config: hexagon-randconfig-1001-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127044024.YlqHcQQx-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project fb29ca8163c3309160711e5a14eb46bc6d4fdad2)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127044024.YlqHcQQx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127044024.YlqHcQQx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/sysfs.c:891:17: warning: variable 'old_key' is uninitialized when used here [-Wuninitialized]
     891 |             key_serial(old_key) != key_serial(key)) {
         |                        ^~~~~~~
   drivers/nvme/host/sysfs.c:853:27: note: initialize the variable 'old_key' to silence this warning
     853 |         struct key *key, *old_key;
         |                                  ^
         |                                   = NULL
   drivers/nvme/host/sysfs.c:996:17: warning: variable 'old_key' is uninitialized when used here [-Wuninitialized]
     996 |             key_serial(old_key) != key_serial(key)) {
         |                        ^~~~~~~
   drivers/nvme/host/sysfs.c:959:27: note: initialize the variable 'old_key' to silence this warning
     959 |         struct key *key, *old_key;
         |                                  ^
         |                                   = NULL
   2 warnings generated.


vim +/old_key +891 drivers/nvme/host/sysfs.c

   848	
   849	static ssize_t dhchap_secret_store(struct device *dev,
   850			struct device_attribute *attr, const char *buf, size_t count)
   851	{
   852		struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
   853		struct key *key, *old_key;
   854		char *dhchap_secret;
   855		bool generated = false;
   856		size_t len;
   857		int ret;
   858	
   859		if (!ctrl->host_key || !count)
   860			return -EINVAL;
   861	
   862		len = strcspn(buf, "\n");
   863		dhchap_secret = kzalloc(len + 1, GFP_KERNEL);
   864		if (!dhchap_secret)
   865			return -ENOMEM;
   866		memcpy(dhchap_secret, buf, len);
   867		nvme_auth_stop(ctrl);
   868	
   869		key = nvme_auth_extract_key(dhchap_secret, len,
   870					    &generated);
   871		if (IS_ERR(key)) {
   872			kfree_sensitive(dhchap_secret);
   873			return PTR_ERR(key);
   874		}
   875		down_read(&key->sem);
   876		ret = key_validate(key);
   877		up_read(&key->sem);
   878		if (ret) {
   879			dev_warn(ctrl->device, "key %08x invalidated\n",
   880				 key_serial(key));
   881			if (generated) {
   882				dev_dbg(ctrl->device, "revoke host key %08x\n",
   883					key_serial(key));
   884				key_revoke(key);
   885			}
   886			key_put(key);
   887			kfree_sensitive(dhchap_secret);
   888			return ret;
   889		}
   890		if (!generated &&
 > 891		    key_serial(old_key) != key_serial(key)) {
   892			dev_warn(ctrl->device, "cannot change pre-populated key %08x\n",
   893				 key_serial(old_key));
   894			key_put(key);
   895			kfree_sensitive(dhchap_secret);
   896			return -EPERM;
   897		}
   898		mutex_lock(&ctrl->dhchap_auth_mutex);
   899		old_key = ctrl->host_key;
   900		if (old_key && old_key == key) {
   901			dev_warn(ctrl->device, "using existing key %08x\n",
   902				 key_serial(old_key));
   903			old_key = key;
   904		} else {
   905			if (ctrl->host_key_generated) {
   906				dev_dbg(ctrl->device, "revoke host key %08x\n",
   907					key_serial(old_key));
   908				key_revoke(old_key);
   909			}
   910			ctrl->host_key = key;
   911			ctrl->host_key_generated = generated;
   912		}
   913		mutex_unlock(&ctrl->dhchap_auth_mutex);
   914		key_put(old_key);
   915		kfree_sensitive(dhchap_secret);
   916		/* Start re-authentication */
   917		dev_info(ctrl->device, "re-authenticating controller\n");
   918		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
   919		flush_work(&ctrl->dhchap_auth_work);
   920		return count;
   921	}
   922	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

