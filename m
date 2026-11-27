Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87C606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ygq+ijyE;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=iokpp.de header.i=@iokpp.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ZTzi8pr/;
	dkim=fail reason="signature verification failed" header.d=iokpp.de header.i=@iokpp.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=IZXSNo3y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=BkMGJDVdvhpFFgwdJXmVR7eGKmkzsgvJ1AWDdMVB5PI=; b=ygq+ijyEM2iFwNj/bGSZGYeNBU
	OtEgJfaMIEcgK+pLkfdQ3tiKR0DuI1KoYaLtnd2t3Xi/wWf1tyhNqzvtRShkea+Bt65QT8bzLN/gw
	d3QaVLR5ow0OWzXvJuZHZAUgqMQKHR11pSVoxRFBM1szCIl9mCo7fGfxCu3bZq9GC5pZfE5J8uMKD
	r8f9oYxHEQa9zNtRsoCIsYi1G0OA9rrcVuFzX8SqyZl7tEmh+N6aBy0zzb5CNAbfy6WGDUVLZmdhI
	RuE9Ga7dJ9L+chOb5s5KD/uh/qJmJ2G/fm1XuD+XW7xlNV4HxfF/HSXlKprt86joyy3BTs5Ypj/t2
	Ialer6wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWw7O-0000000GHq7-0005;
	Fri, 27 Nov 2026 13:36:02 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWw7L-0000000GHpd-0g7t
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 13:36:00 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1795786545; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RqOEpUxygGc0CxbfE5kpPJuptPmJS0P76yOFc8tIq64S+sVU13P++SbJFORMIaeePC
    50vVMCFg59Siw/gSpgIti+J/a8Onfkjmh8R0nEyv/rXHIcUPES/JltM4omp6Pk8qT3e3
    kllIvHLgokg8ubFCiCtVZ6D+66Msap3G6q8tMdgh+YhgL+fLq1q2Yfm4Qha2WoKfWjHZ
    knUDxzUSxvtkj4+7OOU9rTv9+GBwd1jenHRuvo4xXjnfzL/J5QBwwxuxXFYKwlM5St2r
    ZeBNeWeoTwxxWquJiOrlovhcbV1y6WzN0L8rJayfbQNDDboPhgDyqG44NdxOzN2s1VxA
    dETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795786545;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=BkMGJDVdvhpFFgwdJXmVR7eGKmkzsgvJ1AWDdMVB5PI=;
    b=j412NGkrg/7K+s6jp+hz9IOZe5jWe0I118B3CgANvQ+r3md7R2dr5Ay6xyTfo4EYNh
    1QKWafZV+n0ApCk52vRyP/NnMrgTIBXutJ4EoS5a5CGfih/ViIfKRbGhRHpP9mWOoTom
    oMe1X/aHzf5A0AGXhoMg0znT5BuJs5+4e9iKHiQRdAsMvG9ijG+TTYG5GIgJnQR1vwDN
    Mic8NbriLPP23iNkw0D++Y0Txrgf6DZD+m1E0zqL7dqQjajNmv5Oarfp+1sqddin28Km
    0CEuMzrFCAg1wCExLKEgCaimX/sjmh7MI8furOUhTU7E/HWXZ91Z4/vu0ZiN25qkvy3U
    TcjA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795786545;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=BkMGJDVdvhpFFgwdJXmVR7eGKmkzsgvJ1AWDdMVB5PI=;
    b=ZTzi8pr/JWWu9Tpr65dc3yJk2ZUu4qhNrlaEWBtTypobcGee2tBOGOEYBuJbR34nBz
    8rR/0F/MURWhRJdfPPvbsSXnq9dMbGH7U6s8eqoM9GfuSoPv8/AuY9PENB1JPgqOhPAx
    knqrtWiA+bsA9WAVi/wLwPwvswAmY9HQKGBOq8+aBsk/gkUUbAc797QymV0aAMvgBd6P
    V7TZ9C4RTH7cllmeYDKdSPu/Imp9T6xoF9SczdgO/VJ5QD63M7jTGuE+1UWTVS2NCxLF
    ewlT9Zfq+IIwoZBbAAOo0JISW4kp5IKxCHsJA73VU8U7q/x/KnXbzgjAZ15aH87qEkYt
    djXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795786545;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=BkMGJDVdvhpFFgwdJXmVR7eGKmkzsgvJ1AWDdMVB5PI=;
    b=IZXSNo3y9nBQpx5C92OqhoRx1Jau/4EI/aUGBt9VIFGelAtVCit41SCFdQd+1Gl2Cq
    wSmrFC+PQOs6ERH5KkDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RP16IHIsTHDi0QkbKpF63TZwX+VkuiidfpZL2w="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id z831ad2ARDZiiK7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 27 Nov 2026 14:35:44 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Bean Huo <beanhuo@micron.com>,
	Gaurav Sinha <gsinha@micron.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_APST_BUF_512 for Micron 2100AI/AT
