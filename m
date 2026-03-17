Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DDCFED9EB
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wk/4WPTRNuksYJ3zy3hWGwPMQRxbue6JftOXZt//6sM=; b=NCq0+upZPuDKED7PEmUsKPabH/
	/OOqUfu0zYeO6+TVpbc/FxCZSr+4SD7aaIM3wWajRS6EVH5AY0bUgn+w0pMNasX0W8p1fVkcc06J1
	QqZHQLpIunY9wDaDEmMT0sMHdUWjaonu0M9R47n/h9FI2JD1qeeUZvv7Uaf0NDokYg/r7iWivHWDF
	dGKUIzv/nM9RK8bPbQNLjhaeSM59E5l154Es8eW51tj+lWOTOFSswlqZrxzs1pwZeIHb6AEFCwwqm
	n9WTVap8X+3bzaYordD1gve7wo2Lt3k4aP9MdNgn6p318AvkdkBvUnyZjj3IMypffR4/r1tVlds7g
	aBH6C+9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2XhX-00000006rpd-3r0z;
	Tue, 17 Mar 2026 16:55:27 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2XhV-00000006rpJ-3KM8
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 16:55:26 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so2269439a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2026 09:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773766525; cv=none;
        d=google.com; s=arc-20240605;
        b=C2qyb/yIBH0XEuUVlIrG9OaG2GggvC5y6V0irGAZaDaSqClTXod/XSXelXsFb523P+
         tC7g84t4SShWQL6fdGFyFpjCwVE4BbXnlJ0GX1lX+10aZ/Mv54bD5G4YW7S2QdUJ9FZa
         zNXdqAWN5JEA1P3ZyhCh1Zj2iz4iAbgFrp3x1cXXij04JghXqLi9ilevFSfSueLGGD1W
         MPj8sTbJMJEBV+gHBP+zN+yS4IZmw4y6aEmhvIvySfaPSRphYRSoPmcvQe3feN7+Cq5S
         VzAJkMKL7UX3nGPi0KP/LqBzAomx61LCXKsTBv1t1uSj3AHoheKnkhglzVIvguYRtQKi
         q9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wk/4WPTRNuksYJ3zy3hWGwPMQRxbue6JftOXZt//6sM=;
        fh=ipDJyT++xTRjefvR9yn48YF2qGiLH1zc2dDR7FMTnKA=;
        b=M3MQlz9XpCFM+452R9zvnjZYqi8lpBrlDq4yb6EyjVh5qjMj+WyDJdSkp5B9fVSgc9
         bX1dq5pCjVmu5oaRIJnW/9YKZuLTSn6B4vfI03JzHEFuSYReqJLoi1oUT4BeJEk58ofR
         72Xr1YYurziz80wgYSCH111uiQjWNXG/2dt04TDoPtG6JCsgIQd69c6uQk9ZRIUedGhX
         YeJX5JnVIjQWXAboczWd11abG6lWLmhyFPSkOHdM5Sa4D0argTXFE1dC5z1JxB8OElWS
         yv3XjXRVdK2P2oy7arX/7vso8FuN2PPqCkQljt/saisr8SaeoWKyHe3afQDAZDvH/Q5p
         bgOA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773766525; x=1774371325; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk/4WPTRNuksYJ3zy3hWGwPMQRxbue6JftOXZt//6sM=;
        b=YbL70pCMDuteyWxez/6+YU5/Idzno7RRJ0IwiJDtWjK0q+GDvLB3b8+CcDEtrwK3L/
         FYf/KjToB3GpeD8JrQ+sSzuFFlslQsCuacPaLbCV7ArIfVS2yjwwLlalaLlr/aarG146
         h34mOBkxtqXkbv6qs4h5d4rtdMe+naa/1uQgwYDddh36LW1M8BWe50f5pDMcJ1zI0JcZ
         fQE9svyzfYc7GXqpfash9RUPAkFtXuFTr3c6WTG7que/lSi9aV/vZsuK0wDQfL/z2gXp
         Hs6iMHPiyJ+7XvUP92kj7Vt8a/9I7fkr71/yb6FEbcRdYTWa5U7g1Y8Ote3hiph/l/1J
         BI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773766525; x=1774371325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wk/4WPTRNuksYJ3zy3hWGwPMQRxbue6JftOXZt//6sM=;
        b=Ke09r8lqVx4QltfOMe5xeWWGLSRX2pQZ78HhW4Q6bEEbQvpkIr1nmp5Vaos+TqbdGr
         7tJcD8zxqeCLDpmYGcdN0ElvdtYuTPuWVCDvffXrcODAakySFpRlqRl/bNrkMMKYkm7+
         z1zOkrAB8Zuh0bJ1v0fyIV9YkuuLLnfnKsIpQb26vcCPddC8N+VoaMSBqLtkTFlzdXDK
         sOgwP9hmbWRjmppU6nyuGKtuJTPuOV+pujQuzS0j9uF/005huZ06kBJz8bb98xSiGSTo
         zfxt9apLAre0EpyCzpgOKMXg1+MzGEEc5NxUvD7mp5WJQUOYqq8FpD4PrcDkVAMoSiV+
         yp7A==
