Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF97CA0FE4
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2024 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6GlW9yIoadQq46MmyoepJYJ8q9LfdZqy08l1271Zu+4=; b=pk9CvbnfowhSws0XQnQOMK/T78
	D5B6VSI7rfalU2JsbIs6pldynDD4/FUfl5vwr26mtI1JGHOoOVlAhCEmG0BsoN43jfquUfd+fFtky
	6pD6DUKkFXQzP6SUamECtc+krERdBckFf0/TI63RnEspNXzfeJTo0dYqO8h80hYtCdh0RV5AX8/V8
	+3gRbWSOQcqtXISa9jKMdLFMlORMEfqB74UG/cHpPzzapsLkIU//ZR1jNvJBwJai+vdR6XH+m6UAz
	oko7KQU4PlOcE4ExFJYU2Dcld39rA4/cv5MdnzuNAXBIimNmr9oHpwG6HRubllcls2c/DQz0jAMtL
	Y3ROSrNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk0ZP-00000006B6x-1MaI;
	Fri, 30 Aug 2024 12:17:39 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk0ZH-00000006B65-1ePq
	for linux-nvme@lists.infradead.org;
	Fri, 30 Aug 2024 12:17:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WwHGL1TxYzlgMVf;
	Fri, 30 Aug 2024 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725020245; x=1727612246; bh=6GlW9yIoadQq46MmyoepJYJ8
	q9LfdZqy08l1271Zu+4=; b=HDLC/X2jGKS6GEr8dCi4sdxXG4856TtMCXnGwrLk
	hPO1wOwiL6OJ5gZBVzRO5iAqQ8W4nld9tlezsQD3axIrvx2xAuAlifeCxIYW04lY
	XJNOmPI/qZS6iG5xzXM5UkRSAOla/trI5M9M5DbVuebf06mqh1FL8K07ZJa9Qw5T
	25j8wENOw8vzEmOhvCWIjuUYTIRNi/H/oSN2GNzUKuHhDihlqmBEh5SR5LjdlqFj
	HulYBaWrWGYBKs21TSU7+5oPrTh/qcnkDchEoNA+3/RuPO3N9ZZqHetbg0nhVbSr
	zJTXX/O48XQSFBtvs76WvzyIGyvQL1f6moM7RRiKzuyaAw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CK5wHqhS3E6t; Fri, 30 Aug 2024 12:17:25 +0000 (UTC)
Received: from [10.254.113.103] (unknown [207.164.135.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WwHG807ZyzlgMVb;
	Fri, 30 Aug 2024 12:17:19 +0000 (UTC)
Message-ID: <0cfd7841-ea11-48c6-93fb-7817236c81c8@acm.org>
Date: Fri, 30 Aug 2024 08:17:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] fs, block: refactor enum rw_hint
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org, jack@suse.cz,
 jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com
References: <20240826170606.255718-1-joshi.k@samsung.com>
 <CGME20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5@epcas5p3.samsung.com>
 <20240826170606.255718-2-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240826170606.255718-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_051731_472640_E775C42F 
X-CRM114-Status: UNSURE (   7.11  )
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

On 8/26/24 1:06 PM, Kanchan Joshi wrote:
>   /* Block storage write lifetime hint values. */
> -enum rw_hint {
> +enum rw_life_hint {

The name "rw_life_hint" seems confusing to me. I think that the
name "rw_lifetime_hint" would be a better name.

Thanks,

Bart.


