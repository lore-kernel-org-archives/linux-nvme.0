Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216F606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QZxM3ijI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlQsSTzJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZC8KY/zVt/3XvTsa+avKtgzZjJJCkMC+z6b2LaJLjVU=; b=QZxM3ijIUKwkZL
	4gYITXTjCrithGGq3d/JLo3z4DdCzuR0abOohvCLnAXJMOsL9XtTVLpJKb8+aBEhM7tCCYjtyfHjI
	UB3yrWxMW0gGqq8WPypjsF1YT94pzBseWKUnKe2IuiJ3PvKJhagfjSb0KLG1i5Yb8SXNNsoo/fDid
	GswjW/86QpgN4QplSAXUhIq2Vsz9EIXBsNs7nkypiU1WzSxkHMiYaAAofHqtw+ttGy6NYLkg6gTtV
	KdWmJ4vXcGOhA0XBH2xt2g+SckM4wjAEnsAfx6cvsZ9ENXHHdfdQkqixzzw12GvIm1pmbYnHbiUeR
	CGDWV0qXFSZiwn6j2ujQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM78d-00000007dUr-0AfT;
	Wed, 28 Oct 2026 17:08:35 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM78Z-00000007dUU-3d5I
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 17:08:33 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so2126902a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 10:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207309; cv=none;
        d=google.com; s=arc-20260327;
        b=Zye4XFTy7T6JlLUhOtbQCYHApNqee0hyPjLvZN3wod42Xjt/tWSlg0oHZnnhFnbcyk
         ymFUSoWUpyZc24SRzdJRPTAiNMq/UqZJZsTjT8iZWeyao/e63WXjo/A+TK7ycmPUZDyL
         td/iSF84+Q6aGet43kmkQLHOi9AXrovkzpCHgWT0Tdt9WExjMFiU8atnY3jJU3/nZl39
         OUi6Y5f5qZaRub/QLTwjCkCvqOwbC2ZT88bd+cVlyux3rBl8o4uwQUBwg1r050j5Bt8H
         dGeQ24dmIFfRjsuemfoGlpWIoYx7Dicc2TRAmKRAOo9X2/hHh+GivE3Eb33RU/e8E+nA
         IjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZC8KY/zVt/3XvTsa+avKtgzZjJJCkMC+z6b2LaJLjVU=;
        fh=+J95F2sx0TwPKtRpt+/pVuvqQiv9VtWTLn+j8f9zwio=;
        b=RxDIYNACP73cSjEMq4dN0AV1XiibKCAy5JsN/0l4dCdGOqsLn+LNX6ILltih14gMbJ
         yhglzQOl2MUypDVS0XvQrI7RoO+dn28TSMt3Vg6OSDXaWpJOeyLKZbVZ5edUdnYVIwXt
         JFtIPbDzepcwdkE3FXVImWbVDEoQc8P9t6W5NrOQYuby6Sm0BEFo6RN8/TbNYYiUZ6l5
         nPzgi3OM4rSMYwtM3E/7MzK1iAeYIsJb4MHgBNeto1rscK3QvqUx8iJNjD1hg1JBLs2U
         cqkQ1m6Cn+B5g4Tq5XBKdC9z9zPhnF6yA9pZ4vB72++8riZbLB4V/9fu9dlJxgL0Pb5S
         j9bw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207309; x=1793812109; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZC8KY/zVt/3XvTsa+avKtgzZjJJCkMC+z6b2LaJLjVU=;
        b=jlQsSTzJO2L+iQNqHECuXz1zY9+fvSr6vRMiYQQa0MDB2gJGZ9jGG4/UkrXqf+G/NW
         onbyX1Yn9BJvr5itGrSizXU07GZQZBNwdt7OOI7a+mwnlRt8+CTqd2YcTj+C/zQkWFiB
         syAXBpcpZWTJ9RNjAqgKnGRDgxhEXCMI0AlhETWZ5LPUvKJ2azhFbYS1xmu/AkF0Hp01
         9ejnK28egwlwhOYg9UmcOOeppGlGuonepqVLrCHQRJCg9HCTZ7GwS/+STv67NwBh6swi
         cCKurtS8pq0elpCLKz7Cysy9A7qlVXJ+1L7/Z3a3MwnlFprsWfxu136PB/BTYCsCdNma
         oGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207309; x=1793812109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZC8KY/zVt/3XvTsa+avKtgzZjJJCkMC+z6b2LaJLjVU=;
        b=KMCEvOtpzPFTTrsMQ1B05a4AZxwj9E6kL57p1joj5UcykH9sjn6UsREYlret7cl9Bh
         0jZ7iBa/m8MZY0n8haz4CyeqG8nB5R6JYw551GUyX7nt3ytF/BYv+b1vW1sk4sivSMgg
         r82O64Fyj7QHDTLd5tlB/wECPWWBGANnrjEijLWkuR9JjlYfKw+fvCGzdHrtWMIRJ8I6
         c+vfeoAIqctVq4Rj6p91LbiWkRH5AF93NvrtbN9h2mw4NctEAZ6Tku1ptMvxZuuepB0X
         OAjDEMn6m1aGGMfyvVLnC4fNWDjuAmCYRS8aXJZ6IFL3Nf8BPMQA0ZEn7lseUVNDKPzf
         KGyA==
