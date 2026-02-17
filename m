Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F8CE6816B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 10:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=; b=znxbDQwYtdDI45ROmY0g5/kGwm
	lPOwYqGsIjEJZ8mevsBm8wGmxN10hyIuG35YHNq0gXj98Yk6XjL0h3PEK7tpLmVyeJCQhSKY3628D
	Nzh5MIN6WEsWYO4GYXOGrsvnS4GnPxHgGeiQ2CTa537AlQnF4/io7cD2LuXaVCsvSU5hIg5eyYqwB
	/bN/bNzq1wnoxx5LQedzv6WIxRtnGluaIykIzaKFW5h3x9cJW3rNXU+nd2d2m9+vH7aDek7G4OqUH
	YIxGB26VSwH3QMM1V2wh9rR8mM4KbJtJaLPNn1EEzHHeLS4fQn+cVU4g4GZQRfPPAejNJH7FADLHg
	86vTCh2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsISa-000000082RJ-2XfH;
	Tue, 17 Feb 2026 10:37:40 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsISV-000000082QQ-2cIO
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 10:37:39 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-387097ae2e3so31770461fa.2
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 02:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771324652; cv=none;
        d=google.com; s=arc-20240605;
        b=Y47OA8sIU3+Or/RRO7ifGYY8xpimVFZS4X4GPscnwqldl9yEr5E5T1qxvqF6RHW2AY
         7MfTDkwV7Nd06neNI2OXa0ZNuipr9Rz+Dbat22spbbnB1FTpG12MYfZlQ0K36AzGS6Sz
         MYMfbLwS6mU8HzGXF9mzCvvRT/MaaURr9SNj1GCdIfmaKtxOhz3NwVaBE0vTFW0Oq7kz
         mLZ8xy0kz1ViJd9rawsfMInByRli1FxA5dFXdMWaVCSUWmGPGfMrxzk54qj8u+5EjZWR
         pn3d63ZTElFf1RH7x0IqzB9o4QJ+VHsARZpMepW90RSFWAESRqFOD9HZGcpsAT+ACLOh
         Qplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        fh=Hpu8RfJ8wdI1OeWDGucw3v7mpMfYgKyDLeCnR0fz+lo=;
        b=PoyJMTEp1BCVoWh29P7S0r8sZAOmt36RKHifq+CgrL/gDhSWKHlPjQkYmxfuNYA2wo
         6VJXph6FvoJ7bIggnby/AH5RPXpi8LfzN8amfYrp4w6ccM/j3pYbr8BKWgcElTJZzcPs
         lR/10iOaZlx4e139Jp1S7XhpoLzItv2yOA27tqMW1hY+zBW7D3Zzt3Nc56sOSvIz28U2
         5IrVqb688w4oIV/81IT3fbLN8GH+pU+IFg0QiaBhSlXn1MgjXwTSru3g9yehsGMAYOsz
         ktxaeMEHYIaBBuccLUP2e3jfD+M/lDYB4XSan3Wedv9HJuseDyHeoG+t14b7gzKFW/rN
         ehgQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771324652; x=1771929452; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=i64VgaW9ai14wgibuFKfFBhOhpEEYkfovyAqdFL39k5DogiYQGI1u7GQ5fS9uetDny
         eXqr/+awTTp8sQE5Bqul8KFWHr1ezSKAI+SU8O/bR0rWyIJc9bHP8KphbfEkziHGSyTe
         aDYkiBVo0abyMTQLiQjmIsUaV0fhj/tu/okR60MW4SLA2vJSm6X+ukOtkc6GjEVzcj/b
         loJI8KKHSGE/gRWHSsPDqRNn9U7NTWIm9/LG3snfE16b4ziVbiMxJYxHH1l98XiWDr6a
         IUTytkigqZ5t7oVP4mlTF6MhOcTyu/c0GGuSy7/oUn/KlE7KMdytrBYvctne5qg4MK5d
         DxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324652; x=1771929452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=S5JJZLzeAX9MjYiYd8DVY5PGbnT+L4PswDFwsUypJj8vuuy987yO4EXAhCpSYomsb5
         ZKTjuEa1hB7EwwdxABES9G6e5r3tabBEKMqdSUa+kxfKRzIDHeu32hV0SUVhB0AVp2X6
         yVUAvfvko9zAUpGmiMz97e6eBy9yCst6XBcgplCnpxzZtz3ZIQvQdqx8s/+bsJnTwrBP
         oLDhEXp8udMLvw+SXXVYnWyM+9mRe+6cl99/ERP/EBMVFxrPgHKlQ5UhonlBXQYOxpaL
         gLEZAuaqxcUZy7y7Uk7qDmNPN50EKWXQ1xobTKbJTlHzeQquURLEQsQXNNp+s+JFVZiw
         VjXw==
