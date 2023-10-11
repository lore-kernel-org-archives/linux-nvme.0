Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EC7CDB465
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 23:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/k5A3Jn1ZSg3y9Qr4ug3vn56epsfVRpGpqX6uXmBOhg=; b=avw96hk6n20JS6AxklNHOlTwH5
	gjcBIosgDIwqhpHITwQvGieWq0OfdfqF80M3fFG0PS7z9DPfUBONAa2zsMUlHbZ3upnuDppqYhf9h
	kA7gTglfBWdKX7fvqIIQKIe1eHl8XJVJCFax329c1KqgtghaNddSIMuoy6k3kLXTpVGgfEh3NkK0y
	j319FX2rGuLvMC/gC97MhH7Q8Lk2HhE40NBm5EMKOOKWSLsyXyiWD9diMYCchtLl8gsutj6JQOsls
	2EJFTtKMxqqaXpAvG/T7k9Crc/z8AhmDmX7RcY/YgfEDBWhlsJusZx85Doa72Tdc0YbFQYb2utKdm
	3ihIEtnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqiMe-00Gu4L-0W;
	Wed, 11 Oct 2023 23:11:40 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqiMb-00Gu3k-0I
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 23:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697065897; x=1728601897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XGgA9w06CMp0jRkt+cOqHXR1JLuf8vG1xthmdqUP2DQ=;
  b=LUEvLAO3oFRxpSSmreFx0dH5QEp+wj7HZnocqF7aYUaGDeFwXILnSir7
   WexpU+1RfAvhCjpn6sWSaMzA2DJVs361LAFWQ+xqJoRom4Ab64tp7Jq3q
   SraBAg8TdsiRZbGHCYmzKc5MXASYYBkUVsmxjFrj1Dg5jxft0A3dvkyq9
   x2rbt6dyerz5hugfiLlyr59iCWSl5toON1Gx2LigbLkTQ8gg+5nDjaZuw
   P0Orsg5ngNecl3qZb+sTPnEdaBCWYfBogVQTS/3cDV02IABzD63EzGgEP
   GjyFp3ocZApGNaZZceKAonL7ivD+lnem3W7I7eAoQDHIoSwnepLEhN6pp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="365059549"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="365059549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783441140"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783441140"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2023 16:11:32 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqiMT-0002pt-1r;
	Wed, 11 Oct 2023 23:11:29 +0000
Date: Thu, 12 Oct 2023 07:11:24 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-6.7 2/19] s390-linux-ld: configfs.c:undefined
 reference to `nvme_auth_dhgroup_kpp'
Message-ID: <202310120733.TlPOVeJm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_161137_138383_81F616E8 
X-CRM114-Status: UNSURE (   9.21  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.7
head:   70525e5d82f62407d8436aa2a6c3385829ab5a3e
commit: 9d77eb52778499a97cab662aa96de4e2e4fa72d3 [2/19] nvme-keyring: register '.nvme' keyring
config: s390-randconfig-002-20231012 (https://download.01.org/0day-ci/archive/20231012/202310120733.TlPOVeJm-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310120733.TlPOVeJm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310120733.TlPOVeJm-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/nvme/target/configfs.o: in function `nvmet_host_dhchap_dhgroup_store':
   configfs.c:(.text+0x24): undefined reference to `nvme_auth_dhgroup_id'
>> s390-linux-ld: configfs.c:(.text+0x50): undefined reference to `nvme_auth_dhgroup_kpp'
   s390-linux-ld: drivers/nvme/target/configfs.o: in function `nvmet_host_dhchap_dhgroup_show':
   configfs.c:(.text+0xa2): undefined reference to `nvme_auth_dhgroup_name'
   s390-linux-ld: drivers/nvme/target/configfs.o: in function `nvmet_host_dhchap_hash_show':
   configfs.c:(.text+0x532): undefined reference to `nvme_auth_hmac_name'
   s390-linux-ld: drivers/nvme/target/configfs.o: in function `nvmet_host_dhchap_hash_store':
   configfs.c:(.text+0x58c): undefined reference to `nvme_auth_hmac_id'
