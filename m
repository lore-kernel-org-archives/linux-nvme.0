Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AB1CD4F3D
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lwMJ1Sm8Hs0w6EN/rdZjRlV8tpP2P+dy3DARKu2Fr8I=; b=QsNxi4xhtkOGmyw9fRuYna+vAa
	Ivd22Yjgz2mRRplDL+cIcBBxqWGeXRlPEwjEPX1/ydzST5R3hPNpaJ0JZuagFu9dFQFcJn3chjnUL
	h5Qeoaixc64v4v/UnKQiFz4AociejeFtiHxB95fjZGND/AoECXE7VqnYABKG+DYdBQKTP8Xi6n5w5
	kqp6aIJdRFDbNZoff9Wihvh2Ae9Jo2hhmP/bmZ2ImyPGGlqHA+CSr26M6t8e36raWfuT9CRMSlC6E
	BRfp2TNW13yV9yxm35mkTaWQmrngIsub3LMRbaWsZ9nkwOEnMniG/ZtWMxCKEgW4r93qc2160sOrq
	ySEARH+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNdXD-00000006b9w-2m7C;
	Thu, 14 May 2026 21:23:59 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNdXA-00000006b8t-3wLf
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 21:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778793836; x=1810329836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XaHBRgXVHL+fP/Xs/C96bJL6IiRPq1lht1sMUxRle04=;
  b=N8Ya17E5T4tPTc5ZtITDI/CcPdYmFEaO8Xrk5uH45PtIoc/9AqTpxkDK
   Y0dLClH94+nmqyJHur3MAczAnj8sr/qB2npd2pJsM6j0XK94gxO64NrqK
   mpvpJgVQtAHoNaGfb7RHjIipfRtSgMPPnjcOPjkt105PnvmocCA+E6XCG
   72xz8kuVmz2CFmvn8WovXdly9SYTTMT66iS4Xs/Lvc60p2D8FNvxnD5VV
   EXwutRO7jgXKE3q/dpl3NRCaNuCWEQRiHWu+66y98ItreqjK4ADsreNhS
   LM2fgCnOXAQaHDetW5PQS8s3X5Ymml+mM/dTm+at3LE0uwQBefBw/0vxb
   A==;
X-CSE-ConnectionGUID: 6c7kVoYDTwSfZ2VTxSvW0w==
X-CSE-MsgGUID: 4A4tAj74R8WMmaSNR22fgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79603417"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79603417"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 14:23:53 -0700
X-CSE-ConnectionGUID: uDi3XdyRSYOKsoe/IcjnZg==
X-CSE-MsgGUID: Q/g3AHWWSJeGSZaeYh4qwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="235458898"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 14 May 2026 14:23:50 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNdX2-00000000015-0Rj6;
	Thu, 14 May 2026 21:23:48 +0000
Date: Fri, 15 May 2026 04:42:01 +0800
From: kernel test robot <lkp@intel.com>
To: Rohit Chavan <roheetchavan@gmail.com>, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Rohit Chavan <roheetchavan@gmail.com>
Subject: Re: [PATCH] nvme: use str_enabled_disabled() for digest mismatch
 messages
