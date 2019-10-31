Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2265CA9ECB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 22:21:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A90E20663
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 22:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XZyqhakf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+VaOotk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A90E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fjq+8QzrZb1EBoJdux3353Rbo62KWv0KRgY76CGjtws=; b=XZy
	qhakfIlkBfWOt0YB8cxEzIPRK1JEwdWTBWZXP902vjFaU6AwWv9dmw7YPNR5lwZD3hwsgJB+0rCKK
	eM2n9CPIjYPEL9gkO6J/n3/lrVV3Ji16OqoIdy4RjDtXKDosNJjdfm+U6UWtfHMLV3nJXOjCxfznc
	MU1+wvPHTY2PzBcZzRI77pHkOoaoTvR+6GZO0TEdJ9YWKEKSrR5tD2fRW3J/eIxFFaGnF512t0D+l
	mxv22ZzJ9Cr4j655MFxghw5t0PSedLlp5BKnbT4/LNHsfkseJngrI6LyFNIcm97UbFtqsKW5V66xh
	XdFrATc171vV3yK3h1aogcfHBkhxlIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQIob-0008Oh-R5; Thu, 31 Oct 2019 22:21:13 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQIoX-0008OC-78
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 22:21:10 +0000
Received: by mail-io1-xd43.google.com with SMTP id r144so8618525iod.8
 for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2019 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=A2KarTYi3vDeGcuJsL72Q858q5TPQvxECkuNd/c8f2Y=;
 b=W+VaOotkmYqle6GnCP4l6bsfJSXEscdqS7JcDcEod5S7mJWPavjeCj0wO4ebK/kwV/
 9rZj2qbRGQEJxeHimAb6rKymluY6aphdvmgfqpEy6Txo01PHbDACmMBbPhEa2iy3EMGL
 zmFzHyUd3rlOekL9I/dAsYcyeb31Deqw5iRRu99SW0PtsObhENrj/KxZGFED1jLaxX7E
 OeZ7vMDeOnpintKfoqnLIvWyM8zd3Bsem9/h8mtmjMd6zZZ9tc0E7Ol49x3glF19uR1q
 lUMyx9PsFSmZ1R1KtI0hCTMU4BFisTo6K8QIyx9nk9vhAEMCi8qOn3vc7gDp+Q1JFbJD
 GQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=A2KarTYi3vDeGcuJsL72Q858q5TPQvxECkuNd/c8f2Y=;
 b=r7ZKotQXp/sVIYoTKNOF4l/1U5bh+NYTPyYIWHl13FyxUpMy9YdLbC6On+BO2UTjMT
 h8UaajpjsL6J5Fc4X78eTSThw8Vtzze/rT5SKSWE18bBWWC4iCQ1qJDKhTl1Od+JJQ86
 9sMW2Jix5ezkxXXgQjGsOCahhoF79LTSaTMOqPxS/6HwMMFRFlWVIh4OfePb7KM+8Zcl
 ZEUAN4HgPMRupKzC4KFzN50RWzYwM/wWfX3DEv7FVLlZnfYAmkUGSK6wYGUgAoJVYs6U
 iA0rTZUF+bALr6dIz2TvMOze1J60nF6ezLWBs+39h/W2CrRdetKgAQGtdqO9otjGHJ9L
 yJfg==
X-Gm-Message-State: APjAAAVJBHjN46bFW8Hv71/4HU3+uP4Vwp/jbNDpAnsckBy1MS7YrVRm
 al7l7qSk1ih5PC9R1mYCEiuXvTCLTl+pbht9IbZftOgv7aQ=
X-Google-Smtp-Source: APXvYqxI8C1+XHa9W6P4JThdF8dx0xgWA9ItfCCMdA7p1ua9Wg2cmRr6Y2TYzuOiTq9dCtFMXuOyDXPDjK0MWUHIxlY=
X-Received: by 2002:a5d:8789:: with SMTP id f9mr2914469ion.237.1572560466987; 
 Thu, 31 Oct 2019 15:21:06 -0700 (PDT)
