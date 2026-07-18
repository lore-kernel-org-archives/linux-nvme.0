Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB91DC44523
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Jul 2026 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CUxR31Xh85+TAm3j4nZpX4fvNBvJG7NmZg0i4br8yQ0=; b=bvBYyg75NeLpp2gE67rLaJm0Au
	x2yBILE1gcyEqhQMeT2vm61iZApj+c7DQrwlvU7kvQSsp9IY4xW5O9eIufJalOxX993y4kendBM8z
	AC1sbxY+sKTOCQTpIn67I770oUNU22oOwhNS9EdDTC3tHZQc3zdW1aUF8mmnHp8EJePvm21bKxDyR
	Rp79XXMB1i5f9drBtxWLO9worzlcA636udDQN3xCTQgE9HJK+ynYKJ3EXlhzBaqV3thVVK2s0Vt3D
	5RO5Rt4Xs/NPReRAPfEpInA/PfVSoZ6BoR+T8LCdRdZN742GG4q8OKN5cdKcCl9JBYfQtZvs1mBWg
	MATnj1eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7s1-00000004H7X-0jXI;
	Sat, 18 Jul 2026 16:26:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7rw-00000004H4a-18wv
	for linux-nvme@bombadil.infradead.org;
	Sat, 18 Jul 2026 16:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CUxR31Xh85+TAm3j4nZpX4fvNBvJG7NmZg0i4br8yQ0=; b=Ytsmo+y/yA3X7xabcFDoA8/wru
	/7i0z0lFcNOfrSrWPph1je+wR+oXwokq0FmINOr//6nKyywQ0KqJiYOn2eUUgTd0z5A8QRgQa2oBd
	7K3yFqhVEcJ8rLsmQanGDtnB8SPC7pV8XOp5Oi8pYMP7pesJzJsWYnVnoQVE38EaRFv3ciamc4EAF
	7JPTdPSPln5rE4fec4fCR7hDFjt5dnuPhXdvcEokZ57yq9fna9R9eOHmec1I6STAJXZ0/iFZbnyND
	KiuV+Ff+gSQAKFvh5NhJUALkNvagGv23FY2JSz8Rde4SL/X6J2VxI8WyMwqnKgmqGN5xKQylvk2QD
	CKuEpQFg==;
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wl7rt-0000000Fa4Y-21sP
	for linux-nvme@lists.infradead.org;
	Sat, 18 Jul 2026 16:26:27 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4955484387cso1717405e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 18 Jul 2026 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784391984; x=1784996784; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUxR31Xh85+TAm3j4nZpX4fvNBvJG7NmZg0i4br8yQ0=;
        b=US2R3/PX6+vtrPetX+r06+5s/VFFj5zqDNpvGBwJ2Yo/wQ7USoSLrmhRQEoiFONpyU
         WmcP6JepquTNG5jRQ0gDMZ1FiStqtfmKbpOd6IhzS7wBU3gQZpWFQrJgWFErk7IupL4f
         d0KidxTANNzP0/2JJ4NrJivc2Qen3ZjiAZJKi5FaWAR3BIxZoMFS9gDVxPrCmDLCJyAc
         PY1bb4YuevA/W0t4Xby+GarH+HaMjpizdbhWU20FzgwtiXxiNAGIRYv1OV0oVp3corC2
         raDY+wPIen2lob7lw34Pv6tnfKN1KiXPFE4CNWULSq998XM1V2ULdhrZPkRbv3vKvr0H
         ig7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784391984; x=1784996784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUxR31Xh85+TAm3j4nZpX4fvNBvJG7NmZg0i4br8yQ0=;
        b=F18D4JO9kmz6OxytufkkP4QhU6GHvrLIWxTr5dS0TjT2DTobCDYE0tjVwoYGQsni9e
         cGylAbEjTdQbugG4yeGoncvE0ci8a2Z5wG7yfBqvyq7sGXoG1wq1uA/RejMJZD4aXWgM
         rBtC2oSGElwOZGpOclDOXp0FzwpBf8LmB2cAj4QqRAGWSLuU/8jEldVJQrydKaC18Oou
         cUjwquPUjd424vnWmwK4vyUDHuhBWb0BWj25urP36PhY+3eGqKmf27Ma3Ti4B8G9xfz/
         gIlu9KF+ydQwzeDyTiGPG5xlmdoUtd65cEsv4MU9LQsvCA/Y44zm7IqOogmihnwl3lxU
         bM+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpgvWpkb4OWvx7PJWLJhtd4TfBIPqRlU/Dy4OUbiFXy6SsayYgUZeMa47DxAEmMei0RIz/vt0VDsHWt@lists.infradead.org
X-Gm-Message-State: AOJu0YzGzxS+gUUs3owF8RmShuwPoUnTAFDlkbR3DZG2JYZ8Z9qyAl/K
	Srw4TxTjwi976B/8GWGgTRKk0AzD3CAAbTZwLFZMGR8lsHx17lQCwYrwzejAcS0rbg==
X-Gm-Gg: AfdE7cmC55ibT+KcVcyQlAsvCdiX6+9R17gREKjaV0wOBklk73+Kyb92UJfRq+to9PR
	LWQ1ONyXgZUZCK1evs4Z5XH4agKwgMqrT3KODxsQbje6Q7bQHIVQ0lDhUZDbcvBQRXMljxcPSKC
	5KCOmNM3rY6pUqF+M/4qqu7BcWT7wLGrsUPrrOyy9b7hkbK4XMI7A2bbqHSwCh5tSYKMpvZsdn0
	YAEq1djbp9WX/4A6h4H5IfsDTLe8ENJ5iAKxRtEwJ4w7ena201Zcj1crliTGGqPJxyVt4BQfLyH
	/V+CNP5i3ZvMwtUOswGeh7ounl4EtrdCLzN51xSC7MmV00BuW9yp6L8hKyHojwzypLMdbhWguB2
	SxXtdFE8h2RYRx+Cujpmwu0NeqllnEQomCS28srTpuCLe0NsPL46fCdua/3YXvg==
X-Received: by 2002:a05:600c:1914:b0:492:7101:3d88 with SMTP id 5b1f17b1804b1-4954a402e03mr75887675e9.24.1784391983856;
        Sat, 18 Jul 2026 09:26:23 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm266444085e9.14.2026.07.18.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:26:23 -0700 (PDT)
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
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: [PATCH 4/6] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Sat, 18 Jul 2026 16:25:45 +0000
Message-ID: <20260718162547.448892-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718162547.448892-1-mykola@meshstor.io>
References: <20260718162547.448892-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260718_172625_722789_A18727D3 
X-CRM114-Status: GOOD (  11.63  )
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

narrow_write_error() re-issues a failed write in badblock-granularity
chunks, cloning from the master bio and resetting bi_opf to a bare
REQ_OP_WRITE. For a P2PDMA bio that reset drops REQ_NOMERGE, which is
the only request-level protection against the member queue merging
P2PDMA segments across pgmaps or with host memory (see the preceding
md_submit_bio() fix): the retry path would quietly reopen the hole
the submission path closes. Restore the flag on P2PDMA retry clones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 57f64e890102..a30032321191 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2565,6 +2565,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0a3cfdd3f5df..f7ef903a3d4e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2831,6 +2831,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.43.0


