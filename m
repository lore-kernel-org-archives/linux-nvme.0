Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA339CFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWx41fjiYDvxJBDcxhBox+FSm0FMogENCux+016VrYw=; b=GBknRdifyAq1X51ZxCedJFCkg/
	U4p40c+LsijHXEDgFhDqsoQu4UjskHX7yAAoqA+Ul/CR2hTcEpAldUXadCjsVM1PF78fTKJQqUcWs
	08V/EdXJAQJD8UTtPs1120mqFYxVt+7LLxo8vNj1M7wXT9EWWL5Gm0QGpT379+jcUtd+yvTWvRBmg
	Qbo1q5mgWrHebIWa6OUuJFMkWJWlsUE1koAPRzNarasEifQOiC0p4G0EOzac01AWNiS1BRr4g2X9L
	L8a41QrqhyxTd7t8kXkQ9hmt/Ge4hKFKr9Vu0qC/2gnG6fAfnKv6Oct5/PrI6w3wGs6VZZhuipC9Y
	x7PdWDVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOW4y-0000000G5D4-15gP;
	Thu, 27 Nov 2025 07:06:12 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOW4t-0000000G5Cc-1vhB
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 07:06:10 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8804ca2a730so8340496d6.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Nov 2025 23:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764227165; x=1764831965; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWx41fjiYDvxJBDcxhBox+FSm0FMogENCux+016VrYw=;
        b=RJh6+bzU4Ym9a80cvgQbAKVwrOQRtTsm7KrncidddSwv4GykcoEWAX+faAmNHRvChr
         t4LNO2nV6VexT7fnaAtqFFVbz7uTHOCRyuuCRTN03SUntST5Nqtjn3RHIA4WKa6tW8ld
         cGWA7Bhzos5Omy2qy2P5ZMTAJj9QJ4qgIbbjb4Kk0xwG1mildiFCrW3KBQYJBW+P896S
         QWgN9Pl+x2ChYhwbwxoa7m5H1t/KDDy2u5SipgYhiY45bOKDk3IT5DZUjInWfQ2062Ot
         PTMWko/2zP+5prmCYkd7K7bvozNzV9NHv2PZPJphPbDoLw7XDc6WtC/cUncjZprScZd6
         Rhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764227165; x=1764831965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWx41fjiYDvxJBDcxhBox+FSm0FMogENCux+016VrYw=;
        b=IDOON6zsMmJKAAlkjxh7bErtpM73Rr8Arorx6Szwc1aBLKVmyBAj/xSF0yeSaa4u31
         VpRYWOZICLScVj97Ksn5Jmt/pu//1YK7dQ+jmDkcGtnLpBBhr3XsvpE8Os+PkxqGGOec
         iSo2wSrm+1syIPhw/xqSBMteDINtI5fbJHF/c/M4lS4AgfbIKcBmfdJUKNM7EJ+jl9v+
         v5GHj7thV5OOIHPcoU84izeiU1OjBsWKNfaCSSWuFHCLjp6hZWAlt/RxkdpLSYxvwgef
         0JyFL2FDe7LLiEp6+jtZDY0AoilL0s8jZzEMtxpj3Ilm5NxNHeFekvN/UVWNSAXgbyzs
         JWlw==
X-Forwarded-Encrypted: i=1; AJvYcCWaY6tXaM8ZsqPD3EJUghBsN9AIjsI1X99RORfnqRGTC1p8qrfsShv/AGUW3BNhiqtCtNWMFAjxMYsI@lists.infradead.org
X-Gm-Message-State: AOJu0YyJurFkTNsnWQs9JSrfOY/QmajpOCJdRYPclyWecfI4hWGxv6Ke
	GsjD4+CZKesw9o6kaQVvXfLQ/061V9beycoGmmZJzCRItfW9ddyWLQILNjdqKH9zFy5N9dp6J5Q
	KHPi4UCTMCdoJNObQbn00hUkzgE+EFiU=
