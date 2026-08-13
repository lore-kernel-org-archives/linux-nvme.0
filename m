Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D39C5DF70
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SKcIdUVsPmXBigWR3fDEoqD9v2hRGQ9Y+sqraJctfpo=; b=bwyqgmBl6QThxaElLTqARM02UJ
	/KMetRtAEldetaGdlZt78HCK8Wd1Wnv+xg2qNqDLWhuUudu2KjGFcrhKOIqtSAbR86bjJHATcwUR7
	nTQfC461Ta7z980QSH65SUkTNVCa/xi6OvwcsZy3K+AmCfHopA2OYDpxQn4piOFPH/GqOnW+TTXpx
	V/YGD1Emo7YKDJmRVPs+wec3nljMdDh5E4AMjdkEYRNPy2vDDndGBjaQbl1h25D3101aLSZFtX9Da
	t3c/2pQ2HYAztVpXU0Yfic9L98NkWVBCbm4GlzHQdyboyPN45cQv0CPWj4aPDAKwobAOEveI0n+2o
	F0QLIEFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wucPw-00000001YD3-44fm;
	Thu, 13 Aug 2026 20:52:48 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wucPA-00000001XEC-19tz
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 20:52:04 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so324236a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2026 13:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786654318; cv=none;
        d=google.com; s=arc-20260327;
        b=MUtC6Iyj/kux+HNZGaiD0eFYSu7oVAbiwZvSms1kvbUFGgHIfwGdUqgtmFwr035R/0
         RS7NO8zowVE3OHX5WbnH760R/A+h+StdbVCfYicC8wlzasNk24F0O1++5yDzGEvmva8F
         uTOfuMGqLYeCPVbHEpUjqxWmD4FTEMzBnk2QhglQv0O4l9JvWHLwYaSrdBhyVgDEZO+/
         2r0zsoC2a6OCeVayAmKV0UkTGjJ28Vi1lbTNn0ChmsZ/eB4M9/qz+Tq6uyd03YkCQmRb
         0/y/LRf2YM/tZ3+MN9PHJFmwNGbAoYnAi33tjrfk/r7yGrVcGlGHuUNnqMZ9eqLg+tcx
         Bfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKcIdUVsPmXBigWR3fDEoqD9v2hRGQ9Y+sqraJctfpo=;
        fh=hAbchma30ojTUWe/IypsUYSfG3xdtJDhygPBFg770bg=;
        b=kus1en//lwkAOpUY74TNrpOopgOKNS5ODdwxx/i8GOeTWQksgvcyWtEVdJL9BI9Z3Y
         qQmBqYPJjj3IiTkthCzYcm/o6XB48U1HKNzy4dKYUOnIT9JzMlUWKB1ZG8k8oMVA6Q4z
         fxa7jmUl0v45996jf4+g52bIpd+kpUBmUuu7ZQttoXZOI+OQhfIlK6UiH0cCqVwBFyta
         UQhSM5dNI5uVSgtxFYklkFkmSxMAzFJQS3grn+5j+zn6cuv1xUtmMJkXGtr3Eo4LWaN3
         v1kA4d39W8j6g5pQ8mH/6EwPdjla1ofLdt4pMnXQSsA593NTYPzRUq2OE5ku42Mh5fjM
         +tEg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786654318; x=1787259118; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SKcIdUVsPmXBigWR3fDEoqD9v2hRGQ9Y+sqraJctfpo=;
        b=FxGl2LXGqUsjQO8qd5b3yNQIZOpfQ8cB/le0tz0q29cmiQCYxQVW24rqACzO+PpoXU
         bO0NRgxTUFLOZqdiCzhY9tnvv1VeeOG6OqZq+pbGdfCs2lbASYsW/K3+wvZ3OgNVUlyz
         8Y7UNt/52B8k+xM5beAEaHdbHxPTW2P/H9AYWSMPzYXLkiZpWAt6fji6ogoUkN4AMxyj
         cKAAul321tAcD6zlSKnklVULuE2jYbDHjlSwF2PppNTPl71ycsdSbarJWIrbjz384MTQ
         dY05B5Pgcu1ULNyGReO1t0lFnq+TCNZ7KEqbQ000tBiTTnEASYLBqdVmRjKEOc1rudUZ
         wfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654318; x=1787259118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKcIdUVsPmXBigWR3fDEoqD9v2hRGQ9Y+sqraJctfpo=;
        b=gKPgBfP/2jYcjOTORYB1EuDX5bW3u67N4iFO5Sy/l3NopBfHpnQEFGmnUiBY4L+gww
         +IwMnK/yS+HOe/7fg/mZPGDg69rQrigvikvR4//A61yRGMVm2Lb5UqFgOVmOpIjf1sLf
         TOW3EzGKA6LgZ6hgzIhxvDaJPeonGMhDlAZ81vyzswKZ2FUiESnbtaVTkw3EYwQcTFXN
         6vt1GvVHXNA5r15QRKlVMMoEEvp49L6Krs/Cysx9+NHJLoNFPFvu1fNNgYuCjIFuCFHq
         ZHwHJLoQ9J8w1jexYRDAY2B2eKDDmYJBVwHiZTGoJ9E43yF05qkdPmg7l3iyEPs3XH86
         e1yw==
