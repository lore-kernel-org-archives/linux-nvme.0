Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD90C83F0F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0guZz0nxGosC58GUk7QyOJH24N9dOr04NyvpD1yjTvY=; b=4usXpqRAspOOdm3zjX7+6wj0Sb
	BykTOgA0A7R1yi4repV7R+eamQ6uFz0ioBGDgtkwsRz2Fij+qVgWeeZCncWg21sOf3p5L5aH5Ckkb
	HZwwv/KJld/FuXIaC7mpdFjy58ne16IIsJfe/TxK6FVxDZ+xnyc4odCGDvutpLQBXpJuNqXTjTzRX
	pf3SJwRkTduVlSD/NUHoMPrZ8p/DYVkHCBwZMMvwgvvoYCMG0oDEo0ZOKENFMgpIvNYakTecsu/wt
	ETkNxBpVii2rAM0Xg+tnJw1FcRYfLvMXVKbtWiQXurWmLxvzRgn9IWWoJ8M+/0J7MwvSgWHx2Gwbl
	1FH72+cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZX7e-00000009Dnj-2g4V;
	Wed, 09 Jul 2025 15:54:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZV4Z-00000008omn-31K8
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 13:42:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752068573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0guZz0nxGosC58GUk7QyOJH24N9dOr04NyvpD1yjTvY=;
	b=KIxpxpf7DMFEYMdA0dyX/N4hAVp6WBejvZ9Z3hii0KtXGDZQiC0Ob+zP6Pm+dVu5/EzQb+
	WjXKrx3RlqquH9FBUH5/MSaIIfWMj+AaqRL296ddbrNulqBkvQWF6s/h4ypqtrlvqn1JeY
	7+6am93Acc0T+cRWegJRtRc7otxmYDI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-EU70nbJ3MTi2FMwiBFWj9g-1; Wed, 09 Jul 2025 09:42:52 -0400
X-MC-Unique: EU70nbJ3MTi2FMwiBFWj9g-1
X-Mimecast-MFC-AGG-ID: EU70nbJ3MTi2FMwiBFWj9g_1752068571
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453018b4ddeso28544255e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 09 Jul 2025 06:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068571; x=1752673371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0guZz0nxGosC58GUk7QyOJH24N9dOr04NyvpD1yjTvY=;
        b=Oilu0T+b4PEnOUCEEgKVvRHTlOEmXYsMm/9KOQC5fn2IdtUjaH0Z8fV3ddRYmiKrIn
         2o0v5F6LFXX2woJj815dEzvtdZrN2uNpX0dkw8vE4BopTkOvHzQfwAo8JCDMWTFr8uB3
         M2R3jwVoTxjCPtPR1MdNH/C1h3qurZY1d9GqVsspiPwDxme2UUZ+6Tri6w0gYPtSExXS
         bTnBOLxM2sRk2j4jzjNb4FADNG5aAPn+BpetoGkw2bWJ47eBdMamLzf07aGaGNAprmnE
         ctLqaZrBIHd+rQ9Wmt8cj2nbZXd+X0hERY8ZUS8l+xb7lD3BiDmC6H8FUtuRv98RB4eS
         FKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZRGt8mu44VUipcyiq/IAWLtvYpfPdPXm/iRBsIR7o27YqOEAF6H+bqLArhPfbf0boTWj/XAZlguxq@lists.infradead.org
X-Gm-Message-State: AOJu0YwmDcPzrw72Ca5zVTMxCtcJcEtlEKtSThL4QKOm5PBDiunBtVT5
	koRfA5/IvTWeBdjHdaIlnNzN3Xdtv5uaU/5xJtbt1+VFZvJ+an318zuFnH8HKOHi0pJEvPBE3KW
	PAq2GvRZe/cA5bvItwmsI1nLZoJYESpsmKxXQU71eTZQ6QTiJ+KjfUXMFBlDtmV4HqrUc0n1Wfc
	HeCwdAXhOeJxuFllVGjwtDAVBHPosRsieUlg+RbQDrBEtN3gIbkhl5wQ==
