Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36ABC48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ycFTeyYAmqutNmHM0PCbF0R9SEz0sPqdMNm43YOvfQ=; b=XEmFW9PRFiquiCjRbtW/KWQp2a
	8lxljNlQFV2n33nJfJZcLkblvyVEQ2Djapl9oU6YBd5HxYYIzJlF7ItfXajXh6aXf0Rk4K52lETyI
	xyI0XM8hp7daCGJ1LdQyCVw1jQgyOJiLuu9U4nq9JYS6kEPHSkUFFJI/jydPXVQm1F5LTDQPfZOW4
	avasYjrVZIIva4/H0hUO20HrSX5fP26hS6aInaBpxuclDz75Qqc27dRTo7JdwFGwvd+QJaDLaR+Sp
	0ZlX1PwB4gxN5ZCzUcMjYfw94HwWPaWqy137G3rWLqpsd22K3FeqJ6JHZnI6A117gO5hYvfdDDt2h
	GM2polqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQiM-00000004VP4-15sj;
	Mon, 12 Feb 2024 07:26:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQiI-00000004VO4-2PDA
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:26:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 44AF860AFB;
	Mon, 12 Feb 2024 07:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA07DC433F1;
	Mon, 12 Feb 2024 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722808;
	bh=KRvVpg0yMFiU7+mueEuTLVe7ZeaxAMokUzDN33ev9gk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EW2X02JW4C8aHB4RDG6JtajETg9EHOSnmigtgMhPORXGXMn7aRP0Enp366l63JSqy
	 OJrU4Fznf5pGD6Cx9Un8qIxW3okUxb7yE1saj3s3siFrdqMnvMf9gDUuOvJ0fyw99r
	 lAw2Vb5NHn3O3ZyKy5D1WbUtv0OH1DrL3L9MrRj8fRTmOTMRz+MZBAwsD++SMY6OVF
	 y7C3JTfu3xXmXZHQFImyGtbwH4K80tyM99k4OUa0eYm6lXmINrpWmR+hMzOzdzOCNJ
	 oWaOqpCGQ2GA3gTYrU7CBYZzxpD+bnAT0C/vAl2x/cMVPZI9QexoJSkyq9EZT5+tlR
	 5dFJDm+DPwDVw==
Message-ID: <2705379d-7fdb-4061-aae1-4c37f74e1801@kernel.org>
Date: Mon, 12 Feb 2024 16:26:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-9-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240212064609.1327143-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_232650_728163_4B8E15B7 
X-CRM114-Status: UNSURE (   8.57  )
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

On 2/12/24 15:46, Christoph Hellwig wrote:
> Pass a queue_limits to blk_alloc_queue and apply it after validating and
> capping the values using blk_validate_limits.  This will allow allocating
> queues with valid queue limits instead of setting the values one at a
> time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


