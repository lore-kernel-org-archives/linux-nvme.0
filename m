Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC6C3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ng9+hHnH9hSKDAPC455moIhIfdCNxvrkS+SIVZsciFk=; b=2PwhTa/jamQvqTtr6rD0RODf5r
	DU6/cAJNEn1NyC+Hvr9eVqxSePhfxSE3SrZtro/h9Gf9yxrLVjkc2M/NreMm6XoTV8gVTz1lVeIlb
	/iiYyp5AchxHNOWJsoJpSf+Oo7oWaWcmQmWFFPtqmoQg2HhAAN/J7Czwo+IcdWlehS5ZYIZqMM/j7
	LoF39QqLemktm6BBhEzwIGE0J9eb2/lO6TuQwvyCmM/x0EnVMCkcDzKbYg2OdsMT5fZsoKBXXDwNl
	3ukVUwx5xGhnLJplbwTTalOKHtTGkP5aMwB4P4eTSH2oS8rLKQyv7KlOXwNCKQfF2HI3e7VdcC2xD
	xhheqIqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPec-0000000DUWR-1YUK;
	Tue, 20 May 2025 16:17:22 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHP7B-0000000DO67-0IDd
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:42:50 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-231c88cc984so6344595ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747755768; x=1748360568; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng9+hHnH9hSKDAPC455moIhIfdCNxvrkS+SIVZsciFk=;
        b=PYoYh/l55Dzie6uLeENi5p0zfooG5dFq/r0rVrqsNwDCpWRBonbZJMfe3tS5KjKUNo
         Nf1amt8rB9v1Or8xQZCPh2k8hISArgeNYDsncLJQIQkiBZsBG3Ftt0G4v4In4AGv6oKN
         8yDDt9xCYZBzNNCtl7RG5icBHIh+JGhImXRMQznSgQ9h6PM5DrQ1lMx35Rb0TSHKuixd
         WsNG05TWL7EgCx1Z8w1XhlY/jShl1xT0nBn3T63pML+at7XeYaKhTIx2ufXzGEKNbksX
         defBeIy0M7yu4INeuuse8IZuvg9apwzFawIO89+wuOa9mm/lyPv6BjaBFzuxwOSpY6Z6
         m1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755768; x=1748360568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng9+hHnH9hSKDAPC455moIhIfdCNxvrkS+SIVZsciFk=;
        b=gP05niNeNOUlAsMmhIha9ZSQn/bkV62jM+6lBeEOrOe26CJ1ikHzc4b/xDMq6QtZdq
         pw5CP3c4/VeHaLY4NQNhxeDcZzHWP4+nhvjukVP6PB2szcw07954z+sEMUvBDYpcAbtJ
         hOFF0C05JNtNk/XF83GwqhrYe8bhzevXZhMZGaePVpZjKn3oEEjB5NLtzdnWT23M+QfL
         B3xTABZ7TwJQ/blYSV2r+5t1Jz9HNar28zFZT6M72zkgUJ8tJsv3EwYxFnrW9X3dRUM/
         4cISLwiKqFgAdwTluv2RZ6Q51/vPWdtLQp8zQhu6Lxv5cQfLgFWmG3v0Vt5mKEKkxOct
         y8fw==
X-Forwarded-Encrypted: i=1; AJvYcCVuVOoJ6qhEbisDDpwBHWEfkae+FcWUMvL8SxZBV0tJsjCk2bReF//Dhi7bLuWu2L1G0XxTWy906rXY@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0oGYbbM7b+x2qXWmnVhkyUxqBprJesZypTbuxAxhBcw7a6ly6
	P8CsXQs4ITUSXBfTkZA9r/F3h3OxlPkCPHy3Z3Elpiov2EgrT55/vkKjDHFiQEbBz/Opzn2W5MX
	kgZTmwafrA7AyQymzn1vosyMAN6+o9zs/yGv9BASWcg==
X-Gm-Gg: ASbGncso9fulZEVldE4NzL5PbmJpexM+ifn26/LMxPSbG2XNXHIocBHyNeAaWzIzd8R
	Hm+MSkVxMAB4wrlPYg5iqmPUaJpIJxta+AeF/c39UlZS/EMEtRdXwF8bp3pIzESAOiQ7uiBYQow
	ztB9Dj6yvqRxcTjQ4QDsRbqPfxm/MwLbM=
X-Google-Smtp-Source: AGHT+IEQJVnFySNSvAo4sahHrwEgWCdOhp0CL79v8fmxVy2YuVKBFD/klA0kE5ptSDkTTi9dSih4+UittLEYt22gQU8=
X-Received: by 2002:a17:902:dad0:b0:224:1001:6777 with SMTP id
 d9443c01a7336-231d4398d91mr84106195ad.4.1747755767778; Tue, 20 May 2025
 08:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
In-Reply-To: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 20 May 2025 08:42:36 -0700
X-Gm-Features: AX0GCFuO8bvC7Kh6nWTDOsk_P8G3Z4EgqHCUSj_OydMTKmcuiLjavevyw_xwD_M
Message-ID: <CADUfDZpkUnWqtiMBOd1p=Ws2HuQDZhLr6xNYGmfXswwJ9BXpmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: fix implicit bool to flags conversion
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_084249_147147_877F992B 
X-CRM114-Status: GOOD (  13.10  )
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

On Tue, May 20, 2025 at 8:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> nvme_map_user_request() takes flags as the last argument, but
> nvme_uring_cmd_io() shoves a bool "vec" into it. It behaves as
> expected because bool is converted to 0/1 and NVME_IOCTL_VEC is
> defined as 1, but it's better to pass flags explicitly.
>
> Fixes: 7b7fdb8e2dbc1 ("nvme: replace the "bool vec" arguments with flags =
in the ioctl path")
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Keith had an earlier patch to fix this, but looks like the series
never got merged:
https://lore.kernel.org/linux-nvme/20250224182128.2042061-4-kbusch@meta.com=
/
This approach also looks fine to me, but not sure if it will
complicate some of the changes Keith wanted to make.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

