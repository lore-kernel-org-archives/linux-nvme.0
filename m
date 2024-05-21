Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A03BC25B75
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 08:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9EBxGA62sPS5tkIrqIPbzKOO4Z8UW4B2EcNsRchc6hw=; b=uPiYTGpnujHGKQM/kD63tzAGHt
	k4uG3soqx5gGJcMNe/zi717zIg801PwNNKRdAQqR+RzXABacG/rWkZAuBUxX0zI9vtQNm8VqydmNo
	fhuoiY0icIBNsS9GmSqmkFq1yjwKIauSnlGZuI97RgkXrLV2JQHGxVOpEno/tKPQQ/sPAz9BGmRHy
	kDOdJuie6TnjGvKGQjC88+VugJpe907h8bMvohJMLgeLOP280VEUdvSoQi2i5rKftPNPxusPFWcz8
	xZvorG1HT+17pubGaRT3G1RBhLWyDPEWJ556W4QZQk3n26id9lhSJ591kKncurOtnuRQ14BrcwY6y
	6N6yKjbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9L16-0000000GnXl-2SXt;
	Tue, 21 May 2024 08:38:40 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9L0z-0000000GnVk-30Tv
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 08:38:37 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716280705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EBxGA62sPS5tkIrqIPbzKOO4Z8UW4B2EcNsRchc6hw=;
	b=ygfBtFLtHfRnmQ2px15ELOxug0Y1KQVXaK1ppgsKNwkeDOQRz0Klx2yIVcyWPhBqTapTGD
	/cxBN+65zGC5TyULEsHz+xP9wSE+qjBgAaTGbj1WQx9WsWE+ibA+pb4WE2ZTkG+gaI3s6S
	FWL8sP6lk+8zbtsmSf8TkR1iPUQ7HQJ76kxO2A4CgVEedVZ8WVEDEdD/gJ77Debo9wiaGn
	F3XFk7i/EHZ6jRPiGM8QbrvkojUa78NhnpLNW6mHsHxkU7F5gGih8rOEoK449/6r2yFiie
	7Xnc0Fcfe9OUS5q+jLmpIkFEhX1zjKccemZ7Wfidv/rTnXy4a7/b0PhPtuiEkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716280705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EBxGA62sPS5tkIrqIPbzKOO4Z8UW4B2EcNsRchc6hw=;
	b=OprfSqskTBJL2IflXnVh7+N1+Gk6FYsfFQLL8jaA3P7QMGnfVcWFG/0KLNI18Bizi0cY6Z
	g4ant+ntddR++2Ag==
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
In-Reply-To: <ZkwHnw6HkGFFq7mR@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com> <87r0e7mt9w.ffs@tglx>
 <20240520153742.GB921@lst.de> <ZkwHnw6HkGFFq7mR@fedora>
Date: Tue, 21 May 2024 10:38:25 +0200
Message-ID: <87a5kjimpq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_013833_998200_20977AA5 
X-CRM114-Status: GOOD (  14.07  )
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

On Tue, May 21 2024 at 10:31, Ming Lei wrote:

> On Mon, May 20, 2024 at 05:37:42PM +0200, Christoph Hellwig wrote:
>> On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
>> > That's expected as you pin the I/O operation on the isolated CPUs which
>> > in turn makes them use the per CPU queue.
>> > 
>> > The isolated CPUs are only excluded for device management interrupts,
>> > but not for the affinity spread of the queues.
>> 
>> We'll probably need a version of isolcpus that also excludes the
>> interrupt spread given that users are asking for it.  And I'd much
>> prefer that over adding radom module options to every driver to disable
>> managed interrupts.
>
> BTW, isolcpus has been marked as deprecated, and it can't be adjust
> runtime.

Which is far from reality as cpusets do not allow to do what isolcpus
does today.

Also runtime adjusting managed interrupts needs way more thoughts.

Thanks

        tglx

