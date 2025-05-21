Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791D9C54EDA
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 22:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sio+V6cBojGrbSouaYLC1pCKV+UnLmFhRTgPGfKJ4KA=; b=BZfzdLDDABqMd/Yu3DbGOBNjjs
	MoXvtwfsA4fcOAgQ5T7UDv7fhaKoHNEAfVyriHbiou4ZCIWbOT8QWpzxFapaLvyp6SaWHFIFH3TN1
	ycdvHrlTXsVE/RoZuMiGH+99ZYVrJoC3KjuHvLW43AcY8JwwLjoqUWdiR/mZAx34DsLwIfP/FOfQD
	S7Mthcc8elTsCoQUaDfRMbcRg//nCKEawPGG50IBKO1MWq+pAido8cRqzILV3hKloEPyZWrqhCHfO
	u1u/EsN+PzAx15LMJwJzbL6YlIZMVD5Ar56D0AfDw5cvGa/W8HqextjTcuVO76yzasf4Jq9t1DgUk
	BTucprjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHry5-0000000Gvgb-2RCE;
	Wed, 21 May 2025 22:31:21 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHry3-0000000GveX-1vu0
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 22:31:20 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQXcg002432
	for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 15:31:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Sio+V6cBojGrbSouaYLC1pCKV+UnLmFhRTgPGfKJ4KA=; b=mVz0oXk/v522
	8IgduQj0CuwXf3ymOgiD3kYiNyObAM7RotjP9UImESEj1lAQ8J4AzV6eahcPzeQz
	bHsDTvlCxGxEAQ3hMUwd8MEmmVgUr2vY2kk4vY8WGiO1JR9ly/4FS/RX/jdoySl9
	ma1oypmUkVH9HB7pDyUkYBxggegVgZ6n+dRIAf40jyd5bFrnzAz3kRbdb3HYqQis
	afkDNv/Y0+lhGuo8vDEkTFg9Kbe23xrJxBDzQT14lnbSLFVIdAG3rNIzVrvAX6xR
	sbVy8yc4gNDMyHW0W/21O8UbU4SYL+2NkcoH+nt/85bjijHH2VoJHgRrF6WvlIOu
	y//hveFxJg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46rwfgkp1x-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 15:31:19 -0700 (PDT)
Received: from twshared24170.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:15 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D4CFD1BE54ACB; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5/5] nvmet: implement copy support for bdev backed target
Date: Wed, 21 May 2025 15:31:07 -0700
Message-ID: <20250521223107.709131-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
References: <20250521223107.709131-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6VFkFjt5blZjmlXz0dMDp1TKWDzDKq7Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfXzMeHZLPgeXbk y3seUt3p3ul1P1GQqEbYKttP+2f4x2ed51tVuSN5f/SDSYJ1pPblBF1zGcHDOVBkR3klJ46MSxR mfB79P07q4/wsxxZnEpjryfjKK7ygwIW4qcg/3yE+zMymIckhEjZlNOCvThdttanIgoWbHrp5X1
 oP+APOj16CRsZrmYKxYsIHQR4RHW/1ZR9FQokKcSmA1ETeEtG37T8hP9DEgh/4xArNuqk4uWacg RMTUXclXnoFiHa7Naff8xtx435Ns7ui/hSBhGK4jDdTXTgWUmTkrPUkMh1R4kACWrx58TMplcRW sn0TsASWEex4rd7t/yL3UEB7JRQfARvc9ihTIhvtFV6nCgWN4VxoVnFteLJPChsWGVvqELuUlx6
 RV7whnRZHljqwWyY2NVSougp49SpPYtwCcSiGDTYeWAwhr7xleZYtNDCQqNQ0FLDP7wfyVXJ
X-Authority-Analysis: v=2.4 cv=I9BlRMgg c=1 sm=1 tr=0 ts=682e5437 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pyVl64N4sFQ6-zCv_koA:9
X-Proofpoint-ORIG-GUID: 6VFkFjt5blZjmlXz0dMDp1TKWDzDKq7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_153119_504761_45C2FB01 
X-CRM114-Status: GOOD (  15.48  )
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

From: Keith Busch <kbusch@kernel.org>

The nvme block device target type does not have any particular limits on
copy commands, so all the settings are the protocol's max.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
index 83be0657e6df4..d90dedcd2352f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,11 @@ void nvmet_bdev_set_limits(struct block_device *bdev, =
struct nvme_id_ns *id)
 	id->npda =3D id->npdg;
 	/* NOWS =3D Namespace Optimal Write Size */
 	id->nows =3D to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev)=
);
+
+	/* Copy offload support */
+	id->mssrl =3D cpu_to_le16(U16_MAX);
+	id->mcl =3D cpu_to_le32(U32_MAX);
+	id->msrc =3D U8_MAX;
 }
=20
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
@@ -412,6 +417,50 @@ static void nvmet_bdev_execute_discard(struct nvmet_=
req *req)
 	}
 }
=20
+static void nvmet_bdev_execute_copy(struct nvmet_req *req)
+{
+	struct bio_vec *bv, fast_bv[UIO_FASTIOV];
+	struct nvme_copy_range range;
+	u64 dst_sector, slba;
+	u16 status, nlb, nr;
+	int ret, i;
+
+	nr =3D req->cmd->copy.nr_range + 1;
+	if (nr <=3D UIO_FASTIOV) {
+		bv =3D fast_bv;
+	} else {
+		bv =3D kmalloc_array(nr, sizeof(*bv), GFP_KERNEL);
+		if (!bv) {
+			status =3D NVME_SC_INTERNAL;
+			goto done;
+		}
+	}
+
+	for (i =3D 0; i < nr; i++) {
+		status =3D nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+				sizeof(range));
+		if (status)
+			goto done;
+
+		slba =3D le64_to_cpu(range.slba);
+		nlb =3D le16_to_cpu(range.nlb) + 1;
+		bv[i].bv_sector =3D nvmet_lba_to_sect(req->ns, slba);
+		bv[i].bv_sectors =3D nvmet_lba_to_sect(req->ns, nlb);
+	}
+
+	dst_sector =3D nvmet_lba_to_sect(req->ns, req->cmd->copy.sdlba);
+	ret =3D blkdev_copy_range(req->ns->bdev, dst_sector, bv, nr, GFP_KERNEL=
);
+	if (ret) {
+		req->error_slba =3D le64_to_cpu(dst_sector);
+		status =3D errno_to_nvme_status(req, ret);
+	} else
+		status =3D NVME_SC_SUCCESS;
+done:
+	nvmet_req_complete(req, status);
+	if (bv !=3D fast_bv)
+		kfree(bv);
+}
+
 static void nvmet_bdev_execute_dsm(struct nvmet_req *req)
 {
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
@@ -474,6 +523,9 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute =3D nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute =3D nvmet_bdev_execute_copy;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
--=20
2.47.1


