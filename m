Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F1606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rGGADZ/q;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=bjMlux1F;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DkfJk9e3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vu7N8G6YmrfPxR9hmZwVbOMhfcjZ7oRYSphnThRsLBU=; b=rGGADZ/qWDXpZs
	L2Xc6IM50vv2tYsf/7ShATx4JN+VQwfc5MVxBIxyUWnyyg94DrrPcL6qfzKcEp9qhBU6quNG02Pbd
	yq6bLxj9ZztZAVkGdsTqua7kTWNaJi8SONam6cuib016inGGgSYY5pIzubxQ0K77CwsKCwvyv3PG4
	ZEXqUDtGunxkl2KHZ6oOXsgkO2VOkb5QBCp2Y4r+QcI3igKoDs7hdRTlwZWi93d5M+BKkOilzf6IS
	g6l1wLNP37ooIIwhbEt6X2K3ZnPGQPOYDRJs6p+iD6Fy61+A/QiBcjQLOeRZ+9/wve6H7Y64hsKYR
	5ZGFKRCza7eOzy2ibwZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDo-000000081DG-2yeq;
	Wed, 18 Nov 2026 07:36:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDl-000000081B5-1leB
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 07:36:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vu7N8G6YmrfPxR9hmZwVbOMhfcjZ7oRYSphnThRsLBU=; b=bjMlux1F/c2fxMEQ53nUW0AvwP
	3w5xuAVmlf/+YjjNzJsKWQieRYUSmxbKJ+iZRiXsMoEpTBZt+53wDqbg6qA9LpkmMd2WBjSmpumxT
	R5SFbj8qGquaaNHZdee0gHOWkrkEe895UvpK/g9EMYkr8iCZsdojOEFS3zogC1IO7hV1X7+NYyL/Q
	hUTdsyC0Xyz4VyWzlW76oSBGBa64Eu2IaZFVhx84CdByATyzjquoDKPa4NU7swjxzPh6fsF9UVzjm
	9GW0qS9NJRMSwiYHn4uHGFVnHPVa+CLBC/CvyporQnr7pTNXI8Wt5dcskHdiX+b34PsRxzhLcRy21
	zKMX+Gxg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDh-0000000FkD5-30ys
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:43 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2S0iu2431022;
	Wed, 18 Nov 2026 07:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vu7N8G6YmrfPxR9hm
	ZwVbOMhfcjZ7oRYSphnThRsLBU=; b=DkfJk9e37FrSKBT6xyBBQfPj2X6QJ+LkG
	gWB6g2M1V+MtRFIYMyiHRhxs45zC2FYfjZ/NvXk0pUp2cCIIXIRNduiCRsZEThyj
	rYcDGXdIrvwh2pe4FE/Aa2cPFOdsxHjFr24OJXILikldhfSsLojck3pRpVxRUQ+P
	dyYD81WKjA/BhZvFyi3vqPZtxztt3WcP5GAmJK4Y0/LhJB5DQD7vBGpjUkzyfkfQ
	veZ0tH/aqpafv8HV/zKLXPrb7l8yD4GCLlicbyE8fLnqMfo9/LDAWBevJBNa45qO
	UBlZYJLtcbD3p0Re7Mj+TonKwWalMoZ1TyOc1YoPcd0Qz09ffirlQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rhcrp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2YvoD2766485;
	Wed, 18 Nov 2026 07:36:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt7kua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7aLfk46530860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E09822004B;
	Wed, 18 Nov 2026 07:36:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D4A220040;
	Wed, 18 Nov 2026 07:36:17 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:16 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 07/22] nvmet: add context annotation for nvmet_ns::size
Date: Wed, 18 Nov 2026 13:04:48 +0530
Message-ID: <20261118073505.288910-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rKGX_wZB16yiDkwQEWU64bDMPy4ckfqw
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd557b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=KwJ8z0Xve6JmAVbpLWoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX23aJuJYEXSUa
 Maw/ezkqfYcUTMUWfPTUS63yQS1cP/lD/zs6RkfZ1uuc1YEfZ4K6IW5zB2oZiZqUy+MStEYd/KH
 xFq3Lw1Kdzi4RnwVMbkaQ6fy0TWOS1M=
X-Proofpoint-ORIG-GUID: cpsGWNmyODUnqJVE5TqabJq8OUCALdyg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX7fatKHOox3aV
 3gRjole5IYXJhBWeNk+uArfnLQi7DaAxU/oDxf2YIjMngAb+2auQpsbwvDKrHOjweloCRFGdNl7
 2oH7pIU9oLKc6uAk9Ds//CY2gZrsT14DmGW4eNh7HFkKDtaByEC16EIK98rGN+Q+NQy18jmCi1g
 j1Lv52dSguDcHeUkOVIzMjCWyTTgsg/7OrtpllJrWPmO0pKhV5+MbrDVFAFKJxhcH9exfLiAH1n
 Y8jYcQWVd2C3xsOGnkxNuuXMfEI4zgmCoJNwwSA2e8lxng5kNuFExkIellB8narw5fMCCl9Edfr
 hFFZtV/6Es0qlNm8U91Mxj9BJdiDRgEvUHHmE7p+tzDHugmq8GFEHM6Hmk6iJ5N0Eg2pWz/6G28
 1hHApo5kAFzAttIXlTrqeq6GOLw8xlklokcLEzXBlADGz5HBvCYtD2wIws0lkcGgO2Y5CZVA5ho
 Uqe5LdPQVNpbwXgnQtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073642_276649_ED87FD87 
