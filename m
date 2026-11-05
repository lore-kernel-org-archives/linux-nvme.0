Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEA606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ibH47Eqf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HeG1pwhz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=4djbjbi1YPfL0yTh51RFEqcdY/dXJsBUTG3y/N5WRfE=; b=ibH47EqfawGnzLNFosgElC9U8/
	H3DBoX91zZMX84TcNzzIftMXqul3gSa/ZddvuKPh9dX8SvnBUk3myKxU/3bm+OJAKItVLFfvEqAvy
	dy26XhZjw37foqljWF+tUyy2U+Ddo/0mD+a4kpw9sWwct02IOEXMSruiDR2Y0kRWz9cB07N7CeA5z
	Dj42oWEh3VPoglBxkjk6tAh3/IofejEIrKKcT+j9/1gHeNeQQ+Y/erNl5tdI6LDO6idd15dX3Myz0
	25G3KvASRE63HoM1nusNznzMV6lx+BACNCKZiFmCZzfXLCiRbJDMiNHrdNO/AlCkV/GyqYL9Zk/+K
	s1O6g74Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxnC-00000009Ag8-3ZYk;
	Thu, 05 Nov 2026 13:46:14 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxnA-00000009Afh-0bjg
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 13:46:13 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-35c76e9614aso2478379eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 05:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793886371; x=1794491171; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4djbjbi1YPfL0yTh51RFEqcdY/dXJsBUTG3y/N5WRfE=;
        b=HeG1pwhzPVFx5WQg2nhyOVruO4vWYhSY377fMJD6eEx3EsSzNomAUzujX8QNxtb/PI
         HaECmMIm80wfIAOxDI/lGrMpiFWaHn1K0XCLAEMve2TJuWEyIE9GJtmKSz4LJ/qfULt7
         5ZPa7vtqkWqW3XsBuOSjNyzxHWb9G1MlWvDawnEQIdY/0K8xQRAq6oW94IBRtCro0XzF
         0L8Wk7CbctyW3dKRQRtCqJm/7PoecgO8BRat5HIiraxdFS18BFANuOWuxSlstvTQoy63
         9bg+s4B6d4zNKMqNCHA0M/RgqoA2ofSmr42NOAgcmBF+VTUGM3cjijvnh0mhECO+e/mW
         stdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793886371; x=1794491171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4djbjbi1YPfL0yTh51RFEqcdY/dXJsBUTG3y/N5WRfE=;
        b=nC5VlEFs/5W151J0Ane99DwUT8nqIY4p2z2Uhr8PIUl1nISK3DLyufHraxiue45z2f
         Rf9fPpzLlIWgc3gvF46y0LHnGmRTqVNaZLaOtU7d38YKoizZOxlaACzgrfpR6xj8/D40
         g+T8pGltbhddjbRH22atuTiJ0DDs2PzJON4VXcRRsBfGwAIyLGYUDmrJHF2n6EGjiZB/
         vR6ev7mfUtpM0FgUKjKVW47L1Hbqx9ZyKO71yEjKeHRQeEwZNDp6bip8KD1AVZywJI3j
         0nTqcRB4B3Vt1ndtkYiIKVWHDlJZKThkjN466saCpT9Cnb6bUu1I9MMWMfCW6M8i6o1D
         F2LA==
X-Gm-Message-State: APuU4Z+2qv4iwHZwBUJruS7zjTDYS51DQlQfnIpIk4EohBzrTFiR57qv
	rRKeYMZ0P8PYeBEHQUq69Z/QTDljSn4PUuC1hmCX9dOlklIsjLMIKZ+rPen+qW+Ncr4=
