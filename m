Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC39AD3399B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aVIfM6ADLRrW2ddhkhRN1AjjS03IN19K19H+CtsbWaU=; b=Qh4dcgatUvTOvxjsTbmWkr2rCW
	cM2gRXSb0Y8UDcjA3NN6LXqaCbIWTwE0fokJuCBuamLAGZ/AW9woMsIrapLzi6IyCUTc3EnO9h/0I
	8WTiRJoPIiLaUPu/iguN5/ZYAw5i5ERikOG2cafWVsWiIqSa/zLsTvPerCMGigPf3HbFNEuBRNdvd
	Ak92naS0k+zYMaKRS0xJOZm8GkY6A8YRPSzFY+2vLLMLf1vWcKIss0iGzu+NkBhTxiFbLC4/BNgBE
	2LCBctKwtkW8iacI2E/1aDtLs3+02AHJnCe2mLpU2iOzv1onrWacauICmx8AS/sa8Bqs3is1ntitr
	9fp3bCZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5SkU-0000000BVwd-1fsh;
	Mon, 28 Oct 2024 16:37:46 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5SMu-0000000BS8q-1Xhv
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 16:13:25 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Xcdj53kxVzlgVnY;
	Mon, 28 Oct 2024 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730131990; x=1732723991; bh=aVIfM6ADLRrW2ddhkhRN1Ajj
	S03IN19K19H+CtsbWaU=; b=W0dqk1DsslaMtQqRUmYfCegGOqGHrqnDrBsmojNg
	gIK38JxDgmg9hSczFGVpBQ+VMchq05YeATWBuU/ttAFAxocaqf0NvdPrfjsP+jvB
	sNphj7PLtS9+uCjWq9gDoR6/HZ52a+D9FFe3Eerfk44lAlErzTVCIjRUrmK1bSih
	Iy3M1dfEs4ejypA41t9GfZYJ3tE13m83o+JpgpPAiFl5PB9ZpmcwBzfBuWGqKIJp
	SCnmsX/A3fuIqK+HW/thaWRFwjddUyjB+06oy94SByPou5AkmgfOOreyiyADV7tP
	t9jRAePD4uGb1SHVlYx5E6tnUZYSAHi0/DirZru94rycow==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EpRxxZ74yApD; Mon, 28 Oct 2024 16:13:10 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xcdj06BCKzlgMVd;
	Mon, 28 Oct 2024 16:13:08 +0000 (UTC)
Message-ID: <e83cfc72-029f-4ab1-b8e4-56732585e9fd@acm.org>
Date: Mon, 28 Oct 2024 09:13:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 7/7] scsi: set permanent stream count in block limits
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241025213645.3464331-1-kbusch@meta.com>
 <20241025213645.3464331-8-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241025213645.3464331-8-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_091324_507274_8382A1F5 
X-CRM114-Status: GOOD (  15.22  )
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

On 10/25/24 2:36 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block limits exports the number of write hints, so set this limit if
> the device reports support for the lifetime hints. Not only does this
> inform the user of which hints are possible, it also allows scsi devices
> supporting the feature to utilize the full range through raw block
> device direct-io.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/scsi/sd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index ca4bc0ac76adc..235dd6e5b6688 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3768,6 +3768,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
>   		sd_config_protection(sdkp, &lim);
>   	}
>   
> +	lim.max_write_hints = sdkp->permanent_stream_count;
> +
>   	/*
>   	 * We now have all cache related info, determine how we deal
>   	 * with flush requests.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

