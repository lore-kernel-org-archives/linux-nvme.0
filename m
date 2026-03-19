Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424BE1088E73
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 04:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8CzALSUm+Ka0N9AV4r/S4cPAz0dgonrsj+PV+lqcWs=; b=PzPLqJDjO3BShXZJVkqttUSPAe
	3PybPiLGuN1EU0XExV7UQRGz785tSUsidO0zF9K3Ud92DLIVrWo1YZ1htfB/OUjuWGS/amXL3nnMJ
	ObhoCA1NsMx8ys3t6UYVaAdrt2v3Vcm93P2krPUM7vXwx1ST8u5Ef7wewz0i8CDpI0S54YmdhTnSw
	z70Bsy2d6jncQhNNgm50EQDxGb289rnDxqXJmtiDoUD1f0qv1dF9+wngpzZAV33tDLPFmMTKF051+
	WEFc6SGlpzqowMnR1mmJtt5FG9giRLcOYStUysO17Edv4etJ7cBjVDjN07PUsQOck0BGdi8vw2gsb
	L1pwNWEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w34uS-00000009tXO-38NM;
	Thu, 19 Mar 2026 04:23:00 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w34uP-00000009tWs-0lRp
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 04:22:58 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-b98133bdc4bso29053766b.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2026 21:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773894174; cv=none;
        d=google.com; s=arc-20240605;
        b=NFtuoI1fR34+2jt5bG0GJr590cPNyAmho4/gm29BZUreHt2EBK7s6sE0blqYMOHHWM
         rCaf3/b6ztzQZSW49MV/IdPfPIuqBzf2Zrz43O2wMgZ6BxquYCgD1CMESuI212TjP5Hq
         tnFN8kskcmkXnN1Xam+ZuNahCG/2RMrSqDz6lIgZFFLnzCeEpJC6V1kpUJ2rQ18ztsfl
         hogInfwi3bu7gA7Xu6+dDQMd+War17wMVlyJFjOIgqmocVDPkBK4b492NjZ43a6g7NBc
         M3NZ7HrUw4b0VZ4S2CVAyQlwBCr/LuhacvFfKXZfM2+PGVCTaBgPP6ApliCs9xXz5hro
         qbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x8CzALSUm+Ka0N9AV4r/S4cPAz0dgonrsj+PV+lqcWs=;
        fh=/sECmlF2/cpU8sVq6vDR7FEH7VK5WT4kEIyvnXPyX3c=;
        b=PnT/HqcdXPJk702aGUJczOgcblMBjgrBgkokRKE70owe9JI/ZcJj6UnAge9p1YvEYl
         PoC1Cg+rYXheH/jdyvniUioqlJ2id686UpSLLsNM9Lx1RSCW0mpBmo0qq6enNSk5Dv4P
         LoTqHYLXHpN3R44CeV2zw7BaKkXgdxXV8umvANbx/bYXBmPWeDXs7SIpq6wy37C3co+P
         sOgbExVFf3wAhO9R8kNH6zKb4KwdWc73wyoSrM9cjO8MFmsqEt4qjeZzbAILpE9i3jA2
         yG0jFHkz1+tGhuhwIWOhv7d95mF0X8mUSQI/DoeUZBSuAMB3nJDiiJoWrAt4eFedGZwM
         zHYg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773894174; x=1774498974; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8CzALSUm+Ka0N9AV4r/S4cPAz0dgonrsj+PV+lqcWs=;
        b=nq8OAzFj4J8PAkPMSUy3gJ5daGFbd+sO3G2vgLPqwXQ0JjPe2iL8gbHC/cU8eCfl9b
         gC69T2byN/ZjNrOO7HXnl0GPAUX3+4UvV8lf6jvZHQ6mo5dIKpOuBIEDZ4xtDr4uuUc+
         lbVeNYErZhOf1ogynbtj1rmwhBGamW6x8PyRkzcnH87O8p5fBxyoYnZ08LDvIpHyY/2E
         ST0CsdeDdTYha3FZmrPIvxxOvh++7TT7QYY/aL4qByAKW94GExi+gPv3OSlcYMgke58c
         8A+FJp3pruTZ5S+tUR0Bkt0b7rARs/zwx3I+FRBOZp02WoJ4t01U19u/Y1SUYCFKKbv7
         ACfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773894174; x=1774498974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8CzALSUm+Ka0N9AV4r/S4cPAz0dgonrsj+PV+lqcWs=;
        b=XF/eS8LDHy+9qA8haN3AqUXzM/HvQnzQhodUvfRPM1hB/QJPpJsR/ywD5rQ0+GMGFm
         YdA+B9+q589PIB84nemMH1PXOAGeDd6Q2lI+pBZwGi+MPqFQZjtoQrw4r58HA8gkCA0F
         jUj257r6eLMuVy0Q3v3UR5NYvwywKhIs6N4gVkcskRw0ZAje+fv5EfNcJ4eRDzvPRuHi
         sYqKoE6pWjCFAQChf2zBC/zRTimlXSrg/mMOQ9rhDCnt9sEQ1fOaOawSd/Wdxs8m6WAa
         ee5OBbBqwSjccf1nud3ncwuKJDAgBfGVOiAptOPtGlnvJhUl83MxaWKJ/BN4D6X2VbWL
         RQGw==
