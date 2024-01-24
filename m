Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8840FC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFElqW52tVel+hK7T5FhVDy5aC0qYVGsPISYYHPWVOo=; b=zzCHK12VUi1/FduiBiLMHwe0QE
	uH3sITCykfz0RLTwepWk9tBe57v1NV5XTgBsnP2xgdX+28a6nDu4TN8ZQMp9QcNFKukSlFmtPbSmI
	b6kkU4mhDukKEDrmLIezfdrBiM7tyeq7M48Jg4ssoAhnSrpHamUKmZJH1XEjWbrMTaPAgvZLclfnk
	5hsJKvBvVrOcxAYFCwlMxL688Ks2eyaHvdjYy0iz+MegAYi3aEhmj9kVe+SIpCz2EzTUSzRRKcFon
	sVkibS2T0OUr6EEkcd18YfogT/Rp5t6i8G6BFk+Uacodz6zR+Qyv0NxXXwfQZr2WCziWPzUCxZ3Sz
	Et6GwyIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZSK-002CDx-1J;
	Wed, 24 Jan 2024 09:22:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZSI-002CD0-2E
	for linux-nvme@bombadil.infradead.org;
	Wed, 24 Jan 2024 09:21:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sFElqW52tVel+hK7T5FhVDy5aC0qYVGsPISYYHPWVOo=; b=FtHnoWjoB7aofb9PtvTRkGaRJm
	Y82waAENjTXRab5Y3Bve0Jqw+VM2qiBdXybmJ4uBNVz8T/+QRS01rFMuwz72h4op6+HJ2EwZRzOCM
	N8uTAE8Fln6CU06wvI5/nt5xn4pD8uDD9bnVX54RQtsw7wLCfRf8SlXxSvUzM9yluIF+L7dTxx127
	56AMJGgg21gHuGuY0RQXi/Q/Ibog6hluW/hBAQeVqIRLrmQXw2Kgh/UUKXg9oLceI9yly2GI5gYNx
	8MW00CFB4VXG+YCvZa/d2gZGRH1jkcvo5uxF7el0cgq36yjeQLd3yldSU0qV4dOdeGiLVy6pAnlvc
	4RGDaMmA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSZSF-00000004LqP-1kHk
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 09:21:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EC1B68AFE; Wed, 24 Jan 2024 10:21:49 +0100 (CET)
Date: Wed, 24 Jan 2024 10:21:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue
 limits
Message-ID: <20240124092148.GA28770@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-4-hch@lst.de> <de3cd926-c78c-4e68-bee0-2f571ccdaf8d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3cd926-c78c-4e68-bee0-2f571ccdaf8d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_092155_614495_3F5E000C 
X-CRM114-Status: GOOD (  17.05  )
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

On Wed, Jan 24, 2024 at 07:08:58AM +0100, Hannes Reinecke wrote:
>> + * that there is outstanding I/O by other means.
>> + */
>> +static inline struct queue_limits
>> +queue_limits_start_update(struct request_queue *q)
>> +	__acquires(q->limits_lock)
>> +{
>> +	mutex_lock(&q->limits_lock);
>> +	return q->limits;
>> +}
>
> I'm slightly confused about the lifetime of the returned structure.
> By my understanding, the returned 'struct queue_limit' is allocated
> on the stack of the caller, right?
> Shouldn't we note this somewhere such that people don't start passing
> the structure around, or, worse, calling 'kfree()' on it?

queue_limits_start_update returns the structure by value.  So the
lifetime is that of whatever variable you assign it to, which better
be on the stack.  Tryign to kfree a non-pointer type will get the
compiler complain, as does passing a reference to it outside the
function these days.

