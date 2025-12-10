Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3B6D3E783
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y7NY5F74myVmno/JpsbmuG3c55wLr8uglfag8JskG50=; b=dJSZTuSjJqsa2d01RPilxq4JSw
	VUofmJqFR123IfWIO62HryC5UfHFGqvoexHJ/j6SNi9A5OAcMbSCSt+m8YO5Y+BBY7gsDco2IlCgS
	MD+mK7xvbI5Pml3/6SsQz/tDOahV+ONlwkXz0ECuqRl5NIcmQWu2pGKVkiqwIry7iGXoXHEtBY/tW
	rPWnAcrCCMN3FKvdickTrEn79vz8AYj/TGFhIsDafw6Q1ruWtwokiuuHlt9qoDy45L2dDqSbCzMtZ
	EY+gQpsFWKw+jbgULTx8kqe3z0sIlJAWmIOzPvGB91bCMh4Q5F7Dj1E0lnyKo/5F1nsy29yfZbCco
	FlRWhPIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTTm8-0000000FzC0-063G;
	Wed, 10 Dec 2025 23:39:16 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTTm5-0000000FzBa-03iS;
	Wed, 10 Dec 2025 23:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765409953; x=1796945953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CqZoGTVWzCk+WErLN8DYaHT4p5f2ean/CXKGL2NXVM4=;
  b=Vpv1J9FTliuGShpAxr/f+V9+8uadTH9waTr2jsLmLQ9gkjBkW42SsqRU
   VdXecfWV+uXg5uNbgl8JrubcHqlgoLRvZG3erj0VMREXMXZkeP4RgMhB9
   CS1J6OoxiWaB/VWgeyTlRk9CUuKdwyX8v4wXtDsu6zbg0xwrYaT6lsYAv
   7dpbI1DPshSB3HQElstygA+zMEiZMg7J9XOdfQMRZiesB8RwvPzVFwcUN
   B3HFQ7rYc5ZX2nxUxxRVW8U5u7MWqpianEsFVvuzLJ3kI9iuSnT49F0BM
   38VOYfE7D+xf8xix6phaVVWlrSpgTuzuiezNb+KTuM7wuSpgA13IHefzM
   Q==;
X-CSE-ConnectionGUID: kYSeaELRSPG9UWgSG3/dtg==
X-CSE-MsgGUID: AsZ2/FzcSkipTqz/EvD70Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78501429"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="78501429"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:39:12 -0800
X-CSE-ConnectionGUID: KpQ53LaCR92a/lE3dY93+A==
X-CSE-MsgGUID: yM9OGlZbRkmqVgjyMNGu0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="227300278"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Dec 2025 15:39:04 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTTlu-000000003sH-0itl;
	Wed, 10 Dec 2025 23:39:02 +0000
Date: Thu, 11 Dec 2025 07:38:13 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 8/8] crypto: atmel: Use
 dmaengine_prep_slave_single_config() API
Message-ID: <202512110702.EhO0gmFG-lkp@intel.com>
References: <20251208-dma_prep_config-v1-8-53490c5e1e2a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-8-53490c5e1e2a@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_153913_120046_E92E8928 
X-CRM114-Status: UNSURE (   9.59  )
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

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bc04acf4aeca588496124a6cf54bfce3db327039]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-Add-API-to-combine-configuration-and-preparation-sg-and-single/20251209-011820
base:   bc04acf4aeca588496124a6cf54bfce3db327039
patch link:    https://lore.kernel.org/r/20251208-dma_prep_config-v1-8-53490c5e1e2a%40nxp.com
patch subject: [PATCH 8/8] crypto: atmel: Use dmaengine_prep_slave_single_config() API
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251211/202512110702.EhO0gmFG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251211/202512110702.EhO0gmFG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512110702.EhO0gmFG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/crypto/atmel-aes.c: In function 'atmel_aes_dma_transfer_start':
>> drivers/crypto/atmel-aes.c:798:13: warning: unused variable 'err' [-Wunused-variable]
     798 |         int err;
         |             ^~~


vim +/err +798 drivers/crypto/atmel-aes.c

