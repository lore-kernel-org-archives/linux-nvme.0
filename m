Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695FBC02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K78DXbNOH78/MjAMf4mnwzSRNEsYwp/05NMbt7XWjEM=; b=Sp0LXaD/K1+rlucptjfGxODxTB
	1b2saFE/zrnLaGJHAloM+38bIAOwDp04VfQ9i+/8aRvD3e5j9tBXu7sHKDvPoEskSn90ZjCYlwatt
	F3HeEjVrsaUFha0MiheAk14Eiq8EvWA6vD/LHd1D+Pl5ye8d44bMNsqfKnYCiXRP0dRZamvUcKTkA
	XT5VlQPzOFeQmClkJWAJ5Ss8oTJ20OR6zx6dBO3m5JyR90IN8myXmzme/F//EYe/pY0+aS9ZeMYzf
	dfQkCcF+WxOH+x3tHMrhlZup3dhFIcnv0Wia+1pa0xR0vJ/wBlwgU1OP+DvGhiV3obRd9A4ykGv0j
	AWGbhoSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYuTv-00000001Rvy-2nhW;
	Fri, 17 Jan 2025 22:06:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYuTt-00000001Rv9-0xjf
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 22:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737151580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K78DXbNOH78/MjAMf4mnwzSRNEsYwp/05NMbt7XWjEM=;
	b=UMKI+Q3PiOfRQaJi8y948Kh/mJqgKJIZur1Mkx3Lh/fCUZiAvuVdjvVw+dm8BCg6bcPcdV
	F3It8uudLJpOJ42KITrOKKGrgUgzmHeb4Nt1EJqCpa7Syf3ZS1l78UrKoTClFhFI5C2orQ
	FPSD733viWQvjjJAoBQGfdRwMsEhx6U=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-VDUrl9zDNpyiTliixN2jBw-1; Fri, 17 Jan 2025 17:06:18 -0500
X-MC-Unique: VDUrl9zDNpyiTliixN2jBw-1
X-Mimecast-MFC-AGG-ID: VDUrl9zDNpyiTliixN2jBw
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e3a1bc0c875so4949130276.2
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jan 2025 14:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151578; x=1737756378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K78DXbNOH78/MjAMf4mnwzSRNEsYwp/05NMbt7XWjEM=;
        b=i5WKoUuBzf5siZWlk6flTvzqnd2TQbo1RQLB8WUPrurIV4UdBhLUHM33l0tU6nq3yP
         3WER4BgHr90BmJEbsaGR88vjiW/Tv+ZDnbdsTqUFZ6+0D64cGEWllrXTWuZIooegBcGZ
         ZOOrDkldnyRZhQiV0GcQgIaMHH8/9yYZvoOlLkC+VbKjX0SnEw9J3DTQL7/SRqDObdnG
         KBomFgnrYTMF078sUCE4nIWPPWo3M79LFujNm73nV/J3Tz0HcJnF6vzzq8bhISUsQLVU
         fHswTUoEPYQTeYYAswRToOrqp0ORHBxTUruRNZtDmHEFPHx6j3tb66/b+fLQpU8UkdJ7
         5EMw==
X-Forwarded-Encrypted: i=1; AJvYcCUqXM2qx0UqPzWIbpee+Q92ddihNZTYRmx115DPtzuBk/P5PT21RQSli1WX4yWgpL7Kyke4GFGEo3By@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0AQjqiWnHWor424RzlOKnI1Qg31u2o1AczhuPe129A/beO7rB
	94bTiNgy9S0H5iYiJYGYs8FmZ/zn9z4KL7GIF8iZE21hW+iTRBRSDUz5dHy71jKm57+egytedyq
	dniKIDqAVV4jO3pGWZCpRq/nCiff+EeDDfw5g8ns4vYwmaNi/pma9JJMBKtL/6JYQ+a6b0OyYv+
	TFdnk7x8RHGIY8TcnpmjVmSXbVtrhh6w1f04Wf5Ac=
X-Gm-Gg: ASbGncvd1zXwuekVyHdHESrVQcwoLVSbXkkTMXm26rWb+/B/JJHST0ayjDvcBzOoyLd
	Hg5tJ6mA2DwUqWYM0NO8ctdK7YzgudgrMOh1IVw==
X-Received: by 2002:a05:6902:2408:b0:e57:87b3:d2f0 with SMTP id 3f1490d57ef6-e57b1060c05mr3809089276.15.1737151578346;
        Fri, 17 Jan 2025 14:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzrd8dx9ZA0A0/5TNfLVrh3HwCOIXdMomZfPfSxbubGOO9loyHuc4IGY+reIG/Le3gICDKLnpaZ8TLfdA7HEc=
X-Received: by 2002:a05:6902:2408:b0:e57:87b3:d2f0 with SMTP id
 3f1490d57ef6-e57b1060c05mr3809073276.15.1737151578118; Fri, 17 Jan 2025
 14:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20250113124446.830697-1-ming.lei@redhat.com> <20250116061004.GA25010@lst.de>
In-Reply-To: <20250116061004.GA25010@lst.de>
From: Ewan Milne <emilne@redhat.com>
Date: Fri, 17 Jan 2025 17:06:07 -0500
X-Gm-Features: AbW1kvb_O9XXcx7mLQk4vNbyzUgKaR42L8POiBfTHKz3kQVq93BSH_baB2l5_3E
Message-ID: <CAGtn9r=zuwKuUZP=9P-YWyMrnZprGfXqJLCO3WyMK7iDSnuSBA@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, Marco Patalano <mpatalan@redhat.com>, 
	James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v1m9TM2HdFOP-MGSambHRcLUjOgm0H0lQA-cnt3PWvQ_1737151578
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_140621_341859_F42233E1 
X-CRM114-Status: GOOD (  18.92  )
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

I'll work with Ming & Marco on this and see if we can get this straightened=
 out.

-Ewan


On Thu, Jan 16, 2025 at 1:10=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Jan 13, 2025 at 08:44:46PM +0800, Ming Lei wrote:
> > Now target is removed from nvme_fc_ctrl_free() which is the ctrl->ref
> > release handler. And even admin queue is unquiesced there, this way
> > is definitely wrong because the ctr->ref is grabbed when submitting
> > command.
> >
> > And Marco observed that nvme_fc_ctrl_free() can be called from request
> > completion code path, and trigger kernel warning since request complete=
s
> > from softirq context.
> >
> > Fix the issue by moveing target removal into nvme_fc_delete_ctrl(),
> > which is also aligned with nvme-tcp and nvme-rdma.
> >
>
> Yeah, the current placement is wrong.  Can I talk someone to make
> the whole setup/teardown process in nvme-fc match that of the other
> fabrics (and slightly less so PCIe) order?  I know a long time ago
> Sagi was atually looking into sharing more code as well, but that
> would be a next step.
>
> But I'd really like to have one known working sequence instead
> of various different ones.
>


