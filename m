Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB039C77B6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7ZMpWOLjQiDtPHU7QgU9VZTo8I4FL0mrcLDe48w7XE=; b=n9GEzDFa9fb6s5fSLHoqEfDlAp
	aH6WQaSD+Nj6GsK5dq9KBV//phAisLb+5yAQohgxkX9y+9nM4sgTvv852/7rhNgKrQfV42+g2hbw9
	oP6R9eUHQMFkfKlsMUv26GstQI2j3v8H3aOdjlvipJTqYduYa8+zKgdb0RpEzuQxAqEg6B9op24mK
	Tck9BlIyqqWLC8DsFUVkvfkMBLnhNkE76CIdrC9YvXvjxredb39Ke/MMV+LdsvPI2NRFdVKVoE8Z/
	v4VPsvukQanVeT1ay+4m5u2PtTj6tEDZHquPPUoBC+/rjdFFAcFxftIutX02bi9oBR8WGYIzB2eM6
	wtB2OzFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmwSd-006BJj-2K;
	Thu, 13 Apr 2023 12:53:59 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmwSZ-006BHi-1G
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 12:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681390435; x=1712926435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cf9nlwl8d3niwKx0D4zeoXeEDtv7hftLRRYw4QHd3Cw=;
  b=SsY4XSWmizPOI7/QiN91FxsJTz9PQwZjXxBZ4hJY4/Nd6/LGzAZC5bJv
   lobq4Uc+94nMNruqUpKGixIDB0Eu06m9bVC85EEkGbKuaTF/h9DVi3KEB
   KWtrUEyeGFIWMJSpDPRRD80ijM5YIbtiAo0cT3/QK8T3v/bSBQzbfK9qS
   eRUbA5k7KFpI7Iexe5sM3If8zLb6oGUi1nak85v5jqc1Sozntld8pSCIq
   2jMLgxgUqrvyH512bIfW5wVk9y7286IZ2RRv88FglC3Z5HvrAPVi2DoaQ
   ZnaBxShbeum6ScG4DdNgi/exTQZ1BBnvOx1VTRZk/USiwmcrWaLoNNMRs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="345965514"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="345965514"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 05:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="666777301"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="666777301"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2023 05:53:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pmwST-000Yh7-06;
	Thu, 13 Apr 2023 12:53:49 +0000
Date: Thu, 13 Apr 2023 20:53:04 +0800
From: kernel test robot <lkp@intel.com>
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lifeng1519@gmail.com,
	Li Feng <fengli@smartx.com>
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Message-ID: <202304132042.jQcDkblz-lkp@intel.com>
References: <20230413063317.2455680-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413063317.2455680-1-fengli@smartx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_055355_467745_60F80372 
X-CRM114-Status: GOOD (  13.20  )
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

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.3-rc6 next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Feng/nvme-tcp-Add-support-to-set-the-tcp-worker-cpu-affinity/20230413-143611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230413063317.2455680-1-fengli%40smartx.com
patch subject: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20230413/202304132042.jQcDkblz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e5a036c113d5ce43375a6aafedcf705ef8c3acb1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Feng/nvme-tcp-Add-support-to-set-the-tcp-worker-cpu-affinity/20230413-143611
        git checkout e5a036c113d5ce43375a6aafedcf705ef8c3acb1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304132042.jQcDkblz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/tcp.c:44:16: sparse: sparse: symbol 'cpu_affinity_mask' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

