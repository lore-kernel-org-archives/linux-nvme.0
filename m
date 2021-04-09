Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C795C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 07:20:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A7161107
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 07:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A7161107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qJYk+bJ8wOvU3pPzfl/mdkGPfRQbO4vTvPO9nfL2sAU=; b=L05yjy5UbsL1Xcc4kclsz3KUE
	z6m3NCMgk485LNTn3RVLnQLP1Io5rKGRSqWJTt3X6wpigN5XbW65WNiyGlOsVT9gsdkgO4RlfFce+
	gwrmjmj3W5T3Caam+AIusLLkC13xipor74kznunViQtsW3g4ZcZfWtFA7FNyWJbFmovXXEJyCSV/w
	ulDEhSvmXpysGCx1K8F7KIsbKfKf2ehCTFUE0yy6t+WDWL8kceJgMGpz3ZmqqT3wUOEKU2FK8uI/7
	bHAZZcfi1Fnq94PqHlE83QwuBPPMakt5/PCJizU9E9EAUJ28fGmSUOk/zMWTSzglVkrvtpQV5l6Jp
	f50QjC11w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUlR7-00AQ2s-Az; Fri, 09 Apr 2021 07:20:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUlQe-00APvm-9t
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 07:19:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Rp4NWw/QMegUUXpe8iWkrZqwB2foWPI0qM3c87Rs/aM=; b=AcqNFCbcS3uGdX7a7pucWbEP4V
 NZIJifopuZ7xfE5mjEnXc8Bac+k6taJjYsv1unGrm8ad2ygLyl5uksdQl54VGvjSEQDjQHM7dVhk3
 hwYQrjXYEnzOhisp0npQGPfXpRp3lzAHnYY0i92fWaRVAsoO2TExH0duqIz95tvOFo/9bcURwFxTw
 Ubq8e2q8u1bpTjtGBsGOnsczV3KLoqSQxyfKjN+8WW+BINsXl5xSv3+pprjx87yTkQyCxuCAisJHG
 nRS5ouYGWj6FQRO6LQPkqkxlj15dcowcZ62ydNKrAU8yhUfhKMc+6xJp0mQepre5KQp1MfsCeHlvs
 XCKA4cDA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lUlQH-00HYnh-FO; Fri, 09 Apr 2021 07:19:28 +0000
Date: Fri, 9 Apr 2021 08:19:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peng Liu <pngliu@hotmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, Peng Liu <liupeng17@lenovo.com>
Subject: Re: [PATCH] nvme: fix APST error for power latency tolerance
Message-ID: <20210409071921.GA4184967@infradead.org>
References: <OSYP286MB0181647E6B1C99AF64C0803DC6649@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
 <20210323162321.GA2446196@infradead.org>
 <OSYP286MB0181DD097BC42806382473BAC6639@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
 <20210324075824.GA2648357@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210324075824.GA2648357@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 24, 2021 at 07:58:24AM +0000, Christoph Hellwig wrote:
> On Wed, Mar 24, 2021 at 10:38:12AM +0800, Peng Liu wrote:
> > On Tue, Mar 23, 2021 at 04:23:21PM +0000, Christoph Hellwig wrote:
> > > On Tue, Mar 23, 2021 at 03:31:33PM +0800, pngliu@hotmail.com wrote:
> > > > From: Peng Liu <liupeng17@lenovo.com>
> > > > 
> > > > Clear apsta so that nvme_configure_apst() does not execute
> > > > nvme_set_features(), which will fail because admin_q is either not set up
> > > > yet or no longer available at the time of nvme_uninit_ctrl() being called,
> > > > and this leads to the error message "nvme nvme0: failed to set APST feature
> > > > (-19)".
> > > > 
> > > > Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")
> > > 
> > > How did you get into this situation?  For PCIe nvme_uninit_ctrl is
> > > only called at the end of ->remove and ->delete_ctrl, so how do we end
> > > up in nvme_configure_apst after that?
> > 
> > I got into it with nvme surprise and non-surprise hot-removal tests.
> > Below is the stack ftrace result for nvme_configure_apst under the
> > surprise hot-removal, and it is similar for the non-surprise hot-removal.
> 
> Ok, looks like dev_pm_qos_hide_latency_tolerance calls back into
> nvme_set_latency_tolerance, which is a little .. unexpected.
> 
> Does this patch work for you?

ping?

> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0896e21642beba..d5d7e0cdd78d80 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2681,7 +2681,8 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
>  
>  	if (ctrl->ps_max_latency_us != latency) {
>  		ctrl->ps_max_latency_us = latency;
> -		nvme_configure_apst(ctrl);
> +		if (ctrl->state == NVME_CTRL_LIVE)
> +			nvme_configure_apst(ctrl);
>  	}
>  }
>  
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
