Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69B7C54FD2
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 02:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Hemjtez+zdPR/YPlavgIDaG5jGokFqZe9syknkvrEg=; b=MwCjw2avjOX+PIblZ94fibsitV
	CGYj+fRSzygCbuBSAw2g99LTjzXM/8DPA1jKSLO+gQIvXseR05qLOYt5kiUcg1KwXJ8ag5jf+IecU
	dkaERImByQxHzwZhleBalWMoeik8tpUzXDLXQwexD/jgA9kCKxguySmpjJNCYvGbR5JFElmxgKU7j
	7jWs4B1s6YWXFJ+wdDgaeUEDomcqa7t3FJan2pPYjQUNMWAeluGFG77yAoexx7n4+7f9Z9Dn/IpKl
	m+kK8PS9udqBgkE67qblJqKh/rUNMnTboO52fiuugvwzGeiHAjWAxbKgPe3+6T8wTgCZYnsaQtAyF
	V6r5szpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtd9g-0000000FmNJ-2gsV;
	Sat, 21 Feb 2026 02:55:40 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtd9e-0000000FmMy-2QAy
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 02:55:40 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-b8f8324d2eeso45428166b.2
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 18:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771642536; cv=none;
        d=google.com; s=arc-20240605;
        b=LKuiS9/1ne6UjPHxSHdcQo6YxrD5u1zzboM0XFsGFvWubQ4xAPYaf65hDAE2KnCVY5
         Upy+s29akAFB9DUkeZriBUnFg/JGESZUaAYrzO55zeLIv0fSgcvHhi9bnonD0IU8RdSE
         wpqzbeXN1FGhIPqsej8kVbtqg8LFmDRrMgPRjamil0UsHOEICeQxQE+w3hp3YmD4g2ZY
         TdNC6FkaYG0OkP/FWLkKmvKgj/FeqTpS1AiJXQH1huDK+oKJM4go7M82kKYqv5JFmeTn
         sCabOGkuu5YZPk1I/9GDhjJY+tsH/PMfq+W7dwpcHdcL492a/pPw145cOqviLkeIs8tP
         rr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Hemjtez+zdPR/YPlavgIDaG5jGokFqZe9syknkvrEg=;
        fh=hzydWcsEgpD4dIlCNVD9pYoMEW8DmJKQSVWoq7801Zk=;
        b=dsv11sihYM6PVbEZNmu86tLxR1LjoaP9Yvw0QNmFYDNeMQPVAGPW01MsmYU80IWq3U
         uHD/HCvt/C35uZ8esmNc6h5UZ5tFeW3ylZiCHY/JMUNUdGvBor7MhabH1/oxLcz2Ticd
         nY/lwSdBjSQvC1sdvfKtClkQMr5DxIVir1iIRcaNlCP4vTh7YoYOMvOAlbyHPbjT3ftE
         XPmZC8wyboQoOamPIj/bFJEd3FIo2jZrCgawjj08JN0a1Ldtl2aO6eH9uy/0gdDaVR0p
         e6fFIMc9VAKLD6QdhkNqt2qR0R8aeSYMO8YBy2ZHvqKwh7+a3HdCfIXsvrYXUvFWsHKT
         pWVQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771642536; x=1772247336; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Hemjtez+zdPR/YPlavgIDaG5jGokFqZe9syknkvrEg=;
        b=Yzj/Sf1wbU+ATOHqjvCbtzAMHEQtvbHAjF+ououmXhuEXJ8SNWqVCJ5uJz6q69P8/F
         aYzdVFp1SSvExeCLG/d5D5p8Et44bFZIgQuCPtAH0JjYQhLzssEz9mxwKd4Jqm33dHKH
         tJ1Ld1EP4XP08hdmmFUtebpgW8QwCCs4mFR9KLQFigb5I9AwlSbK0/1G4IUwsjIgpD39
         eIRTWtLZ28kBY0m6D1WfBvC5o3OlTdrmOlVPSeYJTP1A7sg/9PmuJ4PUhwj5u9l7XHIQ
         u3uw3wlAnYIx6oySecjxSUB9wS6XhHToKy+Tc3BpYxf48VtomdsDseSqL4I8MI/vlh//
         k2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771642536; x=1772247336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Hemjtez+zdPR/YPlavgIDaG5jGokFqZe9syknkvrEg=;
        b=X+ErlKkE1xRThtAPHjRHTv7FPkkTURpZJU+bmcQ0kAbyU33T1YSYKlSEpS8u7bgVbN
         LQ/ulzCdIngqHuE13ycZt7qV5Os4n09o/BVy8zDZ5+VnhidiIhG0ZfXvIgebt3ovPAh2
         TpMn+Hay/HcTRyAdlh4JQivoc726BDOyuFREdh+whvChgTjIRd8Y9NHaRGN0d5PZIsnG
         DqBMUPmWDhUtCXvMiaD6t777qqTV4vRja1jSnpfXe0l5j4hnxjaj78J/YGjSU8R50p+3
         uGnmWjPhwy2XyDgdFDpj/SogLB4+6lDsIGT3Z4jUXWtRd76P6ElMXGvxv59kYtkYXJHZ
         QsHA==
