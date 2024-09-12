Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B231EEE258
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 20:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9yS7HA6fKYDCCYVIl+KdIxvAej4qJ3r4GXFGjMqBgvo=; b=QgpPyrmbALXY2DRa329sIYhMDe
	5fcmCiCayNlZ2oqal1Yk5Gwg7sJaUZ8JkjOpy+e92QsorJMFPJoiMrr+aHDl5vnRDDfBk0BZFe6d3
	fAPKE+7vns79rFAImvTuCOf5d7ha7M3Oq2Oc0euAiV5dLvQYSxweyRRPAbm0IOFhCPvTZlK1Fh8HU
	JDwMIdKcP9yvE9+bVjA0nI0AFXQe6hUpkFk28csJ70O3FR/H/3grknjdNnNfx7AGPIDJQctkSdd5G
	wc8GGlbbpxCrRhc9Lg9gnFvVV/NyO0df/UdZX7sVuJsN1nv3MW93B5IjZTOMqtDv3XqfEMvbjivha
	7i0O8j9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soqYk-0000000EBaW-385o;
	Thu, 12 Sep 2024 20:36:58 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soqYh-0000000EBZu-28lV
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 20:36:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4X4TkZ655hzlgMVN;
	Thu, 12 Sep 2024 20:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1726173408; x=1728765409; bh=9yS7HA6fKYDCCYVIl+KdIxvA
	ej4qJ3r4GXFGjMqBgvo=; b=uSvi5fR2vmRTU5PsBWAozmgRWg15DQCoTw9QYG0Q
	JILXCI2W17PMdjeB0eCaY4R9b4p5zp9bb+bfYJlcGbHdBTfiFtQtMF3dUYguzo/Z
	TlwUp0S+sLzCJ2ZszrvHZG5CDzMw6iEjadRBSJIy5BAgA0y3vIeIBsfBENIkbnoW
	r11vxY1o7k84TSJpKMgfwayzh+k0/J3gvxSYRGPxCpPyAAVkWDiPCc0uq08D7fpJ
	66OjaML0t1A0/rH2BCmDW3sZR1xKfqOJVpFBi7aKD0+DNxhM9SCJFcr5+emr55CI
	a+9PjgbvNYdOfcQHlw3ysfvDS3LLjk0rwkbAPwa/6Q1aNQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Z4I_UPR0myMw; Thu, 12 Sep 2024 20:36:48 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4X4TkN0rMHzlgT1M;
	Thu, 12 Sep 2024 20:36:43 +0000 (UTC)
Message-ID: <53043e99-be5f-4fc6-be87-4ebcb8ce99b6@acm.org>
Date: Thu, 12 Sep 2024 13:36:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
 jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
References: <20240910150200.6589-1-joshi.k@samsung.com>
 <CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
 <20240910150200.6589-4-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240910150200.6589-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_133655_599597_8861EB8F 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
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

On 9/10/24 8:01 AM, Kanchan Joshi wrote:
> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
> index b9942f5f13d3..ff708a75e2f6 100644
> --- a/include/linux/rw_hint.h
> +++ b/include/linux/rw_hint.h
> @@ -21,4 +21,17 @@ enum rw_lifetime_hint {
>   static_assert(sizeof(enum rw_lifetime_hint) == 1);
>   #endif
>   
> +#define WRITE_HINT_TYPE_BIT	BIT(7)
> +#define WRITE_HINT_VAL_MASK	(WRITE_HINT_TYPE_BIT - 1)
> +#define WRITE_HINT_TYPE(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFETIME_HINT)
> +#define WRITE_HINT_VAL(h)	((h) & WRITE_HINT_VAL_MASK)
> +
> +#define WRITE_PLACEMENT_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				 WRITE_HINT_VAL(h) : 0)
> +#define WRITE_LIFETIME_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				 0 : WRITE_HINT_VAL(h))
> +
> +#define PLACEMENT_HINT_TYPE	WRITE_HINT_TYPE_BIT
> +#define MAX_PLACEMENT_HINT_VAL	(WRITE_HINT_VAL_MASK - 1)
>   #endif /* _LINUX_RW_HINT_H */

The above macros implement a union of two 7-bit types in an 8-bit field.
Wouldn't we be better of by using two separate 8-bit values such that we
don't need the above macros?

Thanks,

Bart.

