Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F62C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Qo7/jYjUQTUB3RkM/YYt62qbjbgAkpEpQ1sQPCKRJw=; b=vL6xh+wALb+4HFIm8honUn9whJ
	XYs9hNgWHrpFm7v6C/bbP0eptBcAJ4YK1ZcUsbCBwpMmwGM+kpVqUYV/6dq5biuefJDWbJ8TLHpFq
	PzThTWYlGelpyoGmnDFkT6WzWFMxFc6YFDeIXw1fjpd21mPXU92SRTIDZvNzEIlaALDRgU8Ad+wEX
	CjOjozvtDgiuXdmdZNieja8N1f7eyndTXBD3F8sEdMzK0S1tblVgINnoP9AFixTHkC2Ro0qdOQQS2
	+nELRVzxH0NExQ6Q2+LtLEsyjgdtbDWi4MeecxYGN8dKhjmHVBMZLrptelr9H8oiXKfJuZE19+Bp9
	gQgnhyUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4hS3-000000067RQ-3mJ5;
	Tue, 15 Apr 2025 14:39:51 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4hRo-000000067P1-0JaR
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 14:39:37 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so878877a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744727975; x=1745332775; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Qo7/jYjUQTUB3RkM/YYt62qbjbgAkpEpQ1sQPCKRJw=;
        b=eyzNNdR52LP7FFvfJt7EURD9CIuZW1n7uD8mPELJzLRfNoAw+Gt00NfAXxnd4d5X23
         UX/HVb6FBqGa/7etVWYrze7aUR0tM8brU+EbRi9b4doeQqGNPjlrZiIwrx6+PLeIq4lp
         aicyJeb8henVzeGcVNB/ofEhSvceL8qGjuUtW/NeimYHuS36ib1C1Xpb1Vgi/ut/7RRH
         4ozoJs5J5Jhir+KRwRan5CKEOaMV+3OsxHvO5KRAJHFCRNo/IpMtcaxmctQr5/gxDmXa
         KJDUX8ReZfachs+WiHBwluC9X4IAjVXY4WjHExHosQaagnmU4fX+1l/QeS3jefozEmvn
         graw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744727975; x=1745332775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Qo7/jYjUQTUB3RkM/YYt62qbjbgAkpEpQ1sQPCKRJw=;
        b=Z6jvJZb/A9L2Bof5ZUNIAPLzinhfOhobMwC6yl8nL41zmBTV9I5wio/XpTXCB+WC2V
         zhBE/6KlxnLm+jA1AFjMVxAJPY4Z7mMzzvRD38yuBbqTKt70l5pZOGITeaBqltGFNxo0
         BOW5dw7x6GTC6/0xqAcuwx2eQXW0IMGPC8qRw9Toc7r9xuUNu9i+QYuRb8RN7PNOmIJ1
         Ceq1+Rjttvci2/nG+7HxFf6/pUJjMm/9Aey+4LGZtZe6/omjb9QMBCyrZep1hF1WpcoM
         BMyGvZuUp9jSL0WwNNl0JEiSspKuHbDSAzpnmG8WJvxCJ/2GzSEFP656/kwxD9bp4yNE
         +/fg==
X-Forwarded-Encrypted: i=1; AJvYcCXIKvOjJ74HjJt2S1KDvJtpKUJL1var0gDSvfV7b0eLgaECicYhnDl/3g2JMy3xX9rZCpmMykWUTkpl@lists.infradead.org
X-Gm-Message-State: AOJu0YwyGYQKF8kolYiosg/VWRO+RisfEhKAgsxR6cZlJGUOmcS5aA8n
	WIKdPglfZq4bOef3yEBdXQU+gdy81gP3SKf5j4BEGY5a5KvFPyaT6Wut2x5HTU9pDTOOQRO4NkJ
	O7nXmCKtE3IlNa0+ON8SrJ+/lbFKZuSgTnHy3bNUqvHrcQ6QEA2I=
X-Gm-Gg: ASbGncsI5rhbw5WJQcUudZvib9xTzYyTfQ1+slF5JR2xLE8Qke7odjwCkCwJBTVoNRZ
	EYlTpOh6Gr+sb7c7A/NpsA5osr8tsHxLVm0T1smleE2ibbNqcFmM4mTWWbASbcXHvIpmJyeyjka
	NoilAh4TqPD/agDKcm/OdnMVMsEAbo+6I=
X-Google-Smtp-Source: AGHT+IEZoFL7sOJJPnQMtyVfw1ECc8U3oRsk84i0RjIRWr7Q/XBZMJwA4kqwVjp/zN/LS1cp4wcTev7INFBTPH3wUeI=
X-Received: by 2002:a17:90a:d886:b0:308:2a7b:547b with SMTP id
 98e67ed59e1d1-3082a7b5563mr8462884a91.1.1744727974742; Tue, 15 Apr 2025
 07:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250415003551.22949-1-kevinpaul468@gmail.com>
In-Reply-To: <20250415003551.22949-1-kevinpaul468@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 15 Apr 2025 07:39:22 -0700
X-Gm-Features: ATxdqUG0GG5wFLRB1204WyA_VVJCOTVIXgifzHeujaVr1tmHeWxIG-001PIfu5M
Message-ID: <CADUfDZqcniNgTUC0v0R450LrL=oMW+-6fh8cgaOXe1K=V1t3+g@mail.gmail.com>
Subject: Re: [PATCH] nvme: Removing deprecated strncpy()
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_073936_158713_62F9ADC9 
X-CRM114-Status: GOOD (  10.77  )
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

On Mon, Apr 14, 2025 at 5:37=E2=80=AFPM Kevin Paul Reddy Janagari
<kevinpaul468@gmail.com> wrote:
>
> This patch suggests the replacement of strncpy with strscpy
> as per Documentation/process/deprecated.
> The strncpy() fails to guarantee NULL termination,
> The function adds zero pads which isn't really convenient for short strin=
gs
> as it may cause performance issues.
>
> strscpy() is a preferred replacement because
> it overcomes the limitations of strncpy mentioned above.

This patch was posted to the mailing list earlier:
https://lists.infradead.org/pipermail/linux-nvme/2025-April/055004.html

Best,
Caleb

