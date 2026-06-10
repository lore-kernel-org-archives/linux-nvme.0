Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2C4CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pfj1cZllVsuDijbywQAmDuv+aS3N6kGQ0AKYc85SBRI=; b=w5B3OB5/KcwwU8DpbTLNr0M9/D
	gq8Eyb48t60BZ5bnzfFFW5gueJSTLA6pgd5GHh1636p3lgovzQZk02CMbxJtH5AfccOLqI8ca7vGz
	qJIUoOvAGOTuuoRC9ESTuH1UrafhOHsPi5hSpqqbPq0xZNS+BQv/AB9Gtt+j72ZIeYgpLdx8uH6wV
	8hg5+qmIhR9FXYDUZGeVpfBZ7YWN7aho5SxIJZe+AF1A99T+9hBDCve3cVIIoPHg8/katnv16qrch
	ucjO5zjbC3uaNRv9f2tWRPWmP+XwmtIfLvtdhHU1Svgy+brvrYdnHT1dwVYiEX+K1/2CUlFCecpf6
	BdSrxXGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvA-00000007skM-1DY6;
	Wed, 10 Jun 2026 14:28:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv8-00000007sgC-1hwV
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:43 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A0PwsQ2535083;
	Wed, 10 Jun 2026 14:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Pfj1cZllVsuDijbyw
	QAmDuv+aS3N6kGQ0AKYc85SBRI=; b=hI2m7FmbDGmvCBHeyW5ENPLWOhbv1lrWV
	kx7nG1rnYmkU8Pd1E4I9b2+7BicCJOwg9heEJeZ6l2pae2wPDkN9k2CDdHUDncnw
	7fajfdAhWDjVreRbRzem64llXFb8+58q+aG0ViapfWUv7c62XETLx3iQiWVi7XQz
	hIu8EfusZDYUe265U2rq9OU2biHUPA7GYmzF0JkiMYOM2DI9SoJe0tOzsKMQaPz2
	a0p4fzlYXoNyCcBSt8a8d7yKW+7rBCmzLgQ2W8zOr9xrz+cidiR3GfHUjfyxbymc
	gjjhrCnRdaRtj/JKs0FtLYmJ48v6bD1BmYS1Ejq/814n3UwHJMTpA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj1bk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AE4edO009707;
	Wed, 10 Jun 2026 14:28:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w74f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESSAo30146976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEFFC20040;
	Wed, 10 Jun 2026 14:28:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82B8920049;
	Wed, 10 Jun 2026 14:28:26 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 08/15] nvme: add Clang context annotations for nvme_ctrl::ana_lock
Date: Wed, 10 Jun 2026 19:57:28 +0530
Message-ID: <20260610142743.115898-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX4EG042Ix0ntc
 EOurlrER5nmckR+3zA/VRlE3IScxUFaHIUIq+R4qacUf15F5DUnbHIpVOjeLI7vgG9jNAIN5gXC
 +l5Qr15gQpw45FfmdrpIT3d56CKjsc4AHpAQM+1b0w/WmbHyiIZ8tnu4EYhHprdAnWobbvp+b7y
 xXURHEna2MRW2WuFhle/glr/hxI8B6tYRV3543+PzBhhb+A4yrty1RyU1vEhKPeBXS7KjLnJ/61
 9lLzmqCB7+Oy9Rj5sP4xs1+MxNzSSHKM6yXJv9BjPsZJMCJ2JNP6NJhyhgVW3AZagryyvTftXZr
 GlUvbF1jwWLc83Yern4HieBQvD3B+92MqEo+ZdiAI+2v+Yg7g4McjIBz1Uh8g1kJa1KkJU0Ndir
 TF6eIV1O0uQDSSx4JbVASmEh0o7DrVOeA3d/rpFQH16f9q0A7C8UghOTPbl2t48RjbgoPOZC4j3
 rfnhU8wb7kHK6NmiXnQ==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a297491 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=dKw57NzDpq4Cn0Z9zg4A:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: FTo4om7hmdUhjtEDeSXff0CR2v1zyvIf
X-Proofpoint-GUID: PBYMWoaDiF3IP7MPVpaQpXvYOo1uQqzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072842_581006_366A80C8 
X-CRM114-Status: GOOD (  11.58  )
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

nvme_parse_ana_log() accesses ANA state protected by ctrl->ana_lock and
therefore requires callers to hold the lock.

Annotate nvme_parse_ana_log() with __must_hold(&ctrl->ana_lock) so that
Clang's lock context analysis can verify the locking requirement at
compile time.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 29e7e5178a5a..b12be93cc681 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -818,6 +818,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		int (*cb)(struct nvme_ctrl *ctrl, struct nvme_ana_group_desc *,
 			void *))
+		__must_hold(&ctrl->ana_lock)
 {
 	void *base = ctrl->ana_log_buf;
 	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
-- 
2.53.0


