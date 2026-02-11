Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51FCEB595E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 03:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkfps1sGjuiHIHlEXIXeU8rsUSF5ZRZi+4yZM9t5aRg=; b=Bj/inWZGDURVkT3pGm0l4Qpn1v
	GdhYVDA1AYY6PIeMthAtAC1P8rkXUAUIpMZB1BLBpJJnvY0BHmctgpT1phzTLOH7JUOp8RswRbGEb
	Gryg9JKm+OQ5RIIT0KM9fkhSV77B46XJLNLk/o0EnHY/AQb6J94hYWMeV76P5+PeKDzj/v4EO34VS
	+jdWIeCrBcq4o7PBusghLHWZH+lYc2jFe1jJ2Pr7eb1Jsxf1/I01khqPpmAgKn+au/wz37eHKSPw6
	QETweTPB3t1x6xJM8Zm/H2AfKMGN0soDmshkpoDLjQuDXktQobEQljtk+r0uIqFGfRST7ysZpHa81
	NXVkrT1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq19Y-00000000AYA-3jwC;
	Wed, 11 Feb 2026 03:44:36 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq19W-00000000AXn-0vRs
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 03:44:35 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-567417610ddso892970e0c.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 19:44:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770781472; cv=none;
        d=google.com; s=arc-20240605;
        b=EsKq94KZgpV6TUctvHgriscWKTr57CRiiJ0pq7+u3XNdfGdJi5xaSsH9/z9zFPqjVl
         n+scpDV+mrskWbEbrsK/tio/m/3h1e6IcxHmUQIFKB64TK4ZaHgpR1CbdtafSEF4o7MK
         EB3GjNXJEFlqZ/5obN03EPIhkpOM4A6/3BX+sY6JzkUyLotOyMXMa1bs/BLAr2b0nI/Q
         J6OXlJItU8ILBJIUWxguJtmYZhrGmvy9f1oZPQsCG6eFRHkrHqwzyE5uKeJJI4A2GBu8
         9b95bdCWhhH6LAOPWMbjaHNeIpGCmW3OOi6OGp2N9ylnIJKm1QKJ1aynFn8AIFi2o4UJ
         ZScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bkfps1sGjuiHIHlEXIXeU8rsUSF5ZRZi+4yZM9t5aRg=;
        fh=weOQtW8/fNP7l+vQeBMU+dPci8d+fMGFOEgF662WWG0=;
        b=ftquyuafAKoCkneEgZky+nXYqPcHcssz1t2m32ETZDcOhT/dD6fprppJccv+erNMOL
         Ae9paWtEE14qudB6hh0ry63gHf8cwQPo5Nb3cF+2x0iWw5Nc33vFlTU5+hrwl9id5HdP
         cWPHke3WLgFAGnR9zNVqASrgh5hiL3bMdkdhiffIPyKArYSEGyYy60tHAltAO4acW7qT
         pOgZMD4ClZFX9VrRJFlbvlz6OM9JHD/aSdWL/DK6WBFcM2Wy6WklLp258omr3l9zA907
         QrRG9SIqMX+QOjbCi3ucKin2XSzqGJUATdakOTdPxLNeioB86crQlR1zIlrFQVXXLfTh
         acjA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770781472; x=1771386272; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkfps1sGjuiHIHlEXIXeU8rsUSF5ZRZi+4yZM9t5aRg=;
        b=eE9nI4t0WRrBJl+VqbSm4XP4eDM+6V5+Kc8pMzeF6fyluZ4hr9gugZ8Ovd3g1+s0e4
         tPre5AuRAfWeOuwOmZ9B++l6TuI3VETQnyQbjdI+NVYtNfjjyyGxhCJ2cDASpUsMv2Mm
         BaZOBCUay2CneWodWMlBFSp6UgxwyRtZudKelS/CoZ62X5D8/Qt/5CjKyHcgXhIronpZ
         4rk+eidrgjfNtUvq63OGhOGAywYkc3ZkBmKodoc3vsB/weKc9bG5U0zoF33PgOhInOCh
         wGKbkCZB+8v6Y8pn2C3a6sHo70bn9eykSAjiDlJCYldV6iHzoH19WBD/7GxLKiZwC5DC
         LR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770781472; x=1771386272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkfps1sGjuiHIHlEXIXeU8rsUSF5ZRZi+4yZM9t5aRg=;
        b=X60ZFBj6mOrADdoEbpPuGLgThqIdKJzkXjJcf5D6BbGbdykXORhZnOwMiJIJsGSzTA
         lCZ3ObZcHM9EVMEkrpFjTBYJkXLsTKnOo5od0oDNq8tmOX152xnTXBeIILRg+cRhG830
         652VGebX9WxPpp4FDokeT4WjLQKc8GoK9o0OFPEzvBPBoUBG3GF9Yna3uGsRFXkK2vYU
         y9zyTgZgSmPopfYddqIfZkI4UI4nnXJgXUwA46yoqKAsLOF6FuOYYldKYOW1ElhkD293
         scxAZ/v7NH9iF22NX4jTUuo4FJHGlbYy7uAh/ifnKeL4PHLKqW2+7pPJqmv9Pe/86WMz
         LeXA==
