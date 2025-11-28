Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2367BD116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=++QMIe2Gzi7z7FeXSAmSiuqg8P1uQ1lVTlMI6i3m06g=; b=VnTHwJ3SgzEbtUCheanqYIafrQ
	Zx/WVZFLmhrREApfneY/LaFmefrnjI2X3eAjnrgy3kM7XVqn2nfnfckH9lirE5xE8b+ZVsOxqDSIj
	GMxEdcb9aNmUW+wxaZFarfYkXevjEwN8fwGKuR471o1ARVbMi9+MSBU/4UrPaVLm7iBMpjA8L1cpS
	VgIXGk6pgMrMjb2OIkYjBK5Yf7D1EgWqwp7tjNHQQuxjB4PrJgS5XkFeLo+C8jxfJYVZGiMV6upFS
	NlxnqLTHiMYsC5UTUk6JxGLea54S+a8JQq9PHtHR5hYnxf6ekaOy/bXPEX1HW22FKAeUMO9I8mCXl
	S5v6nkwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtzt-00000000BGA-2vrP;
	Fri, 28 Nov 2025 08:38:33 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtzr-00000000BFi-2UDH
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:38:32 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4ed9c19248bso13962001cf.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764319110; x=1764923910; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++QMIe2Gzi7z7FeXSAmSiuqg8P1uQ1lVTlMI6i3m06g=;
        b=jxGttYCiEXQKOCWHbymcgQaLcRS4HKJzV17D5XWhLYX8TfkMTRmLdOkF1Y+gb5gYoU
         /CXbCbwNVk35m31iy8TTSJpD0K0uLDObeDePqvlK+egt5yX6q8BlVZKzxcaWaCHIQxJ5
         EhY2gZoZbfcIBqNDBd/egNGHlFWPiZ38cti0TgNvXRT0vEzoFiDOG2JZBBFF18ASVOX+
         qoenmno3M9TG9Oqe2H0e5byLFAGj0+I8RtkRaKzXvD05e1K2qUg9E9OeCNR4F3wnlMok
         njbkoRe0+bwq5y3ZUPIwBNIjEgKbGMv4yoP5RUB2xJcNtXMhhAJtN7s7eFBe9hfxwwW6
         2fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764319110; x=1764923910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++QMIe2Gzi7z7FeXSAmSiuqg8P1uQ1lVTlMI6i3m06g=;
        b=FHefpHOOP6uxdevbCnKxnzdASlqbD1XO0Gtv0y1Eeec4kMFMLxfXp2yYCh320wBqRd
         cYnZCbzYpTrtz5si0wNjPCjyUhC25PMF55lpQPiWJq1LEF/a94bnd/yLbpATdj0qx4rw
         IOa95YkHnub4lqGIbW87gx1x4O/+jLYOdAI8WKZ/rC0sooFWruLtjR5EIOJ5rPVmNUBq
         ttFxsf5if5FOWzuXA9YeI2nFyzMUZPazPBk0WRkc/PhyXYdLtKzfoROf9lmjZmZg3MgC
         UCt91JhV62IQdKC8bl89qL1FmEs+LesUTH8zYCTWmqUiHPB49WdvuMsTvMX1NuY72Fz3
         kbhg==
X-Forwarded-Encrypted: i=1; AJvYcCVxaTf/kO0UdRY+PCKXbUCLLjy/swksyolB7Vfz6jdUhVjvdXhnn1wtNSjlL5pL20ejTfEnfx1ur2m/@lists.infradead.org
X-Gm-Message-State: AOJu0YyJeQ7G8PfuXZhUCu0quzVK7D6T3U8jRgs1U2aWu8SniqInGIXX
	/+17C2Kh6dGnIEySrVyRLsZ+zLW8FZoz+q81yPk3wU3W2Oxfis1U7Q7W5OHXgHWtXgWalihNLYy
	8pOyI2p5o+m7UZH9dD8G0yTctraIYW88=
