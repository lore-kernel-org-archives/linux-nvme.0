Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D48E77198
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnKvXeaIbNLGjva3x4wq0sUWPhchXJHe05AZXqB3U8g=; b=G6fTWeRJaxa0W/K/jxgonYMFKI
	HRmekY7Qb5N1nT/0jxgfNyNhzKU7RbE0SHjEsuQki34q94hN/JMuVHCD6tYv127YS39ZjYiqxVTn6
	b4GemqDRxxyM9g5+6Hvz4j95+iQ6PXFdwzVkpZwhvKGZ7Dr6vF31Mpur03KA3F5F66YtNCHj8B9OE
	bVUgXFBY5Z2FQ4MWeVnk5vLngfpVWhkda4/pR+OA6SJSjKxcUdCwNQBZ/TwkiQxaGj0vwTU2TNk41
	Diez5KDi618k3aC+pQLPnDY5fplm6E7U1NQGomzJVvPwkw7Pd8blevDifv28CQRW8Zcw4PmEOiumI
	PQ89ek1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6lk-00000004KLA-02fT;
	Tue, 07 Jan 2025 10:25:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6Lw-00000004EgB-1T0X
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 09:58:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 536B6A40DDE;
	Tue,  7 Jan 2025 09:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96556C4CED6;
	Tue,  7 Jan 2025 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736243902;
	bh=gXePA8iZEDN51uz8OEr9Kuq7CxiG2RKGlA3FnkJaxfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YdhHQR0MmT8EOeR26AEO2aeZ3R7cPbIl06Z1PvPXM4Ube0w8E1WkzylvCk1s8Fmu3
	 7PGATboRdDfnMKXY41BEYh+R6xeXdckAvn6MYGoalw1R6FSAkN4NeURWbez22Z/DvM
	 z+snIlyQi/ET01PHZ1bClO6lrM2760bvIdk5pSh0iiZ493zKO9bwHOuvzqYQK8FMSE
	 X8NR6/AWU4Q0ctsFVoxKL3k8B8PlM4Tzj99QUn38mK1iiAXbB7cxxtohzjhmwkL06U
	 Wau8CPfxV9dWIYC9a2Uxt97HmfjoQIKwDsXsuvVKquqxpk73Vbu0uGRj/9jpn5W+Rp
	 CjgbEFyy+K55w==
Message-ID: <28120cf8-1a6a-485c-be2b-57aeefcb9190@kernel.org>
Date: Tue, 7 Jan 2025 18:58:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme: fix queue freeze vs limits lock order
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-7-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250107063120.1011593-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_015824_453410_03DB4EC8 
X-CRM114-Status: UNSURE (   8.98  )
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

On 1/7/25 15:30, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock.
> 
> Unlike most queue updates this does not use the
> queue_limits_commit_update_frozen helper as the nvme driver want the
> queue frozen for more than just the limits update.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