X-Forwarded-Encrypted: i=1; AJvYcCVLhoRmZZaeU/i2mjF0TGadGoRHlDgzGs3hhEla3zmw8pGkwktkN2V6vOSsuDvS2+taZVNacCeneH+q@lists.infradead.org
X-Gm-Message-State: AOJu0YwR3SpdpgX7aCiGudRbRU5uUeNsiJyC9pqwhnP07hbilFTp+yak
	zguzYen6+3cyjrbvVRQgcFGE5uQ5IDWrWvyA4nGlN9cIxWCgv1xJZCn6XaOxbl8tmPLf/2YpuUg
	iO2DNcWRakN+1vEkG7UOxoB8itK4QSbdXjO1dC3cf5A==
X-Gm-Gg: AZuq6aKiXDcYoiVQ0yTnShbiyxoXY5np2WmLVcPiRBUHCUhibaBYt64Xhv7dyxt8nGy
	ziDqXa5zl8yk8/3kAOyAk/WdjROi7p+rWuIdB0gGaU9A1dHgxKkW8OUE618cMFKn0WvNN2zqlk7
	nV6eC16wTk40AEWjoMpyZp133h8TKewNVI93tFO69177X/ZqreUuFg1Jxg5TYROlvBkrFS5t9yw
	tV+LSOvbWZGV2bV46xnVkbYvYw00bEMKxAQ+dB5/oYdqWtuCRjxm6RSyBd4I2ktXKdYPjtJk+OY
	LIKvSVhSdw+sCQ01HPSM4KcrQjh5oDrCZIAZ5uq7yYw0TsMRJ7+XqwEOaihk57+5Jj48
X-Received: by 2002:a05:651c:1ca:b0:386:ec21:c87f with SMTP id
 38308e7fff4ca-3881b99cc9cmr30135731fa.42.1771324651832; Tue, 17 Feb 2026
 02:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner> <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner> <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
In-Reply-To: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 17 Feb 2026 11:37:19 +0100
X-Gm-Features: AaiRm52ye33PKO28CcExseV6coNOG-rZ2nBeMP78z80h8Dwp-N455yQLK7UlhmY
Message-ID: <CAJpMwyg-3-Z=ZDC60Vn0s-8Z78VOPKYmvX9s=Nnvcoao4T5zbg@mail.gmail.com>
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_023735_756451_79672ABB 
X-CRM114-Status: GOOD (  15.58  )
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

On Mon, Feb 16, 2026 at 3:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jan 29, 2026 at 05:13:52PM +0100, Christian Brauner wrote:
> > On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > > > (1) Fill out the following Google form to request attendance and
> > > >     suggest any topics for discussion:
> > > >
> > > >           https://forms.gle/hUgiEksr8CA1migCA
> > > >
> > > >     If advance notice is required for visa applications, please poi=
nt
> > > >     that out in your proposal or request to attend, and submit the =
topic
> > > >     as soon as possible.
>
> This is (likely) the final reminder to put in your invitation request!
> The invitation request form closes this Friday, 20th February.

Hello,

What is the announcement date for accepted topics and invitations?

>
> Fever has struck me down so all you get is a bad limerick:
>
> There's a conference called LSFMM,
> Where maintainers debate and condemn,
> They argue till dawn
> What's merged or withdrawn,
> Then next year do it over again!
>
> Don't forget to pester^wask^wremind your respective organizations to
> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
> considering renaming it LSF/MM/BPF/AI.
>
> Thanks!
> Christian
>