cadc4ab8f6f737 Nicolas Royer   2013-02-20  788  
bbe628ed897d72 Cyrille Pitchen 2015-12-17  789  static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
bbe628ed897d72 Cyrille Pitchen 2015-12-17  790  					enum dma_slave_buswidth addr_width,
bbe628ed897d72 Cyrille Pitchen 2015-12-17  791  					enum dma_transfer_direction dir,
bbe628ed897d72 Cyrille Pitchen 2015-12-17  792  					u32 maxburst)
bbe628ed897d72 Cyrille Pitchen 2015-12-17  793  {
bbe628ed897d72 Cyrille Pitchen 2015-12-17  794  	struct dma_async_tx_descriptor *desc;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  795  	struct dma_slave_config config;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  796  	dma_async_tx_callback callback;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  797  	struct atmel_aes_dma *dma;
bbe628ed897d72 Cyrille Pitchen 2015-12-17 @798  	int err;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  799  
bbe628ed897d72 Cyrille Pitchen 2015-12-17  800  	memset(&config, 0, sizeof(config));
bbe628ed897d72 Cyrille Pitchen 2015-12-17  801  	config.src_addr_width = addr_width;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  802  	config.dst_addr_width = addr_width;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  803  	config.src_maxburst = maxburst;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  804  	config.dst_maxburst = maxburst;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  805  
bbe628ed897d72 Cyrille Pitchen 2015-12-17  806  	switch (dir) {
bbe628ed897d72 Cyrille Pitchen 2015-12-17  807  	case DMA_MEM_TO_DEV:
bbe628ed897d72 Cyrille Pitchen 2015-12-17  808  		dma = &dd->src;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  809  		callback = NULL;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  810  		config.dst_addr = dd->phys_base + AES_IDATAR(0);
bbe628ed897d72 Cyrille Pitchen 2015-12-17  811  		break;
cadc4ab8f6f737 Nicolas Royer   2013-02-20  812  
bbe628ed897d72 Cyrille Pitchen 2015-12-17  813  	case DMA_DEV_TO_MEM:
bbe628ed897d72 Cyrille Pitchen 2015-12-17  814  		dma = &dd->dst;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  815  		callback = atmel_aes_dma_callback;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  816  		config.src_addr = dd->phys_base + AES_ODATAR(0);
bbe628ed897d72 Cyrille Pitchen 2015-12-17  817  		break;
cadc4ab8f6f737 Nicolas Royer   2013-02-20  818  
bbe628ed897d72 Cyrille Pitchen 2015-12-17  819  	default:
cadc4ab8f6f737 Nicolas Royer   2013-02-20  820  		return -EINVAL;
cadc4ab8f6f737 Nicolas Royer   2013-02-20  821  	}
cadc4ab8f6f737 Nicolas Royer   2013-02-20  822  
c8695132080931 Frank Li        2025-12-08  823  	desc = dmaengine_prep_slave_sg_config(dma->chan, dma->sg, dma->sg_len,
c8695132080931 Frank Li        2025-12-08  824  					      dir,
c8695132080931 Frank Li        2025-12-08  825  					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
c8695132080931 Frank Li        2025-12-08  826  					      &config);
bbe628ed897d72 Cyrille Pitchen 2015-12-17  827  	if (!desc)
bbe628ed897d72 Cyrille Pitchen 2015-12-17  828  		return -ENOMEM;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  829  
bbe628ed897d72 Cyrille Pitchen 2015-12-17  830  	desc->callback = callback;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  831  	desc->callback_param = dd;
bbe628ed897d72 Cyrille Pitchen 2015-12-17  832  	dmaengine_submit(desc);
bbe628ed897d72 Cyrille Pitchen 2015-12-17  833  	dma_async_issue_pending(dma->chan);
bbe628ed897d72 Cyrille Pitchen 2015-12-17  834  
bbe628ed897d72 Cyrille Pitchen 2015-12-17  835  	return 0;
cadc4ab8f6f737 Nicolas Royer   2013-02-20  836  }
cadc4ab8f6f737 Nicolas Royer   2013-02-20  837  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

