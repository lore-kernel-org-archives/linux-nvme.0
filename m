Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF20C4451B
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Jul 2026 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v4Dvf1BFTy/Vc0nJhWIM7SPA1tR6TPAktef7abvXxvQ=; b=UTeJaYgHaKw772dPQtvL4gUKX2
	191+UFKvjEmg+2VXbSjcxSj21biWTWb1viwPsniaejFjz3AbTc1JcTKtC6nqCOHDHan+hN62mFUx9
	WQo9W6cy0YKS093jjPtwfAHXltZ1OSrcvs2cmEfxn7RwMjHf8FH80nXTOqauTicbJV+Lvhk3BQ4ty
	X3Rf0BgKkl8LmVMuq0qyU+NXm+tWrnFIe+o+KBZSp0Zhi535GH+RyedQlqh7w5hVxbsfsoLSbXw8d
	/mO/ol8ZznzWe42XXzssn+RDKKl9CkhoMSJb9nQM6Xjq/4F0GdDDmZtNLo6ilG2E3C67XYxk6PPJY
	zZSiD+5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7rr-00000004H2V-07qj;
	Sat, 18 Jul 2026 16:26:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7rn-00000004H0w-1zUf
	for linux-nvme@bombadil.infradead.org;
	Sat, 18 Jul 2026 16:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=v4Dvf1BFTy/Vc0nJhWIM7SPA1tR6TPAktef7abvXxvQ=; b=U30C/68KfvRSFaTs9O4ThkhMLr
	vOzqB4slwka5stXD0/oc0cM8uR/Wmopih/1JqjX+Ye7Opeo6aM5R7T84r7tAU2Ms1KsvZMMFUBp9m
	t2tr4dtt42bjDcwxdFNWvfadx5YZTTVIWZsjR2ZPcwnyv5vokHXebYE8wt6wl9uyt+MbVjKxPXUd0
	OP0BrHAc4ZmQtmP9k4MwtEWMcnrBzp6gTy0jHK2Qf5PwvRJEVRueg4uetUJz3QmYuJZo69Xys4g8i
	11kmcf6xr1+uaIQ8JEerxk+z+ht3Sa0AJHGR5xWGfkBC8wVjMrTP7djjLWaC17bLlvVk8xUVi3xU3
	BpAlQSSQ==;
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wl7rk-0000000Fa3b-2Zs9
	for linux-nvme@lists.infradead.org;
	Sat, 18 Jul 2026 16:26:18 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso605855e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 18 Jul 2026 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784391975; x=1784996775; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4Dvf1BFTy/Vc0nJhWIM7SPA1tR6TPAktef7abvXxvQ=;
        b=q3m+41JRgwUmjoke+BvdFbwjaE5frwS0uuxqeEVTcdq637HaS92+MVdDFnSkByH6rE
         iA1eYCoiuIoqwcWhZPpxT16QqHasX5Vor5ONu0BB0+NPVdwqmpRlf4n9VRvC/RzBLA1S
         1TS9JWgzT6+RweND40V0VFYeCa2Bmn8cBzVknRKkEdiSTStmhof8ucPjzBZdAyKNONrE
         WO+Btzolme+8II1YVXJ2+LwY5m9nBnPff2hbQepNCzVcT8FK38z3lcGfmDLI8I8VPMXH
         oSfbPj5eV2OM2Nb2bWcCycO07+RPaPif8810BZzo0x5OlyT+f7A5nCubikM3rgQJJIyk
         kD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784391975; x=1784996775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v4Dvf1BFTy/Vc0nJhWIM7SPA1tR6TPAktef7abvXxvQ=;
        b=ClMZFU3psw2lXFbF+aV0y5sh7mGmFemn2P12Pxa1XyIlXzsSCpHhdm5G3D8h1VGPII
         TyiM6DkOVMhYjGXDXfs0hWH0rQjZ3M4ou3p5JQ87qLBuTuu2RKszfauntvYQxRc+JsbL
         b1fKihfYOT16WZifAuJ4oVNFA9SxourHkitzheBUjZxX9Wg6LHoR/YD/6nLFq9jvOPIi
         oYnguzhGFOERaR4EYmm0YyDAvuIoCWOlC9Fa3+GRD1VHF4yRB1ly4Ug0BbqtLot9kXEQ
         nMN4CqmfLot5zTZd5CySXDg6OMIZPOs8TO5QnBrV5kivpiYZadX/ewstdphA0LKJowGO
         F23Q==
