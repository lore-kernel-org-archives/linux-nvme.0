Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AC9EA852A
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2026 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5WNWcUgIDbmPE05x/v8F166/SMHmYy/5mUzpMa0Vcg=; b=fdY8BNcq0rb+kC56qaZwtyNHtC
	Rh20Y5YQs9qAxeduH1TDZwGBTzQURq8AR0QU4xsYkTTChWEgo4XvfNM4R6xmQ8xvGaHqZ2cJOeLJ/
	962ugaWHsTF8zq44AbU2Oxc5vsm/zHwRxO+2Cm8NsrHvQggKCG6a0GVd66dul5pdnixirBkfy8ygC
	B48lUcNCO4z9aVPbwiZRt1SOWzYYmgcmHYITbODpByI3sK1UWe2wYYiM6/w6wvkUVfczdAzJZIDLc
	N33zkJUApIi0StvLpe7Ub4Lb5VqNRMHf0R5uRzkAGv3PGHAPLwhKlM7u6UBqgUVbasYxqgjtPp41Y
	/WEGQcIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzFoG-000000067LA-1i3Q;
	Sun, 08 Mar 2026 15:12:48 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzFoE-000000067Kp-0u9r
	for linux-nvme@lists.infradead.org;
	Sun, 08 Mar 2026 15:12:47 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so4190505a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 08 Mar 2026 08:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772982765; cv=none;
        d=google.com; s=arc-20240605;
        b=DLe1uIAdTLz0X9fgMvgwwXZxt75XB0AWkOaNF5+k8xR090WU6UcNlk+gfhGLvhwS99
         Ul9xIDwhEP/f+Tx2eOZ8HkHJfz9Q6MiFvSrLviXEqINDA1FRQbHOepYHRKNW5lDgyCZ3
         sEh4UQD/n+T4haviURPLRrulLcvj89J8S/AJNPDrVKhVdZzSz/epZtdlCeq3b7FgmVcH
         g+lt/lkx2jBOHePWvQD7JA06HhKSzeufPTM9BOr3/vwZSlnf2nuWB6UH1jVI+EN+aVKE
         RThFN9H31WZUtTaGB5mTsI9Ag/vCvBeiF+dtkg2kG+SRiQmA1SVjuG1xYPQtkdRFbFbw
         2zcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T5WNWcUgIDbmPE05x/v8F166/SMHmYy/5mUzpMa0Vcg=;
        fh=yOMX44ahgglSpgI0KEKiBxpN2v0H21qrBCY3U3Nk7GU=;
        b=bzTfv7YCedWrRHPaKKdyTJKrKH6g4valRgHdz8R2dHN2k3tZA6PTS3w9K9PPdHMc4g
         OnGyhGABwW9g0i1ccNIfDQYP+4yALVkVr8XjjEnAHYZ7pwgyTWH6bBfwZkFO5ChNU6wq
         SnFHIiAQqDteLK8don1oa9ih4RaFZil91YdUAPI/iac4ZOKjDKuvtozehVOxayZGhDPN
         MasQIYnJm0I28npgOKblDlwnF6+r746F2iWXW1cScAs6FjqVXKFwgtZ5ZSO5pvbS0+50
         Yfo/yGDjmD44o3YFGHHMeVJSmPscUmpWoo0pmwseohdkP1NncBanBS1GgbCUdTzanuSA
         keNg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772982765; x=1773587565; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5WNWcUgIDbmPE05x/v8F166/SMHmYy/5mUzpMa0Vcg=;
        b=B7EMOJ95+ciXtt8HjKCPD4CDuQuNPGBxqm7yjWnZ8Us8UE5hr6gvSZeIuChVowwEJq
         zyXeD6L6do4/61QRmjgcI/hrBZVE2PTC6DrZd607O/lf0F57iLn7P9v9g0PhBxquuWzw
         c2z3T+O1N9EzqkZzbS/7wdSxdFN6DL9R6/qRNNd7F/P3U1JyWtTQPg3aD2c2QOVaNcQl
         2Wn7d45DQ1BxROZ59fFIw5hS+lCYXwPVEe+8phL9ab91q4+F7UOqP86NvhnsQXQmTcDu
         13gLG5C+5hDVZwvPUl2kKsvnu9uS6KpIIyOsByx3CCO96A8f+iY+188KrHCL4wTnkaQC
         x/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772982765; x=1773587565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5WNWcUgIDbmPE05x/v8F166/SMHmYy/5mUzpMa0Vcg=;
        b=lAkxWEGYLVQMquuxhY4mjf0Np8GQxsAn1mycIQBDXN57vdYyUSV+EDN0d1qTd8ZLii
         iOZGvnqQOYKw/rS1y1Xs1UtIsKvosVGGXoADPw068ZdNK6+d0MsBptBeGGxG06Y+Yqjk
         2u8Enyb3OXnqEXJccQ3pmGemG1wwtAT6pkUlt9oT3AWnG84FDn5Z2mRS+yZGtBwnAgR5
         Ucvv39AaY6P0GAznhQOAKxPbOYQRu9OFCI6sNONxW0HRIWhAWy0Wg3e3Lu/irp0b3her
         RPzRklX9PraXY3FaxHnPQhSLTPiAJkJn3Au/y6jmRiCVEdL+lzTttHui4OHlt45q6dRU
         jz/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+LQwtb9Za+MN7ssl1lkp1pRj48Pyl/FwCkHvNhjzYY263tE3Pfme0BcXd77Og7ZWhMdYG/JHn9XtA@lists.infradead.org
