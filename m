Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AE8F31E24
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cf9B6qVrP1bgRDKEPgwYFOrfy8peSUb1Uft91wqXmNg=; b=tFn5EttSbYOeuSnjFMHLY+Wbxq
	L3gF+emVJgmc+uC7bToO2J2UL4h3u7h7W8EJ3L5ivqIfnf9Q2dW2bAKM9o3zhp2Cp2CW6C+L8Pr/3
	Rzfg+ZXZlK71IVwvRyQnc4HwmFS+KEuGwX70a4rW+8SqAwjWwAkox97HI41tmGYHAR3k9v2/ggirG
	auYFUt7dxSCSE4vY9e2Tqqq6w/ToVyaK0b6uPCcUVyiOHOZylJQiKnjwzOPmSm/C3v0cnBUohB90g
	iwjNo5H3oT+mnyBSSleTRwW0EQulwzgzIPracjnM6uOSXV1zvP+pEmU7fyhAUmx0xhkWSu+Y5wsO9
	Og8j3++A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqzO-0000000AlOF-12nX;
	Thu, 09 Apr 2026 15:08:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqrv-0000000AkmG-0NF0
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 15:00:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775746825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cf9B6qVrP1bgRDKEPgwYFOrfy8peSUb1Uft91wqXmNg=;
	b=hwedqR/p0O6y1rp/HU8TxNQ9sgPH8BN/KEAnvhOVFj5L5Gmmni3nuLNiT8Dyi1XDhAThTX
	AvupUWhj4WPz5ZUmD1AjOTsj5ueqD854UxMDMM9fdtq+oQYrbsAR5lNvIEo3oL41zQAsrK
	cy66/CIeRnDjIOUmyaquAKSbLsTw+7s=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-HA-tNlOBM9iQ7OX-2oridw-1; Thu, 09 Apr 2026 11:00:23 -0400
X-MC-Unique: HA-tNlOBM9iQ7OX-2oridw-1
X-Mimecast-MFC-AGG-ID: HA-tNlOBM9iQ7OX-2oridw_1775746823
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-60521f54387so340375137.1
        for <linux-nvme@lists.infradead.org>; Thu, 09 Apr 2026 08:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746823; x=1776351623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cf9B6qVrP1bgRDKEPgwYFOrfy8peSUb1Uft91wqXmNg=;
        b=c2a7GgLvKSYiH64vVr0Ig0dPB906lhbIzltkJ5q5BapV7McEnQQPAQFa9te0QQ0wMI
         hVabuPHVSblqYfMWvVpvc4OdQ8wDnKQQ5ZemOVULMpN2K2QTHqJ9d3kc9rKobJTt7nI7
         0zPwTzOJxYbD56l9ZcvRfBP+E+rstVDiYJYWf5EObwFXc73OMXcWz2vA6vMjYWsJ37ej
         1Z56p+84p4lLVwchluFBaYDi/IMq3zmBWODxdX2qrzoWT5S/0aI7R3F8/h84olj8yOug
         N/BmyVwmHDgorHDO/IeKSPH4fuRfovzyuTTF0D/2sF6KrtzToF+ebBDq57gXEmwLkHGf
         ankg==
X-Forwarded-Encrypted: i=1; AJvYcCWpUaz2vDWk9G2Y714TCsyp6PJ8ADWtqvsxYbB1cRTswfC+qIP2FutV/y/xmW8DYxO/7JALGhNH6fic@lists.infradead.org
X-Gm-Message-State: AOJu0YxPNRx3wMObzZq1ygn1jLbhGEeqiLoXH6ZZsJ+JhmX0ke19LumJ
	mqtYLwo+O1dCBALpe60SfFyvto+CAKHI5U6xcAEYX/2Ksb3V978p2xuP2y5zd0gwI6YaiDOjICV
	JJYDaqXObfiQbb/bdaN3KYaD8q8z316abfC8GmqiEyzqm8V/aIHKWhiOnI+j111QkDa9hgZs11o
	Xv6+WwJ64I78hFLDSTj40ZSo9jIk7EsDAH9lavS7Ic1rs=
X-Gm-Gg: AeBDieto9aKGUkUv5C7J+vvIIObszgSBO1Js4yeIwic4090b6+y3DivFJQpLuA5X2Vr
	sfM6its2FWvqhERUWTfwwrJaV5bkzqcuCp2ms0iDxbcxb4d8BTtr0Z/T/WlhUkKqyXDv55huWa7
	5OrDHeeVj81azZNBMycYcaCcu6zmINWVZ9x8y+H8IERELznd7eqLcyDXdCdgq8IY+TkxDkZ2TIG
	zBvbrguFduT6WOcvBpIbFRA9YPuhqurQOEtXdw=
X-Received: by 2002:a67:e713:0:b0:608:1b6e:f4dc with SMTP id ada2fe7eead31-6081b6ef921mr2784438137.11.1775746823140;
        Thu, 09 Apr 2026 08:00:23 -0700 (PDT)