X-Gm-Gg: ASbGncuLrULpUBeW0j3A/DIh+ZnUTC0haTW8k1QHhfsoD9dhiRH639mtNCYx35NJE5f
	HxMCw7HIP5+sQjJDAAIieamWj0TVQpvSLvNZr3h9uGQhqXSXAxtaueM33/JKe+8molhIRBc9whR
	/yHptO
X-Received: by 2002:a05:600c:8518:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-454d52fb208mr24824115e9.12.1752068570615;
        Wed, 09 Jul 2025 06:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH89dnCuTL2cmPNRDmvKQh+uZM/OIYRcbHCPQ09jQ4AZOfXPI2kJkY3Dwz8Ha1kZZSib18R9qACe1iJBvTWqmM=
X-Received: by 2002:a05:600c:8518:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-454d52fb208mr24823785e9.12.1752068570157; Wed, 09 Jul 2025
 06:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250624202020.42612-1-bgurney@redhat.com> <CAHhmqcTO_Q59aDr3DywC-tPF=9pe3gxbyn6J4ycdf+eYEOayHQ@mail.gmail.com>
 <19484829-0a7b-42ce-99fe-e74ccda67dce@suse.de> <b0817e2a-1c4e-4d7d-9a84-633913d9e0e4@redhat.com>
 <0db83ea3-83aa-45ef-bafd-6b37da541d22@suse.de>
In-Reply-To: <0db83ea3-83aa-45ef-bafd-6b37da541d22@suse.de>
From: Bryan Gurney <bgurney@redhat.com>
Date: Wed, 9 Jul 2025 09:42:38 -0400
X-Gm-Features: Ac12FXwzG1gS7v9UtZ_ikdOvnf5ZBD8N95qvu58iwnI37g1slCVzvxgwerBnmeQ
Message-ID: <CAHhmqcTNrfjj-ABjTfj7LUCQ_qRtcTrZCzhtaERViaAQut3TUw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] nvme-fc: FPIN link integrity handling
To: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, james.smart@broadcom.com, 
	dick.kennedy@broadcom.com, linux-scsi@vger.kernel.org, njavali@marvell.com, 
	muneendra737@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LM2RxCtpDKTDaKtPq0EAU-wf-5s4j-xjXHlIuVNlYjI_1752068571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_064255_839876_DA2A013D 
X-CRM114-Status: GOOD (  47.14  )
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

