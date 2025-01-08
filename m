Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35ACE77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1DjUCM/jbBSR6cK0gy/+/2U77r5hRrUDOcnrZNiR9wY=; b=ilV2eYGmIgcF8/Hu/RpcahXshN
	MVGPdcKQ+uwlERJpkrwRgLgblcgdFZqx7yivH5Dob6QLHJ56j0jynq9d7JLa9TLJnUEr9hTJ+CMuv
	ACvekhBjTtSd//gpd02s8HVCh1wo8TrOYyvv6s5doN1iLaUnTHP2ubNjGUw2aXMCIvAYcUUPe4Vb1
	7HXSC3TVcPhmY4SFCNJ7K2leUYtxYRVFIH4LHbwDveVGKZKk0ctIaNKbbTTnooE3xB8wvG4Qvqhlz
	9lyXBeOnmGi/BHkEok83p68jhyDKWsj4eqNQPnEiC9p38bkxi4XzlFEcb5iPcNK39tuiRqo1Opm1g
	Z82F3oGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVSS3-00000007o0K-1642;
	Wed, 08 Jan 2025 09:34:11 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVSS1-00000007nzl-0E5N
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 09:34:10 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-385e0e224cbso8241060f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2025 01:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736328847; x=1736933647; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DjUCM/jbBSR6cK0gy/+/2U77r5hRrUDOcnrZNiR9wY=;
        b=Y6UnytrC3vJ0/IbBXEfsFwUxDX950+z3OnVdA6LWM/x/UmAd0ESSjLw43lP5sa2w29
         +eRlahcBhp2YC2/+EBMoIRDBIHxCL4h8qFY5GZCzajc0rdiAyhzORdY8fxnuv/YVtYm6
         xSn7OtUeoIwQV+hSUHZF046HQm4kSiPyiXVP796hWyz3MyWv/+Y/wMD49I3VMo4+a3ak
         WVKc0S8WGXtS4zaHBSg8DL62cPMXfn1r47dDqtSuY7YgJeSTBCXe+yGrclRhPSYX4ZHh
         7S4iERpqlcypkygOJu64/yEQxQibEwL4zapKU6+KDaVTjkyX6da8e0OXriIEMnyce3g4
         cfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736328847; x=1736933647;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DjUCM/jbBSR6cK0gy/+/2U77r5hRrUDOcnrZNiR9wY=;
        b=mhIUf+6TljgdZwHLgM4i1wkHHsTA04OXrhe+IfAQqdBPYBQW+/IpWp/8vj0kzg0KpA
         M2yzaUa1yaJNKWrbR+mxF3R1IYvqFRAUOaswkvR+M723zfKsD/Wk1xdNBZ2xFXPVhbmg
         /cK/H6oiHItF0+KGC1wZd44kqP7rCbyx0stsjG++B9iDukgHUvtarhUUc7/4ybGtGYI9
         Vca1o7/HVnpEF0/CkFzkK7upjUZLOk13x7YktHBViq+ydv+oUUZffPgif6h2+NitDJgu
         cD1Jh9f78UkEvMeuFf8Ghvb/ZiLSPf2LSaoC/51e81j+Rz5PQWMM7kcjy9Xs4Ye2yPqL
         JbFw==
X-Forwarded-Encrypted: i=1; AJvYcCXIy5CcVOWQdCfzeoS65rBIA3Ge/NkDuXrZY00VugTvQ3G/83xHdVOlzfL+VhwGKLtCIBgDZVBVcTRI@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2yElt57WYf7T5jvmqOwnY+sfGRGEkdN84MkrxOBqqeT36QMN7
	69bwFAuuZZVlToYgPO8kzgL8SkOo9u/u9KZDm0V6+X9nBCjm7jT98xlV1Nk8Rpc=
X-Gm-Gg: ASbGnctIFMyAlCvHbniGsm7knFLKD+17SPznAKNL0ChcFriWSgAP25TVD65bjGPBkyM
	6zg+9QzPQyY0RojZlV2516/L9GFGbCA5tkZ+WeB2fLY5L2inxp5Mk7t6x1K94wG0UOV0L1uvvOJ
	HRV6x8Iuw2uhMIxXN3hAHp7ehL+AjICM2I9jvXS3fjMRWLsxF/1ZrzUp7mKWJ/vwpxf+lNqmuOd
	/HHGXvMwOIpkOA5/utnZ9TpOnqQYn2BDXVTvOBQUQqAA4+WjmlQ28F1SDZftQ==
X-Google-Smtp-Source: AGHT+IFIvyFGgaq0/LulwNY8T7dmzAp5swTnN2NutVuGddfkmNBlI6+QhCrQSOIBcI4yvN6nZlRY8A==
X-Received: by 2002:a05:6000:712:b0:385:f3fb:46aa with SMTP id ffacd0b85a97d-38a87308c15mr1512201f8f.43.1736328847516;
        Wed, 08 Jan 2025 01:34:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da63eesm14430465e9.3.2025.01.08.01.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:34:07 -0800 (PST)
Date: Wed, 8 Jan 2025 12:34:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] nvmet-auth: fix length calculation in nvmet_auth_challenge()
Message-ID: <2abae353-5e30-4dc5-a2cd-26dab4db93d0@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_013409_104585_03CD997E 
X-CRM114-Status: GOOD (  17.21  )
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

The "d" variable is a void pointer so sizeof(*d) is 1.  It was supposed
to be sizeof(*data) which is 16.

The "data_size" is the data required to hold the data struct plus
"hash_len" which is the length of the variable array at the end of the
data struct.  Plus the "ctrl->dh_keysize" which is the extra space after
the end of the data struct.  The "al" variable is actual length of the
buffer.

This mistake means that we will not zero the last 15 bytes.  We likely
copy data over these bytes so it may not be an issue.  The main problem
is that the check "if (al < data_size)" which ensures that we have
allocated enough data is incorrect, potentially leading to memory
corruption.

Cc: stable@vger.kernel.org
Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I thought about changing the caller to use kzalloc() instead of kmalloc()
to get rid of the memset().  But we need to calculate data_size anyway
so moving the memset() doesn't really add very much.

 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 3f2857c17d95..aad113e17072 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -356,7 +356,7 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	int ret = 0;
 	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
-	int data_size = sizeof(*d) + hash_len;
+	int data_size = sizeof(*data) + hash_len;
 
 	if (ctrl->dh_tfm)
 		data_size += ctrl->dh_keysize;
-- 
2.45.2


