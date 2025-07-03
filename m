Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6893AC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 09:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QIWiG9dqFQFHdKj4M2wbUUNwQxdB0m9vMthTEJMZrmc=; b=Sk8Z3JonagKj2v+fIwzlip773Y
	zM6lTmE4dfkanFM/VjKuUlP0Jq1WR1sXBnfWR1vgOVC0MsfvebaFAhrtJVe5vYZ0IQGqSoIF0v8UK
	pxkFzeu49xFuI/uTXap+p6IvxZxPn5W+2zC51KsYlSZEK60EUval3G6wAvA3zmrfaFm+wNGRsUSCI
	DbPfV49N9NU58vt59pQJcwcAzFTfmaZVdbTEJCHD9qc8sHdw0It5geB++tsgr0uVM/Ntk99VKYYXd
	hQl2N0x9vkyhNqA+KH0jsg0tPIKBWTZy3SrOOhdVXeCQQxOhtaIttmM30g2e1NylT1uj5/ASQUqgo
	jIp1rnQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGO8-0000000Aqkn-04FB;
	Thu, 03 Jul 2025 09:37:52 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGGY-0000000ApPv-0Zgn
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 09:30:03 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso1061400166b.0
        for <linux-nvme@lists.infradead.org>; Thu, 03 Jul 2025 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1751535000; x=1752139800; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIWiG9dqFQFHdKj4M2wbUUNwQxdB0m9vMthTEJMZrmc=;
        b=oaZuso4u42u8AXDwnQW0TVBLNqZtYbMcVxz88CA7Tna2mEcN+LNSmw7+PA7b9hMMzt
         GU8yV2VJVdpNDzGNbn1OdgSZJ1q5/OwJCbiB05AKqa6Z3wdcdj0yilxCtjSGS7Ga9T+K
         MQubFziUnYINMXfvgUCfWZ28nNruo0u5ucMKdw5CJE2D8ohyK4qu0btSRXrceLFsVaOx
         u4K0PAAJJolG7qu9I8Cd9oVqgFecSxsRPI1hvjMYzJq2RNp+ecJlxAmzqmvxzmu8dIvd
         BI5XCT1mP2dhlvaP7H7srT6ihyBVvwLJU9xQfT/TXwVIKO1Leyw7CbPy/si3YgvLP+W5
         IYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751535000; x=1752139800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIWiG9dqFQFHdKj4M2wbUUNwQxdB0m9vMthTEJMZrmc=;
        b=S7aB7oVZCD3CajEP11A4WG9qHsXL3jGGFIIt0gSXCs7sdFJaak7vfMOQyChnvqkyUF
         SpJ6SJ3gHi1lZ6Sg/se4K4UzcPcc2jGQNwMQ2qWUun0oq3lOZ+OiVNAknFbnH6W5DRDv
         7LCAQSkOfhI3SHMq0e5I8ABxebB3D8KBwgssTuis2OBkEOv8Ie49thE/zGZ2pegAzTmX
         AMqzpkQzx9CWBWiccN0RA7MBrsNtjMWpcQ/0iKu+1bGYepcMAktmFVcJRKfe4PiZGb2q
         +ax0040c127ncHRHqhz6dUkbR0gMymIWTV8OSQfx+eQrJG+VkwM2MVWCagFjn/DCPNac
         zjlw==
X-Forwarded-Encrypted: i=1; AJvYcCXUc541aVyKrBdL5uHsvcwjISWf22GHlF6+BCeQmez6+hG6apK5Cea5J8xE5bHk1EFIFka3uNZGliZX@lists.infradead.org
X-Gm-Message-State: AOJu0YxCMqnnEATFgjM7b4J5zHBAA5mlHJxYBh9dT4jGSK2YumsjpCq3
	niMpVk3/+sJV4dYS6VN8AXWXNaObhs77/fT4q31a5fb/9h8VhgWci+oyFtepqynlzQI=
