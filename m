Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C8DD3C52A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y5HOoOD5dCWDgLmk7gnzsDtvXXjrCmmDUUN4mUhZvOE=; b=rMDBDqREa5gsWOu8T9jgMMXfSv
	LP8VsyFW8kAb3RNXrKpenLsqoalSCXhx9sgL2J0B6LDSGv5qTn8JoXNGbJou/4AnSsnd9/iMIl4b5
	QpbLyC0nkpBHkFgCrS5ByDl4Zx90KktJf3jzMnMt9wWs6W+AIcDuEsdg7phADwL9BUiM0gpXD5JyH
	wwS7QwMG2G/9JumPbANEgXGJKKmSoceHyxbS+cjsE8U9qDbzWF5zV/H+R8jvfMcd7TPbTLMC0akGs
	uZyBb55k3MLps3glUrEGDs/m1APB/kpf8gof7Pw420Knhlr1j4VzXMj32fmouWH8ETQHGPlbdnuzp
	im2bFBeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1USv-0000000Fjsx-26Te;
	Thu, 17 Oct 2024 17:39:13 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UPy-0000000FjUz-3zUL
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 17:36:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XTw3t0c8SzlgTWG;
	Thu, 17 Oct 2024 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729186567; x=1731778568; bh=Y5HOoOD5dCWDgLmk7gnzsDtv
	XXjrCmmDUUN4mUhZvOE=; b=k/yKAOpllTs1aorUwKoqjbPubqkTfXDSq5r+te/e
	vchjxecPfmCpdJjA94eKwMaJc3PcpTo2O3gScyUVRKUoHXRXmgjYxcRrfUuK8iid
	hvF6oEUVX86E8hZp6QjYVACG+ZiFd//WPt6Af4n6jeb5pqKWFD85Lt75b1jyYtlR
	GzqMqSb+7r8WeHZLEFy/MpRQf4Yku5jswOw9WzJ09T9eG5fCJH9GaYqXXzSm6WHJ
	vZPp9D256biqpYkDoybKXHTLRak3e1jKosuF0xq2etNH0W5NDztMYabPn1cT3VW1
	3nS36bmjzBlRHRbQuO9BfXXSRxut1yEaS8t7qeRe5yET1w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id I722kBlHhm0n; Thu, 17 Oct 2024 17:36:07 +0000 (UTC)
Received: from [IPV6:2620:0:1000:2514:f052:5dba:b913:ed45] (unknown [104.132.0.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XTw3n4ty3zlgTsK;
	Thu, 17 Oct 2024 17:36:05 +0000 (UTC)
Message-ID: <86834982-054c-426c-b70b-73740b6b8ed1@acm.org>
Date: Thu, 17 Oct 2024 10:36:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-loop: set blocking flag
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, hch@lst.de, Keith Busch <kbusch@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20241017172052.2603389-1-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241017172052.2603389-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_103611_038901_1A5A5A71 
X-CRM114-Status: GOOD (  16.09  )
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

On 10/17/24 10:20 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Commit 505363957fad ("nvmet: fix nvme status code when namespace is
> disabled") introduced a mutex lock in the io path for target. The loop
> target connects this to the blk-mq submission side, so it requires the
> blocking flag set so that queue_rq doesn't happen inside an rcu context.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/loop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index e32790d8fc260..77dd809fe4507 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -479,7 +479,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
>   static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
>   	.name			= "loop",
>   	.module			= THIS_MODULE,
> -	.flags			= NVME_F_FABRICS,
> +	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
>   	.reg_read32		= nvmf_reg_read32,
>   	.reg_read64		= nvmf_reg_read64,
>   	.reg_write32		= nvmf_reg_write32,

Shouldn't this patch have Fixes: and Cc: stable tags?

Thanks,

Bart.

