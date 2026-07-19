Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E03AC44512
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jul 2026 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wPPSB8e7R/CQvh84euJ6RH38MKEu1i6y4HBVSmJRVhc=; b=qqWfMRvYaiq/BU4zWWG8k45U1M
	rg9NU/DMN7PgchMv50opcgdEHuArNOZjiNdw6+mPKBqwHqmmPtJriWP8Z7nY02wahliCM9X4t7r+I
	Ax9wDtmUpvk0K9WuokLvHWr6QRTeoJJ+4n3XNwlEkrivn+eo4JccJVszGwrHmN+xmmuHnwAktsmKp
	MAA0qPJvtw2mKu5JFZDUenL2ER4wUrYUMW7eGzP4VBwZbulR0s4tC7aYQ0sKqSq96OPSVYh9JNBni
	9WVzfpbtLRjbR1kv9U1eFH18ajAyNoXi7u8/LsWQld89bY94AjDXs0i+KVWqkgDUPeXzQyv0364lZ
	Yfbt6c4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9U-00000004vaW-2HEp;
	Sun, 19 Jul 2026 10:53:44 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9R-00000004vXq-32NK
	for linux-nvme@lists.infradead.org;
	Sun, 19 Jul 2026 10:53:43 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-49548e01d02so9338965e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 19 Jul 2026 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458420; x=1785063220; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wPPSB8e7R/CQvh84euJ6RH38MKEu1i6y4HBVSmJRVhc=;
        b=CrjAZeGyTlB1pPL8ySnvfAORmqUwJXMdmNbSq/98qASAwh23VQ62/rDxSffQKQa62l
         CNu92LnMxsAhJWXd4/OdktVja1Ny5seIT22cP1kUFZ5zzd3AiJ9S2jZAg5/EibcVjLfi
         Qb5T3wLyYB7X4/zVPn3NdSpd9hGyeZY3LG8++uz+6O2C+QCYE+gXPow1J8H3Unrvc0Ei
         jqcEkWdOTB8zGlxyYKh7fsbMQ7KmKFR1/x+IEmei5RX80dn9uE0RVUr9ZmCjBvGxKLBp
         pKXlovizMLYT+0ZYD2VXy1aMJPw6xuW4RiBOjAOU8tU/QU9GR8QikaTmPa1WivHps12u
         iqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458420; x=1785063220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wPPSB8e7R/CQvh84euJ6RH38MKEu1i6y4HBVSmJRVhc=;
        b=aqq97nqG7oqsu7XSRgA1EZq3zc9w0RegoyBCVWFLokucdq4mohGPvqhig0LdhZOZWy
         3Ech10gO35fjID8Y+K7InDuL8HcWtgU+qC7rUrTWVpxSIo/4Q8TZTDwnAPpJ1DXZay3W
         vWpvBRMuaSTEaF6PpoybC3s78twODMGVdndbWSdFcDqj0t+u6kHkN+QZ785us23KmmJg
         iFCLZt1r/MOducwFYu1GlmWWHCMxe2wII6/DKn7WoJC1lYES9UKco19L+8p5BR9sscz6
         /+v6Wj5LlqB1QhgkA6sjeEZfPP2krqiHP+UYHcT4SH2Iusx6lh4sbrFEFD+EFclmrSU5
         2ccg==
X-Forwarded-Encrypted: i=1; AHgh+RrtPuEX33tdDhHiQxjUhsQqOXIJrCBRuQY6WvHF4KgBz+XAbV1DBQcEBnwoOwFqyX+R4GzqGGX6TNdj@lists.infradead.org
X-Gm-Message-State: AOJu0Ywl3wMlkwMxAE8rBd32HAQNHI/DhZDBRmwSY48/kZNBtXU7iIEQ
	MMou4Ge5j0/Tqv5v6/Rj/+J+AdLLVku1XDv03tDQuiYyyCoYkJBsesP9VC3uDNKQDQ==
X-Gm-Gg: AfdE7clTDiAz4hsXQvhLJZO96giI6/3CMrH5TxydxAIhemm3e/+brZks53tZht24lU4
	vYz/tPacCGnpib1ZfWGywfF1qdqTTbOQNQevx1V+9VBySGHChfsVIR8Aj8+2AcUXrnrSBHwb/Wo
	WrvyzFB7P9BFVjqbSeZiZ/Aqt/utBmeHXKlw+NSFs55cRwhsMdS5hcEz7jSNfMmJsJ5XmUzvvpZ
	0vSFkX1oNop4eBaDeDoGCxSeOcg9X/j1gKMqsf99w+z/tZ/Uoc4dDEJptfvEaArqx77IdRtR8FP
	XfkY3VwFOlNRkHgZqwL8zoL9ZHJ7yD+iYvB59d42rODr3xbRLc3SgI+5aBC0IMy4d6wkkVeHMdM
	mT6MTW4auulAENT5u+lwN+aPpqYYu1hF/WVpsqC+523mafHxHaZu5Di6zI5t+xw==
X-Received: by 2002:a05:600c:b90:b0:493:c42c:7e87 with SMTP id 5b1f17b1804b1-4954a50885emr97913395e9.33.1784458419927;
        Sun, 19 Jul 2026 03:53:39 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:39 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 3/7] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Sun, 19 Jul 2026 10:53:23 +0000
Message-ID: <20260719105327.864949-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719105327.864949-1-mykola@meshstor.io>
References: <20260719105327.864949-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_035341_871911_A4519174 
X-CRM114-Status: GOOD (  16.57  )
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

A write-behind write is acknowledged to the caller while its copy to
the write-mostly member is still in flight.  wait_for_serialization()
exists to order later overlapping writes behind it, but the non-behind
clone path only takes it under serialize_policy.  A write to a
write-behind array skips the behind path whenever the behind queue is
full, a reader is waiting on behind completion, or the behind bio
allocation fails (raid1_start_write_behind()) -- and then races the
in-flight behind write on the write-mostly member without any
ordering: if the older behind data lands last, the member keeps stale
data for sectors whose newer write the caller has already seen
acknowledged.

Gate the non-behind serialization on CollisionCheck alone.  The flag
marks exactly the rdevs that own a serial tree: every rdev present
when serialize_policy is enabled, and write-mostly members when
write-behind arms serialization, which is the case the current test
misses.  Take the matching remove_serial() at completion under the
same condition.  Discards take the same non-behind path and are now
ordered as well.  For an rdev hot-added while serialize_policy is
already enabled, mddev_create_serial_pool() never builds a serial
tree, so the old MD_SERIALIZE_POLICY gate sent it into
wait_for_serialization() with rdev->serial == NULL -- a latent oops
that the per-rdev gate avoids by construction.  REQ_NOWAIT writes
can wait here when they overlap an in-flight behind write, as they
already do on the behind path and under serialize_policy.

Fixes: d0d2d8ba0494 ("md/raid1: introduce wait_for_serialization")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..8172df882f26 100644
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
@@ -1677,7 +1677,14 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
 					       &mddev->bio_set);
 
-			if (test_bit(MD_SERIALIZE_POLICY, &mddev->flags))
+			/*
+			 * Order against in-flight write-behind I/O: a
+			 * behind write is acked early, and an unordered
+			 * overwrite could land first, leaving its stale
+			 * data on the member last. CollisionCheck marks
+			 * every rdev that owns a serial tree.
+			 */
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_for_serialization(rdev, r1_bio);
 		}
 
-- 
2.43.0


