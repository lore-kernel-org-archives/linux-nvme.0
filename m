Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90F6CA0EED
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 01:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6EjOMjGxgelvbAdgdlpqo6DyVunaFYKRAz7O3t3j+8U=; b=xUM4N7zbBkvm+lQX6Wb6p0i/I0
	xLUB2WJmu/rnLTmFchLKXNCV/iT+CQyFbX/fbCd4e7rUHTn4ddOITqhnYhKe1hyzWQ8TLs3Jp/MYN
	ImuwNBvbmr/l2/yY1HAEl7SyvE9ro2McrfAWySFXgaw8AGLEYYNLxNjrcWXCvNL6a8YCpd7CB0e9D
	vLf89KLDIym6z78ecPmhPqkBWaksE1TJhItcN8J9AxjG57CMxwGIUzmY26VBTWif9fp3DT7+HJ6nu
	xESbFoUzQ3xUhPYqXYyEw/gy5XNCNU58xrlO/9WvGb2iwJfuGa675JdZmPHiw/6viryw6iNsw2A/H
	P0mm9LKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uotwd-0000000FQIu-2cdv;
	Thu, 21 Aug 2025 01:18:23 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoqhn-0000000F23t-37tU
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 21:50:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755726651; x=1787262651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QAJM2vtk+jQErQJw0BJQHZUwsFbRTuLCCthqPSR+ct4=;
  b=UsIStoazprPMSHmDL0i5YvheLKoEbZb6T48MRRNgQ+mkGILEVi0ox1wl
   RL8USOA2onOwvWExpvyNNs4rsJvPO+YQMLlfIvaG5FBuK34V91gwuTXxQ
   fLSNmfGX/F1R30kT74acXIF6S/g6Rbp/bfqoxoH7p2O9APW7XBpEfU46C
   VeJKYg0A6YjzyqObBa7yxEiY8emsw1SNyGFECsPMKIF88sRNcXcTb/jI7
   +IEbgq29SWEoktTFH5sXJnBfNJtSrfACxJqO2zfeR3p0Q1iQw9OuYN6Cb
   WSA+zpRkUDQOnKwAn61psAGOqDDwTQqZwETOGXGgnIIj25JkFSqNIFFfk
   Q==;
X-CSE-ConnectionGUID: M/wYiLjcRjiN0L7WNLK4Mw==
X-CSE-MsgGUID: PMI2SHrERFC3tgZLCXMGKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="45581468"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="45581468"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 14:50:51 -0700
X-CSE-ConnectionGUID: 3i776o2vQP6XTmlLlTM4UA==
X-CSE-MsgGUID: t/8RawfnQS2cb3n5GuBCEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="169024566"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 20 Aug 2025 14:50:48 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoqhc-000JhX-0J;
	Wed, 20 Aug 2025 21:50:42 +0000
Date: Thu, 21 Aug 2025 05:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] crypto: hkdf: add hkdf_expand_label()
Message-ID: <202508210523.p8BdHsR7-lkp@intel.com>
References: <20250820091211.25368-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820091211.25368-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_145051_823611_7D065CC0 
X-CRM114-Status: GOOD (  12.22  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linus/master v6.17-rc2 next-20250820]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hare-kernel-org/crypto-hkdf-add-hkdf_expand_label/20250820-172750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20250820091211.25368-2-hare%40kernel.org
patch subject: [PATCH 1/2] crypto: hkdf: add hkdf_expand_label()
config: loongarch-randconfig-001-20250821 (https://download.01.org/0day-ci/archive/20250821/202508210523.p8BdHsR7-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508210523.p8BdHsR7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508210523.p8BdHsR7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: crypto/hkdf.c:151 function parameter 'labellen' not described in 'hkdf_expand_label'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

