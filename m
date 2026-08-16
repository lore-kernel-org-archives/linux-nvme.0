Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D81C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZPPcb+6L1tSSLsANqwKI7loeM1EwHu96h0gKbDhNEvI=; b=QCGQAtx3LG3DR9Mtx8mWfLBAfz
	FCAaoWFROpR0xWzDV/aWjAy4NB0YjsINIVs69y1IeoLuhfbOkrYr5kZN+EtA17cJv5jyIwLUdjKdR
	jQe7l5xuWcf9JE7NDOjj/oAy9afLomlqCuyvXpJeQHzT/3H88Va6X5NjCSVZD77xy496QWGjsUxkH
	1hBKKg7Z7SGfxEfZ1WHx4YTuIGHBb3WRAxKDswAexS1zsujw9leritez+hhYlAfupa/1qdEqbiKuI
	QyyS7Lve4ufvP5IcjyYJCv3eA9jFywTCv3BzdFOvyddAHPy8laRwvNHRtD7jdChVavOVJ7pH9UyJk
	/cqm+6ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsfU-00000005gLW-1aY9;
	Mon, 17 Aug 2026 08:26:04 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvOJm-00000004K7e-0Aiy
	for linux-nvme@lists.infradead.org;
	Sun, 16 Aug 2026 00:01:39 +0000
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-4ab89cff9c7so623771b6e.2
        for <linux-nvme@lists.infradead.org>; Sat, 15 Aug 2026 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838496; x=1787443296; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPPcb+6L1tSSLsANqwKI7loeM1EwHu96h0gKbDhNEvI=;
        b=w3hdih4nujt4amcbqCe3qHGL8228V743YNB1jDHBSLKV3UdKnb2m4VoKwfzyGhNQwy
         5SWs7qR1FtLJtX4zilJls18IHzM/8Y8Tk+XxDZs6TZ7tY30DuoviVjFo2Qdl+TgCyOrW
         KPE1AZFOxIgguHbH4A0mKyPBojLG+tytLx0YsF2WmaC9aPdnA4MIe/65faBHas8Qgrma
         AZe5agajhgeXSwK/OJRS+kT4YapAPuTC7vLmSjvwrJoKWxdyWk9BYCoKe0yN9GywkR9c
         in8OHl6L6U+YWoQ6yaV8itRhSBQK0vBXKpR4ZX9201mSl5AaURs9PW67xuqMgm+jN0hq
         9TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838496; x=1787443296;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPPcb+6L1tSSLsANqwKI7loeM1EwHu96h0gKbDhNEvI=;
        b=ar8e0zxlw1V5tCvwq7a5XpksDmQAeofqQxm37HGcf+GEHHQ9PkUzo9oGm5JT2tjjxH
         qaqjKkPDotaSj0Wok8+KYnRkzAZkFHz8B9lQ6QgcXmxluLtUcU7mFiHd0IYUq0iKa69G
         XBgmXGIkCmlDN16aB6RoHD7zKxhTOz5rOc8nfifoGxCDqIgKu17R5klJF6qTPn12L5Yl
         ep1DTERSSlH3b3Vykrwj9E2Wa1F/9KE3Q4dox2wkfjeKIlBSThkyn/8ai8PsWbQXmggE
         JWlu+XwAJKiB0PBfhQ8AQRhu5WvwVnVQhvME7fPfKsL45rFRInPDnlaUxr032sR4OmMn
         vXFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrn/Y/2PUphDowAvaqSaYcobJqCbgfJDW/gGji5G91+wNrqCOUVu9NVsH3mO63gZ3lH0IYRaN5IeDUb@lists.infradead.org
X-Gm-Message-State: AOJu0YzG5VC+EtMIOkDkwLni9Io5Ew2exubFLzHQU2W9oz1tzRr/LzDQ
	Fgn8fefTxMxgkv4wAT8JBI3JQ90+jp+x4yVJKCops8PDS7jNzD/bPIDniHd52Rliew0=
X-Gm-Gg: AR+sD12TosAS3DBy1Qul9kCN3aYGFJOJJKWAYoyh0hRz3zpHqQ3f7MPP+JkjS7Yw7U4
	hGBSYi4LTkbsY/RtvGE5Ntq2laIjk3AGKJunbcp02FKWxDYkUoNL9WDQeM6g1Sh97C7lg7BG1ng
	BjQq5ouBEJJZf8v7Th2rRz7boX1ZF1n5H6Q40qvNeryGIiCGGABvbD2zqcXwr+3ToKFGjucjmUy
	sE+RgTSAZQ8xdaUBE3jktHFwEsLP4xT5rxBpyAYY/244cxekTw7l6s0o2FqsKHrHAhDatVTix6w
	BpoS90L4teEkc0iddA9ypZtm/aQe03ITyg5iLlsKpVpA10R9SqpLaJtSYzFIudtMryHunQGFdfu
	t8mRGElurNd3gqi9r5BvxJsS84NTvfAOrbTwXxty1tXdL1UxU+UzzrgC9se7ij/hAydHHU6LSJ3
	P0fczwhxjzyTIy8AWX1mj4hZucjFmhqm8DwT23t55TkWOR/guVtsUvOHF7dXbZTfcvM8uhlGsY6
	FT8klSUI/vUQcLf4PPTdmGdfJROltPLUu5nafZXcQ==
X-Received: by 2002:a05:6808:23d4:b0:4a4:ddde:5207 with SMTP id 5614622812f47-4b24198f27dmr12801839b6e.8.1786838496365;
        Sat, 15 Aug 2026 17:01:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, 
 Phil Cayton <phil.cayton@intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>, 
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
Subject: Re: (subset) [PATCH v5 00/16] Add dmabuf read/write via io_uring
Message-Id: <178683847578.1984298.10059277109543676478.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_170138_092563_D691430E 
X-CRM114-Status: GOOD (  12.44  )
X-Mailman-Approved-At: Mon, 17 Aug 2026 01:26:02 -0700
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


On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1]
> (from where I borrowed a good number of changes). Later it was brough
> back up to life by Tushar and Vishal.
> 
> [...]

Applied, thanks!

[05/16] block: move bvec init into __bio_clone
        commit: e228404b05c8293f6a1286856e49ba3e55da1933
[06/16] block: introduce bio_iov_iter_set()
        commit: 8b8755e00847da1027fe6624277e43d289e2300e

Best regards,
-- 
Jens Axboe




