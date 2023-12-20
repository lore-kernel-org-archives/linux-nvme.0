Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42170C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 19:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jmWZvQ1sgmbWuBHHzG7b/RyI4Si1nSCQGy+inezt3k=; b=SpQcWaZK3fBrVBIY7ZW4n5k0aO
	yQgvMwYkk++BkClJ6sBucVELlr4+mI/tFG5UxSGvNJptIuu+ZGydbDpzAHH7A1UUuNgzuhq7zIC+K
	17QnvlA/2WQwQbhTrcePwlBDI3GqzaRxU+uX2dEwHtTLRTilK43qMBmb5oPL6kG6YVeW6onlatvjO
	025sS7RXcOC8s5y8RJ+Ycxn6TlQMKe++/cVfJHgGsVeNxYLW6JSEv4Bt3pkRDlHRRNCWP7VF5lzTk
	1PhfBZnoxtN+vCvC+bGX88Qzd36VEP858Ha5wy9NSHItoL0ute/UgJab+2SJepO46uMevgqgWARm5
	8fF7/V5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2Ql-000mUl-1R;
	Wed, 20 Dec 2023 19:40:35 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2Qi-000mTP-0Z
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 19:40:33 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d3ce28ac3cso647465ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Dec 2023 11:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1703101229; x=1703706029; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jmWZvQ1sgmbWuBHHzG7b/RyI4Si1nSCQGy+inezt3k=;
        b=AQ3zZ5DaxdT6PZenFz3JfKr7QGYSJ+AJ2pwTQeX518+xk3iI42h/bBVjkrh3+BF5rc
         pkw1b8aTcUV34rrQ0jvz1oLQflyEQVoT7G/uRedxAZMhzWFX59JVDfpfDF1m4YTTkw+E
         tij5j4OlM/rsmHmuyyvkgsuFRExkmDCtgwGHokrJq4lPxNurky5wbBJ/eHQn2HF0N9lA
         O6KoQSMhmr+HWJJDYPPCANaYu+X536E0V5SgKZKHyBf0O+vsv7EsHdwO9Ztv8IvHXGec
         mRkK28uxwMlRKGilot8mvCzOVketiv0QIxqIMTiBi+1BZneeFaVzJUqgEVk51NPPxyDK
         igNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703101229; x=1703706029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jmWZvQ1sgmbWuBHHzG7b/RyI4Si1nSCQGy+inezt3k=;
        b=d7GltW/3sAamCY3AnF6TfMqQ1QRfS/D1i0kTdV8uyqX1QpAWIHr73yRRwKDWU2/Hpi
         Ghbt53W8Jdau8AvGF7u12HbHcnjWJZSWsyoHIBSC9szSM1/t7lnMwp6Wiu2qElyxAnC7
         4uE/KnDZIg5QoZI34Wqj8OCljkWuVS8BXznR07TF3vAguhwOkBXm3yIQl2QNA3pXPrLJ
         a/TRxby0jVr9L5hTP1HirN7KgbxMgi3cwT+0GY74AtVT2FEXprkYqQUjL5cqW+GATxxv
         ABw4miS9APyU+Z1LKGfoTc+G6Ih869V8N32/n4yLdPpl+tY7mwsG4kmttp12MfQHEsd1
         p4cA==
X-Gm-Message-State: AOJu0YyDO672vg4GcpEtvX0GzCOuo/Ue5u3wPe4Y1bD4setGYBHPzY0e
	F0jTDiPoJvGTno7t2rZL7FpwK8iGyIA+iudaQ+CnbA==
X-Google-Smtp-Source: AGHT+IFUZT1Vk1DlMRGc585VlG4kOfA8Ibwo5cr3xD4ZypxVdVvjgenbpLrndJfPx/Les56pGKIPgh53x47l8uuDhLo=
X-Received: by 2002:a17:902:e892:b0:1d3:c0d9:ad52 with SMTP id
 w18-20020a170902e89200b001d3c0d9ad52mr3755713plg.100.1703101228778; Wed, 20
 Dec 2023 11:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20231220092745.35325-1-mgurtovoy@nvidia.com> <573c2ad1-8407-4c8d-b31d-b89b16f0fea0@grimberg.me>
In-Reply-To: <573c2ad1-8407-4c8d-b31d-b89b16f0fea0@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Wed, 20 Dec 2023 14:40:17 -0500
Message-ID: <CADUfDZrhPONOEK6xhbn3Uig4UZ+nwg0hDCRUziW8NA_g01raHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-fabrics: don't check ioccsz/iorcsz for discovery
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, dwagner@suse.de, kbusch@kernel.org, hch@lst.de, 
	linux-nvme@lists.infradead.org, oren@nvdia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_114032_249853_E4AF0077 
X-CRM114-Status: GOOD (  16.51  )
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

Why? As Max points out, the base NVMe spec says those fields are
reserved for discovery controllers.

On Wed, Dec 20, 2023 at 2:31=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
> > IOCCSZ and IORCSZ are reserved for discovery controllers. Avoid checkin=
g
> > their values during identify controller phase.
> >
> > Fixes: 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz")
> > Reported-by: Daniel Wagner <dwagner@suse.de>
> > Tested-by: Daniel Wagner <dwagner@suse.de>
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > ---
> >   drivers/nvme/host/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index ee2e4c49892d..b218ac88fcf8 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3068,14 +3068,14 @@ static int nvme_check_ctrl_fabric_info(struct n=
vme_ctrl *ctrl, struct nvme_id_ct
> >               return -EINVAL;
> >       }
> >
> > -     if (ctrl->ioccsz < 4) {
> > +     if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
> >               dev_err(ctrl->device,
> >                       "I/O queue command capsule supported size %d < 4\=
n",
> >                       ctrl->ioccsz);
> >               return -EINVAL;
> >       }
> >
> > -     if (ctrl->iorcsz < 1) {
> > +     if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
> >               dev_err(ctrl->device,
> >                       "I/O queue response capsule supported size %d < 1=
\n",
> >                       ctrl->iorcsz);
>
> I still think we should at least warn (and ignore) for discovery
> controllers.
>

