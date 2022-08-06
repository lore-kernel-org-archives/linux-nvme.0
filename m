Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16F0C00140
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Aug 2022 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eux/D5Lv9qNRWAdldvmPk2NZNhaPTDIsn+e6/ZE3bto=; b=SA17x0WMWBdgY8dpKxFTV+dBuU
	qKdN85/J6R5WlTC56mkOIJHOqv2Qb8lthgXLFjjktahu0qCPckq7jq/QiMoeoHFZxBhOWGX1av+7E
	pht4LR0TMp6k85I/HXFLiKmIc+jtcGsLnyLzta+bbbF0pfsKM2UZb2FzV0AmdvU98NE4mgJXn7r8l
	r9fmYvFKoxW/bxGbsWt4t4+GDaIwSquAhU+DcR2mNBlFvPRGkAzIuEN/V0hrBQypnCbE4OZk8qIX2
	uYMj/N85f78GCB6+2AfQy+roqnV3WJgfL/iZq6Iht7i6/TIurzCYr93lUI7SefyhwaFlhRWYipBLa
	cFdeRcCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK7L6-001vOK-5Z; Sat, 06 Aug 2022 00:06:48 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK7L3-001vLE-4W
	for linux-nvme@lists.infradead.org; Sat, 06 Aug 2022 00:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659744405; x=1691280405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wf66Dk1R1z5HRNa92f3K6aYFgQFLMt1ZbhtZO2lk6Uo=;
  b=EHUFNi+IxO57acBrJTnLTIc0e2QGdHYsB3Uiq4lAJgsmgPJpfjOzxA2l
   LEgRPfxREPmso/4cvws1ah4pklkyIyaBBXDG6cK+LA2XmsX5ehMSo4SOq
   ZPBOmSszeKwSuzixriogYflJJyB67gLL5QVFo6q61tt8xluehHcCL0ttA
   1gkPEw6r53JlBNdQ1i+xMmWoa5S34E/aYt9NDJpOlx4a5eTXeZCeVJ1wJ
   p11sChaD5/T6r++/wpNaD6daIZeiJzTdciUa7UJC4q8yi8KREJ/bY7Ad2
   bTr7DFyNPnM+Ua36UiVu7PqdnQnbOLAHqzxrPS0nO8sAawgLP2IudTjzu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="376611464"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="376611464"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 17:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="746027320"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2022 17:06:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oK7Ku-000Jq7-07;
	Sat, 06 Aug 2022 00:06:36 +0000
Date: Sat, 6 Aug 2022 08:06:02 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	ming.lei@redhat.com, joshiiitr@gmail.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 4/4] nvme: wire up async polling for io passthrough
 commands
Message-ID: <202208060733.GCwasLXB-lkp@intel.com>
References: <20220805154226.155008-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154226.155008-5-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_170645_218221_8CAB1061 
X-CRM114-Status: GOOD (  13.34  )
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

Hi Kanchan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master next-20220805]
[cannot apply to hch-configfs/for-next v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/fs-add-file_operations-uring_cmd_iopoll/20220806-004320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220806/202208060733.GCwasLXB-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0964795577fbf09d8b315269504b5e87b5ac492b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kanchan-Joshi/fs-add-file_operations-uring_cmd_iopoll/20220806-004320
        git checkout 0964795577fbf09d8b315269504b5e87b5ac492b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/ioctl.c:638:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:641:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/nvme/host/ioctl.c:638:2: note: remove the 'if' if its condition is always true
           if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/ioctl.c:638:6: warning: variable 'ret' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
           if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:641:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/nvme/host/ioctl.c:638:6: note: remove the '&&' if its condition is always true
           if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/ioctl.c:638:6: warning: variable 'ret' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
           if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:641:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/nvme/host/ioctl.c:638:6: note: remove the '&&' if its condition is always true
           if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:629:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   3 warnings generated.


vim +638 drivers/nvme/host/ioctl.c

   625	
   626	int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
   627	{
   628		struct bio *bio;
   629		int ret;
   630		struct nvme_ns *ns;
   631		struct request_queue *q;
   632	
   633		rcu_read_lock();
   634		bio = READ_ONCE(ioucmd->cookie);
   635		ns = container_of(file_inode(ioucmd->file)->i_cdev,
   636				struct nvme_ns, cdev);
   637		q = ns->queue;
 > 638		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
   639			ret = bio_poll(bio, 0, 0);
   640		rcu_read_unlock();
   641		return ret;
   642	}
   643	#ifdef CONFIG_NVME_MULTIPATH
   644	static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
   645			void __user *argp, struct nvme_ns_head *head, int srcu_idx)
   646		__releases(&head->srcu)
   647	{
   648		struct nvme_ctrl *ctrl = ns->ctrl;
   649		int ret;
   650	
   651		nvme_get_ctrl(ns->ctrl);
   652		srcu_read_unlock(&head->srcu, srcu_idx);
   653		ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
   654	
   655		nvme_put_ctrl(ctrl);
   656		return ret;
   657	}
   658	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