X-Forwarded-Encrypted: i=1; AJvYcCXcISHPHbn3LJ8Okqrfs47bakXctF62Xr8eGFLikIbWAiuQstRFdDwdOntcIgrogTi8NdWSCcopBmcg@lists.infradead.org
X-Gm-Message-State: AOJu0YzsFKvwt7qPgifKwXPMHhI9JacbSj3jSlZs8S/C8JCbNhKduae3
	MZ3pUjoTJgqvcscVE+tKcE2c3mlS3/sjrfJvhyZMojAjXqOP1/mJRhcD/YN2zeQkdIcbZqsFwRP
	RH17aAatDNh474aSw4zuya5FU7ria4c3KFmiuXmOt+3LW+SXIktg/L3I=
X-Gm-Gg: AZuq6aIJF9gdDiQPc4iyNm2chkGv4bshvXNMb1UdNk1tcZD/KrqdwSJ5GRGLiHDqlVk
	bfWTFO+WGQLscL/qV9u7fxlOyQ3AvcgI2wCsqIS5qFC3z7HX9oqiAz6TO6/SniK3jKELWOl+5UD
	/HBFd5r5oIVkJVo93O95+vBcIYtEijI2zxDfsg9m5BnbFGJVxwhh6948CiUnkcCTwSRJxAaKtSO
	6CDriu/RktF3sTRGOuUs6tzno/BfszML00RkPpIF3Q8c4jtvqlGZJKUZpgTy2CanDoWfZC1L4vF
	ityUKeEE
X-Received: by 2002:a17:907:720e:b0:b8a:f2d7:9942 with SMTP id
 a640c23a62f3a-b9081af2e40mr46536666b.3.1771642536456; Fri, 20 Feb 2026
 18:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20260220032809.758089-1-csander@purestorage.com>
 <20260220032809.758089-2-csander@purestorage.com> <20260220160639.GB15071@lst.de>
In-Reply-To: <20260220160639.GB15071@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Feb 2026 18:55:25 -0800
X-Gm-Features: AaiRm500rsCMQWLYK2HZp0NF1ckVCSt5EPLYt7xNYIUbDbR-yiZuMSNZSI7KGps
Message-ID: <CADUfDZq5xVsWyJuwi2=aWMqjqQDMzScp+sYXkp7YEq-pKz4EtA@mail.gmail.com>
Subject: Re: [PATCH 1/6] nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_185538_677471_7F69D042 
X-CRM114-Status: GOOD (  12.81  )
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

On Fri, Feb 20, 2026 at 8:06=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Feb 19, 2026 at 08:28:04PM -0700, Caleb Sander Mateos wrote:
> > A subsequent change will use the NPDGL and NPDAL fields of the NVM
> > Command Set Specific Identify Namespace structure, so add them (and the
> > handful of intervening fields) to struct nvme_id_ns_nvm.
>
> Looks good.  Btw, as the kernel now has a the global scope static_assert,
> can you add that too any on the wire format struct you touch to ensure
> our modifications aren't changing the sizses?

Looks like static_assert() was added 3 years before struct nvme_id_ns_nvm :=
)
Definitely agree it's good to assert on these struct sizes.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Assuming you meant "Reviewed-by". Let me know if you meant something else.

Thanks,
Caleb