X-Forwarded-Encrypted: i=1; AJvYcCXeel0EMl8tFfbHTTJuYkm3a5FLMMZDJRGpu1VOobZY4KdPocLBG7nzEzsPBcbNVWCN49iR8hJZTdiF@lists.infradead.org
X-Gm-Message-State: AOJu0YyAlnv56oofiOjIAkAfpmpK5B+Hxq5R7gEBdbt1iTEnWEx5eLOI
	GIlguA6Bl8sHEImqdZZOZ3A7Ak3gjFPCZ2twDRxn3JprYY6Hr1g61DiwBPV+SkTe9+KDh10/oHX
	yHLykgLtih8zrXfYJl2jHg8P8FriIbOqGvwpQf6AbQA==
X-Gm-Gg: AZuq6aJVEuf14gLl8hRO+SQLgY50XfFgxCACE/Ts19Ag0DJcgN16HN4L8wZeFDO1xq6
	LGN88OaLzMMq4SIv0I9VPQooZLLivwQa3k/AggSgXtV318xeo4zfMe3+3YDquR+4oJVEZRlpW0W
	CtLIYYWKCtcV40kGD2YfrMZHjtqHOcqIolKEBEg4IcdGSEcrDZVcvPmBzN8N3c5DWJy20N8XSp0
	vD3UtdapoAvruPj9eiTqL7GhauBm6x/xgB7Kk7wpXV0wuOX6yfMzbCdWconjJCzgeDDIeGmP07d
	isJNy00=
X-Received: by 2002:a05:6102:304e:b0:5f5:11d5:70fc with SMTP id
 ada2fe7eead31-5fae8a2590cmr6091828137.2.1770781472580; Tue, 10 Feb 2026
 19:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com> <528a39a9-f087-461f-9f5b-c4b5821396b6@suse.de>
 <20260203200048.GE3729-mkhalfella@purestorage.com> <481562cd-0444-49db-8755-29436bec02de@suse.de>
 <20260204232456.GM3729-mkhalfella@purestorage.com>
In-Reply-To: <20260204232456.GM3729-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 10 Feb 2026 19:44:20 -0800
X-Gm-Features: AZwV_QjB1bjkiieHDQ482L0acS6wH-EjdjIfY69EtULgkTEqI55bpBcCdFjUJLc
Message-ID: <CAPpK+O02_ua4Rz+uggMKpp4gpgm-JugmKCs9CUECsdV9WuVdig@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_194434_298317_B2BCE523 
X-CRM114-Status: GOOD (  35.48  )
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

