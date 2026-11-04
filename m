Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1C60716A1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A9OlGT/3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MSqLKSuc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=otW91gbXc1YAQNlvjTbYBKLpt7tQ412lK+YFy/nR2CI=; b=A9OlGT/3GUdpwx
	trOoE5yjzHg94RnMJoKe4fZKERBZIuDVMeHKJt04uZ0XOuqv06k0CxDceX5gtWU3EgimH6XdteP9M
	+92Entb24Y220cemAczLQhLnn009vK7AAR40+unp9aoiYIIUYwk6Q3uIdgZynXWlFR1DIvaLdpYKO
	vXVZlNMcmhSUEks0Nm95qlExmMXm70MfxJ59HM9E/EfgQsslIptcu8XDtHXSR8cYzpKdRt5XTilYv
	8VRJFnUscnIrRsEZXt/oYz4j2h8h8tr40DWZ2339rGXbQA3wOrUoDoB8tYKrHnn7b2wyN9ZVMCF+H
	Fz81Ia5y6fEhgfA8H/yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfF7-00000006Kur-3AA9;
	Wed, 04 Nov 2026 17:57:49 +0000
Received: from mail-vs2-x08.google.com ([2a00:1450:4864:3a::8])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfF1-00000006Ktf-1BCt
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 17:57:45 +0000
Received: by mail-vs2-x08.google.com with SMTP id ada2fe7eead31-7c03d219375so1191721137.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 09:57:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793815062; cv=none;
        d=google.com; s=arc-20260327;
        b=EqH9NoF8ExNSmeHTUOvkQ4lKtjYkDVTpFdllXMw0Iu4O3cfd+zu0uBac1r3zDMZFu5
         BuqAqAFLdH9uyLTnY2C4MYKV0bCwVCy9K74cJ2gTgmmxC2/bSlJT9YYSzeID6Ml9ny1c
         xlbF+RIAFd3RmAGB6TeZZa88lsjCV86JZedWmOiJL8k4Z1AnJyjBPdw8Y8XxLK6RcvtE
         PwAQ1tL/bKzXsBBUgjygEgh1ZQttEhB60oysL8tvuHDWacjxAgQINXFuMFjdX2Y8x0OZ
         sK/k9qZtDfaq2FDmKJ4Cg53taJeMi5RwAFByZUlfU/QIrZoRe8qk9NWXG13nevKDggrX
         nPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=otW91gbXc1YAQNlvjTbYBKLpt7tQ412lK+YFy/nR2CI=;
        fh=L1wzsr+KLAMFSY0UwNMOaPxigL2+jMIG/0Nx2JztDv4=;
        b=pqLasEN2bFnqnmDx4E3fOrG3wCRLtjN6DEBviHgDevHuhFp0Qc0D7TlWOdJsC/fwhM
         vegTnQX5wKB6J1j7pvdukN6bHF5wJSYkXsRaQuiVgD5/EKjIW+aXVqSge44We/tvWoFD
         j5iuYPENeO7vRHmzXIeATjBnb4wMLhzP8WZFOGirnFACTuUqwjJM1gWvwET1l0a0rxOs
         3777NH1i7MIN9mywU+/wknqvGu3WR9XmAFEN7k30eYtEyJG4rz71janxzjJkREZsIkpx
         0DuSZgrQap/0YwStFNgnDr6QIxuYppczKLiHuOaKg6dYettRMpipJ1EcdxP8yuYZF5Ff
         RNUA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815062; x=1794419862; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=otW91gbXc1YAQNlvjTbYBKLpt7tQ412lK+YFy/nR2CI=;
        b=MSqLKSucBdgs5KXH+wum1+2pcblXS3Mcl5AVWeH+ZnllTPKzhzDUVoznu65AK5IaUs
         SIgeUBPqTk1WInlfVe5CxYlHCnyEEKSWVK10A4sLLMcgzfzyknzxiDMe0oDP2BJyxwIs
         +PNkWHeokfAyfvo8kUvAgoyiSo8elPQLalP7NwvBEcIyN3psH7kp7Vjk7a30sU0VJmJJ
         eU670p7gW97/sAHhY+0swj7G0teEGgu+yIQ8Yn+8qOtRI34//3CYcD2atOCQHo6/FyIi
         zzbY1oxX1N6RFX0cd7ocnR4z5/nfgfjDMrDl/mfrFpfKL8euWyvmqJoupuz319YG5X6b
         To9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815062; x=1794419862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otW91gbXc1YAQNlvjTbYBKLpt7tQ412lK+YFy/nR2CI=;
        b=raler7xTsYJMBnMzhrCBapFm6Mzo9Cx6jeuFsv+3ZxzxDZlCj4ZNH0sh7ZBkz/ya65
         +QoLjRcpJNbuGsL2fsJyMUTpV1TNiIAzP9mBmmxjSVK1ZZ3HDPotQSuyv7Xk1mgarBTr
         rQWrqr/sbCeQvWIAo8XznCuMVv2KWwOhJDrVWySVWDlcAgPHYAJpNGBWDzdf8B9EdJrj
         ahNLCQAQ+EgW29Xt1g0F9gPvjt4/gEn8faljEEJsvA6izq3MM2gTDFDEQ2tfZoTxAnI7
         vMMAD8DQaRXq0SuFxwP4TXU5QduxTDkWdSrsziNdP8Va8EBuwm39edNb1VnlzPaemKvv
         wz3A==
