Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D09C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/DKW3LaHbQZzwzNtJpLwgGQtDC6Yt7JxonjusUoHF4=; b=0etVC0FECy4TjjjAR9Tq+XLe59
	QVcjur1BHmbg/HFRWB4wADmgtf1QoMXVs8CAxPOb1cxGcD3PlUjOPy9gVCdSjUUzCsxyFmHXu8cBi
	z4I1enj4k2WXsn2s1uAGYaLkzFrnC6Dgzz+hx/khfoTf6/vr2A/Vfk+v9l6JqoXHw9aHCMUcKtpBv
	OGvXv/3VVJR+dJ8R+V2rtfvRODQshKkS43qbQOXEGwm121y617a73TtHbEhmcD5yxrbqlw9ukxE04
	nQtiO17fEIhwMJEuUBcNYp2jyKlLgkwKxBcsGYmfig0oc2p9j2r52Qw9bx/fn40yGfmprZmfgKRwc
	o3OgBt1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIBtr-004J0T-9m; Thu, 10 Feb 2022 16:02:27 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI3aH-002qqw-44
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 07:09:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644476981; x=1676012981;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=584MwG2iZL/ZKEmSpY0r/AEBoG/ID+aoMKFMo/Oh1Hg=;
 b=J2Z0phJx7Xu0GM4lUqNZZCsuOxpYuOXxGWPdP5QLFy5Bo40c58H1Of39
 MQ5/l0flrNJWoOX/6j2zCIvtGxQPt4RvZf362vuNhfYOmEoJEVKcn8hBe
 y0K130TZqp07LcATigEGiFEfAi01Mes4YHYULA0dTXdymlXQklhu6MsaB
 UmsYhFseMqEupRbTvP5JHp5VNa5HUnSZ8rkXQMaMTRp8LCLNOoe13IgUk
 6mhG4EhIImcFwOIYPraaJSKn/rQvWhZL1GxYw49Kp/suBe+eLXTmvMYvj
 PZuyeDKrDeT/qH4c9gsx63Y6WKT9et9fh3p64+ZM5crlTYTF6aIvNn5vR A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310166977"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; d="scan'208";a="310166977"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 23:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; d="scan'208";a="482643883"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 09 Feb 2022 23:09:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nI3a7-0002rA-1q; Thu, 10 Feb 2022 07:09:31 +0000
Date: Thu, 10 Feb 2022 15:08:52 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc: kbuild-all@lists.01.org, javier@javigon.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com,
 bvanassche@acm.org, martin.petersen@oracle.com,
 roland@purestorage.com, hare@suse.de, kbusch@kernel.org, hch@lst.de,
 Frederick.Knight@netapp.com, zach.brown@ni.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
 josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
 jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
 nj.shetty@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH v2 06/10] nvme: add copy support
Message-ID: <202202101447.DEcXWmHU-lkp@intel.com>
References: <20220207141348.4235-7-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-7-nj.shetty@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_230941_259374_97F3F5E1 
X-CRM114-Status: GOOD (  14.74  )
X-Mailman-Approved-At: Thu, 10 Feb 2022 08:02:26 -0800
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

Hi Nitesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v5.17-rc3 next-20220209]
[cannot apply to device-mapper-dm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm64-randconfig-s032-20220207 (https://download.01.org/0day-ci/archive/20220210/202202101447.DEcXWmHU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/22cbc1d3df11aaadd02b27ce5dcb702f9a8f4272
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
        git checkout 22cbc1d3df11aaadd02b27ce5dcb702f9a8f4272
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/host/ drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/core.c:1793:42: sparse: sparse: cast to restricted __le64
   drivers/nvme/host/core.c:1793:42: sparse: sparse: cast from restricted __le32
>> drivers/nvme/host/core.c:1795:48: sparse: sparse: cast to restricted __le32
>> drivers/nvme/host/core.c:1795:48: sparse: sparse: cast from restricted __le16
>> drivers/nvme/host/core.c:903:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] dspec @@     got restricted __le32 [usertype] @@
   drivers/nvme/host/core.c:903:26: sparse:     expected restricted __le16 [usertype] dspec
   drivers/nvme/host/core.c:903:26: sparse:     got restricted __le32 [usertype]

vim +1793 drivers/nvme/host/core.c

  1774	
  1775	static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
  1776					       struct nvme_id_ns *id)
  1777	{
  1778		struct nvme_ctrl *ctrl = ns->ctrl;
  1779		struct request_queue *queue = disk->queue;
  1780	
  1781		if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
  1782			queue->limits.copy_offload = 0;
  1783			queue->limits.max_copy_sectors = 0;
  1784			queue->limits.max_copy_range_sectors = 0;
  1785			queue->limits.max_copy_nr_ranges = 0;
  1786			blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
  1787			return;
  1788		}
  1789	
  1790		/* setting copy limits */
  1791		blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue);
  1792		queue->limits.copy_offload = 0;
> 1793		queue->limits.max_copy_sectors = le64_to_cpu(id->mcl) *
  1794			(1 << (ns->lba_shift - 9));
> 1795		queue->limits.max_copy_range_sectors = le32_to_cpu(id->mssrl) *
  1796			(1 << (ns->lba_shift - 9));
  1797		queue->limits.max_copy_nr_ranges = id->msrc + 1;
  1798	}
  1799	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