Message-ID: <202605150416.4egCVwkx-lkp@intel.com>
References: <20260504123555.1741525-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504123555.1741525-1-roheetchavan@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_142356_996719_0E03F74D 
X-CRM114-Status: GOOD (  15.73  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[cannot apply to linux-nvme/for-next hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Chavan/nvme-use-str_enabled_disabled-for-digest-mismatch-messages/20260514-220734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260504123555.1741525-1-roheetchavan%40gmail.com
patch subject: [PATCH] nvme: use str_enabled_disabled() for digest mismatch messages
config: arm64-randconfig-004-20260515 (https://download.01.org/0day-ci/archive/20260515/202605150416.4egCVwkx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150416.4egCVwkx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605150416.4egCVwkx-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/nvme/host/tcp.c: In function 'nvme_tcp_init_connection':
>> drivers/nvme/host/tcp.c:3089:26: error: unterminated argument list invoking macro "pr_err"
    3089 | MODULE_ALIAS("nvme-tcp");
         |                          ^
>> drivers/nvme/host/tcp.c:1576:17: error: 'pr_err' undeclared (first use in this function); did you mean 'xa_err'?
    1576 |                 pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
         |                 ^~~~~~
         |                 xa_err
   drivers/nvme/host/tcp.c:1576:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/nvme/host/tcp.c:1576:23: error: expected ';' at end of input
    1576 |                 pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
         |                       ^
         |                       ;
   ......
>> drivers/nvme/host/tcp.c:1576:17: error: expected declaration or statement at end of input
    1576 |                 pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
         |                 ^~~~~~
>> drivers/nvme/host/tcp.c:1576:17: error: expected declaration or statement at end of input
>> drivers/nvme/host/tcp.c:1570:17: error: label 'free_icresp' used but not defined
    1570 |                 goto free_icresp;
         |                 ^~~~
>> drivers/nvme/host/tcp.c:1493:17: error: label 'free_icreq' used but not defined
    1493 |                 goto free_icreq;
         |                 ^~~~
>> drivers/nvme/host/tcp.c:1483:13: warning: unused variable 'maxh2cdata' [-Wunused-variable]
    1483 |         u32 maxh2cdata;
         |             ^~~~~~~~~~
   At top level:
>> drivers/nvme/host/tcp.c:1474:12: warning: 'nvme_tcp_init_connection' defined but not used [-Wunused-function]
    1474 | static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1438:13: warning: 'nvme_tcp_free_queue' defined but not used [-Wunused-function]
    1438 | static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
         |             ^~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1422:12: warning: 'nvme_tcp_alloc_async_req' defined but not used [-Wunused-function]
    1422 | static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1415:13: warning: 'nvme_tcp_free_async_req' defined but not used [-Wunused-function]
    1415 | static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1377:13: warning: 'nvme_tcp_io_work' defined but not used [-Wunused-function]
    1377 | static void nvme_tcp_io_work(struct work_struct *w)
         |             ^~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1094:13: warning: 'nvme_tcp_state_change' defined but not used [-Wunused-function]
    1094 | static void nvme_tcp_state_change(struct sock *sk)
         |             ^~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1078:13: warning: 'nvme_tcp_write_space' defined but not used [-Wunused-function]
    1078 | static void nvme_tcp_write_space(struct sock *sk)
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1064:13: warning: 'nvme_tcp_data_ready' defined but not used [-Wunused-function]
    1064 | static void nvme_tcp_data_ready(struct sock *sk)
         |             ^~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:587:12: warning: 'nvme_tcp_init_admin_hctx' defined but not used [-Wunused-function]
     587 | static int nvme_tcp_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:577:12: warning: 'nvme_tcp_init_hctx' defined but not used [-Wunused-function]
     577 | static int nvme_tcp_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
         |            ^~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:550:12: warning: 'nvme_tcp_init_request' defined but not used [-Wunused-function]
     550 | static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
         |            ^~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:542:13: warning: 'nvme_tcp_exit_request' defined but not used [-Wunused-function]
     542 | static void nvme_tcp_exit_request(struct blk_mq_tag_set *set,
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:208:32: warning: 'nvme_tcp_admin_mq_ops' defined but not used [-Wunused-const-variable=]
     208 | static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
         |                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:207:32: warning: 'nvme_tcp_mq_ops' defined but not used [-Wunused-const-variable=]
     207 | static const struct blk_mq_ops nvme_tcp_mq_ops;
         |                                ^~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:70:13: warning: 'nvme_tcp_reclassify_socket' defined but not used [-Wunused-function]
      70 | static void nvme_tcp_reclassify_socket(struct socket *sock)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:58:17: warning: 'nvme_tcp_cpu_queues' defined but not used [-Wunused-variable]
      58 | static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
         |                 ^~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:51:12: warning: 'tls_handshake_timeout' defined but not used [-Wunused-variable]
      51 | static int tls_handshake_timeout = 10;
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/pr_err +3089 drivers/nvme/host/tcp.c

3f2304f8c6d6ed Sagi Grimberg      2018-12-03  3086  
92b0b0ff0ba32e Chaitanya Kulkarni 2024-01-23  3087  MODULE_DESCRIPTION("NVMe host TCP transport driver");
3f2304f8c6d6ed Sagi Grimberg      2018-12-03  3088  MODULE_LICENSE("GPL v2");
723277b15ed971 Geliang Tang       2026-03-31 @3089  MODULE_ALIAS("nvme-tcp");

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