X-Forwarded-Encrypted: i=1; AKwUvBwJGLD6yZ3bu5vQzppsSs7u/GR1eFGI+5ZLSBN+zqW8du127SUhIZDTb6hsj+OuLjKp5fYgkYC6M3gR@lists.infradead.org
X-Gm-Message-State: APuU4Z/wg6hWeKj33/3yJ6kadWt1Av04f0ExWyfuaN0v4zahD4DDC8WH
	WCAAfBqdgnP9DqslvIY/2jh1xDWbldRVz4hVSJV40BeaAXaUAlJYw39PBbfO745ieeP+3ebEl6L
	6rpd2R5+Y8ktxSnlFllrOq2plqI0XamE=
X-Gm-Gg: AYBFou2QfWkrGd6QQiZKMzzFTrWWwgfDYQR3twSeE811lk32RX8zx2BDMk9qg9rIa+S
	/kh2PVb7wkBt2nYeu8G7V0Gx+hrFPbxiz6KkdQNERsYQez5zTTEDZSdGPlYpRjXuK28y7lHDJqF
	CLokfJCp1FdtZHQ6Fzzz0G0RW2lKJhfOPcgETSo5wmRxq5mNp8N7ftXkq0JIszxsvzkRpuAy777
	NqYk3quRoldogOCb8fFEMJyY+ahdYmZCjTcP/mfWE5Rt4qB/C1yFr+aqTrPwzBe23qTtDm442+/
	fpDHNLjuX1LasksZyLdnXkHl6tIw5fM16XgBP2ZgARBckc1cF2t58FuxtV7kPJI7VnBJTXtxHWT
	dUajSjMLtpqZeMDEVImnSnntZRo4SzIZi/IXg0OAJQ08/qTO3P0QJ63+c0KGigmBK4Z2bxqNSId
	4ZZEF+GRh59qdHMyi9v/CDb0wPz8U=
X-Received: by 2002:a05:6102:374c:b0:7a6:85d6:84c3 with SMTP id
 ada2fe7eead31-7d072270e87mr7248597137.3.1793815061671; Wed, 04 Nov 2026
 09:57:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <WnzOhxjlW7w5jwpSIQmUzrvduOStpoX2h3FS@robsoncassiano.software>
 <20261103075845.GB3882@lst.de> <b0824cb9-e678-4bb3-934d-a1743b164ca8@roeck-us.net>
 <20261104090111.GA30750@lst.de> <3f48f63e-c25b-4361-9ac7-f25cb5082e2c@roeck-us.net>
In-Reply-To: <3f48f63e-c25b-4361-9ac7-f25cb5082e2c@roeck-us.net>
From: Robson Cassiano <robson.cassiano777@gmail.com>
Date: Wed, 4 Nov 2026 14:57:30 -0300
X-Gm-Features: AclHuK8D77soGc8eurdVd3k7xx9vsXPjC7p6i5jgDB3ZlIKHDyFw7fQ8cmt0yAc
Message-ID: <CACh1udi5h49ir-dDmPOP=usu4SJegsxa-Us6yV5BeVatj=gj+Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for WD SN740
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christoph Hellwig <hch@lst.de>, Robson Cassiano <linux@robsoncassiano.software>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alexey.Bogoslavsky@sandisk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_095743_910136_E66B8D89 
X-CRM114-Status: GOOD (  27.96  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

You are completely correct. I have now tried setting up the temperature
limits manually on the WD SN740 drive, and the NVMe accepted them without
errors.

The quirk is indeed not needed, so please drop/retract this patch request.

Thanks,
Robson


On Wed, Nov 4, 2026 at 11:11=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 11/4/26 01:01, Christoph Hellwig wrote:
> > On Tue, Nov 03, 2026 at 05:31:29AM -0800, Guenter Roeck wrote:
> >>>> Mark the controller with NVME_QUIRK_NO_SECONDARY_TEMP_THRESH so only
> >>>> the sensor inputs are exposed.
> >>>
> >>> Given that this is an older device I suspect we're not going to
> >>> see firmware fixes for it.  But given that we had quite a few devices
> >>> with issues like this, I wonder why nvme-hwmon can't detect these
> >>> obviously fake values instead and we could drop the quirk?
> >>>
> >>
> >> Question is if the quirk is really needed. Personally I doubt it.
> >> Normally the thresholds are simply not set. I see that with the NVMEs
> >> on my system (Samsung SSD 990 PRO) as well. If I set min and max
> >> values, they are stored and subsequently displayed correctly.
> >> That means, no, the hwmon driver can _not_ detect if those values
> >> are fake because it can not distinguish "not set" from "not really
> >> supported".
> >>
> >> I have not seen the patch, but I strongly suspect that it fixes
> >> a non-issue, unless it can be shown that writing the values has no
> >> effect.
> >
> > So should we drop NVME_QUIRK_NO_SECONDARY_TEMP_THRESH entirely?
> >
>
> No. I checked the commit history. Commit bd375feeaf340 ("nvme-pci: add
> quirk for missing secondary temperature thresholds"), which added
> the quirk, stated that attempts to set the limits on Kingston NVMEs
> failed. That seems to be real.
>
> Commit 340f4fc5508c2 added the quirk for Wodposit WPBSNM8-256GTP.
> That also seems to be real since it reports an actual failure
> when trying to write the limit.
>
> This patch is different. It does not claim a failure when trying
> to write the limit, or adverse effects when doing it (which might
> be covered by NVME_QUIRK_NO_TEMP_THRESH_CHANGE). It just complains
> about unset limits. I do not know if the submitter actually tried
> to set the limits.
>
> Thanks,
> Guenter
>
>


--=20
Live long and prosper =F0=9F=96=96
Robson Cassiano
Senior Software Engineer, Simple Software
+55 19 9 8384 6616
global.robsoncassiano.software/
robson.cassiano@pm.me

