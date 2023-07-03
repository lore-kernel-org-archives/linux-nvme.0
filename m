Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78A0C30654
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S3goOZqeuYoc0I9eekS0pLYTxfPF9T/RelhGiV7wzY8=; b=K57Wxkh2YjsKPvJGLv7kIjpNK4
	MfFalNQr7nqYA76qNtyBuhAZaBhdR5T6prpbIWhWbz3eqkoSl2Mfte0wnrC8pZszjSjtdpI0M3PQG
	D/IM+SBjNBArrHwLs9C1Oc3IUE00JrxGfpNE8lV7bMppTHlCA8D8MNt5VaOnacPvcha2gyKJrmD+R
	lDRyaZ/iJoPIY+ohOmfxfD2+QiyzQPb4eAuvEVWAMbq0Qzp+fTVzZcut35Rul7a0m+ZGvFjHNYMWn
	rQ1heWKFwXYtmhbvMkq+YiN3YBAa1e1wp/No+/VcFAGMyZAHHC1DINuUdArGAbH1MUKMBd2BCTPUL
	KukSftHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGOFN-00BCHx-2X;
	Mon, 03 Jul 2023 18:26:01 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGOFK-00BCGc-31
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 18:26:00 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G82oI025221;
	Mon, 3 Jul 2023 18:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=S3goOZqeuYoc0I9eekS0pLYTxfPF9T/RelhGiV7wzY8=;
 b=mNiJusU2lahRoPDyVnjeOiv6DgU9MtMz3ZUvBNrmwn1qhuEuXnvZqRkw5fOivPslCfRo
 k0VUsvyUw9CdtMdic0E+UtoTpVA5lWzH7qRBFWd2xvGT9K23ofwbzRvTJDEM5/hZmANt
 TF9qecVrzhNiHnXEL4ZORFaiMz748dcnLnUEJp36f4docJ0tDUyObzqeuDHsPS/YaB9q
 fy2dxcAE2Mnzo3bLo6LNIowE5ls44ckPB8AH4FlDje82jlpzIC9OkspltB4Di+hxvlld
 /DbnCf5BD0KTHq4k6FH+gjTDGcSpPzz1GRFEQwVOO+lTjSynRIaGFfuhJ02eZivBg3gY lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6ck8cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jul 2023 18:25:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363HARxB009061;
	Mon, 3 Jul 2023 18:25:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak9ddgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jul 2023 18:25:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363IPoQ7009914;
	Mon, 3 Jul 2023 18:25:50 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rjak9ddgd-1;
	Mon, 03 Jul 2023 18:25:50 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests] nvme/43: use a valid hostkey
Date: Mon,  3 Jul 2023 11:25:49 -0700
Message-Id: <20230703182549.971324-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030167
X-Proofpoint-GUID: RHqyIHjbvUVgadGBoUeLuKFB4qvb-R3V
X-Proofpoint-ORIG-GUID: RHqyIHjbvUVgadGBoUeLuKFB4qvb-R3V
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_112559_117791_D735C22A 
X-CRM114-Status: GOOD (  15.68  )
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

The test does not generate a hostkey and uses a NULL when setting
up and connecting to a target. The test passes, but a valid hotkey
should be used. This patch generates a valid hostkey and uses it
when setting up the target.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/043 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/nvme/043 b/tests/nvme/043
index a030884aa4ed..d498fd7ae885 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -39,6 +39,11 @@ test() {
 		return 1
 	fi
 	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ -z "$hostkey" ] ; then
+		echo "nvme gen-dhchap-key failed"
+		return 1
+	fi
 
 	_setup_nvmet
 
-- 
2.31.1


