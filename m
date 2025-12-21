Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71343E66886
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EgF+u+3+qKWUN2Pcj0Q6pSWcx9vHIvQVBsBvZcGrA4o=; b=fkRXGj0rUDK9rJ4Xu3CBOHcg3i
	/caJs0VluBcPz+o/W3TED4s1g32l2CqN5viF3EwVWrHk5zDphOIYgYFPsRONytgHqZoON53odILHz
	koGO/TpZN+W10OcAQWrs6WjbZg2OSCV+GNncYn6nPM17moE2BxEwpkVG+4SbAkxWdIZsqfol02O2T
	5NgMwIpjBQxSkzW98rEY/7CZxOjlopPFiyM88fLKAzWKfxmMud6HoEH2whOYOCngompdz9GJ1QYSk
	vJbhIimEOfj0tGRYcm+VP6Sedk7voWXXRye/qork3PT3iqo0cdTxkBgsczPjfZ29A8aPks9vLEeTH
	ELP4k7YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXDau-0000000CCY4-3xyi;
	Sun, 21 Dec 2025 07:11:08 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXDam-0000000CCXe-2elT
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 07:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766301061; x=1797837061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pUcNV5KVp9JG5QHdkt8tf0jL5xiJu4V00/rw6BChgSk=;
  b=CIgk4B7fByqNyZ/IGbrGcWctzWPjivwroENs5EbKUtg8NWJy3EVEZGmY
   Vf/XveY9jFWQCtUJkpycQOEScdSTJELUsiBSUPW509h0DF67rwL5KXXaa
   yVeeDPfpK2SRoN2EnlPBjuhYcjwsuW/+BvEtjD8LmFKjvYMVfUjWwlZzv
   dOTGPsa+O8GkwKwfBEC2/yDOUhFXDms8pkCcPsBSQ+zGKgpia/EW72ROw
   DWged1/WofoMLltP1cPi3jYSk1oRRyYzzXhDvpEBBA0N8LMZYpth0aqyi
   Nyx9CGYa7Vl8m+fCEIMJiWx08qHwdykEXeqj69XNcoDofnkkwT2kvX2jd
   A==;
X-CSE-ConnectionGUID: Ns/l2s5gRUi6Nulf/YHBBQ==
X-CSE-MsgGUID: BQYAiRHnT7yNFOQWeKx4zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="68242922"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="68242922"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 23:11:00 -0800
X-CSE-ConnectionGUID: BwKEE3XIT669p95RFe3K0g==
X-CSE-MsgGUID: /MGz7wTwRwmYFW/kePXy7Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2025 23:10:59 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXDai-000000005OH-42S1;
	Sun, 21 Dec 2025 07:10:56 +0000
Date: Sun, 21 Dec 2025 15:10:03 +0800
From: kernel test robot <lkp@intel.com>
To: Vitaliy Filippov <vitalifster@gmail.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Vitaliy Filippov <vitalifster@gmail.com>
Subject: Re: [PATCH] Do not require atomic writes to be power of 2 sized and
 aligned on length boundary
Message-ID: <202512211405.FsWuMZAC-lkp@intel.com>
References: <20251220173833.71176-1-vitalifster@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220173833.71176-1-vitalifster@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251220_231100_921551_59154761 
X-CRM114-Status: UNSURE (   9.51  )
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

Hi Vitaliy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vitaliy-Filippov/Do-not-require-atomic-writes-to-be-power-of-2-sized-and-aligned-on-length-boundary/20251221-014115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251220173833.71176-1-vitalifster%40gmail.com
patch subject: [PATCH] Do not require atomic writes to be power of 2 sized and aligned on length boundary
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20251221/202512211405.FsWuMZAC-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512211405.FsWuMZAC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512211405.FsWuMZAC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/read_write.c: In function 'generic_atomic_write_valid':
>> fs/read_write.c:1805:16: warning: unused variable 'len' [-Wunused-variable]
    1805 |         size_t len = iov_iter_count(iter);
         |                ^~~


vim +/len +1805 fs/read_write.c

c34fc6f26ab86d0 Prasad Singamsetty 2024-06-20  1802  
c3be7ebbbce5201 John Garry         2024-10-19  1803  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
c34fc6f26ab86d0 Prasad Singamsetty 2024-06-20  1804  {
c34fc6f26ab86d0 Prasad Singamsetty 2024-06-20 @1805  	size_t len = iov_iter_count(iter);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