X-Gm-Gg: ASbGncugsPhFnP3AMq/sUHptun69qgIAfmTcVxU/5ApM88NoZOk9QfeEVNTImgIrMOp
	jTPGB2V7PS5vfdaIpHbFk4PoSJ36o4sM4gA5EOgOcrOGfZQwSW0bLCpZBbJz78mUtKduD6MiqFF
	Xv5XU9vCkhJEfBwmLz9BSjZrSRs8aflTnVOM2AAaAuFw8WPwbaNw5JVObEWt78cCa3imKs9JrbB
	Sqn7sQqD83H8ucCIvQ8jQ/errmcMJxe9UGVjAfe/4OWN68LaTb7hnlL4PP5IoDGNj3Te0yK751l
	CBLyLA==
X-Google-Smtp-Source: AGHT+IHzM3mMsS8tgLfoKGHhBY7XCjpG2AMXOtnZwN9X/T1/YsQGgtSmkxVAO42GtcErC0+dnzj4kMOng2ojzVjt/kM=
X-Received: by 2002:ac8:5ac4:0:b0:4ed:aa7b:e1a6 with SMTP id
 d75a77b69052e-4ee58b06ceemr313796031cf.81.1764227165447; Wed, 26 Nov 2025
 23:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org> <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org>
In-Reply-To: <aSP5svsQfFe8x8Fb@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Thu, 27 Nov 2025 15:05:29 +0800
X-Gm-Features: AWmQ_bk_Q7JOTiSFa20fvKvOS6m3SqnDBEgFzZo8VoXEPgg04GUPVW1qbNBOsHU
Message-ID: <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_230607_510306_719504CD 
X-CRM114-Status: GOOD (  22.06  )
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

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=B8=80 14:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 22, 2025 at 02:38:59PM +0800, Stephen Zhang wrote:
> > =3D=3D=3D=3D=3D=3Dcode analysis=3D=3D=3D=3D=3D=3D
> > In kernel version 4.19, XFS handles extent I/O using the ioend structur=
e,
>
> Linux 4.19 is more than four years old, and both the block I/O code
> and the XFS/iomap code changed a lot since then.
>
> > changes the logic. Since there are still many code paths that use
> > bio_chain, I am including these cleanups with the fix. This provides a =
reason
> > to CC all related communities. That way, developers who are monitoring
> > this can help identify similar problems if someone asks for help in the=
 future,
> > if that is the right analysis and fix.
>
> As many pointed out something in the analysis doesn't end up.  How do
> you even managed to call bio_chain_endio as almost no one should be
> calling it.  Are you using bcache?  Are the others callers in the
> obsolete kernel you are using?  Are they calling it without calling
> bio_endio first (which the bcache case does, and which is buggy).
>

No, they are not using bcache.
This problem is now believed to be related to the following commit:
-------------
commit 9f9bc034b84958523689347ee2bdd9c660008e5e
Author: Brian Foster <bfoster@redhat.com>
Date:   Fri Feb 1 09:14:22 2019 -0800

xfs: update fork seq counter on data fork changes

diff --git a/fs/xfs/libxfs/xfs_iext_tree.c b/fs/xfs/libxfs/xfs_iext_tree.c
index 771dd072015d..bc690f2409fa 100644
--- a/fs/xfs/libxfs/xfs_iext_tree.c
+++ b/fs/xfs/libxfs/xfs_iext_tree.c
@@ -614,16 +614,15 @@ xfs_iext_realloc_root(
 }

 static inline void xfs_iext_inc_seq(struct xfs_ifork *ifp, int state)
 {
-       if (state & BMAP_COWFORK)
-               WRITE_ONCE(ifp->if_seq, READ_ONCE(ifp->if_seq) + 1);
+       WRITE_ONCE(ifp->if_seq, READ_ONCE(ifp->if_seq) + 1);
 }
----------
Link: https://lore.kernel.org/linux-xfs/20190201143256.43232-3-bfoster@redh=
at.com/
---------
Without this commit, a race condition can occur between the EOF trim
worker, sequential buffer writes, and writeback. This race causes writeback
to use a stale iomap, which leads to I/O being sent to sectors that have
already been trimmed.

If there are no further objections or other insights regarding this issue,
I will proceed with creating a v2 of this series.

Thanks,
shida