On Wed, Jul 9, 2025 at 2:21=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 7/8/25 21:56, John Meneghini wrote:
> > On 7/2/25 2:10 AM, Hannes Reinecke wrote:
> >>> During path fail testing on the numa iopolicy, I found that I/O moves
> >>> off of the marginal path after a first link integrity event is
> >>> received, but if the non-marginal path the I/O is on is disconnected,
> >>> the I/O is transferred onto a marginal path (in testing, sometimes
> >>> I've seen it go to a "marginal optimized" path, and sometimes
> >>> "marginal non-optimized").
> >>>
> >> That is by design.
> >> 'marginal' paths are only evaluated for the 'optimized' path selection=
,
> >> where it's obvious that 'marginal' paths should not be selected as
> >> 'optimized'.
> >
> > I think we might want to change this.  With the NUMA scheduler you can
> > end up with using the non-optimized marginal path.  This happens when
>  > we test with 4 paths (2 optimized and 2 non-optimized) and set all 4
>  > paths to marginal.  In this case> the NUMA scheduler should simply
> choose the optimized marginal path on
> > the closest numa node.  However, that's not what happens. It consistent=
ly
>  > chooses the non-optimized first non-optimized path.>
> Ah. So it seems that the NUMA scheduler needs to be fixed.
> I'll have a look there.
>
> >> For 'non-optimized' the situation is less clear; is the 'non-optimized=
'
> >> path preferrable to 'marginal'? Or the other way round?
> >> So once the 'optimized' path selection returns no paths, _any_ of the
> >> remaining paths are eligible.
> >
> > This is a good question for Broadcom.  I think, with all IO schedulers,
> > as long
> > as there is a non-marginal path available, that path should be used.  S=
o
> > a non-marginal non-optimized path should take precedence over a margina=
l
> > optimized path.
> >
> > In the case were all paths are marginal, I think the scheduler should
> > simply use the first optimized path on the closest numa node.
>
> For the NUMA case, yes. But as I said above, it seems that the NUMA
> scheduler needs to fixes.
>
> >>> The queue-depth iopolicy doesn't change its path selection based on
> >>> the marginal flag, but looking at nvme_queue_depth_path(), I can see
> >>> that there's currently no logic to handle marginal paths.  We're
> >>> developing a patch to address that issue in queue-depth, but we need
> >>> to do more testing.
> >>>
> >> Again, by design.
> >> The whole point of the marginal path patchset is that I/O should
> >> be steered away from the marginal path, but the path itself should
> >> not completely shut off (otherwise we just could have declared the
> >> path as 'faulty' and be done with).
> >> Any I/O on 'marginal' paths should have higher latencies, and higher
> >> latencies should result in higher queue depths on these paths. So
> >> the queue-depth based IO scheduler should to the right thing
> >> automatically.
> >
> > I don't understand this.  The Round-robin scheduler removes marginal
> > paths, why shouldn't the queue-depth and numa scheduler do the same?
> >
> The NUMA scheduler should, that's correct.
>
> >> Always assuming that marginal paths should have higher latencies.
> >> If they haven't then they will be happily selection for I/O.
> >> But then again, if the marginal path does _not_ have highert
> >> latencies why shouldn't we select it for I/O?
> >
> > This may be true with FPIN Congestion Signal, but we are testing Link
> > Integrity.  With FPIN LI I think we want to simply stop using the path.
> > LI has nothing to do with latency.  So unless ALL paths are marginal,
> > the IO scheduler should not be using any marginal path.
> >
> For FPIN LI the paths should be marked as 'faulty', true.
>
> > Do we need another state here?  There is an ask to support FPIN CS, so
> > maybe using the term "marginal" to describe LI is wrong.
> >
> > Maybe we need something like "marginal_li" and "marginal_cs" to describ=
e
> > the difference.
> >
> Really not so sure. I really wonder how a FPIN LI event reflect back on
> the actual I/O. Will the I/O be aborted with an error? Or does the I/O
> continue at a slower pace?
> I would think the latter, and that's the design assumption for this
> patchset. If it's the former and I/O is aborted with an error we are in
> a similar situation like we have with a faulty cable, and we need
> to come up with a different solution.
>

During my testing, I was watching the logs on the test host as I was
about to run the command on the switch to generate the FPIN LI event.
I didn't see any I/O errors, and the I/O continued at the normally
expected throughput and latency.  But "if this had been an actual
emergency..." as the saying goes, there would probably be some kind of
disruption that the event itself would be expected to cause (e.g.:
"loss sync", "loss signal", "link failure"), but

There was a Storage Developer Conference 21 presentation slide deck on
the FPIN LI events that's hosted on the SNIA website [1]; slide 4
shows the problem statements addressed by the notifications.

In my previous career as a system administrator, I remember seeing
strange performance slowdowns on high-volume database servers, and on
searching through the logs, I might find an event from the database
engine about an I/O operating taking over 30 seconds to complete.
Meanwhile, the application using the database was backlogged due to
its queries taking longer, for what ended up being a faulty SFP.
After replacing that, we could get the application running again, to
process its replication and workload backlogs.  The link integrity
events could help alert on these link problems before they turn into
application disruptions.


Thanks,

Bryan

[1] https://www.snia.org/sites/default/files/SDC/2021/pdfs/SNIA-SDC21-Johns=
on-Introducing-Fabric-Notifications-From-Awareness-to-Action.pdf

> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


