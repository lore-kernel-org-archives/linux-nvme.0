Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57061CD37AC
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fcGNWPdgIRUfqLFA0GOZoU3+UwNtNJ+2YhJwhF/cH/A=; b=p4m029Hv+ZUEprYzQRkUOHQXBp
	HRQrZQS+p1cUanjLTSwNB1lJKhPQiow1dl+g8tLhw31n08Et03a7nzVAszieboOJUzPnIoIj4sqKE
	EckKiEM7urHLfcM4aKY5nRXJ4qoMBU1QVQQn643u36cOwyecOK8qnPmCrFJqzmmQdLUkxOXku3+IM
	9y1gtSQ+fU5XEL+aJS5nNlg77F6+3vCXly1nWmo0A48GoUegsbVqGj4KGYmWTgej12WCuBWBhJ4It
	HoDYatW+3hQSgWRhntS87H4u/za4fF0n+F3pj8NxKe6SCPG6L6y00JCEoQz34Q1gkyJgFDwWpigvx
	rXvdDtBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNdXD-00000006bA4-3DNX;
	Thu, 14 May 2026 21:23:59 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNdXA-00000006b8R-3idd
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 21:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778793836; x=1810329836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vTmSUvIn9x/CcPFXAKAy9pKtnnMg1I+WS1UKjBO+Zc=;
  b=mgQJwG2wgU41/pMBO3qD1+hzezmn6Ztp+jd0Z8WJC1LyWynMA1ZCIxP8
   mtEBrKuGQjMIWKmPMnRYKMzYOHk/yTYcRsTNiInwD8Y7X4guuYnbIc/t0
   gMKMDEAMs64chhT2G9xPuT2Ji+6/9QQiLOoyeXuqdSAIfT1xergLWyK8Q
   eiRivpkxyJ+7OEf6KqetJLhUiDMatKuivUWUrbBs8lrGOYdLNVs5D4/Vc
   OHL83g7CFA/VXQG3AUdzbhuYuM9OOq2138uweI3HjMAfTSSAXoOjW1XNl
   pf8GI1Ig/SA5xP5+rKyE28adTDkiHZjPFb1NJMk4o+zIVZ1ODWyiM3u55
   g==;
X-CSE-ConnectionGUID: 33unYlkSTpyd39PdDV25FA==
X-CSE-MsgGUID: +BnCaR1fQtSUIC6k4ZYG9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79603413"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79603413"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 14:23:53 -0700
X-CSE-ConnectionGUID: yn7ihXaWQOuY/dLmp7hUow==
X-CSE-MsgGUID: iWj2PQ3fQ6+Ap86UUZQvRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="235458897"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 14 May 2026 14:23:50 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNdX1-00000000013-3a1z;
	Thu, 14 May 2026 21:23:47 +0000
Date: Fri, 15 May 2026 04:21:15 +0800
From: kernel test robot <lkp@intel.com>
To: Rohit Chavan <roheetchavan@gmail.com>, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Rohit Chavan <roheetchavan@gmail.com>
Subject: Re: [PATCH] nvme: use str_enabled_disabled() for digest mismatch
 messages
Message-ID: <202605150441.5HXklwvg-lkp@intel.com>
References: <20260504123555.1741525-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504123555.1741525-1-roheetchavan@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_142356_940675_853505AB 
X-CRM114-Status: GOOD (  16.97  )
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

