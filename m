Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248FBC88E72
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrLppnrQYU9X/7lNEqnP9eIKSAA0eVenLVLPftEA0EY=; b=mvLx1l0SZ+2cq6LoIGfu+e63vf
	jmHKBaekKxb4jgNzonfcNxG4OS3yObZ3kxCO/KkUrsdhsd6SLTOCeZ5mQKsBeFJMMMV3RjVl6/LXn
	xUYoDev9xkcoM0m6cwZ3zC4qSVk+dkPQ6B5JYfWGqOfBxHSz5uNchwwyEXly8C8+I0iHcb3xrjZe3
	/W+X6DDrsMXjBPxadzPYeAEx2DJaDkW+N5TCDxZ2Wflt6fgqv8ru4q/jHkpmAn8S+IN1k/yi3jI96
	u9EmBIPfP8DEmfBHfN7OEOBGzTiQQT2dAwoKxSzkjIyzVifq9P8Ot6sD0c6CakRXLfS7yEWUnE9rr
	RIzNExBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x689F-000000043C4-0Rw4;
	Mon, 14 Sep 2026 14:59:09 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x689D-000000043BN-05VE
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 14:59:08 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-530fa1d2b31so13427181cf.2
        for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2026 07:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789397946; cv=none;
        d=google.com; s=arc-20260327;
        b=EG66U1Tv4XPiNXbBCC3BSiLW4KSJmdPaYqa7ih/sTazjygMstQGWkF0EWz0W9ingSk
         4U3I6xpYOBsM2nB9AuXKOic++VyIcNUtL2UNEJwCs9U5ijDhqM3DjgMLsFvOnuWF/7N3
         jdYF3SRNqz1lRtcYzd4a+YHvffml+NNxUucMTd72vZRbdxJQY6n+zlo0QP6UVueiVPws
         YKlwxo9+a9GMWsDXYtVb4aJI++v7u3LCXl7uoaGQU8o2neNn7xqniNDcAu0rMx74Bzw+
         XGOlnUvDCbVHH0MNvPmLjJ+8iJo7oAqAoRcC32vLOQBSvcS1ZT416t1MX8Ax4RLPYkP0
         RQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xrLppnrQYU9X/7lNEqnP9eIKSAA0eVenLVLPftEA0EY=;
        fh=mLrm5XgvPFNNWvQb0iKNQM0KewBPpFyliFXgBDiY0w4=;
        b=kpCVtCUvYftJ1wz+m9BlnHlhw/H1Vh6Vq0Y5ZBErKlZBdftq6Ta+VJaiPt5TbatE/l
         CAFm1fR0uMLQ+ORrsKhyTVZ9FYwi4CSHazOMeRyqwsOsYoYkNx0sld0zP4HHSsjh0WOZ
         cC/68zk5gPv9sQ8rm8NUEQgXNSe10EbIQxX31PAQN3fSoKjHy4wNLvJdVoMSqwen/qD+
         tFk1ivB4SXGQoow274w5yi1WPCJQ+WWRPXF6H2LEILO1LWVXiwk4wxeVhyIVy8bhSZaw
         iZ6sEXcKU3/A6yopY19+dc0GyLbNvyjUaN/YwLOO/ImhWIWFBNMTrN1HIx7LUzjuyiwK
         3C/A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789397946; x=1790002746; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xrLppnrQYU9X/7lNEqnP9eIKSAA0eVenLVLPftEA0EY=;
        b=K8VBeCwHFrJQ7PM6fc5oHOGDtvqYCryAGC/XeKjfG0MW2/JCMVO7j9hQ4FAAVAuTqn
         CzKZEH0rTkhYPkp+jS++RVpo9aeZCOLsSrG9zx+kIZA/BM+FY6c1a/qRs2AEoS5xyrFO
         bnmCn0h5ot/gMwCn4RSzxqhvGofRkYVQVpyo/0AVOo+569g0ELogJQwkRMedhqNKtJHY
         IbD1sf7C1GbT54BTUq5yneFeX3RopOIOIyZBJkyD/ar2FqAAZwJkaWm99PMsSMyvpkce
         z0c3+u6filWV8IDypuPW012ko03FmSj0cwbynap/pfujL2qre4FEEYduQpUjJDuk0vyB
         Wahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789397946; x=1790002746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrLppnrQYU9X/7lNEqnP9eIKSAA0eVenLVLPftEA0EY=;
        b=LE+bFAnFGhd2/ZgshmKyBaZwKUOS7l1FrEyxI1VJSQrvSjUhReFjWVwi6lZJ1ncWvR
         3J4WtUrNCjiWT/dwAqjwLJQYo2ik8TVhTuJ74VUwDJaMvIG8d+eJXn4gPr/jf42meWX2
         hEAuxwIJaG6ZtMdHTVdeusETb1ndRzZJu1hRRtj0rKqXZ1aB1J+v6ikUDHvtBI81tWGx
         N9KQPmAv0Es+X1uYkbHijKANdJ2lo2m35mYb5ZKGrLrsFamTacopqMtbKQHgpmgGnLgl
         dXyopf53neJud+UrBFMzn2iB19kJZrqV2mGe/usZaDgm1hYqDZmI6TLf6THB3bmZJhhX
         y1jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFK8Z6aty6JW/K3mpDvxopRJc1eF/TF7Qa3UsrT6n1jLKkoib7Lb1S0gsZPg1V6eOs1kNRy17dc7OW@lists.infradead.org