X-Received: by 2002:a67:e713:0:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-6081b6ef921mr2784399137.11.1775746822118; Thu, 09 Apr 2026
 08:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260401222312.772334-1-atomlin@atomlin.com> <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora> <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora> <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
In-Reply-To: <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 9 Apr 2026 23:00:09 +0800
X-Gm-Features: AQROBzBGMQxEgwdm4UZJAa6NOKwn3RLk5aSwu5C0sv3kx4PGZQZHIp5V15VSUxk
Message-ID: <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, 
	sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, 
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com, hare@suse.de, 
	kch@nvidia.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com, 
	neelx@suse.com, mproche@gmail.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, "Lei, Ming" <tom.leiming@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _yxR6HCrtxhuPWZm8WWGjUIQrPMVzDTIRqqoiAxKnCU_1775746823
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_080031_200052_5DA49C76 
X-CRM114-Status: GOOD (  34.71  )
X-Mailman-Approved-At: Thu, 09 Apr 2026 08:08:12 -0700
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

On Wed, Apr 8, 2026 at 11:58=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> On Mon, Apr 06, 2026 at 11:29:38AM +0800, Ming Lei wrote:
> > I don't think there is such breaking isolation thing. For iopoll, if
> > applications won't submit polled IO on isolated CPUs, everything is jus=
t
> > fine. If they do it, IO may be reaped from isolated CPUs, that is just =
their
> > choice, anything is wrong?
>
> Hi Ming,
>
> Thank you for your follow up. You make a fair point regarding polling
> queues and application choice; if an application explicitly binds to an
> isolated CPU and submits polled operations, it is indeed actively electin=
g
> to utilise that core and accept the resulting behaviour.
>
> However, the architectural challenge arises from how the kernel handles
> these queues structurally when the application does not explicitly make
> that choice. Because poll queues never utilise interrupts, they are
> completely invisible to the managed interrupt subsystem.
>
> If we were to rely exclusively on the managed irq flag, the block layer
> would blindly map these non interrupt driven polling queues to isolated
> CPUs. If a general background storage operation were then routed to
> that queue, the isolated core would be forced to spin actively in a tight

How can the isolated core be scheduled for running polling task?

Who triggered it?

> loop waiting for the hardware completion. This would completely monopolis=
e
> the core and destroy any real time isolation guarantees without the user
> space application ever having requested it.

No.

IOPOLL queue doesn't have interrupt, and the ->poll() is only run from
the submission context.  So if you don't submitted polled IO on isolated
CPU cores, everything is just fine.  This is simpler than irq IO actually.

>
> This illustrates precisely why the io queue flag is a mechanical necessit=
y.
> Its primary objective is to act as a comprehensive block layer isolation
> boundary. It structurally restricts both hardware queue placement and
> managed interrupt affinity strictly to housekeeping CPUs, ensuring that n=
o
> storage queue operations of any kind are mapped to an isolated CPU.
>
> To achieve this reliably, this series expands the struct irq affinity
> structure to incorporate a new CPU mask [1]. This mask is explicitly set =
to
> the result of blk mq online queue affinity. By passing this housekeeping
> mask directly through the interrupt affinity parameters, we ensure that t=
he
> native affinity calculation is strictly bounded to non isolated CPUs from
> the moment the device probes.
>
> This structural enhancement allows device drivers to seamlessly inherit t=
he
> isolation constraints without requiring bespoke, driver specific logic. A
> clear example of this application can be seen in the modifications to the
> Broadcom MPI3 Storage Controller [2]. By leveraging the expanded struct i=
rq
> affinity, the driver guarantees that its queues and corresponding managed
> interrupts are perfectly aligned with the system housekeeping
> configuration, completely avoiding the isolated CPUs during allocation.
>
> [1]: https://lore.kernel.org/lkml/20260401222312.772334-5-atomlin@atomlin=
.com/
> [2]: https://lore.kernel.org/lkml/20260401222312.772334-8-atomlin@atomlin=
.com/
>
> I hope this better illustrates the mechanical necessity of the io_queue
> flag and the corresponding changes to the interrupt affinity structures.

Can you share one example in which managed irq can't address?

>
> > > Every logical CPU, including the isolated ones, must logically map to=
 a
> > > hardware context in order to submit input and output requests, saying=
 they
> > > are completely restricted is indeed stale and technically inaccurate.=
 The
> > > isolation mechanism actually ensures that the hardware contexts thems=
elves
> > > are serviced by the housekeeping CPUs, while the isolated CPUs are si=
mply
> > > mapped onto these housekeeping queues for submission purposes. I will
> > > rewrite this paragraph to accurately reflect this topology, ensuring =
it
> > > aligns perfectly with the behaviour introduced in patch 10.
> >
> > I am not sure if the above words is helpful from administrator viewpoin=
t about
> > the two kernel parameters.
> >
> > IMO, only two differences from this viewpoint:
> >
> > 1) `io_queue` may reduce nr_hw_queues
> >
> > 2) when application submits IO from isolated CPUs, `io_queue` can compl=
ete
> > IO from housekeeping CPUs.
>
> Acknowledged.

Are there other major differences besides the two mentioned above?

Thanks,
Ming


