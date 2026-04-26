Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB12FF885D
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Apr 2026 23:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w0mhqtviz5LarODI5feTp0v+64DC+vjC/m2+2BhGJ2c=; b=LOC10DwWqQTFHD4E4x+NnESi8+
	VzJAYHPLNc/u0Xp3VmZ8Nd4M85YX+NjZW1SdVw7QfNd+9KA6x4T7llouC4I35xy9Sq0eaWqoiFiOQ
	vZ6EYxOi61VkghDhIkLGcIHfp/RBCQEkhRL6xoouznxeA7B2zmbjFWEZClXhTnItZ3E/W3mpJCntW
	09EaFIlcgfdaM0Jz1JWw75FEYn8mzMEmZ3srkHuRGZ+pzr8OJY2as+p8VDjz78h5+P7EUwYUzmBj4
	1RQkHhavdUYFmy7mcdQbxah2RezATV/5VxPR1bB+cf6/F9FQCAcz02hYgGzUDChsA3rFiL5rfubdx
	yPNb7IUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH8oY-0000000Fvhu-366g;
	Sun, 26 Apr 2026 23:23:02 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH8oW-0000000FvgD-1Yr4
	for linux-nvme@lists.infradead.org;
	Sun, 26 Apr 2026 23:23:01 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso1218175466b.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 Apr 2026 16:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777245778; cv=none;
        d=google.com; s=arc-20240605;
        b=T4BM7gOp8yJSirRK6WTeoPRJ80FOeRnQP+yZi5k0NSOnAFNUB0XuEY4VDNTT9EleXR
         nfpOWNFQkOSjCXPg27y0KIzQYXaRHH+dOGKgq3NfXptbWSOUbA8HMhjfvHxS5GQYSlJO
         BrWwMP6SnXHblpfIpcJDKD676SIw0CA1cN4MawUslTiN77Yqr8gfRYot4QG7ZGw+uSt0
         m8WaezRYtWfKy3K/MJVceZQ9I4FL3KvuLebuzKtCcSeBFiTYDC5Yq7RKiHLMVgw7X/i1
         qqNfF+xqgS3rSPN8sXkehXV+DHsJYMkdfqohCgg2DGYv9nwoxkOvjE5GHmGQC4juLIQ3
         8n9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w0mhqtviz5LarODI5feTp0v+64DC+vjC/m2+2BhGJ2c=;
        fh=7+3j1jwk7yLdNE7DHc/CakR675CtE6ELKLrhXv33gGY=;
        b=Xt/LyrN0UhwBDhWCIhnXvKvePlMHAk8AhZr9CsHWW5DD4IE2wcH3bVhkFiqPw13Ewh
         YHIfCFeMAFzLE5EKmXvbKMpUHWtyal0DnNgp89g6iGZRZM0bZVYzJuzE1OoKyZx+2AVn
         lHqZ+uXMEeHisBUiSihO6tyRBtQKIY5detYrtKxlB1A+SYmuuQ71e4LzS5EHVnjy1fcn
         KT5t4LntcpOrJn8EQCSGeA16KKAI7CDQhN+hig/q9q93KDheR2ViM9TQ8Y8p8Q+UUXmm
         9n6anIawpzc9amgz3uFtBqvUTm8BNWCXuueEWIhyKEs0sWskV4vYM4iE+WV81OLbZ/Kx
         d4Tw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777245778; x=1777850578; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0mhqtviz5LarODI5feTp0v+64DC+vjC/m2+2BhGJ2c=;
        b=CyBAVzYjB0/hwjOHg/UlWJXlCRyiGW/7htR2AJy+teDf6Xf7RdBFj31cRjR5ual8fJ
         qOwu0sdPR2VylrN9mtBnGNKX3WpTnwl1NQJZQXu9qGTrxa4KOg4VFDBRxGtJ7FLkYaxl
         Uj3WOfI7prdOmOQsJIxfLEKc9Jib/ggclJwl8kiy4JYG5QdzpZ3qhGCipOXQs4mhWfnI
         gFK8rRmIerXmwllHGJohkN1Bg21oVpbTYwXOERqzQ7MmUrW9nqZSqwRwKZv8doYUdT4E
         1BMys4kNowOfnfaauvC+cEz9+Aj8AwYdgKhm00tQS1ZQe8UOmGADy7L/ULw0HAM753Gh
         LX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777245778; x=1777850578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w0mhqtviz5LarODI5feTp0v+64DC+vjC/m2+2BhGJ2c=;
        b=NUgaJxyW4uBZgN5xLpIyq2ZwyeNyfq5xhizwGAWUIaSz3jKObJVPhW+UH0vo4aPIYb
         jJKwiR8Aml9q5WGk12vRaarNQ05zXAcC8RGWw4dF63hb8b1lB5unYlo896JuiHdgrr+g
         NshMKxDVW08k2hicPMjr9epIhiHvA8PLQFfP6DgnG6CjDd07wZAbgS7kqtkBZ4Ak6ddJ
         JXxl+wqN2YUviryhlmvnA/uNGHrUhp46E1ZHARYAjSJVdbqw6PjkEKvk6gNgFFiNkhq1
         +MjBFn1AMKUQZHgz5ZLcPTypvEHM7ViYGPkEeReyox+M336NYELZ7CDMtKGjbNSd4pFc
         0B1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/UOZ38wEybb+mN7ueoaV4IwLiVrH7kvzL6Xk3VCEZoMQQI2tnnV9GoLPrOPxJtRH3PKByI9qCE7rpb@lists.infradead.org
