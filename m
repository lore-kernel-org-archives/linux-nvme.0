Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3FAC41513
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jd/GFJFwjn8Dj9UlkTihCG1JPLdLq9GV+PUlR8GnadQ=; b=bJtqqo1k/eTIPqh/AAXw4A7XCP
	/l9LeAr76eNADPdWiinB35OLooE7w0MOlc19PBFKX8DvkfKDGDEm4neP3MwJp2qDTqaVZvKdUjnE4
	Fq0yIA7cc9Nl3f/KHq0qJ6x4Jzx6Wl5k8g501VJ0BDeRliEI8ZjBJsyh3uLWjM/4HObOp8rQgjuom
	hjR8BXzpCnZxL7tOldBnom1kNPPP+RS/UdeMvIPZVqN0ApXLOCTzB56gWbNe45ibhSHO2OLNCG5OH
	sovy4ZZ0dwG4Z4BZSHqx9F66ArrLKWHmjw+hH8JEvjHb2ktY1PC7x5sGkkDLevUALWUeHtzLwzOY/
	OqbeHDOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUUdV-00B2YR-1e;
	Fri, 11 Aug 2023 16:05:13 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUUdS-00B2Td-1E
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 16:05:12 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230811160501epoutp04db3b31f9c7af8f521a60beb04564707a~6X8MJ4Vc30569205692epoutp04G
	for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 16:05:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230811160501epoutp04db3b31f9c7af8f521a60beb04564707a~6X8MJ4Vc30569205692epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691769901;
	bh=jd/GFJFwjn8Dj9UlkTihCG1JPLdLq9GV+PUlR8GnadQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKiJ6daM9o1foINW4Be9KEf7ntNt4TyIj0+7XUzaU027Mhpl0aGb0dyslwE7zTIJJ
	 iiJVbuIT5n0B8pTi6IRWGdCPdT1Tihcxw2nIZJ/jPGuKkzZlzeKX6I1vlW1CopJ/dF
	 oaQEULOaDUysecycVf+cs4GRg6UsmYhrwhBpkfqw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230811160500epcas5p13dea8ac076f4fccad316b62146d0055e~6X8LyOjir2626626266epcas5p1R;
	Fri, 11 Aug 2023 16:05:00 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4RMpXW1dtkz4x9Pr; Fri, 11 Aug
	2023 16:04:59 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.79.57354.B2C56D46; Sat, 12 Aug 2023 01:04:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230811160458epcas5p36baa80f06fda8b9b05546fe6e044b0cc~6X8Jv-5Un1729417294epcas5p3H;
	Fri, 11 Aug 2023 16:04:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230811160458epsmtrp23befd09043b8fd8b6ec7b705eacfeb69~6X8JvP-D_0442304423epsmtrp2o;
	Fri, 11 Aug 2023 16:04:58 +0000 (GMT)
X-AuditID: b6c32a44-007ff7000001e00a-75-64d65c2b75a6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7D.07.30535.A2C56D46; Sat, 12 Aug 2023 01:04:58 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230811160456epsmtip2f7ef859d6688f6be3e17f664559579cc~6X8H85GWY2904129041epsmtip22;
	Fri, 11 Aug 2023 16:04:56 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/2] nvme: avoid memory corruption for sync passthrough
