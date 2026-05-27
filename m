Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650E2CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2kDOEHTAVXsJ8p+1XJC3siM1N1XJmdh0X1046Pwc3ZI=; b=4ytMVFmnQW99mD/os5voY7cavr
	b4BEraT3jaxva40+/VqdsaNKu9VSwj2Twtq5EON2ZDIaCinlaAKbNL5yxBCxa1UlNm7FH2O4nb9lD
	oQg8nvfGRYOsrGqofgqQMP+/6waFBZMJ98yUelDTib4WXWo4sZ4fJeFe+dN6Jo9PQUMFBb4wcf5mi
	QbB0wtAMgZQJuMnQr9OfGeGDovoVqZ3JVTT94q1PlR/GjPtdvVgT2J/Qf0iAJyLMWZcMJJDJRudnA
	EpfWJIoxrfN5WU+tu3j9wf9ilzv2fAPZI608i8aSMMl8QJ4vfpEzrKssNViDd8ZUUSTBZxGgjbhjB
	VDnrPB8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSG48-00000004Obt-0g1V;
	Wed, 27 May 2026 15:21:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSG47-00000004ObS-2sSc
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:21:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B6553602E2;
	Wed, 27 May 2026 15:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1492F1F000E9;
	Wed, 27 May 2026 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895262;
	bh=2kDOEHTAVXsJ8p+1XJC3siM1N1XJmdh0X1046Pwc3ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q7ctsfOMOJm7A45J6fWGrWpuJjRLzTlQW1CgUT32VVkgLo79uHsvZ8gC6wWVcYg1j
	 kbRhxueEE3D1nVJLSnZAn4lVgAN0fsOvrbcnWUcMqAsp1XfWSaVxzFCxQAUV0LO1T6
	 yyelRFRkg6ZKDu+8Y3jlY+S/z7yeo/QMUEkqj0AS07ERBLihDqf7b4fDo2iFACqsjI
	 nswJ9s+nMkU14lPgKVtbxqjn+15eYqDVGjjmA7Eq1PT/J8+6fAK+p7S2+2Jo8ArdLW
	 2IFMHq1cpw5lwLPswjLvba1i0qFsfuY4fxWxbm5Q3CpmNt7E9GkH7HE6vdo4ZurNr9
	 lre4BGLZu/rAw==
Date: Wed, 27 May 2026 09:21:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] bvec: make the bvec_iter helpers inline functions
Message-ID: <ahcL3GaCxRoPnPBT@kbusch-mbp>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-4-hch@lst.de>
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

On Wed, May 27, 2026 at 05:10:22PM +0200, Christoph Hellwig wrote:
> The macros are impossible to follow due to the lack of visual type
> information and all the braces.  Replace them with inline helpers to
> improve on that.  Because the calling conventions are a bit problematic
> with a lot of passing structures by value, all the helpers are marked
> as __always_inline so that they are force inlined.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

