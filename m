Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE5AD3B7E2
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 19:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PvtBCN8q7OJHTmZPU/1Pvq3WWRAphxJgKeW0vRrevtM=; b=jbE7EURzg+mn7oPTJPRtAZQM+I
	Ip9iuSeh5wS+KMqe8pvoRf8J2VdI5pvaEdwOWpwry3Lo5KxRfvLzrNP3QiUC0xlw/44jJwDQ/T38w
	xRDM6qRedd0XO63JSC6Y5pGr/MR92BFS7ECw/yZavNElVUrVz7ZkKx8DGiD9SKJ1ZNZZKvPWNlGKg
	gMyawp7+zoXQ/XJ4TjR/7DIewZysTp12RWQ7GDA1FT1Y5lqxIl3LfNNWzoTDtI387LFg+ghN36Qdm
	isZf1vEXSag65MEr49GsY01GEj+v/RrYKnyMYUWtLhLhTPBylqa+ACpeQd1nlsDomf8SEPLP1FivQ
	dendv4fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSgos-0000000DSnR-1aW0;
	Mon, 08 Dec 2025 19:22:50 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSgoo-0000000DSmj-29R6
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 19:22:49 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dQBhK3tPRz1XM0pl;
	Mon,  8 Dec 2025 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1765221758; x=1767813759; bh=PvtBCN8q7OJHTmZPU/1Pvq3W
	WRAphxJgKeW0vRrevtM=; b=MNIo/rCgdYiwN8mRWKxBEqCy5/qxUG2dLgqnXhq6
	SP9gsLIQUYXfLm/OSeUGMkLmtmUyD6cXtRKo6U39hH16BzLR+F2nnRWnZjiQyjEG
	+8peEO7LV5QANPpdCkGNylsIz4WQfaJRxZbatoM15inLdnR041nIuYOnEQvll2pY
	De5FahEfwAg9XBAWsMVWWXAtVsXFqq23BImDxpJGBRIczxCfXnYoknDSb47R3tRg
	E1NsVJpcTPVKt+5MZGky6BPCIllhgjEEnX4Jion15JPI5zPhcoFYzet8Ac18mTvU
	HapCtboazPEDJwyM2RD26+B6R3ZGcQkxiILAKOMqZvmgEw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id E80-xswuVyhH; Mon,  8 Dec 2025 19:22:38 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dQBhC0SVyz1XM0pk;
	Mon,  8 Dec 2025 19:22:34 +0000 (UTC)
Message-ID: <f24709c4-ba5e-4fb8-b20a-883d14185b2f@acm.org>
Date: Mon, 8 Dec 2025 11:22:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead
 of set->tag_list_lock
To: Keith Busch <kbusch@kernel.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Casey Chen <cachen@purestorage.com>, Yuanyuan Zhong
 <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org> <aTH8opTiwJxH2PMA@kbusch-mbp>
 <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org> <aTI2L6j50VWjp7aW@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aTI2L6j50VWjp7aW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_112246_607320_0B4CEE66 
X-CRM114-Status: GOOD (  12.58  )
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

On 12/4/25 6:32 PM, Keith Busch wrote:
>   static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   {
>   	struct blk_mq_tag_set *set = q->tag_set;
> +	struct request_queue *shared = NULL;
>   
>   	mutex_lock(&set->tag_list_lock);
>   	list_del(&q->tag_set_list);
> @@ -4302,15 +4305,25 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   		/* just transitioned to unshared */
>   		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>   		/* update existing queue */
> -		blk_mq_update_tag_set_shared(set, false);
> +		shared = list_first_entry(&set->tag_list, struct request_queue,
> +					  tag_set_list);
> +		if (!blk_get_queue(shared))
> +			shared = NULL;
>   	}
>   	mutex_unlock(&set->tag_list_lock);
>   	INIT_LIST_HEAD(&q->tag_set_list);
> +
> +	if (shared) {
> +		queue_set_hctx_shared(shared);
> +		blk_put_queue(shared);
> +	}
>   }

Although harmless, with this approach the queue_set_hctx_shared() calls
by blk_mq_del_queue_tag_set() and blk_mq_add_queue_tag_set() can be
reordered. I like Mohamed's approach better because it results in code
that is easier to review and to reason about.

Thanks,

Bart.

