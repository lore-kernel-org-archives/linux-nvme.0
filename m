Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653C606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bCvsC0xZ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vkBY5Fja
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=; b=bCvsC0xZ8aoJi0/aAkf5rrL+Ea
	TWNfhb+DXiOM+3qGGEa9WwXxpGvxcyNqscYidz7oGPXSskzA7pcA4DD5GgZydORFecLXmZblVfdVx
	myK4cEsvFLIhH03gh3lhL6qEVHa2iW0rTgKXgtlWwoRkbkv3FaO0u6abptQEAKasptW28aud6gNtJ
	s1o+lEhTEwgUWYZrqvpXgvQwdqow7u2v/Ul537YGaywxlpGaglKmhwWFG2kZ91fXnbQkyZRRG/pSo
	vrr04670hE2phEOITHS6XbzFnqLB//eJAhoM9JZHUJcVGIMk8CTZpqzdNAMVH8e1y9l9hmtrAJlY0
	CRqj1fEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVX65-00000004E4l-0t9d;
	Mon, 23 Nov 2026 16:40:53 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVX60-00000004E42-0NJO
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 16:40:50 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so5162097c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452046; x=1796056846; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=;
        b=vkBY5FjalMZ/8c1o7kMFmXZsCc/LRjL1jWgKPYSFGPuVt99bSFaam7MaJx9gJ2tkqw
         OF/EcxZmjw99DPbuFjZOGIv4E48gz2M/PcTm+7IhfeCYVKOCNR6eI45UzdQL+Ni7NywW
         loty7MUJhH+Dad1tEiA7SwdlfE+02OAtpEElTXm/nROg49YbvnuzkqPd5KlfuX/1aBvu
         f+yhebMSHqJYXxS0U1IW5g/NFYr/RB4I0Z2X9hjCuQ5ayC82k8LSgVPSZ+WoBHaxevwR
         FGgYAHxHMRvgvS6PQ4H1UfVNBrU0j++V8v8aJ8EMbBjEr9Txhb0VLolPWN6c2Ck0s81Y
         Hzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452046; x=1796056846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=;
        b=IMAkUO+x0MvKXnWv1ZANsCqZR9bumUBv+9cRzkIV8hD3i/zU3RRMr++9Ss7OUgeFML
         b0kN2j8jHfIuWTW1agcjdtou2lK3v6AbpxpK+RPx0Zo7J0H/2iuRTzmy4ClDaZmdb6x3
         U85vuvOl6YtZ5JaDEdZ2Nu+aH2L6ocFRam439sp0YOVZC/Jy6TtM/q8uVciS6ZSiwmUU
         CLLN4FobVrdN81WhXVHa+1mEJeihUrTEmIXXUR21FH+crbAQ13/Wg3h23gbfre4YKk2q
         TfjHjOwqsjCdJ7PXNzJmHkGqX7OwywTgy4fs+ph79KPGAT2XXaKYX+ZAeCqD0rzJTZaZ
         4j/Q==
X-Forwarded-Encrypted: i=1; AL+hErEq9BuNF447CWWN8GV9iVJqeSN0x9NO6L4WovDLiFK6ohoeibhEX67A3uq2Z8esNw4oEhIS5FJ4k4Py@lists.infradead.org
X-Gm-Message-State: APuU4Z+mOWT9zsrtUJB8GzuM32f8poTIEzmo5A2rV0sC9Qwxs9PBoQJH
	oVsQF54szx76DHGhc7V0eGve//5pBZ2xE4bbvRAHKhEATuv6sO81vTaF
X-Gm-Gg: AZFdTZfZfSAoQaSfYHuDGbu9V+mQ17I50DGi2PETO5zY+gou6R/yyS6Qy1sbc0wgDiK
	+ZS2hxhQpPHbfzm0aCDxgcy7GxcHzOHtgn1WufxHldL6xeq53fececRpwOJ9XlIHi7HsrmjIri4
	hLsG8dqI4SUtU4HA29SPVyyd4i6bVLhdMvMnlviuS3g79XQlt3QWtJ+FdOXcyQLmBD+8zVsEF3C
	qjSwmD1IDAR8MlR01UJP/7/OBfNSdcek/DR433gUjaDDeV8vsmJOgvsYmxHislwwFuSj0m0Wc/s
	n7LRsuWz7shkgKwudy+qiNWeDngLMig8Q4rZwhIY8sDfi3wkq+VA5f0aG72ikWUstjWSCyrhvxM
	vf8ICpB/EFLJJwErbE+EUvc/RYn1GKw+0VZQ2WsMyWroIK/8Zo/jdJImTFevfCoaATnsDl5zgGz
	/rLGagxUIwtvn6Ls1QkdAAjIZJM4C5BrQ2cNZwro8dQ+qxQnKfxWHKbTZYWzXaaX3f5Fm50/Aj+
	LE7ipyLfJM1hc/0nBmJCn8JEC7WjghaEI3Ct9u/UnRSka3HKYJ2/5Knss1gGDps6K6GXZVit6Cw
	i4yuBin0v1s0ZcFG2tUM83abuP5QG/lORl/FezASxVzHmIca34R29pCHEMqOS/1g5fBOQbs2qug
	t3u7XuA3i
