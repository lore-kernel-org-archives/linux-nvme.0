Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC54C531FA
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=; b=I4MDkfYl+pCRTglS1kX1pQqT82
	BO3XhPtgVIXhdo5Fj/7lJdf3+LCN4gwARb0+VVvYZxSzGdwxshJ1/eyoKtCyGMooeKo+xGnNpMAGP
	bqE2qwrFTOFm1SOyU4yUobcXo5IZ+mu7tSkkTdK3MbtI3eQ+I9GLc8FQRx+8cb2/e7p2qf1w6jBOg
	XqRgIENZLDurw1hNBBHDpsMYXI3sb/Py6c0lSZMzKZWKZ8YBQiHCX5q54+aENghQJ3buhBWvBq0Sb
	5EbEt+XK7TUftvjNA20kkkj4c7NFKFQ4B8yzvUm0/M65iOlhyQSGfB4k9wvJmAKWtUFgftftmpE9j
	DCL4vdqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G0-0000000F3aJ-0IC2;
	Thu, 23 Jul 2026 20:43:04 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0Fx-0000000F3Y6-3JVK
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:02 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-4720f3bf164so588728f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839380; x=1785444180; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=;
        b=VDmc8ftzCHHnfjt7LHg9rIy/O8CdScJMe74N1hwZghG99QRh9CxtoracKzRDCrknkj
         3J23WakaDopTQZ6RtNOIYVSYOZrfS9ECW/LG9uEaT46LSPj/97AQnVPPziAPwzJRbu9/
         JoAhOCQKzlDf2nae3bwIfDagaebomcMOeFCcrQ3yCnKnR+etMcFsacbjJaA7Gyg66e2S
         njkIESqmIkyCrdCzR9/rF5uNuO3lsbMBEWIjbvWOqj10uxz1iJ/8avDNicSrsxQQlzXf
         3BVi/JdchUKdL8SHPxe3pNoNuL5ORS3vPcehcWK61NpRIMVE0ZZ3pjPB3OJxrjCBSxHV
         CnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839380; x=1785444180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=;
        b=lXm/J9B8xAUEUjxcvodoQlhGJL8qMQh1EQNYdZ+vVy2B4aRa4kqx9SlGJl6m+VvKv4
         VOtX7yXYsyvnJa/iXWFYVPxRRDFDTKI7ALJWCTlKDy8hzjYbx4SWJj6ddsVzliXRbLDS
         X3ODV6Vr+s65DJKnPKXkRWJzl3INKpcJg22rnWcqFB03/I/7rvs0HTL0yEmo/itANvrX
         SQG9S9OoxpkfXkehKAbLlz9gutO/4iB0rrwtBlXpFc8pDJN3W2ASEEQ1+nU7mLDELwYR
         AcRzIDP+ADUNjjqV5hhN013DyRkXbi9BFDdfQp1Kwso9PpGu5DwLC3SlXDKZ8r6S1UkU
         JXFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpd+Kw+izdkHaSFmA+b2CFCtxpF0odayUVV+GMDAJYUzI8RtugZWGmKTabJDVaHC7lxznUowKh1JBi7@lists.infradead.org
X-Gm-Message-State: AOJu0YyTfM9E6K/bPZZbVpszUClELB9WrkGW5ZvyBT9uvi9y1mYyfL+8
	FID+I5ZeL3dOv9e0u3gcLgiadJIB9VES7a7O+7veJCya0Ia/zv1NWULUtxHxd+s/zw==
X-Gm-Gg: AR+sD122usy9m2OzqsymO5MVucfZhjeBLoj3LYBy5MRZcqCo6KjII/pVT6n/kTnxYmx
	Mh9Vlcc49+hWbumm9yyizBnVwIAHEy7OifOO3FBQ8EqEuc2RAqGyKij+oiXmebG/YbQLU1C6jYW
	n7PUTLOJDvbXC6G/fwb2c4Vt2mxqXlQr6XS93rnIB6ndvUJUp8KxPaiZiFseOnrcpkDTYJaxJbi
	mzC8DAbFw9Pz9y6hcAlAlmrL/Mq0qb5jzFVZZJdSp0zqqvl1RcRXE8r2iEfrLI8tlCqSNplXPsI
	VhJAvBXMXVYdZR1LzMuFaY+Z0438foHj3z2HzltGRiaI+L7KfdYBZFJ0yP+PoqAnwxjIvJien5Y
	Z5kly2l5SjtqXUPY3U2MohY9jWIku8XapamiLX3zPTIy9MP5A5f1fv9HNRsWA1syQA/uMOSinfG
	/SxSza1rsrn4dAHKiSuujfCndC9S/UiDvvM7i24vvt11ODS22QUoGax2ZXdTO4ZZRVA+WfAXIDH
	ppGWyoyxOAIm/Y2bHejeWxbjBlrhml6N6k6JYDoYg==
X-Received: by 2002:a05:6000:2309:b0:47f:9208:9e4 with SMTP id ffacd0b85a97d-47f92080a4cmr4670984f8f.31.1784839379605;
        Thu, 23 Jul 2026 13:42:59 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:59 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 03/10] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Thu, 23 Jul 2026 22:41:59 +0200
Message-ID: <20260723204206.76930-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134301_872266_E4297626 
X-CRM114-Status: GOOD (  12.78  )
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

A write that skips write-behind (full behind queue, a waiting
reader, failed behind-bio allocation) races the in-flight behind
write it overlaps: nothing orders the two on the write-mostly
member, and if the older behind data lands last the member keeps
stale data for sectors already acknowledged as rewritten.

Serialize on CollisionCheck, which marks exactly the rdevs owning a
serial tree: serialize_policy rdevs plus write-mostly members when
write-behind arms serialization -- the case the MD_SERIALIZE_POLICY
test misses.  remove_serial() under the same condition.  This also
avoids the old gate's latent NULL deref for rdevs hot-added under
serialize_policy (they never get a serial tree).

Fixes: 69df9cfc7042 ("raid1: serialize the overlap write")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..997f79c05db7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -564,7 +564,7 @@ static void raid1_end_write_request(struct bio *bio)
 				call_bio_endio(r1_bio);
 			}
 		}
-	} else if (test_bit(MD_SERIALIZE_POLICY, &rdev->mddev->flags))
+	} else if (test_bit(CollisionCheck, &rdev->flags))
 		remove_serial(rdev, lo, hi);
 	if (r1_bio->bios[mirror] == NULL)
 		rdev_dec_pending(rdev, conf->mddev);
@@ -1677,7 +1677,11 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
 					       &mddev->bio_set);
 
-			if (test_bit(MD_SERIALIZE_POLICY, &mddev->flags))
+			/*
+			 * CollisionCheck marks every rdev with a serial
+			 * tree; order against in-flight write-behind I/O.
+			 */
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_for_serialization(rdev, r1_bio);
 		}
 
-- 
2.52.0


