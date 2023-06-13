Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27176EB64D8
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5FZ/f7Lv4BUWL2A4XNfliJq8d1Hmw6gTiO1jD6Tohrg=; b=af9cJwzt0qY4XBQqZwpHyENN0M
	Ab8NOQgBe13Jkdw/UuJtOwuqHp7fAfsNOxr02KfMx6cfT0oNxm8qHfVvVB1PrV+dAsS0eOGGb91Cu
	XTLthGKGEAFdS1zf/4Ks7D+FDReXPgs8o4Y7aoOmYppVxTdEG7LZ4JPAOdeWIChI0dpEWO5bHMxqw
	wnpp28ogilNMgWY5mne8CGA1y3eTEzFhY1jOexJFcOMJxE6Ax2ej8d45/RIO+y9p7j79+QZAlUa5O
	mo/6ws+u5DceI9bjuI2pbwDBOkPXPs2zW/dzs9wUb7vROkGVEO+FvjyfJe1c+4LtK7gKyePxy6JLz
	1DOiTi/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9C4f-009Hxz-0J;
	Tue, 13 Jun 2023 22:01:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9C4Y-009HwA-1V
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 22:01:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3F269611DF;
	Tue, 13 Jun 2023 22:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B10C433C8;
	Tue, 13 Jun 2023 22:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686693661;
	bh=0I7334PO3KlCPVruC02Cf0E2A+sX+5P5HJ++VK5onO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDJ/b0RRB7OAvOYGZBtBVWVaKUZj0m5+j97KXL+PHWearsMKE++Mdl6Fn+VHXQT8f
	 CPByRL1GZdFelCevRm0KzvPwkhW09KWZSmbOmkPc2NHAngGDXqpOCGpnwaZ4MzC9tu
	 dFswHr7Dfpmf+18pKNCotJa7VXW/kr0kh13DtmxUEsjz4mmASpTt6Qscd0iHQaDqgp
	 78boo8UipZXnvql7gLp44kxFsUGWK8QRM08ezJESS1GW2jDXuILdASkMM7DjXbYSLr
	 tEn894faFXSP7yR4Z+CTgedMeeo3F4Y/LSgRuCXYvF/FrP3t87R2LkVMS8X1s5y1Nj
	 A1zhPeMsy+zHg==
Date: Tue, 13 Jun 2023 16:00:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, leit@fb.com,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Print capabilities changes just once
Message-ID: <ZIjnGiMbih0sjn3g@kbusch-mbp.dhcp.thefacebook.com>
References: <20230613175538.331639-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613175538.331639-1-leitao@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_150106_671363_39E49E08 
X-CRM114-Status: GOOD (  20.07  )
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

On Tue, Jun 13, 2023 at 10:55:37AM -0700, Breno Leitao wrote:
> This current dev_info() could be very verbose and being printed very
> frequently depending on some userspace application sending some specific
> commands.
> 
> Let's turn it into a dev_info_once(), since it is not useful to know
> about it all the time.

This looks good to me. Vendors sometimes put unnecessary effects in the
log, and spamming the same recommendation to repeated operations isn't
going to be helpful. I expect anyone who knows what they're doing can
consult the effects log directly and take appropriate action on their
own.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3ec38e2b9173..459e5a84e596 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1134,7 +1134,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
>  		mutex_unlock(&ctrl->scan_lock);
>  	}
>  	if (effects & NVME_CMD_EFFECTS_CCC) {
> -		dev_info(ctrl->device,
> +		dev_info_once(ctrl->device,
>  "controller capabilities changed, reset may be required to take effect.\n");
>  	}
>  	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
> -- 
> 2.34.1
> 