X-Forwarded-Encrypted: i=1; AKwUvBwyP/GFH567ohHy4CEe7vlofpMrcyQMBIwEy5QKPBM57rGS7nyB178wgCnQcWjFmaLthFW6Z4UVwYRe@lists.infradead.org
X-Gm-Message-State: AFq9FYIQJrYKalfYFlFP97/hPnQOuC5QFI3Lw2pU9UDr533qSiLkt7py
	gx2pdc6SgYdIY+WYipGVfeXNhqi7BrlUCu572Y6v91MYVGWyKFwXsLqlVP9LDZc0M9KBt8QqDo6
	0JwgAyV8xDvcNCB48cTY4pooV79z9E/E=
X-Gm-Gg: AYBFou1901oumj7I2RJp+V2qJjr60IcWgTgny4YU/8ORuh+NM235ikVu/jVXYUlWpXo
	muj3LHNTkOVPvyoWmD0HNG7pFrWXrPo+ZDRtFLSS11T6xp1+VPOm5vemzo5SAieDNfypmJg9iUl
	DLBMECzuAierTo+lo82UNyV9b/8jjPWX4vmz8Cb0oU+zS11yXp+vgdQ4dg3/sn/6Cyl7cXQ8glc
	wyI3isjdraHdWeF26buTV3ePEn9ymf9toYy9ft/NXnGwMmiq1s9kQXnHg+pnPEAQ9Wjwml0zEQ+
	rZQeVtmk5B7D0tPqcZLK4igDEi/NPNzbck08FX2k88LOYiuqwrzhI0/4DwaoiiprBRf/g463sTV
	6O4uRnw2oJnqMN/PPWPCoG5nfcuUNocJKYc8l
X-Received: by 2002:a17:907:3e8d:b0:c3e:d2c7:c530 with SMTP id
 a640c23a62f3a-c49bdedfbe1mr261186066b.12.1793207308831; Wed, 28 Oct 2026
 10:08:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016141208.2641974-1-e.velu@criteo.com> <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp> <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
 <atJk_2FmzjUZYO_Z@kbusch-mbp> <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
 <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com>
 <atqZmctbU0siYmVX@kbusch-mbp> <7fec6534-9e57-4041-8699-72c5950c7e2a@criteo.com>
 <auId5RuBhMFGirJ1@kbusch-mbp>
In-Reply-To: <auId5RuBhMFGirJ1@kbusch-mbp>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Wed, 28 Oct 2026 18:08:17 +0100
X-Gm-Features: AclHuK-5_1Gilc9_SLXAMsAbWyhTvmhD9biFKJhmkVB59sXOJbXXsUsXwUEcFRA
Message-ID: <CAL2JzuzMo3xTMbF6LK97yf6-CB0_NGhr7sGpf69Gv3ONvZQ1KQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
To: Keith Busch <kbusch@kernel.org>
Cc: Erwan Velu <e.velu@criteo.com>, linux-nvme@lists.infradead.org, axboe@kernel.dk, 
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_100831_925695_371C73D3 
X-CRM114-Status: GOOD (  11.86  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le mer. 28 oct. 2026 =C3=A0 17:08, Keith Busch <kbusch@kernel.org> a =C3=A9=
crit :
[...]
> > Considering the performance impact for these type of device,s would you=
 be
> > open to a backport to stable once merged ?
>
> Not sure when a performance improvement is stable worthy. I'm more
> concerned that doing this is going to expose corruption, but it's what
> the device is asking for, so fine to introduce it, but stable is
> questionable.
If we consider this dangerous for this device, should we add a quirk
for some devices that could be seen as lying?
PS: I'm still waiting vendor's feedback on this question.

