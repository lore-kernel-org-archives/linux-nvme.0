Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B216DC25B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L/Z8Mp/V6Xlw6wkYa899vAJPgD1/fbki4rEqLMN5kt0=; b=FGuT2Au5cawljJ9yf5yvCsgZIJ
	pG2gBQ/H0/6mW95ApnZ+C6lJdH3h1KooE+E76yRYLwbNEYKHQT31KavVvJYMDj9LQ6leipdHazZLr
	HPTj+93gtxg1JMEEUezrhnL3UQiSBaRS2DhzI8nlKH7xrbBRJ2/t237gmoYiawu15IpEE2uC8QkHm
	xPnJfQYfYakDQKknWa/UDlgNcOCkylkF3qH2b5+tYxD6Lepw02gvcnFMWrR7aOKQIW0f7R9AI//yV
	Kc3IgeEQrdPleAJewWFlvkB8vuGCE1iN5aGFyBdPo8GgmT82esHopj1U93v3C/48UGVQhQd6lJ51j
	bYnNZs1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9qLO-00000003l0d-13x4;
	Wed, 22 May 2024 18:05:42 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9qLJ-00000003kym-03L4
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 18:05:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vkzk83zW8zlgMVN;
	Wed, 22 May 2024 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716401127; x=1718993128; bh=L/Z8Mp/V6Xlw6wkYa899vAJP
	gD1/fbki4rEqLMN5kt0=; b=w4GG+Zk5K8I/0oN1UncHTyKd/Gk3/mstQgMKWu5t
	Ny7lWh1SNsdH2k/eerNIDbR63ln2fHwadLSxbN26wlaOya/Eb7PeDC2wO1wQKjb9
	3Kv/JR7I2jGtvACEHUtbbltKIsewEnPsGTXlFkdHY5VQDRMbOzG2Cwd8N6o6Kglt
	VAATPhWT8TLmUPmX550QPPAX33B17Mu07oRnRQwIO7d7FhOlbWoNQaN1AFJr+alO
	tSKLeozFvhzoY0vF+hxn0Q0phgYjUm0983n3BJ3WEMUeCawbvbeOWfDl6EKHKFRy
	nODt7HOx9vbzAwF9c3bzRHWDHD+tlt4k1IYNX1Ev1w+wxg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id F51LBj9xAtLQ; Wed, 22 May 2024 18:05:27 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vkzjx0WdLzlgMVL;
	Wed, 22 May 2024 18:05:24 +0000 (UTC)
Message-ID: <97966085-d7a4-4238-a413-4cdac77af8bd@acm.org>
Date: Wed, 22 May 2024 11:05:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_110537_104029_E4E58893 
X-CRM114-Status: GOOD (  12.69  )
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

On 5/20/24 03:20, Nitesh Shetty wrote:
> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
> Since copy is a composite operation involving src and dst sectors/lba,
> each needs to be represented by a separate bio to make it compatible
> with device mapper.
> We expect caller to take a plug and send bio with destination information,
> followed by bio with source information.
> Once the dst bio arrives we form a request and wait for source
> bio. Upon arrival of source bio we merge these two bio's and send
> corresponding request down to device driver.
> Merging non copy offload bio is avoided by checking for copy specific
> opcodes in merge function.

Plugs are per task. Can the following happen?
* Task A calls blk_start_plug()
* Task B calls blk_start_plug()
* Task A submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
* Task B submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
* Task A calls blk_finish_plug()
* Task B calls blk_finish_plug()
* The REQ_OP_COPY_DST bio from task A and the REQ_OP_COPY_SRC bio from
   task B are combined into a single request.
* The REQ_OP_COPY_DST bio from task B and the REQ_OP_COPY_SRC bio from
   task A are combined into a single request.

Thanks,

Bart.


