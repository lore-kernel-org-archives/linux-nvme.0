Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AE2C5ACD9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CEpG0Asu+in3PXSWcL0isDZX5KtRi550kSpC3TdsTDE=; b=OgBvpxn0UvpHo/zYHt/l8br9eq
	ZPMJEPoL/NL8XXCurP2wHGovVsKEhpXd6pBo2VnZmsUL5/FC4vGCxeqMPLWhbUSMQ4VWVTlh7uk1G
	SDu6uNoFr2hRqW4bSRdACZzeCS9bhTPRXBDh8QJViyROyX+DPbU3JR4nzZlf3RNx0PanTFe8usbwS
	Ei+FaTvhOiHYb6QzEM9QB2R6UauhlAYMvxTj7IvcJhk7OCcYlVmajxDpS/ahT5jI1Lx9VOouwHH+N
	alOE3X95BHCHjT21pi5LDDh0WHVXWeW5xAcDdDxAaD/CiRVf1rGc5+2I/jLgul2AfJ+VJExAe0Y6o
	Kv2hMuAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTHA-0000000FFnh-4AGX;
	Fri, 20 Feb 2026 16:22:44 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTH8-0000000FFmg-2AMj
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:22:43 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b8fb8858537so27153766b.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 08:22:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771604560; cv=none;
        d=google.com; s=arc-20240605;
        b=DMd7PlCt+uMGgwrE3LUZdDQLyFqLtwtIeZnhGwX6Q0WZAJ+BfBYi1oM3mnloQfzWaV
         epLzdi0zC9qmeQdpOjD2qczsRi6IXLYcHdBbuPftBlMM49bJej4i99An8hCjDK0LLf7J
         cehQcapCaTUaiNlq2x70K+GuFkerS+68VBaNu7HKqeG13pcsid/YuFfyi22Ln3SNRygC
         omcxtWUCx8DdPyfet1LbNjsl0284OX3NPbAHEKluni4nHVEpZxFSzPA/K7Qykv4cXrd3
         9/I2uRklZ7HxvAR83Pq6YNdyG5K6n4yII9AVP6d7RlD7SnUtga/XVJVXN1WKhHns1SSg
         sAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CEpG0Asu+in3PXSWcL0isDZX5KtRi550kSpC3TdsTDE=;
        fh=yZ9snjNxGs42/YiEdGFTKmKw2m7OkpEgM7QEFM2YXw4=;
        b=f3t5LCo8Fd7y01HFVcyo3/mdTEUt6eZTj7eumgsMc0ZbkVuZTQV9vtSncpq1n3t9sC
         /VzUCr96zL+IBBDyBuvZwQ6/OWeEXGFQd5D6O5RLt43CVI00NFiOLWxCRVr+o53TtJK3
         hC1T4WTCZ50ugmsjb5x4BLlLD07anre1sglGeYqWvMeym4MQ0riaJl0dob35n88hu7wq
         adj9SyT9CPLlQT2OrsGFlCSMemfZD0snpP/LAoT028kTK0NCeYhy7pWC3DkNbKEoYoNL
         hMlr5OePFdpKaSXnoFi5vziTD9ZNBFfZBEIa/xUYdSKQQaPQFePPFlaEK94Mv/aVv6Y6
         25nA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771604560; x=1772209360; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEpG0Asu+in3PXSWcL0isDZX5KtRi550kSpC3TdsTDE=;
        b=I3r9q25IFAm7zEY/rkD6KOXne7Jv8l9cbe04qP7Ol0Rv7qlWv7F6QOguklJxo3fjvi
         J7pFnBtYDb09Om7MRoMm+cww+oLHy9Seefga6CRVIgRSba5G+UA1NHjA5i/bzzYhNVRl
         4VffDou1jArfva1VfxLYBYY/F2ELaeEDmxyvQT55iuRJdLBZNEh43ThT5dh3LFokhzsd
         /YBTtiMl8zT4sh6Qp9hz7F8UnlOLDK/NWlyw+XpKRqkaHLoSGOVXtRhAs70eJp63Dc4m
         CZoGk4Lp21K9Ht5rhBC31AvEPXAH2ilRq7P8PmF1w14+iaPA37xJuo70TG/PWNxSfz5x
         m3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771604560; x=1772209360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEpG0Asu+in3PXSWcL0isDZX5KtRi550kSpC3TdsTDE=;
        b=iyq8lV18ilBNJmNgMyCI4w+Od7GE2yMN9mdObP/QeELkoIuChGtsZfgWT++qoMmxaR
         I1gL09NRMSf7mrPVgdn9vLjWDWJMEy/fvOrfS0StBTEJDPzg3yS5qtPvhdV6dqIw/t8h
         FyH2zWBts0lyBATJpAZR1wGg9pWdJP0ySsqSUKMY7fw0W4sZoEp6C35w9HMBFh4Kd9sI
         YCv6u2uOQKKP0W/Zb0U3w9osN6TDJ0qcarcHXVNtX2QzcOOZSAYsmdnj9F1Artuy443o
         l3uNWlLFV1OlQoN9nbxfTLfsbUyKQtBaxQUMKojixzQ27vYw4tEwsCOcqGFzN8cmQEqR
         hnjA==
