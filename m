Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5B2D3C533
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M2+wb2LgzRJhRj6yefyqXu/CkuSPpP66P9LaMg8ISWo=; b=MmC45I/0mU5ykEQ/O5lN76f1+2
	Hwu9ffrEQ4Ey32TYTyQXJWhHmhnnEObfkwhgrDzKPNCachaL33riY+oiJE0njeqb70Fi8SUowB4Rb
	1aAEj/Am7GxGAU/B/q415VP08IIycRY2936NJhTRcV2FWgAi6W9a8iMClFN2HVds5y7VmShKVsWur
	CZUjuIzopCoFpvsiq+fJiTMN3a3gSVNdidEpBRaciEMeK0c/e0A0wLTg4EilV2d+Q8JKfFIS5N/Xd
	CC26cBUKh24T8eqLiiMC7UQmfAZBa7JYTrCLxuvCK6G0KsodJZhRe0fR4hvlV2iVGcFByj3h+3P9r
	iJ4izZMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Y8F-0000000GFY4-3rnr;
	Thu, 17 Oct 2024 21:34:07 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Y6h-0000000GFIV-0Cbw
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 21:32:32 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-20ca03687fdso63755ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729200750; x=1729805550; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2+wb2LgzRJhRj6yefyqXu/CkuSPpP66P9LaMg8ISWo=;
        b=2w0+/i4REiB3gnLcRC009lvY8VK1NX9uKwR3WTkIPZDZJPlZEIUyU2DU9T4YsmIg5k
         0m1EH5B7p/WuyGK76eOJP0+pqpjmrDAEiIqIgWdmw2jLFLlYeJbZk7+HYAzeSHYUKZFP
         +OjvUtcSLwGJUI8WTxRwOItYn5BTE7okjQdDiunFUeSCY3z8XfPifOx5j/1R5AYH03RB
         TruUN1LyLtsZc1ug8lDp+lam4VFkKU2pEd2JNWvNzVuag/ucQbC0NCsQKMx02hsrU8I1
         JhO+vEUrKUJV6JMDiMRgssM59928s81aJ78+QD2DBK/Zne+a7X61GgXJBUSNQNDFLttw
         eYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729200750; x=1729805550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2+wb2LgzRJhRj6yefyqXu/CkuSPpP66P9LaMg8ISWo=;
        b=bfgF86TX1vLXp6VVdroaAKQOnNP8uCseoPxMDvHNMgBdbkCPZN6dwYvRswPpggUAw4
         J2FmwQ+rdKTf0YwWjD/ADe+a9rmcz39iveUQsxw5An+IAW3zaTUZTmZtNpGrSTIsfc3e
         QgZMKWrlbHlgso1+LDsMFQZCIihUfqS+DMb0JoCRp2Vv7InYsi3S2x0M0gVszzdxxX/j
         cgu03Egi2He0SXnKS7HLSB8J6kRhpa/KpiZtaT5zi9wtFHqejzVFwmYFvOFn2zZxW2Nm
         0d6E+GCZaU0GgjYU9NfE+23OK5t1rww+gENcY1M8CNmM+We5C1Ni4OfMbGnTgTUke86Q
         KsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJRwXSh9fS/mQ53ncSZ5qBlJwquWF86OdMKVY+NOy/8JV8a5+GDPc/FZ91RmdppO3hX6e4aGe7vW8D@lists.infradead.org
X-Gm-Message-State: AOJu0YyNK9BjuZSE+nm6wycGTlg1Gn9nPxpTLQ++2FmfYene7Zfr9YJH
	jQBZfvolEEyyO2E07TlkGd7noorgF07daAbAfTo8rIDXgXUIcRDooly3cvC9Cu92vGVhtsA+PDO
	NN42KCT5WXsbRtqPZUaQaDolaNtZS/j5nwyYN
X-Google-Smtp-Source: AGHT+IE4ntQMyyyTm5zlYwq2ofxDyZx5MXuYcNqBg/PzTdgdJREmYHhcZb5mzIIg2QyNRoAPQcx7cbMrES36X5k1Tng=
X-Received: by 2002:a17:903:2342:b0:20b:bf5a:c8 with SMTP id
 d9443c01a7336-20e579af565mr890875ad.10.1729200749514; Thu, 17 Oct 2024
 14:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241016213108.549000-1-abhishekbapat@google.com> <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Thu, 17 Oct 2024 14:32:18 -0700
Message-ID: <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_143231_109273_ABC97AEE 
X-CRM114-Status: GOOD (  19.05  )
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

On Thu, Oct 17, 2024 at 9:40=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> > max_hw_sectors based on DMA optimized limitation") introduced a
> > limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> > (MDTS =3D 5). This restricion was implemented to mitigate lockups
> > encountered in high-core count AMD servers.
>
> There are other limits that can constrain transfer sizes below the
> device's MDTS. For example, the driver can only preallocate so much
> space for DMA and SGL descriptors, so 8MB is the current max transfer
> sizes the driver can support, and a device's MDTS can be much bigger
> than that.
>
> Anyway, yeah, I guess having a controller generic way to export this
> sounds like a good idea, but I wonder if the nvme driver is the right
> place to do it. The request_queue has all the limits you need to know
> about, but these are only exported if a gendisk is attached to it.
> Maybe we can create a queue subdirectory to the char dev too.

Are you suggesting that all the files from the queue subdirectory should
be included in the char dev (/sys/class/nvme/nvmeX/queue/)? Or that
just the max_hw_sectors_kb value should be shared within the queue
subdirectory? And if not the nvme driver, where else can this be done
from?

