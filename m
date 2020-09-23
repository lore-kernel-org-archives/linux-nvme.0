Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17367C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 17:35:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D122054F
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wXTRan0d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXTdt4oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D122054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p/K0JXda4lLuVMO/QjuWNVESC4eBUcpJVHBHgmotyBA=; b=wXTRan0dKXJa6zNJ+HohHZn/L
	wRl8ogKTmCox49kTx9ZgS0j9nce+eedz7f325bgfEiCMTrYTMme0kuhPiSmOQRGhdtN7Om7LiHk3l
	uA26pg46OVQTbDmUSQfXKTVeVwJZB3hN6RXr1KrzKxRN8pCKOgHo0CbaUDpfRZOsS5UNtNxCF53CU
	o9mbhDmXNtyDa1FpX8gz4GZXsgv7GYr0xJqKqY+oXXgpPQqfdYr+jCNnNNt5gQQ1jh1kZ0XGjF18P
	JscJxKoFsdZ50aKd4DZntGC8nFOCqsau4kdjv4lrv0YZKlytnJ7YM3KsGafkSSOc3OtX67H6Gjwo0
	aCI7ZkdIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL8gK-0003bM-SH; Wed, 23 Sep 2020 17:35:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL8gH-0003as-CQ
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 17:35:50 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A34D2054F;
 Wed, 23 Sep 2020 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600882547;
 bh=Lwi1WrsoTZg8FeZIgUAJguEk1u4SYfl/vaUKxWvDX1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TXTdt4oUbssB66B0Jokg37P7X/DjOsET0mg7sDyHt6DoPDLkBhRF/Zu6h4pDGPt/g
 YBOupflI6FtiajpKMrJidHdUaVTCA4lUsQ2DCqCtYyJqBcoyKy+Ux4qIp0/m6U5dqi
 F9x5E3uJYbV5TdMSdLRbjeJg6lG7zohHcvz1vq60=
Date: Wed, 23 Sep 2020 10:35:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-core: don't use NVME_NSID_ALL for cmd-effect
Message-ID: <20200923173544.GA4036936@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200922194938.51845-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49653CBA4B13CC2595F9205D863B0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49653CBA4B13CC2595F9205D863B0@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_133549_515600_8D4ACEBE 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, Huai-Cheng Kuo <hh81478072@gmail.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 22, 2020 at 09:04:36PM +0000, Chaitanya Kulkarni wrote:
> In the function nvme_get_effects_log() it uses NVME_NSID_ALL which has 
> namespace scope. The command effect log page is controller specific.
>
> Replace NVME_NSID_ALL with 0x00 which specifies the controller scope
> instead of namespace scope.
>
> Reported-by: Huai-Cheng Kuo <hh81478072@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209287
> Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")

This is actually the wrong fixes tag. The code was simply carried
forward from 84fef62d135b6.

But otherwise, yes, this looks correct.

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9beb9c94eeef..0d4713307724 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3041,7 +3041,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>  	if (!cel)
>  		return -ENOMEM;
>  
> -	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CMD_EFFECTS, 0, csi,
> +	ret = nvme_get_log(ctrl, 0x00, NVME_LOG_CMD_EFFECTS, 0, csi,
>  			&cel->log, sizeof(cel->log), 0);
>  	if (ret) {
>  		kfree(cel);



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
