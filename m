Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED5606A6E4
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=05aNYmEn;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BY+NeHy/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PpkBWg73siaVtPLgU+wteCjzVixsxQxZ7WbWHzddazg=; b=05aNYmEniwfmVo0csP4UOdaW5h
	r1pvu7m+7bHXZ3Dy0jsJLQR7a9udSwriK6gbR9E8I42yiEPKheEZiFV7xAAZz9R14PwzhWk+G0xwX
	eHX1SwIEVgnwWwneWLp0ZKmvUyUX7uDDFhESKt9n24RsHsOsqtDSOyjgCpa6TCDiRFTGSiIS+lCa0
	2Sftv+MPopPk46eGM4O3EK/j4+xESviWB8FlRsncbVoGak1n7s7OG520mmCW7xOpm6GSA2i4B+nmB
	a2UblRG+Oenh1FEH1GbKHYhuHZJ80gcqEmdBJ1toCgAu7NXZGA4GpS3yNVdpCux4uNsUkgmUmhXZo
	k5lw2Ghw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUQi-0000000G7BN-298w;
	Fri, 20 Nov 2026 19:37:52 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUQY-0000000G78T-3qrL
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795203463; x=1826739463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zy9gc1RP4EMMMJftR1/jeBO+YhbU4lMj5Uf4m6zIKlg=;
  b=BY+NeHy/fX3l3vKDxrJBYP0Um1yjGLgBD2g1dVnCkEdU6zY7bA+D2BSF
   HchptwtFwY2QYMNC9YEqFMhFnQqMv30C+n02Z34s35XSP6VArZzZznp8d
   r7OQmOYpRb6yrVgHXCO0+2qmJTxSccjnU1MyH01qCA+ylxoCcd+iub0Ez
   qH45fQj5m1hvzUt4UKt3jmV3cshJZNpge+6cH6IDx32d34YzPeZ1pjkk+
   b85qyu6bBzuk8mc6ua3IPdPNIs6Is7VDDl4eYb941kS9iJJXoSvXZ68vn
   Dni4VrsEpUpxzpP/DNck2C5bVKHD+JQOLcDqb8t5zwKVI1CKHlh3Hguy3
   w==;
X-CSE-ConnectionGUID: 7aKZwo1iRcaQrPdfvGel6A==
X-CSE-MsgGUID: xZ9tNSL1Sk24PsAig17QZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3972984"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3972984"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 11:37:42 -0800
X-CSE-ConnectionGUID: 3+MGPmkjSyKMx9wxD7raNg==
X-CSE-MsgGUID: RqQFEMgcSya7V0AHYMCpDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10845732"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Nov 2026 11:37:40 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUUQT-00000001IOl-1qNv;
	Fri, 20 Nov 2026 19:37:37 +0000
Date: Sat, 21 Nov 2026 03:37:35 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] nvme-auth: switch to use 'struct key'
Message-ID: <202611210315.8aA2D5rd-lkp@intel.com>
References: <20261120-dhchap-keyring-v4-v4-3-5f8c7d9926ee@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-dhchap-keyring-v4-v4-3-5f8c7d9926ee@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_113742_968133_07A925A6 
X-CRM114-Status: GOOD (  11.89  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 68099cf27253a8c89d703a282d3d811446d9453b]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/nvme-auth-modify-nvme_auth_transform_key-to-return-status/20261120-121400
base:   68099cf27253a8c89d703a282d3d811446d9453b
patch link:    https://lore.kernel.org/r/20261120-dhchap-keyring-v4-v4-3-5f8c7d9926ee%40kernel.org
patch subject: [PATCH v4 3/9] nvme-auth: switch to use 'struct key'
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20261121/202611210315.8aA2D5rd-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611210315.8aA2D5rd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611210315.8aA2D5rd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/nvme/common/auth.c:154 function parameter 'keyring' not described in 'nvme_auth_extract_key'
>> Warning: drivers/nvme/common/auth.c:154 function parameter 'keyring' not described in 'nvme_auth_extract_key'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

