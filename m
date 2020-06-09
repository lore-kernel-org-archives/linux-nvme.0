Return-Path: <SRS0=KBoe=7W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41015C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 15:03:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0630C20774
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 15:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W0+CXkIY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zjRCmqdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0630C20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PZClQoHFZLMwOEcUQk1ZaPT0N6n0saWyv1gKcxsa+54=; b=W0+CXkIYqkZW1x
	Ctyd+0OV/D2c2G19bCRk5qu+717OUC2DbMy0/fV4Fvlmf+ZjoYLFHqSUTVrn6EWHjYEW6JnZUT68X
	P1BUiF11shPKfK8Kay8j+mNDrQkS37h/3+mgyVZC4Io5wpB364fIIrQaN7m4Ap8xqmLekJkgh0zE5
	NKU7PS5K/I9NLCzbVFlYFaKa4DdkjeOemnVMReb/sBVym7XMjKvCh+H8jTvAgoaKR9AfNxmgD0k1x
	fnA5EMnHC5M3TLoe/rXpiwFpM4XWf1Ez8vzfvP19i7LSxhyQgojORFJ6lMwebvWtYgSYrtew6OMIC
	qVtQRxbvT8nmXnsRrBag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jifmr-0002d4-OA; Tue, 09 Jun 2020 15:03:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jifmo-0002c8-Or
 for linux-nvme@lists.infradead.org; Tue, 09 Jun 2020 15:03:37 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E263D20774;
 Tue,  9 Jun 2020 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591715014;
 bh=mj2OFhCkkI6uu9lKNor01u8RsbnNseXBopThzshPbPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zjRCmqdV9nYDlTtasPZrWGONNbfxmZVSSuB2tnQBUGbHqeOUd9tiPch86eT8gDGGq
 3vWKqlGYXbtsPzTBkqbRx7r9easF961zz5lKrlycaFZyymXR9DRBOuwub2R7wbHN34
 M1yxI5qCIOGlttzWXIU+peDBNLAhN40rSZfmlGx4=
Date: Tue, 9 Jun 2020 08:03:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH nvme-cli] nvme-print: fix smart log temperature output in
 json mode
Message-ID: <20200609150331.GA189247@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200609145422.22386-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200609145422.22386-1-yi.zhang@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200609_080334_822669_55B26A51 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 09, 2020 at 10:54:22PM +0800, Yi Zhang wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  nvme-print.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nvme-print.c b/nvme-print.c
> index 7414280..d63b402 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -593,7 +593,7 @@ static void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid,
>  	char key[21];
>  
>  	unsigned int temperature = ((smart->temperature[1] << 8) |
> -		smart->temperature[0]);
> +		smart->temperature[0]) - 273;

I usually consider json output as something to be consumed by another
program rather than by a human, so we've not done much manipulation from
the spec defined units. It's just a serialized representation of the
structure.

If you need a more human friendly output, we can add flags to refine the
output, but we can't just change the default reporting from Kelvin to
Celsius since that may break existing programs interpreting the current
json.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
