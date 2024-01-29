Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99124C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FIjLM/+oic+RKlSoBkZbgoDTEu+Hx73idszw1N3CZEc=; b=wPDfNDPy8rWiz7UiqMxgvhfgHv
	Alpb2Ytl8l2+3frg2hdX1EedgmoltHdLh+Unp8fCauR4BAwQSRGFsaANNo5vtiE3JvhIsl6DVA73s
	DbuyRt9iMQHB+ggJTGuKWcBJ9xNZoZFDZU8ZrWNZWR8Lwsjb46fLy/AK1TRj7P0TYpcxUkJfFPsDx
	hJo5JdgdeAGOOA/tzIM+2+uFZydh+O5G3M5J3CJhZeN2lizWZb79JJHMOuA4LA/KfPqAMfRdJ97SK
	C6dco63lBdqdBF0tGKQd8xdwYY2uYbHbA9CTLA6M/ye853sspzWgF5JeFgBtt5YTMYt7DLKL+JeJ6
	97LO5j6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKw7-0000000BQWs-0FQR;
	Mon, 29 Jan 2024 06:16:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKw4-0000000BQVv-12CG
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:16:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8584968B05; Mon, 29 Jan 2024 07:15:54 +0100 (CET)
Date: Mon, 29 Jan 2024 07:15:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
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
	virtualization@lists.linux.dev, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/14] block: move max_{open,active}_zones to struct
 queue_limits
Message-ID: <20240129061553.GA19581@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-2-hch@lst.de> <a0d499e7-ec2d-44f8-9b13-b1ef857e4c14@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d499e7-ec2d-44f8-9b13-b1ef857e4c14@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_221600_470639_C609BE82 
X-CRM114-Status: GOOD (  18.78  )
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

On Sun, Jan 28, 2024 at 03:32:32PM -0800, Bart Van Assche wrote:
>> @@ -307,6 +305,8 @@ struct queue_limits {
>>   	unsigned char		discard_misaligned;
>>   	unsigned char		raid_partial_stripes_expensive;
>>   	bool			zoned;
>> +	unsigned int		max_open_zones;
>> +	unsigned int		max_active_zones;
>
> Not all struct queue_limits instances are associated with a gendisk. Do we need
> a way to separate the limits that apply to all request queues from the limits
> that only apply to disks in struct queue_limits, e.g. a comment that separates
> the two?

I've actually been thinking about that for a while.  It does sound like
a good idea but I wonder how practical it is.  But that is on the table
for after we've sorted out the basic API problems, as that makes
splitting it much easier if we do that eventually.


