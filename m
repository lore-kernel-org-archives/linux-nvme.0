Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84181606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y0r0JCS7;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=AKz/k3Da
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ypr9cxPiv3deakk+O4p4y3+YtXRhrt20LKLToNhf8rs=; b=y0r0JCS7O4MVq0
	+0XFekmt8wLyTHvyP8zaqXCLOj1BeJqaH2IKburM7+2YtLI9GwtNAK2X8cg590iSlphNCmw8Gzr6D
	fCIb7RQmVLFBV0FWrQdMVX3ah7gl6HmurIXC2Iamas8O7VzwK+IbPNnlrDFRG+foBzS/ReqN2nogP
	mICYKncvqKcJjnJw7wAZ6ZIntBbRD4SyzMZXYVxJw+OqUEPYhyTtwItESIukGs5x/bSpCwpz+++92
	wcajGTsdodrLSSUUI7AAk7RfIW/3NuAy/A7DcV/UJyw59OLUI3txyEHr5/IFMqC+QUjcxRUIkECl+
	XWpM++Baf19iX4w0tRsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRdOp-0000000BBL2-2eXY;
	Thu, 12 Nov 2026 22:36:07 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRdOj-0000000BBK6-26WF
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 22:36:06 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-53bb57f1310so4394341cf.2
        for <linux-nvme@lists.infradead.org>; Thu, 12 Nov 2026 14:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794522960; cv=none;
        d=google.com; s=arc-20260327;
        b=iwYtje0/De9ZEYv8KrEJkhwh3O3JJjLas1xLF7JRvXU3xK0OJd1X5oKRHuavvCIbI2
         Ly5++W5U29zM26FiFRCp7FACg4vkDNqh/1LJcGU1tmYllswP/8F4yq8v0QGvVFlEjNEa
         S8HZKp4H+5mrisd0FP5OrNdEIfzrOllGV11IoYCrmpXp59R1Z9gf9wyMF4YooM7R2wKF
         kMOFqe4sPLfHHLN4UllTQOzLN82ar8TRoWy5Ld01dWX9LKHumyzFoBZQAaD+PvJEFYxr
         bORLorSvxD8lSD76cjqzLUoeaMU28iHwRKt5eyPmVIN6JkNZDHne4MD80lm4lOXWodTO
         Afpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ypr9cxPiv3deakk+O4p4y3+YtXRhrt20LKLToNhf8rs=;
        fh=GuftQox9xlzs4jkbdQykT9wY8epqQzjsA4ObOU4OqC0=;
        b=bsiPgbcIwpLHHkfJ4BLddNOFAacXMlxnoSjhlW8+IGd5zomPglfRiz67wLNZeaPkPI
         R9ffR1TefvlXlgi25sa3FPwZc0RIXTAEHAetBxNfKhuTuY4yvf+UURP9TYiShIufF4hj
         qupd/LqvJ0anucLNIMP+Onngr/omABmEfURyGXOhxK2F+MdpDfWVk863isbZWKCsKHZO
         Qr/nTLfQYko47iyTKg7HDFwWHA8qCJzfduVbqtPTJsZzDmXUQT1xuvB6OOWAYyBGxpyJ
         vcKD6CDS5VPMjdrrDQOCEl0o68S1owhm6+3GI3uKG5IDJBt/qNisCeA0+Q8mt3HsgGky
         Bj6A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794522960; x=1795127760; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ypr9cxPiv3deakk+O4p4y3+YtXRhrt20LKLToNhf8rs=;
        b=AKz/k3DaxWxoin561sv7fGLm27LmkNpLaflFZdWgb+D9Ayfc2Sq1xjzGfjq1evxw/9
         FA//eGpc1TcTbb8PBC8Dl/5i2uZZME8IthTBItJro/rU68zqbXKfPaPmRs/IZ3hvXPcJ
         1ulcnUSqr1lpyvdRjcHChcyXJtXpHeMfXQSY8DT7WM57F94KSBshisWzFesvEpDzAwvC
         88l+56q6rQ9WLu3m7I5yh3ZtATxBvTyO1kavqv868iXk+KYOkP2OzZiqY77nzqDJ//Zh
         DttJO1fChkIX7+m3tIHTzV+5Ax9v8NMc+2hN7jWp7UUtegdix5hGaSB/iX4ibpqajgCb
         yQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522960; x=1795127760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypr9cxPiv3deakk+O4p4y3+YtXRhrt20LKLToNhf8rs=;
        b=0Lu65sfby+rgndz6iZcmky3vRmcXOnVLhrqfA5Dy3p3+fqVpNOHmr91DOMrcGCW2kl
         VusL8JPPoLhrhtOHihLCpWMbKyVWFmWPnEDMBK1COUbiDL56luIb/0QRQxFT3IgDf544
         IsARP+Vg0XHgvCJNEIr//YQbsPrM9hcZqaTK78c+xagR5nmQiLNu2t/+sQeb/RI9+6ms
         Fa+8nV3l9BUc4VKT751CNUIp+SG/tkcyjIJSVQy4cyGRPMbwgOVyCkRar2rUPIh0xakD
         q1r5Zj/6S9k2B3plx1/Ujb7LyutaDOzyuKMdk2KSJPi+XsIZodr7TliauKAqbRHCejvu
         aAWA==
