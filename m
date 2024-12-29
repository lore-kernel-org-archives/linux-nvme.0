Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2ECE7718B
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Dec 2024 06:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4gdnXsDl7ytemc/CYo/BJA5VBm+9t71MtE6QSzrCTk=; b=lQuxmCAIhXz+OyadD9yvW9qIZ+
	H3ZvfTB4J2dDrRIP3KTvKXe+2LcwFn019SPKsdaIwM2IGIdabYongt5P2MVum0UgJweuMuEdIXhbw
	2tA2noN9/ufTPluuczXnLsfhvAK7plHUwGoT6N33HTfvmDsJQGNVFZiBY4EWZ4BxAXaTQlCY3iyvG
	Puo7jrqNTeDteTVIeHt40dyAo8dAxkOn+fnLTp8zZMVURMxInTKJ6tC96kUUGwo8qH0ZBEkLDU/fO
	FTJ1H5soCiaDsQ8EgOf8RBCNe7SS11u9H5DnEfmOaAnx1mfYs48MZQQqAciF/aQyM/SkZSgjuxjoB
	mZP242XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tRnBn-000000030WK-3zPR;
	Sun, 29 Dec 2024 06:54:15 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRnBh-000000030Vn-3Cw8
	for linux-nvme@lists.infradead.org;
	Sun, 29 Dec 2024 06:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735455250; x=1766991250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W4tnXakf0kq3vxryWjAQNS8a3zjroqDKu75yuKQsQlU=;
  b=Dl1QDFRXgdOQObTpnHZOy6sekha2NYTMfdNij0SKRcmVg1pnr2AYxATb
   rSFMCi5XBnS6Rbpt9En08NDsrD+v9Xlz0b7KkqLJ3zvCiQa85zd3lNSq2
   lj5s8LiYnKYSrVsjm1jZSqurfMSxZXe148eq901y8s1KM61awC2IP4nvu
   QrBobYTJWWohCT/iXotLceZkCExUfHq/7ctekYkKXuP+8mEWd1Ss/i3Iw
   AqlyvE6tNaweJ+ItdxJ/TFKWICO5JDHKV1khmmJagvxo5L1q4/n9LrioO
   ZTqfP85VYbuzTlA2TGvAXeZRSBs8NBWPG5pECA6nOxKb30B4Vhw9U4rLc
   Q==;
X-CSE-ConnectionGUID: d10eIA7uQ2u8NPYnREQsvQ==
X-CSE-MsgGUID: wN7l/5lzTdSN6+6dyKbyfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39466500"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="39466500"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 22:54:05 -0800
X-CSE-ConnectionGUID: 5tXAXnFMTt+Crm/OSuw3TQ==
X-CSE-MsgGUID: KKO77kzwQG28faSx55L2Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="105358263"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Dec 2024 22:54:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRnBX-0004XY-2U;
	Sun, 29 Dec 2024 06:53:59 +0000
Date: Sun, 29 Dec 2024 14:53:18 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v8 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <202412291432.nDgfmkwD-lkp@intel.com>
References: <20241225082956.96650-18-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241225082956.96650-18-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241228_225409_884251_D34D0301 
X-CRM114-Status: UNSURE (   9.52  )
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

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4bbf9020becbfd8fc2c3da790855b7042fad455b]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvme-Move-opcode-string-helper-functions-declarations/20241225-163855
base:   4bbf9020becbfd8fc2c3da790855b7042fad455b
patch link:    https://lore.kernel.org/r/20241225082956.96650-18-dlemoal%40kernel.org
patch subject: [PATCH v8 17/18] nvmet: New NVMe PCI endpoint function target driver
config: alpha-randconfig-r072-20241228 (https://download.01.org/0day-ci/archive/20241229/202412291432.nDgfmkwD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241229/202412291432.nDgfmkwD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412291432.nDgfmkwD-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/nvme/target/pci-epf.o: in function `nvmet_pci_epf_complete_iod':
>> (.text+0x2a38): undefined reference to `nvme_get_opcode_str'
>> alpha-linux-ld: (.text+0x2a3c): undefined reference to `nvme_get_opcode_str'
>> alpha-linux-ld: (.text+0x2b24): undefined reference to `nvme_get_admin_opcode_str'
   alpha-linux-ld: (.text+0x2b28): undefined reference to `nvme_get_admin_opcode_str'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

