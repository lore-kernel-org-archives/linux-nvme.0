Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2F8E7718B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNCekzdNJZmUuGpzwzOxUn2DY6eci5HZ8lsy1e03Zho=; b=LCaU6Xxl1tT/+AZhXWCjrO1JEg
	uCKyvbd83Whdk9GGuH351m/0in1DbGWjMRCWVl61YjW6i7Ih/JR8Mp61aB07y9+e8reC9MOaD2q8G
	YYwMGqkADlEsCzTQTl5LL/keS1Pt68tm0bc6ynQLmzOa2hAt8HQIq1kigan5NbbQXzXhV6aDmc8ji
	ZOHmDByqr33bH3Ti0DBvqAyYdjNvQm1e2yQCHr81sJ/Dg+p0Flc3yQdF1jBTNnu1X8u4e3ROBgJ/7
	/qHwZAlqTuPSNwudi58TvIMtROcfCHIiLwvhCpqBbens9Aa8rWT5LDwEWYAp9WyFfc6tmf7daTb6j
	Nvck5bhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZSB-00000004RpL-2bpf;
	Fri, 20 Dec 2024 09:37:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOYwI-00000004MoE-3Jh3
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734685493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNCekzdNJZmUuGpzwzOxUn2DY6eci5HZ8lsy1e03Zho=;
	b=SEuGnJVvW27H54VFC6K1jq2v6R/kGJhhpoM6PGv22B4ahsO7kCeLH7sPAgjpv79ur9PHDB
	RjTRvqWn4fOhSQluilB/WcCJ33uwrhjER+pAHuokCht5VCzq2OnNnB2U7eUJ5oJ05+r4K8
	iK2wG0kxn5rSFROel3t44LS12Mlw/qc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-V_hpjVgqOaWhO_PeQOMseg-1; Fri,
 20 Dec 2024 04:04:50 -0500
X-MC-Unique: V_hpjVgqOaWhO_PeQOMseg-1
X-Mimecast-MFC-AGG-ID: V_hpjVgqOaWhO_PeQOMseg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53E431956048;
	Fri, 20 Dec 2024 09:04:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.29])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4FDE195608A;
	Fri, 20 Dec 2024 09:04:24 +0000 (UTC)
Date: Fri, 20 Dec 2024 17:04:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Don Brace <don.brace@microchip.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	storagedev@microchip.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] blk-mq: issue warning when offlining hctx with
 online isolcpus
Message-ID: <Z2UzE-CGa7YVwx0f@fedora>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-9-5d355fbb1e14@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-isolcpus-io-queues-v4-9-5d355fbb1e14@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_010454_900007_FB5EA81E 
X-CRM114-Status: GOOD (  14.39  )
X-Mailman-Approved-At: Fri, 20 Dec 2024 01:37:11 -0800
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

On Tue, Dec 17, 2024 at 07:29:43PM +0100, Daniel Wagner wrote:
> When we offlining a hardware context which also serves isolcpus mapped
> to it, any IO issued by the isolcpus will stall as there is nothing
> which handles the interrupts etc.
> 
> This configuration/setup is not supported at this point thus just issue
> a warning.

As I mentioned on patch 8, this io hang is regression on existed
applications which can work just fine with 'isolcpus=managed_irq'.

Do you think the added warning will prevent people from complaining
the regression? :-)


Thanks,
Ming


