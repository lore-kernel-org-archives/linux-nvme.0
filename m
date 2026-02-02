Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B32E73158
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E0ud7ThXoQ1OUCCOkesT07U968V60XKwMJwn7bYkahs=; b=P1ogqI1VaQ0DZwnrURTQrj9QW9
	X+Vyp1Ypdfs5aIIfyC+Aq8dOd6d9JI62ZFBTKw3vhUzLnHAiXSm+gNC152PneoqZtzc64EisCmtB9
	tOVgy/QCzR5B/O7rNjvgPStxdEoaOAtfI50x0wExJB1fHWvwsKw/1GzlKQL9eJwNv0IpjOJkEgVyS
	qiki84pAenGGG4NmgWBxYJETqinFDpB+XY2RcrpViwMHUbnhnTXhJ43qeD+vid6aVzRosSNG/vPS5
	O462gyRyY0v1duX3Fp8YggsVguzbjclN5r7Juv2FzM1D8mhI6bce49LfsuVSElHcov8s/pcXutTHH
	WSN2yuZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmtVF-00000004yhR-00YF;
	Mon, 02 Feb 2026 12:58:05 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmtVA-00000004yh4-3bdS
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 12:58:02 +0000
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612AtJS33915998
	for <linux-nvme@lists.infradead.org>; Mon, 2 Feb 2026 12:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=E0ud7ThXoQ1OUCCOkesT07U968V60XKwMJw
	n7bYkahs=; b=TzCJGdATRrr8wQEoye0kFXhknLDEChKovfMzF5mxoVYdSu3m2G3
	uHjQ2r6+xgsEI715h+Endmo3N4c34yfWdyJZngPXUhgbR9C0Lc4Lr62XtnEK4prq
	n5IldVHWNDjpnMv8TKsV51xDBfqF88jsRKjCc3EcLPXIVg6Xut2cqJ0TR6XFsq2X
	kcXbaBatgA0X79oKcvTOQZb41ogZurIVeTL+PVrj+VX0VfXAUmV1bIecZLoJ10mM
	H5haiVpURjiAldp0LPrnFLotD1OMcSfDwoNoaJql9kSE1UHgjd+EurRJX95mO/1O
	vxD+oVZkxiA6MILzMrBDVIGTr9UeTTTT7tg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tkmga3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 02 Feb 2026 12:57:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6366048135so3268668a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Feb 2026 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770037078; x=1770641878; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0ud7ThXoQ1OUCCOkesT07U968V60XKwMJwn7bYkahs=;
        b=fCsQth53/rWP4eaavcO21QLpEsw2UTKopo1GF7FsPkta8frnLdl3yKITGYDhNDk6h7
         DNZEl8TN9ygjpesLrsZTdbg1UF2ujfgJiftwVcb1jVfac0eBQwHUbHxBobHJj+XTYEXh
         oFSO8LeZcsVUvQ2t22XNeaaca2B3ah8MrtrEGfX7IsBz7248zD+5x95q/EtErKN8OM1R
         eVU3hJgLyxwJCMmIezKf03XBKlg4dtFVY0VY5gu+ws03cZsBNoDEwZwWXhfVPK3/S5NQ
         9kWsFDJfczU0xxM+GQlsNN3yY5VmHQpd5oS4xsLcihEx2qykqrsWD7qo6mhPGjDX47lA
         XctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770037078; x=1770641878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0ud7ThXoQ1OUCCOkesT07U968V60XKwMJwn7bYkahs=;
        b=ZY/WhSA7vH0kHRDPTCn1VYtFl0G1GMrGxV5KE0XSmZ9KJPvjXibkXVx+ilxpT5KjLF
         kh42SBHVRsa8UwbREgJ5T2OaycW1x18Y19QYJ+v0vcQ8+XaFgefRqYG9Swlw306u/AKA
         6ARtyztsrTHnqp+2vpii4PU47v8AbfMBRg7SxruNx4RFGoVZSRze8PlAKanwe7EkLpIQ
         etHxSvO64+1Be9FqHMGzA5bOXhnOX5pBbHm9UJAjGOE8jw4ubxIBrYv6nzKJlIGCA/s4
         cBsR8I+wI98podbEADDfHf/k59xbzBwxPESNUoZOgThb2ObOQncj5tg5Snh5Zs4bDG9g
         lERw==