Hi Rohit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe/for-next]
[also build test WARNING on linus/master v7.1-rc3 next-20260508]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Chavan/nvme-use-str_enabled_disabled-for-digest-mismatch-messages/20260514-220734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260504123555.1741525-1-roheetchavan%40gmail.com
patch subject: [PATCH] nvme: use str_enabled_disabled() for digest mismatch messages
config: powerpc64-randconfig-001-20260515 (https://download.01.org/0day-ci/archive/20260515/202605150441.5HXklwvg-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150441.5HXklwvg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605150441.5HXklwvg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/host/tcp.c: In function 'nvme_tcp_init_connection':
   drivers/nvme/host/tcp.c:3089:26: error: unterminated argument list invoking macro "pr_err"
    3089 | MODULE_ALIAS("nvme-tcp");
         |                          ^
   drivers/nvme/host/tcp.c:1576:17: error: 'pr_err' undeclared (first use in this function); did you mean 'xa_err'?
    1576 |                 pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
         |                 ^~~~~~
         |                 xa_err
   drivers/nvme/host/tcp.c:1576:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/nvme/host/tcp.c:1576:23: error: expected ';' at end of input
    1576 |                 pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
         |                       ^
         |                       ;
   ......
   drivers/nvme/host/tcp.c:1576:17: error: expected declaration or statement at end of input
    1576 |                 pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
         |                 ^~~~~~
   drivers/nvme/host/tcp.c:1576:17: error: expected declaration or statement at end of input
   drivers/nvme/host/tcp.c:1570:17: error: label 'free_icresp' used but not defined
    1570 |                 goto free_icresp;
         |                 ^~~~
   drivers/nvme/host/tcp.c:1493:17: error: label 'free_icreq' used but not defined
    1493 |                 goto free_icreq;
         |                 ^~~~
   drivers/nvme/host/tcp.c:1483:13: warning: unused variable 'maxh2cdata' [-Wunused-variable]
    1483 |         u32 maxh2cdata;
         |             ^~~~~~~~~~
   drivers/nvme/host/tcp.c: At top level:
   drivers/nvme/host/tcp.c:1474:12: warning: 'nvme_tcp_init_connection' defined but not used [-Wunused-function]
    1474 | static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1438:13: warning: 'nvme_tcp_free_queue' defined but not used [-Wunused-function]
    1438 | static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1422:12: warning: 'nvme_tcp_alloc_async_req' defined but not used [-Wunused-function]
    1422 | static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1415:13: warning: 'nvme_tcp_free_async_req' defined but not used [-Wunused-function]
    1415 | static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1377:13: warning: 'nvme_tcp_io_work' defined but not used [-Wunused-function]
    1377 | static void nvme_tcp_io_work(struct work_struct *w)
         |             ^~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1094:13: warning: 'nvme_tcp_state_change' defined but not used [-Wunused-function]
    1094 | static void nvme_tcp_state_change(struct sock *sk)
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1078:13: warning: 'nvme_tcp_write_space' defined but not used [-Wunused-function]
    1078 | static void nvme_tcp_write_space(struct sock *sk)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1064:13: warning: 'nvme_tcp_data_ready' defined but not used [-Wunused-function]
    1064 | static void nvme_tcp_data_ready(struct sock *sk)
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:587:12: warning: 'nvme_tcp_init_admin_hctx' defined but not used [-Wunused-function]
     587 | static int nvme_tcp_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:577:12: warning: 'nvme_tcp_init_hctx' defined but not used [-Wunused-function]
     577 | static int nvme_tcp_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
         |            ^~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:550:12: warning: 'nvme_tcp_init_request' defined but not used [-Wunused-function]
     550 | static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:542:13: warning: 'nvme_tcp_exit_request' defined but not used [-Wunused-function]
     542 | static void nvme_tcp_exit_request(struct blk_mq_tag_set *set,
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:208:32: warning: 'nvme_tcp_admin_mq_ops' defined but not used [-Wunused-const-variable=]
     208 | static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
         |                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:207:32: warning: 'nvme_tcp_mq_ops' defined but not used [-Wunused-const-variable=]
     207 | static const struct blk_mq_ops nvme_tcp_mq_ops;
         |                                ^~~~~~~~~~~~~~~
   In file included from include/linux/seqlock.h:20,
                    from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:18,
                    from drivers/nvme/host/tcp.c:7:
>> drivers/nvme/host/tcp.c:205:21: warning: 'nvme_tcp_ctrl_mutex' defined but not used [-Wunused-variable]
     205 | static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
         |                     ^~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:22: note: in definition of macro 'DEFINE_MUTEX'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~
   drivers/nvme/host/tcp.c:95:13: warning: 'nvme_tcp_reclassify_socket' defined but not used [-Wunused-function]
      95 | static void nvme_tcp_reclassify_socket(struct socket *sock) { }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:58:17: warning: 'nvme_tcp_cpu_queues' defined but not used [-Wunused-variable]
      58 | static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
         |                 ^~~~~~~~~~~~~~~~~~~


vim +/nvme_tcp_ctrl_mutex +205 drivers/nvme/host/tcp.c

3f2304f8c6d6ed Sagi Grimberg    2018-12-03  203  
3f2304f8c6d6ed Sagi Grimberg    2018-12-03  204  static LIST_HEAD(nvme_tcp_ctrl_list);
3f2304f8c6d6ed Sagi Grimberg    2018-12-03 @205  static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
3f2304f8c6d6ed Sagi Grimberg    2018-12-03  206  static struct workqueue_struct *nvme_tcp_wq;
6acbd9619b153f Rikard Falkeborn 2020-05-29  207  static const struct blk_mq_ops nvme_tcp_mq_ops;
6acbd9619b153f Rikard Falkeborn 2020-05-29  208  static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
db5ad6b7f8cdd6 Sagi Grimberg    2020-05-01  209  static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
3f2304f8c6d6ed Sagi Grimberg    2018-12-03  210  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

