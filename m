Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E00C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78Zaoc+ysQZW0svRK1nsW0QmI3S17DItZByKXc3/tr8=; b=mjZEP+8vNNxUHZCvFpn/xFlqJU
	n5T8YQAKfFvSUAOAMYCa4oItU5Bz8AIfGl8zEXZBstvWJ62n1r36M3A65FVgtQhL2YdWCp1Ty15yK
	JxZhQ9C9onwcrJf6to4inCipsh6O5jng8B8DIATbIMpuhqCknBYY78W8G8NP8zsERb9BDX25WBBB1
	ZmHCONZpnKU9HtzJRF6VzQXie4u9mfSengd5fgqg3vrpkhWOeWBN1wPx2M2c2cPeFqNjwaQGre+Yf
	w+e15JPVx0OHdgw3kGFpp0yQPKqr2JXYLyspk/w/4cZuKPz78fFrIvCEtR6+VUJjNiHJ4OE2Efkpa
	4pNKt99A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5ha-00FbwI-Du; Mon, 22 Nov 2021 09:33:30 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4BR-00FB6c-HG
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:56:15 +0000
Received: by mail-wr1-f53.google.com with SMTP id s13so31019399wrb.3
 for <linux-nvme@lists.infradead.org>; Sun, 21 Nov 2021 23:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=78Zaoc+ysQZW0svRK1nsW0QmI3S17DItZByKXc3/tr8=;
 b=nkbjbPzDmcVlqudD49hxQ3zCxN/hsEO/q6iW9wz8/vGSzm3tSiaiwQ+wX+YyCi6aqi
 zP/NrNq99u1WpbVfG/4DesGFBMNSXy52D9GrpdVU8BYtnfH1Sr2x0XA6UtahXmyk+YOE
 nNkMxNvo+aOYMkl399FQIsaF7K0NJiv7v0rydptqThION5336a4vu6pphjpSGrYRr3tW
 2g6V0d0ceOpJWs9fMHh0LiYD/nJhFtXTjUG6VD+TfkSmOscGx+QHSZhVwzH3n4xTjLXv
 2xFegSjeVTqsOY6FOuhms7yvLJbZtv+dRWY98IfBywQ917vGX9FBOUjeFa37wWZAKjiI
 RCaA==
X-Gm-Message-State: AOAM531k2/f8XrypkAiqUzGM5uvncXOECJDstKf7I6XTigq5JF7aI1f9
 i69FBtO4WhO7L9lSEO0K7G0=
X-Google-Smtp-Source: ABdhPJy05or7AiPXEADL1NGpquFhxqkO2PYPdr/Gq1eAF15MB4FM5Abvecrg2lRFpC6RvQu5DZGgjA==
X-Received: by 2002:adf:eece:: with SMTP id a14mr36297769wrp.333.1637567772184; 
 Sun, 21 Nov 2021 23:56:12 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m17sm7931073wrz.22.2021.11.21.23.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Nov 2021 23:56:11 -0800 (PST)
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me>
Date: Mon, 22 Nov 2021 09:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119021849.2259254-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235613_683746_A7097343 
X-CRM114-Status: GOOD (  20.90  )
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


> Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
> queues in parallel, then we can just wait once if global quiesce wait
> is allowed.

blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
obviously it has a scope.


> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   include/linux/blk-mq.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 5cc7fc1ea863..a9fecda2507e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -777,6 +777,19 @@ static inline bool blk_mq_add_to_batch(struct request *req,
>   	return true;
>   }
>   
> +/*
> + * If the queue has allocated & used srcu to quiesce queue, quiesce wait is
> + * done via the synchronize_srcu(q->rcu), otherwise it is done via global
> + * synchronize_rcu().
> + *
> + * This helper can help us to support quiescing queue in parallel, so just
> + * one quiesce wait is enough if global quiesce wait is allowed.
> + */
> +static inline bool blk_mq_global_quiesce_wait(struct request_queue *q)
> +{
> +	return !q->alloc_srcu;
> +}
> +
>   void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
>   void blk_mq_kick_requeue_list(struct request_queue *q);
>   void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
> 

