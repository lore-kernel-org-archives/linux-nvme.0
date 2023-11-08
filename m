Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA2DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QPaa7MF0dhTULqLGYThaKMtJPg5WPSzu68f+oYIVSbQ=; b=qdUPOXU1nMiaXmMnCP3ZMHH9zk
	KzjdVKe3nKRuIwIM0JLLuteXbSnX5aVUIeFlbWEjz3FowajIfxXsA3H763Avs9IL3jSkVuMdvto5O
	Ntyz4hyciGQVeJIRFFXZi5yZZt+Th2R1nlcGQucw5QEujQQYUOOg8dot19Y996DF+IzSx4Ze6hc4G
	s9AeLXzq8OxsuCsvFLrTyh45ge9MTLQne/UoI7mCgKct3smKOPaYTulObwMhiwk84n1wXhVLSHy0q
	KGaS7/wKLoHStgJt9JlsgZ7TfKYdXyi9GT7lFzwL8z1FVUzsGEQMQvM5ba++GMwM+gRtfCdA+p1gi
	khuUl0ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0dd0-003FVO-2a;
	Wed, 08 Nov 2023 08:09:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0dcz-003FVC-2P;
	Wed, 08 Nov 2023 08:09:33 +0000
Date: Wed, 8 Nov 2023 00:09:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org,
	tsong@purestorage.com
Subject: Re: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
Message-ID: <ZUtCPeDYRaGszXnE@infradead.org>
References: <20231107212331.9413-1-emilne@redhat.com>
 <20231107212331.9413-2-emilne@redhat.com>
 <ZUqx7JoyPG1QxYeY@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUqx7JoyPG1QxYeY@kbusch-mbp.dhcp.thefacebook.com>
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

On Tue, Nov 07, 2023 at 02:53:48PM -0700, Keith Busch wrote:
> On Tue, Nov 07, 2023 at 04:23:30PM -0500, Ewan D. Milne wrote:
> > The atomic updates of ctrl->nr_active are unnecessary when using
> > numa or round-robin iopolicy, so avoid that cost on a per-request basis.
> > Clear nr_active when changing iopolicy and do not decrement below zero.
> > (This handles changing the iopolicy while requests are in flight.)
> 
> Oh, here's restricting it to that policy. Any reason not to fold it in
> the first one?

It should, and I agree with all the other comments.

But I'm also pretty deeply unhappy with the whole thing.  This is a
controller-wise atomic taken for every I/O.  How slow are the subsystems
people want to use it for?  And is a global max active really the
right measure, or would e a per-cpu, or at least batched per-cpu as
used by the percpu counters by a better option?


