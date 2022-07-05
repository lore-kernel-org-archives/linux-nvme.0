Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1112FC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 21:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iijkGBmaOhCvHOqvNj9HaRrH7raez5sN6TpD3EPHDVk=; b=ITAMD9yqdoUzKNz5lvxIQg/v+K
	sTbJKQA/m/0eXZO4ZkuwqO2yWyB30BKsWVTA3+ZPQQxv85cdOjslLNtaB2gM/NJvBdkvQmIQZQZex
	AExv8s4V20NjiDQzkOTZ6cMLFXSIgqLsyqZSAk+PYCiIgNk9+3HsB0Jh7nIDgy83EGMdrI5MDOWB6
	4VDZr2E57dQ3skSquwMlSZbLq3Th6jZ95PVLCsaicfwQ9kYgeVuYY9YTdtsy2JQiOxgb0wjs4scyP
	l6Up1V58LOcAipoR3mCAJfRJXmalRT2UstB9Ji4Ozd0XcPGpu/YJmNg1fm2C1hFDNTNSv+a6hcGh7
	/CvUuvBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8pie-002oM5-Mb; Tue, 05 Jul 2022 21:04:28 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8pbG-002lKn-Rz
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 20:56:52 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265Jn628001452;
	Tue, 5 Jul 2022 20:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=iijkGBmaOhCvHOqvNj9HaRrH7raez5sN6TpD3EPHDVk=;
 b=N7BGy3xawmytxtzzDhLyygFxEKYpqeVg0MS8qfVB7sh3330z09Hhvls39wNKnmWC6dbE
 VEHJ7OEcK1mvid90EegXjKBpcwZ2vFWYnaQc+LUx2WIqv7k1m+PvACJoO41DoZSpcIg4
 IKjGXhPo219SsRdatwEKV3CA1UoMoWsowhOL+3YCZnI0DVsgTJXv4sXpNf819fg8lx1k
 mfnNcD/U59vqmaivEjKMeyBd+XU3vdSFZbYNYpWiLBC9xaj8aBj01yGrab6rKkNqEULb
 RpZhsq6BHG/MOP9NSpUFaxzIK1NCPl6quWtOxP/Ek/fpLuEgatCy8Bkib5H8mbVu+MSX JQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyr6ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Jul 2022 20:56:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265KpFkU006618;
	Tue, 5 Jul 2022 20:56:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud5hq3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Jul 2022 20:56:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 265KujJr018042;
	Tue, 5 Jul 2022 20:56:45 GMT
Received: from dhcp-10-159-234-206.vpn.oracle.com (dhcp-10-159-234-206.vpn.oracle.com [10.159.234.206])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud5hq3e-1;
	Tue, 05 Jul 2022 20:56:45 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        shinichiro.kawasaki@wdc.com
Subject: [PATCH] tests/nvme: Set clear_ids for passthru targets
Date: Tue,  5 Jul 2022 13:56:31 -0700
Message-Id: <20220705205632.1720-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: U4fo21Z7qDZSLbQ8NNhr63zNdIMFAXZZ
X-Proofpoint-GUID: U4fo21Z7qDZSLbQ8NNhr63zNdIMFAXZZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_135651_100095_E10DD1B8 
X-CRM114-Status: GOOD (  14.51  )
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

This allows to connect to passthru targets when the client and target
are on the same host.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4bebbc762cbb..5e50e69fb3f0 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -303,6 +303,9 @@ _create_nvmet_passthru() {
 
 	_test_dev_nvme_ctrl > "${passthru_path}/device_path"
 	echo 1 > "${passthru_path}/enable"
+	if [ -f "${passthru_path}/clear_ids" ]; then
+		echo 1 > "${passthru_path}/clear_ids"
+	fi
 }
 
 _remove_nvmet_passhtru() {
-- 
2.31.1