>> s390-linux-ld: configfs.c:(.text+0x59e): undefined reference to `nvme_auth_hmac_name'
   s390-linux-ld: drivers/nvme/target/fabrics-cmd-auth.o: in function `nvmet_auth_negotiate':
   fabrics-cmd-auth.c:(.text+0x164): undefined reference to `nvme_auth_hmac_name'
>> s390-linux-ld: fabrics-cmd-auth.c:(.text+0x226): undefined reference to `nvme_auth_hmac_name'
>> s390-linux-ld: fabrics-cmd-auth.c:(.text+0x294): undefined reference to `nvme_auth_dhgroup_kpp'
>> s390-linux-ld: fabrics-cmd-auth.c:(.text+0x31e): undefined reference to `nvme_auth_dhgroup_name'
   s390-linux-ld: fabrics-cmd-auth.c:(.text+0x37a): undefined reference to `nvme_auth_dhgroup_name'
   s390-linux-ld: drivers/nvme/target/fabrics-cmd-auth.o: in function `nvmet_auth_challenge':
   fabrics-cmd-auth.c:(.text+0x706): undefined reference to `nvme_auth_hmac_hash_len'
>> s390-linux-ld: fabrics-cmd-auth.c:(.text+0x7e8): undefined reference to `nvme_auth_get_seqnum'
   s390-linux-ld: drivers/nvme/target/fabrics-cmd-auth.o: in function `nvmet_auth_success1.isra.0':
   fabrics-cmd-auth.c:(.text+0x9da): undefined reference to `nvme_auth_hmac_hash_len'
   s390-linux-ld: drivers/nvme/target/auth.o: in function `nvmet_auth_set_key':
   auth.c:(.text+0x76): undefined reference to `nvme_auth_hmac_name'
   s390-linux-ld: drivers/nvme/target/auth.o: in function `nvmet_setup_dhgroup':
   auth.c:(.text+0x1f6): undefined reference to `nvme_auth_dhgroup_kpp'
>> s390-linux-ld: auth.c:(.text+0x2de): undefined reference to `nvme_auth_gen_privkey'
>> s390-linux-ld: auth.c:(.text+0x396): undefined reference to `nvme_auth_gen_pubkey'
   s390-linux-ld: drivers/nvme/target/auth.o: in function `nvmet_setup_auth':
   auth.c:(.text+0x57a): undefined reference to `nvme_auth_hmac_name'
>> s390-linux-ld: auth.c:(.text+0x5b4): undefined reference to `nvme_auth_free_key'
>> s390-linux-ld: auth.c:(.text+0x5ca): undefined reference to `nvme_auth_extract_key'
>> s390-linux-ld: auth.c:(.text+0x60e): undefined reference to `nvme_auth_hmac_name'
   s390-linux-ld: auth.c:(.text+0x658): undefined reference to `nvme_auth_free_key'
   s390-linux-ld: auth.c:(.text+0x682): undefined reference to `nvme_auth_extract_key'
   s390-linux-ld: auth.c:(.text+0x6c2): undefined reference to `nvme_auth_hmac_name'
   s390-linux-ld: auth.c:(.text+0x716): undefined reference to `nvme_auth_free_key'
   s390-linux-ld: drivers/nvme/target/auth.o: in function `nvmet_destroy_auth':
   auth.c:(.text+0x82a): undefined reference to `nvme_auth_free_key'
   s390-linux-ld: auth.c:(.text+0x846): undefined reference to `nvme_auth_free_key'
   s390-linux-ld: drivers/nvme/target/auth.o: in function `nvmet_auth_host_hash':
   auth.c:(.text+0x8e8): undefined reference to `nvme_auth_hmac_name'
>> s390-linux-ld: auth.c:(.text+0x992): undefined reference to `nvme_auth_transform_key'
>> s390-linux-ld: auth.c:(.text+0xa14): undefined reference to `nvme_auth_augmented_challenge'
   s390-linux-ld: drivers/nvme/target/auth.o: in function `nvmet_auth_ctrl_hash':
   auth.c:(.text+0xca8): undefined reference to `nvme_auth_hmac_name'
   s390-linux-ld: auth.c:(.text+0xd54): undefined reference to `nvme_auth_transform_key'
   s390-linux-ld: auth.c:(.text+0xdd2): undefined reference to `nvme_auth_augmented_challenge'
   s390-linux-ld: drivers/nvme/target/auth.o: in function `nvmet_auth_ctrl_sesskey':
   auth.c:(.text+0x1152): undefined reference to `nvme_auth_gen_shared_secret'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

