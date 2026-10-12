Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C2CA9ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FEGgdcLnqcVqT4VDy0LsmeHP+tq7RUbfRCvfJ7zm1f4=; b=C8CSoyb0MizyyrvqXf+rUb/sTP
	MjIwcmYNIwie8uG4oWUXYCa4GshmskrKg1i4DhMeefbYUrrsmbMr/lfyBzUFXy5B5N+7Zsh3h3bjg
	T6IFGKrWU5edR4FC1HOxKw+LdYGgZmKEeIH0KA3WwCalpIIb6i7j2/4foQVoVv7KT9b5D74K6HwNo
	O47SDPPOYTx3gCJ7rWZKMhNWEjbjfCIEd/HqzBXAAUd1EE/uw/Es98vkDkZ8zNBfRLOmx/gz7bkjO
	zAlZFdytlg+g9RyQsHq+7ickoIbKi80iR/Kvq+RnSys+o0lGoI2bE0J08sqB4UDXt/sUxkawXqqNj
	ecNBIqLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGm3-0000000Aeet-3ekj;
	Mon, 12 Oct 2026 14:13:08 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGm1-0000000Aebv-1k7y
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 14:13:06 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-49d05d51553so12454745e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814383; x=1792419183; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FEGgdcLnqcVqT4VDy0LsmeHP+tq7RUbfRCvfJ7zm1f4=;
        b=hXYgnXW550FZaFYqwEtb28RiKlNM34SRHxMokH+91/HgVbtMVVHFqhM2Mw3rUAPaCO
         otJ7xpW4x2p+oZUJWvu7TvrAGQ+V+OaLE+RomXY8eHNCCdHfqI6W01Om9YGpGdE+YlHl
         Cjl62ZaR8apwtytMZww0GmyYgB9HT3S8K3ySk/wjj64x20C6V41FDZ09H2C40o5nqqy4
         po9c+ROSIqtNZg5KFdz3VzUtz4Pq5YEt9+AdYtfhaxT2Th2S4xcbD2cWS83YjjD/7Xhd
         gW8oYvC71cTY5D259Uuxx9WtZPaoPc4RuTzjoPG4qMjifxMVcrCjS+HkTHmSMjVVyZ5q
         soIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814383; x=1792419183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FEGgdcLnqcVqT4VDy0LsmeHP+tq7RUbfRCvfJ7zm1f4=;
        b=qj6l9pHeRPHQOYRsjrBSHlrGZ463kvm2vugNE1i1CL/MVQ9uChP+Ij79JtyDviv7V/
         01SfX6HlaI59mh0scIZ2pWutfHVzO4DMsuj+FYZJIU9xqtDixsIffD/6WIznszTuJBk2
         BawSTgDP0eTfFvlUywuUC1jOJ97NF/Tb2GNwwYF67Tsg5SSPlgvz5G0narHtHoJrsM7F
         QpkUhRqJ2za34mZO04N/dL7JyHclQY4FVw4n6cJjDVtY80K7miuGgBQrVZ8hp++c5br5
         z2Qr+QTLdWhTjE0tqfNq6ctv2M/RzVwpdH7RK5ntHii4pD7xIpqhU2+mlcMk0podFeuf
         TWGg==
X-Forwarded-Encrypted: i=1; AKwUvBxtkv6SbHTNgL92Al+wWs58MmPRKTmSC1cjc0j+/0KjvOvLDonG8vcT8RiKEQbbWwyFVCsE9Gw0DC95@lists.infradead.org
X-Gm-Message-State: AFq9FYLPTbTM3txBptEsHjtQMznXWlc7kQueiLu9ima0XQq1/7hHunKi
	q8Mj9DsvnoJJYlCyXMn3QjhBKGZz8n3/1N3sUH2rtTPpDw93cz7j6gZL
X-Gm-Gg: AYBFou1Stnstg8Z/Y7QCig3nlN9RVFfXjqppWpaidf09fLnwLBgztLhzEfk12yDxdC8
	/mmEnbiHzhlt/16i1HUwF8vQMgPhAc/6wn3vepU8mcBqbkv0//C32Xs8rkoYgdoDj+MfDIlO0rI
	Y29fpQQWaRhNOj1pHLygYB7gR+Ek9jaPNt4vAr7zC2DVJiZ8olH1QgJuc5UVqooJsbRj5kwS3xT
	WHjda+iIvi34njZ7Zmt7dcIyllmSS5YlFJoHOxE/l6mgMcCxLAoHbxpSpxthxm6fVJLeskBVlpo
	4K/xaNkhxxSmGKLFD23LvvO0DMhsj01RWGglEANZd+Uqyb6emIFzLKI0jpUgkXy06+YynM3eFru
	nPTl/a5baJRv6z7BvGmsSFYf+vS+vvhcJK5ARyMsFgUmao70RAPr0iH2SFQE2zSjZZoafIapwPI
	o8iTlEdKCAHTrrQbP7Un8Xxvl6rx6vQS7TtY1qlwd06Va7e1qP9cBM5YRd7c+NJZlOXaZwavKrf
	La6yFQA67zTyypWUtKN9fQKjKDkMzU=
X-Received: by 2002:a05:600c:8208:b0:4a0:1b14:d00c with SMTP id 5b1f17b1804b1-4a18e446f55mr177700555e9.3.1791814383286;
        Mon, 12 Oct 2026 07:13:03 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:13:02 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/5] nvmet: pci-epf: report transport errors in command completions
Date: Mon, 12 Oct 2026 16:12:31 +0200
Message-ID: <20261012141239.156408-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012141239.156408-1-parri.andrea@gmail.com>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_071305_487486_C1104025 
X-CRM114-Status: GOOD (  13.32  )
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

When the PCI endpoint target fails a command itself, the host receives a
successful completion. This happens for a data length above MDTS,
malformed PRPs or SGLs, a buffer allocation failure, an SQ that is not
live, and a failed DMA of the command data. A write whose data cannot be
fetched from the host is thus reported as written, though nothing was
executed.

Each of these paths sets iod->status and calls
nvmet_pci_epf_complete_iod(), which then reloads iod->status from
iod->cqe.status. The nvmet core only fills that field when it completes
the request, which these paths never do, so it is still zero and
nvmet_pci_epf_cq_work() posts a success status to the host.

Drop the reload. Every path already sets iod->status before completion:
nvmet_pci_epf_queue_response() copies it from the request's CQE, and
the transport error paths set it themselves.

Found by code inspection. Build-tested only (x86_64, W=1): no PCI
endpoint hardware was available to run it.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/pci-epf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index c683450df4227..4c5fff232fb99 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1152,7 +1152,6 @@ static void nvmet_pci_epf_complete_iod(struct nvmet_pci_epf_iod *iod)
 	unsigned long flags;
 
 	/* Print an error message for failed commands, except AENs. */
-	iod->status = le16_to_cpu(iod->cqe.status) >> 1;
 	if (iod->status && iod->cmd.common.opcode != nvme_admin_async_event)
 		dev_err(iod->ctrl->dev,
 			"CQ[%d]: Command %s (0x%x) status 0x%0x\n",
-- 
2.53.0


