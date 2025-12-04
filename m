Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE79D29FA7
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uSt3LQxRGpjDmMgYwHR3vatY0L+HSvxBS4jGX4ynEhY=; b=kUJLynOs35ZLN+LdZHahLOz0ZP
	SlJaYeAGpVyvuYarierlPtXKY0ZPTE5xrDLwtB1sV0qCt1QYL1XoRhu8z/TmXVs5rCmlHzp/EWrEt
	79q4wiIXoGgURHPfQbyu0T+pZ9uEbtZl2OBF9in7Hd1ea+EO6VLWC6J676gzAkp+SD0ZNYo/7NJBJ
	ZvhZKBg9k3XoULnzqAdU6MgdKgBivabUUiCO/aQ5/sOPatWQ1ZrvKPml+QP1vqC7zyIKKNYo12xbe
	2LWkAaPBTWLhufw2QieFpL7rO4hk9X3PUljel7n5x33ogzmuZ7qmLLFmZoLz6wZ7PDwS28SfxbL5M
	KbxRHl1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRDyU-00000008RDJ-36zO;
	Thu, 04 Dec 2025 18:22:42 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRDyS-00000008RCt-1LRc
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 18:22:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dMjXv3gMWz1XM0pg;
	Thu,  4 Dec 2025 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764872556; x=1767464557; bh=uSt3LQxRGpjDmMgYwHR3vatY
	0L+HSvxBS4jGX4ynEhY=; b=BDh8OEQMeMGOmbaMpaZ8cfAW7Vn13mFGdLUxghFQ
	qASqhrTIOH2eJF0gdpTuJAI4Vi/+WjasOSyUWWs1odHF8CYHxFFJ/GD1KPeldydw
	/Fe/pI90m6Q9jMY/W9j3ZF8313NMjZCNKaRBFC8y9OXY5doG6fTvem9QK2apU7lW
	G4JOuR9B0tcnmCfu5GsJf6TsziA9+sfMACyq7rjb6egFubDQexPNgRfc61n4zYRS
	EPDQxlvOz1GPgoWk+ULFd3YMtfQiQBthsLr6HixT+0LJtigha8TJ77HpO4foZkh5
	mBqqoVEkJrjf1e7aUc3dhKa22d961cd43U6osr/NN+48Yw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FtvBUV3owpqd; Thu,  4 Dec 2025 18:22:36 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dMjXg1zTgz1XM0pF;
	Thu,  4 Dec 2025 18:22:26 +0000 (UTC)
Message-ID: <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
Date: Thu, 4 Dec 2025 08:22:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead
 of set->tag_list_lock
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251204181212.1484066-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_102240_484202_B525E8A7 
X-CRM114-Status: UNSURE (   9.40  )
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

On 12/4/25 8:11 AM, Mohamed Khalfella wrote:
> @@ -4302,6 +4302,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   		blk_mq_update_tag_set_shared(set, false);
>   	}
>   	mutex_unlock(&set->tag_list_lock);
> +
> +	synchronize_rcu();
>   	INIT_LIST_HEAD(&q->tag_set_list);
>   }
Yikes. This change slows down all blk_mq_del_queue_tag_set() callers.
Please fix the reported deadlock by modifying the NVMe code instead of
slowing down the block layer.

Thanks,

Bart.

