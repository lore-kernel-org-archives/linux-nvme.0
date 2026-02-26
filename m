Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458FFFCE08A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nGVLntgS7y17jrtUPVq3eOV3I3Dp+Pz66Cj+hxDGxis=; b=REtft215npzZgKM2b50oHqhchN
	eMGDNeHPqOdo/KzY7vRpl/sAjwTmOkNDzpKhm+yv0gzAbPWBtL0N5lUO8nNOblG2GAyQDrCfm7mMc
	m757HQ9x2k4gQ8SKYT2uFZFcQ21d+ks+HzK6auZsltk++CFypBlJexN2/NHxHbhZVPl8ysRimxlLX
	Fj5jEAhU+yTQlGuKwt7p9eRLaWweM5T0bListqgEWiCV6p9qWzrN0X58pp7l73rXmOC/kcelYTYVw
	Q8E49VDMUXP9QjADJnvNqnpauaIIbP4+xzkhldtWrANgsPvNxO+KyBapKnNu9QcD57akEmxDUJX8D
	G0z3aSxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbyv-00000006HO9-02yT;
	Thu, 26 Feb 2026 14:04:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbyr-00000006HN8-3fGC
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 14:04:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772114679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGVLntgS7y17jrtUPVq3eOV3I3Dp+Pz66Cj+hxDGxis=;
	b=h+OCF7diVnx4f/p57mBWrIoYK8cLcBhSsXB8U6eO7AeppRzhC+NqNucEeV7pJXx87idIxE
	np+PgawXiBeNM3rqelVvVlCcAHwP+sFhM1Dt5skphyh9HDu8AAKNfWSYQaAhpTt/qeQWQm
	40W7/zWNl5jGdsEL76J8DdKLHTMSSPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-cd0trrkZNFKZDEH-N7NXbA-1; Thu,
 26 Feb 2026 09:04:37 -0500
X-MC-Unique: cd0trrkZNFKZDEH-N7NXbA-1
X-Mimecast-MFC-AGG-ID: cd0trrkZNFKZDEH-N7NXbA_1772114675
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED52D1956079;
	Thu, 26 Feb 2026 14:04:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.93])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EE591956053;
	Thu, 26 Feb 2026 14:04:25 +0000 (UTC)
Date: Thu, 26 Feb 2026 22:04:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] Revert "lib/group_cpus.c: avoid acquiring cpu
 hotplug lock in group_cpus_evenly"
Message-ID: <aaBS4pvtiFHL1LSz@fedora>
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
 <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 63-EnvEnetIMDSxzCse1NPSFGClapaCznPxMVrq9xvg_1772114675
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_060442_048482_61AB1995 
X-CRM114-Status: GOOD (  15.25  )
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

On Thu, Feb 26, 2026 at 02:40:37PM +0100, Daniel Wagner wrote:
> This reverts commit 0263f92fadbb9d294d5971ac57743f882c93b2b3.
> 
> The reason the lock was removed was that the nvme-pci driver reset
> handler attempted to acquire the CPU read lock during CPU hotplug
> offlining (holds the CPU write lock). Consequently, the block layer
> offline notifier callback could not progress because in-flight requests
> were detected.
> 
> Since then, in-flight detection has been improved, and the nvme-pci
> driver now explicitly updates the hctx state when it is safe to ignore
> detected in-flight requests. As a result, it's possible to reintroduce
> the CPU read lock in group_cpus_evenly.

Can you explain your motivation a bit? Especially adding back the lock
causes the API hard to use. Any benefit?


Thanks, 
Ming


