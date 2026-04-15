Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728C9F41997
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lJvdUxUUPaebZ87OfEcbBiQ0Cb+WI4qRuhXO7Cgjo1w=; b=mSpthG4xKGQekrKdJHRQUSk+78
	lkKuWy9Hjw9ihCtWOBOAgEOF+hnwhjRTLYYauWlEJ3p7CJj5KeOUDndzCi1MFnJnn9AW0sx9EX1S9
	FL5t2hUrULZcUgwG7yxbG2pL88NEAi0ge8X9VNw578+FsGGz3xz8TdDj+Vm1epN0+l/boSDIx1mPb
	eK0yX/dbXwoS60Pb7ksjhyQnMp4fHXJIoqOfCa5kCyHg4iJBJSQDqMSnJL7Ne4c5lPaDA6wvVovSa
	wQNa6UwmI0zNkbe+Bi7FTcptmQRhptkwb0/VHFW8f1ZwPauzCPGnjJbc5NIOQO3GqDDZiw6VINokr
	PZp7mWKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCz4E-000000016AZ-2ZeF;
	Wed, 15 Apr 2026 12:10:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCviH-00000000pZK-1REy
	for linux-nvme@bombadil.infradead.org;
	Wed, 15 Apr 2026 08:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lJvdUxUUPaebZ87OfEcbBiQ0Cb+WI4qRuhXO7Cgjo1w=; b=JrSZOIx+oHN/7iclKUHmAQyyWS
	6zH2uJ1asoYHnB1dmkhFKlN3/2B2t+DXzWMj4re4hIuJmHQKMdUffLDUUtbl1KZXQSzgBgtlvC6Nr
	tvhBKxxDpZN3PKpQiOZtPo2yGjik56/iG8KpVcZ/TsSp14EoMMpoRecUi7DREH6QmcZSMGIHGTlbE
	+DtQdu0DqpEGRq0VbvGm3oQfk94z1qbBg1IulTuR9gLRedcp5wCwbRDoov87DTaGFgwehwhRt0g8c
	L5xUn1FVFCehjVXe/PQf8dyx7vugnHWzWKbpRbUSsW7sIzQazMd0SzMjTmFQ1XNMQXgY0NCUwfQLv
	3P8+nQmA==;
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCviC-000000025VD-3qBF
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 08:35:07 +0000
Date: Wed, 15 Apr 2026 10:34:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776242100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJvdUxUUPaebZ87OfEcbBiQ0Cb+WI4qRuhXO7Cgjo1w=;
	b=07EG34PdGxTG6ncahJqEGpSFi2vmyg11FXnNJb2fSf1QdcF62LbTQ5VRospF7lcKzVwfux
	e4mYk3YPz8FuePLL6dmn2/8irypzy+9t2fWJN8bWaqRqwd8hNWYAQT8jiL6s5ktoOUfq2/
	wFEnvWw9l3snNypme9XYruxUTinW2EXm14h2PMggUY4o0J9jw7JVcRI+NT3M8DIx85ixWq
	ZIETR2daLhGrPF5yPK9o8bmqXdQJbVLG57O75Us2n0TdiIvkcvmDmuyIqW4uG62eoNW9ww
	P8eGR3UeBYrsErhP+UwykZw2UvY/i/IMqN92LL6Rh9HKmmDi+DRNefdzLuNT/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776242100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJvdUxUUPaebZ87OfEcbBiQ0Cb+WI4qRuhXO7Cgjo1w=;
	b=5aK9zNFAQwnRroDNDQ+XYuEPmdTdVkZP2V2Fgiw8ZMZ9rvNOr2JZaCkXfABWb0rlsw9ZqL
	v/+4GiC2syrrF5Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Ming Lei <ming.lei@redhat.com>,
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org,
	longman@redhat.com, chenridong@huawei.com, hare@suse.de,
	kch@nvidia.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com,
	neelx@suse.com, mproche@gmail.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <20260415083458.UD3cF5IQ@linutronix.de>
References: <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora>
 <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
 <adpD8M8cNu3IZzEL@fedora>
 <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
 <ad0Hk48y5JEeMlFk@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad0Hk48y5JEeMlFk@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_093506_095847_FF701F6A 
X-CRM114-Status: GOOD (  13.29  )
X-Mailman-Approved-At: Wed, 15 Apr 2026 05:10:01 -0700
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

On 2026-04-13 23:11:15 [+0800], Ming Lei wrote:
> > > What matters is that IO won't interrupt isolated CPU.
> > 
> > The isolcpus=managed_irq acts as a "best effort" avoidance algorithm rather
> > than a strict, unbreakable constraint. This is indicated in the proposed
> > changes to Documentation/core-api/irq/managed_irq.rst [1].
> 
> Yes, it is "best effort", but isolated cpu is only take as effective CPU
> for the hw queue's irq iff all others are offline. Which is just fine for typical
> use cases, in which IO isn't submitted from isolated CPU.

Couldn't we tackle this by limiting the number of managed interrupts the
device asks for and then limiting the CPUs it could be bound to?

So if have house keeping CPUs 0/1 and isolated 2-63 then managed_irq= is
futile since it use 64 interrupts and map each to one CPU. Even if the
device supports less it would map them evenly across available CPUs.

If the user wishes to initiate I/O from all CPUs but not be bother by
interrupts we could limit the device to ask for 2 interrupts instead of
64 (with the consequence of more queue sharing) and then limit those two
interrupts to CPU 0 and 1 instead to CPU 0-31 and 32-63 like it would be
now the case.

Wouldn't that be what the io_queue flag tries to do?

> Thanks, 
> Ming

Sebastian

