Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9EDC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 09:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SsT/oDowNWup7Ix11QnYhp9cNMr9KttgiUelX9jHuoc=; b=VGVJqtK5i7m3otpbYaUZmBT7vt
	eLFW1s0hxYHaDFdU9Goi+/h8DjsxgDIiKMYVqdB5l4MaLThp+Ww5VkJF+TmnnQHnJV9wVgEvw5ryl
	Wiasz+WuFYp1NSiRJIGw6ZN4Clz5qEdtiRCylL7RRm/NlYUGvhc0gquj7QTMFxDXb0AwhkMYGTvQK
	xnsVK/By5vyxAHgC6WvU9ErGSasHzXIvsAkOWfx8pQJTurnkzpY+sWwilQEoCyddLIG+8qmy1LJFV
	u1Dd+1zjZ8Jkq53HgO6FnVXfhMQ11lmh/shxra/dSXUvhAw1ND/31TrDoFtkdYlKzfKjryb4t32B8
	2uRCjRig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peuiv-00FOhv-0C;
	Wed, 22 Mar 2023 09:25:37 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peuis-00FOgb-1m
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 09:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679477134; x=1711013134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gfhrp8iPSQmV2bVU3KHGZ0M/NIJCkOCiaD6roS2eIAk=;
  b=BBMwYqwEvR4vw7F/g/PSr+9j8KfiObRdQtfD7r2XpKhAGnC3M6Cn9mcH
   saVpqRvHLK/2LOjH/WXd7HaI5JC2GHuurjPmm0LS2DSvm3MLAChNQmZjl
   q28qpNssWiLznaBltsz0tKgzPXM/Qtq2XasADRO7RXEJz5BV/oPIpBYp4
   W7CiADYjMwI9tivFFeyJP7BrvQlm08zKnphvQ6WwTU8GkfP1UubsppgiT
   nSRMQC+tx0lKAhECoJRReMASN3qqsQLnMep9XqsfDmY7f33jqm7KMVr6O
   bXIkzifXGz0I1GZnviUAg7t2i7/ThtSPWccLFVj0HIJ3s4NEWhj4uKaWf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319560129"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="319560129"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 02:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="684235029"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="684235029"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Mar 2023 02:25:31 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1peuio-000D83-29;
	Wed, 22 Mar 2023 09:25:30 +0000
Date: Wed, 22 Mar 2023 17:25:16 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Message-ID: <202303221736.jlRVazVR-lkp@intel.com>
References: <20230322002350.4038048-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322002350.4038048-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_022534_621040_CAE24F37 
X-CRM114-Status: GOOD (  11.08  )
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

Hi Keith,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.3-rc3 next-20230322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/nvme-fabrics-add-queue-setup-helpers/20230322-082537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230322002350.4038048-2-kbusch%40meta.com
patch subject: [PATCH 1/3] nvme-fabrics: add queue setup helpers
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230322/202303221736.jlRVazVR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0acb3964621b925db18ebec1a6c57bc3c3446859
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Keith-Busch/nvme-fabrics-add-queue-setup-helpers/20230322-082537
        git checkout 0acb3964621b925db18ebec1a6c57bc3c3446859
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221736.jlRVazVR-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "blk_mq_rdma_map_queues" [drivers/nvme/host/nvme-fabrics.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

