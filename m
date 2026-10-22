Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BD60A4AC5
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TrN9vKqO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WoUMuYpL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HDUAmNZcPxPev48FOk/77ScD0rraPEGB2IzDMOiukPk=; b=TrN9vKqOKLaF1m
	hDomOUKgoBjZX1hQTWvZtExezB4S179UiFAIim5ZJjkLHuJTc3bzLLc39FF/yWwFZnokIFa6On2Qd
	pBHyHnAhOUjk+OV4zVQYj3dMWDLpeCypTOrEfM0XG6QlPNj9p+7UlKV/9CidhjT/q1gduKT9NlHK7
	SAhb+l5PdMt+oFt1nAtuca9NAIUrOkSz9Yg8rIN/FAhHqHYE4H2vRo+fiyhfUAr3jc5mm8kBw0RGo
	xLMl1zQdfbE8xqwVtaoBqEGz1qQJOPaFlF2rtoZzAqAHVULlX7czebE5xFmheeAngH1uDQEaw0bxb
	OilbOx0ayqdk4vv4exSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsrr-0000000ECee-3egs;
	Thu, 22 Oct 2026 13:30:03 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsro-0000000ECZv-1qrj
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:30:02 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so15004015e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675798; x=1793280598; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDUAmNZcPxPev48FOk/77ScD0rraPEGB2IzDMOiukPk=;
        b=WoUMuYpLPNBwXNCmUNY79zGo4wK6zZ+AN+VkFHK8uvyUBlwrPErbyJidNiySLNKu5M
         fWVa/jfC5JQjnRz0tYch6BMV+HWYYNRdG4aKpyGlNU77x/xk+PCFjADuhxGTix0nRxF9
         Lh9myICKei4CN12FXC6NaAmQIEuF2xvv7+oWA1gwR2kYgkhlkye/MbH1fPbzBDePvGUY
         8sU2k204XFt6mMIY047QdDmWLF5EEudTfawT3EA3aTZArqwE4s2DR7O2IgZ7OvIpNJBG
         4JigtnhVNcu9U62fZntT8Dl/yFlbOOBZVDJW/2Y8v42wStqWui53icoO4nOiDG5Lc9E/
         1TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675798; x=1793280598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDUAmNZcPxPev48FOk/77ScD0rraPEGB2IzDMOiukPk=;
        b=UcwPALtvMYhABIMbKfiowdbRnQDxbFZ0LIVq59aoB1zA6Oy0hayj5jHqaYwHrwuARF
         vKKqDfh1RpxAeZhab4YQs9Md/iyzhoNURjAIMOfnCdZIbAsptQUkobS2eKHNQ1ph/bea
         wPRAcIy+Qsg9NvOTO2XxzVkP6gW3pcqgXVJgN0Ckl0eZlVp1jaDeVjGGdarBdg+nU7d9
         FcunSPPTflAnoH9uDaINnp8q1y6j4dkkzLi/MAsVG17DGQ52b1heepFxXWvnWW9D4l5A
         R8PEUmF9ufbrNoaxZu7Q9cQjepTW0ZB/zO3lSz6BRpZkSP4MkMN8UTKcnYJEJMCW0SH1
         8Qjw==
X-Forwarded-Encrypted: i=1; AKwUvBxqKcTgpqXW5pPuUzgbnnTACSSPyxWh/b2eq+4q9HUPKpss2Oa7N3GZVCuYCNJM+WbegJOmk3C4y5Bc@lists.infradead.org
X-Gm-Message-State: AFq9FYL4UiGiZyWOqT0vo8T4LI59c+qSOoEw3SPSvZ1FPWitsyLkKZzB
	CUpYOMbVlcDBWwOU6XBNy7CW+iok6MgyByZjcUtNCmiJPhFheF12fvgLd5LK1vfe
