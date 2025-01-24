Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A112C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YipXsoNbJAtqYyVp6VRH4yyOTYcAMW9lzgNAc8k++qI=; b=OpfGCqm7mKksDbwEzm1/SW4DfL
	orz2pjUhBHq3WTQsNQZEM80GfZycqu7otgVcksQDv5b5W9bcpLxRwSi99/KlQHhrtkgE9jq9WlbsZ
	DATh4rFYaY5/lfZQTdeJEGenXqcX3yEX2tNg1oxXqNhJ0FtkiMSg+qRKx4mXkE6CStrl4rnRslo71
	mXcsIzwAQzv+e0+wssI5Dka6efZjlKlIVQlB7hyJ/2JKQj6zpsEluns/FXadnfKOWbt8ii/nsCkIS
	PtU8ktxZyW1/FtwPS6g6SKomGEPnJuUFaqTN6OFLEvTEtWXrzvb7TJbNYLbH/KyBuwHKI6PG4vcKR
	WA6n20Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbEQ6-0000000EAIW-3NmP;
	Fri, 24 Jan 2025 07:48:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbEQ3-0000000EAIC-2hZ9
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 07:48:00 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7WkkV021218;
	Fri, 24 Jan 2025 07:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YipXsoNbJAtqYyVp6VRH4yyOTYcAMW9lzgNAc8k++
	qI=; b=aUWuaCvmd4qpYm3FSzfTarp/J4nCB55GrTOmgEmCF6c16brH4afMZmZ+4
	AtwWoKpxR+w0UNpDHI6yWfVV9Apyyz8U5CCBmgVCfdDxAnRyKTSM7uN5YBgyasxF
	YAlmJ7SMAH3mtBSGEkN+RHzsQXsaL1VOp8eQRyvtMiKKWGOMcQCiFt17FpOkDIxs
	BrnVPSCqQEigd7iid0Er/FJf+NrjxjGnvwlq1UtTSAF6McK8oEerTLNybv0Rr8hK
	fzZgCaQjJ8HEQI1TRrNeyaxdCRhFGbfm0Ox3BCMtTiGjHDDZ1VqUKtqyiFzr8Cut
	wexyHzjFfIZv0SKfPM1XjqiH/CkEQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jng1kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 07:47:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50O5HpHJ029604;
	Fri, 24 Jan 2025 07:47:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmntda2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 07:47:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50O7lt9o49283388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 07:47:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B14AB2004D;
	Fri, 24 Jan 2025 07:47:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C2372004E;
	Fri, 24 Jan 2025 07:47:54 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.53.174])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 07:47:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, hare@suse.de, gjoyce@ibm.com
Subject: [PATCHv2 blktests] nvme/058: detach loop device after test finish
Date: Fri, 24 Jan 2025 13:17:29 +0530
Message-ID: <20250124074753.9802-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DpgLwCjwG97Sob-K2FSb1DwO3cUVQ-gK
X-Proofpoint-ORIG-GUID: DpgLwCjwG97Sob-K2FSb1DwO3cUVQ-gK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=702 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_234759_794752_BDA4C84B 
X-CRM114-Status: GOOD (  13.08  )
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

The nvme/058 creates three (temp file backed) namespaces and
attach each namespace to a loop device while starting the test.
However it never detach those namespaces from the loop device
once test finishes. Ideally, we should detach loop device from
namespace so that the associated loop device is later destroyed
and its resources are released. This patch helps detach each
namespace from its associated loop device after test finishes.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
    - keep blkdevs, which are used for setting up ns, in an array
      and then later access the array to free/detach each blkdev
      (Shinichiro Kawasaki)
    - use longer option name instead of short name for readability
      (Shinichiro Kawasaki)
---
 tests/nvme/058 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/nvme/058 b/tests/nvme/058
index d230a21..815503f 100755
--- a/tests/nvme/058
+++ b/tests/nvme/058
@@ -65,11 +65,13 @@ test() {
 	for ((d = 1; d <= num_namespaces; d++)); do
 		local file_path
 		local blkdev
+		local -a blkdevs
 		local uuid
 
 		file_path="${TMPDIR}/img${d}"
 		truncate -s "${NVME_IMG_SIZE}" "${file_path}"
 		blkdev="$(losetup -f --show "${file_path}")"
+		blkdevs+=("$blkdev")
 		uuid="$(uuidgen)"
 		_create_nvmet_ns --nsid "${d}" --blkdev "${blkdev}" \
 				 --uuid "${uuid}" --grpid "${d}" > /dev/null
@@ -99,6 +101,11 @@ test() {
 	done
 
 	_nvme_disconnect_subsys
+
+	for blkdev in "${blkdevs[@]}"; do
+		losetup --detach "$blkdev"
+	done
+
 	_nvmet_target_cleanup
 
 	echo "Test complete"
-- 
2.47.1


