Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045CCC25B4F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 01:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ee6/3FEkinVFx7RLpDJuOTr8QVENMJF3bDVMIlYGklw=; b=q9u2+Ddd9x16RUrEDea19HGHyz
	ALjjfkCBSOmsxNH1CLX2DLCyFxKGKylVWiEAAq1dB6feEdmMXw92T/MqFzlT67sJh8H4DzJXfdY7f
	SDzzdcv/KCqUml8mq52c8HqGGLS9KHC4Cnt7VLgNrV0WzmuFSH+PvXqxQVWDKa6QjSdacOv+qIYqC
	001I9dZCzxmu+Xf8NQOrPDzbYS3h8Hrt8kHL8P1SPWIIlLZ6GhnvseNKBnyipvUFvvBO1R47Ydn7M
	TzNppiRF1Iw91/gfug8nupyYM7Lf79eOp71YHzzZiZWTS/jokBdt88nfIsDqoym09trZMRfdZKS+U
	JiTXweyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6KIY-0000000BFMb-3Ljt;
	Mon, 13 May 2024 01:16:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6KIP-0000000BFLd-0uCg
	for linux-nvme@lists.infradead.org;
	Mon, 13 May 2024 01:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715562961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ee6/3FEkinVFx7RLpDJuOTr8QVENMJF3bDVMIlYGklw=;
	b=C02k0x/GK1UCE3EXmVclqn+koW0npSseMBSIcVZ8FR/tDvOBjKkYsIU85GN3t89bV+V9D+
	V7NKLv3ABxMO3PzvLfiQ4mhPuS/PJsqOE3+qF0Hrz10I8dbCYgOPF7c12FJ18bqRkVS9BC
	nHUjc/5NJyq8oUFPlKRDQIofwYUiGw8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-1KGrz948O5qhWtKJvz5ZyA-1; Sun,
 12 May 2024 21:13:06 -0400
X-MC-Unique: 1KGrz948O5qhWtKJvz5ZyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1A921C05157;
	Mon, 13 May 2024 01:13:05 +0000 (UTC)
Received: from fedora (unknown [10.72.112.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9526840C6EB7;
	Mon, 13 May 2024 01:13:02 +0000 (UTC)
Date: Mon, 13 May 2024 09:12:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCHv2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkFpGlEMs4yHL+Xv@fedora>
References: <20240510174645.3987951-1-kbusch@meta.com>
 <Zj6yDtRzl68zspQY@fedora>
 <Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6/gqxxDD74IYR6@fedora>
 <d6e8c980-7be7-4902-b466-79dc4b9beb17@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <d6e8c980-7be7-4902-b466-79dc4b9beb17@grimberg.me>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240512_181605_356095_308DD824 
X-CRM114-Status: GOOD (  15.48  )
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

On Sun, May 12, 2024 at 05:16:13PM +0300, Sagi Grimberg wrote:
> 
> > > Everyone expects nvme performance will suffer. IO latency and CPU
> > > efficieny are not everyone's top priority, so allowing people to
> > > optimize for something else seems like a reasonable request.
> > I guess more people may be interested in 'something else', care to share
> > them in the commit log, cause nvme is going to support it.
> 
> I don't have a special interest in this, but I can share what I heard
> several
> times. The use-case is that people want to dedicate a few cores to handle
> interrupts so they know it does not take cpu time from their application
> threads
> that are running (usually pinned to different cores).
> 
> The app threads isolation is more important to them than affinity to the
> device...

That is exactly what CPU isolation is doing, include 'isolcpus=managed_irq',
isn't it?

Thanks, 
Ming