On Wed, Feb 4, 2026 at 3:24=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Wed 2026-02-04 02:10:48 +0100, Hannes Reinecke wrote:
> > On 2/3/26 21:00, Mohamed Khalfella wrote:
> > > On Tue 2026-02-03 06:19:51 +0100, Hannes Reinecke wrote:
> > >> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > [ .. ]
> > >>> + timeout =3D nvme_fence_timeout_ms(ictrl);
> > >>> + dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeou=
t);
> > >>> +
> > >>> + now =3D jiffies;
> > >>> + deadline =3D now + msecs_to_jiffies(timeout);
> > >>> + while (time_before(now, deadline)) {
> > >>> +         sctrl =3D nvme_find_ctrl_ccr(ictrl, min_cntlid);
> > >>> +         if (!sctrl) {
> > >>> +                 /* CCR failed, switch to time-based recovery */
> > >>> +                 return deadline - now;
> > >>> +         }
> > >>> +
> > >>> +         ret =3D nvme_issue_wait_ccr(sctrl, ictrl);
> > >>> +         if (!ret) {
> > >>> +                 dev_info(ictrl->device, "CCR succeeded using %s\n=
",
> > >>> +                          dev_name(sctrl->device));
> > >>> +                 nvme_put_ctrl_ccr(sctrl);
> > >>> +                 return 0;
> > >>> +         }
> > >>> +
> > >>> +         /* CCR failed, try another path */
> > >>> +         min_cntlid =3D sctrl->cntlid + 1;
> > >>> +         nvme_put_ctrl_ccr(sctrl);
> > >>> +         now =3D jiffies;
> > >>> + }
> > >>
> > >> That will spin until 'deadline' is reached if 'nvme_issue_wait_ccr()=
'
> > >> returns an error. _And_ if the CCR itself runs into a timeout we wou=
ld
> > >> never have tried another path (which could have succeeded).
> > >
> > > True. We can do one thing at a time in CCR time budget. Either wait f=
or
> > > CCR to succeed or give up early and try another path. It is a trade o=
ff.
> > >
> > Yes. But I guess my point here is that we should differentiate between
> > 'CCR failed to be sent' and 'CCR completed with error'.
> > The logic above treats both the same.
> >
> > >>
> > >> I'd rather rework this loop to open-code 'issue_and_wait()' in the l=
oop,
> > >> and only switch to the next controller if the submission of CCR fail=
ed.
> > >> Once that is done we can 'just' wait for completion, as a failure th=
ere
> > >> will be after KATO timeout anyway and any subsequent CCR would be po=
intless.
> > >
> > > If I understood this correctly then we will stick with the first sctr=
l
> > > that accepts the CCR command. We wait for CCR to complete and give up=
 on
> > > fencing ictrl if CCR operation fails or times out. Did I get this cor=
rectly?
> > >
> > Yes.
> > If a CCR could be send but the controller failed to process it somethin=
g
> > very odd is ongoing, and it's extremely questionable whether a CCR to
> > another controller would be succeeding. That's why I would switch to th=
e
> > next available controller if we could not _send_ the CCR, but would
> > rather wait for KATO if CCR processing returned an error.
> >
> > But the main point is that CCR is a way to _shorten_ the interval
> > (until KATO timeout) until we can start retrying commands.
> > If the controller ran into an error during CCR processing chances
> > are that quite some time has elapsed already, and we might as well
> > wait for KATO instead of retrying with yet another CCR.
>
> Got it. I updated the code to do that.
It is not true that CCR failing means something odd is going on.  In a
tightly-coupled storage HA pair, hopefully, all the NVMe controllers
will be able to figure out the status of the other NVMe controllers.
However, I know of multiple systems (one of which I care about) where
the NVMe controllers may have no way of figuring out the state of some
other NVMe controllers.  In that case, the log page entry indicates
that the CCR might succeed on some other NVMe controller (and in these
systems, I expect they would not be able to be particularly specific
about which one).  Very little time will elapse for that to happen.

It is important for those systems to have a retry on another NVMe
controller.

Sincerely,
Randy Jennings

