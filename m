Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B131D3B7E5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Dec 2025 06:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4ewT3eQeEpO8GTqQ/uFr2WOBVB+M9+hPqtp97ZRDoU=; b=gHqTYvSqwaSR6w9V1C03PZhUqK
	UtEHwIRZ4jk2CHs6hWSVqzv4wy9R4xNIAuO0QzWouLOJrzOo5eZtRwViSUfv47FFlxeiNiwHRgLQP
	OHU10UPYO4al7lD/z6kwElQvHqU7+KwyvIk+hSNIJnd9rTzkkLOwIqKr/HI1mnR0wHlBZ3EBfxyBK
	m35LzrzhruFJhGF/dbHDSMNN9mhrNNINkceWHcQp+qymMNSQ5vqZS+zWCOPhtcqPIwx2Fmmmxbqa+
	QwqDXcKWxr0rBCrOHUQfejsjxSU0HlafJl0ukPEAI5PCk0v23Fwh+Q2zv9mDqoowX7UfXzX1+u8vA
	FVYVbqzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZkBj-00000002Y3J-1dkT;
	Sun, 28 Dec 2025 06:23:35 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZkBc-00000002Y2y-1oQi
	for linux-nvme@lists.infradead.org;
	Sun, 28 Dec 2025 06:23:29 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-559748bcf99so7171879e0c.3
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 22:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766903006; x=1767507806; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4ewT3eQeEpO8GTqQ/uFr2WOBVB+M9+hPqtp97ZRDoU=;
        b=C9i6opWPUUkyl8iqKd2L4t+IuD9WQ8Bp004QKvJEzYsQOyQi02izsLPUjf9QjwxMMs
         /C5OX5kz6jfBg6ZWoB7fTaAtEi0K/Pb0Ij/JN4zu+QHst13qFc8AsaED/XCLAzoJKWjV
         YpWM7za3IPFaBvhgLctqLqPQ025vDoJkam3NHp4GMLUEPuA5z6dKVuQHjEE6T0sMY++9
         wNBIZnKUJ317ntLuVXLcRwAl9A9me+9i+6w9YzCajHs62fnjGU7YLMGghFRcE4zyipi2
         yPwdSWRWYebTIDpDojb/dyKiSaZCZtSZYWder0tHTdTwYJDjOmpp6MjENYvG6ZGABiVj
         Ft0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766903006; x=1767507806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E4ewT3eQeEpO8GTqQ/uFr2WOBVB+M9+hPqtp97ZRDoU=;
        b=Myu8rcVqmVvVk7YEGdHY5iJ3yFBYe4Y0s7fM/jhCZoG5bT8mkFMTLIOxNLJT2CFrtd
         IWNZws4p/FXkyBc0h3oBEBTXd/N0rIaqiBw756xT1KgAJ3GSwDIaRlvEAqwDNTMHoosc
         7d+ieL3UPuRjPtquAEf2Az8ckwezcYEG71tRVyTi0r5JMJNVmDqJmHVKTTaaBuPrY0Fm
         /IUgo8ZyFixreFyRfIl04lBqoCdK3YpHQ7ba6slDhzgR17E+MLdlPt5rM0a4J4Me0DmQ
         n5HEKkqKAus01AIuFXvbzZNjMKQOHgzRB6tPADjRqTCAmuRKX9GWTWDh5DptJ3CAkBtU
         nRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB80r5nx/qKq4NRe9BV+y9Qe8E43MHw6TlEB0bnlbUa0gL8Xq0PWJcOAEZUN6L3Xe50da3yjvSEY5F@lists.infradead.org
X-Gm-Message-State: AOJu0YzDG5ObWdL4oxVugGeRJkVhVmY/2a6OJ5193OtCgKWsG3MkWZ1A
	/fTLLxrXLMXbvAhBWmbyUIPhkUcc57ByFroBbd99JMpzV7Fj/cuzB+Y7DEC5q/b4zg7GetUC1o4
	OZ3g3dYNTuPz6Ov9Co6daqt827vI1K78=
X-Gm-Gg: AY/fxX6ZCVppbI3zP5sPnjzjlvnjNbUSKoe1kmkO19X3u2BTSaXDB20bkuuDKjJ92DA
	VQqq/FFQ1dRkPwOkqJQRhC8Aq/H+doCkhHp6lH2B/iyJ+8MT1ZutfNqT9777PjWkCcXgSnoM/If
	MuRW12gb7t6jCwlhsM23bPfydKDZG0AwzsT4x3Lw4cMq1a8FvM7s5iuK6Gi8k/feWmq/1bag/Gz
	2tTNxHzMA9eHqccaWrAX6rcsdI+6HvcTS1ViK9B0/MOh0sgeUAFz1pjGjJhjhAL8JDlVGny
