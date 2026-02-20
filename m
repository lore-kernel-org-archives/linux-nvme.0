Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CF6C531F8
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 02:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYeTmQ9whxNTcNffMBo7QPOt4ZPhHOc7oy9gWT1uFaE=; b=C3G+4IWmVM/WcBzGUebVuImEd9
	hRF9MBPOfxuUEe3hm2+dLeAFt3Gi4ANTaCXfOBcV4OpqeGfVS7KVrYBgElOJ+eA5B2I8ZjC+NCQLt
	Ypcw6g1/T8nSx5n2ePiJ+UAYN5/v75f6rTE4Csp/Zw0WOM9QKidoyZA0euT0baohMD7c8V5QHlNdb
	K/C3NyQj/rBfGRAOd6QUWfYoAVl+StlFKSeRs4V3JTwk/iZKpLTwpGtL4vWDFLdPVrPwVkkHXGnQ9
	F4/f3qUIn8TT8PWUJHlkO+BfrSO2UNJAaJj9Zje9GPuj4C61y5j5hOL9DU6eyaUJL0tvCmOOe3gZM
	vpDQSzfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtFpq-0000000D0aK-20sS;
	Fri, 20 Feb 2026 02:01:38 +0000
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtFpn-0000000D0ZQ-3Wv7
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 02:01:37 +0000
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-5665171836cso1693671e0c.2
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 18:01:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771552894; cv=none;
        d=google.com; s=arc-20240605;
        b=T6kFiOMebbCp0AQ3mbVUCcsbyTR4ppw8ND9Vrx3prob4jJBr95WUCxh0wbK8ROhEvL
         Jx6jFls9nsde6XpBjh9/7HLRletztKGuDKyixJmM9aEOU8c1Y2oGDpBQxnN2XS22XB2t
         OJndZXFuTCCvKmwDLATFhXLNvPdtzNBtHkF1cxn6j+QWy79zUG4WGxt3bEfTy72C2jza
         3dwwYEy4we6d/XY+hOacqnkH3GUW7WuKOqsv5iTBBlp7fwpouYa32K64Tn8gWCuBPKfn
         ybONt5GMmy+iY4by+d1B54SBwvkqP5JLDhxuori4F7IbdeaykcYO9e4ZF4ww46bmVwZc
         bFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kYeTmQ9whxNTcNffMBo7QPOt4ZPhHOc7oy9gWT1uFaE=;
        fh=5nwmR+tKgbWIcBCueURz9t3+PR1asK+WST3AffIjOhs=;
        b=jRaI4yQiJmHnckwpsUyOu5KN2ePMGAE/N4U6zhzfI5d13l9kABSq64qk/dAhDXhYyk
         4ManTjCYXXds8KVmHtKJLxjsaziCAL/iwocVFN9pVsRpiNPtRfh23gerwkmZgaaTXCY5
         SX814TR0ECoinuEhpruHCHnOaqploPbjNeufGyi9rHbsKYK0UwJ8edPuwURgqHBLbkYo
         Q6o7OtxmE2hh6yGxsPLll2kRynLlzmzcBZaQjmCDiGOFPto+5Tsdup+bNhIcypTfWyzk
         9IMgRym08cLZCTzIROBQ/sxkSKrGLjTyo3943NH2bd9nWmro5Z+Ld17Dd/MnjEwWwfvc
         cHMg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771552894; x=1772157694; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYeTmQ9whxNTcNffMBo7QPOt4ZPhHOc7oy9gWT1uFaE=;
        b=J+qozgFcEldwIfJUbekGVwmRc51YFOrgiHqtgxmKDBwEeXSccmRB8IDy9MMQYRGLJI
         YmXLHBKlGe30f12KJ3hfmlS8d+tS6wnuSS9/WF8gFQabcgmBjKhPCzWYmYwRCXkY9rk9
         TT+3bBdGIMFFVZVaA3r4fnbLsvV8XDKkSsgPOlqFDKZKBDsnLYEwSeBPJ7RtXfa+xkv5
         A5RJIIklJ57gnppWH6vGkCqmGl8z1W0Odg5mnxRmRWW3xAg3FK7UpwnsmWFXj+MCI8kg
         6B+S7EDWSyBAaFwN8I7VQ3As/LGjjviA0MpFMXyJ7L/BXECw3JpaimLHYHh8xZ/1iKXk
         7JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771552894; x=1772157694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kYeTmQ9whxNTcNffMBo7QPOt4ZPhHOc7oy9gWT1uFaE=;
        b=edH82NP8SI39NVajPaKK8xT9k0F79jSKv03mX9zmVo7tDebKqsrL93v6YSsA59fOHV
         RptYE63+QMVcX9V8LAgMKWoVEmzVERPI6QTmd2XKlzp3s3buDvcNFXBebypPHnZruFJG
         MFflkUrscnn0L89yF5aPZeWxAuT0VzzpEAPZSGLkrKbBsb9m/GxW9Wk0iYDtjHeD+K/P
         zHP5Pz7xix/QRT7ZvgaBM7/wYK5PhiBIKl7XJwX6ENtUHDN2045bwL0WgzYL8qmK1iSE
         HYlMihNKAgdSlxq8ffP+ZWj2TgaGbKvNFB/ezMNDb4ZUX+3+Sh69CeBkzbLBU2uQj9a8
         FSaw==
X-Forwarded-Encrypted: i=1; AJvYcCXvh3J0EajEGLn2pANO+48apGwTWBWOAGCJJ/a16cL3qQDrm8RiE1rEXJ6CL9+P63TtA5XTEN7R3gcz@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+oDrmeZgDuEzonKRP+2wAQ1kRGzndGw7lZIGlBUjbV/kpHzR4
	nYeEHtja5Lc2NplYBtFs5/1HIK1XuE9lfV3MYmIp/raDFvnvmRHhBGUSr3YwPMvulxSIt3iRJwI
	54n2Kcwi/vIoJv92j0kGBXrY85DcDHv/EjnRa92hwDQ==
