Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BBCCD13DE
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLyNT/DBEnc/exWGGYI7o2TnEaDelTtHJNyo6OLw4No=; b=DzIApJ+gFg2+THnm43qPaTadtp
	5VjdokSAJUqgCzPR8h6djMqyj/ewWWDTd7dmMQbIiVK2rtoxBal4WbZ9qNJmgUk/7UbPbs4quTMx9
	4IV3jU5z5MwzY9vSUnnVmwh3Jtf3lNisJiwTqE5Ci5rxC4Z3zwEr1t7rCyvG26FzkKyuUdQeJ4o/w
	dOgn7YMqOwQ9nUIFPHz5qeWRmYHlWXjtzHkKOYIxeiK8Rp+xAIJ4AeX/YdwyR80YnzhwsvdpVbdIO
	yneJDbT0Py371RD5/K3rCciVT/nOrzbTwn2xy5T/DCfCZSiTSMP0m5Qxf6JoLVCHemplVRQcGkLAx
	bPZq7Fiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIUmk-00000005m7W-0wNH;
	Thu, 30 Apr 2026 17:02:46 +0000
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIUmh-00000005m79-0MdH
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 17:02:44 +0000
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-60fa13bde2dso719328137.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 10:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777568560; cv=none;
        d=google.com; s=arc-20240605;
        b=MWMasrO70SlKMLW3jnOluWgmmRUas8duEwGWyp3CGTK3f97hjJMibagaH7guEqahrz
         X3+sRpIUYMoBF9aFFi40NJVoUQxHn4f2UwplR0Ibpma+afo24faNQRHmTr8MZrwUYy+R
         kix5lpQC4YdwN5xmoa8TaSu/3Hhq9ADlSfpeD0+hKIDr2uOFlnJPsyr/W4Jt/PmHHTKO
         UnzZnyyVbOPShUtFQReojhj+JGe5GAa51uNRhkLRiToEPXJA6VAIpC6WRGN/tS5JUZAe
         vP/m9CWIKxzd6hlm5u5ROcWuwu6uEqUBFTfdyLqEAUAWEToZp5fmTD/GHuXXng9WRbg3
         myMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JLyNT/DBEnc/exWGGYI7o2TnEaDelTtHJNyo6OLw4No=;
        fh=SeyUsyCERzv57s4qt8ASGjxrNsxv9QJ5pLBA4R7Ibp8=;
        b=Vq/aoXolbZHeNi6w5ZPpaxJNYsmX8VYw+JkJz21hscZT0eR0wi8jMTTMVqAdmOnJc0
         h4ON8P+KtHoaAMmwlh0ZNEo6zT97ZNIzTDGwTIOPom4W4o/dWlHR+kWpwH73gHL7WjcX
         gsQIDf193RoXzj+F2uKiZm1Gnkm+KsjR0KHqlR07rkINq6+NjtrZUJXMA77vIs0FrmTD
         dhewYlsLgMYUUYsQVOynduKxXHTrd9TNccXdsTkeJMchbzZ8tvN+PVVMzoST6d/AT6dI
         M6TKbp+ikE66iiacB55xv2vNQ3bSW0BvlKnm093jPvZBoXnAhdcNvE2ImaqY2Ds8hDqJ
         /X9A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777568560; x=1778173360; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLyNT/DBEnc/exWGGYI7o2TnEaDelTtHJNyo6OLw4No=;
        b=H1uhlBjt2e9KCZRepKEeQHfb41y1h/5z+QpDl17qtr30YZg7cUaLxISFSM91pVrXBm
         1q62+nWVz7lLHAO9g5xm2uJzo7K3baovAYg79YA7+MvTuQT6TlzgLA02SsSGl0Cde9dU
         LpkQAWYJ4wjMQFTysOkQI+nC13i2Nz/4FdTXJLJqrMStbjBJVY6WAyc7WzzbY0cyJSBE
         HUEmr01mhUO9fdDzdGQRG1E3+z6cTzEsoaSw+yQV0LC7AKC0BHlosQLJz0SLyZ/CmSfc
         /uTbLphI1RsgmbZq7XBnFYrv3Du974qOvlcwUMs2Zqw7bpDs+gIwlHA2XCOSOpEYnn0I
         ZLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777568560; x=1778173360;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLyNT/DBEnc/exWGGYI7o2TnEaDelTtHJNyo6OLw4No=;
        b=iSfw8oFP9o6afHDjIrLubZZZLzBFcYcNQBFaCW+GTDBDVHsLMSDxZ7Z+VRxxla3Gs7
         rhKjlUd25suuOwnzZKKoPutFKDQmXEm8T0klOGsL4P69qccJpsLYut1CkWx4CqoN2h1g
         xvnGN6d1CiAk/yE70zL7B7bF1qHElUfwQinO7QnGqXMTFjZbhKnx29ne6U4RTkrcG0iS
         UVhYIFORI7uXuXqe1KS+Ez+R5Oj0rjN6wT7I3m3WPiHvYyX8PJXKkKNyl+HeR/GJM0+2
         4SP33N94XZMc/sKFQ7aZO8itGYtwJeWnT3s+WhHCSeSRgjl7ThErlrXZCL1Md4f0cLjw
         WGDg==
