Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FBDCD484E
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 23:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+m01i7ONG4TcxT12L5Ah13VDmeo3+u4TTYYf5GcTZ8s=; b=ELeWN2puwpOPOIUz6zUCjyCBbO
	HHgz3Q6920dLmE4UE4oPoI7binzNGf0SPzTJiHcXF7adDbtmVqtV2X4es8EwqDd2DS33MdcnCr0hD
	ePxB7nhpag6Gi2CfgrIEVGnmGfqVv7SKV0qNrQLM1t2Hr/+u+LfxMrdjAwNboTnl1sK+09VTNne22
	ZADMW8EvSSPs83VPhB0/kks2rahYs1kzc6ZcQr735E9KgC81PRzZ9FmnrgSHWmBBTRurtsHPTG1aU
	N6fXukKB6GoDSUFYJNhrqAhKTZcisKtNESsXJGGUGr1caaHcxNm/Xfw923ehJc+kl/I/xbRmlfJR1
	BvUWfGmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMZnO-0000000EzVO-1pYk;
	Mon, 11 May 2026 23:12:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMZnJ-0000000EzV9-0Cxi
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 23:12:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 313FE60103;
	Mon, 11 May 2026 23:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1C9C2BCB0;
	Mon, 11 May 2026 23:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541131;
	bh=aOERcIU/jFHzO/xWFj9O/Ookh4+6ChCIXRn2aWz3RTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OL8HT2h6+n4/D4+JUu1dUwZOLtY9GRv8PnIih+t2qYnRv9j5+m1F4LgmZya+pjDZ5
	 jePgg4N2em5p/e+SvVGJWymEKSnxM6Q+6HlMu1spw32bph9fxTVfIEBkCXzAzNsnit
	 nQ5zITK/CPhW/z17EoO71kDWUZhIC33JAGmqk0IysqnH0GYh///xKXFx+TozAOPixp
	 lLEzbxDUrqY2hImsfZ5F2LNITY9i2SHthVSQX/wYGjn0PaWbE2VndTyhEwMqNfJ9h8
	 JKVoj2TXzAtdqIZPdlv9eOUVNjJ0q3hgpw6DQvqaedvUo6Ijlo7X56O4gVve/4XtRi
	 tS32BBAKiJ57w==
Message-ID: <f8c4bebd-464f-4a1f-9d11-5f3a6b2b3b30@kernel.org>
Date: Tue, 12 May 2026 08:12:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: handle rejected keys for secure concatnation
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 alistair.francis@wdc.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260511005454.2486599-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260511005454.2486599-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/11/26 09:54, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 

In the title: s/concatnation/concatenation

> The NVMe-TCP specification [1] states that if the PSK retained or
> generated is not available on the subsystem, the TLS 1.3 handshake shall
> be aborted with an unknown_psk_identity alert and the connection be
> closed.
> 
> Currently, when an unknown_psk_identity alert is sent from an endpoint,
> tlshd returns EACCES as the TLS error. On subsequent reconnection
> attempts, we fail with the same error because we keep attempting to
> connect with a stale key. This may occur if the endpoint experienced a
> full reset and lost its PSK.
> 
> With support in tlshd to return -EKEYREJECTED when an unknown_psk_identity
> alert is received, the kernel can now detect this condition and revoke the
> current tls_key. This allows the subsequent reconnect to perform
> re-authentication via DHCHAP to generate a fresh PSK.
> 
> [1] https://nvmexpress.org/wp-content/uploads/NVM-Express-TCP-Transport-Specification-Revision-1.1-2024.08.05-Ratified.pdf
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  drivers/nvme/host/tcp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 15d36d6a728e..eff68eb7a5fe 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1767,6 +1767,17 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>  			dev_err(nctrl->device,
>  				"queue %d: TLS handshake complete, error %d\n",
>  				qid, queue->tls_err);
> +
> +			/*
> +			 * Key maybe stale, revoke it such that on a subsequent

			 * If the key is stale, revoke it...

> +			 * reconnect, we will generate a new PSK.
> +			 */
> +			if (queue->tls_err == EKEYREJECTED && qid == 0 &&
> +			    nctrl->opts->concat && nctrl->opts->tls_key) {
> +				nvme_auth_revoke_tls_key(nctrl);
> +				dev_warn(nctrl->device,
> +					 "qid 0: revoking stale key\n");
> +			}
>  		} else {
>  			dev_dbg(nctrl->device,
>  				"queue %d: TLS handshake complete\n", qid);


-- 
Damien Le Moal
Western Digital Research