X-Gm-Gg: AZuq6aI3iSrYgd3PNlq3QfAsQ5/euhmUzKJVbj9gDTwuwEysPnDo2/KXjQavd64wHK6
	ON8TNTqakwVSEfb8JjZQCaUXB/xcccziiVfnrwFfPfoZNg7mN4u+G9b/DRmj+La/kjMb1LZX0L2
	oSS77ZPtN33NWRlXIwVV8Sce1Yah0mmUXFLcmeexCK4hB3KDx1AQ5+UQ779m3qCrwdmZFejXGrx
	TFk4GBgnGvtPAHLCN0+sW6dwYiLKWuYZOPDvLvQP3FXFnB/UP1UONbGrcK+VRjfP+P3BjhEiRfs
	jzCqy4nIUr+ixe4ZyLGBAxl4NXWEbIwjl3UU2EzH/qKMZlttzhISX3jMQvFMvCk6e8SR
X-Received: by 2002:a05:6102:38d1:b0:5ef:b4c5:d8e2 with SMTP id
 ada2fe7eead31-5fe7fb39277mr3862399137.7.1771552893772; Thu, 19 Feb 2026
 18:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com> <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com> <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
 <20260217153530.GI2392949-mkhalfella@purestorage.com>
In-Reply-To: <20260217153530.GI2392949-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 19 Feb 2026 18:01:22 -0800
X-Gm-Features: AaiRm50dMODlSlDnaNll056K3lRq3sxkcEssnuj74ERsBct9QBLFnvI-RTd6EPk
Message-ID: <CAPpK+O35BBLnQOuPg37v772g7LtOpo6onxENRObUi7C_xLCoPQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart833426@gmail.com>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_180135_944411_AC344F8A 
X-CRM114-Status: GOOD (  37.00  )
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

Hannes,

> (ctrl->kato * 1000) + ctrl->cqt
As Mohamed pointed out, we have already received a response from a CCR
command.  The CCR, once accepted, communicates the death of the
connection to the impacted controller and starts the cleanup tracked
by CQT.  So, no need to wait for the impacted controller to figure out
the connection is down.

The max(cqt, kato) was just to give some wait time that should allow
issuing a CCR again from a different controller (in case of losing
communication with this one).  It certainly does not need to be longer
than cqt (and it should be no longer than the remaining duration of
time-based retry; that should get addressed at some point).  I cannot
remember why kato (if larger; I expect it would be smaller) made sense
at the time.

Sincerely,
Randy Jennings

On Tue, Feb 17, 2026 at 7:35=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Tue 2026-02-17 08:09:33 +0100, Hannes Reinecke wrote:
> > On 2/16/26 19:45, Mohamed Khalfella wrote:
> > > On Mon 2026-02-16 13:54:18 +0100, Hannes Reinecke wrote:
> > >> On 2/14/26 05:25, Mohamed Khalfella wrote:
> > >>> TP8028 Rapid Path Failure Recovery does not define how much time th=
e
> > >>> host should wait for CCR operation to complete. It is reasonable to
> > >>> assume that CCR operation can take up to ctrl->cqt. Update wait tim=
e for
> > >>> CCR operation to be max(ctrl->cqt, ctrl->kato).
> > >>>
> > >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > >>> ---
> > >>>    drivers/nvme/host/core.c | 2 +-
> > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > >>> index 0680d05900c1..ff479c0263ab 100644
> > >>> --- a/drivers/nvme/host/core.c
> > >>> +++ b/drivers/nvme/host/core.c
> > >>> @@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct nvme_ctrl=
 *sctrl, struct nvme_ctrl *ictrl)
> > >>>           if (result & 0x01) /* Immediate Reset Successful */
> > >>>                   goto out;
> > >>>
> > >>> - tmo =3D secs_to_jiffies(ictrl->kato);
> > >>> + tmo =3D msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> > >>>           if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> > >>>                   ret =3D -ETIMEDOUT;
> > >>>                   goto out;
> > >>
> > >> That is not my understanding. I was under the impression that CQT is=
 the
> > >> _additional_ time a controller requires to clear out outstanding
> > >> commands once it detected a loss of communication (ie _after_ KATO).
> > >> Which would mean we have to wait for up to
> > >> (ctrl->kato * 1000) + ctrl->cqt.
> > >
> > > At this point the source controller knows about communication loss. W=
e
> > > do not need kato wait. In theory we should just wait for CQT.
> > > max(cqt, kato) is a conservative guess I made.
> > >
> > Not quite. The source controller (on the host!) knows about the
> > communication loss. But the target might not, as the keep-alive
> > command might have arrived at the target _just_ before KATO
> > triggered on the host. So the target is still good, and will
> > be waiting for _another_ KATO interval before declaring
> > a loss of communication.
> > And only then will the CQT period start at the target.
> >
> > Randy, please correct me if I'm wrong ...
> >
>
> wait_for_completion_timeout(&ccr.complete, tmo)) waits for CCR operation
> to complete. The wait starts after CCR command completed successfully.
> IOW, it starts after the host received a CQE from source controller on
> the target telling us all is good. If the source controller on the target
> already know about loss of communication then there is no need to wait
> for KATO. We just need to wait for CCR operation to finish because we
> know it has been started successfully.
>
> The specs does not tell us how much time to wait for CCR operation to
> complete. max(cqt, kato) is an estimate I think reasonable to make.

