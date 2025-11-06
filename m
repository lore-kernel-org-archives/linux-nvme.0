Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51FECCFA05
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1FIkj9b+mixj5Rm823k0FAzL9RiM2lOllkS3tk8IaM0=; b=nUEwvYe7Wh++S8MBSKjHA7w6E/
	DLrNuNvHgumK5Ikjy4oaUHEj3L3RzEef9yGYvyr1IM7zLfPrzi+i/XFOMYPuR1R1Hgxm5xMq7gHs0
	4XrYcZJ3xDb+5ebNsnmBKunlaAP1qcanZb1xn+YlnEhvfN73guRi62ECApovFhGJqV1odAwtwyV0J
	aEavRw4g9rA4pFqyB0QLqRTJMBBJ9htV+pQg7GzkoYJS4ohTUU22/GhxZbmtJ/l4Br6XMMnysgFHz
	qYRcBXeW3qy+HdHOmeWpy/r/V1poa5NMZZMxrhyIp7DUcjYfHHrGWnd2G+TIKY2CFt7geLBHc4nAJ
	Kl4PSalQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH4w4-0000000G6aY-2QQJ;
	Thu, 06 Nov 2025 18:42:16 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH4w2-0000000G6aA-0mcP
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 18:42:15 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-781421f5be6so13698837b3.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762454533; x=1763059333; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1FIkj9b+mixj5Rm823k0FAzL9RiM2lOllkS3tk8IaM0=;
        b=drgRaYQWuUuyGgM74GB1uniJiwBEICxNVsPoXNtKVaS93BI/53idxnwYBN60BPJ9j9
         OlcDMO2GVTf3VePkSBkeOCjqfZJr2Y2Q2h0HQaWlYGBvDIEkn/0V75UlHRuOD2o6xajW
         MrWu/e2vbJMOzhDvCje5rYsXWGZ2JAKujwAyt84YRqiOgV6hYpXCYqCTV4aomXN8A8fh
         oy92TOspmcLf5vhCkU6EsV31gjsNy8tdzONLpN++meMJiGbndG+WEJaGtO5fu5T3l3Q5
         rpMOB9/htEy0ip12+IOlAsso3RTlmWEFddGS/Wp8w6St5ULyceMIeAlhSFZ857/aYiLc
         9CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454533; x=1763059333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FIkj9b+mixj5Rm823k0FAzL9RiM2lOllkS3tk8IaM0=;
        b=niLoFG/9FLJBcBBE3ZxL/Wf3rjV3PoGUBFiVwWAqeaSfJg/4T/sxrPc5+evl46c09Z
         6uAQa52v5jIfhsBGG2vZfZGM1aLyYth4qsnZMKfrw8sN51h1hSeY+TmPivhwlBxw0LyV
         PmMNAmnO65Cj/At9TdWqRgZfbDCRyQufrfN9S0tBoWzRQPB+Wt+li7kLaqxPoVfBFwcC
         qhQBrA2/aInb3+303fK3uPTSHbPlLfjwWJ9fPSojaGDju6OJzXaHrIOfeIKZvd5IOO+w
         F+o7q2oM/+avKyruCoZ1lb0L0Bi8Vb9TNQU7OopqLmvQQ2eIjN/x7e+yQZhUNOGN7ffi
         HPiw==
X-Forwarded-Encrypted: i=1; AJvYcCVDi5+Pvpn+OqgBDziRy9bF9WQoKe+QMAAIo/zWpHSRyQq6yYsVg6pFAD12LR3IiTFOevQzvqt5aZQb@lists.infradead.org
X-Gm-Message-State: AOJu0YxnAF8ICDQ8pmlvNbCV8RgUjcG1Yy7cL0R5almZzAUBYODkFAFZ
	UWWdCAo5JDMfcT6cJ1dXubUn9cELVYAjdGGC2YU6vq4UV0JTHyps2/ScYAf0aityfK29lUH6AxO
	hIy9LYQv74RPNHJYNqAwYD4erfQ/pP8nm23H9QcU=
X-Gm-Gg: ASbGncsdjTQkri8KSPqnifX6YY5HTle5jjF5AH5LSP71OYFRBwdSJUdnZAbNqfAuI7k
	I/Z/Z2WegJuAilIQybv4I/jue5iVvZXVlAbohZojPmwD4Sh+aUdQOrt4/7bUhvHy4BuwFF8m9sp
	1DOX24hQ5tOGoCsxAhMeb3wP3r/hAJi+dCxamgBoeBm4ik5K7s6+PGt3yDDd1Z7gG2u+6C2hrhH
	KOTL649FN0RGm0j0UOECx0itUcLZlCRG7mVZlCCq3s8JOoC4fVrwNcUPt4g9BAQb2A0HlbO
X-Google-Smtp-Source: AGHT+IElVNhW0M3PjCH+PkYBjIXR+99AQZBInQ6KD2TmAz+A/SchLSZlk+h5L9aFTawIceMky+lJCga4v9uIkZCCVWs=
X-Received: by 2002:a05:690e:419a:b0:63f:aa5b:bce1 with SMTP id
 956f58d0204a3-640c444de3emr325438d50.39.1762454532744; Thu, 06 Nov 2025
 10:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org> <CABPRKS9aLHfaiTH6YSa6E3d5gQab-tUEmPYbr59X-ybg1p5ErQ@mail.gmail.com>
In-Reply-To: <CABPRKS9aLHfaiTH6YSa6E3d5gQab-tUEmPYbr59X-ybg1p5ErQ@mail.gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 6 Nov 2025 10:41:36 -0800
X-Gm-Features: AWmQ_bnLCiQ3MQsUo2WmF_ON4-aDlzJE-K4Fh-EBv0St_rNCfVThKj3v4IS0qig
Message-ID: <CABPRKS8K8zfkbbVZYYxrLYPgAD+nhmrknkpA+57wc5TTAKwz1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] nvme-fc: fix blktests nvme/041
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Justin Tee <justin.tee@broadcom.com>, paul.ely@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_104214_254519_62B532B2 
X-CRM114-Status: GOOD (  14.76  )
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

Hi Daniel,

Taking a different approach than this patch set, may we see if the
following singular patch resolves the nvme/041 blktest?

[PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for
authentication failures

With authentication, in addition to EKEYREJECTED there is also no point in
retrying reconnects when status is ENOKEY.  Thus, add -ENOKEY as another
criteria to determine when to stop retries.

Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3d4d6d8e88c4..fb7765bf0cdf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -594,7 +594,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl,
int status)
        if (status > 0 && (status & NVME_STATUS_DNR))
                return false;

-       if (status == -EKEYREJECTED)
+       if (status == -EKEYREJECTED || status == -ENOKEY)
                return false;

        if (ctrl->opts->max_reconnects == -1 ||
--
2.38.0

Regards,
Justin

