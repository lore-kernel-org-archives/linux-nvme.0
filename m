Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53907606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aPHh/UHT;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jOQPDIxI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xqXuv0LLsf6muvjp1Hq/j82k4Px4V1VxcIAnnJTrH+w=; b=aPHh/UHT0ymzc6
	0xmPujY+oduap7P35SUOINMxwG6BskqbmG/wMvfs5r0GXlJQhcsgj7O3jevuFwBOvt598/FDtd86g
	Iw4Kkqa2HCdtbJYutfg/dmfxCKUBHCfY3r/CNxJfe9F4F/H6OyRuhSveY9KiO+V9gXq+rCunK7NAx
	4WoUk767zTJkg/1ZUhD0KoIv8oI+Q+5ZWViRYWmLVlaoLDDYOJK4nlNVKs4AaEiXt32LUX+sl71oc
	RV7Yub7Pq3rdPtcLJqRyIF9Tz5jb1AuGkOgjDCo6VYhStHZG4HQqdZAj+Myq1jAXZaKXfNqgltpQy
	XyyDtr2O8C79/igfIFqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEa-000000081ld-40bD;
	Wed, 18 Nov 2026 07:37:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEV-000000081i2-1I1C
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:37:35 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SHNV4045005;
	Wed, 18 Nov 2026 07:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xqXuv0LLsf6muvjp1
	Hq/j82k4Px4V1VxcIAnnJTrH+w=; b=jOQPDIxIHCIF93oLnqh/uwUngImo3llTK
	Rn3sRNFPAO7jJkhDYdHjpFvWnw4ec1t/2DbGZD1Ak1xzlJvgct+65nIDs38ZXs4Y
	Kzk0rCfNdUj/dNy4W2Tm3F2kB/LnfUH0msdw/hvSVxccG7psWQu3DEh3rmeQkZqX
	djN8VhMtEuRorEUPhEq3s6HBBquVQrK2bB8yAs93P+LvuUWf5I9t42b6NdH1Ci6T
	+gOpHTCMRtYmnWcifqLo3Gd3RB6LW8l4r+UzVMkTPYxBtKjyzF+SYe8+dVglyt2S
	OsSWh7Sq57A9+HT/+WHXb6Sg7DYJ9u1tDDyVhgrZIg6TTv0dJSRlQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wsb8v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI787xS1660684;
	Wed, 18 Nov 2026 07:37:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4r2bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7bG2u35193186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D028020040;
	Wed, 18 Nov 2026 07:37:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BD9720049;
	Wed, 18 Nov 2026 07:37:12 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:37:11 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 17/22] nvmet: add context annotation for PCI P2P parameters in struct nvmet_ns
Date: Wed, 18 Nov 2026 13:04:58 +0530
Message-ID: <20261118073505.288910-18-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 11xv538JxKaYW4CyiaE_uPApodTTbZWf
X-Proofpoint-GUID: zvkvwFwQrvG43U8r3_TEK5pkudx1g0Aj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX4YDzQsu5ZlU7
 3SUZO8Jna3eW/CT7vHDnhrgRIs7bEqjp+2E9PyEs7kZhBeHezq/No0ESb1ogQv9IO5xYSFHF8x5
 CcdDM6o7hncqRX+mERjR4jayNotcTbmBegQuZHexCOCbacm2UgsN3U0VfXFAp9VYz2RbMK+X6u1
 h27rRp5awtNZwNpRjSe7iy/6Keh1LP2COsxQ67BD4LwMwMRUcR7VzD/i1jlu1ReA+EHQnji5apc
 7ED9YISgqd8YnhKZTHHike5s3a+/WQbHt3ZpastWmx2nGScmgxoQCh9V5svJCyDQyBi/wvoFu96
 wCXwXX90ZERiO3+/IbWHdaAGV4f7e1dHckcFv+rJwEIPW/GKlMZvt1ltTsHf8KACDfwjtgkJUf4
 dL+tR9Cho/X68mxStuzwCdl+zO6qYqKL99EhbZi+chweWxZMClG0uN2hft1dGS8gKtePHDtMXj2
 hPJQQY5a4fI0Re5j1Lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXwa7qYEmmijSg
 6uVRd6hhJPAvZfDkcr1fTbUiSJdp4TOpL0MOpGorej6OoEipgKw85ZYgfGPP1RqpOvQyzgLw0ZM
 xckOUbh2nYF6/ul4MnisGh5hUaN/GFU=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd55b3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YeBxuRm8RaLLF98ZCrQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233734_172829_41A4800D 
X-CRM114-Status: GOOD (  13.30  )
X-Spam-Score: -2.6 (--)
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

nvmet_ns::p2p_dev and nvmet_ns::use_p2pmem are protected by
nvmet_subsys::lock. Annotate it with __guarded_by(&subsys->lock) so
that the clang context analyzer can validate accesses to this field.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/nvmet.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index db5d5a3fec3d..08cf6364c4a6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -184,8 +184,10 @@ struct nvmet_ns {
 	struct completion	disable_done;
 	mempool_t		*bvec_pool;
 
-	struct pci_dev		*p2p_dev;
-	int			use_p2pmem;
+	struct pci_dev		*p2p_dev
+		__guarded_by(&subsys->lock);
+	int			use_p2pmem
+		__guarded_by(&subsys->lock);
 	int			pi_type;
 	int			metadata_size;
 	u8			csi;
-- 
2.53.0


