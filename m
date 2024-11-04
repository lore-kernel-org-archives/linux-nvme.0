Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A8CD111A1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdzGTMHoJr7DsmAYK7dZF3Jk+VkM+gVW6lv3bLW8Di0=; b=wyrzG5wuQZ0dVUgAFLX9u7EfNu
	FBioOLQvQf+DqdSV75j6f378Eg142L9eZ6hpfY+SLDNxACU6ESxC5eRpenp5Tnv5eqLLgjch8yAPN
	KpzseHRvpjiQI4prUx37XzUp8C9ucMmsh+gVQ3SD3NUvwley2iy5NHhQhxlyBJU9gPnU/IJDDmzhF
	b6qNYjHoh5Q/I71fYAYVXIE84bsaxgiQEKU6F2YYvpJ7J74ODGqC6w16mdwx0bCbcJr/QdBDvbBgK
	wuNWHjhLkRUWSLhFKyZkxjSoAKoakES0KwFzkOyKXK0HHWyshx4erOnApsniwa1gLLsk6SrXPT+y+
	pEppB0+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zRS-0000000EHbk-2V5E;
	Mon, 04 Nov 2024 15:56:34 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zRJ-0000000EHS0-0Zn3
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 15:56:28 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241104155623epoutp04d5c9d729e9b38d6005104d49225dc0f7~EzwZuQuLh1247412474epoutp04S
	for <linux-nvme@lists.infradead.org>; Mon,  4 Nov 2024 15:56:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241104155623epoutp04d5c9d729e9b38d6005104d49225dc0f7~EzwZuQuLh1247412474epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730735783;
	bh=TdzGTMHoJr7DsmAYK7dZF3Jk+VkM+gVW6lv3bLW8Di0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyaKIkyqn9+MnsrBSN0W0u8PaG0t+Gu2GHegB+s4I7RQ0u6hq4Rw0lzJX5BwgRHJC
	 wtvi8fFvwmOZMY4PPE8sqzixZMUXNzqlUI5J/MRfR74xvOiC6qxA2US40rUseyGgFL
	 1p2o6sB96XWNnje8rpeYm76VUiZWq0W/mgS68/Ys=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241104155622epcas5p37fc4250e11a34029e910dfcdce649715~EzwY9sY380268302683epcas5p3C;
	Mon,  4 Nov 2024 15:56:22 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Xhx0N59wzz4x9Pp; Mon,  4 Nov
	2024 15:56:20 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E8.A7.09420.4AEE8276; Tue,  5 Nov 2024 00:56:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241104141504epcas5p47e46a75f9248a37c9a4180de8e72b54c~EyX8jQoAX3055130551epcas5p4j;
	Mon,  4 Nov 2024 14:15:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241104141504epsmtrp185b3edd7ba835d76c7ea980221a18c8e~EyX8cS1Vl1329813298epsmtrp14;
	Mon,  4 Nov 2024 14:15:04 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-16-6728eea4e0f6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5A.8D.07371.8E6D8276; Mon,  4 Nov 2024 23:15:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241104141501epsmtip273173b25c2459b8858b68de6692b678e~EyX6AFrz83074930749epsmtip2w;
	Mon,  4 Nov 2024 14:15:01 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, Anuj
	Gupta <anuj20.g@samsung.com>
Subject: [PATCH v7 08/10] nvme: add support for passing on the application
 tag
