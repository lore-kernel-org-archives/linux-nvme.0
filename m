Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06045CEB2E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rFxspoJzSpoidu30KdZ/3LutpEs5eoSpyKA4GWnHU/c=; b=ku5NEUEUcQ+lLaui2GKVR1VnIm
	HX+REfITk87wvOp+gPuKPgw25GCWZCDS+octZKBg/TDEX/ei9tfubj7YvjeQulhRY6CyTykXVV2Wf
	mwUfkTPgsp8IIAv3xZrB8sUjbVBHKwGNDg/2KtY1izROx9Zf5B2qntwrFoCSZoaSMQkfHkzeAhsEb
	v9qU4HCkTh4wLe3cqZeec2bj0Y7EtQhQ1F8G038GmmJgptTjypUj+wjQmXUykN6FEOxLoXEMtGHkQ
	zV6eER2+KceWiUw4oL/Iodwpl3HzFhIZeZVibk5+58ClJKNcAVrPVc1ZGRrbvug9E5lCtvQl2qQGT
	ZMV/tDiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw46t-00000007AuY-4047;
	Wed, 02 Oct 2024 18:30:03 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw46n-00000007Asf-3xDy
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 18:29:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XJjyr00kTzlgMWB;
	Wed,  2 Oct 2024 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727893788; x=1730485789; bh=rFxspoJzSpoidu30KdZ/3Lut
	pEs5eoSpyKA4GWnHU/c=; b=2+HXCbK6SmuieqTkaM6qtUc4K+iKcGDiWWfIUizJ
	qeDK0l4j6vf7prZMWMfP9kYMN2aIimluNOu+uUOnbUDlu3QWes6ZaFJNNqo6IVFr
	1vNgCcRCPvD8KUbJ4rkKqd9mf8L9NVKfjM8MGjCfp6WN/CrLaHPziAyxB/MdnA12
	K0/AYnRp/u9Cxf4iE0i52F7EgoiOTnT/Txceo9XtDuFIC4iDfseJ/SFMmqvripyS
	yFD/YTy6aMKsmFUvyi21OD2H43fr5lNP1XUqxKF0fBXpm451dOyxPXRSA6vBbdaI
	Gn+ys5xCORibg0VCvGEOHTyZ1XzOp8+N8beaw7tzBN/NyA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fb7lQuE366pl; Wed,  2 Oct 2024 18:29:48 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XJjyf4PxZzlgMW9;
	Wed,  2 Oct 2024 18:29:46 +0000 (UTC)
Message-ID: <80eb6cb1-c1e6-42fd-8941-ffe081041a18@acm.org>
Date: Wed, 2 Oct 2024 11:29:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] io_uring: enable per-io hinting capability
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, hare@suse.de, sagi@grimberg.me, martin.petersen@oracle.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 asml.silence@gmail.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>
References: <20240930181305.17286-1-joshi.k@samsung.com>
 <CGME20240930182103epcas5p4c9e91ca3cdf20e900b1425ae45fef81d@epcas5p4.samsung.com>
 <20240930181305.17286-4-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240930181305.17286-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_112958_075131_61CD79EC 
X-CRM114-Status: GOOD (  12.41  )
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

On 9/30/24 11:13 AM, Kanchan Joshi wrote:
> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
> index 309ca72f2dfb..f4373a71ffed 100644
> --- a/include/linux/rw_hint.h
> +++ b/include/linux/rw_hint.h
> @@ -21,4 +21,28 @@ enum rw_hint {
>   static_assert(sizeof(enum rw_hint) == 1);
>   #endif
>   
> +#define	WRITE_LIFE_INVALID	(RWH_WRITE_LIFE_EXTREME + 1)
> +
> +static inline bool rw_hint_valid(u64 hint)
> +{
> +	BUILD_BUG_ON(WRITE_LIFE_NOT_SET != RWH_WRITE_LIFE_NOT_SET);
> +	BUILD_BUG_ON(WRITE_LIFE_NONE != RWH_WRITE_LIFE_NONE);
> +	BUILD_BUG_ON(WRITE_LIFE_SHORT != RWH_WRITE_LIFE_SHORT);
> +	BUILD_BUG_ON(WRITE_LIFE_MEDIUM != RWH_WRITE_LIFE_MEDIUM);
> +	BUILD_BUG_ON(WRITE_LIFE_LONG != RWH_WRITE_LIFE_LONG);
> +	BUILD_BUG_ON(WRITE_LIFE_EXTREME != RWH_WRITE_LIFE_EXTREME);
> +
> +	switch (hint) {
> +	case RWH_WRITE_LIFE_NOT_SET:
> +	case RWH_WRITE_LIFE_NONE:
> +	case RWH_WRITE_LIFE_SHORT:
> +	case RWH_WRITE_LIFE_MEDIUM:
> +	case RWH_WRITE_LIFE_LONG:
> +	case RWH_WRITE_LIFE_EXTREME:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Moving a function that is not in the hot path from a .c file to a .h
file is wrong. This increases the kernel size, slows down compilation
and makes implementation details visible to callers that should not have
access to these implementation details.

Bart.

