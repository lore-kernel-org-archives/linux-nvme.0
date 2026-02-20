Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC00C5AC80
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLDcj/2tl6eJ1rtbmAcD53HOSalhKLNKFMA/3qFufx8=; b=ba6F/+XyGwBlXHCVrxGs3FKhFc
	GQmzaiFqq/ylid99zSh8m9LlRUhOBjJiNz6vCN1b0vwuUBlnZIAE3ZGlzxM/snC0EKqLk39bBz+77
	2aHrz8IUZv0wwISIQD7lF9Z4Le31fZ/bmh5/PpfqrDEdnKEpurV6iw8D4q7ig6iFP9oIMxywGZLnK
	f9i+aqeqIMQwTyeaIEk2bjqJw7neJ6AW2QY7m4cUWJKsKPvvzYDQL24oLsgrJWjmzQuPT8WB8Wwk1
	ha+fyR2OUB7YCPrQMVdLBRxhm5pdV/ah/cq89/US5mus4A7WInOJIzHAeaxXSJz5YmtcHZ7hOlTXx
	bIkWExEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSr7-0000000F7lP-1XZd;
	Fri, 20 Feb 2026 15:55:49 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSr4-0000000F7k6-38Et
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 15:55:49 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-65a3df61335so272169a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 07:55:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771602945; cv=none;
        d=google.com; s=arc-20240605;
        b=NE8DoEJTAWoQuY6ah7tM3pmvhlA/Gn9+Z7WbvnjJSi5CbjVHMq5f6vSNF9gftc4ju4
         58QN15UXtLSqS1FzSkctN7KRQ5+C+yOiQlFY/KoaJr7nmDy6eHsYKPLzbs6bDUZAjpMQ
         +Na/UJRINNSNFP+oGjUIPsEqHeDqeL3OBeNFFEYwsbSELsy5xBjYycqcijzhxGVpNoYk
         f3vfrvLPOur07mx+36caijGNfdaH+iM2bnCLg3pLtUZo3GaeTbnBNR7f+f6MP4mptu05
         yG/NgLavnMsJWCx6iXRBd+OYWXRVUmLYV/7OkScEI3ZGst2SXeM4XXSOBPNSu2Zwqvqf
         Pg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dLDcj/2tl6eJ1rtbmAcD53HOSalhKLNKFMA/3qFufx8=;
        fh=JrPPYAX+5aSrZxT1UkoCoHForYQc/b6Q9brRvoboASk=;
        b=MfupWWKevmXPvHLyEysoF39dgBktPn6P7UUktVg6YKAo6mQSoqRiJA7dSClcHR/Z+J
         oOowOgdbv9HVzo8piDwxTQ3x6afmANL9O2zuv7m0evZhzQjBRo9RxVFAIliEZBPCUDlq
         ZYf/6uNlWrAUK2KW1uMmWCVZV2zyLjB17Cwjh+s+uNcJAxa03OmS5QE6j8DQZHEsltnd
         Yr2Z4GHcqvP0je6t/NsUMi2LQtenHX9E7FpJZcHoMixiHUKuNucJEbfLqJCQTp1B5ce9
         9scr3wIfT+21/iuLATm1acEwoPfbpVBLLDdS0SJ28Kl7XZvdlS+rfs4poB7+rAUIh+ud
         MBiw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771602945; x=1772207745; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLDcj/2tl6eJ1rtbmAcD53HOSalhKLNKFMA/3qFufx8=;
        b=STBVM3TZX0CPLf+TVd4QdB58lLHphtnsxla/KiwFb45ksLvBTXjk4FIX1gCMDdXsNd
         3vlzgVQt5S1MBr5dK8tx/knTtF/f7aJ3oaAo5WwQTLL9uCs2AVogmvaiTC0T034RmZcL
         ahEvKhnUcTJCve//jIYnm1kwcXmAMEmyYkQTG7CtoFpRrPzc2Vfe9hY8dgmQdcYiKrYK
         KIT3d6YU844OCq2xCNIcx1gyFkJjxOqaz3eLGCeypzBXE1iSLNl0dvglRxNRgVN7WMSV
         qUHBe0dn1AcWPoofcocGqW79y/gzDSxr5tkL1bEPUsbMIUt8PS0TTUhWY8mZsd42W1G4
         vOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771602945; x=1772207745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLDcj/2tl6eJ1rtbmAcD53HOSalhKLNKFMA/3qFufx8=;
        b=EEshKItN7QV8ZIJNdX5X+absFIab1N6yS9YNQZdYWsl5tnGsw5smKDIOxkW40Q/6iB
         SiFbDAX/eKmt//O/bXQvxvGtghojABbSOp3T3Wd5s6ajvqUZymF2qVMdIhw6ZgUA0QuQ
         Fytz47O095W/puldZPPAIdseOtyhopaePXNlvEMvIRBc59ogxaJy0YFPMpeq6davgQKf
         umpha8ranxTc3F5xbtM5r28CET8UMrFzda4+zTz3n0JcaLIjIS3/e+9Sv8UZeApt15CM
         XGzLl3m1OhfPOX32/vYhOpasbFvfPoV88Cwbkk7CRmlYOxVSa/PzkfCUH9hHohobhTE/
         hSCg==
