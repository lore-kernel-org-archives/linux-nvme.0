Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8C2CCF9EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OWeVQ4AtgfB93bgZfN+1XmqssXEaSbhn0NZTenNXkU=; b=swuwNjB+2QpDVtTGqHAZBzMA1g
	bO19VV/66bWKkAkGOF4HR3ui7BvGvhpGYwoYeu0/fNEppKA6HnCebatWYL6/mU9qeCQXyupOW/hJQ
	zecC9gy4X5g4EumkEtY8u0H71bVw06XMqaKE3uOfK9dMz8F1CT/72eNd4Glo+KSc5XZyYqloIU0yj
	CWv+GovHpecQaeXAwJO90gB5qb0DbDa6EzTDxL0+rJXOpLKpZvUhbs+ypNgcbt1SsKBldEJ6am5L+
	mfpbUA9bHCGqLzBjf4XTV2hy7LDKzDT8jN4LWF8GkPN2woVTy1fLbln6kxkHHTRbXZWuZStSA9qrJ
	eJd35BjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDO30-0000000E81x-256R;
	Mon, 27 Oct 2025 14:18:10 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDO2x-0000000E80Q-1N71
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 14:18:08 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-47106fc51faso60223825e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 27 Oct 2025 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574685; x=1762179485; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OWeVQ4AtgfB93bgZfN+1XmqssXEaSbhn0NZTenNXkU=;
        b=jDmRgmbQN4yRZCJvtgIx6Jncet6kJTG5CI7JDI4alWpXSPDYf2pVs+M3YMg4Ee9aEX
         zvYoL2siRhexU919Zh1qsqnzCu8WnrL1s9JR8Pz6V2dv553E/THbPWEc5GP6zfsE49XL
         OSqgJjshyrr4PIhx0F4mjASst5ytVWfXYE0c0bKN2K5LW1jpOQcsWqHHPVJWYAvdaSVm
         kY8jqBcsjO1dgM50T2h/1Ghwk1lIL5sji1HcAg6P6DOzjaiA5c6hzIrEQrZjJZN1C3W7
         QkRvrB8Hxx+dU2uuGt4rB+h27RXu4C3IEy3ClNqNYim+Ray34dCSocPPo9e1s3a/jPXe
         uXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574685; x=1762179485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OWeVQ4AtgfB93bgZfN+1XmqssXEaSbhn0NZTenNXkU=;
        b=sIZANreQHTheahl59cubZGNsraA/it/w7Iio9x193tmq3L/94PQuzKRjIBzEDDeiT8
         gtIvJrwKhXUr+LM/U0DhnVf8QMFNTXAYf89exyTLV+244aL0h+9AVJTUIu5DAuIFcXFd
         xhGXvfMo0wnHVqWO5POw4xsxFeXXAUNmy/br4q3XBRHB1hl4vgnSmFwsdM/IEIYvG96P
         /RFy/sxzkfUBEOmIKud4U2232aYWwl5yb9cjT+MW1s6Jt2yGKt7PKnPIzSprMTxj5X5B
         +P2EXTCD0sSyU3pGQHniGwFpay4paRQ7swBmwzT3MVsFRs0AJ/KajLP7oxFaKBSk1fPB
         X3kw==
X-Forwarded-Encrypted: i=1; AJvYcCUT6REZKiC0m8aV3UrgpN6TD6K1/zep3fGovl52AozmTiGwqY1SQ25aPDQoGP97HJYvdyVgAAViMfta@lists.infradead.org
X-Gm-Message-State: AOJu0Ywe1M4/Dc8nt63C+a6NbB6WGaJkn/chg+jZahNACnCJ2dW64s1F
	oLid2TytOcOSQT5bCQAeFaZbsyUQWI+Sfmyjf+51XJ/aqQ8JoYaF9QIY
X-Gm-Gg: ASbGncvd/afD1R7AxWbQo8sUsc8jAlRgwcoXVkByYOyD8XW1CcIZCBTmDFC5G9fxqiA
	v22udBtDsyaQH9Hi1hBc6yG7hMnOe0OApQXt1YqCGNNkkQ7Vnh6selKuL9/rH80K7Z67isJeedE
	uyFiaX/vhFIVVGVB5BRJEBbaBHkDWyxknfQGJONM/KMvZKkCaGRKSaZHQZvNl7i0CmV2hAyW5Op
	iNY4t8Cf+o98U36HbenIz+MWwd6txZtVvZFvxeRynMXK58Iwd7x/cE3g289p++sBTMZ7dJapsBk
	YQxqKE4vP5unMaQFJaoAXqkw9YDXCTESQwGDjAeXVQKNTURwhg++PvpNRcJaep88IPwrZ9XSIZX
	MEOfXW8DGywnzpJJaT8Uj11sBY/RwEdQjpznygiXAPNN2AcJW8f4GxSGp6/b+2ZD69IaG7NHMbO
	bgReOXjsuzz1eM+YKNjcbnaeXKG8vbzBaDpxYWm6KvC0kBcPort3po
X-Google-Smtp-Source: AGHT+IHOC4zgG6OF1kjm4g+wN+sLLGwPrLU1lwZ+ztIlqe61AFOMk+PmnLjf3OTwF1E1sL0nyHsaLg==
X-Received: by 2002:a05:600c:5493:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-475e067f43fmr57939265e9.25.1761574684773;
        Mon, 27 Oct 2025 07:18:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dcbe5587sm168380565e9.0.2025.10.27.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:18:04 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:18:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
 jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with
 reverse lookup tables
Message-ID: <20251027141802.61dbfbb2@pumpkin>
In-Reply-To: <aP9voK9lE/MlanGl@wu-Pro-E500-G6-WS720T>
References: <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
	<CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
	<20251005181803.0ba6aee4@pumpkin>
	<aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
	<CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
	<20251007192327.57f00588@pumpkin>
	<aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
	<20251010105138.0356ad75@pumpkin>
	<aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
	<20251014091420.173dfc9c@pumpkin>
	<aP9voK9lE/MlanGl@wu-Pro-E500-G6-WS720T>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_071807_379874_2FA880F5 
X-CRM114-Status: GOOD (  13.38  )
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

On Mon, 27 Oct 2025 21:12:00 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

...
> Hi David,
>=20
> I noticed your suggested approach:
> val_24 =3D t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
> Per the C11 draft, this can lead to undefined behavior.
> "If E1 has a signed type and nonnegative value, and E1 =C3=97 2^E2 is
> representable in the result type, then that is the resulting value;
> otherwise, the behavior is undefined."
> Therefore, left-shifting a negative signed value is undefined behavior.

Don't worry about that, there are all sorts of places in the kernel
where shifts of negative values are technically undefined.

They are undefined because you get different values for 1's compliment
and 'sign overpunch' signed integers.
Even for 2's compliment C doesn't require a 'sign bit replicating'
right shift.
(And I suspect both gcc and clang only support 2's compliment.)

I don't think even clang is stupid enough to silently not emit any
instructions for shifts of negative values.
It is another place where it should be 'implementation defined' rather
than 'undefined' behaviour.

> Perhaps we could change the code as shown below. What do you think?

If you are really worried, change the '<< n' to '* (1 << n)' which
obfuscates the code.
The compiler will convert it straight back to a simple shift.

I bet that if you look hard enough even 'a | b' is undefined if
either is negative.

	David



	David

