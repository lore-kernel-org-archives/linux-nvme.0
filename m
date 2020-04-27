Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A0EC4CECD
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 18:03:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5801D20656
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 18:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EN6jFC8B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Iv7lN4SY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5801D20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KSkGMssPQROdmAjySa+hb73eJVHLewAylEuLhRX/xqg=; b=EN6jFC8B5zfQbzxdshY0Up4if
	LsRdsJxC8rOgENRUq6b2uSWx5Xk6Iak/OTHDoSTGzmkX+wN4xI+rW+SapO/43TxMLxvYhwiV1Q+/I
	hf3hcGft7c93wn4X8QSQTVRBV7ribEXxMNd7BwJfZ7BhhzUHXid7RZ8R99hWlKvL4Xpt0n4jiQf+M
	pwAlg1ge2nDkl8Xsc7obfQ5UShdPNzUVL5VFH4t3ZipWCnNVbHSmoPukKMn3b9uqyzrmQVKfu1g7x
	lh2yxuyX3latawFZhXHRxpnjdgaoaNhPdgQh8WEIpDZp5UJt+C+kZMxxY5SAQQwdFynO/6ehYjifN
	2XBoo//LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jT86A-0007xR-SB; Mon, 27 Apr 2020 18:03:18 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jT867-0007wV-I3
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 18:03:16 +0000
Received: by mail-wm1-x342.google.com with SMTP id x25so641199wmc.0
 for <linux-nvme@lists.infradead.org>; Mon, 27 Apr 2020 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8kkiQoZyL52bM98uS+NVNJ+KUSycw9kMBRFEFYEjPyo=;
 b=Iv7lN4SYgCC8OCj34c9Lww3ZLGvoQTjyKptBU5gHoNiBmYcM6Rn7qkDZO4H9ehwNRI
 SxI0MVDhCwo1G4h7Upp9rJgTrU8tsu6w2MjiZAaxNZQl2up9C6rIig0GGKUFmyHFZEG5
 5qelknXeJyP5KKvQjk0ughV21vg44zk+NAgpD1JxF8NnQ5S7cXSjJnO/Tw49f0YQ6DVK
 sFgEZ1jf7yvJVI5yAqeqR0ncOP3jHQ1u3ia/jgiEJlG/R9LYLot9BYzo9V7ByfXdruaX
 0h1fFb0VdmK+EirNJQMvCOG2+3+Ll5qd7aHBHslD8CYAMKvLnOUBBUNwr7HnTaBe3Zyu
 PhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8kkiQoZyL52bM98uS+NVNJ+KUSycw9kMBRFEFYEjPyo=;
 b=GU3MseYxXxLy8bns+aqWiDoG5pUVRrZ7vfIr8ShjHINaQSuHtr+6DOxIlekluC/QQf
 4fXWC+bpPwtpWXTZ9EvSanRMNT6mCCYzTqZl/qPBZuzsk4BPVOU5HD6PVLoud5muSf0Q
 9Qs0zKXPSwm+lVwm32L3UN4RjzUWdSdPXtPv63Bk2q8V5eiP4edEOsXxFBcygx32RD8n
 PUayU0Z/nB3EKObyk4FgR9kG92RkhrW7QcnWrUMavBWbeqKbvz+6PnBKM1aA5LaGdsl1
 b0oy86mtEUzoVkUzDHgIw7UVp/iVDk0LcyRcz3ry47Nh5n3Ekroj4P8rWMhxfCSGpT6R
 Mc2A==
X-Gm-Message-State: AGi0PuYcu5JYkYEQc266SivHyA1bbqReO4yIGJII3BY10hMwZOBIBZ0z
 iPh4Vs8okOvVYkMdYWYoJzXHvM5lEJhgsA==
X-Google-Smtp-Source: APiQypIBvmmtnAK8BhRP5kW/qy9KU+eOczQrDkh0Mx/nX8nsKauWKImyvvS3MLQzevLvhmx1gpPDGQ==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr663782wmk.97.1588010593436;
 Mon, 27 Apr 2020 11:03:13 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
 by smtp.gmail.com with ESMTPSA id n25sm11445511wmk.9.2020.04.27.11.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:03:12 -0700 (PDT)
Date: Mon, 27 Apr 2020 20:03:11 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Message-ID: <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427123443.520469-1-niklas.cassel@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_110315_646682_E0AA7F50 
X-CRM114-Status: GOOD (  11.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Igor Konopko <igor.j.konopko@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 27.04.2020 14:34, Niklas Cassel wrote:
>When jumping to the out_put_disk label, we will call put_disk(), which will
>trigger a call to disk_release(), which calls blk_put_queue().
>
>Later in the cleanup code, we do blk_cleanup_queue(), which will also call
>blk_put_queue().
>
>Putting the queue twice is incorrect, and will generate a KASAN splat.
>
>Set the disk->queue pointer to NULL, before calling put_disk(), so that the
>first call to blk_put_queue() will not free the queue.
>
>The second call to blk_put_queue() uses another pointer to the same queue,
>so this call will still free the queue.
>
>Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
>Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>---
> drivers/nvme/host/core.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 91c1bd659947..f2adea96b04c 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>
> 	return;
>  out_put_disk:
>+	/* prevent double queue cleanup */
>+	ns->disk->queue = NULL;
> 	put_disk(ns->disk);
>  out_unlink_ns:
> 	mutex_lock(&ctrl->subsys->lock);
>-- 
>2.25.3
>
What about delaying the assignment of ns->disk?

diff --git i/drivers/nvme/host/core.c w/drivers/nvme/host/core.c
index a4d8c90ee7cc..6da4a9ced945 100644
--- i/drivers/nvme/host/core.c
+++ w/drivers/nvme/host/core.c
@@ -3541,7 +3541,6 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
         disk->queue = ns->queue;
         disk->flags = flags;
         memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
-       ns->disk = disk;

         __nvme_revalidate_disk(disk, id);

@@ -3553,6 +3552,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
                 }
         }

+       ns->disk = disk;
+
         down_write(&ctrl->namespaces_rwsem);
         list_add_tail(&ns->list, &ctrl->namespaces);
         up_write(&ctrl->namespaces_rwsem);


Javier

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