X-Gm-Gg: ASbGnctzRAy+0ra7i3gA/XetyhKETckj7kkei6whARmRh1Gvtrc6NgYc98FHvno2bh7
	NyMWMR684cKyN9NABXHvfZe+SYT7c1kGM05QcnNfgU0im9tjB6imG0NRlVDwkcqWSMAgCK1IK5C
	W277WgxJcEnePBwioIf4PF8B5Injj9qZHKGWNYku2GwChTvoHzPYIXJDd+5eLtgXEeGW+WtBf9H
	RREZOhL/Egy5+etNa7u9joiVbsjrQ0opTc1gP6BjGst6713yWljkGS0RiHybLDY/ytVeR4=
X-Google-Smtp-Source: AGHT+IEfh/pR5dVEp+MyGlS6Z0E5USpuJd+WqXIzQcqzstZI05ioUW/B3ey2i9/MpvyCwVsDk2BTTIWfhdBYNOpApmc=
X-Received: by 2002:ac8:5a4d:0:b0:4e7:1eb9:605d with SMTP id
 d75a77b69052e-4ee5883f99cmr321417371cf.11.1764319110284; Fri, 28 Nov 2025
 00:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 16:37:54 +0800
X-Gm-Features: AWmQ_bkmQmYK3DJQjInSuzOGjciJ8sGZNWSCY3EbybUAu4bZJ47LIxlxmcK_q9w
Message-ID: <CANubcdUgYpxBqPrsOnFpGJK8S9DM46DT6hriu4kDckPMVzc-Fw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Fix bio chain related issues
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003831_637140_481C2CA1 
X-CRM114-Status: GOOD (  13.22  )
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

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:32=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Hi all,
>
> While investigating another problem [mentioned in v1], we identified
> some buggy code in the bio chain handling logic. This series addresses
> those issues and performs related code cleanup.
>
> Patches 1-4 fix incorrect usage of bio_chain_endio().
> Patches 5-12 clean up repetitive code patterns in bio chain handling.
>
> v2:
> - Added fix for bcache.
> - Added BUG_ON() in bio_chain_endio().
> - Enhanced commit messages for each patch
>
> v1:
> https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.c=
n/
>
>
> Shida Zhang (12):
>   block: fix incorrect logic in bio_chain_endio
>   block: prevent race condition on bi_status in __bio_chain_endio
>   md: bcache: fix improper use of bi_end_io
>   block: prohibit calls to bio_chain_endio
>   block: export bio_chain_and_submit
>   gfs2: Replace the repetitive bio chaining code patterns
>   xfs: Replace the repetitive bio chaining code patterns
>   block: Replace the repetitive bio chaining code patterns
>   fs/ntfs3: Replace the repetitive bio chaining code patterns
>   zram: Replace the repetitive bio chaining code patterns
>   nvdimm: Replace the repetitive bio chaining code patterns
>   nvmet: use bio_chain_and_submit to simplify bio chaining
>
>  block/bio.c                       | 15 ++++++++++++---
>  drivers/block/zram/zram_drv.c     |  3 +--
>  drivers/md/bcache/request.c       |  6 +++---
>  drivers/nvdimm/nd_virtio.c        |  3 +--
>  drivers/nvme/target/io-cmd-bdev.c |  3 +--
>  fs/gfs2/lops.c                    |  3 +--
>  fs/ntfs3/fsntfs.c                 | 12 ++----------
>  fs/squashfs/block.c               |  3 +--
>  fs/xfs/xfs_bio_io.c               |  3 +--
>  fs/xfs/xfs_buf.c                  |  3 +--
>  fs/xfs/xfs_log.c                  |  3 +--
>  11 files changed, 25 insertions(+), 32 deletions(-)
>
> --
> 2.34.1
>

Apologies, I missed the 'h' in the email address when CC'ing
hsiangkao@linux.alibaba.com.

Thanks,
Shida

