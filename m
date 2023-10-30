Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DF5C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQ7fbE02UgE56u3Y+dEyy0+hVW4Gi5FCYUs18yS72xY=; b=ya8zrkPS+HY7D3umOz8jDBzQwR
	H8FvdVsIyWeYmD2+jPL12MRZPh5/L03EHqPmjrx/8Cw+lKU4Xh/dBGeavj4SfjRMD6o6WEB4IrXuc
	KpLlVCk4+X845pY/n2rz+UuLBmgL42qB463U9YZMcm0oO7iwRnTJjw39PRAow7BhMdP/UVxwvLuBM
	OxBMGppa374yUGBFmgziZqC7N6ljNth1opGJHwy0lbtPdLb8Q/Q4Z00GYW2kIn5rAldkpPN4VOl9N
	4pb1G/dUqkoDT6NvnmCD4OYgZ1h2us3HivtEIhM7+AOb9cPQcKvuOlmKDIE7Icx7hjrAaZtVbqbd5
	nPrAEI4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxUBS-003Ya5-21;
	Mon, 30 Oct 2023 15:28:06 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxUBP-003YZb-1a
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 15:28:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698679683; x=1730215683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6T6UPqWYgJB+UcA/dxsApCw6zxraf4JHxXI0YyflEQE=;
  b=Ga7ZtT5Mf6SEEjn1OK1cbY7wZXej5yQs7mAM6oE7G5axXwSqCg4l9XZJ
   /9zsZfD5ttV1fat7/yKaQ/lwZS7OsRgr5Fsa6DA8Z53U8OdIr1qHQ2QZM
   zPICqF4xa4wnEEvhGf9yieG6vC36Grv+MZJg7/JZq235mVn2/Fl72HHsa
   GwbL5X7nTKv6wmg+lnboDUy+89eG84GHp8nQM/BXzZTTD2rCX4RuqAyeO
   zBY3Umlf2Ux/LdjiGntJpZDGID6vPuaCjhmTCwirpj46JgfcebAoM/HmY
   V7faOzaFQrm2WPU1mrlYFqRWwtYY8dhvecBgVa4mlCSmHrRfUnKWaxecO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="373139866"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373139866"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 08:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760301000"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="760301000"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2023 08:27:55 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qxUBE-000DMR-2c;
	Mon, 30 Oct 2023 15:27:53 +0000
Date: Mon, 30 Oct 2023 23:27:28 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <202310302318.pPweFNME-lkp@intel.com>
References: <20231027181929.2589937-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181929.2589937-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_082803_596470_61F0D678 
X-CRM114-Status: GOOD (  13.63  )
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

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.6 next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/block-bio-integrity-directly-map-user-buffers/20231028-022107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20231027181929.2589937-2-kbusch%40meta.com
patch subject: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20231030/202310302318.pPweFNME-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310302318.pPweFNME-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310302318.pPweFNME-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/blkdev.h:17,
                    from lib/vsprintf.c:47:
   include/linux/bio.h: In function 'bio_integrity_map_user':
>> include/linux/bio.h:799:1: error: expected ';' before '}' token
     799 | }
         | ^
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1682:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1682 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


vim +799 include/linux/bio.h

   794	
   795	static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
   796						 unsigned int len, u32 seed)
   797	{
   798		return -EINVAL
 > 799	}
   800	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