Date: Mon,  4 Nov 2024 19:35:59 +0530
Message-Id: <20241104140601.12239-9-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104140601.12239-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmuu6SdxrpBpvvKll8/PqbxaJpwl9m
	izmrtjFarL7bz2bx+vAnRoubB3YyWaxcfZTJ4l3rORaL2dObmSyO/n/LZjHp0DVGi723tC32
	7D3JYjF/2VN2i+7rO9gslh//x2Rx/u9xVovzs+awOwh57Jx1l93j8tlSj02rOtk8Ni+p99h9
	s4HN4+PTWywefVtWMXqcWXCE3ePzJjmPTU/eMgVwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7
	x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gD9pKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
	VUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzvi8o4+lYAt3xfsdP5gbGI9ydjFyckgI
	mEi8O7eBpYuRi0NIYDejxLFbV9khnE+MEvueXYJyvjFKzLy8gh2mZeufr1CJvYwSX6fMZARJ
	CAl8ZpQ4NCEVxGYTUJc48ryVEaRIRGAPo0TvwtNgS5gFJjBJLJi+hRmkSlggQGLq2n9ACQ4O
	FgFViS33KkDCvAKWEguXHmSB2CYvMfPSd7DNnAJWEnP+3mWBqBGUODnzCZjNDFTTvHU2M8h8
	CYE7HBLzu7vZIJpdJI723II6W1ji1fEtULaUxMv+Nig7XeLH5adMEHaBRPOxfYwQtr1E66l+
	ZpDbmAU0Jdbv0ocIy0pMPbWOCWIvn0Tv7ydQrbwSO+bB2EoS7SvnQNkSEnvPNUDZHhL90w9D
	Q66XUeLR717GCYwKs5D8MwvJP7MQVi9gZF7FKJlaUJybnlpsWmCYl1oOj+bk/NxNjOCEruW5
	g/Hugw96hxiZOBgPMUpwMCuJ8M5LVU8X4k1JrKxKLcqPLyrNSS0+xGgKDO+JzFKiyfnAnJJX
	Em9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAPTyr4/1yROcayR1Gie
	ZHZY2uZp9RtDvj9CO9OrBNJ8OuY0LJ1ir/9O3nbWYY9bcxpq2tKkJ24+LTQnZrrp3+niMp4V
	xt/y/W7+vLS8cz9388aw66r2rGaZH467FlilFeTb1D3wOZZwoc3l/uKIMCmtYoPGDo0FlgHv
	Uxz/zlDZOu9knHjTcgP+lH3TznKJvLYUVp5RtVXS7YrGhSDH3PhZO304TdcuNn15Jvz1LM3l
	51YnyGa9jX3A1mQ/fYro1B/fOXfMnr6bq8d69UfheZzRP+5efadlVBGd5sasY56yZJZv30NN
	zxgpIy9uyQuZfm1adZo1r+6x+OVazTpSyP2/Ttj4Sej2wvCdvCfyViixFGckGmoxFxUnAgDF
	mwMmcQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvO6LaxrpBrevylh8/PqbxaJpwl9m
	izmrtjFarL7bz2bx+vAnRoubB3YyWaxcfZTJ4l3rORaL2dObmSyO/n/LZjHp0DVGi723tC32
	7D3JYjF/2VN2i+7rO9gslh//x2Rx/u9xVovzs+awOwh57Jx1l93j8tlSj02rOtk8Ni+p99h9
	s4HN4+PTWywefVtWMXqcWXCE3ePzJjmPTU/eMgVwRXHZpKTmZJalFunbJXBlfN7Rx1Kwhbvi
	/Y4fzA2MRzm7GDk5JARMJLb++crexcjFISSwm1FiytODjBAJCYlTL5dB2cISK/89hyr6yCix
	+do5dpAEm4C6xJHnrWBFIgInGCXmT3QDKWIWmMEk8fvPAhaQhLCAn0TPxUdADRwcLAKqElvu
	VYCEeQUsJRYuPcgCsUBeYual72AzOQWsJOb8vQsWFwKq2dR0iQWiXlDi5MwnYDYzUH3z1tnM
	ExgFZiFJzUKSWsDItIpRMrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzjitDR2MN6b/0/v
	ECMTB+MhRgkOZiUR3nmp6ulCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0t
	SC2CyTJxcEo1MM06EG7VJaU36/eqd3cK323YI7IwYZWyiqfvZCGH5+sfvJn4YvOmy5GurYIL
	jae7PVl8Y8bmpZdWcm8RfcwcJ6c7K/bX+k2vPn/YffVQRKtCguuXJcK3lt2OyDg40cfg52Sb
	1f0R0x3OdDJK8Pt7mVampt9b2Lf7x6TGRtXkpevW7umwS3u2e/HqiqMX2ZwXicad++q99u4a
	uZbNR6eFbNfpTpLQ2bfpT9ae1jjpNsFHgcqlypPnP9h5VPvUXavi9c4SzG9+SM1yvzWncI2W
	sF1t0JkZl+65bT/+8PCfMNdw3zV6f794TI/r3Xkp0bx5+5G3vrpG/FLpte5MX7sMn1RGMbyv
	6TTVvvzWacEpEcsEJZbijERDLeai4kQAWokeuScDAAA=
X-CMS-MailID: 20241104141504epcas5p47e46a75f9248a37c9a4180de8e72b54c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241104141504epcas5p47e46a75f9248a37c9a4180de8e72b54c
References: <20241104140601.12239-1-anuj20.g@samsung.com>
	<CGME20241104141504epcas5p47e46a75f9248a37c9a4180de8e72b54c@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_075625_836094_B092A50A 
X-CRM114-Status: GOOD (  16.76  )
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
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


