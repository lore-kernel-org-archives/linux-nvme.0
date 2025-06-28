Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C119C54ED1
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Jun 2025 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L+3Ml7MGMvKIhp7iPbG5EBDt2Nn9VyKSNRG0no/ATvI=; b=Sjw2wO+CdjkHiN2t/Oebvl/or/
	VCOE0hjLVycpyMD+eb7CqJH2Abio1IcAT2fn9iV9owUosIQT0nMfNq13fLwXRT5axnMyhRrQ489zG
	h0eN1o6ZAL2lDinbCYP+jjiehah7RZhsD5SH6LXsufaY8cWMlZFd9WKdgN/7Q+/B5Ftnd94JFxgVI
	qsR80bm2egVvgbfLqYurkMvyVGTwlaZPZNzX0h5Y0RPsWtZRW61hHMmmu9VAwflGZIn3JLGFtw1Yz
	FXPTx+tBumxPx/j6cuRsxsPxISu/YC1QaArrKs63pwDKrp/a0v8GEAcwYgudokXanzuLI3mdgrvgb
	ov6iIfmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVa3X-0000000HBli-3yeh;
	Sat, 28 Jun 2025 18:13:39 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVa2o-0000000HBik-1IsD
	for linux-nvme@lists.infradead.org;
	Sat, 28 Jun 2025 18:12:55 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55SHJURv017534;
	Sat, 28 Jun 2025 18:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=L+3Ml7MGMvKIhp7iPbG5EBDt2Nn9V
	yKSNRG0no/ATvI=; b=nMlefoxdOJjxvoSgVov+mpb9MO3drxho/Buj6OKQ/+9u0
	+UlTyndICv2ckFuWi3Y2EFRTjKtbzMXdP8UeRGa5aRmueulni2kIdkJxGpTX2Lc2
	3RFbSV22y2lZQhSoh/rYZgdAXtaKXwQs/1vXTqaxwp27toQRmBsGNKrq+NOixNq1
	YJoTXOe24drIyLg8SOvwEtou1muuX+KcgMVK2ONsEzKRecprvNEKNW8e7iPQ72gL
	Nm+Kn6tleCA2HaiD2ETlYNrwMliiiUapI+/JKmNG34K/+xUXzKyc6MhtT498p6fT
	0u0rI69gWhTyppxDhMZJzsHSLpqbEP7vmQxUfJN3w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tf8f4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 18:12:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55SI9KAp028997;
	Sat, 28 Jun 2025 18:12:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u6ysqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 18:12:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55SI6MIm010792;
	Sat, 28 Jun 2025 18:12:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47j6u6ysqh-1;
	Sat, 28 Jun 2025 18:12:36 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH RESEND] nvme: Fix incorrect cdw15 value in passthru error logging
Date: Sat, 28 Jun 2025 11:12:32 -0700
Message-ID: <20250628181234.3978844-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506280152
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=68603096 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=AeMM1KqErxL4ncdj0kYA:9
X-Proofpoint-GUID: W_q7wwMP59uDsSMHsfdD9MRpvRaGL7Mr
X-Proofpoint-ORIG-GUID: W_q7wwMP59uDsSMHsfdD9MRpvRaGL7Mr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDE1MiBTYWx0ZWRfX2kjbMkP1/PcF 4irX/vCShlxU+dNmdA6szhO06UC8fbN2O1LIVD6aAdkvFPqGdct1xkzuyg6uhQzaNQDgiPQ7Ln3 DUTkvLn10ps4boUscF91/DS+WRXv7wOmQhT9+EN1B9qgZMkvf1PDIcu5vexpXT3MiU+3y1aTuq8
 9gdlVlG0cQqgoCFdP0gXtMurthw081ETcQxpzURshgLGOIF2YFYXG4oTJnakoT65tc6cnSWkPCA 6ZZazigxQbMzjfBvcwBIWtI72pslCKk60R+GDxvqqh2x7pi74z0dkI+ede/1m/je9/84Sm4NlrW NuM7ZWTMkQQs/8DCAcdXte/K0txd5VQcBrg3Yodfylx+PqufulsxL4TIhDOMyhA0B8i2sM7ENbm
 VKO74Adc5iPHEQcFt4i1Ne/tZV2BgZdyc/2at3g67XwjSjtDfTyiLGEsaqMfnrdIvO//9GkJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250628_111254_781525_6C10B327 
X-CRM114-Status: GOOD (  11.91  )
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

Fix an error in nvme_log_err_passthru() where cdw14 was incorrectly
printed twice instead of cdw15. This fix ensures accurate logging of
the full passthrough command payload.

Fixes: 9f079dda1433 ("nvme: allow passthru cmd error logging")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
Corrected Christoph Hellwig's email ID
added Reviewed-by  Martin K. Petersen
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e533d791955d..2ae36bce615e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -386,7 +386,7 @@ static void nvme_log_err_passthru(struct request *req)
 		nr->cmd->common.cdw12,
 		nr->cmd->common.cdw13,
 		nr->cmd->common.cdw14,
-		nr->cmd->common.cdw14);
+		nr->cmd->common.cdw15);
 }
 
 enum nvme_disposition {
-- 
2.47.1