X-Gm-Message-State: AOJu0YxlJozWiUd2OqbwTFrtyaUgYY7oIDEBYpEm+ydHXGiSqHAD7x0v
	2NGH9BWdLWoCEOmWboS/HzMFW++ObDlNSQFZhxXJuimRpHXU0SKGvI5i6WPWrI0ywmgP79Rmksj
	e3tupnQ0F84/PGspL2+CMghOYchfkodU=
X-Gm-Gg: AeBDievsx3sdx4mqeTRaxFWgkdvDssLssSi1H288l1w2iYqxCaqmFom7GR/njP+dSBD
	JXwxHnEIop2w+b1pXvQAovjguzbBpzFE8hLKUT8x3yzECnSPUU1DGBtB3GdvauZlOire4fYWfrf
	CU+2uWWW9+19rp0DCni4jN5g61FIb1sbBX36ap102S8v0MVS9JgqQACJVDs8mXb1RnzAvajZrqG
	YYDGLpDnqNHlVQ+0Tk9TZyEPTB7UJ02LQnzIixnJLhcfT8S35YTG2FoPSh1iT5VThWCEotGNFlL
	GSc48L8qxeI9HUjrl7PODUsLtsLp1w0L3p+x1IrSXv7nkf+g
X-Received: by 2002:a17:907:847:b0:b9c:a70c:d30b with SMTP id
 a640c23a62f3a-ba418e85407mr2034197666b.19.1777245777452; Sun, 26 Apr 2026
 16:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260415230824.2790058-1-alistair.francis@wdc.com>
 <20260416051627.GC14802@lst.de> <CAKmqyKON1MoOU-MQNK8EEVwVWmSJZ9OmxH2M_mmYTadmcbVyTw@mail.gmail.com>
 <9bb1d1bd-2acc-453d-970e-762e173d230f@grimberg.me>
In-Reply-To: <9bb1d1bd-2acc-453d-970e-762e173d230f@grimberg.me>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2026 09:22:29 +1000
X-Gm-Features: AVHnY4LUyXcVGDe7mbNurV8yCVBtq3d2Uu7pg2jmbuUqDsfsjEjrU85BHknBGf4
Message-ID: <CAKmqyKMk5CeXBDCfrXasZs4h9QcgBX9iTrJWXJOC5C5eFz6vBw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-auth: Include SC_C in RVAL controller hash
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260426_162300_428005_F3108881 
X-CRM114-Status: GOOD (  20.02  )
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

On Sat, Apr 25, 2026 at 8:58=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 16/04/2026 8:25, Alistair Francis wrote:
> > On Thu, Apr 16, 2026 at 3:16=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> >> On Thu, Apr 16, 2026 at 09:08:24AM +1000, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what i=
s
> >>> included in the Response Value (RVAL) hash and SC_C should be include=
d.
> >>> Currently we are hardcoding 0 instead of using the correct SC_C value=
.
> >>>
> >>> Update the host and target code to use the SC_C when calculating the
> >>> RVAL instead of using 0.
> >> This looks correct.  But I guess this breaks existing implementations
> >> in the wild now?
> > It would break an implementation that is using non zero sc_c and
> > updates one of the Linux target or Linux host but not the other.
> >
> > Note that similar changes have been made recently to "HostHost" and
> > didn't seem to break everything
> >
> > 7e091add9c43 nvme-auth: update sc_c in host response
> > 159de7a825ae nvmet-auth: update sc_c in target host hash calculation
>
> Still doesn't mean that it does not break folks.

The current implementation breaks all cases of secure concat with a
spec compliant implementation though, which does seem worse.

>
> I don't see how we get around not breaking other than introducing some
> compat mode under some sysctl (yukk).

Ewww...

>
> Perhaps secure-concatenation is new enough that the breakage surface
> is very small.

I suspect the user base right now is small to zero, especially
considering that this won't work with any spec compliant
implementation and no one else has noticed.

Alistair

