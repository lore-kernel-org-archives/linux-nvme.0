Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D52C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 16:43:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46392067D
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 16:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tuTa3nrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46392067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IEBcJj4i+DjGNYTCmh/kVOiL6XSQb0s7wnycTTLKvOE=; b=tuTa3nrUeaLsyiO3ja1iovoql
	tJ3gmh5VFJqInWBW/HCQGxUpUuzEWwSgEFnSf1VRKk0QLiFCXtmL1rKn2NPH2ZnaHUPE/J0WPbd7L
	1v4RoxIQiV9/GHBi6BErvbvl2cOqBXNOQCn+vDbWg6tBoLLwRG0SsVXk2DAB40HNqhyakAyOieZE9
	VX8HRza6bq9oCwEMVc7aqZ+8PY76HvihOqXKK1QTm2SKYP1Kat9Zf186UWru9oy/c+F9+hAh8X7oS
	nVa0asEYbEJZbOa/G881J5KV55hdbvQzqazf/ibQ0BVDrloYMCzqrsdSLwkwA/TuKCjFdoFARSwzT
	7C7MBqffw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jv1Xf-00027g-7G; Mon, 13 Jul 2020 16:42:59 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jv1Xc-00026X-IO
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 16:42:57 +0000
IronPort-SDR: QkZ+ISy17sY2Z55RpBCJW0+mL+GwtEuF+4YSedv8bV93edUspicVQdYT8/olfToKV+DTXygdDL
 v15qEj0QaYDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146141286"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; d="scan'208";a="146141286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 09:42:53 -0700
IronPort-SDR: dQgS6KRxXnZehQ6xSY5bScIB1NbPYyLT4+zopdkg5S3fiuf5XsC0QhqYiX7EJ72qjhdGaDOB1f
 Vf9essvY4UOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; d="scan'208";a="485064335"
Received: from rrajashe-mobl1.amr.corp.intel.com (HELO [10.212.135.176])
 ([10.212.135.176])
 by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2020 09:42:52 -0700
Subject: Re: [RFC PATCH 09/35] nvme-pci: Change PCIBIOS_SUCCESSFUL to 0
To: "Saheed O. Bolarinwa" <refactormyself@gmail.com>, helgaas@kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-10-refactormyself@gmail.com>
From: "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <0762f646-90a1-217c-4e4b-6168d85bb08a@intel.com>
Date: Mon, 13 Jul 2020 10:42:51 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200713122247.10985-10-refactormyself@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_124256_748848_B170A526 
X-CRM114-Status: GOOD (  17.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, skhan@linuxfoundation.org, bjorn@helgaas.com,
 linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On 7/13/2020 6:22 AM, Saheed O. Bolarinwa wrote:
> In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
> Their scope should be limited within arch/x86.
>
> Change all PCIBIOS_SUCCESSFUL to 0
>
> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b1d18f0633c7..d426efb53f44 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1185,7 +1185,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
>  
>  	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
>  				      &pci_status);
> -	if (result == PCIBIOS_SUCCESSFUL)
> +	if (result == 0)
How about simplifying the check to if (!result)?
>  		dev_warn(dev->ctrl.device,
>  			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
>  			 csts, pci_status);
Thanks!
Revanth

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
