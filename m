Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0789CC74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 14:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFaYWfMNcOhkgAqXfnLhMpfUKThfse0w3Tidaov9hJ4=; b=nseNUrLqRXUguopYCe/Y8/54cg
	WFh93VrOatE7uXAHmshhXwpe1bPP9nCMVIXOs4Ju8DeKmRpzasVAoYdMPF6keL1eseSbpX0e7Kbld
	3Bi+rrqLe4WWo9r7slxenOMkWr3pHTD4Yake2y+9CLX4JNQi1Vx0xT3VnN73O7lF72YRKY0q2g0eT
	hZMNE9NThkbKW88zAVT8Y5sQQVSMabo6dhjiS9G3Bk2AO8pYkkWtykZs4IdNNQ6UlFb4hd0+guJIp
	78/JHpaU/dNvBpxm0PyV0R04fJqdq7Z0MCYZu/eNns4IG7XtWIj3Uvs6wwSDP3F7zKLninrKtcCgg
	xMeq5z+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pezUT-00GJ4p-1Y;
	Wed, 22 Mar 2023 14:31:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pezUP-00GJ2B-2o
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 14:31:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 88F5C62125;
	Wed, 22 Mar 2023 14:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7513FC433D2;
	Wed, 22 Mar 2023 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679495450;
	bh=wKeBG+Ixle96ci/1iogQ3xq7f2RG9f52S0T8Z8IffII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdKFixtAcS8OGWyW255UStfpYAXjuSYDtwRQCpQgXGOHc+AGr3F5sIwzgWpY8ADfj
	 jVjEoR42FDgElVLJioNITIsjc5XLWXum1i5LT67IkPbezsJ6zmLJC+hGvhc4HDl+T+
	 QRwgHxp+1Yu4BY/bsakeL0p1J6NjL78BQLjopsNUmUARNYEIY6TshZuWJN4Kv8WsCD
	 K9mLkW0f8+8H2to4xoA8CR3UvFp72F3kKP7KmwSA/vUOnk7pMD8r2+UIeGCJcbia0y
	 9YsEVr+KxqiifUxhNuk+yRDkNmnJtUMoiJClGnCzEZKgcIlw6q7UU/sq+d3DEn4KZK
	 2oDWhtXVjBkDA==
Date: Wed, 22 Mar 2023 08:30:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <ZBsRFgMkK7qf0Lsx@kbusch-mbp.dhcp.thefacebook.com>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-3-kbusch@meta.com>
 <20230322082310.GA22782@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322082310.GA22782@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_073058_952450_6D803C9F 
X-CRM114-Status: GOOD (  15.99  )
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

On Wed, Mar 22, 2023 at 09:23:10AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 21, 2023 at 05:23:49PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > This is for mostly for testing purposes.
> 
> I have to admit I'd rather not merge this upstream.  Any good reason
> why we'd absolutely would want to have it?

The only value is that it's the easiest fabric to exercise some of these
generic code paths, and it's how I validated the fix in patch 3. Otherwise this
is has no other practical use case, so I don't mind dropping it.

Let's just go with patch 3 only from this series. I'll rework patch 1 atop
Sagi's rdma affinity removal since it's a nice cleanup.

