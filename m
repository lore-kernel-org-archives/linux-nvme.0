Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AE5C369A9
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fY1gSrpjrgeQ8ataNxaYcq0UlkrrWslBXgOoENC/kuo=; b=odgYnbCP9YtvJIwyET10b2pSXv
	NUnPi+WFaUwe0D22sa73/kB+uk2M2fK38Tv/oie4JZrv3WSJHxxTiH72w2ylxffgdD18FqVrK0efb
	hQxco978JkkDzJf6ADFUFxFbRz6CaQXcAMhnnPT8VmWV7WGRbTNDx3S3eJijgRrC1CW72NhJKm8ld
	jsO9tOcSEoTdfajOrDPz5bkqoChwZKDTAgDCe1/Oinx763nhGPbYJlZMzBTHdCPi9ARO7QerTQp8b
	/7/qRmLBnBMYl2ePCrT6ObakTPbtAmEgD6oG8zHSRHnzsKNOlsB6xpEQ0VahNTVPTbJ2ZE3rPYdjF
	K9d2PAPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Atm-00000004cVd-1ymK;
	Tue, 08 Apr 2025 15:30:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2AtL-00000004cKG-1ikN
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 15:29:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 712604A14B;
	Tue,  8 Apr 2025 15:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C33C4CEE9;
	Tue,  8 Apr 2025 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126175;
	bh=lL5xvBPnp71ji+5WknENKAr4x5TL8jAfZndzTEyuBIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SiSabXlaOkIywKuDWoKj4WIzb6MSLyktUbxB/lS7Au3ht3fdiWfrHbA+cvCmfbB5G
	 /a96f6yJtUqz6um2491bCzn7+J+yRB85v+0LcUxZFDMo8V0+QUdY1kZcmyQ1Q+4zlI
	 I0e+51xQOGj7MVUigoBz7UoocI+GBnPcwujzI2b7aZq7Wv4oLkoYpF3whjvpaaC/YZ
	 dNC7k2REF408lAaunuMJs6o30H/upQQKOJ70cvKujA4SirFw/qrb/1f7Flq61rVyo5
	 1QpXLXPS3EDT6epMdoZQYHi0Hgo0gsrE+rhtqOM2IQ94RX2lhLK/Q/TCiKpQ/EUwfD
	 ywT6tvNOPF44g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 17:29:10 +0200
Subject: [PATCH 8/8] nvmet-fc: put ref when assoc->del_work is already
 scheduled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-nvmet-fcloop-part-one-v1-8-382ec97ab7eb@kernel.org>
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_082935_474518_758169E1 
X-CRM114-Status: GOOD (  11.53  )
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

Do not leak the tgtport reference when the work is already scheduled.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 61e9eea3bee430bfdef541bfe0d1f2538a49d9eb..7b50130f10f6578e6e49fe8ea661de34dfbb3683 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1073,7 +1073,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool

-- 
2.49.0


