Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A440EEF99E9
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EoigBoa3T+kazzUIjBgm9e7AScIy4l9rWD2ukItvrXo=; b=bbIzHjSt0Gxe+H0sbEa4lY3tiA
	0/dGILqgXgZlrzphsFrdXn196YwRaQLvIcfBj/yiYkdo9aZM7eKzw5C54ZxGCN0w1PE6onvtfdADj
	/r5XCwStKeFQLl70EDKsiZHrkkFyf72G/X7eDSnoA4zkI0leWURzpGl3aT9f3JI/8wDt5XOPX8LJq
	D5qBc5gGwOS34+o2ts9xXxztcW5FH3rzBMz9B2KBlnVUG92fpleTW2D+71XdHjMOMK3SBCUs4e3Vr
	X1aaJzG+drFUz5L27a84ImO6BIE6400Wffrdsk2vBjL2ZNoHoAIE8sjvtVKs8jLcczOhKA4JIKN6R
	hsOFpA9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr3kd-0000000457M-2lOu;
	Sat, 14 Feb 2026 00:43:11 +0000
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr3kb-00000004571-0AAh
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 00:43:10 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-5fa26e497feso546882137.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 16:43:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771029787; cv=none;
        d=google.com; s=arc-20240605;
        b=KY727EQzTDROVduzhNoQ8QkfYZpxZi4hSYGCmUZILAyDr2rwz3TQOwjHldAMiZnlBA
         fvU2kBfLPcs23gBeSe9aRIcQJ5LIqS7WmzhbPI5WvoMhvHurNcy9VsC1JiJi3NR8pMXO
         6/xRdLLpEuvYbYQZvxsEsaoSeraIWPMBXvHlxJqRnxLK6zgNQvc5VdwYI+MU0Y3sPVVF
         0E8LX5D+/Njg8SdrVz1xBYwL58Fprt19v/qWGy+oYLoA3OJ6Vw2NOsCeJRR7X/aO0RMf
         62mkuTF0JfoZuZ7nVjwbQUg4k4PI8TOV7Kk9QrMN04tiS/NA8Q2MTjUGPA08g8j7yjxk
         gcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EoigBoa3T+kazzUIjBgm9e7AScIy4l9rWD2ukItvrXo=;
        fh=rKnSVhyiqJWmkd0e05urj1c9h3V+MyJlnjEOjBiq33Y=;
        b=W1v5i/lP/hS/Qz6c28Nq2BIRUywT+JTiuSyLw/Vj9AocQLv23qlYqdc5Semt+2LNhX
         XcGVWCmku8Zq6B1Ycctq38FObc++yyE6GNdAfl1XjrEJRqdZ8JMfQS02uprHvExwSqNO
         HkbVmIWaC4SbyT/leNlx050ZocchWVHH6Pw8Lbg+Dkn9pNXmaMokGEIqr8oQwinPvoUO
         9GazAFx7O9ZRAkNM9Uvi8hbevfc3V9hIUfqV6x3NlbojaNMEqCjCiTNlOyWIcd2Ylf8v
         IVeYRfKt0AVDvnIr8Wtd7ougQGQns3q52NHLCy3Zd2HXi3IFXVgN3//CDrU/TGU4/gYU
         yACg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771029787; x=1771634587; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoigBoa3T+kazzUIjBgm9e7AScIy4l9rWD2ukItvrXo=;
        b=NnG9fOZba2EuoIqFYn4h/Spuh8QkAmedVgScyvPzuOvmDwVnBhl4sMDYra4WubkLzK
         /McovYsUA7GNBRGfGeg12j8Z50TXC+KhXYe/YwgUgsqTD+jJBauZi8d8tk/DXxxPTpdu
         /fnjt4apEhxmKriiPqy7J0fyEHEcY5K8Buaba2h1B0OIlI3EgentNCs5pEZb1fgsmCYt
         9VbIAHEnf1pX6z3qqvbwcU0PAxK3o8ggWdzo7UlxkISZP7gH5m6uFZHy7FyTA7gTBKSq
         tTop1WVAs/HcJIlaBO9O+HXnHSq+KZjbby+Hl6D0xzkHKsuB6wlPRYoJManEzYfanoOT
         mB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771029787; x=1771634587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EoigBoa3T+kazzUIjBgm9e7AScIy4l9rWD2ukItvrXo=;
        b=aL7MnXPmFXTM1DpyZyUAWgLHe9ruNc7nL63nYJDLcIhQES2PV2tRHA5uwGKay5dCB6
         AexQhnS1LazhrH54S0ypjPxJwZAnCuuCBA820InuNYYNPS0qgMaoYxyfc846KmpDKNHN
         Ar53GRGup8F1sq7A6yn0HszfHd59+rn1FbBPS/46+LlNGyGEsv5t0pksR5eK7R0sq6Po
         t8UOfZB6hm6qAY03ZT5U247XXghcRK/+Oqy3qu1Xs4FbN4igyT3n5Xymm3xJ/n1E/ccM
         gfpK7iiWgLHq4k8YV2sxH8Tx9XKyKNiPHoVbArkxsWW3atjWASy932VeHUL5LwKzqpBV
         xBkA==