X-Gm-Message-State: APuU4Z9tiEpUZbzq5v0REOmFZswjV/sORzSUSPWkTfgdebKd3ZnqYzvZ
	UKcygJubkkAxwY7douBkPmpcEdp/ge2KBxgTEzUkuDzKpcMxAAjKdtQus9Hu9ccVoTaw9mhBiXz
	Tpdu5SWskA7nFye5pHNEnPGNPTQe6OLjxFUOvRVPn1v3N4fi4FkUcJ+mqNw==
X-Gm-Gg: AYBFou3HAH8cLZh41nZRvMtjdDcrAxiqTyCY2OvlZ1EYYDfFCtNm/oq0xpxzDbMuM2F
	K+qsoos+sUoi+RzscL+ysYrfzKetcrYZthC0gkWsHnTINvcNAA8mtAkict1PD4hUztyy1KpVpBv
	Obpp+ZH6PBxcnYduLQ0ZxdSZD57eoxrGKgEGwbFR7kD8OZ49g8ttrRXBOuQl9j+xPbqPbe6c8xw
	rfOuQ0FENvKmc9I/qXHCNjQTTV7qxY1/1iWBdKqfSnU1KaD4IOcNy4omrZMrA/9pTaG4nwVYP7D
	s3mlOGjb2tEeeGMkTDzqVXGp2oxus+B0g5bt74r9bSVKSulUX60Jd6HvEzFAdch1dO3QdXj+pyf
	o6fD8S9VJ4uqXdI0ssFd0IpKk0kkHthprmU7M
X-Received: by 2002:a05:622a:5984:b0:536:5004:6347 with SMTP id
 d75a77b69052e-55ac717261dmr14420931cf.25.1794522959491; Thu, 12 Nov 2026
 14:35:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-9505880f2c33f0134ef20c39@redhat.com>
In-Reply-To: <20261112-9505880f2c33f0134ef20c39@redhat.com>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Thu, 12 Nov 2026 14:35:23 -0800
X-Gm-Features: AclHuK-z3arf23Ak967LY929iJToASjqdutkcGx83PDYmNodXXSb1FxSCOCatJ8
Message-ID: <CAMof9cWw6jDht3++cYcybQohq=Nf6DzY4ZL1m_E0b95r9CRxMQ@mail.gmail.com>
Subject: Re: nvme-tls failing with (61b0ed3be81b6) nvme-tcp: parallelize I/O
 queue allocation and startup
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_143601_710225_E40FDA57 
X-CRM114-Status: GOOD (  10.22  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 10:46=E2=80=AFAM Chris Leech <cleech@redhat.com> wr=
ote:
>
> Hello,
>
> I was testing some patchs and ran into trouble with nvme-tls that I
> bisected back to this change (61b0ed3be81b6 nvme-tcp: parallelize I/O
> queue allocation and startup).
>
> I haven't determined what exactly is happening yet, but blktests
> nvme/062 and nvme/063 both fail with this applied and pass again if I
> revert it.

Hi Chris,
Can you check if the failures you saw are due to an older version of
ktls-utils/tlshd being used?
Ref: https://lore.kernel.org/linux-nvme/CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2Bm=
N20Bh3btpLum7THg@mail.gmail.com/.

If the tests fail with ktls-utils 1.5.0 as well, please share further
details about the blktest failure logs and kernel logs so I can also
take a look.