X-Gm-Message-State: AOJu0Yxczsfzq61u98TQAIbK0WEs9ElL6d6U1aEpXE0yjLQp9qFKrpAS
	CBtf53sVyMP+Qlkwe2SCIKsYWVhie534Nh5fw+J+FKHwIsiwcyBbAW704fzM9RCPox5d0IIxyIY
	jM8aG1oEVmjTHBma0j0NKkboDSmgdc4IeRmceYeGWZz899hE9VQCizVXxHagv7ancQWqacQ==
X-Gm-Gg: AZuq6aJaVI/q45RJ4wx0AjUy4stHNV3sr0Xn2DUcOmQlCDvWAM3hl5o4VYrD1PHDJ67
	QUFDIA2zxk8nBW244oxmQeLiyh1OXqSvjHsZwKwcoaqwNfC7ydGI8WXOY/1LydRTbmXjROZvMy8
	9kZPM71H3rpsgHBlzu37z5zwSBNwGuIfFglFKM6lhf+JsmNJx9gnTXMANmkbs0IIism1TfM6JrX
	neQpjVn1dAsgT4gaedJSEpUpn4nxER+KBmcgrrLi9vAafDHVRMRxtVi5ORBBJmQYKDoMrPV3JUM
	Qy+f8nWcejRLe2+PlazETfc5+pS4aymlw8HhQZrnX+nCw3CAzW+aC+k/xa6NHloytjtobPBufm/
	u2NVBmE2oJv1oukBog6Pq7lKa/puGzfOpf8dQNuYdHvnib36hdKIc
X-Received: by 2002:a17:902:d4d1:b0:269:7840:de24 with SMTP id d9443c01a7336-2a8bd4f23cfmr128997385ad.21.1770037078240;
        Mon, 02 Feb 2026 04:57:58 -0800 (PST)
X-Received: by 2002:a17:902:d4d1:b0:269:7840:de24 with SMTP id d9443c01a7336-2a8bd4f23cfmr128997255ad.21.1770037077717;
        Mon, 02 Feb 2026 04:57:57 -0800 (PST)
Received: from hu-pragalla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b426ae4sm140852615ad.43.2026.02.02.04.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:57:57 -0800 (PST)
From: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nitin.rawat@oss.qualcomm.com,
        Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Subject: [PATCH V1] nvme-pci: Fix NULL pointer dereference in nvme_pci_prp_iter_next
Date: Mon,  2 Feb 2026 18:27:38 +0530
Message-Id: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TaebdBQh c=1 sm=1 tr=0 ts=69809f57 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4zosCYUxuotpryp6MGcA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 5QwN6rU5R6Ij1tMD6udWKz0uCPzl6bxx
X-Proofpoint-ORIG-GUID: 5QwN6rU5R6Ij1tMD6udWKz0uCPzl6bxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEwMSBTYWx0ZWRfXyM/bnn89Jw01
 fzFsqPokRAywtaT77ZUHA1km9k+IqKh4ITp4kBTPCnBgY1CNeo62Zo8K1Vwc74QLhxGRUhthDUE
 a8KbuXnpQ1+nOAfg62+aFukOec1C+W291v3MmWaOD0gKG4R5lfwiG1v0YgBM9DdX62ONPopYaU8
 Dc0O438GX5+94ZJBUFkcWFeu/yOtF9anugsv8juoy0cGDcS9n5P1g33+OdnUGuC+7j3P1YsCNo8
 9xB7hAgWQwu54QOXAhS36z55DmooE+t5u6eKaCRuZ7mkujZNaeWMCZpzKj6nQu3gomg7BRiCNPZ
 GnG/aL2izJlxj2fM8GiJY3y5RT6s2LM+anmTzr9tTiXZZx0vzXqAYCHZsp9QfYTQiXRcdaXmObK
 79NRUUujdkczylalhuiVBiQaRHMcCngcd1bnTqeXqxlgejTCIS8D6Ld66gtSbd+IRDqT/Nbp3DM
 gAbcX0eldymSm5DCQ4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_045801_090780_12418C1F 
