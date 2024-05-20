Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BDAC25B78
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 11:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eFjYOy/rO8gowEbK0HM6LksYvSQzjlGqTWi9wTV85D4=; b=U/0/S0dYiDEpy4YGLDWVbtzxES
	gjef0QIvnufhvUJ1HrgT4aJK8wNCSs+NZWQVdKM8wy489+A1WjeXmKn7vwoeDMl4IcbH190U0nEUg
	wEBW/wT+CrTTz6zDfh/dmFXnSb7egfBN+2WCDTQcoxdAsoBZ/FffMNc5cJMJPVjZEv5ctv7KN24gs
	TedLFpM08UY+ydbhDALq2ItbsZTyYxwCTCgZwoSV4E9v4njSNg19QiSwflJ7CUSaPRHIhRBUYvsRu
	Jd+8uUbTGpMNBfPkQ7ifn97YXVzhpeVkgPTeWjewTVZEf+xx2cp6nnhI7cLJoIHeFtYE02OS65lxG
	u8zd+8Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s91S1-0000000EK6r-35Kh;
	Mon, 20 May 2024 11:45:09 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s91Rx-0000000EK2W-1n7W
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 11:45:07 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240520114502epoutp01024857cc3a9d71fb35122830a12a5320~RL8-gfKzn1937919379epoutp012
	for <linux-nvme@lists.infradead.org>; Mon, 20 May 2024 11:45:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240520114502epoutp01024857cc3a9d71fb35122830a12a5320~RL8-gfKzn1937919379epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205502;
	bh=eFjYOy/rO8gowEbK0HM6LksYvSQzjlGqTWi9wTV85D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qx88QH5I4iNQymT5c/u9o9/+xCJN3AHSZanjySqJrfMRkVdVmxdHSEAYxxHk1ellp
	 v4Wp9QWBTVjtJKybh5Dac/dUYKRH9OhT0enW6oPwb+WbARKwZYDrWxv4Yhyo6mZag4
	 /9lUEKF/EjNEjh8WFB2Gm2g9NcHSpAyMTXMCgd8A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240520114502epcas5p314d3ac8847fbfa8f00e6469d2bee365a~RL8_9Pvzi2210822108epcas5p39;
	Mon, 20 May 2024 11:45:02 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VjbMw3W1Yz4x9Pv; Mon, 20 May
	2024 11:45:00 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.60.19431.CB73B466; Mon, 20 May 2024 20:45:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7~RK62SXh_40443504435epcas5p1G;
	Mon, 20 May 2024 10:29:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240520102917epsmtrp2ac75c71748c9cbc2118a64cd866875eb~RK62RQdSo2153521535epsmtrp2y;
	Mon, 20 May 2024 10:29:17 +0000 (GMT)
X-AuditID: b6c32a50-f57ff70000004be7-6c-664b37bccb97
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.08.08390.DF52B466; Mon, 20 May 2024 19:29:17 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102913epsmtip223ed300d14416990c75ecc6ce4fcc8f9~RK6yqRUzB2247922479epsmtip2r;
	Mon, 20 May 2024 10:29:13 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 05/12] fs/read_write: Enable copy_file_range for block
 device.
