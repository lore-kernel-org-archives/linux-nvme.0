Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268E7C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ISxSsa35zicnwR8CHDBxXUC1WXX08GIzXhpcSZEyQQg=; b=kPXtJGepiqpc6+z6CVGjbrqEUU
	TYjK9HAXKJvIaISuYVO/FqwtGrV4rnk/qc8h1YRzgmgvjxroAsQ/Bfz98qgHrzmZp1tNBBuRbO298
	1SxWdIFfiF5sqI5+tyILZTT09GMe2Fx7s78wF80g2SzBlmQgyyigckEbwcVgtL28cfEPrJsm54Cbt
	1JHyPMkV4gjvRnwKNLz8LExd2Si1z6bcsLDrb5g6oEeuv6ALGDKKZUj1zBofOVO6jIzh/jHg6GFEi
	TgR/YSswiBirH4mx3ayyRfUKo/Z58QtUeq7DdwclDlwBj6z/td7mZBV3V84pFnXFFTls9hZrxnq4f
	tcTfX4wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNdP-006ROW-Li; Tue, 25 Oct 2022 17:22:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNdM-006RNY-Qv
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:22:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53A6422009;
	Tue, 25 Oct 2022 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666718553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISxSsa35zicnwR8CHDBxXUC1WXX08GIzXhpcSZEyQQg=;
	b=xVyYg+iPwuXh6wZ0H5+ZdNmrZZTHHCd0hFU/wK5wubnxEsBMkObfwWAUjIItezodsQzpup
	ZKyEgs7eQhnehyEhWBLFsGdkdupKotg74HwljyMMtwVOq7LsATwlEvq1CzGUyMtUN56ppc
	4wRuiH4CIP4wqpkvFx9P5C0Q7tytzV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666718553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISxSsa35zicnwR8CHDBxXUC1WXX08GIzXhpcSZEyQQg=;
	b=Mz1NomA9Sv3Sc8mp4CKfo1qi4DbsHISgKvM6icvSd8YrtwChXZdAAlRS56D8/mqPc/1Meb
	m6kOmWmN2xKQIsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34A0213A64;
	Tue, 25 Oct 2022 17:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LEa8C1kbWGN9NgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Oct 2022 17:22:33 +0000
Message-ID: <07667003-2a31-8c82-895d-aa520fb4968c@suse.de>
Date: Tue, 25 Oct 2022 19:22:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/6] nvme-auth: don't re-authenticate if the controller is
 not LIVE
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-4-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221025134330.1028352-4-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_102237_059051_6E3F7B58 
X-CRM114-Status: GOOD (  18.97  )
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

On 10/25/22 15:43, Sagi Grimberg wrote:
> The connect sequence will re-authenticate.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 734928282d3e..93c0fc71bc7c 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -939,6 +939,13 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, dhchap_auth_work);
>   	int ret, q;
>   
> +	/*
> +	 * If the ctrl is no connected, bail as reconnect will handle
> +	 * authentication.
> +	 */
> +	if (ctrl->state != NVME_CTRL_LIVE)
> +		return;
> +
>   	/* Authenticate admin queue first */
>   	ret = nvme_auth_negotiate(ctrl, 0);
>   	if (ret) {

Hmm. That is only part of the story; the controller can be reset at any 
time during the workqueue function.
Doing so will invalidate the digest hash, but we only find out about 
queue being invalid once we _send_ data. So we crash in 
skb_copy_datagram_iter().
I got a patch here somewhere (which is still under testing, hence I 
didn't send it off), but can do so now if requested.

Cheers,

Hannes