X-Forwarded-Encrypted: i=1; AJvYcCUi4cbXWmqQhVvW7DIxnFU9727bVryg/UNro84rgV8YK8aK+XOs7uhTeYKC26nprJW/sYCFddQcG5Ih@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1U9Q1nbjasDRYG5MzVK3PrfL07b/8fot3yIZTCPZqB29/lrcO
	61dIUlpm3PZnXP8lN3t085NWz2NwRKakXaw6SLlBoOj6qgCb6SsY47NESVfVktzw7WVwzGGpCB9
	xiJv6x24AlPECe1m88g/2pGoJBzYMtm6QLtFa4MPfXA==
X-Gm-Gg: AZuq6aJyzdbpoBKVQbWg+N46XZ1wwUl+6FF7+diCdkZBI7tpSRpOXOBaaeger29x4+Q
	o46GKpNF4r4X4F4+ItXGtKTzRlXHzlE4FRt/TPzDVivSCUqdvYJRFcrjwaSde/P64pcXXC65zCq
	178FF/zBlG0tB+PKq03DI/QTv9TlxwnnEIFySKbMc5ZxeVM+p5sgqArKaRZ4vaRc8//20X9AwSj
	cakr1NxroPPMVCT+1/4HRlOGwHkj7j54UrKtwX4MnRy3jVVS51UResg+QDL34Y+J2PbvG7luiUY
	U7nVt39l
X-Received: by 2002:a05:6402:50d0:b0:65c:37a2:e4a1 with SMTP id
 4fb4d7f45d1cf-65ea4f1cf0fmr14335a12.4.1771602944840; Fri, 20 Feb 2026
 07:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20260219172228.429479-1-csander@purestorage.com> <aZhuwOku9lFe33UM@fedora>
In-Reply-To: <aZhuwOku9lFe33UM@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Feb 2026 07:55:33 -0800
X-Gm-Features: AaiRm51MVVjjjGK3SmCWXzLeh33JdwAmlc7hUGmZViVX5bC_jsF58uq-g-XjQ_g
Message-ID: <CADUfDZr3ksmd=ZZOhU4RJsqEzbxBHnDPCtOQXJ5ft=X7irWvPQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anuj gupta <anuj1072538@gmail.com>, 
	Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_075546_838112_E0E9219E 
X-CRM114-Status: GOOD (  19.53  )
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

On Fri, Feb 20, 2026 at 6:25=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Feb 19, 2026 at 10:22:23AM -0700, Caleb Sander Mateos wrote:
> > Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> > requests issued to it to support iopoll. This prevents, for example,
> > using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> > zero-copy buffer registrations are performed using a uring_cmd. There's
> > no technical reason why these non-iopoll uring_cmds can't be supported.
> > They will either complete synchronously or via an external mechanism
> > that calls io_uring_cmd_done(), so they don't need to be polled.
>
> For sync uring command, it is fine to support for IOPOLL.
>
> However, there are async uring command, which may be completed in irq
> context, or in multishot way, at least the later isn't supported in
> io_do_iopoll() yet.

Can you describe the issues you envision in more detail?

io_uring_cmd_done() can already be called in irq context. Even if the
request is not REQ_F_IOPOLL, any completion from irq context must call
io_uring_cmd_done() with IO_URING_F_UNLOCKED because an interrupt
handler can't acquire a mutex. That means the completion will be via
task work. The mutex acquisition in io_uring_cmd_del_cancelable()
would be a problem in irq context, so ->uring_cmd() implementations
that use io_uring_cmd_mark_cancelable() will have to call
io_uring_cmd_done() from task context, which both ublk and fuse
already do.

I missed that the SOCKET_URING_OP_TX_TIMESTAMP uring_cmd may use
apoll, so that one will probably have to be prohibited on
IORING_SETUP_IOPOLL io_urings.

Best,
Caleb

