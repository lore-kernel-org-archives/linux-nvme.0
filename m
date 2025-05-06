Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80C1C3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 05:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sch28xP6WEwnIvUBxG3RgJ58EIQ3AtVfphEVYn+3Nl4=; b=tuypGgd7ipjTRhIB/9SJZLTtFq
	Zw9i4PCX83Q+qkOtyTQSclCnf4x9Okv14DLtbuerGS6Xa04blfeX9+OGfVlANS+AbjumY5sALAQUg
	X/faCAQBWcVty2H6bjw28eYsx2kEhIXsDRC/RGkaBk3KcIVLxDFnxvaOMxCJRI8uA2mxSaWEJmViX
	EOeXIo+0x+Ko+v1DqYSC2XoUz/qJIB+H4lGDe9dcM1o6sdrxXdHKEBlAiWAUxsgIu6qK1BjBXe8io
	xloE4e32cTcgW8DLJrGcFSXF9cmv6V54xRCGUeFpjYtetAZxf/cBza55AP8OhghO7233v2P5fTxXv
	f+/yGcsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBB1-0000000AWcI-1AIf;
	Tue, 06 May 2025 05:49:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC8qi-00000009xR3-2UEu
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 03:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746501602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sch28xP6WEwnIvUBxG3RgJ58EIQ3AtVfphEVYn+3Nl4=;
	b=A8eEEnftTcMwSBWuLLWfUctRh9oWAnxD4vvnwqrI7zJRGgvdOVsv/TTYmsngUGCgJHDAn0
	bxxFP6QyfJUNw2P0c7n5FfIOhUCbb8kDR1QJ/WfEvqInMLUEuZ91HuvWz3Py4rDH8D4HOm
	zaYN+TnSU0i1tpP4JkuKm0+djnY/s+Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-nA-B1ofkMX2faPg98ufcOw-1; Mon,
 05 May 2025 23:18:18 -0400
X-MC-Unique: nA-B1ofkMX2faPg98ufcOw-1
X-Mimecast-MFC-AGG-ID: nA-B1ofkMX2faPg98ufcOw_1746501496
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8EC7180048E;
	Tue,  6 May 2025 03:18:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44F2A19560A3;
	Tue,  6 May 2025 03:18:02 +0000 (UTC)
Date: Tue, 6 May 2025 11:17:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 0/9] blk: honor isolcpus configuration
Message-ID: <aBl_Zn7aHbUTmPSE@fedora>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_202004_762379_16EB7193 
X-CRM114-Status: GOOD (  13.22  )
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

On Thu, Apr 24, 2025 at 08:19:39PM +0200, Daniel Wagner wrote:
> I've added back the isolcpus io_queue agrument. This avoids any semantic
> changes of managed_irq.

IMO, this is correct thing to do.

> I don't like it but I haven't found a
> better way to deal with it. Ming clearly stated managed_irq should not
> change.

Precisely, we can't cause io hang and break existing managed_irq applications,
especially you know there isn't kernel solution for it, same for v5, v6 or
whatever.

I will look at v6 this week.

Thanks, 
Ming