Date: Fri, 27 Nov 2026 14:35:38 +0100
Message-Id: <20261127133538.3032289-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_053559_489642_8392BD3B 
X-CRM114-Status: GOOD (  20.23  )
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bean Huo <beanhuo@micron.com>

The APST table is 256 bytes and nvme_configure_apst() allocates exactly
that much, so the table can be the last 256 bytes of a page.

The Micron 2100AI/AT (PCI 1344:6001) reads the data for this command
in one 512 byte unit. When the table ends a page, the read reaches into
the next page, and with an IOMMU enabled this can be reported as a
fault. The command itself still completes.

Add NVME_QUIRK_APST_BUF_512 for this device. With the quirk, allocate
and map 512 zeroed bytes. kmalloc aligns a power-of-two size to that
size, so the buffer never crosses a page. PRPs carry no length, so the
command is unchanged.

The table format and the APST policy do not change. While here, use
the product name in the comment of this PCI entry.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Gaurav Sinha <gsinha@micron.com>
---
Note: this only changes the APST command that the driver sends from
nvme_configure_apst(). Userspace cannot send this command since commit
1161be71d1ec ("nvme: reject passthrough of driver-managed Set
Features"). nvmet passthru can still send it, and is not changed.

 drivers/nvme/host/core.c | 14 ++++++++++++--
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  5 +++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f43582e5f6c4..6f351757e909 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2972,6 +2972,7 @@ static bool nvme_apst_get_transition_time(u64 total_latency,
 static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 {
 	struct nvme_feat_auto_pst *table;
+	size_t len = sizeof(*table);
 	unsigned apste = 0;
 	u64 max_lat_us = 0;
 	__le64 target = 0;
@@ -2992,7 +2993,16 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 		return 0;
 	}
 
-	table = kzalloc_obj(*table);
+	/*
+	 * Some controllers fetch 512 bytes for the 256 byte table.  Give them
+	 * a zeroed 512 byte buffer.  kmalloc aligns a power-of-two size to
+	 * that size, so the buffer never crosses a page and the extra fetch
+	 * stays inside it.
+	 */
+	if (ctrl->quirks & NVME_QUIRK_APST_BUF_512)
+		len = 512;
+
+	table = kzalloc(len, GFP_KERNEL);
 	if (!table)
 		return 0;
 
@@ -3067,7 +3077,7 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 
 done:
 	ret = nvme_set_features(ctrl, NVME_FEAT_AUTO_PST, apste,
-				table, sizeof(*table), NULL);
+				table, len, NULL);
 	if (ret)
 		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
 	kfree(table);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2543e52d6358..ae195f28d3ed 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -198,6 +198,11 @@ enum nvme_quirks {
 	 * do not advertise FUA so the block layer emulates it.
 	 */
 	NVME_QUIRK_NO_FUA			= (1 << 24),
+
+	/*
+	 * The controller fetches 512 bytes for the 256 byte APST table
+	 */
+	NVME_QUIRK_APST_BUF_512			= (1 << 25),
 };
 
 static inline char *nvme_quirk_name(enum nvme_quirks q)
@@ -253,6 +258,8 @@ static inline char *nvme_quirk_name(enum nvme_quirks q)
 		return "admin_page_align";
 	case NVME_QUIRK_NO_FUA:
 		return "no_fua";
+	case NVME_QUIRK_APST_BUF_512:
+		return "apst_buf_512";
 	}
 
 	return "unknown";
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 076603df01ab..0b7f69d73f3b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4416,8 +4416,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	 { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
-	 { PCI_DEVICE(0x1344, 0x6001),   /* Micron Nitro NVMe */
-		 .driver_data = NVME_QUIRK_BOGUS_NID, },
+	 { PCI_DEVICE(0x1344, 0x6001),   /* Micron 2100AI/AT NVMe SSD */
+		 .driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_APST_BUF_512, },
 	{ PCI_DEVICE(0x1344, 0x6004),	/* Micron 4100AT */
 		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x1e0f, 0x0032),	/* KIOXIA XG10d */