X-Forwarded-Encrypted: i=1; AJvYcCUWx3U4l6juvf/ElXQeAtKZ+lSWYnAWjMxgE1YT0YeiH2FjqOa3GlA2N9W7wJel2seKAxb4k4XZ3Z4d@lists.infradead.org
X-Gm-Message-State: AOJu0YwaoSzB/DdV3uOsqPGkUcq+PRvvod49ar/04FZiqalAstXWQE+z
	Tu5cqgvB2/UXRzfxE4m8P4E8g1SK7QKnwjMn9mvyLo2oXDIKgGC8vqvAfhb6JEy6mWRB99wdCir
	X1X3huWVT4KoSaBi1SxvXOIllHNHaMww=
X-Gm-Gg: ATEYQzyVrodK13WL5cA3fO1QuWmuyOlG+yj8EoJ8qL+HG9rjQ5M1kHaACLiKff+h0VI
	38eRHdh5FWMwDMyUYOehvhpoPMWDZsn8VIE+8lgVKMyFUCXIy2qDiUFSmCEdCj3sHrIqOZeQ1oC
	AcjqQnXRR/RUiUpdNJmG3zcM3/j+cWnCV0NBtVhhaNdxbLs1z+0770gwqOqWdjg1j0XFk3b10PI
	HhECIcz8NhaZ9niCZw/c8gg6Dnwd8isX94eOKxP/B843ApmHmodbOgp5iYVDI7E2FC3RxoUp1DC
	UVRtBKp0WRCZyXDQp1Hi/dv7+LDdOMTqYtpZvA==
X-Received: by 2002:a17:906:6a01:b0:b97:fe6d:2e4a with SMTP id
 a640c23a62f3a-b97fe6d3a3fmr281946066b.10.1773894174044; Wed, 18 Mar 2026
 21:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260317031330.2794078-1-alistair.francis@wdc.com> <20260318-straw-snazzy-a8976b9c9427@redhat.com>
In-Reply-To: <20260318-straw-snazzy-a8976b9c9427@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 14:22:27 +1000
X-Gm-Features: AaiRm53p2JBiytyhn-BKEWWLTA5RRbxO3649MaFpvDdSq338R9Oz3ZmmvcJyU-s
Message-ID: <CAKmqyKNcvLKCt4eibR+h6XDfGzeFU+uBYz6wv7fd-uWgrue5GQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-auth: Include SC_C in RVAL controller hash
To: Chris Leech <cleech@redhat.com>
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_212257_264566_DB23EB2F 
X-CRM114-Status: GOOD (  15.82  )
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

On Thu, Mar 19, 2026 at 2:40=E2=80=AFAM Chris Leech <cleech@redhat.com> wro=
te:
>
> On Tue, Mar 17, 2026 at 01:13:30PM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> > included in the Response Value (RVAL) hash and SC_C should be included.
> > Currently we are hardcoding 0 instead of using the correct SC_C value.
> >
> > Update the host and target code to use the SC_C when calculating the
> > RVAL instead of using 0.
>
> Am I correct in reading this, the current kernel implementation is out
> of spec when doing secure channel concatenation (SC_C !=3D 0) with
> bidirectional authentication (R1 takes SC_C into account, but not R2)?

Correct, SC_C isn't included in the RVAL. So if SC_C is 0 it works,
but if it's 1 it doesn't work

Alistair

>
> - Chris
>

