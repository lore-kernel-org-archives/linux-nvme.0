Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E229C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qDZo2TEgDk4TO/7tRVIEF7rDUOs5Hta/AcV2RSs/5Ag=; b=GqP7qorZMHUSolwmfYq6MBS0aT
	B8DQ8lqjHmS0PGIyz5aFXggiNvTpewNBD7cmHKmV5xo3Hk3+6OGVUBkXMNmtMU4MGfNa7QDx1+kvy
	BvV5HzKTXjnAHjVPasryY51LrjSPNpEBu/31iamxYysGPNz8mYXvdKoCV2lUI84ZI1gR7k/ooxsLL
	NY+qT6annkecuBrbz+MzdAa0AkyQUWFtlOnYIpezY2jFdP9wQnK1KWKguSl4UDs14ot+qvldRTxii
	VwHHLVnOhdxfHzlcH4sxRtmYea0Cc+Pk3BIwBY0/y9ab2o2P5NhnAgRfj2g8Yj7no7m25nwex7uNf
	ZUn6L/Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9CN-00F8DP-32;
	Tue, 23 Jan 2024 05:19:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9CL-00F8Cs-20
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:19:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 15DEC6137C;
	Tue, 23 Jan 2024 05:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6498C433C7;
	Tue, 23 Jan 2024 05:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987184;
	bh=fTwXC5a+GyvoKvS4HGH/GTBafoY2st06hVenMAUFCO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SbNGrW+LcTZcEwmz7X80teBShRjqua6PYHO1i5X7e1jf3cyTe5cG8eBy7wFfMgv3z
	 2oULZZQB2fTqWaxi/f6s6+OF6oplZPU6an37oaZg6qOluva54lgSlSpwe6n5hdrY+X
	 r8ff4OX7JoobbN9lGc8JwmHc76UT8zxUDJfSmUNXnehgV+oQNq+nZpnJob5ln77PgC
	 F468C5wBz5GmAgVWzNH2fE8YH9kx0IYJmgZmK6MVzjpeSG+0GKzFb+LYkY4QMce9tN
	 QunJKXEFexkep90UJNBD8iKtte9s+AcqxWqSUL/homPDTiao+cqVazEwrK7Df+zXde
	 VzLLRlcBHyFqQ==
Message-ID: <d8e0f81e-b269-49b3-92bb-c039a2dfbfaf@kernel.org>
Date: Tue, 23 Jan 2024 14:19:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] block: pass a queue_limits argument to
 blk_mq_init_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-10-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_211945_701291_3493DF4F 
X-CRM114-Status: GOOD (  10.75  )
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

On 1/23/24 02:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_mq_init_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Also rename the function to blk_mq_alloc_queue as that is a much better
> name for a function that allocates a queue and always pass the queuedata
> argument instead of having a separate version for the extra argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