MIME-Version: 1.0
From: Jeffrey Baker <jwbaker@gmail.com>
Date: Thu, 31 Oct 2019 15:20:56 -0700
Message-ID: <CAMCX63zfn0EQ89qKdyDQOzU4V8qj8bf2PYARdvtGZMs9e__AdQ@mail.gmail.com>
Subject: Possible to configure nvme irq cpu affinity?
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_152109_263959_4AC5C5D2 
X-CRM114-Status: UNSURE (   8.56  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'm running kernel 4.15, the vendor kernel from Ubuntu 16.04. On a
system I have with four samsung nvme devices and 20 CPU cores (40 CPU
threads). I have a weird mapping of nvme irqs to cpus.  Each device
has 32 queues, each queue maps to 1 or 2 CPUs:

# grep -H . /sys/block/nvme0n1/mq/*/cpu_list | sort -t/ -k6n
/sys/block/nvme0n1/mq/0/cpu_list:0, 20
/sys/block/nvme0n1/mq/1/cpu_list:1, 21
/sys/block/nvme0n1/mq/2/cpu_list:2, 22
/sys/block/nvme0n1/mq/3/cpu_list:3, 23
/sys/block/nvme0n1/mq/4/cpu_list:4
/sys/block/nvme0n1/mq/5/cpu_list:5
/sys/block/nvme0n1/mq/6/cpu_list:6
/sys/block/nvme0n1/mq/7/cpu_list:7
/sys/block/nvme0n1/mq/8/cpu_list:8
/sys/block/nvme0n1/mq/9/cpu_list:9
/sys/block/nvme0n1/mq/10/cpu_list:24
/sys/block/nvme0n1/mq/11/cpu_list:25
/sys/block/nvme0n1/mq/12/cpu_list:26
/sys/block/nvme0n1/mq/13/cpu_list:27
/sys/block/nvme0n1/mq/14/cpu_list:28
/sys/block/nvme0n1/mq/15/cpu_list:29
/sys/block/nvme0n1/mq/16/cpu_list:10, 30
/sys/block/nvme0n1/mq/17/cpu_list:11, 31
/sys/block/nvme0n1/mq/18/cpu_list:12, 32
/sys/block/nvme0n1/mq/19/cpu_list:13, 33
/sys/block/nvme0n1/mq/20/cpu_list:14
/sys/block/nvme0n1/mq/21/cpu_list:15
/sys/block/nvme0n1/mq/22/cpu_list:16
/sys/block/nvme0n1/mq/23/cpu_list:17
/sys/block/nvme0n1/mq/24/cpu_list:18
/sys/block/nvme0n1/mq/25/cpu_list:19
/sys/block/nvme0n1/mq/26/cpu_list:34
/sys/block/nvme0n1/mq/27/cpu_list:35
/sys/block/nvme0n1/mq/28/cpu_list:36
/sys/block/nvme0n1/mq/29/cpu_list:37
/sys/block/nvme0n1/mq/30/cpu_list:38
/sys/block/nvme0n1/mq/31/cpu_list:39

There's 33 interrupts for these 32 queues, nvme0q0-q32. I don't
understand that but it's not the main problem. My problem is I can't
change them. I get EIO.

# cat /proc/irq/43/affinity_hint
00,00000000
# cat /proc/irq/43/smp_affinity
00,00100001
# echo 1 > /proc/irq/43/smp_affinity
-su: echo: write error: Input/output error

The reason I want to change this is the I/O rate on my application is
pretty modest but constant. On account of the way these IRQs are
spread around, such that there are 1-8 of them on every core, none of
my cores ever go to sleep (C6 state) and consequently none of the
active cores are ever able to clock up to higher P-states ("turbo").
In short, all 40 CPUs are stuck running at 2500MHz all the time, even
though under this workload I should be seeing 3100MHz
opportunistically. This measurably harms my service latency, not to
mention the power consumption.

If I could concentrate these queues on fewer CPUs, I would.  Is there
a newer kernel where this can be configured?

-jwb

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