X-Forwarded-Encrypted: i=1; AHgh+RoHGdUbpukY80QGD0AJiP2TjoR47PzT2+YOVFQT5zTZGKTRlhcCLUvERN364Qsb11gA5zA4Cqen+M4E@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9ErNVA/OP8f7Ei/fj1zLKpjd0mn2UX12aBG0gjkRD3HR4IAYW
	eX8a6RLFIZnsN89GG2jfugJFQsa+OiDrQeVt8w8yoEWlkCa+HrkAWbh8JOhi3HPSeg==
X-Gm-Gg: AfdE7cnGtjDj/WAog1EAGPAhoy9Cz7jWnZjX3YSCswAQHsu9GOBH+yuDRB3EcrD13bE
	6IvZPyw/hLhG4X5sVYNPg0akYpbRBicC1bFAZEsN5QTfg9gYWdlxozfqSHjQjLSYKFbYt5f7oO9
	cS7+yzJo62+9TAEyH9ZJf0VVl5YoftNkRS1JuMUsA6hqiedR1fSe/w18OV3VNc5cyRS4AV7KIR9
	YVoHUn/3px1fNWSmksrJ7igchrtOyo6WmXGK9wO0JrcCYsVz6uTH06hE91/lS/OB09fvQA88dz3
	qjTwMwJooyk7Y2VJ06fRraESm6lJyCQUTGsLWqq6dW4zGSxZepXEuRa4wLZfKPeppZ4Gezkc/dm
	/9Drg+JgaeH9bjESxQC3t8zRmTNP2mpHL7Mp4BwVjhDWsjLHM67CAMl8vh1+P4w==
X-Received: by 2002:a05:600c:6b69:b0:493:e583:7053 with SMTP id 5b1f17b1804b1-4954a41431cmr58900345e9.35.1784391974915;
        Sat, 18 Jul 2026 09:26:14 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm266444085e9.14.2026.07.18.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:26:14 -0700 (PDT)
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
Subject: [PATCH 1/6] blk-mq-dma: restore BLK_STS_TARGET for unsupported P2P transfers
Date: Sat, 18 Jul 2026 16:25:42 +0000
Message-ID: <20260718162547.448892-2-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718162547.448892-1-mykola@meshstor.io>
References: <20260718162547.448892-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260718_172616_784810_3C2570C0 
X-CRM114-Status: GOOD (  14.77  )
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

Commit 91fb2b6052f7 ("nvme-pci: convert to using dma_map_sgtable()")
deliberately mapped unsupported P2PDMA transfers to BLK_STS_TARGET,
matching dma_map_sgtable()'s -EREMOTEIO: "When this happens, return
BLK_STS_TARGET so the request isn't retried." The conversion to
blk_rq_dma_map silently changed the status to BLK_STS_INVAL, which
regresses two consumers:

 - md/raid1 and raid10 ignore BLK_STS_INVAL leg failures
   (commit f7b24c7b41f2 ("md/raid1,raid10: don't fail devices for
   invalid IO errors"), where it means a request-shaped error that
   fails identically on every member).  Since commit 02666132403a
   ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
   P2PDMA bios reach md arrays: a peer-memory write to a member the
   peer cannot reach is counted as written, the master bio reports
   success, mirrors silently diverge, and on a topology where no
   member is reachable the write reports success with zero copies on
   stable storage.

 - the failure's classification flips: for direct NVMe consumers
   (nvme advertises BLK_FEAT_PCI_P2PDMA) the mapping failure has
   surfaced as EINVAL instead of the documented -EREMOTEIO since
   v6.17, and blk_path_error(BLK_STS_INVAL) is true, so a stacking
   consumer would treat it as a retryable path error (dm-mpath is
   the only in-tree blk_path_error() caller; P2P bios cannot
   currently reach it, but the classification is wrong on its face).

Restore BLK_STS_TARGET.  md then routes an unreachable leg through
its per-device error handling (badblocks, WantReplacement, mirror
retry for reads); a follow-up patch teaches raid1/raid10 to handle
mapping failures without the retry storms that machinery was built
around.

Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 block/blk-mq-dma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bfdb9ed70741..2eed06bfe791 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -190,7 +190,15 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
-		iter->status = BLK_STS_INVAL;
+		/*
+		 * P2P transfers that the mapping layer cannot support
+		 * report BLK_STS_TARGET, matching dma_map_sgtable()'s
+		 * -EREMOTEIO and the pre-blk_rq_dma_map nvme behavior:
+		 * the failure is a property of this device pairing, so
+		 * it must not be retried on another path (blk_path_error)
+		 * nor be mistaken for an invalid request.
+		 */
+		iter->status = BLK_STS_TARGET;
 		return false;
 	}
 
-- 
2.43.0


