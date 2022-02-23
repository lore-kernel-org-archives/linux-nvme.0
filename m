Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7532BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Mgyn45Wh7HqAh/Uf+8lT7BxDq2A8OTnCie6iczASjLc=; b=N29L2yuCf/6FSLqvnZhwmpGbAl
	dPDiUK9Riptk8Ij0n/m6M9d7GPXly81QGRxqK+D1tSL3YZzmc+QcDVBMtP29BCS1P2HsZTVgtTyok
	I3L37odwp8Smydz1oV9lLrzGhDlNMDVQDxxJklqaECVbdBsiB5LD5ornGqHZ5AexiPioIICnYTzFY
	KON+8E6XiyLWfXuHxuuadQcF5Kc8k1uJ67EpVQ81W6+e4qKGH2QjmyWDfQbcpxvoD2wHNIv9uEvfe
	Nh38xlTf+0VWLKP/lgpSoRjD5w05fs0HJPg/sOE4tQUwEzqyoDe0HaxNOtXf2N2EiX/e9waoew/IT
	M06BDydA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nN1El-00GHTM-3s; Wed, 23 Feb 2022 23:39:59 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN1Ee-00GHRD-L5
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 23:39:54 +0000
Received: by mail-yb1-xb30.google.com with SMTP id d21so427018yba.11
 for <linux-nvme@lists.infradead.org>; Wed, 23 Feb 2022 15:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=Mgyn45Wh7HqAh/Uf+8lT7BxDq2A8OTnCie6iczASjLc=;
 b=Jkn3s14cmYQB7aM0QtoIaIqNrleNkE3LwPoozPoSEaaCaf/fbHyMkpV+6P0WSMmO1a
 gjlMOU57B73TSWXmEiC3OhSjAAukwlQq+wRH3sONbMlq4o8X6n+5JSem8qflvtcs08DI
 psYx880SqN9Q7yr9hn8bTZ93Fj6Sj/blQIBlggymRZjH9MtDT211ANT8W55LgoH09l7P
 3nXTFLqltbAe2oh1DGLBCvVc023R9SzBl9nHXRhB2X2ad4hAnEZGH0BS4aW/+xzJOD92
 iepNRUPwr/D58xQ0wAMj60C+dKwDNJ9EvQIS+Of3Gz3HGeppjztslpNG+sxLrLuXGdF/
 v0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Mgyn45Wh7HqAh/Uf+8lT7BxDq2A8OTnCie6iczASjLc=;
 b=5mjK19IM+GraF7Ijf+MED+OUmq7/aB4AuDI5y424FdAXZdzt5MICcsBo8/OYo7QhJH
 9WlngM8BPj/C6a5YAGLZy1Hu5GK/ETI8E4USsLaVP6WgAIlN1Ha6N0+8gN4njh2L4rpq
 i9OB6mfHLaODydGoxHmS6PURMdA7KBbabZAl33yIdhg1WkM7octiQSxajm3vMDw34TFn
 92fVSJgpI9sAuwu4bTDrDTFKHDdfVbBoviOcMtdtwJASmYGJ8yplhR+Tn1QScmKbbrMD
 jvcZXMZKwKnLVTalPWVCDiglMmx+XtGvapmTacBaphp9/A0Ltw2gID3T2y5X89RZJyrQ
 phcg==
X-Gm-Message-State: AOAM533s1RbdASPY9GQOPGY1TFQGkcepzC5M0LIwvVL+Rdz4HMCZWFub
 +v5BQgE8GpOxkp59Q8hR5x2weZ3q0TyiQWW8DoenOVxB1GkDsg==
X-Google-Smtp-Source: ABdhPJx1lZtU75DIB6tcnbaTtW6rRbb0aV9nyAXgafdGjKDyNC2aHt3A5rFY+CDMBSkPY+h9VSsw5e58RNt+Ok1M49E=
X-Received: by 2002:a5b:50c:0:b0:61d:d249:d9b1 with SMTP id
 o12-20020a5b050c000000b0061dd249d9b1mr122079ybp.300.1645659590331; Wed, 23
 Feb 2022 15:39:50 -0800 (PST)
MIME-Version: 1.0
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Wed, 23 Feb 2022 18:39:14 -0500
Message-ID: <CAHex0coRbCPVnwVfeHYVxLHQp3HRd5V3aWZJ5uVwyyr-zk9=Sg@mail.gmail.com>
Subject: nvme-tcp: invalid h2cdata pdus in response to r2t
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220223_153952_727928_6DE524BC 
X-CRM114-Status: UNSURE (   7.87  )
X-CRM114-Notice: Please train this message.
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

As recently as 5.16.10, when a target issues an r2t, the host driver
responds with an h2c pdu of whatever length was requested. If the
requested r2t length exceeds MAXH2CDATA, the response causes a fatal
transport error.

In reviewing the code, the driver does not appear to generate multiple
h2c pdus in response to an R2T. We're a bit confused because commit
1d3ef9c3a39e seems to indicate that the code behaves otherwise.

I can see there was some discussion and work on this back in November.
Is there any plan to incorporate the fix? If so, is this likely to
make its way into LTS kernels?

Thanks,
-Jonathan

