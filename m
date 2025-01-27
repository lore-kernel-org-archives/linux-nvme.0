Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBBDC0218A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=waKWpqcxZ0FAY/zTlx8AVaKJAjKg24lk46/to25N/DY=; b=CGo0ktBoYBh54doCHyz63X8vi9
	9W9gjYKfDnD4cUCTV0PjzfCSsVg8lpdp0sETX9orqzBpUANM93k4Ajy6zjyn0QHIaakmuhJQARDTt
	0iMlmaLBYmnL4ZLlYGWriPRdu5IwWcZORoql+EI7tMyILoxd79olVySOoSM/plxhrvyiGuA9QDN89
	CO823l+XZMcPZg3AWrzpeeyYgwncVhYKY4g70hVlyxlggjZIBtmqu1yKWB6fc7S5i1/MzNf4rQwbw
	T+3iB2oCoHzA1zrjVrprqzHQcavtONzKvfAx+LlEcs/f1XYo2DgvCb+AmFR3TzWeRHPsJssKelpcJ
	i+MaZm+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcTGn-00000002wcs-0bQA;
	Mon, 27 Jan 2025 17:51:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcTGk-00000002wbt-0vj1
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 17:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738000288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waKWpqcxZ0FAY/zTlx8AVaKJAjKg24lk46/to25N/DY=;
	b=QyakeJKHZjExaTpWys/vQga2dkKWc1ih1QL+AgfUEG2Q4PeXJr1DQTpF4RncjYpenkIl5Y
	XoOTP7PrO668foXJ8+tAHYZOXXA+O9C6KJz+izN8c5Jbbe5TCyHgWcAmGUJxdFp8TISfYQ
	5dvQccxmSQ+jyJwVsQxVyt2v1tvQwxA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-O1SJcdIvMKC3wygRm_CNXA-1; Mon, 27 Jan 2025 12:51:27 -0500
X-MC-Unique: O1SJcdIvMKC3wygRm_CNXA-1
X-Mimecast-MFC-AGG-ID: O1SJcdIvMKC3wygRm_CNXA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46dd301a429so96699171cf.1
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jan 2025 09:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738000286; x=1738605086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waKWpqcxZ0FAY/zTlx8AVaKJAjKg24lk46/to25N/DY=;
        b=N9Y2IQBeX+oy2ZudZVotYmHwhbI6t4iOOvadp55nC+Sme1nvpcj4c+cKv40Ax+0LYN
         0HooQ6ahiSCIUKbsvLpqdurW6VwYSORM3zeZeOXZ+WQBZVqSl9jegpRsyjSVkN1N0CRx
         qgqhD3VuaZFaHhGQqwnRfOKe98u1h/R3kZLR4lIHFoK02sy3HAab9XfYO+UuJw68CHXy
         +reOE9NOMvvATOsLZnKn4g8X9v9bx5BVyD16rXF5QlYasWlJlqC3UDFL/yP68vhulQqM
         rZMCmof69rdfGN7yfL5vcSlZCeyIDgFo2T0eSV3Q05ZvfSRtJATkB2qAokLxbIPy0ypr
         pfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTVWA23YeWe9Bga1j/jTijHbs0Z74qV6GmwFxA1MR80C/N24DbQKR7JpE2SpC84CzWS9pKVh8ljDqz@lists.infradead.org
X-Gm-Message-State: AOJu0Yxhvw4yjy+aCovCrA2VhBSKT82hM3/IHu1aOoiQ7TXxcK/cv5xQ
	EkhcIYx9xJJZu7tyYXnBaAXZPxk3tsvfhCBfhyPx7+3flWa929YYWOsfi2YCZbtxHOqoXjssWSE
	jiE4oyiAE+3+UDO7VQKaX5w/XhbCrv5cQwNId/yUL48pVXQHmanjHwq+SQye2GZ8ZR2vgCGcpex
	8IgfnGICkUHkL9GOfJwDN6ywt8xkexTDoXU+c4vhk=
X-Gm-Gg: ASbGnctRE8hA+eANbEdfhcRD0JDyv6Qh76tl3XJjllwLyvk43y2EymzyoERN4m6tOv+
	wNExx0rTzs/beWuDFllgq08sJvukcB1yA3lZtw3reTcjR9R9YzwLGhUmzKslv8uiS
X-Received: by 2002:a05:622a:1817:b0:467:b1b4:2b6 with SMTP id d75a77b69052e-46e12b7bf21mr655220561cf.38.1738000286593;
        Mon, 27 Jan 2025 09:51:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIW9p/GzEHXc3EcNq3TO8jIBnmGsMm7+MnoBQS3uP9gz1CLA3aPsUTKiGNKKMzcbA8MZ/zs2GVm2D0k5OtKcU=
X-Received: by 2002:a05:622a:1817:b0:467:b1b4:2b6 with SMTP id
 d75a77b69052e-46e12b7bf21mr655220341cf.38.1738000286369; Mon, 27 Jan 2025
 09:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de> <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
In-Reply-To: <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 27 Jan 2025 18:51:14 +0100
X-Gm-Features: AWEUYZmp6gZU6h07py_R8O1sW-evNga9p0ocaUaKgxVVi82HbIeuUzuNkJDoqVw
Message-ID: <CAFL455kYTy2j=OYjhF8HNXrb2tEOjLb+YkgYSWWC1d9Eqib6RQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander <csander@purestorage.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cJXlH_nOTwJiRB8-46JWMrga4sPdH4xMIvZKTvBbpaI_1738000286
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_095130_328283_779882DE 
X-CRM114-Status: GOOD (  12.94  )
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

po 27. 1. 2025 v 18:39 odes=C3=ADlatel Caleb Sander <csander@purestorage.co=
m> napsal:
> > > +     msg.msg_flags =3D MSG_WAITALL;
> > >       ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
> > >                       iov.iov_len, msg.msg_flags);
> >
> > But won't we have to wait for a TCP timeout now if the sender sends les=
s
> > than 128 bytes? With this patch we always wait for 128 bytes, and
> > possibly wait for TCP timeout if not.
>
> Yes, if the NVMe/TCP controller sends less than 128 bytes, we need to
> wait for it to send the remainder of the ICResp PDU.

I guess what Hannes wanted to ask is whether it makes sense to
check if ret is a number greater than 0 but less than 128,
given that the MSG_WAITALL flag has been set.

Maurizio


