Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA92CA0FED
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfiUHCiiNPh+j6IC/etdkeraxWhNp6g5cIqVOdo/74g=; b=nZjSU46ia/vVkWOV2qvzs5pjBj
	Q6JJeVx/+bdHHl7gnq06Yg/+h2venOxNllr4lzWE9o1KcvIeLUDgpEQDWOuvn2YJ86BmHMpMco74s
	u/uik/Yfk80fqpFBe7tp+SVZkj6wZ+Gu7M9dhQ2scCklVnSrmxOoBIKfrxIGfUwTQ985HIefnTIQf
	5WWYs1+scfS9CR0Bu9NYiaQp4TZBDTq1dY5Y6cBVsMs7D0tJysAWdQLbmn5iwVu6o9k7rOihWi4u6
	qAH4r7OW4r9J4tRN1mvtA4Db7MbXawOAKhEYORTQ9HxG77qFdpl7/OZH1MiYJHcAID89x35g1XjGE
	b1wQ4DZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uub1b-00000003kAl-1bNQ;
	Fri, 05 Sep 2025 18:19:03 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuXAy-00000002Cx1-0jPH
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 14:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757081548; x=1788617548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d623E1liTi60iAjibtCqAAj0iSP9kDrLBmukVMoZ1bw=;
  b=k+VjbZmrNcZAsqGkvKGc43zB10OJqny0j7HNn8rTRMzTLAXwd1My+OhM
   ClRleRVYJ7fAs5SVhkIRJ3NS2MM9lqMiDHno2DIX4mL8FORtgC7vG9FzT
   S9LcoLLvrqujQ+/sISr0x3BbkTwbFOdm4oarSvoSnAfdHZk9mTtIAgvgd
   PGYt6XjVZg3H8ZgdkMMCPHDcjzI1rMaw6wNJe2Pi3ycrpgfxDnzRoKOa4
   +frMLxEGbqqRs8ziRkLkQLCuCTKV/P+3HZwQfMTKNwW8HEijkKTjTHem7
   ZGJh+ilnkc5MV5n49ASKongNF0QJjMnzke7HCV/uYboSi2OTKjo2JSDeL
   w==;
X-CSE-ConnectionGUID: og26Qb8oQ0m2dGz15LCuaA==
X-CSE-MsgGUID: aFuMPKAWQt2nCviEDtfCyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="62065760"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="62065760"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 07:12:26 -0700
X-CSE-ConnectionGUID: 9mM/JCghRqKBgJuUXE6PAQ==
X-CSE-MsgGUID: X78LcsnRTRWksMka9TIijg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="176511026"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2025 07:12:22 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuXAq-0000UZ-1Z;
	Fri, 05 Sep 2025 14:12:20 +0000
Date: Fri, 5 Sep 2025 22:11:58 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 2/7] net/handshake: Make handshake_req_cancel public
Message-ID: <202509052149.ChcoGfkh-lkp@intel.com>
References: <20250905024659.811386-3-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-3-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_071228_231746_DFC3E7E1 
X-CRM114-Status: GOOD (  11.87  )
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

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on net/main net-next/main linus/master linux-nvme/for-next v6.17-rc4 next-20250905]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20250905-105201
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250905024659.811386-3-alistair.francis%40wdc.com
patch subject: [PATCH v2 2/7] net/handshake: Make handshake_req_cancel public
config: x86_64-randconfig-001-20250905 (https://download.01.org/0day-ci/archive/20250905/202509052149.ChcoGfkh-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509052149.ChcoGfkh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509052149.ChcoGfkh-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/handshake/handshake-test.c: In function 'handshake_req_submit_test4':
>> net/handshake/handshake-test.c:237:9: error: implicit declaration of function 'handshake_req_cancel'; did you mean 'handshake_req_next'? [-Werror=implicit-function-declaration]
     237 |         handshake_req_cancel(sock->sk);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         handshake_req_next
   cc1: some warnings being treated as errors


vim +237 net/handshake/handshake-test.c

88232ec1ec5ecf Chuck Lever 2023-04-17  207  
88232ec1ec5ecf Chuck Lever 2023-04-17  208  static void handshake_req_submit_test4(struct kunit *test)
88232ec1ec5ecf Chuck Lever 2023-04-17  209  {
88232ec1ec5ecf Chuck Lever 2023-04-17  210  	struct handshake_req *req, *result;
88232ec1ec5ecf Chuck Lever 2023-04-17  211  	struct socket *sock;
18c40a1cc1d990 Chuck Lever 2023-05-19  212  	struct file *filp;
88232ec1ec5ecf Chuck Lever 2023-04-17  213  	int err;
88232ec1ec5ecf Chuck Lever 2023-04-17  214  
88232ec1ec5ecf Chuck Lever 2023-04-17  215  	/* Arrange */
88232ec1ec5ecf Chuck Lever 2023-04-17  216  	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
88232ec1ec5ecf Chuck Lever 2023-04-17  217  	KUNIT_ASSERT_NOT_NULL(test, req);
88232ec1ec5ecf Chuck Lever 2023-04-17  218  
88232ec1ec5ecf Chuck Lever 2023-04-17  219  	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
88232ec1ec5ecf Chuck Lever 2023-04-17  220  			    &sock, 1);
88232ec1ec5ecf Chuck Lever 2023-04-17  221  	KUNIT_ASSERT_EQ(test, err, 0);
18c40a1cc1d990 Chuck Lever 2023-05-19  222  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
18c40a1cc1d990 Chuck Lever 2023-05-19  223  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
88232ec1ec5ecf Chuck Lever 2023-04-17  224  	KUNIT_ASSERT_NOT_NULL(test, sock->sk);
18c40a1cc1d990 Chuck Lever 2023-05-19  225  	sock->file = filp;
88232ec1ec5ecf Chuck Lever 2023-04-17  226  
88232ec1ec5ecf Chuck Lever 2023-04-17  227  	err = handshake_req_submit(sock, req, GFP_KERNEL);
88232ec1ec5ecf Chuck Lever 2023-04-17  228  	KUNIT_ASSERT_EQ(test, err, 0);
88232ec1ec5ecf Chuck Lever 2023-04-17  229  
88232ec1ec5ecf Chuck Lever 2023-04-17  230  	/* Act */
88232ec1ec5ecf Chuck Lever 2023-04-17  231  	result = handshake_req_hash_lookup(sock->sk);
88232ec1ec5ecf Chuck Lever 2023-04-17  232  
88232ec1ec5ecf Chuck Lever 2023-04-17  233  	/* Assert */
88232ec1ec5ecf Chuck Lever 2023-04-17  234  	KUNIT_EXPECT_NOT_NULL(test, result);
88232ec1ec5ecf Chuck Lever 2023-04-17  235  	KUNIT_EXPECT_PTR_EQ(test, req, result);
88232ec1ec5ecf Chuck Lever 2023-04-17  236  
88232ec1ec5ecf Chuck Lever 2023-04-17 @237  	handshake_req_cancel(sock->sk);
4a0f07d71b0483 Jinjie Ruan 2023-09-19  238  	fput(filp);
88232ec1ec5ecf Chuck Lever 2023-04-17  239  }
88232ec1ec5ecf Chuck Lever 2023-04-17  240  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

