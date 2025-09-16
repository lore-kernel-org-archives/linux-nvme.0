Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1049CAC598
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CN6Klq0OHK0wKPP026Wnqvf8WRiTBMfcL1nd6Si0b1o=; b=LUTaKlIlFu24YDq42TvTt+9HTC
	AFrLhhiuLgEpidS4HCkiywJTNXiQ4AEOF5eF5PPFQAHl2hckRstu0IonkYDR1b66Gd8msR5JrJpRH
	b5Dnt+cVXX2WNUPmxEfunSxhAonE0278q+KtRiyHT6EHi1fN9cOOvDbFXKJgEXSn9zUzqsHDp5ROW
	SBIBSv+3aV6sFADDO6cfg1hYlYZ9py89+T5uxhxlE2v3IpubSZVd/Mz7yGYhwfKhLel7suYo/kBzF
	XVcg0OzSlkzEphlSU78a1rV2QNUEyv8L00tFUvrF5sctFN+Oe6ZlAnFp1iEO0PKG/anXg468c9BJ9
	LAI/MSwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyU43-00000007guC-3Bqo;
	Tue, 16 Sep 2025 11:41:39 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyU41-00000007gtr-0fQ1
	for linux-nvme@lists.infradead.org;
	Tue, 16 Sep 2025 11:41:38 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-32e0e150554so2023372a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 16 Sep 2025 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758022896; x=1758627696; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CN6Klq0OHK0wKPP026Wnqvf8WRiTBMfcL1nd6Si0b1o=;
        b=OoR7te9lVUkoqyqTtok6WTAUdON/njqnCttkhjDz6wzahaSRruU66TAcDmDY8wQjQz
         yiqp6FB6wiKuWjW/Pi6iHCkxynimBfPfRzkdR6Ynq27BZLrWSAc86j2jIf3nm0IlYga4
         0yJKzAANDYlKBNOgu7OANjS1wzzpq3zNHWQw7JlEbbvfXhpgra10+vqksGaopwGlgvxW
         rAN9Dtg+ehWXbCVkqf2wvt2mrb87rcVT/d2zK8VTKkFK8cLzuPRXNNghJf0bDqKDpMT9
         fxDimHP7alvrl8eTh+8ey76ufFwb630evkyAFg3ltMgUmzL99rxWuPTTLAXEs9P9ZzpK
         Aqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758022896; x=1758627696;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CN6Klq0OHK0wKPP026Wnqvf8WRiTBMfcL1nd6Si0b1o=;
        b=nrhrLQ0sasFxMKlyWHta8zVBqvl7/iFE19eYnxN5fgDicohDKO8wJbjnPDGwpA6vXk
         MEecyLX6wuc3aTqe6r9hYm6uVlLWpTvKQV8DPqOZTL5E8UPHsrwzVQgY1UVe59RMDwTe
         bJHoszSrz1RcxvoN1MW2B/ILAs5ubbWxBXw4uvOwgeenpyYUt5GRdCu/S90iyqr58+6d
         ioENCQhIdtttUvuVqK3x00PseF6eVy23SGeruNEC0XPaRuyQKDUNLncvhqxMsJx5JWYC
         VZNNxTCuK04OTpo5Om7Dp+glWT6WpeCWBdibUblPrYjJuZDVswABQALFSSVYsKYS3T1s
         hmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVQ3hN9FpgiA8tqmKWT2NjJcXY3bYtV6hfXyYh/UyBPxymUurUoOPKdC2/8TsgP/klBmT7GbRJLhAr@lists.infradead.org
X-Gm-Message-State: AOJu0YyqFtgBuMAguY2KQCwLO+a2fKWy2caCJjrvbxpeCSChjaORt2K3
	vRJGbBPBMskZOklNz4DAFR4PrgOt5ezAB4AEMIiudXLe7dd9E8DoncHq
X-Gm-Gg: ASbGncuLstelg3AqWqpXmHTKdWpmZS18rDw4bEuFd+3SFpUEW4+PloU0BpMYQEeOmuU
	OcuT88+LzgFZYB/byUaIdVika7H+zAwsAlHRpTNiABN9TDJGfjD7tiDXZOKj+x4K1ws/DIMiIj4
	qjo7KSieq+J5vSKRTTS74WoOlou3WwAG33wp7nId8/iOKwYSHSB2drJaTattgeNyocCnYqtJpNP
	YfNyo2hkzQBMbor6/Uly+tnujUEth6QR2RZTLkt6sjy9ka5SuwAHiun8vmWEEPIicopWr/hc4yk
	tn4bIr23F6OIHVnIXJHZiQ6991WlNUDLJZKC8EqjsTMhwC65VlzXQN7fL5THr/f1iyTyhA71C9Q
	bUecZy0XE9ZKqdqX+1wU2dC45XvZ+PVmDkxvj3+XjBaqs1Y+oQBKmgEaV
X-Google-Smtp-Source: AGHT+IEbcKuX518G2WAnU1/JDtD9CZaLoMqzjZnxj06bD1I8WmJTVuOy4Tr/WaWoGSqJDwQnGKltbw==
X-Received: by 2002:a17:90b:4b82:b0:32d:fd14:600b with SMTP id 98e67ed59e1d1-32ea60d5664mr2566061a91.7.1758022896246;
        Tue, 16 Sep 2025 04:41:36 -0700 (PDT)
Received: from [10.0.2.15] (portal-nbc.netapp.com. [202.3.121.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37bf1c19sm7456535a91.22.2025.09.16.04.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:41:35 -0700 (PDT)
Message-ID: <8638a12a5f221b874bb0ec54a5b0bf1bdc31131b.camel@gmail.com>
Subject: Re: [PATCH v2] nvme-auth: update sc_c in host response
From: Martin George <martinus.gpy@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org
Cc: hch@lst.de, sagi@grimberg.me, hare@kernel.org, Prashanth Adurthi
	 <prashana@netapp.com>
Date: Tue, 16 Sep 2025 17:11:31 +0530
In-Reply-To: <32cffc9b-8be5-42db-bec2-871293c5549b@suse.de>
References: <20250908172457.5512-1-marting@netapp.com>
	 <32cffc9b-8be5-42db-bec2-871293c5549b@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_044137_227885_A0D9DE94 
X-CRM114-Status: GOOD (  15.72  )
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

On Tue, 2025-09-09 at 08:43 +0200, Hannes Reinecke wrote:
> On 9/8/25 19:24, Martin George wrote:
> > The sc_c field is currently not updated in the host response to the
> > controller challenge leading to failures while attempting secure
> > channel concatenation. Fix this by adding a new sc_c variable to
> > the
> > dhchap queue context structure which is appropriately set during
> > negotiate and then used in the host response.
> >=20
> > Fixes: e88a7595b57f ("nvme-tcp: request secure channel
> > concatenation")
> > Signed-off-by: Martin George <marting@netapp.com>
> > Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
> > ---
> > Changes in v2: set *buf to sc_c as suggested by Hannes
> > ---
> > =C2=A0 drivers/nvme/host/auth.c | 6 +++++-
> > =C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> Reviewed-by: Hannes Reinecke <hare@suse.de>
>=20
> Cheers,
>=20
> Hannes

Gentle ping