X-CRM114-Status: GOOD (  19.54  )
X-Spam-Score: -0.7 (/)
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

The nvmet_ns::size field is protected by nvmet_subsys::lock. Annotate
it with __guarded_by(&subsys->lock) to allow the Clang context analyzer
to validate accesses to this field.

The I/O hotpath also accesses ns->size without holding subsys->lock.
Unlike ns->bdev, which cannot be updated while I/O is in flight due to
the namespace reference, ns->size can be modified concurrently by
nvmet_ns_revalidate_size_store() or nvmet_file_ns_revalidate().
Consequently, lockless reads may observe a transient value of ns->size,
which is acceptable for these access paths.

Introduce nvmet_ns_size() to perform these lockless reads using
data_race(READ_ONCE()) which would silence KCSAN splat as well as help
avoid clang context analyser warning. Use this accessor at the relevant
call sites where accessing ns->size without holding subsys->lock is
harmless despite concurrent updates.

Pair these lockless reads with WRITE_ONCE() for all updates to ns->size.
Also use READ_ONCE() in nvmet_ns_revalidate() when reading the old and
new size values to detect changes.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c   | 3 ++-
 drivers/nvme/target/core.c        | 4 ++--
 drivers/nvme/target/io-cmd-bdev.c | 4 ++--
 drivers/nvme/target/io-cmd-file.c | 7 ++++---
 drivers/nvme/target/nvmet.h       | 4 +++-
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 940ba0e14449..de47c64a2028 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -887,7 +887,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * that out from the underlying device.
 	 */
 	id->ncap = id->nsze =
-		cpu_to_le64(req->ns->size >> nvmet_ns_blksize_shift(req->ns));
+		cpu_to_le64(nvmet_ns_size(req->ns) >>
+				nvmet_ns_blksize_shift(req->ns));
 	switch (req->port->ana_state[req->ns->anagrpid]) {
 	case NVME_ANA_INACCESSIBLE:
 	case NVME_ANA_PERSISTENT_LOSS:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2c60210c14d6..b031595d8edb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -582,14 +582,14 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_subsys *subsys,
 
 bool nvmet_ns_revalidate(struct nvmet_ns *ns)
 {
-	loff_t oldsize = ns->size;
+	loff_t oldsize = READ_ONCE(ns->size);
 
 	if (ns->bdev)
 		nvmet_bdev_ns_revalidate(ns);
 	else
 		nvmet_file_ns_revalidate(ns);
 
-	return oldsize != ns->size;
+	return oldsize != READ_ONCE(ns->size);
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e950b442ffc6..0ed691387f1c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -115,7 +115,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 	ns->bdev = file_bdev(ns->bdev_file);
-	ns->size = bdev_nr_bytes(ns->bdev);
+	WRITE_ONCE(ns->size, bdev_nr_bytes(ns->bdev));
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
 
 	ns->pi_type = 0;
@@ -136,7 +136,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
 {
-	ns->size = bdev_nr_bytes(ns->bdev);
+	WRITE_ONCE(ns->size, bdev_nr_bytes(ns->bdev));
 }
 
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index e1e02f5f5efb..c87de131037d 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -15,7 +15,7 @@
 
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
-	ns->size = i_size_read(ns->file->f_mapping->host);
+	WRITE_ONCE(ns->size, i_size_read(ns->file->f_mapping->host));
 }
 
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
@@ -68,7 +68,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 err:
 	fput(ns->file);
 	ns->file = NULL;
-	ns->size = 0;
+	WRITE_ONCE(ns->size, 0);
 	ns->blksize_shift = 0;
 	return ret;
 }
@@ -123,7 +123,8 @@ static bool nvmet_file_check_lba_range(struct nvmet_req *req, u64 slba,
 	u64 pos64;
 
 	if (check_shl_overflow(slba, nvmet_ns_blksize_shift(req->ns), &pos64) ||
-	    pos64 > req->ns->size || len > req->ns->size - pos64)
+	    pos64 > nvmet_ns_size(req->ns) ||
+	    len > nvmet_ns_size(req->ns) - pos64)
 		return false;
 
 	*pos = pos64;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6204dcfb82dc..c90599afcdbd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -160,7 +160,8 @@ struct nvmet_ns {
 	u32			nsid;
 	u32			blksize_shift
 		__guarded_by(&subsys->lock);
-	loff_t			size;
+	loff_t			size
+		__guarded_by(&subsys->lock);
 	u8			nguid[16];
 	uuid_t			uuid;
 	u32			anagrpid;
@@ -222,6 +223,7 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		\
 }
 
 NVMET_NS_ACCESSOR_MARKED(bool, readonly)
+NVMET_NS_ACCESSOR_MARKED(loff_t, size)
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
 {
-- 
2.53.0


