Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C56D3A678
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1dbtQAeD0iePlfKD3yxWUWqgeSMIvmMv0CUHvF3cEGM=; b=Nxr20J3zN9JnHXll7Gb7aMvyxU
	/HEQ/14A4CaWhQRAkMV7yUETbMKbtj5T30gdUhXEfEDvx8Dv8kg8u/4Gql4DCHsl0R33mQ1XQR8m1
	xSedppklNhn7rVIvUJxhK4wUGlJkzwOunFWMjAB1esLkMQnO405fdQ8zRYcek4rDXFLg3G9YTyQ4n
	DU8pyJdCX/6h9I4YEP9C4MWyvNWjI5kBgD+KoeJ+RqWJP3Cd9s0erRMpbxsd+gn4M3sp80Lan1uyu
	t5bj7XZHWZ3ZE6Jfu0HR1hjueX/qoZffzZNg7ihxclraPB9iW5RxFDQ2iv5mbxFcoyZW12tEtV2+n
	w2Gu75rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qQ6-0000000FOyM-1hSy;
	Tue, 29 Oct 2024 17:54:18 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pws-0000000FF0K-2hhN
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:24:08 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241029172404epoutp03620f88de419ef352ff4190c66260ea29~C-FQIAz763208532085epoutp03Q
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 17:24:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241029172404epoutp03620f88de419ef352ff4190c66260ea29~C-FQIAz763208532085epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730222644;
	bh=1dbtQAeD0iePlfKD3yxWUWqgeSMIvmMv0CUHvF3cEGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQfyaWt5QR8k3fv5ogj6/an6walPzCAHRoGuXWVeCN0NOEqblHl4eeX0Yz/EnsPyE
	 NWhSGRADdDmFage7kZnEVqngolVSFOgymohhLPWZwDUe6GjmOB7yoSuvOhMs8lUOWq
	 1awnOui8XMpYGmH+tV3r7ElQCbMchWQ4xJ97cNDc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241029172403epcas5p3e118afcce8ac877e372e8c257bfd9c69~C-FPN9CyA0894708947epcas5p3s;
	Tue, 29 Oct 2024 17:24:03 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XdHDL4R9rz4x9Pp; Tue, 29 Oct
	2024 17:24:02 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9D.7A.18935.23A11276; Wed, 30 Oct 2024 02:24:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241029163230epcas5p18172a7e54687e454e4ecb65840810c4e~C_YOm1YX-2993629936epcas5p1r;
	Tue, 29 Oct 2024 16:32:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241029163230epsmtrp2df03d4cb640586cc2c056461a4be9506~C_YOjdbyZ1621316213epsmtrp2J;
	Tue, 29 Oct 2024 16:32:30 +0000 (GMT)
X-AuditID: b6c32a50-cb1f8700000049f7-d9-67211a32078b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.07.08227.E1E01276; Wed, 30 Oct 2024 01:32:30 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029163228epsmtip2eb473021666d8b3baa91fd6557a9a56d~C_YMIvhm01387713877epsmtip2F;
	Tue, 29 Oct 2024 16:32:27 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, Anuj
	Gupta <anuj20.g@samsung.com>
Subject: [PATCH v5 08/10] nvme: add support for passing on the application
 tag