X-Gm-Message-State: AFuF++lS7vMBCOhd/9HpsGiQZsrqwqwFswkxjamzGmEsEoPOmMORuADS
	ImmFJTaWqH/ukAX5BZgY3uoLlaFAeG7Nv/VfCXkEZ6qi60c5pL/WPkMREPsY3gSolAzsUGjEcEn
	oFDOej/UjQmf+YBkAxIl6Uw287XVG35erk4ZNqatn
X-Gm-Gg: AYBFou3Qs340dxb1U3rcQXzVaRqO0hIs8poa9qNF3Hamr4BXgj2ISjEwR/0DlJ7hoLe
	wJMvhT8gJDsLKCl/PZZLnJwWS2es6K8tMnxF4TPxmkKbweSN5mg3G35meYj8YdVGeKOn+xMFifA
	WWFQMql23uOyzpCzUMZALWfuZFFmagGyeD2EbzbfTlhy99CV5I2kN31vPDZdWNi+id11Jk/dl1c
	Hdx4HI4RqJ4KEu8lkdaRJcmXsUn9MWDYfy/zgP16UkqTXk88BLQHwK/2yk8TrdD7Mj6vhu0LPma
	ChepbnZb0Ire8PrKsHVy3PPV6BWZLOOoCCPyFjU6b58ElftU9k/YObG7RgPgpvQqRe6czMoJlk7
	X+fFbdDQxI03MovfpgonPp5I8J6QTgWLSg0WPI2s+84jA6re1Rmzv0vUzoAlyOAnTwD0=
X-Received: by 2002:a05:622a:394:b0:530:3052:5257 with SMTP id
 d75a77b69052e-5310cf7b070mr40709261cf.27.1789397944718; Mon, 14 Sep 2026
 07:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com> <8284b88f-542c-425c-88ec-0486a6393fd1@linux.ibm.com>
In-Reply-To: <8284b88f-542c-425c-88ec-0486a6393fd1@linux.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 07:58:52 -0700
X-Gm-Features: AcwNN1WWzkM8Y8QbmSJnADrozo3O9KHAq3Ck0R8gCNde26ESArYOancy5RQNCDY
Message-ID: <CANn89i+nzpN0B=yYqYSBxE7VES2CGxinROeeHoFMOZSXJqFz7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] nvme-tcp: do not use dynamic lockdep key for socket instances
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@opensource.wdc.com>, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_075907_079492_7E00F1C5 
X-CRM114-Status: GOOD (  39.00  )
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

On Mon, Sep 14, 2026 at 7:48=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> On 9/14/26 1:18 PM, Shin'ichiro Kawasaki wrote:
> > From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >
> > Keith and the maintainers, please consider this series for upstream.
> > The commit 19bdb70c77d3 tried to avoid a lockdep WARN issue, but it
> > was imperfect. With Eric's help, I propose this series as a better
> > solution.
> >
> > Eric, FYI, I prepared the second patch with your authorship and your
> > SoB tag. Thanks for the fix idea.
> >
> >
> > Commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys per
> > socket instance") introduced the dynamic lockdep key to avoid a lockdep
> > WARN. However, it had a bug in lockdep key lifetime management and
> > caused another WARN [1]. The first patch in this series reverts the
> > commit to avoid the WARN.
> >
> > Reverting 19bdb70c77d3 re-exposes two lockdep WARNs that it had
> > suppressed. The first one was observed with the blktests test case
> > nvme/005, which was caused by the lock chain below:
> >
> >    set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_co=
unter -> elevator_lock -> set->srcu
> >
> > This WARN needs no patch in this series: it is already cut by the merge=
d
> > commit 0ba6912f7e97 by Eric in the v7.3-rc2 tag, which removes the
> > "sk_lock -> cpu_hotplug_lock" dependency. This series therefore depends
> > on that commit being present.
> >
> > The second WARN was observed with the blktests test case nvme/062, whic=
h
> > was caused by the dependency newly added for TLS support. The second
> > patch in this series delays the socket reclassification timing to cut
> > the dependency.
> >
> > With this series applied on v7.3-rc2, nvme/005 and nvme/062 pass with n=
o
> > lockdep splat.
> >
> I have just reviewed both the patch in the series and both looks good to =
me.
>
> I also looked at Eric's commits 18666c73afe9 ("tcp: use GFP_ATOMIC in
> tcp_send_active_reset()") and 0ba6912f7e97 ("Revert once: don't use a wor=
k
> queue to reset sleepable static key"). Both look good to me.
>
> However, reverting commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic l=
ockdep
> keys per socket instance") means that lockdep will no longer be able to d=
istinguish
> between the socket locks of different nvme-tcp queues. This could unneces=
sarily
> create dependency chains between socket locks belonging to different queu=
es,
> even though those sockets are independent in practice.