X-Forwarded-Encrypted: i=1; AFNElJ8J7X4dStpLvVf8C9OtgDX0GUeGVMKEhd47GoeMXY5xd911LHru5RJK0OzNUUsjXmnAsMuhzinLTLR9@lists.infradead.org
X-Gm-Message-State: AOJu0Yyy3vZ0EqGE9o7EqLvH55K6riNmo18lU3FOYGckR0K4vJhs6hc9
	5Kcai/zXeUIxJbl/7En7tRHezIv5/1v9RLqF2IezGILQcU3H+HEfzb9U5+K2eCkWTk8LKZ+jhAM
	Y1LYB6SioTsWju46HiUnbkuO9wZ906YzyDHDmqRcYVw==
X-Gm-Gg: AeBDiet6Mu3f0ZqA7tP0PahULwwJjVF+hXa+Th5l4GF+2lSeJ83H4S7Kjj4Bk4bD2kS
	ll4a2U+IX1OQwDLXidn5RQ5V6xRgWv1aDMbRRXvNQnz8ZAiawQiSaJOzpUtSr0poKnbyUVo63fI
	CTBNWaQf7XI6o2KmrThHmBCJOGOYFn6xF2wI9nYt2bAyJi39TEXpn2fkCaKAVV4xk/81m1ACswD
	NBcf8/wkQN8A4vN5cFFNgqjNJohzdX9UZWky+wt89LgSHu1H79zMJ4dWp5izU8GKeP1N5VCYleX
	lM+dhZiXlRO2V4NBVd3BA98yFZReXoJVfgFjLui03SeVwgvbrEoyTVIOLNAOQf5+EpirLmy/oNB
	sRdo=
X-Received: by 2002:a05:6102:4421:b0:5ff:f4ae:a154 with SMTP id
 ada2fe7eead31-62ad1e3ce29mr2306786137.1.1777568554453; Thu, 30 Apr 2026
 10:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPpK+O3zB4Y7L6u0jmVkM2eQs2D1DEJJMG_AXgM+HBs4wkLStg@mail.gmail.com>
 <CAPpK+O3fFkbs-E05a8t+JfwCb+Wpj-trNOi05uO_zp8wF65nCg@mail.gmail.com>
In-Reply-To: <CAPpK+O3fFkbs-E05a8t+JfwCb+Wpj-trNOi05uO_zp8wF65nCg@mail.gmail.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 30 Apr 2026 10:02:20 -0700
X-Gm-Features: AVHnY4I_Sn2OkXzp-tYFAwI-68libLobX7XCdaeVmj9UR1GPYVWk-QoIkDNYzro
Message-ID: <CAPpK+O2Pe3uA6t8kspp3wq1qCWS-T+Mre8Hb74+3hTpyy2VWTA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] demo Linux nvme initiator driver stretched and
 dispersed subsystems
To: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_100243_172518_4FCA0789 
X-CRM114-Status: GOOD (  15.56  )
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

On Wed, Feb 25, 2026 at 5:32=E2=80=AFPM Randy Jennings <randyj@purestorage.=
com> wrote:
>
> On Fri, Feb 13, 2026 at 5:16=E2=80=AFPM Randy Jennings <randyj@purestorag=
e.com> wrote:
> >
> > I'd like to demonstrate the Linux nvme initiator driver interacting
> > with a stretched and a dispersed subsystem, run through some workflows
> > and illustrate usecases that are possible with one and not the other.
> > No, this is not necessarily production code.
> A few more details:
> I am still interested in extending the namespace mobility and
> synchronous replication use cases to NVMe. As instructed, stretched
> subsystems have been implemented on Pure=E2=80=99s array. I will demonstr=
ate a
> Linux host and Pure array stepping through these use cases. I will
> also demonstrate and discuss the limitations that come from this
> approach and solicit alternatives. Finally, I will demonstrate a
> hacked Linux initiator that implements dispersed namespaces that
> avoids those limitations (this is not even a prototype, just a
> demonstration).
Presentation is available here:
https://drive.google.com/file/d/1DcUJMyjSuMj6SsNeue_gqV3PHXZThoFO/view

Sincerely,
Randy Jennings

