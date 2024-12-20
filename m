Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EF0E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QzjzcdcjxJq94HHw+ivm1Rh4H1wHHh3+V1gm+dCRqaY=; b=UHR24yBI3wlBQ3D4iSBx0Gs20d
	/2g3701bEclMa9608iGSHyEPYk++tRhHUn21JwfiehfYG+/jsnBmF3FDsJepK9xi4hO/RS2tiDsSE
	fBc03KXAh6+MBQW8flea17Vw262xLjAdbHNzhW+qgmjyX8Dr7vUZNzbZvm/MR841h/4b/r66/ZUjl
	9qXmt0J51r7iYNk4/dNT0uNTyrcEIZ/tWSe5JWQGL1gP3xfM7ucG/cNOH2yKn0sG+RaNWbMM2udH3
	EvJqrUJN2quheUF2nlI3MohxU37PjxlSyLvOaD63dCZidyvUng99w3BswecP/uJv2V1R1/4kX7HyT
	OOTYV0Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZSB-00000004RpB-01ly;
	Fri, 20 Dec 2024 09:37:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOYmg-00000004LDC-3jJJ
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 08:55:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734684897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzjzcdcjxJq94HHw+ivm1Rh4H1wHHh3+V1gm+dCRqaY=;
	b=e9C+spFe3IrhC0L606a+USkBw7Inf6Ix8QLDRL4N56SO+RBdrhUAGq4DB2wsVY93YJtrfJ
	PJ/3JmbWthZXOXO8nmCJmVt8eTGP4fjkHnj+OdrImT067/pzvZ3iCuBgKRCZzxU6N/WCR8
	SC2S+fzSGWmPfBU2IG9FzATtQgHg0/E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-AQ6ceaTROi2gD8kt32fNWQ-1; Fri,
 20 Dec 2024 03:54:54 -0500
X-MC-Unique: AQ6ceaTROi2gD8kt32fNWQ-1
X-Mimecast-MFC-AGG-ID: AQ6ceaTROi2gD8kt32fNWQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C293B19560B1;
	Fri, 20 Dec 2024 08:54:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.29])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85E3F19560AD;
	Fri, 20 Dec 2024 08:54:26 +0000 (UTC)
Date: Fri, 20 Dec 2024 16:54:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
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
Subject: Re: [PATCH v4 8/9] blk-mq: use hk cpus only when
 isolcpus=managed_irq is enabled
Message-ID: <Z2UwvQoDM3f4zAxG@fedora>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-8-5d355fbb1e14@kernel.org>
 <Z2PlbL0XYTQ_LxTw@fedora>
 <cc5e44dd-e1dc-4f24-88d9-ce45a8b0794f@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc5e44dd-e1dc-4f24-88d9-ce45a8b0794f@flourine.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_005459_003007_71571AAC 
X-CRM114-Status: GOOD (  24.02  )
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

On Thu, Dec 19, 2024 at 04:38:43PM +0100, Daniel Wagner wrote:

> When isolcpus=managed_irq is enabled all hardware queues should run on
> the housekeeping CPUs only. Thus ignore the affinity mask provided by
> the driver.

Compared with in-tree code, the above words are misleading.

- irq core code respects isolated CPUs by trying to exclude isolated
CPUs from effective masks

- blk-mq won't schedule blockd on isolated CPUs

If application aren't run on isolated CPUs, IO interrupt usually won't
be triggered on isolated CPUs, so isolated CPUs are _not_ ignored.

> On Thu, Dec 19, 2024 at 05:20:44PM +0800, Ming Lei wrote:
> > > +	cpumask_andnot(isol_mask,
> > > +		       cpu_possible_mask,
> > > +		       housekeeping_cpumask(HK_TYPE_MANAGED_IRQ));
> > > +
> > > +	for_each_cpu(cpu, isol_mask) {
> > > +		qmap->mq_map[cpu] = qmap->queue_offset + queue;
> > > +		queue = (queue + 1) % qmap->nr_queues;
> > > +	}
> > 
> > Looks the IO hang issue in V3 isn't addressed yet, is it?
> > 
> > https://lore.kernel.org/linux-block/ZrtX4pzqwVUEgIPS@fedora/
> 
> I've added an explanation in the cover letter why this is not
> addressed. From the cover letter:
> 
> I've experimented for a while and all solutions I came up were horrible
> hacks (the hotpath needs to be touched) and I don't want to slow down all
> other users (which are almost everyone). IMO, it's just not worth trying

IMO, this patchset is one improvement on existed best-effort approach, which
works fine most of times, so why you do think it slows down everyone?

> to fix this corner case. If the user is using isolcpus and does CPU
> hotplug, we can expect that the user can also first offline the isolated
> CPUs. I've discussed this topic during ALPSS and the room came to the
> same conclusion. Thus I just added a patch which issues a warning that
> IOs are likely to hang.

If the change need userspace cooperation for using 'managed_irq', the exact
behavior need to be documented in both this commit and Documentation/admin-guide/kernel-parameters.txt,
instead of cover-letter only.

But this patch does cause regression for old applications which can't
follow the new introduced rule:

	```
	If the user is using isolcpus and does CPU hotplug, we can expect that the
	user can also first offline the isolated CPUs.
	```

Thanks,
Ming