This is not a problem, and there is no need for a per-flow lockdep class.

Lockdep tracks lock _classes_, not lock instances, by design. All TCP
sockets in the kernel share "slock-AF_INET"/"sk_lock-AF_INET", and a busy
machine has millions of them. If lockdep needed a class per socket to
produce useful reports, networking would have been unusable with
CONFIG_LOCKDEP=3Dy for the last twenty years.

Per-instance keys are only warranted when two locks of the same class are
held at the same time, in a well-defined order. nvme-tcp never holds one
queue's sk_lock while acquiring another queue's sk_lock, so there is
nothing to disambiguate. And if such a nesting were ever introduced, the
right annotation is a lockdep subclass (nested annotation), not a
dynamically registered key per object.

Note also that per-instance keys do not make lockdep smarter, they make it
blind: they remove the ability to detect a real AB/BA between two nvme-tcp
sockets. Silencing a class of reports before any false positive has been
demonstrated is the wrong trade.

The only distinction that has ever been needed here is "in-kernel nvme-tcp
socket" vs "user socket", which is exactly what 841aee4d75f1 ("nvme-tcp:
lockdep: annotate in-kernel sockets") provides with static keys. Patch 1
restores that, and patch 2 moves the reclassification after the TLS
handshake so tlshd's dependencies are not pulled in.

>
> So, while Eric's two commits above should address the lockdep splat repor=
ted by
> blktests nvme/005 (as well as syzbot reported warning), IMO we should sti=
ll teach
> lockdep that sockets belonging to different nvme-tcp queues have differen=
t lock
> classes. This would prevent lockdep from constructing dependency chains b=
etween
> unrelated socket instances.
>
> I agree with Eric's initial assessment that the lifetime of the nvme-tcp =
queue and
> the lifetime of the lockdep key associated with its socket need to be tra=
cked separately.
> Based on that, perhaps we should consider introducing a separate object t=
o track the
> socket lockdep key lifetime (separate from nvme-tcp queue object), simila=
r to what
> Shin'ichiro proposed here:
> https://lore.kernel.org/lkml/ao2QHIDrGeYjltX9@shinhome/

I would rather not. My point back then was that 19bdb70c77d3 was buggy
because sockets outlive the nvme-tcp queue: __fput_sync() does not
guarantee sk destruction (in-flight packets, TIME_WAIT, RCU-deferred
sk_free()). The conclusion I draw from that is "do not tie a lockdep key to
this lifetime at all", not "add a refcounted object whose only purpose is
to hold a debug-only key".

Such an object would add allocation, refcounting and teardown paths in
nvme-tcp that exist only for CONFIG_DEBUG_LOCK_ALLOC=3Dy builds, i.e. code
that 99% of users never execute and that nobody will keep correct. We
already have one bug from exactly this, plus the syzbot report. Adding
more machinery around it is how we get the third one.

It is also not free at runtime: lockdep has a finite key space
(MAX_LOCKDEP_KEYS), and lockdep_register_key()/lockdep_unregister_key() are
heavy operations (graph lock, chain hash zapping, RCU). nvme-tcp creates
one queue per CPU per controller and re-creates all of them on every
reconnect. Churning two keys per queue per reconnect is not something we
should do for a debug feature.

No other kernel socket user (sunrpc, ceph, rds, iscsi, drbd, ...) does
this. nvme-tcp should not be the exception.

Thanks.

>
> Any thoughts?
>
> Thanks,
> --Nilay