X-Received: by 2002:a05:701a:844e:20b0:1b5:6c13:c76c with SMTP id a92af1059eb24-1b56c13c7a8mr6689110c88.15.1795452045824;
        Mon, 23 Nov 2026 08:40:45 -0800 (PST)
Received: from lounas.tail428e48.ts.net ([157.131.129.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm33225486c88.13.2026.11.23.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:40:45 -0800 (PST)
From: Louis Thiery <thiery.louis@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	bmarzins@redhat.com
Cc: ming.lei@redhat.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Louis Thiery <thiery.louis@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm: clear REQ_DM_POLL_LIST on embedded clone bio
Date: Mon, 23 Nov 2026 16:40:21 +0000
Message-ID: <20261123164021.463361-1-thiery.louis@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_084048_128595_E71FFA61 
X-CRM114-Status: GOOD (  13.27  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a polled bio is split across a target boundary (for example a
dm-striped chunk boundary), dm_split_and_process_bio() re-submits the
trimmed remainder of the original bio and then calls dm_queue_poll_io(),
which sets REQ_DM_POLL_LIST (aliased to REQ_DRV) on the original bio.

When the remainder subsequently enters dm_split_and_process_bio(),
alloc_io() clones it into the embedded io->tio.clone, inheriting
REQ_DM_POLL_LIST. alloc_tio() only clears REQ_DM_POLL_LIST in its else
branch for non-embedded clones, leaving REQ_DRV set on the embedded
clone that polled normal I/O uses.

The leaked REQ_DRV flag is misinterpreted by lower layers. On NVMe
(where REQ_NVME_MPATH is also defined as REQ_DRV), nvme_start_request()
calls nvme_mpath_start_request(). For a single-path namespace where
ns->head->disk is NULL (with CONFIG_NVME_MULTIPATH=y), dereferencing
disk->queue triggers a kernel NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000050
  RIP: 0010:nvme_mpath_start_request+0x28/0xc0
  Call Trace:
   nvme_prep_rq+0x5e0/0xa90
   nvme_queue_rq+0x40/0x1a0
   __blk_mq_issue_directly+0x45/0xb0
   blk_mq_try_issue_directly+0x85/0x100
   blk_mq_submit_bio+0x6c9/0x710
   submit_bio_noacct_nocheck+0x127/0x330
   blkdev_direct_IO+0x230/0x680

On stacked DM devices, a lower DM layer also sees REQ_DM_POLL_LIST
already set on the incoming clone and treats its bi_private as a dm_io
poll list head.

Move the REQ_DM_POLL_LIST clear out of the else branch in alloc_tio() so
it applies to both embedded and non-embedded clones.

Fixes: b99fdcdc3636 ("dm: support bio polling")
Cc: stable@vger.kernel.org
Signed-off-by: Louis Thiery <thiery.louis@gmail.com>
---
 drivers/md/dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1881d8611..79972f17f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -628,13 +628,13 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 		if (!clone)
 			return NULL;
 
-		/* REQ_DM_POLL_LIST shouldn't be inherited */
-		clone->bi_opf &= ~REQ_DM_POLL_LIST;
-
 		tio = clone_to_tio(clone);
 		tio->flags = 0; /* also clears DM_TIO_INSIDE_DM_IO */
 	}
 
+	/* REQ_DM_POLL_LIST shouldn't be inherited */
+	clone->bi_opf &= ~REQ_DM_POLL_LIST;
+
 	tio->magic = DM_TIO_MAGIC;
 	tio->io = ci->io;
 	tio->ti = ti;
-- 
2.43.0