X-Forwarded-Encrypted: i=1; AJvYcCXHeCmGz4binmM73JvKPdhuV79rAT1FfmN8Qs6t7RsBor5Li4dpGLFoXvvJzbxJhIltQeJmw7z2UNvc@lists.infradead.org
X-Gm-Message-State: AOJu0YyWs++n3+98HUEUoY7V2PHd2tmZYEFzCCo/iJh3kZJTmbwcyNik
	hbWxkGigQR+PMjgXojXadWxNJF30K4cKEfHqu50bpiYzUvFUQCASgkVjFaomznSHoX1GLT6o/DM
	etl5l+r2GljqVgClg74hBrJ9scJltXUC6hhzsXisSow==
X-Gm-Gg: AZuq6aJTfjejpHasYPfr2fxSI1hH218pROCxYMojQHipwbEXFX8roqI8vcM98c5EhQ4
	ovLK1vScus9EOmGbrbTjezAE5c0+22CnJ8TC5I8argCn5Sc+wB0qNcW51rOz73Llz6dLFkFdfHE
	5eYGTVS86xzBGHaBZoIIeGTMnSgkgqCGekw5yAfl7w5xI/mEXNAjJiHChS/sNAQCdCEKYfMgdEW
	KHwvyqaCw9R0FTJmzTl6giXp7U5mnlR4PZ1juTBHcZmCm5jex4htXxoyilb6Bq2F04b4Bj/roi1
	gYZICPjPVpyvE+bn1MM=
X-Received: by 2002:a17:906:ee87:b0:b8d:e858:dee5 with SMTP id
 a640c23a62f3a-b9081b6dcd5mr906366b.5.1771604560283; Fri, 20 Feb 2026 08:22:40
 -0800 (PST)
MIME-Version: 1.0
References: <20260219172228.429479-1-csander@purestorage.com>
 <aZhuwOku9lFe33UM@fedora> <CADUfDZr3ksmd=ZZOhU4RJsqEzbxBHnDPCtOQXJ5ft=X7irWvPQ@mail.gmail.com>
 <aZiHlp8nOPgQFGMq@fedora>
In-Reply-To: <aZiHlp8nOPgQFGMq@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Feb 2026 08:22:29 -0800
X-Gm-Features: AaiRm513RQKxAb9S4lN47njXOP1hMUP9KvVkWx2uUV-jY4xIGUbozyhkjbTIMts
Message-ID: <CADUfDZoxW0m4nptfNYqmqFCdTj6zSaYOk1vYSKU5JztkjEjD=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anuj gupta <anuj1072538@gmail.com>, 
	Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_082242_595157_B9FB3501 
X-CRM114-Status: GOOD (  23.75  )
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

On Fri, Feb 20, 2026 at 8:11=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Fri, Feb 20, 2026 at 07:55:33AM -0800, Caleb Sander Mateos wrote:
> > On Fri, Feb 20, 2026 at 6:25=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Thu, Feb 19, 2026 at 10:22:23AM -0700, Caleb Sander Mateos wrote:
> > > > Currently, creating an io_uring with IORING_SETUP_IOPOLL requires a=
ll
> > > > requests issued to it to support iopoll. This prevents, for example=
,
> > > > using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> > > > zero-copy buffer registrations are performed using a uring_cmd. The=
re's
> > > > no technical reason why these non-iopoll uring_cmds can't be suppor=
ted.
> > > > They will either complete synchronously or via an external mechanis=
m
> > > > that calls io_uring_cmd_done(), so they don't need to be polled.
> > >
> > > For sync uring command, it is fine to support for IOPOLL.
> > >
> > > However, there are async uring command, which may be completed in irq
> > > context, or in multishot way, at least the later isn't supported in
> > > io_do_iopoll() yet.
> >
> > Can you describe the issues you envision in more detail?
>
> Basically IOPOLL doesn't support multishot request yet.
>
> For example, when io_uring_mshot_cmd_post_cqe() is called and new cqe is
> queued, it can't be found from io_iopoll_check()<-io_uring_enter(IORING_E=
NTER_GETEVENTS).

I don't think that's a new issue, though. You're right that
io_uring_mshot_cmd_post_cqe() assumes a non-REQ_F_IOPOLL request, so
it's up to the ->uring_cmd() implementation to ensure that (which ublk
already does). Since ublk's struct file_operations don't provide
->uring_cmd_iopoll(), any ublk uring_cmds issued to an
IORING_SETUP_IOPOLL io_uring won't have REQ_F_IOPOLL set, so
io_uring_mshot_cmd_post_cqe() should work just fine.

Best,
Caleb