X-Gm-Message-State: AOJu0YwMxxfoVoDdr20/CWFMT+AXaZfd53zBQN5NpHouCWFozPwQu17Q
	FFNDGQpFp10TGRqvbk6M5MyY0TjBrYIitP99bkjzf3dhvO5prB84PoXKed3QI5dcuL3mNAcDPLq
	8Tyz0a1xo3yrteKkpjKNJ/8kM1xTVK6g=
X-Gm-Gg: ATEYQzz2Y9bKAcpI6BNf6MW2kYtd6/nyuO8DW4L6G99DsGgf/Mrk0ZqFzQ62h0hfel0
	aAwMBk5tixQdDoFgU3efpIn8IRXNqhQDtorc1EYcxTYtTDF8EYLIC85PZ5JWJA67p43yE6jc8hf
	rW9k0USr7wEGk0NLygc3PvJUJOUrbPEE72us6IZ9zp9x2dZzFj7EyxWy2T1Bma52SadBGRqNCRy
	oaYZmBLHiwVTC9Ne9qasHMybQ/prpfo28nPCtrQ5Ei833bMpt116XgO7PTosCsez5PTxLTLI5a7
	FLvBtCc=
X-Received: by 2002:a05:6a20:729a:b0:395:4dbb:7e69 with SMTP id
 adf61e73a8af0-3985908729emr8032682637.45.1772982765360; Sun, 08 Mar 2026
 08:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260211160859.GA11869@lst.de> <20260212013338.1417091-1-ioerts@kookmin.ac.kr>
 <5eca9b82-c6bc-4d8f-a939-db3399baca57@suse.de>
In-Reply-To: <5eca9b82-c6bc-4d8f-a939-db3399baca57@suse.de>
From: yunje shin <yjshin0438@gmail.com>
Date: Mon, 9 Mar 2026 00:12:34 +0900
X-Gm-Features: AaiRm50d0twjesiVtYbCcSqmYJOioCWCCvhfCXKD2lfeCwCpEr9ldyK7-IWe_Ew
Message-ID: <CAMX6_QG0A=Tow01x7N39iAp=chWCMJGxAF6N+tqGpGQFwjVy6g@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: validate negotiate payload length(BUG:
 KASAN: slab-out-of-bounds)
To: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org
Cc: hch@lst.de, ioerts@kookmin.ac.kr, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260308_081246_259396_1E8D562F 
X-CRM114-Status: GOOD (  13.47  )
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

Hi,
Gentle ping on this patch.
I wanted to check if it can be queued.

Thanks,
Yunje Shin

On Thu, Feb 12, 2026 at 8:03=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 2/12/26 02:33, YunJe Shin wrote:
> > From: Yunje Shin <ioerts@kookmin.ac.kr>
> >
> > AUTH_SEND negotiation requires at least one DH-HMAC-CHAP protocol descr=
iptor.
> > Validate the payload length before parsing the negotiate payload to avo=
id
> > out-of-bounds reads.
> >
> > KASAN splat:
> > [ 1224.388857] BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_sen=
d+0x1d24/0x2090
> > [ 1224.407035] The buggy address belongs to the cache kmalloc-8 of size=
 8
> > [ 1224.407998] allocated 8-byte region [ffff88800a6537c0, ffff88800a653=
7c8)
> > [ 1224.412412] page dumped because: kasan: bad access detected
> >
> > Use struct_size() for minimum length computation and move the negotiate
> > restart flow into a helper so the call site stays compact.
> >
> > Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
> > Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
> > ---
> > v2:
> > - use struct_size() for negotiate payload minimum length
> > - split negotiate handling into nvmet_restart_dhchap_auth() helper
> > - use NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD instead of NVMe status
> >
> Reviewed-by: Hannes Reinecke <hare@suse.de>
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