X-Gm-Gg: AYBFou2nSMl2QUhNAnla2olssOVId5ymkQYUHy3WjLlC3iddxTc0xJd9vUL2TLoHI0u
	Y4yT+sPJXc1y3cGsFalG2VZR8+N4H/YV+SwHzqxR15Wgm8vyBZ0fvP0jm7eeIB9jCYqFrARy+9b
	9PffoiYqDGYPyyxcPREwNX4mBtlbBznz7imteFjn+BwQnVbl/OuchSrco+aKPZwkzPayImZNFnG
	UBokjS+FeesvE/AoPJdNbHm8o30VCSD8RKqipYijwsTVUk1pnT/WrXQdkezdn60xNh1bw7HWSPz
	oI7kaHFVY5/yZYbJnQmzKi5k8ypTrYom2oUwJ34PrV4md4EQ9hmIRiH1tTEud2zMsv/f9r2AF5f
	hdQrKhoQmTZwpuwtxdZGRjXoL+m4oLj4o0ctUDQ4IVV3ImWhMS0tHxRRp3u/r2TFQu3sq3/WKhB
	ic7xhB9XJqgcCDT69rThuzoIqtl/Tof3mD6LcV6QymHOONYWuwDdpFDPq78M7L87LywoSC3f1bh
	Jt5+LDSAY3PDHut4Jk8LWWQYxTPIVRlbNGSaPwdVpPrrT/oa3ox6UCPi6VeDDK8DQ3zDdr1CCHx
	172Sj+i+g5TzTlL6HqBkaPAR
X-Received: by 2002:a05:600c:540f:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4a1fd8cde00mr100975265e9.4.1792675798292;
        Thu, 22 Oct 2026 06:29:58 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm108832715e9.5.2026.10.22.06.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:29:56 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] nvmet: pci-epf: require SGLs to match the command data length
Date: Thu, 22 Oct 2026 15:29:33 +0200
Message-ID: <20261022132934.3592924-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132934.3592924-1-parri.andrea@gmail.com>
References: <20261022132934.3592924-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_063001_233546_0A7A03DC 
X-CRM114-Status: GOOD (  20.05  )
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

The PCI endpoint target sends the host every byte a read command's SGL
describes, even when the SGL describes more than the command transfers.
The excess is kmalloc() memory the command never wrote, so the host
receives stale target memory. Any successful read can do this,
including Identify.

nvmet_pci_epf_alloc_iod_data_buf() allocates each segment at the length
of its SGL data descriptor, but sets req->transfer_len from
iod->data_len, the length the command implies. Once the command
completes, nvmet_pci_epf_transfer_iod_data() sends every segment in
full. Nothing compares the descriptor lengths with iod->data_len, and
the MDTS check only bounds iod->data_len.

Fail the command with Data SGL Length Invalid when the data descriptors
do not add up to iod->data_len, before any segment is allocated. The
tcp and rdma transports take the data length from the SGL itself, so
there most commands already reject a mismatch in
nvmet_check_transfer_len(). PRP lists are built from iod->data_len and
are unaffected.

Found by code inspection.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
For stable, this depends on patch 3/4: without it, the new Data SGL
Length Invalid error is still reported to the host as a success.

 drivers/nvme/target/pci-epf.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 099e8766f6d40..0cc198f87dec3 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1070,10 +1070,22 @@ static int nvmet_pci_epf_iod_parse_sgl_segments(struct nvmet_pci_epf_ctrl *ctrl,
 	return 0;
 }
 
+static u64 nvmet_pci_epf_iod_data_segs_len(struct nvmet_pci_epf_iod *iod)
+{
+	u64 len = 0;
+	int i;
+
+	for (i = 0; i < iod->nr_data_segs; i++)
+		len += iod->data_segs[i].length;
+
+	return len;
+}
+
 static int nvmet_pci_epf_iod_parse_sgls(struct nvmet_pci_epf_iod *iod)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = iod->ctrl;
 	struct nvme_sgl_desc *sgl = &iod->cmd.common.dptr.sgl;
+	int ret;
 
 	if (sgl->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
 		/* Single data descriptor case. */
@@ -1081,10 +1093,23 @@ static int nvmet_pci_epf_iod_parse_sgls(struct nvmet_pci_epf_iod *iod)
 		iod->data_segs = &iod->data_seg;
 		iod->data_seg.pci_addr = le64_to_cpu(sgl->addr);
 		iod->data_seg.length = le32_to_cpu(sgl->length);
-		return 0;
+	} else {
+		ret = nvmet_pci_epf_iod_parse_sgl_segments(ctrl, iod);
+		if (ret)
+			return ret;
 	}
 
-	return nvmet_pci_epf_iod_parse_sgl_segments(ctrl, iod);
+	/*
+	 * The command executes on data_len bytes, but each segment is
+	 * allocated and transferred in full, so they must describe exactly
+	 * data_len bytes.
+	 */
+	if (nvmet_pci_epf_iod_data_segs_len(iod) != iod->data_len) {
+		iod->status = NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int nvmet_pci_epf_alloc_iod_data_buf(struct nvmet_pci_epf_iod *iod)
-- 
2.53.0


