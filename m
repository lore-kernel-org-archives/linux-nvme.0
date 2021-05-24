Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0BAC2B9F7
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 21:37:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAD461417
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 21:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAD461417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZVgc/2m9MrV5dCytIGM6QF5wHIOGULs8TMoX3qTVeI=; b=iLkHfmz4qcVHY5
	lOqtceP4dzd/4ewA0lSrCO7WqX4efWBFOCPaROVb27DLWIy5P7Oshs6XVOukdFBXI1DeEOnuk7bkA
	SZ+Tp/2DZOV6R1TC75Bqyn/o2d3K20+gtA6y/BLAFb00Arfnyox7kZ94/ooULFVim8HfrWqU856xP
	cPsT2dXbL7TEdaj7rEbGO8iL7MpzDjMkMq2v8J9tGJDiOejVUPIBQkvmh0RTPSCs+P1LVLfbVtmBG
	dmNCLz9dfsPWcPJrtlg/z+sOulT/Shd5kPwOwsp7lCcznlX9XDlqZp0rYVFcDVJXX8MKXnmi1stbx
	rtsrH7gCRXIEwIxE8Zww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llIFi-001xy2-GA; Mon, 24 May 2021 21:36:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1llCM7-0012I7-57
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 15:19:00 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A0D161209;
 Mon, 24 May 2021 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621869538;
 bh=SkNbXkVBwgc7wTXmb9lPORb8aebgc6lmQgyJ83+0D64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HA+RB2+k5aBd3AqG8rp7KMJUIrR9Rw7wLo/D1eyzj/lt7oJWe5j8j4bXqS7t0S9l3
 cBnWyAqU47CypSMe/E+uOuzuR1slpdS9ivbxjL5we4SiCCQcvsg39X1HcrLbocz2o3
 5zJX77Y8o8l17ofr4m+h5gAOmPScHdAay0oIuQI+nh2abCJiG3G5ZYlRDMI/Awfnr0
 Na9SxZEokrSBRn/Iv+VxJ7+dxAQMeFUzyGjVhbkO0NZVvpw1A6uPD/4HK6xiTDfQwU
 e7swWy1clMY2VJP/VKn3RHT6sp0pgubmPkUyMwbWzeVMeo5JJpRU8BxxONyy8jZELO
 Z+r2JufSt8fUw==
Date: Mon, 24 May 2021 08:18:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
Message-ID: <20210524151854.GA3677624@dhcp-10-100-145-180.wdc.com>
References: <20210521215115.1901970-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521215115.1901970-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_081859_238222_DF589092 
X-CRM114-Status: GOOD (  15.77  )
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

On Fri, May 21, 2021 at 02:51:15PM -0700, Sagi Grimberg wrote:
> We need to select NVME_CORE.

This looks fine and matches what the other drivers are doing, but I
think a more appropriate dependency should have NVME_FABRICS select
NVME_CORE.

> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index a44d49d63968..c0826b3c617c 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -71,7 +71,7 @@ config NVME_FC
>  config NVME_TCP
>  	tristate "NVM Express over Fabrics TCP host driver"
>  	depends on INET
> -	depends on BLK_DEV_NVME
> +	select NVME_CORE
>  	select NVME_FABRICS
>  	select CRYPTO
>  	select CRYPTO_CRC32C
> -- 
> 2.27.0
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