X-Gm-Gg: AYBFou3GUet9n8nWcesF26ZOqLDvL+Nc4zlG5u+koRHOS8tAjTlIvrd4MlmqlfOHQnv
	5+pPV8KnAV58dxh0CpOH79mwGNaBoFcfhCmsmtqpZPs9FKUvpd3ROs1VZK8ZdB0CJr00B4XV17o
	gvGS2326c+Mube4RPz6PTe8oF2DIDyjUnIlyr09c62RDiCCKPSYZTxiLkEKt8hxOCdQvAQU7Zb7
	Y7Dcawtiqgy+O7lxM1xsF4GM948YzDBJ6P0ex22ceoqz/tHtHNNMC0AY/DqNK86aPGVShewmbEk
	20KFTbHvAdlIrinaXqSwSs3JxBx8fBTJkEqGF3tQjDVcLMXGmtAkRjPjqSptW/uA7aj/vCvGd3n
	VkdhzVl4CtY9BEo/kOzEox0ofmD21O4uOc3eBSNectaod5x3+4m0j6sLj82g03mKLpOoRzjuHS7
	UsZLzP8me5wnxZ18eRxM678PiHxaNcMEtoQepeW+24LBq7M+JmGVpwinWhvTh5Rneyma5wfMa+2
	BNorkgnoIf++Ybd7V2Cq2CqcejvLdpwMsCeR0gTGrNqLl+8/V8aeNP9344G9wPldDAyj9bFW9wW
	BsZl1dcyP1/K3SXaQD2ffK1WdtlbAEBSwSCNJilE3s+nQEN+GcPnJdiclH0rG4njHaE=
X-Received: by 2002:a05:7300:1351:b0:36e:a321:5353 with SMTP id 5a478bee46e88-36ea3215cb4mr2389132eec.2.1793886370684;
        Thu, 05 Nov 2026 05:46:10 -0800 (PST)
Received: from ChanningdeMacBook-Pro ([240b:253:9800:600:bcd8:ac74:ffb9:55cd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3966daasm22454844eec.23.2026.11.05.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:46:10 -0800 (PST)
From: Chengyuan He <channinghey@gmail.com>
X-Google-Original-From: Chengyuan He <channing1ne@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org,
	Chengyuan He <channing1ne@gmail.com>
Subject: [PATCH] nvme-pci: add NO_NS_DESC_LIST quirk for SSSTC CL1 SSDs
Date: Thu,  5 Nov 2026 22:45:26 +0900
Message-ID: <20261105134526.95382-1-channing1ne@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_054612_184873_D60336FE 
X-CRM114-Status: GOOD (  14.03  )
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

The SSSTC CL1 series (PCI ID 1e95:9100, e.g. CL1-3D128-Q11, a Silicon
Motion SM2263XT based OEM drive shipped in Dell laptops) reports NVMe
version 1.3 but fails the Namespace Identification Descriptor list
(CNS 03h) with Invalid Field in Command:

  nvme nvme1: Identify Descriptors failed (nsid=1, status=0x2)

nvme_scan_ns() gives up on the namespace when nvme_identify_ns_descs()
fails, so no block device is created even though the controller is live
and namespace 1 is otherwise fully functional.

The failure was reproduced with the latest vendor firmware 22301119
(Dell package NJV53, A09) as well as with an older third-party firmware.
The drive reports an all-zero NGUID and EUI64, so skipping the
descriptor list loses no identifiers.

The generic Silicon Motion SM2263 entry (126f:2263) already carries
NVME_QUIRK_NO_NS_DESC_LIST. This drive reports 126f:2263 only as its
subsystem ID, so that entry does not match it.

Add NVME_QUIRK_NO_NS_DESC_LIST for 1e95:9100 as well.

Tested on 7.0.14 by booting with nvme.quirks=1e95:9100:no_ns_desc_list,
after which the namespace shows up and I/O works.

Signed-off-by: Chengyuan He <channing1ne@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index eade0b1..af19c75 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4282,6 +4282,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e95, 0x9100), /* SSSTC CL1 series */
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),

base-commit: c64d9b2c1f4fd1d8fa52dab37b48428a99c4d58d
--
2.54.0


