Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28293C33CB1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 06:28:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3C12081E
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 06:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AKqcJtSJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPaTyKCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3C12081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H6KhOapXZ2ses/4dRTPeeAcjdVaGi3fhbWd6VYIaj1I=; b=AKqcJtSJEZedJT
	Bf8bk3wbSDoVS3KqJGp5Uz0CYFtr3i3lRakIYYflb7UcUF9e9gyFQhnfmNFB1ydR/PyuYJiFu3GRN
	SP+G4Qqnfj9JPAD3dQ0e4MfyuLXyjvr5RlhHYyOMd2e+yQqueR8NkWvkOv/IOifP9o+v2u5q5wHk2
	J0Ml3ffFB0fr6fNcou0ZN8kY1tBBgu+Scj0c6YFzs8mPm5k+IL/t6ARnIQVB27WYtSdfbhVSTlKVe
	hLesSfwIAVmXnPU0JIj7QXAtC9sFh07Lxjy5WR0g+INtK+5O0dwbiniLpZ/Y/W/h8744vT2Lz+R7z
	O3EsKux8/AmdIdtEyF5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1irye8-0002lA-L2; Thu, 16 Jan 2020 06:28:48 +0000
Received: from mail-yw1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irye6-0002kY-N7
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 06:28:47 +0000
Received: by mail-yw1-xc30.google.com with SMTP id t141so12271192ywc.11
 for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2020 22:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k9vkFSm7AIgM5H2fBphj46pF8AAfDERQnyYVxzggXhY=;
 b=IPaTyKCSGFckxuPQRbvyIXEqQ1VcfZGc0vkMvIWp3ZAhvmG/sRcrh02+mtgQcbTHNm
 9Kpq4/XXdAH1MhtnC9Kc42y+1MAJlm3KH1W4YgnATY9UJTNnGJL7H8cVCrzgwyncz+xb
 +RfMS0gL33R9yuiAIk48IowI5Ahi+Sd7RIbHMpceHmPseKH96vJRsG1kiprncbpk7qFw
 SXrCZTsEI9ixq0tE9tHj/okYf/2KRb7F36rOgcW319tltDB4Tvyt+eWeR/LffGLxJbst
 s8BCfJbyzE8o5qw/vBTqFVbZGa6rjuJ71F4PkYNmi6p8uGw1teDvLJjNqPtM+ZAmFS0Z
 R13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k9vkFSm7AIgM5H2fBphj46pF8AAfDERQnyYVxzggXhY=;
 b=nrYW+B66U5xv54tfdJ6f7JFbNGDrOAlpl2tTHqEVY0f9yO6U2Que1eC/ZL32R1jdQp
 +KtZITM1I++uCtXQD2dK7lkl+aEkXG1JUCQJT5FVi33zUYA4gQOlYkuPtE95KH/1+35c
 RBMSyBWvV+b+9TbHSrYggErNIs/7NKsAdqNXEOVC3VVDczKFChHVl2j0MvMaFY4jw1hG
 sydtKLLEJI8d9herh2lV2FJpiK+Ahou7ukUn2xNBD1wvgkWZaED14I96FVpfj7mPoLpv
 CglYcPiKAm1LBQsq8FxGL1VJMvufcfVL6dLVme8GCs5FQ9x1cLB5y283hUTSbpOgJQTj
 No6w==
X-Gm-Message-State: APjAAAWHEhz1lX/Kb6eptXHkg1BT8/UKRXaES/MFBP2U10YbQVqPHGhF
 uSLCuW9X/On0pCBaYnASUcfkjJaGFvqvyrx4Z9I=
X-Google-Smtp-Source: APXvYqxRSVjmIcjVNNzS50jaoLmyuISxT5AB+ZcvLDJuf62OPNedgK8lmaYwkc+QYSqaeCky4YAYFlIi1biaV+ndcbQ=
X-Received: by 2002:a81:27d2:: with SMTP id n201mr26471359ywn.28.1579156125425; 
 Wed, 15 Jan 2020 22:28:45 -0800 (PST)
MIME-Version: 1.0
References: <CADdPHGvjZdh41u4HsSBBFs9jHohQ0qT4UJ223vysKANYZfzKRg@mail.gmail.com>
 <20191226174733.GA513665@chuupie.wdl.wdc.com>
 <CADdPHGsGtqOiS3ZXxf-6rOPeXAtREc-Ag3EAbPaQybtLaKU4Og@mail.gmail.com>
 <CAB5Wxwco3KD1e_nRGQ_mWAMa_2d-wP2-1Aao4ZXtDeVgFQQM_w@mail.gmail.com>
 <CADdPHGuJjpY6WNBw5hGFUKbJdrwM-oQ9A3xCy3e2O6fY4yzEPQ@mail.gmail.com>
 <CADdPHGsT8JxqWN8KKnQgJvNFZXzq08pd5eR1RJeUN-cmhQYH_Q@mail.gmail.com>
 <CADdPHGt+vLDp6hx0u3nabW7s6Ut11Jzbb4gx2NRD95zu3H9mvQ@mail.gmail.com>
 <CADdPHGumJGQcuHtzFZKmezgec1Jx1fBjAJeQDf5_n-YWvowdeQ@mail.gmail.com>
 <27c302af-0a0e-2739-6f54-b09007d088e8@grimberg.me>
In-Reply-To: <27c302af-0a0e-2739-6f54-b09007d088e8@grimberg.me>
From: Stefan Majer <stefan.majer@gmail.com>
Date: Thu, 16 Jan 2020 07:28:34 +0100
Message-ID: <CADdPHGtfGX=ZnJ_K+T+1CuF2HyFJA2zw-KU39foX5em+kXw1Bg@mail.gmail.com>
Subject: Re: null pointer dereference in nvme_tcp_io_work
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200115_222846_780551_C801624F 
X-CRM114-Status: GOOD (  11.75  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,
Sure, no problem.
Wil report back. Thanks for looking into.
Greetings
Stefan

On Wed, Jan 15, 2020 at 9:03 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hi,
> >
> > is there anything i can help with to further nail down the problem ?
>
> Hi Stephen,
>
> I cannot reproduce this issue with my environment (both host and target
> are VMs on my laptop, kernel 5.4.0 qemu version 3.1.0).
>
> Would it be possible to try and use kernel 5.4 for the sake of the test?



-- 
Stefan Majer

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
