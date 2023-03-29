Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA453C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m66QfaYtTdncPHJpq8ouZNXyepTW4EhPappA6okNgfU=; b=K8O0eR6E3VHCrdHApdZogNJZSr
	tKv3u87pDXXZhSSMbIuc95drQs2XzqHbYatLp3lmU1CVs8fqBoFUaVyuN9P/kqiUU6pNl2Vy3O3lc
	hJABbJYFRIqmlLzsgq/ASIjbiG8A3C/mKHy4l8Z44kDuopklpG/gE9FLs29jGoMk5PTtegAibd+6y
	JBbPnwbo60/R1I0RP6+Erm2tb8vCe3lg/PkeCNhQpnIcKOvb1gi8Ul5BqlXhYGKcHh17EYPBBJTeZ
	g9sd5JgzlMSbbUVnwW4f+ogQeeX+19zvPzIG4roB18dKXlIsXcLjbk42/8F9DtdbxKg/mOz/HdKua
	rGBD664Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWTg-000YDT-0R;
	Wed, 29 Mar 2023 14:08:40 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWTb-000YCI-2W
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:08:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680098915; x=1711634915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=54TwdqI2jO0fD5SczmgJpyLhNeumpJSC1ZS+7HlXaF4=;
  b=TFyxsQ3z6HN/ktKbZNSRSCx6JkXgsEmKi6NbU6ZlvGkTBsrupnTfKjiw
   7/5hX2qPNxbLPR88NgDXhKwJuYbPKugmxJowh59uNAPOocYawL8veZ7jl
   QahiEXnrdru8SH+Qx1+9KrZk7r5SJk/tI9JlIB8WYJqiTLhEsHL1RP6zX
   dDr76l0alJUD8kVx0H7r3ZfWGbXnEhT7CFO8bWIjtidX0+YpKcR6RH7A6
   +molRuAW7jG8X7jNJ5/aV1+VDMsYVqzI3d0Ee4942EHeEluj9a2u4/gAQ
   VbJHqBjB0f0LA+J4MPiX7hwz0Nyxc/GIhluWSOKOVLZW717O/PWif68Pf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="324789531"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="324789531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795245926"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="795245926"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2023 07:07:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1phWSv-000Jba-1B;
	Wed, 29 Mar 2023 14:07:53 +0000
Date: Wed, 29 Mar 2023 22:07:29 +0800
From: kernel test robot <lkp@intel.com>
To: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bvanassche@acm.org, hare@suse.de,
	ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device.
Message-ID: <202303292151.7DDOUCIt-lkp@intel.com>
References: <20230327084103.21601-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327084103.21601-5-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_070835_866324_63E25B58 
X-CRM114-Status: GOOD (  15.62  )
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

Hi Anuj,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on device-mapper-dm/for-next linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anuj-Gupta/block-Add-copy-offload-support-infrastructure/20230329-162018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230327084103.21601-5-anuj20.g%40samsung.com
patch subject: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for direct block device.
config: loongarch-randconfig-r001-20230329 (https://download.01.org/0day-ci/archive/20230329/202303292151.7DDOUCIt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/61819d260936954ddd6688548f074e7063dcf39e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anuj-Gupta/block-Add-copy-offload-support-infrastructure/20230329-162018
        git checkout 61819d260936954ddd6688548f074e7063dcf39e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303292151.7DDOUCIt-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: fs/read_write.o: in function `.L633':
>> read_write.c:(.text+0x42e0): undefined reference to `I_BDEV'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

