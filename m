Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92038C7113E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWkNewhRJ4wpEDm7PPC52E6cJKu2Um4iV+x8uvVQe/M=; b=4DsfFQEhOKPO02agOucc9SC6F5
	Zmp1sPTq09UPWksaeSBUCsxt8jToIQvRLSpgneQkJ7tneVOzwdoYXOhkuKYIC5WWo1ts3GnrI0dxQ
	0C1UrFkS5H1Z1AQvyX3/WV+FAaTkzuwMiWkavKJVUmJvOzucgPF3wv0+w3Xn0QBUeLDwEF80eJcKB
	rpXT+fjIrgKvFTLajFfvmqfjZnRshG0JPEwV3Apwitad7lgzI+j3qggi7R/2CDqXjZE4KRfH118Jj
	oAuLzl3HGMqEUxz/GiKDVdsthRMj6TeP82pq7jCsbbwpsdGG82yQ0kv2yy6jJqSnrHKur4zBnQTqo
	3XM7r2EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRWa-0000000B1Rf-1kSJ;
	Wed, 11 Jun 2025 19:54:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPN6O-0000000AL64-1HQs
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 15:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749654653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWkNewhRJ4wpEDm7PPC52E6cJKu2Um4iV+x8uvVQe/M=;
	b=BDbklt10LQWoaUYdI9PYxF3aj0aCTkEA/Lay+7V41TIixJbd5qO8b7vumA196Q6NjJZgML
	upW1dwDXTsqG8T5Z10ALn8ypGhddwlOFQ7rIh0LffAyy0woErsTndpqgPivIfJ66tSIPrL
	nfsei3dRh5BpkVKNtbJt7Uei/5Flng4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-zveqg8ABN8KQBI07Ze_SoA-1; Wed,
 11 Jun 2025 11:10:49 -0400
X-MC-Unique: zveqg8ABN8KQBI07Ze_SoA-1
X-Mimecast-MFC-AGG-ID: zveqg8ABN8KQBI07Ze_SoA_1749654647
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69F09195604F;
	Wed, 11 Jun 2025 15:10:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AFD11956087;
	Wed, 11 Jun 2025 15:10:33 +0000 (UTC)
Date: Wed, 11 Jun 2025 23:10:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
	Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
	Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
Message-ID: <aEmcZLGtQFWMDDXZ@fedora>
References: <20250611121626.7252-1-abuehaze@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_081056_411103_8C60E1BE 
X-CRM114-Status: GOOD (  12.13  )
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

On Wed, Jun 11, 2025 at 12:14:54PM +0000, Hazem Mohamed Abuelfotoh wrote:
> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
> 
> Commit <e70c301faece> ("block: don't reorder requests in
> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
> list, this had significant impact on bio merging with requests exist on
> the plug list. This impact has been reported in [1] and could easily be
> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
> having any filesystem on the disk.
> 
> My benchmark is:
> 
>     fio --time_based --name=benchmark --size=50G --rw=randwrite \
> 	--runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
> 	--randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
> 	--verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
> 	--group_reporting
> 
> On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.
> 
> Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
> --------------+---------------------+--------------------
> 6.15.1        |   362               |  2KiB
> 6.15.1+revert |   660 (+82%)        |  4KiB
> --------------+---------------------+--------------------

I just run one quick test in my test VM, but can't reproduce it.

Also be curious, why does writeback produce so many 2KiB bios?


Thanks,
Ming