Date: Fri, 11 Aug 2023 21:29:06 +0530
Message-Id: <20230811155906.15883-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811155906.15883-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhq52zLUUg97TXBZrrvxmt1h9t5/N
	4uaBnUwWK1cfZbI4+v8tm8X5t4eZLCYdusZoMX/ZU3aLda/fs1hsaBN04PLYOesuu8f5extZ
	PC6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxiDGCPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
	MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpOSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
	klNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcWf1R9aC1ZwVJ790sjcwPmHvYuTkkBAwkdi6
	5x+QzcUhJLCbUeLjl8fMEM4nRokfV88xQjjfGCUOTprICtOy8cxyJojEXkaJZ7vvQTmfGSX6
	rzYCtXBwsAloSlyYXArSICLgItHw7w3YJGaBJYwS898tYQZJCAu4S3w8cJkFxGYRUJW42bme
	DcTmFbCQ+PNtGxvENnmJmZe+gx3LKWApsXEdyCCQGkGJkzOfgPUyA9U0b50NdreEQCeHxMX3
	N5ggml0kNqz4AGULS7w6vgXqaymJz+/2Qi1Ilrg08xxUTYnE4z0HoWx7idZT/cwgzzADPbN+
	lz7ELj6J3t9PmEDCEgK8Eh1tQhDVihL3Jj2FBpC4xMMZS6BsD4mJ/59Bw6eHUWL6tFOMExjl
	ZyF5YRaSF2YhbFvAyLyKUTK1oDg3PTXZtMAwL7UcHrPJ+bmbGMGpVMtlB+ON+f/0DjEycTAe
	YpTgYFYS4b3lfi1FiDclsbIqtSg/vqg0J7X4EKMpMIwnMkuJJucDk3leSbyhiaWBiZmZmYml
	sZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1Mp/tU9KpXs0wtXZHk3+jF2x6TwL3hg5nQ
	0hOTC6U+1H1dNTtF3uHg6bUzPjb1H2hUCdjEuo9B2WHV40f9t75Om6Ej0nrwfkF7VISBdegE
	l73XcrwnnZ26JSvKp3Xe2p9CM9SLKiTn7a1Vlv56b/NDy9OMdWbfLsmkF7Z/fS1b9/dkkDKH
	lqi43vr0U6vattX/XvA497Fqpd+hPb09ntUL2u+u6nXXUDn4XdVQ0fp+Y8Te3d+bLvinrNYN
	LeaZcf5hEIvfFi0OXo71Tec1n9wwDF93pvDdrIBHpex+Scv1fbYeUpD8Z9ztlLP/1ASpz1Iy
	p1Yx/2maseulyvuCB9lsAWsMHY88ZT4fJXCn+bigEktxRqKhFnNRcSIAOcMwjy4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvK5WzLUUgwUrVS3WXPnNbrH6bj+b
	xc0DO5ksVq4+ymRx9P9bNovzbw8zWUw6dI3RYv6yp+wW616/Z7HY0CbowOWxc9Zddo/z9zay
	eFw+W+qxaVUnm8fmJfUeu282sHn0bVnFGMAexWWTkpqTWZZapG+XwJVxZ/VH1oLVnBUnv3Sy
	NzA+Ye9i5OSQEDCR2HhmOVMXIxeHkMBuRonNp7YzQyTEJZqv/YAqEpZY+e85O0TRR0aJUxvn
	ADkcHGwCmhIXJpeC1IgIeEnMm72ABcRmFljFKPH3sx6ILSzgLvHxwGWwOIuAqsTNzvVsIDav
	gIXEn2/b2CDmy0vMvPQdbBengKXExnVvGEFsIaCaXXsuM0LUC0qcnPkEar68RPPW2cwTGAVm
	IUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOAa0tHYw7ln1Qe8QIxMH
	4yFGCQ5mJRHeW+7XUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQWgST
	ZeLglGpgCi9zDr11MSDjp+A23uBz++IEdWbm+Mm/0sqQOrF9o4J/7D7FxaciT7evyjtx+cb0
	v/z6lc7mme3Vj/ekbs5qPF2SYLBKx1EvhlP0AlfVlLt1Ef9dmq3lmB4kex6ZpPxhyaukX/IR
	Tn1V9YvviyRP3XX24962kpJr+nNKp541e8fyTOLrNP4Dz/kcHrD4SDjEsm7vXnHyuQ9P/5tO
	t8uTDSQ3pfR0lyxYusG5t2JHXdhkk87FqsbfXh08XBPX+qDj0uYNCYeefpgkuH/mz01b+NTN
	ti2QvubkWJ/zvGT+7ob1yj5tW23Dl81sffHTYucuvbR1swJDo3w6jDkm9Ez1qjHsT9u0Yckj
	62fXazlOK7EUZyQaajEXFScCADn92N3wAgAA
X-CMS-MailID: 20230811160458epcas5p36baa80f06fda8b9b05546fe6e044b0cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811160458epcas5p36baa80f06fda8b9b05546fe6e044b0cc
References: <20230811155906.15883-1-joshi.k@samsung.com>
	<CGME20230811160458epcas5p36baa80f06fda8b9b05546fe6e044b0cc@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_090510_730904_BBC4A6EF 
X-CRM114-Status: GOOD (  12.57  )
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

Sync passthrough metadata handling also needs to avoid the situation of
device writing into unrelated kernel memory.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index fb73fa95f090..f7adabbc9e9f 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -388,6 +388,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_validate_passthru_meta(ctrl, ns, &c, cmd.metadata,
+					 cmd.metadata_len))
+		return -EINVAL;
+
 	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
 		return -EACCES;
 
@@ -435,6 +439,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_validate_passthru_meta(ctrl, ns, &c, cmd.metadata,
+					 cmd.metadata_len))
+		return -EINVAL;
+
 	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
 		return -EACCES;
 
-- 
2.25.1


