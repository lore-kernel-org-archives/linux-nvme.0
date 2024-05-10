Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AECC25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vQR11keyTTQOKDfkWfPtUymxGeZHTE7cG68TmAcO8gk=; b=4EWbZFRb2mWBiS4myrfhBg1+7/
	Qm9YqgUogk6GwqQepzAoCXygtBOumvfq2SkhJuAdMpcMMJOucoflfzj2GD6Sq03O84U3PGNfYT4M6
	Aj6f9aFL6fp1fndOFJqKeQQZwD942N14xXLokTDdwaaHt75o8n6EbNcEgRXS/6BeXZ7SWrlsJmnpn
	e2+s4vWz1wK3UZwqZPvUF1mQaH0tUf0ZB5aFIrn0oKdt/IzAQK0372ix+9soNotOa/A0nOjWWVGQy
	qhIccQImDBB0c2R8UhauGuvI2TMpI9bvZ2LtcM/SV7Hi1Ugw4yUiBGO1nVIF3Jgh13IZOFzln61ng
	SF9wy0eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVb-00000004s3K-1r1i;
	Fri, 10 May 2024 10:29:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVV-00000004rxr-3hD0
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 10:29:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 42E24CE1D3F;
	Fri, 10 May 2024 10:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BEFC32781;
	Fri, 10 May 2024 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336979;
	bh=2+i7bTWNtKNOAzGlbkmTO8GKENs6BV1RJJ0bZA8PkaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNs4MY8q3abQM8SbLYgXMeYaDzHCmij5v91uqVWOtyH6UAAoHEYtwfRmmkjMZW7b9
	 pHvpHFlmPx2pLHvHSnlcQp1tzMauPCkbwiNixewSYtZljYf1VNKc+GOGbzHHnqF/pR
	 YaOFURjHFbTRc/GG7FcKehQSjnKz/rReuQYOTmbqmeWMNzvGyZ+f1/iMK2zLNu/Fa7
	 uOI+PaSFKdSi/Keou7y/s70aVKizAX2JEHwjGUf9J4B198WrbJ5dK8QA//kEYvAI8o
	 lyGA87Zxx1COTgDIBWfGBj0FKhXFItokyhnEGz3/cR9QZ+HF4fCtzzVodCcpiPCiXQ
	 zBC2fzlYnZg5w==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/5] block/bdev: enable large folio support for large logical block sizes
Date: Fri, 10 May 2024 12:29:05 +0200
Message-Id: <20240510102906.51844-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
References: <20240510102906.51844-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_032942_135630_7C134F5D 
X-CRM114-Status: GOOD (  10.24  )
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

From: Hannes Reinecke <hare@suse.de>

Call mapping_set_folio_min_order() when modifying the logical block
size to ensure folios are allocated with the correct size.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index d37aa51b99ed..a0c0ecc886e8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -142,6 +142,8 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
+				    get_order(bsize));
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -158,6 +160,8 @@ int set_blocksize(struct block_device *bdev, int size)
 	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
 		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
+					    get_order(size));
 		kill_bdev(bdev);
 	}
 	return 0;
-- 
2.35.3


