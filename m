Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F056DC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Oct 2023 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fuhTPF2nGxyW2WW8m2ohxcVL9tICIUEqav9y02554yw=; b=0IB1uu094GbPCfSmIxPIWDGphr
	7hmJDMIckD+ZwmFQisQyMGZWRg6+QZdGzP6e55d8kKZ3xJHTzeI9+8Nr/a9z46lMSaeyjvnaX5jyR
	mvaLUtN56funrl+EbOrcynZCZKXmGKI5UgHAb+7RIPwpRYkvQKbFZTDg4hquFmt3g9rOw2AxAKGzz
	o90Qb0NkQyKyMAw+AdgypuX20iLHgrYQhXP45VMPwu0TNOhczUYDtsaA4gTCuBnr9sAzoSPsw+gT5
	tv8i8aOYVeXg300faG898UkvNnz2wzIlPYYmf6rOBlS97512npW05tZSJVYCXlwoINDZ+DqN/ahGm
	XTR1/hDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxisx-004fSQ-2k;
	Tue, 31 Oct 2023 07:09:59 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxisr-004fS3-1P
	for linux-nvme@lists.infradead.org;
	Tue, 31 Oct 2023 07:09:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD1B02186E;
	Tue, 31 Oct 2023 07:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698736190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuhTPF2nGxyW2WW8m2ohxcVL9tICIUEqav9y02554yw=;
	b=P9McitVuq1lNXVZ9peFtsmlQM2/3ghmEVt6dIFBxtBnFgaSpGV2CrqGlIb3HbzahU02XVM
	XNrNl+D8crFFmffS+PBRhpg80iyP8tPihueYno/UuahSN+zRaR471K/ylxY6KTSqUKvCAm
	s/Av0yBhaGP/9kr1sHa1KYxh0BBDLqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698736190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuhTPF2nGxyW2WW8m2ohxcVL9tICIUEqav9y02554yw=;
	b=UEo3p3f6U6i9QABLiWbDd/xSpw5kQ8ZRBZ61UtTPVpo92rY8GNXyQEhjtbOKmNmIACXhu9
	pXuL2SVY7CrCTDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BF46138EF;
	Tue, 31 Oct 2023 07:09:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lSeMAj6oQGW7FwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 31 Oct 2023 07:09:50 +0000
Message-ID: <28a41bf1-661b-47e3-8b7e-65cb64a0b8bc@suse.de>
Date: Tue, 31 Oct 2023 08:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Fix a memory leak
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231031_000953_637907_CC6960F3 
X-CRM114-Status: GOOD (  16.72  )
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

On 10/29/23 22:22, Christophe JAILLET wrote:
> All error handling path end to the error handling path, except this one.
> Go to the error handling branch as well here, otherwise 'icreq' and
> 'icresp' will leak.
> 
> Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/nvme/host/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4714a902f4ca..3c35c37112e6 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1429,7 +1429,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   		if (ctype != TLS_RECORD_TYPE_DATA) {
>   			pr_err("queue %d: unhandled TLS record %d\n",
>   			       nvme_tcp_queue_id(queue), ctype);
> -			return -ENOTCONN;
> +			ret = -ENOTCONN;
> +			goto free_icresp;
>   		}
>   	}
>   	ret = -EINVAL;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