X-Forwarded-Encrypted: i=1; AJvYcCXCPCHGkl7F7GtEB2yW3bf5RbCPRXMExKYGziiIys3OvKB4nFReVu05o4uqxlOFc3N1BshujN3v4tx6@lists.infradead.org
X-Gm-Message-State: AOJu0YznuxPfAKcH2woV+17p6bqzEwI0ONQZpoSlp7rcUDF55hKVsWuy
	gkSk6VXTPY92Qtqc52F1jJv6S1xW6SK5ymu8q3KlWWyljhr6D1eWeNy/nZCvT1ZsBCRi3oSvUS/
	jvOAvg9qp9SMEYpJO6QIde07UmhEdnUI=
X-Gm-Gg: ATEYQzxGw4Wy+nhzG+KLTVBk9AO/shEWWZUhw9fn+kZGIVnHetnpBe6bI4UcWBLxPWP
	NjauClCpiNpIaGC7jXRinMxGplS32EUq8IAwyNY1bihj/8Vc0pIirbEugVY3hJ/cXLn1N6PQfHz
	WdJ0gCdRtSXpOJ6S4qlMRSmPde/u73wHiTzcO5mTZ+lW3Nm19zG0mJle52D4vJ8PC32qYctNXoo
	c+5CAuVMsFaQgU0yAx+EY0EP/aQ9A2ilu7q+BX62pyfC+xMyAAT4mevZ3Ag2pIwufFYX6ts3D9F
	L4B8FVE=
X-Received: by 2002:a05:6a21:2d42:b0:398:6bb5:54b5 with SMTP id
 adf61e73a8af0-398eca05555mr16848730637.8.1773766524615; Tue, 17 Mar 2026
 09:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <ec03d5ca-a26d-4427-823a-17c5709391f7@suse.de> <20260313052444.3865842-1-ioerts@kookmin.ac.kr>
 <20260317145137.GA6462@lst.de>
In-Reply-To: <20260317145137.GA6462@lst.de>
From: yunje shin <yjshin0438@gmail.com>
Date: Wed, 18 Mar 2026 01:55:13 +0900
X-Gm-Features: AaiRm53RcHyWssDV8XnwkfAbT5iLVpjfQ8J5T6k9pZ3hFOJg1pghgvIpPwRWb8Y
Message-ID: <CAMX6_QFvhJwCp1v+YNC6BOTsV-7qCW1Q2pKZDOwkPychZOQuSQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet: auth: validate dhchap id list lengths
To: Christoph Hellwig <hch@lst.de>, hare@suse.de, cleech@redhat.com
Cc: ioerts@kookmin.ac.kr, kbusch@kernel.org, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_095525_836545_E4081321 
X-CRM114-Status: UNSURE (   9.53  )
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

On Tue, Mar 17, 2026 at 11:51=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
> Overly lone lines. A local variable for data->auth_protocol[0].dhchap
> would really help with readability here.
...
> Tabs before the values.  Bonus points for a reference to the relevant
> spec.

I will fix the tab alignment for the macros and add a spec reference
in v3.

Regarding the local variable =E2=80=94 I understand the readability concern=
,
but data->auth_protocol[0].dhchap is currently used without a local
variable in 8 places in target/fabrics-cmd-auth.c (lines 42-44, 71,
75-76, 100-101) and 12 places in host/auth.c (lines 145-156).
Adding one only for the bounds check felt inconsistent, so I kept
the existing style. Happy to hear your thoughts on this.

