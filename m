Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB415E77188
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2025 19:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v04C4WRjdJLQywbSCAuHomGTWRY3ErBf95xjDGBqoss=; b=q1MIPv6qdpgDK2V/h/Na8F80+B
	STn0wMSmqwzpfcyf/NodTF+bELsZqeSymrPC6Wfzijq9RmJpmZ8t+h9ejaDmeTzpplj1EkWadHr8c
	lBpQeNUcdrWZu05xhY+hq5mGRvTphk5sI3ec2PvQ/PCGh3ID5NgXIUvL7KXXOCDwj+B2xmoLz8WxR
	1jxHl8F2LVxLuN1F23f/qraJNc6oiFFBCtBppKFkj6NXxMbOL18CZWo2Wn0i4iAz3QHPTtCrEY8/J
	rJhVCuPHcjnbkhQjlZz7ykB7hvsqgOJ49EfIrDAv89aOlRQV+7XkQ3TON5ceAFOJzxoFZ8Y9aOfRW
	YLWt3fdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tX3pE-00000003LLh-25U5;
	Sun, 12 Jan 2025 19:40:44 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tX3pB-00000003LLK-3DbY
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jan 2025 19:40:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736710842; x=1768246842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QmxaaU7j+wgINjt89Qxa0hewTyYsU9tufLrFrisYXaQ=;
  b=LtnbMt54P/wlwkVdhb9TEQ/toWFKKxzxxx3nEQHyExtAu+y8eV7Ag8lL
   Yk70K6YMMWGvrLWnx/Rc+enQgODHv/98gKiwABbDtMZ+s6xWG27W1XawJ
   AfIcjS97eKNT6egdVF1W2ZahjFsUzZNVinFcY3o/IvWDLwip76zgnQbVY
   HIebSHT6NTrUnW4joKg6nQV1krsofJbb0voTkslU4VA4tAypFRJoPpiSH
   vym7xkBXKiLoXs+/nCz6pLBJThy+hKam2qiFMScBHUFu4IJUMIiV2KhfR
   E2Xram9/DNCEjggEl3RzPxDmgcWdbOeJu2r/AxGQIfDH1qOPPziFd266S
   g==;
X-CSE-ConnectionGUID: /xqtS2kpRQ6yXnTEmjSxlw==
X-CSE-MsgGUID: y0qUxRW3QZOQ4pxZF+mMVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="48351720"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="48351720"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 11:40:38 -0800
X-CSE-ConnectionGUID: meavDUFSTHuxjoMyDct5Mg==
X-CSE-MsgGUID: rzzfmzJmQTKcBwxLnGzYKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="104737280"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Jan 2025 11:40:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tX3p1-000MLH-1l;
	Sun, 12 Jan 2025 19:40:31 +0000
Date: Mon, 13 Jan 2025 03:40:15 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-6.14 29/35] drivers/nvme/host/auth.c:742:2-3:
 Unneeded semicolon
Message-ID: <202501130310.A2dr9hU5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_114041_859216_89E8915A 
X-CRM114-Status: UNSURE (   8.75  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.14
head:   6d84dae9af94be43bb71d24353aef102fd0744da
commit: b68527338ba3882e43bae078c1bd4de0f55c6ce3 [29/35] nvme-tcp: request secure channel concatenation
config: arc-randconfig-r054-20250112 (https://download.01.org/0day-ci/archive/20250113/202501130310.A2dr9hU5-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501130310.A2dr9hU5-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/host/auth.c:742:2-3: Unneeded semicolon
   drivers/nvme/host/auth.c:751:2-3: Unneeded semicolon

vim +742 drivers/nvme/host/auth.c

   699	
   700	static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
   701					   struct nvme_dhchap_queue_context *chap)
   702	{
   703		u8 *psk, *digest, *tls_psk;
   704		struct key *tls_key;
   705		size_t psk_len;
   706		int ret = 0;
   707	
   708		if (!chap->sess_key) {
   709			dev_warn(ctrl->device,
   710				 "%s: qid %d no session key negotiated\n",
   711				 __func__, chap->qid);
   712			return -ENOKEY;
   713		}
   714	
   715		if (chap->qid) {
   716			dev_warn(ctrl->device,
   717				 "qid %d: secure concatenation not supported on I/O queues\n",
   718				 chap->qid);
   719			return -EINVAL;
   720		}
   721		ret = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
   722					     chap->sess_key_len,
   723					     chap->c1, chap->c2,
   724					     chap->hash_len, &psk, &psk_len);
   725		if (ret) {
   726			dev_warn(ctrl->device,
   727				 "%s: qid %d failed to generate PSK, error %d\n",
   728				 __func__, chap->qid, ret);
   729			return ret;
   730		}
   731		dev_dbg(ctrl->device,
   732			  "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
   733	
   734		ret = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
   735						ctrl->opts->subsysnqn,
   736						ctrl->opts->host->nqn, &digest);
   737		if (ret) {
   738			dev_warn(ctrl->device,
   739				 "%s: qid %d failed to generate digest, error %d\n",
   740				 __func__, chap->qid, ret);
   741			goto out_free_psk;
 > 742		};
   743		dev_dbg(ctrl->device, "%s: generated digest %s\n",
   744			 __func__, digest);
   745		ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, digest, &tls_psk);
   746		if (ret) {
   747			dev_warn(ctrl->device,
   748				 "%s: qid %d failed to derive TLS psk, error %d\n",
   749				 __func__, chap->qid, ret);
   750			goto out_free_digest;
   751		};
   752	
   753		tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, ctrl->opts->host->nqn,
   754					       ctrl->opts->subsysnqn, chap->hash_id,
   755					       tls_psk, psk_len, digest);
   756		if (IS_ERR(tls_key)) {
   757			ret = PTR_ERR(tls_key);
   758			dev_warn(ctrl->device,
   759				 "%s: qid %d failed to insert generated key, error %d\n",
   760				 __func__, chap->qid, ret);
   761			tls_key = NULL;
   762		}
   763		kfree_sensitive(tls_psk);
   764		if (ctrl->opts->tls_key)
   765			nvme_auth_revoke_tls_key(ctrl);
   766		ctrl->opts->tls_key = tls_key;
   767	out_free_digest:
   768		kfree_sensitive(digest);
   769	out_free_psk:
   770		kfree_sensitive(psk);
   771		return ret;
   772	}
   773	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