X-Forwarded-Encrypted: i=1; AJvYcCWBH7Y/AOMA5ROekQ6ZUWfWqT6lTKmnBIItPb5AW0unH14+hK5YnNFYQEMtDg7dXpV3hIwCDZYElnQD@lists.infradead.org
X-Gm-Message-State: AOJu0YwZO9Sqawb6hsOhLlnsT2k0UvgQFMLs8bNQXW3Yge8MNZzx6yID
	CpQsQs29PbT4ANHwczsOMl/tO9egCsHTFj6zi0VcIbguOhJWs3Vz1UZ1o5WB3s0PSjB3M1zkpr6
	c+ZWL8nyrrgN71HBviatbwI/OePRhNYFP+Ui+cCCyKA==
X-Gm-Gg: AZuq6aKEJO12DwlGexIvhfZxKmXOwANwQFgBaCI71rsEpl+My1TFsG04sMmTbkncGJ9
	eWQgkUKxUJ4dccKcqjDN+1SeCOpqMDQbT7A78x2+QCOL/5aprjvo97pz0UFyPPWUK56wh6KdeCH
	lAZfMnrXrIDsfzewLvirhwK7OGHjTrXryYCte0SbpFWwmNDbhiZ7iNMIqsg1+4DDV1eJ5VRmV32
	xKUdxBjx06N37O/7sosIaWezKPGa2cJoRZfBLQldxpywBsK2Yu8P2NVbw0oy62BCfWiKrjytEZ8
	k5CoIACi
X-Received: by 2002:a05:6102:50aa:b0:5ee:a38a:ebf6 with SMTP id
 ada2fe7eead31-5fe1ae23aedmr1428811137.20.1771029786970; Fri, 13 Feb 2026
 16:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-2-mkhalfella@purestorage.com> <59a8d510-d06d-4d35-b911-c758c184df52@suse.de>
 <20260203181457.GA3729-mkhalfella@purestorage.com> <b695a3f5-bfb9-4215-9672-47abf7e35cdf@suse.de>
 <35ae10c9-808a-4882-86dc-311b23c821e5@grimberg.me>
In-Reply-To: <35ae10c9-808a-4882-86dc-311b23c821e5@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 13 Feb 2026 16:42:55 -0800
X-Gm-Features: AaiRm51xStRLZpcleuOXY1yd-NzQeI1nBBRyn_prpFyYTxENhmhncB7dd4481M4
Message-ID: <CAPpK+O3Uus03zmuqif++5fMVDdXXLiUxOwxdbixRyfkhMTJ5NA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] nvmet: Rapid Path Failure Recovery set
 controller identify fields
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Mohamed Khalfella <mkhalfella@purestorage.com>, 
	Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_164309_260624_495DA000 
X-CRM114-Status: GOOD (  17.58  )
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

On Sat, Feb 7, 2026 at 5:41=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wro=
te:
>
>
> > Precisely my point. If CQT defaults to zero no delay will be inserted,
> > but we _still_ have CCR handling. Just proving that both really are
> > independent on each other. Hence I would prefer to have two patchsets.
>
> Agreed. I think it would be cleaner to review each separately. the CCR
> can be based
> on top of the CQT patchset, for simplicity.
>
Hannes, I have some concerns about structuring the CQT patches
separate from the CCR patches.

We are trying to fix the Ghost Write data corruption, and this has
been a long process (involving 3 modifications to the spec and a
number of proposed patch sets).  We=E2=80=99ve already been told (explicitl=
y
and implicitly) that CCR is the more interesting solution (a
euphemism) for solving this data corruption.  I have some concern
that, if  separated, the CCR patches will get accepted without the CQT
patches.

CCR does not work in all cases, so I do not see them as independent as
you are saying here. Also, CQT is a natural time cap on the retries
needed for CCR to handle CCR retries when it cannot succeed down some
paths.  When used as a time cap, CQT fits well with the CCR changes.

I am concerned that it will be more complicated to review the CQT
changes, with at least more patches to review.

Structuring the patches with CQT first and CCR second would take care
of many of these concerns.

Sincerely,
Randy Jennings

