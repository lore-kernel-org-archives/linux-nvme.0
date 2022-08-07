Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C26FC19F2A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Aug 2022 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tImHUT8VzHKxygN+oH9d0jGhcN1m3suaVHaoH22+mBI=; b=Lv/vEcbq35X+w+++skjoZ4PMD1
	sk5IfvUiFv9aA7r18B5uxWzd+Mxjr+oXlPa7SL86Rd0aKrZUZui4j6Wf8zZuSQEBBxyNplvJNnKls
	rAStpwMVu1rbi97es2rp0dgKfbiYcDrveq+rftcaakH73VOAXQNgOoGoOvC131IMDKtteAKHLknto
	elCsw/nr9JMNcP9H4hQDnCUkoEVe962SG6WjyHRO7v2njxMzwAvwxtRKx1ai5n7r7dSp8I5VCULB9
	7Iaz8r6835iaxLYXGMI6sVZB2qc+95RzTaQ9dDDGhgw8U9IBlsfhgidFpA7MSUT8AI9NU0KZo8mSC
	N5+3TXZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKfMg-00Bxx0-4V; Sun, 07 Aug 2022 12:26:42 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKfMd-00Bxtb-A5
	for linux-nvme@lists.infradead.org; Sun, 07 Aug 2022 12:26:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659875199; x=1691411199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C8OJFU9nJ9ZOIk2R+bGe3FsCe9iC7W48BOxnXR0mX9g=;
  b=QmQEYxuvsc174kMZkXdqhKU/TKSe5ph4X15C976EMHzffMpSrAWBIdbc
   rZ/w4QgGOQQvbSesqnsAD1oIt4kdlyXRixv0puSo8qtg47MP+a0s82qj3
   M3hWPs91RsSshcoEay7ynZAn+ypmH3ztjvSt+xWvn88jUS4umwl9M1CZ1
   w8zu/H95eZnkLyrz9KN0aJI9RtP1Z+U65nMl+kz9DHPQpQdlOuTPKOttQ
   f8NkjHhCmmRmrGDxlSQB7SBuSZtZG16oT7LGjhGsPX8Lv0/hPKv/2w2FM
   815zblrl59apcEd9I/2AkjHzxnfDcntadDPFWUVjqDR9LDD7eDInA4Adi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="352158770"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="352158770"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 05:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="693465426"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2022 05:26:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oKfMV-000LHw-2G;
	Sun, 07 Aug 2022 12:26:31 +0000
Date: Sun, 7 Aug 2022 20:25:41 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de
Cc: kbuild-all@lists.01.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	ming.lei@redhat.com, joshiiitr@gmail.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 4/4] nvme: wire up async polling for io passthrough
 commands
Message-ID: <202208072057.wTajgd76-lkp@intel.com>
References: <20220805154226.155008-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154226.155008-5-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_052639_481576_8EBDC11B 
X-CRM114-Status: GOOD (  12.00  )
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
config: ia64-randconfig-s032-20220807 (https://download.01.org/0day-ci/archive/20220807/202208072057.wTajgd76-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/0964795577fbf09d8b315269504b5e87b5ac492b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kanchan-Joshi/fs-add-file_operations-uring_cmd_iopoll/20220806-004320
        git checkout 0964795577fbf09d8b315269504b5e87b5ac492b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/ioctl.c:639:37: sparse: sparse: Using plain integer as NULL pointer

vim +639 drivers/nvme/host/ioctl.c

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
   638		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
 > 639			ret = bio_poll(bio, 0, 0);
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