Date: Tue, 29 Oct 2024 21:54:00 +0530
Message-Id: <20241029162402.21400-9-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029162402.21400-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc98r/cEoebaYXZsp9S1mKQtIWeleiTg30Lwome26ZRtxgRf6
	UgjltesPcW5jBFYMvwTxJ235FRcNJWMOKgEtBAuIVYGpmUwUNgidCyAGcGBG0LW0bP73Oed8
	z/3mnHsvFxVMsEXcHMZMGxlKh7PDWR19Eklsgmi7Nr59IJpY+HuVRRRVr6GEw9kBiJbxKjYx
	27cIiAe9XQjR3DKAEPPWYRZhP1uMEAMvn7CJGs99QHSPvU24u70souGCj0OUj3ayiYuDLxBi
	ZG0wjBixOTh7BGSXbZxD3huykG3OUjbZ/sN35NUHhWxywTfGIo+7nIC83djPIZfatpFt008Q
	ZXh67q5smtLQRjHNZOk1OYw2GT+gzkjJSJTHS2OlCuJdXMxQeXQynpqmjN2Xo/PPhIsPUzqL
	P6WkTCZ85+5dRr3FTIuz9SZzMk4bNDqDzBBnovJMFkYbx9DmJGl8fEKiX5iZmz3kOmQoee3I
	lZe1SCFw8MoAjwsxGbzrrQsrA+FcAeYGsHnVhgSDRQAX+0ZClWUAG+YqOBstv99xcIKFbgA7
	rj1cLwiwJQB9544GmI29BfsfW0FAFBU4t7LpFisQoFg1AhvPutCASogp4a26q+vMwnZA6/kp
	JMB8TAEbLrnZQbtoWHt3Zd2BhyXB6wPukGYT9NZOswKM+jXFl+1owABiv3Hh5ZrWsGBzKlwr
	fYoEWQhnBl2hGURwab47ZKCFz+/5QhoDLL7eA4L8HrTerPIfyvUbSOBPV3YG01vh6ZutSNA3
	ElauToda+bCzfoNxeKzZEWIIu4cLQ0zCiubi0LYqAWw/nl8NxLZXxrG9Mo7tf+dGgDqBiDaY
	8rR0VqJBGsvQ+f9dc5Y+rw2sP/QYZSdoubQW5wEIF3gA5KJ4FL/li61aAV9DfXWUNuozjBYd
	bfKARP/CT6CizVl6/09hzBlSmSJeJpfLZYp35FL8df6stU4jwLSUmc6laQNt3OhDuDxRISKJ
	aN89fUDoyPCm966E931zsD5T+KjAlfJo39CR7xF0PPWzugt7+U2lvM03Wj9Ja2e+jJqMnIiA
	eY7JGt3yX7+uAee290vc25sahQ738hvSlDMTYz71M+ZhxB/ScktB1Y4VcWr6YmSYff9HUz3X
	YoYK4n4kZ/jynHOqZ5HRp+oT3DPli/P7D59uO0l6P5eUvWnuUVeePH/w4ofyUrWq65/qKdXQ
	/T0lP3vsRP4W3+O+0XyHqoGTdmPOHfFB7LeqX84cUiSlQI310wWsSlK0pWivXrZJr6BWhkef
	svvnkiKwQa/6hKoiRztJTfb+WXjb+/F0zQvM7jn29XJmx/P52TtpOMuUTUljUKOJ+hc4TfmX
	cQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvK4cn2K6wbdmeYuPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8XR/2/ZLCYdusZosfeWtsWe
	vSdZLOYve8pu0X19B5vF8uP/mCzO/z3OanF+1hx2ByGPnbPusntcPlvqsWlVJ5vH5iX1Hrtv
	NrB5fHx6i8Wjb8sqRo8zC46we3zeJOex6clbpgCuKC6blNSczLLUIn27BK6Ms1tiCtq4K3b9
	n8nUwDiHs4uRk0NCwETi/sU57F2MXBxCArsZJRa0HGWGSEhInHq5jBHCFpZY+e85VNFHRomH
	z9eCJdgE1CWOPG8Fs0UETjBKzJ/oBlLELDCDSeL3nwUsIAlhAT+JLRv/MIHYLAKqEq2LH4HZ
	vAKWEvM37GGD2CAvMfPSd3YQm1PASuLY0T1ANRxA2ywlTk5ygygXlDg58wnYSGag8uats5kn
	MArMQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcLxpae1g3LPqg94h
	RiYOxkOMEhzMSiK8q2Nl04V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQ
	WgSTZeLglGpgUig4fNFd5t37iD1OevnfyhbO2ZbcLS4xIfDDbpNIO1bunCID29DjQfcYOcQW
	TeDRWOe/36LORO9wfZvXdh23x+vUni4UX1e+rcBEYPdd1dMx2i9msq5NEFLj+W9at7umYPqd
	9jjl3pLZzOrx/6RkBbg2C8766pij+n2eqKtTdekBPvMNE86ejjQRF2ErK/5qvzitbHa6/MM7
	n6yymz+WRBguCzmTULF7T2Fal6xo/tz129bn/a258Nv3kYew7kxTxVU3Nnl5/2zcsmG5x4Yt
	fW3SAtKzYvSeVq2wNDjB6+PIVPj/0YEA40UNxbKXDA6mFV+8bO2Z+eiQ4ibOwKvdKu9DmYzU
	F3Gz9H1zyVdiKc5INNRiLipOBAB+d6zPJgMAAA==
X-CMS-MailID: 20241029163230epcas5p18172a7e54687e454e4ecb65840810c4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241029163230epcas5p18172a7e54687e454e4ecb65840810c4e
References: <20241029162402.21400-1-anuj20.g@samsung.com>
	<CGME20241029163230epcas5p18172a7e54687e454e4ecb65840810c4e@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_102407_047756_C3A6D713 
X-CRM114-Status: GOOD (  15.58  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

With user integrity buffer, there is a way to specify the app_tag.
Set the corresponding protocol specific flags and send the app_tag down.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79bd6b22e88d..3b329e036d33 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -872,6 +872,12 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static void nvme_set_app_tag(struct request *req, struct nvme_command *cmnd)
+{
+	cmnd->rw.lbat = cpu_to_le16(bio_integrity(req->bio)->app_tag);
+	cmnd->rw.lbatm = cpu_to_le16(0xffff);
+}
+
 static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 			      struct request *req)
 {
@@ -1012,6 +1018,10 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 				control |= NVME_RW_APPEND_PIREMAP;
 			nvme_set_ref_tag(ns, cmnd, req);
 		}
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_APPTAG)) {
+			control |= NVME_RW_PRINFO_PRCHK_APP;
+			nvme_set_app_tag(req, cmnd);
+		}
 	}
 
 	cmnd->rw.control = cpu_to_le16(control);
-- 
2.25.1