X-Forwarded-Encrypted: i=1; AHgh+RpVdlwXumQ6n7WVBMBXFR7LV7VLrokl/eiycJRq2NhL1X8rA7r40B/srgl/4DprSAghPFW4Cnqd2FrM@lists.infradead.org
X-Gm-Message-State: AOJu0YyJPH104jw5oFeEm7bd0OL0/qVfxU0XdK+ek3UIvrxSf95sadl6
	c2Yj/gNLjrUPO2m22wBG2p4gy/cCuEuL2Ar9nYkLvnL18UbG3FKuCz3aTKlbuvzE9RYrZRlJj8r
	r1gaS9V9HyROJwRZWMjs03aZUQpi6+ig=
X-Gm-Gg: AR+sD12ecIsLEpG83x5fbHS7mI7cobEvAbgFDxpcSYUNs1xK4zVnPEBve2uulpDMorP
	u8/JmDSmTcwvRudoc+WP3ugWn/ZO06cdwbMTuhBA1Eqw9R8TGNVAIv+ufLRyMdx/lnrhU35C8Hs
	33G7vK+906J1vlFbe5+2lkNzznrEvsRpKyAr6BzTGwV6sOk9R4ylPOBvCGg4wE8ALEACY9Ddeh1
	c73GlOWNtJdWMUMzyfVRsoAanHGd/lB7N5Dxn9JRUo2T+Ukkzyf+39usFSBMDtOvAC1mro9Jj2N
	KeqIjrs+dEUZ34/PabBn6faUr6Knr2qrEriBT5ZlmLvt
X-Received: by 2002:a05:6402:530c:b0:6a1:23f3:26b7 with SMTP id
 4fb4d7f45d1cf-6a38a97a9d6mr570500a12.14.1786654317500; Thu, 13 Aug 2026
 13:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260811192111.2058140-1-coshi036@gmail.com> <ant4bioGLl4B35n_@kbusch-mbp>
 <CACd_6n1=oS_Jdq6s=u2jNmtP9n0Yc13BkKqJHSpsjbWHy=X5cA@mail.gmail.com> <anuJTi4sZiCBuMzb@kbusch-mbp>
In-Reply-To: <anuJTi4sZiCBuMzb@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Thu, 13 Aug 2026 16:51:46 -0400
X-Gm-Features: AUfX_mxij6zSANPAqoiBci6Iv7N_fj7yhY5bl1KY0y2Np-JLxzonVg5z2Jce10g
Message-ID: <CACd_6n0GsFdiz-jQfnRmJx0+2zUoEQQPwswkOQk4gkD5xVC7EQ@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: refuse an unsolicited format change on a
 namespace that is in use
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_135200_518910_B38CF82E 
X-CRM114-Status: GOOD (  17.80  )
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

On Tue, Aug 11, 2026 at 4:42=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> You need a nvme spec level change for this to work. There's nothing we
> can do today to close every race where the driver attempts to use a
> stale LBA shift when the format was changed externally.

Got you. I understand now. Thanks for pointing that out.

>
> What I proposed in the past was that the device has to return a new
> error code for all new IO until the host queries the appropriate
> Namespace identification to acknowledge the new LBA format. Kind of like
> a SCSI "Check Condition Parameters Changed". An enlightend host could
> trigger a queue freeze and namespace rescan after seeing this status,
> clearing the device's latch and resume IO after setting up the new queue
> limits.

I think you are right for this. And I think this is a right solution.
Thanks for sharing your thoughts! Helped much.

Best,
Chao