X-CRM114-Status: GOOD (  17.44  )
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

Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
when SWIOTLB bounce buffering becomes active during runtime.

The issue occurs when SWIOTLB activation changes the device's DMA
mapping requirements at runtime, creating a mismatch between
iod->dma_vecs allocation and access logic.

The problem manifests when:
1. Device initially operates with dma_skip_sync=true
   (coherent DMA assumed)
2. First SWIOTLB mapping occurs due to DMA address limitations,
   memory encryption, or IOMMU bounce buffering requirements
3. SWIOTLB calls dma_reset_need_sync(), permanently setting
   dma_skip_sync=false
4. Subsequent I/Os now have dma_need_unmap()=true, requiring
   iod->dma_vecs

The issue arises from the timing of allocation versus access:
- nvme_pci_setup_data_prp() allocates iod->dma_vecs only when both
  (!dma_use_iova() && dma_need_unmap()) conditions are met
- nvme_pci_prp_iter_next() assumes iod->dma_vecs is valid whenever
  the same conditions are true, without NULL checking
- This creates a race where the device's DMA requirements change
  dynamically after the initial allocation decision, leading to NULL
  pointer access

  Unable to handle kernel NULL pointer dereference at
  virtual address 0000000000000000
  pc : nvme_pci_prp_iter_next+0xe4/0x128 [nvme]
  Call trace:
   nvme_pci_prp_iter_next+0xe4/0x128 [nvme]
   nvme_prep_rq+0x5f4/0xa6c [nvme]
   nvme_queue_rqs+0xa8/0x18c [nvme]
   blk_mq_dispatch_queue_requests.constprop.0+0x108/0x120
   blk_mq_flush_plug_list+0x8c/0x174
   __blk_flush_plug+0xe4/0x140
   blk_finish_plug+0x38/0x4c
   read_pages+0x184/0x288
   page_cache_ra_order+0x1e0/0x3a4
   filemap_fault+0x518/0xa90
   __do_fault+0x3c/0x22c
   __handle_mm_fault+0x10ec/0x19b8
   handle_mm_fault+0xb4/0x294

Fix this by:
1. Initialize iod->dma_vecs to NULL in nvme_prep_rq()
2. Add NULL pointer check before accessing iod->dma_vecs in
   nvme_pci_prp_iter_next()
3. Set iod->dma_vecs to NULL after freeing for defensive programming

Fixes: b8b7570a7ec8 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
Co-developed-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Signed-off-by: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a52cf46d960..e235654e7ee0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -720,6 +720,7 @@ static void nvme_free_prps(struct request *req, unsigned int attrs)
 		dma_unmap_phys(nvmeq->dev->dev, iod->dma_vecs[i].addr,
 			       iod->dma_vecs[i].len, rq_dma_dir(req), attrs);
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
+	iod->dma_vecs = NULL;
 }
 
 static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
@@ -825,7 +826,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		return true;
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
 		return false;
-	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
+	if (iod->dma_vecs && !dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
 		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
 		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
 		iod->nr_dma_vecs++;
@@ -1218,6 +1219,7 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	iod->nr_descriptors = 0;
 	iod->total_len = 0;
 	iod->meta_total_len = 0;
+	iod->dma_vecs = NULL;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
-- 
2.34.1


