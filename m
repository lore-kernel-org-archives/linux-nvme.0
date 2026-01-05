Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C70C79FAF
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jan 2026 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yn1Jc4ICLWk8ULaLrztIgS2WchuirD6GB9gytQ0+C+k=; b=xzTkxbqcvXc2N9a4hUOjo2KEYF
	UfPSgkRSaLDY0CVEiueuJXNJ7sIvP88ZgkH0qmepFrRr/33ytsaEMTCodaAEs6ikrMNzjpL+/tUim
	3x1Y0CdmCYya8SoZsshO4D46i0yM3xCH6/bnfE5rPge7bbB6Fh4dxk0iU3dlbKBSItW43Yr1nKzvx
	+A53YCcZhXr2BsiEXSElGgp0jrB7Kr5hjPueojf0O0vtJFKZFuxwaaMpG6d64FKNPXQlz5t+RKSwt
	RPIJdz4ULh6tTzuv5jHmxxCDH9SjublR4xPHOrPnf5FkgU5HPq8TLlUCsKSvaKbQz1uSwgCAndLmX
	vDjGM13w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcpnO-0000000BwoL-2F5V;
	Mon, 05 Jan 2026 18:59:14 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcpnL-0000000BwnW-3WuT
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jan 2026 18:59:12 +0000
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-5dbddd71c46so78932137.2
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jan 2026 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767639550; x=1768244350; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn1Jc4ICLWk8ULaLrztIgS2WchuirD6GB9gytQ0+C+k=;
        b=VQcNRSj+SCEOLOuJbEdtuWyNmtXb/hZbxDWFdy/Div7llzPPckKD28Ug10hfVrUGz6
         1/dTGO4Fk2CUk6BLnfwctdjIgRTSWpQJZGiGblX4dZ/r2q4nH6esUrCNBoU865W3B3FE
         zOkXwKPmmkwXce8OexrIDKQbr21NNmfBiqPzS1Jp6yuXrQFPWelKW/r+kCM3tlJt9eqZ
         y5cPbeEwuVOoh5s5ufUjCMxqtbAXbc5T2kVtL2Yh8qWrZQ97riK79COgQUllEFe/ZchN
         K+df9xlBl0jfy0TNFAewVXsIL728tm8W8S/5whc61QKYkaizTFXM0L26gsvL6cnWzLqu
         YXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639550; x=1768244350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yn1Jc4ICLWk8ULaLrztIgS2WchuirD6GB9gytQ0+C+k=;
        b=uSPRHky3BamsBAnLczd1tGUgNBandzhSe9fnaOM+4RPjN/SgBg2BHf7s3zOs5deUBV
         eWShEqizL6St/uhKeMpiC+1eqkOXxfhy/tHa6ytA9fuf6Jubcs5bW+LS56RdY7B0GF2V
         92rWrTcWIuSBNO0uAuVc14UrItFkI81C96/g1LEeCUVdaoeleyTfKZSkHDfZ8UyBf8//
         JcN6hm0TZjDs1DMf2r7F8bQp/iWRb4ocm4tqy42xWbpnf8X1vHAvUKvgv8FfCIjtGWh8
         fjVx7/+AezrvwIcVJjHXQGntO/XK/YKTy8UtHy1CTbeJxIp93aQwd0+DoA4SF2fUgGGJ
         CAVA==
X-Forwarded-Encrypted: i=1; AJvYcCWwGTiSNlGU2ng00H8K6neI4Kqyzh1wXR7Mjk9rrrllzevmP+AAkEjKkYX21rj9o59Gkq5ShxvboB7v@lists.infradead.org
X-Gm-Message-State: AOJu0YwlWYmi3liLQm8bbCW09/1tZuOMvH+PRGPbq/TNqwKvbP+uDVYM
	e5j2/RbKUfObqaF/U8xqdyC6o1pCTC7CBMjM9MEkusTkML9vrijGrg4oHdIBBO7zv7vMPU4NwTq
	DHupHCy5B7PeubiXGbM/e6HDwvUQiTDY=