Date: Mon, 20 May 2024 15:50:18 +0530
Message-Id: <20240520102033.9361-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+693Ba2uiugO5bBWDeUx4pUaDkQUDfMcgkYWbZsy5aIDb08
	Umi7PkQXpjCsAzZegm7W8RCMDhCKtCBP0xUFZXQwsTAg4DSQuTFRgWEYqa6lsP33+b2+319+
	J4eNu9tILjtNpmaUMnE6j3Qj2noDAvjd4XHJIbm3IdIP9OHoyxIbjhqmikk017sA0JnHKzia
	MX0F0KplCEfGvmmAqmsqCDRu6sBQd80pDNU13MDQuW9zMXTj+UMSnTKPAjRr1WGoZyIInT95
	gUDdPbcINNL5PYmqLs6y0KX+ZxgqzbNiqH0mB6C21SocNc09ItDNCS80ZOt32fsqPXInjh6o
	gXSHbopFD01fIegRi4Zuqc8nacOF4/QDw1lAd41nk3RtUZkLXZg7T9Id2rsu9JPZCYJ+dM1K
	0kXGekAPVl9nJXh8Io1KZcQSRunLyJLkkjRZSjQv7v3EmEShKETAF0SgcJ6vTJzBRPP2xSfw
	301Lt1+I53tYnK6xpxLEKhVv5+4opVyjZnxT5Sp1NI9RSNIVYYpglThDpZGlBMsYdaQgJGSX
	0N54SJr6TdcwqZjmHOm9VM7KBqYXC4ArG1JhcLXMABzsTnUD2DkZWgDc7LwA4L1RI8sZLAP4
	130da2Oi5Oc/gLPQA+Bk+RLpDLQY/HH4HFEA2GySCoI/PWc78p5UAw6/NpQSjgCnDDjM6TVh
	DikP6gNovKldkyUoP9hsnScczKEiYPn4b4TT7jXY0GzCHexKRUJT6+M1a0jpXeFISRHmbNoH
	ny0+Wd/PA/7Zb1xnLlyc7yGdnAnryn8gncMnANSN6YCzsAdqB4pxx9o4FQD1nTudaW94eqBp
	TR+nNsHC1Zl1Lw5sr9zgN+BlffW6/jY4+jSHdMhAiobmk0HOqxQC2PNgAi8BPrr/HaoBqAdc
	RqHKSGGShAoBX8Zk/vduSfKMFrD2DwIT2kFDsy3YDDA2MAPIxnmenBZjbLI7RyI++jmjlCcq
	NemMygyE9guW4twtSXL7R5KpEwVhESFhIpEoLCJUJOC9wpnTVkjcqRSxmpEyjIJRbsxhbFdu
	NuYj4lNT5yMrNscenVvU+ilW4g+8/VFa4+5+js9ojM3itd3rrUNRd49ZGlv43MG+1mBv/kXX
	oluueZVHVre+9+lTi9vvxwOmriY27cU3e6SvdFpYmk3jxbePkVLPLjL2gHD5O2nQvUz4kr/M
	8OFCSlRevodHbtq4JX/5H+HD7vjqN3eo/Fn79ebexCydaWz48PXGusHgg9lbAoShHN93CuWR
	ki+yahVjry/oZ1tVSyrp8o7kybPXlqRtv4BdZzK6/MNXKz/ev52dhTXRk1dzrgwXZ/Xesf56
	2eQzX7OnzG/AxI8uq5JYt82f2LpQmzUZeFpk+/uzF7wPvpwQo1+pmEwOu+/GI1SpYkEgrlSJ
	/wXV832lkAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSvO5fVe80g/c9YhbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW237PZ7ZY9/o9i8WJW9IW5/8eZ3WQ8bh8xdvj1CIJj52z7rJ7nL+3kcXj8tlS
	j02rOtk8Ni+p93ixeSajx+6bDWwei/sms3r0Nr9j89jZep/V4+PTWywe7/ddZfPo27KK0ePM
	giPsAcJRXDYpqTmZZalF+nYJXBk9uy+wFdzjrTi8fAp7A+MB7i5GTg4JAROJCedeMnYxcnEI
	CexmlOg9upUFIiEpsezvEWYIW1hi5b/n7BBFzUwS65f0MXUxcnCwCWhLnP7PARIXEdjOLPGx
	uZsJpIFZ4CizxIU1FiC2sECQxLcND8HiLAKqEhuuvgNbwCtgKTHl5gOoZfISqzccAFvGKWAl
	cWDrB0YQWwio5u71D2wTGPkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjlYt
	rR2Me1Z90DvEyMTBeIhRgoNZSYR30xbPNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK83173pggJ
	pCeWpGanphakFsFkmTg4pRqYChxP7/f+uftI0t5Nne+Yjsf+/bWlkkF02Xebdg/mJyIs01Pn
	NJ24wXCoZaV05awODn9f41kLmOLdamMerBO0Ot9kO2v+ua0rrupMXLQsirvoSVnC2tmeVyJN
	jJ/52O97YLP9z4l1ta5H7PcXT+2wz2zPNTkkWZU4j7eiVjv+aeOGZT9/s7hl3v21JnA1N9sG
	uaqe2R7yd5hcp82cpFx7asqVSTKJN0627/j5zebNWfUHhU7lyiELrhdZ7z+6Qqv57Aa/rnl/
	k2M8xZM3bi3ZwvHpsbmRsvNMv4uBj7PX/lbTvyBj+WjxD/3gZ/lvf0YWFRvcrxf8p/dx2mcJ
	Oe+YKtZ16kxqQcc+uYiUTfPPV2Ipzkg01GIuKk4EAIU1DcFFAwAA
X-CMS-MailID: 20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_044505_905130_785C8B98 
X-CRM114-Status: GOOD (  20.90  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

This is a prep patch. Allow copy_file_range to work for block devices.
Relaxing generic_copy_file_checks allows us to reuse the existing infra,
instead of adding a new user interface for block copy offload.
Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
and inode_out. Allow block device in generic_file_rw_checks.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index ef6339391351..31645ca5ed58 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1413,8 +1413,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t *req_count, unsigned int flags)
 {
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
+	struct inode *inode_in = file_in->f_mapping->host;
+	struct inode *inode_out = file_out->f_mapping->host;
 	uint64_t count = *req_count;
 	loff_t size_in;
 	int ret;
@@ -1726,7 +1726,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	/* Don't copy dirs, pipes, sockets... */
 	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
 		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
+		return -EINVAL;
+	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
 		return -EINVAL;
 
 	if (!(file_in->f_mode & FMODE_READ) ||
-- 
2.17.1