X-Google-Smtp-Source: AGHT+IFhW+TQXQtttOEJMCZi9X4DFxLh1FDK8YUuBZmkSvQrGvO1V7StkNck/UWxU+qTD4Ffb2BLep221xAGlicRz30=
X-Received: by 2002:a05:6122:4fa4:b0:557:c743:e14c with SMTP id
 71dfb90a1353d-5615be07393mr8728554e0c.11.1766903006291; Sat, 27 Dec 2025
 22:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20251226-nvme_ns_validation-v2-1-0e1b3a142553@gmail.com> <91ed7327-bf4c-4912-a490-ce7606b854a7@grimberg.me>
In-Reply-To: <91ed7327-bf4c-4912-a490-ce7606b854a7@grimberg.me>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Sat, 27 Dec 2025 22:23:15 -0800
X-Gm-Features: AQt7F2rLzjktL10VGVxaXrASxI0j_kz6PQ8aABx3Faye27WvOdTGInmlJ_NJ9F8
Message-ID: <CA+hkOd7_+n2qiXdOw1Z9nYTHP1tosqNOwDBXZwML0kND2WmG8w@mail.gmail.com>
Subject: Re: [PATCH v2] nvme/host: add delayed retries upon non-fatal error
 during ns validation
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_222328_483696_DEA58B09 
X-CRM114-Status: GOOD (  28.14  )
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

On Sat, Dec 27, 2025 at 2:42=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 26/12/2025 19:54, Alex Tran wrote:
> > If a non-fatal error is received during nvme namespace validation, it
> > should not be ignored and the namespace should not be removed immediate=
ly.
> > Rather, delayed retries should be performed on the namespace validation
> > process.
> >
> > This handles non-fatal issues more robustly, by retrying a few times be=
fore
> > giving up and removing the namespace. The number of retries is set
> > to 3 and the interval between retries is set to 3 seconds.
> >
> > The retries are handled locally. Upon success then end. Upon fatal erro=
r
> > then remove the namespace before ending. Upon non-fatal error, retry
> > until the max retry amount is hit before ending.
> >
> > Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> > ---
> > Changes in v2:
> > - Simplify retry logic with local loop instead of delayed work.
> > ---
> >   drivers/nvme/host/core.c | 37 +++++++++++++++++++++++++++++--------
> >   drivers/nvme/host/nvme.h |  6 ++++++
> >   2 files changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 7bf228df6001f1f4d0b3c570de285a5eb17bb08e..6cd1ce4a60af55e5673e5fd=
0ec2053a028fae4f2 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4289,23 +4289,44 @@ static void nvme_ns_remove_by_nsid(struct nvme_=
ctrl *ctrl, u32 nsid)
> >   static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info =
*info)
> >   {
> >       int ret =3D NVME_SC_INVALID_NS | NVME_STATUS_DNR;
> > +     unsigned int i;
> >
> >       if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
> > -             dev_err(ns->ctrl->device,
> > -                     "identifiers changed for nsid %d\n", ns->head->ns=
_id);
> > +             dev_err(ns->ctrl->device, "identifiers changed for nsid %=
d\n",
> > +                     ns->head->ns_id);
> >               goto out;
> >       }
> >
> > -     ret =3D nvme_update_ns_info(ns, info);
> > +     for (i =3D 0; i <=3D NVME_NS_VALIDATION_MAX_RETRIES; i++) {
> > +             ret =3D nvme_update_ns_info(ns, info);
> > +             if (ret =3D=3D 0)
> > +                     return;
> > +
> > +             if (ret > 0 && (ret & NVME_STATUS_DNR))
> > +                     goto out;
> > +
> > +             if (i =3D=3D NVME_NS_VALIDATION_MAX_RETRIES) {
> > +                     dev_err(ns->ctrl->device,
> > +                             "validation failed for nsid %d after %d r=
etries\n",
> > +                             ns->head->ns_id,
> > +                             NVME_NS_VALIDATION_MAX_RETRIES);
> > +                     return;
> > +             }
>
> This is really redundant. just make the loop (i <
> NVME_NS_VALIDATION_MAX_RETRIES)
> and print in the end outside the loop.
> BTW, don't you need to remove the ns here?
>
In the original, a non-fatal error was just ignored without removing
the ns, so I assumed the same behavior, even when still receiving a
non-fatal error after the max retries. Unless it is preferred to
remove the namespace after failing max retry times?