X-Gm-Gg: ASbGncuhv25yBN+TUZljAwEveyRZiU0MRdzUhj5E3xt/vxhDuVna39aUMkEXBqwHl8x
	QY/R38CSPNAaOeAeVyQpv337Io/TPYYeAi+SQw3XLT5w/IkxpF+dTPwOafqIXw1yJN1B6mXvcuj
	9HrBrA78RghC/JtoxS3YQWMvb93zHYkLZ7oonFL6SZImAxZJTfR019aU3MftUZrpAYT1FtCXpm4
	lbegXdusR0pwA1zT/hOc1oUSHyDrzVSIwoZsseRH5hBvIYqWJRd5I/LM39M2QuGuD72WiLTkqRd
	q9VRtJpc51KXQLFBzbsPGv+hOWZTYzaXe9wuGtb1hA2r52+rPTle4UIv0xd5kOJbnmd72SxPIAu
	khDuWr88MU70kLS2gZnpfVJcNVtI=
X-Google-Smtp-Source: AGHT+IF6ggB54PB58WsdUlPptBXf+B1DdD84f3tx0QpZNb0Gubfb/YJFRtUnI7TT/jSbgpB2+0kCpA==
X-Received: by 2002:a17:907:a088:b0:adb:4143:4c8 with SMTP id a640c23a62f3a-ae3d83c0c05mr192246666b.8.1751534999498;
        Thu, 03 Jul 2025 02:29:59 -0700 (PDT)
Received: from somecomputer (85-127-104-84.dsl.dynamic.surfer.at. [85.127.104.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a021sm1256411366b.54.2025.07.03.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:29:59 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Damien Le Moal <dlemoal@kernel.org>, upstream@sigma-star.at
Cc: Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kch@nvidia.com, sagi@grimberg.me, hch@lst.de,
 upstream+nvme@sigma-star.at, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvmet: Make blksize_shift configurable
Date: Thu, 03 Jul 2025 11:29:58 +0200
Message-ID: <2880421.FSEd18e0ET@nailgun>
In-Reply-To: <20250703085451.GA4459@lst.de>
References: <20250630191341.1263000-1-richard@nod.at>
 <132c1bdf-e100-4e3a-883f-27f9e9b78020@kernel.org>
 <20250703085451.GA4459@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_023002_461212_4D8D550F 
X-CRM114-Status: GOOD (  25.54  )
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

On Donnerstag, 3. Juli 2025 10:54 Christoph Hellwig wrote:
> On Tue, Jul 01, 2025 at 09:34:00AM +0900, Damien Le Moal wrote:
> > Even if internally you use the block size bit shift, I think it would b=
e better
> > if the user facing interface is the block size as that is much easier to
> > manipulate without having to remember the exponent for powers of 2 valu=
es :)
>=20
> Yeah, block sizes are probably a nice user interface indeed.

Ok!

>=20
> > 		pr_err("Configured blksize needs to be at least %u for device %s\n",
> > 			bdev_logical_block_size(ns->bdev),
> > 			ns->device_path);
> > 		return -EINVAL;
> > 	}
> >=20
> > Also, if the backend is an HDD, do we want to allow the user to configu=
re a
> > block size that is less than the *physical* block size ? Performance wi=
ll
> > suffer on regular HDDs and writes may fail with SMR HDDs.
>=20
> I don't think we should babysit the user like that, just like we allow
> creating file systems with block size smaller than the physical block
> size.

I'm fine with either way.

>=20
> > > +			if (!vfs_getattr(&ns->file->f_path, &st, STATX_DIOALIGN, 0) &&
> > > +			    (st.result_mask & STATX_DIOALIGN) &&
> > > +			    (1 << ns->blksize_shift) < st.dio_offset_align)
> > > +				return -EINVAL;
> > > +
> > > +			if (sb_bdev && (1 << ns->blksize_shift < bdev_logical_block_size(=
sb_bdev)))
> > > +				return -EINVAL;
> >=20
> > I am confused... This is going to check both... But if you got STATX_DI=
OALIGN
> > and it is OK, you do not need (and probably should not) do the second i=
f, no ?
> >=20
> > Also, the second condition of the second if is essentially the same che=
ck as
> > for the block dev case. So maybe reuse that by creating a small helper =
function ?
>=20
> This code is copy and pasted from loop, so it's originally my fault.
> It just missed the comment that explains why it is there:
>=20
> 	/*
>          * In a perfect world this wouldn't be needed, but as of Linux 6.=
13 only
>          * a handful of file systems support the STATX_DIOALIGN flag.
>          */

Well, my code is the other way around. I checks the logical block size of a=
 device
even if STATX_DIOALIGN succeeded, which is a bit too paranoid I guess.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y