X-Gm-Gg: AY/fxX5RDnGghivTLjIgwd/7jzqqAr2NbaNl+xdxN1ViNKCeEr0u2lR3HH+FKseJlEX
	DxIj6iEYt4zCeN7J/oxO2UGN/OwkMa9la3OhCDkpmzmVaKo4ue2/s74IdIAoqeXYHgiw6MECBLY
	q2lQl+VZta4mESsNncp8uxKt6HgSOE4fBP7RaS7091JZ7P6V9GMVD3+WEgJGVP5bGp7KyegZ6ey
	GehQRer47N0zToskMTG9tKQLvHIhsrXVpdKH66RGqklpzhQjbfKiM5Ou6vyDTkGfDgVqnWXNqHO
	H8Tmmkj+ycsG/7RpDcwb33EbG0K6
X-Google-Smtp-Source: AGHT+IEK6t29nnbM4KSi3RE2dRptIPsBlJI7+TEZUWDWfQLw/G0JUg7s/X6SseZ/NRhydZf5A+iBWFM2iESPtCJyrnk=
X-Received: by 2002:a05:6102:2ac2:b0:5db:cba0:941 with SMTP id
 ada2fe7eead31-5ec744f41e0mr168063137.38.1767639550024; Mon, 05 Jan 2026
 10:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com> <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
In-Reply-To: <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 5 Jan 2026 21:58:58 +0300
X-Gm-Features: AQt7F2rq5lSdRuDrKKO_WX7qlrOIHIyAA4sAGBL3za53jFIAgFNIDCZCA8inI4w
Message-ID: <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_105911_909206_740242C9 
X-CRM114-Status: GOOD (  25.79  )
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

>What good is that to a user?

It will allow him to use the feature which he currently can't use.

I don't understand your point about "arbitrary" failures.

Imagine that a user just sends a 256 KB write with RWF_ATOMIC while
the device has NAWUPF=3D128 KB.

He gets EINVAL even though the write is 2^N and length-aligned. Is it
any different from an 'arbitrary failure' which you describe?

Now imagine that he sends a write but it spans multiple extents in the
FS. And he gets EINVAL once again.

Is it any different from what I propose?

Obviously in all of these cases the app has to make sure that it
satisfies all atomic write requirements before actually using them. I
think it's absolutely fine.

On Fri, Jan 2, 2026 at 8:41=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 30/12/2025 09:01, Vitaliy Filippov wrote:
> > I think that even with the 2^N requirement the user still has to look
> > for boundaries.
> > 1) NVMe disks may have NABO !=3D 0 (atomic boundary offset). In this
> > case 2^N aligned writes won't work at all.
>
> We don't support NABO !=3D 0
>
> > 2) NABSPF is expressed in blocks in the NVMe spec and it's not
> > restricted to 2^N, it can be for example 3 (3*4096 =3D 12 KB). The spec
> > allows it. 2^N breaks this case too.
>
> We could support NABSPF which is not a power-of-2, but we don't today.
>
> If you can find some real HW which has NABSPF which is not a power-of-2,
> then it can be considered.
>
> > And the user also has to look for the maximum atomic write size
> > anyway, he can't just assume all writes are atomic out of the box,
> > regardless of the 2^N requirement.
> > So my idea is that the kernel's task is just to guarantee correctness
> > of atomic writes. It anyway can't provide the user with atomic writes
> > in all cases.
>
> What good is that to a user?
>
> Consider the user wants to atomic write a range of a file which is
> backed by disk blocks which straddle a boundary - in this case, the
> write would fail. What is the user supposed to do then? That API could
> have arbitrary failures, which effectively makes it a useless API.
>
> As I said before, just don't use RWF_ATOMIC if you don't want to deal
> with these restrictions.

