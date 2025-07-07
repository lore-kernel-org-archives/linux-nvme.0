Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A669C8303C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 08:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OalrTZVgCTcY8CfgCXR2MxPAgz7dMXIrKso6Jipbb5U=; b=LMIexvuxtwJ6YRY83mCiO88hUx
	Gv9+YiKiSyKG7xN5aUjT2Vcwnrmo27XrU+9ZANgzZuAAq/PCJm1SWrgwZIc/k2wYIGqGJFZ/JwP9f
	DIt0LtHGL47yr6MRpgsdxNPKi1F0hexYvnSZDqtMnUikkQN9H57EjPOnjmzNUV5En14HCAn1guFsb
	crtR4al4X8Sw3jW937Q6kgiGUnVVmvXy71BhWofTfyCaA9g+gNunff3S1eP7SBP9b4t9B/K2Ubyr0
	2VW5nYMwf0nUUmzqXIQjq0cGjA77/RR8eUoDY9kcVIXTmX9JJ14azGISDQpp0QHWwDtmrtVzmFY7d
	JWuJA00w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYhCq-00000001r0b-0W2k;
	Mon, 07 Jul 2025 08:28:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYgX8-00000001jUJ-1Usu
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 07:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751874300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OalrTZVgCTcY8CfgCXR2MxPAgz7dMXIrKso6Jipbb5U=;
	b=ErtZasqvYfuKgCY0OZ2yYbYDCPtM3TFfJLWOmV96kIsHKaku5w5huvPcpiYoLdGVZKLo32
	sB4TEDl0IH98ex/ZJ+gklgG6J7aWDK7uz/ZYytBcdU9SKyJnXtr8HTgsAVkuSC+8jTqlVL
	FzNC8RzSUkteDJ7jpKQq/+S0t50Z+R4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-ZccoFHbxPKqYGcrylrjfjg-1; Mon,
 07 Jul 2025 03:44:54 -0400
X-MC-Unique: ZccoFHbxPKqYGcrylrjfjg-1
X-Mimecast-MFC-AGG-ID: ZccoFHbxPKqYGcrylrjfjg_1751874292
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60B6F1801211;
	Mon,  7 Jul 2025 07:44:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.160])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0525F1956087;
	Mon,  7 Jul 2025 07:44:35 +0000 (UTC)
Date: Mon, 7 Jul 2025 15:44:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
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
Subject: Re: [PATCH v7 09/10] blk-mq: prevent offlining hk CPUs with
 associated online isolated CPUs
Message-ID: <aGt63lJr2JY8VAqc@fedora>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-9-557aa7eacce4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-isolcpus-io-queues-v7-9-557aa7eacce4@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_004502_467801_9F76B5A1 
X-CRM114-Status: GOOD (  13.31  )
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

On Wed, Jul 02, 2025 at 06:33:59PM +0200, Daniel Wagner wrote:
> When isolcpus=io_queue is enabled, and the last housekeeping CPU for a
> given hctx goes offline, there would be no CPU left to handle I/O. To
> prevent I/O stalls, prevent offlining housekeeping CPUs that are still
> serving isolated CPUs.
> 
> When isolcpus=io_queue is enabled and the last housekeeping CPU
> for a given hctx goes offline, no CPU would be left to handle I/O.
> To prevent I/O stalls, disallow offlining housekeeping CPUs that are
> still serving isolated CPUs.

If you do so, cpu offline is failed, and this change is user visible, please
document the cpu offline failure limit on Documentation/admin-guide/kernel-parameters.txt.
in the next patch.

Thanks,
Ming


