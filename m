Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EFFC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIQcG5FO1t1dwBgbjesyFrp5oZhWz2TAgUNaz2nbA14=; b=x1NkmZlPuAShNH7QH9L05w0Bf/
	aRZyhgE2HEwEeMtyL9JtLbkIfO/jNDJOTbHEDr0Fci4KYPzWV4bHcfM6BqdHjjpulz99pv4lYAjfb
	emXGyKaEzcXd7rmiPiMKKR+UoRlgIOzeLxf/lh/q0xS7GmR+qaDYlB/uT+sb+LF5mnVKekPcmnUsr
	HK/QT4OOBkb3xZLQqVxZFP8E5/OuRqyAMd/ofVcyZbrWAugYjUpQVU2Yf6yvrSxzp3FhgM1dnOAep
	6QkZg9AnQF9DvFsayPEwqLJLtLfJ1F56KtYN5+uPyfL/a8A2vPpyGM1CownCEOtcIz11CxsrxIGRP
	LzlR+ycA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MOh-0000000GzxB-1XFg;
	Tue, 21 May 2024 10:07:07 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MOe-0000000GzwZ-0l5E
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 10:07:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 317CDCE0EE8;
	Tue, 21 May 2024 10:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1005FC2BD11;
	Tue, 21 May 2024 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716286021;
	bh=jqZc2bJtxtIBJwM/97UqABA4R2EDya0YKbUlffFLnUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6ph+UgqyXtfZIRxRb/DfroOOuKcv1Gl/t/19hLlpXi7xxFMMW8HxBAiNjdXp6Lgr
	 CXMT36Inc8sua/bFzVdlBdwCudNKe6WAb9+avJoIgXehtW6xKAwRXr5KYkGroWvVxI
	 gK8PBa5AoSB1BLO+G+enX1PqVj3IVJCWsoX4Pr6MDMDH3kW4MzHQTDlqg+msX8PlqY
	 SQHimPMaoiXTfRexnlALwPGwXht0OrD3OWKM5sTZSV348deu39cs+eSFpd3m0IDTph
	 noeiKda1I/kRhB6V4HlIlFioB0HuOgL7FPbqRq2D+ipUbt9YGHo2NK5sV9wSfEWuqo
	 dc9IEjN2wVGXA==
Date: Tue, 21 May 2024 12:06:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkxyQmR0cpT7-zKY@localhost.localdomain>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
 <87r0e7mt9w.ffs@tglx>
 <20240520153742.GB921@lst.de>
 <ZkwHnw6HkGFFq7mR@fedora>
 <87a5kjimpq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5kjimpq.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_030704_542342_25C28807 
X-CRM114-Status: GOOD (  18.83  )
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

Le Tue, May 21, 2024 at 10:38:25AM +0200, Thomas Gleixner a écrit :
> On Tue, May 21 2024 at 10:31, Ming Lei wrote:
> 
> > On Mon, May 20, 2024 at 05:37:42PM +0200, Christoph Hellwig wrote:
> >> On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
> >> > That's expected as you pin the I/O operation on the isolated CPUs which
> >> > in turn makes them use the per CPU queue.
> >> > 
> >> > The isolated CPUs are only excluded for device management interrupts,
> >> > but not for the affinity spread of the queues.
> >> 
> >> We'll probably need a version of isolcpus that also excludes the
> >> interrupt spread given that users are asking for it.  And I'd much
> >> prefer that over adding radom module options to every driver to disable
> >> managed interrupts.
> >
> > BTW, isolcpus has been marked as deprecated, and it can't be adjust
> > runtime.
> 
> Which is far from reality as cpusets do not allow to do what isolcpus
> does today.
> 
> Also runtime adjusting managed interrupts needs way more thoughts.

I'll remove that comment (unless someone beats me at it?). We used to think
that cpusets would indeed deprecate isolcpus but for several reasons this
will never be the case.

Thanks.

