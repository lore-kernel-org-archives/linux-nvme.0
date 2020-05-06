Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30005C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 07:11:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36D020721
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 07:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aWfHgrnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36D020721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JJR4BU6fwyovKgcskoWeOmtHMuqGAg8X1nbSfUnoI8E=; b=aWfHgrnvFFRKVu
	hbL1p1bzEINUIABBH6gq/plBL+MJbkfi0kSH43nBQTUu6oEGrkNy63hirYfwCO31o+mLph/P85J9n
	ORJthkq++Nu6/f+gvYGlGJ5s7WE1Vf+h6hprEfdmb21CJXIJggd2Vk/qSfUx05TWcbPjhye+JjyMd
	leLbcZU/Q+NBA2JH/iJ+sh4Qq99oJGnCHkZFMb+gfDpf97zu6c5yBb04Mpjg+BAo8bfWFQPJnPJlV
	aNjpdfG+1mhQFpj8Ch579XdPHNFIUxtp+90ZzS+LcE0xspDrpz22ehKX8rh9kzgOO5fQGUenLckMA
	LmTDWqk5dMQWpUQE9znA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWEDE-0003LA-57; Wed, 06 May 2020 07:11:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWEDB-0003KW-AS
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 07:11:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0E22768C4E; Wed,  6 May 2020 09:11:19 +0200 (CEST)
Date: Wed, 6 May 2020 09:11:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] nvmet: add helper to revalidate bdev and file ns
Message-ID: <20200506071118.GA12145@lst.de>
References: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
 <20200506014629.39509-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200506014629.39509-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_001121_508088_2E7A7920 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 05, 2020 at 06:46:27PM -0700, Chaitanya Kulkarni wrote:
> -int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
> +bool nvmet_file_ns_revalidate(struct nvmet_ns *ns, int *retp)
>  {
> +	loff_t oldsize = ns->size;
>  	struct kstat stat;
>  	int ret;
>  
> @@ -22,7 +23,11 @@ int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
>  			  AT_STATX_FORCE_SYNC);
>  	if (!ret)
>  		ns->size = stat.size;
> -	return ret;
> +
> +	if (retp)
> +		*retp = ret;
> +
> +	return oldsize != ns->size ? true : false;

I find the calling convention really weird.  I'd always return the
error over the bool, as a bool *size_changed is a lot more descriptive.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
