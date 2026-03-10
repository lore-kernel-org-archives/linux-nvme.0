Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3105DFD4F09
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NTw2rheN2uYbUPHUkZqD8MBHondkUFtRIAazt0YhrxM=; b=qcRYP8WMSzGAi8iKAFJ6mWVLnF
	ew5R8Nex7LIW0cnAOOcJbUbN0aSinl+P6uNNwuWUCERSDSrQ8nsiaLgBT2gLnyneNqjDlxcSyvEvy
	/BI6kk6jSUxzDRZL5EnRJYfIEwEmK5ZfsR42lBQToQg76kCeFDNqix3nz1cgbdQ8DLmPPZdnv8NKK
	V1iUH5GHxp5DreJhMb4kHT6szsEaRXGuoEy7XKpuELskZBSMQKoPtx8RWiWysRupPXoBBQHzQQW8u
	WvNelEp2VT0FfJQlwYSyQQImPHttB6ZtyhcU1E857pojcwnordoE8jQ/xeCpo+qTcBWQzoyg8VLB4
	yzeCfyAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w00fQ-00000009xJw-1wV9;
	Tue, 10 Mar 2026 17:14:48 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w00fM-00000009xJ6-485y
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 17:14:47 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-660a4aa2aa9so864a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 10:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773162882; cv=none;
        d=google.com; s=arc-20240605;
        b=Xo9rSmm8I6cdR3osM9WbjsvoFWW3AGHgBavH+f5vddttZqFn5UbDkrmdO4c4krP1jV
         VcR52IOMhROvcsScZcJ0N1PlVL/p9r1T0vuvlVX95Fs8THSFQ7Zo+Kj+ldY+sujkwMA6
         AdK1DZjf4VQHKpeoXheEIxnxopbHKtLLbtytETudmCYBk2pZyoF7TOp7POZSiiclZcSy
         8w8s4h/TOnLJpsM6RYxERloM52ymOJpk6/owcWRRGQAcdE8I7mFUajjq5YfHxjg4y1eU
         iDaF/ZBRuTvgrtnhf2ICKfzsPwAR+LE08kFDzw7dBxRl04tkKVcXI0slbCAODRyLQoKX
         01UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NTw2rheN2uYbUPHUkZqD8MBHondkUFtRIAazt0YhrxM=;
        fh=RbmHvLy9iPgGW/AFZbwaGYcV2Tr91mNv1nRZ/NvW6fo=;
        b=gW43FtN/EXSdEQm3rrG2yQF4afsYvaqssk6IyfLH76c8xU8cVwC6ze791EjmVy/Wmf
         yKf7lGWjRji+18Nl1rRA7/0MEcUdDauw1cduL3isUx4ZH6zLUIsuS4sXKyRDr/FeSGbE
         Li+4kRkUNea7Wix31wUJK9T+gRNAhmmGDxvE3Oo1sbumQRR8ePFxUEFfrAYAxYr5Ieh9
         EYAgL7QuXw3Ee85kyQY5zBZvHssHtVy7hKdnzURwxe0859yZnHaMm6nQYx5CgRHwP4gy
         t1N44EFg5ULVPEgazoO/C3m3q4gvfCgi4NA5Gg712U2iGxNmEk35aOh1jH/4EpyyDM5T
         dEIw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773162882; x=1773767682; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTw2rheN2uYbUPHUkZqD8MBHondkUFtRIAazt0YhrxM=;
        b=OChc+0YtMBe3j8dCOQVG8iAaRyTuUUWHsq/4tL/pQrR/8JQds6ehDgSr/+zC8SOPJ1
         rniwUxCc6T5BDsKDRrMYkGjQ8tifbfEavYqz0Ou04Szm2q5XBAIoPz1vZvYI8fhCr45s
         qrckY8hgd9K5M+yes3ChgghuzW6zhh6q71IhTo7S9iO1BKoJU45Wvde0asPyg8i/JTS/
         aBaHstVNKnIRnwCFwUqyB2BDCLMmkWp/beSrvL8i12kXSGEFmPfy4SCAOaYHPSpgiVDq
         QJVL6sJK8r1XVEn1gBUvfgw7GE7f86tUV3Cm2mpu+uXG98XcDcNlyzZrJFOnFn4bSUUj
         lzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162882; x=1773767682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTw2rheN2uYbUPHUkZqD8MBHondkUFtRIAazt0YhrxM=;
        b=HQAUV2pNdA3KKJQYISym+4smamXcM5jOa1+Mu0GyesFQxZjoKjQ7+MDkY8ShRm6IhR
         jjiYpmoZyiX2ZlGgF/izOBTuDpiM29goMYlawWy3omdV+wVeMJvFm/nD/sTPWMvZMfP4
         TZ5RWXOe5HLDvtXgQQzFwzwUtXRVd6N9ltcOnzkzeRCiCYEuOoPDziwggsDlu3/mrX9+
         TZ6ivKiGdEBZHQZVrlzmiIlcyesewhpyxksTd/j/bPQ6GxFxJgx6xGKzCAUEJisi3t5i
         UDxQnbILWT21sbziri7+txpeSUUENbYPk1saTmR8ch3y/kZrXHaxt1PSrKqpzgfgQ4mE
         PG3w==
