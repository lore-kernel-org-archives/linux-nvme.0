Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D092C53200
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2026 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DsDPuWCrrbv34wnYAE4DR4tUqUyigMc/FOQGtObKAE8=; b=tWK/RD54i9b7jLUjNHJcxUDpvr
	A/ZkJ4psggkLi14TWPNegTtbb/2xbpUN0Fg5yXFk4ArBjrevHBfdUa8Z7xOTFa0JXRqwgAShIeUCz
	in6hBfbbuqHhoDgDKhU49oGo2OLJUxE+4sifeZUB+hCGHV0lE8mtW5AesS2hlq0coxYF/rMZ1QOZD
	AV7JcGess34CggBtGqjgWb6zaqKpd6+58niQVeAsiOBk8VDI/T8PleJp9+s/i1SP08c/NvEmhw5yH
	t0Oahv2yFO1btRU+XGvRHprfrh4svsgQRoFFzszAJIPFTjMkxZzXOtiIsZdOWnI2r6fGGhfq9uXpk
	dxg7RDdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wncmn-00000000PXc-3C69;
	Sat, 25 Jul 2026 13:51:29 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wncml-00000000PVw-1Vtt
	for linux-nvme@lists.infradead.org;
	Sat, 25 Jul 2026 13:51:28 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-c166f1bbeaeso214290466b.0
        for <linux-nvme@lists.infradead.org>; Sat, 25 Jul 2026 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784987485; x=1785592285; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsDPuWCrrbv34wnYAE4DR4tUqUyigMc/FOQGtObKAE8=;
        b=f3xY2un7fk6AwcktaqD3YdzAs5k5XZm1SzE5grMDakvp4z8ERXrOyfLt2YFV4OPUvC
         bgGcslBlPNhlY2Th7wu5hSoqY4DR77lUTNCoSyWmnetWb7MX13YDaCSR6j7dJeslbYbk
         Of36BP9SnghigbrTSn7qOFZXdNdNMlnJj9l24tOtoQnne0Auy//f15cJxJ787YoSGjgc
         lWFyjNNGCcNkW1x3MdOusbwDcZ3PWwrLWtxuc5x9D50etBTwg3oBYs5giRa7hySbDSpp
         gF57M5HZd3r3ndrNvsm2owqQV617Cs3PDYG81EkL6IqMITILGPvu88XCMDcnbfteQUu2
         caTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784987485; x=1785592285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsDPuWCrrbv34wnYAE4DR4tUqUyigMc/FOQGtObKAE8=;
        b=el2J6SqBrJjZSKsonkgkazChxlbyLQG8QyW0f74vNvlIYair0ETcUG4n5X2Ng/sZXN
         1g5/ET6ejQVQ2YLS4hUrJf0TgxeUf7aEk3YJBNHCpVXNydp2US3Fqo9EHkWyAO9KMzcM
         yCc66TY2wJmgv8y11DgMmzeXh++0GGcX+TA96QQHvBEdo0+6RhdAqynb9TjaZ8xlmU+n
         y03PN6Hx/iRJSVnqEeYAD1W99/9lSQaeD5Aj8eJirMpTUInjm3di06bxZbMAPBRNQSyr
         ozd8O3bU7NNvzyK3z/ljzhOQ6+EOR3k3LeEzpsmdaMr+VgkASfe5wcQ39tb6zzENXIpT
         KrqA==
X-Forwarded-Encrypted: i=1; AHgh+Rrh4AcUepFSpw+8znmDxoiUfyH34KoXY1aejIgci1aC8KSLnDKAOSaSBnMAsp/Od/PHSUHeAP4jKvOb@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1O/iGoKFoRqLKSe6FV5tudsd3S97jFXslnoUg/7wT68fm93WT
	GCsKnqV+2Pr7uGdFDkmR/KfkUpnKrJa43v384xXuoBXe09+Q6hhf9asd
X-Gm-Gg: AR+sD12UvL/N4sNGuCDw/eO7ihepxVkM/03+ChQV/O+wShK2kGwo5XtuERw8m13XpAn
	5Lh5cWjdiDzc/P7U4KXWWvyludshp0YXVOW+TpG2avkS47h2/Ko0AUU4qXUby5Y1p0zn3nAxJuM
	u3Gq14Gpx/lOUUMyFYbvOpNtdfx8U6JHh76OjplY0JNJGjCLy9cGU938WpAhfUAUUDchc3p5Cwc
	HmhJryTvycTXHOHeWm9goUaDT5bh2taTxlzCXAkziAqeqYoT/foV1oHoL72ZvJSYMxLD6z8rFtN
	BO/0rHqAg+cx4S8iQNdqFtEd13usJkhBUGqRqRwS/kUFW6p0gCNf8TPt81grzkvgD6SnoBrlHiJ
	JpeckxCEInuEVQffGG6yCJPbYjhUUEOPXV5PY1A355S/IkHcnTwZiNuK1iAMUakRueQHYcZdiSZ
	m6E5/AfHPHbFWpjcwzWyPR0V8l7wZWkdyaDNx9BwwFbDjQ6dMpUVL4Hpt2zQDPbPk=
X-Received: by 2002:a17:907:94c7:b0:c19:45df:1856 with SMTP id a640c23a62f3a-c1f1ea72490mr94475866b.17.1784987485216;
        Sat, 25 Jul 2026 06:51:25 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-7475-eec2-a79e-2db.fixed6.kpn.net. [2a02:a463:a071:0:7475:eec2:a79e:2db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5543aacsm836431a12.14.2026.07.25.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 06:51:24 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Date: Sat, 25 Jul 2026 15:51:11 +0200
Message-ID: <20260725135111.14041-3-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725135111.14041-1-harimishal1@gmail.com>
References: <20260725135111.14041-1-harimishal1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260725_065127_412907_06768FBD 
X-CRM114-Status: GOOD (  14.87  )
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

write_stream is validated against bdev_max_write_streams() in both
generic block direct I/O (block/fops.c) and F2FS before a bio
carrying it is ever built, so write_stream > nr_plids shouldn't be
reachable through any current legitimate path. The remaining users
of bio->bi_write_stream elsewhere in the block layer only copy an
already-validated value between bios (bio.c, blk-crypto-fallback.c)
or compare it for merge eligibility (blk-merge.c); none of them
introduce a new, unvalidated value.

Using WARN_ON_ONCE as the backstop for that assumption isn't worth
it given how many deployed systems run with panic-on-warn enabled;
the existing graceful return BLK_STS_INVAL already handles it on
its own.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bdc5f07f5bf0..48ae0ffbbe6e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1023,7 +1023,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			u16 write_stream = req->bio->bi_write_stream;
 
 			if (ns->head->nr_plids) {
-				if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
+				if (write_stream > ns->head->nr_plids)
 					return BLK_STS_INVAL;
 
 				if (write_stream) {
-- 
2.43.0