X-Forwarded-Encrypted: i=1; AJvYcCW7LhWZcAuLcRflsLXGglgb/e6lKxjrSyHYRUK9bMbePE19+BsW7uMnbcVfYPK2Xb4b378fsK6UjWMX@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9fPq9nz8FoWGHc9vnb4x8aGLAaGAJi/Z2gOG22nZFWCTNIGMo
	b9dHHf8fdPc87Z6lSXTWlfT5sLNZiBXlWgdGyEF2+5+2eZ9OQha+sDiAANB4L3heehvRMwzPIeF
	exYmA7CHFS24ZePidCr+PeIBliu9cTVIxk3f5DsY5
X-Gm-Gg: ATEYQzyYvO5J7C90bHCTLlrO4TsASgvph4oha6txBv7gCNPNDX2HwaADPCl1wT/ZLWi
	Il3haAGoxk7vV40mpd7eYMc0/3RvcQSDaNUEHI6zbPkWZ3YJGZ1capvaRrltRlGYXzyNWmS7hEp
	AHNsuJ1YUaY2Hg/fqhHfl3zj8xxStvuYJvkb8+yirUuWn/NtCGMz7TUbDTO53HnbOsJBn42kpj8
	lLnV46OcvX3qO4QCLfTMMsR559sLWIJMq00Udnuu5g5esqQTcjlikpIlURFlOcJObexBXdsjlxh
	6iCmz3oRXQfOMiQ4hV2K5h15nNl9paZEMUQs9g==
X-Received: by 2002:aa7:c344:0:b0:662:a565:cb41 with SMTP id
 4fb4d7f45d1cf-66309fa78d7mr1129a12.6.1773162881536; Tue, 10 Mar 2026 10:14:41
 -0700 (PDT)
MIME-Version: 1.0
References: <20260305202735.1773922-1-robertpang@google.com> <20260306142434.GB16612@lst.de>
In-Reply-To: <20260306142434.GB16612@lst.de>
From: Robert Pang <robertpang@google.com>
Date: Tue, 10 Mar 2026 10:14:29 -0700
X-Gm-Features: AaiRm534WCvGA7mGEECKdMXt0npK7xL1dk_KSl3P795VgxwAB3F3o01_TlRpRyQ
Message-ID: <CAJhEC06h=QwxoAkdQ7eyZmW1dJMdBZiiXF3TNHR9L+bhpYCPNQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: honor NVME_QUIRK_DEALLOCATE_ZEROES for unmap Write Zeroes
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Zhang Yi <yi.zhang@huaweicloud.com>, bmarzins@redhat.com, brauner@kernel.org, 
	chaitanyak@nvidia.com, chengzhihao1@huawei.com, djwong@kernel.org, 
	john.g.garry@oracle.com, martin.petersen@oracle.com, 
	shinichiro.kawasaki@wdc.com, tytso@mit.edu, yangerkun@huawei.com, 
	yi.zhang@huawei.com, yukuai3@huawei.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_101445_039166_752CDFF9 
X-CRM114-Status: GOOD (  14.82  )
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

Hi Christoph

On Fri, Mar 6, 2026 at 6:24=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Thu, Mar 05, 2026 at 12:27:32PM -0800, Robert Pang wrote:
> > However, certain devices already use the NVME_QUIRK_DEALLOCATE_ZEROES q=
uirk to
> > indicate that they deterministically return zeroes after a deallocate/d=
iscard
>
> Those certain devices are completely obsolete first generation Intel
> SSDs.
>
> > Update nvme_update_disk_info() to allow the presence of the DEALLOCATE_=
ZEROES
> > quirk (combined with DSM support) to set max_hw_wzeroes_unmap_sectors t=
o enable
>
> No. This was a hack that got sneaked in in the first days of the nvme
> driver and never should have been there.  It most certainly should not
> be extended to any new functionality.
>

Thank you for your review and for providing the historical context
regarding this quirk. Given these insights, we can discard this patch
proposal.

Best regards
Robert Pang

