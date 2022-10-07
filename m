Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AA4C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lcoLrZFAKxrQ+BPdrrLC2kimHR0uic1Rf26kVgHeI0I=; b=aXPKgRBlvEUMJxBVuVGyCp2+uw
	HtvBhQBeAKn8EUIxkUJX3t1ezKtbcfD5ctgFMaVmt4frHZK8ubAE1ap11pW1gIok2+NXHOsTEzbgm
	pfOsCxrvV69d4ajrDLAVwOKXuyBnfGEMj0LrV4Akp3ScmipJtdhDns16/aPNBh5Znq+pPRTApkV+n
	rM//D0KZIde8Os2jzWzIJz7K3SPOvS0Q4sVVJIEuG55/zcpFyKZ8RJZOZtUXMOtGwpEOiRgcodq9Y
	O3XzrR3ZrtE7oysHpdNgSHwmGbCWckNIS0XNVEKtxUVpwuDJIWlhkIx88rZ7J6RVSVCAo023Z9vIJ
	9EEyd/Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ognNO-0095sO-94; Fri, 07 Oct 2022 13:26:54 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ognNK-0095r3-1s
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 13:26:52 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221007132637euoutp02db2d22d1400fef832dc63f645627145a~bzF9yVhZ_0746807468euoutp02V
	for <linux-nvme@lists.infradead.org>; Fri,  7 Oct 2022 13:26:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221007132637euoutp02db2d22d1400fef832dc63f645627145a~bzF9yVhZ_0746807468euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1665149197;
	bh=lcoLrZFAKxrQ+BPdrrLC2kimHR0uic1Rf26kVgHeI0I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=P9JmJG9E2sEKzLeP5H1NtvYukMJlmCjJV7CSuyTZeg8REba0G0xyCLhRyyBMZrARN
	 dOmFbAhbfxmtwOtDQYTp2cFNOnkDTTrsA+UeXc2zjotd9hPEh+zzurNPMM2zmD/jMh
	 223J4ZNRdMVfa6HcQi2PoH1/05cyeb8Q6Z6Ws3es=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221007132637eucas1p291398454b3a0713235f23a76747c5d21~bzF9eQM5F0520305203eucas1p2I;
	Fri,  7 Oct 2022 13:26:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.B1.29727.D0920436; Fri,  7
	Oct 2022 14:26:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221007132636eucas1p29fa012432043435685baf0b2789b4041~bzF9CTwxf0574005740eucas1p2y;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221007132636eusmtrp2d72a495b9662d3e51becade4bcf1b87e~bzF9Bn4Ja2144721447eusmtrp24;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-3e-6340290df4b1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 71.57.07473.C0920436; Fri,  7
	Oct 2022 14:26:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221007132636eusmtip215b629413dcb0e963f2f84b03d2b7421~bzF85TE8p1495614956eusmtip2Q;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 7 Oct 2022 14:26:33 +0100
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <javier.gonz@samsung.com>,
	<gost.dev@samsung.com>, <joshi.k@samsung.com>, Joel Granados
	<j.granados@samsung.com>
Subject: [RFC 2/2] nvme : Add ioctls for passthru admin whitelisting
Date: Fri, 7 Oct 2022 15:22:56 +0200
Message-ID: <20221007132256.2543136-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221007132256.2543136-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djP87q8mg7JBmfbOS1Wrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEsUl01Kak5mWWqRvl0CV8bBo31M
	BcslKt7fqG5gXCXSxcjJISFgIrHv6GyWLkYuDiGBFYwSF89PZYRwvjBKTFmyggnC+cwocf/V
	PhaYltsX9jGC2EICyxkl3vSHwBWdmvgHqn0To8T5uffBOtgEdCTOv7nDDGKLCFhKHL5yGWws
	s8AsRon5ByeCJYQFXCQ+NkxgA7FZBFQkfjWuZAexeQVsJa6e+8sKsVpeou36dLDVnAJ2En9f
	TGaDqBGUODnzCdgyZqCa5q2zmSFsCYmDL14wQ/QqSmyZ8x1qTq3E2mNn2EGOkBC4wCHR/fwb
	O0TCReLU5ClMELawxKvjW6DiMhL/d86HimdL7JyyC2pogcSsk1OBjuAAsq0l+s7kQIQdJS6s
	ecoMEeaTuPFWEOIcPolJ26ZDhXklOtqEJjCqzELywCwkD8xC8sACRuZVjOKppcW56anFhnmp
	5XrFibnFpXnpesn5uZsYgUnk9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHenTvtkoV4UxIrq1KL
	8uOLSnNSiw8xSnOwKInzss3QShYSSE8sSc1OTS1ILYLJMnFwSjUwtXDz780umODDzmYWVGNj
	vruyQUdwznRmxc/TamJsz64Okhf1cbG6clJv+0N7DctHqx7WTTRR/DrhXGzAyd/d6u7vNDn8
	CwXarJ8+dciaMDX2nP4u74WXinKZVqdeSzvMK7WKVTv9iPS9kJqXimUFm1lXPD8Q87h1/UOj
	gAUfLGMlN7mFHsgX+r691mtlrVcTX6rhdenNncIpDFGGbMeWxbXxJJtcPdryT748dk1+357q
	lduYGPd2R/yzDKkKVaifo2vzXv6QsN/WvrgjgnwrH7qt0H55fVdTjNemH8y+u/xnL3kmxWa4
	+dWmsyfddYK22dSr1tyymWNp2DZ1RczE9T6XVnXmK1wWFf33KEeJpTgj0VCLuag4EQAfdijb
	kQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7o8mg7JBg/atC1Wrj7KZDHp0DVG
	i/nLnrJbrHv9nsWBxeP8vY0sHptWdbJ5bF5S77H7ZgNbAEuUnk1RfmlJqkJGfnGJrVK0oYWR
	nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbBo31MBcslKt7fqG5gXCXSxcjJISFg
	InH7wj7GLkYuDiGBpYwSz/r3sEEkZCQ+XfnIDmELS/y51sUGUfSRUWLzvflMEM4mRomp0x8w
	glSxCehInH9zhxnEFhGwlDh85TJYEbPALEaJ+QcngiWEBVwkPjZMAFvBIqAi8atxJdgKXgFb
	iavn/rJCrJOXaLs+HWwop4CdxN8Xk8HqhYBqWi7cZ4OoF5Q4OfMJC4jNDFTfvHU2M4QtIXHw
	xQtmiDmKElvmfIeaWSvx6v5uxgmMIrOQtM9C0j4LSfsCRuZVjCKppcW56bnFhnrFibnFpXnp
	esn5uZsYgXG27djPzTsY5736qHeIkYmD8RCjBAezkgjvzp12yUK8KYmVValF+fFFpTmpxYcY
	TYH+nMgsJZqcD4z0vJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkG
	JsXMP4r2GucOnrI+0PXees+UDevtO2Nf2/x+YZV56eBSIXOzqg8/OI6oW1y7eeFTyp/1S5jq
	jZ+f+D6fbbrs558VOa0mykfV2k3yvAIPnMx5U9wfcb7j71KlWV8aTDeu5Vj8P1y7++fuFpEg
	s0diW/f8Os+2aXFz0/rAcPNOFb8p24tr+mtZj87Ysrf7iFTQsuMbpukwfjX0mbhbIml97J6s
	NxWn/x2Q8VM7XDHxyE7Zift8NPt+h73u1kvrWHX8Ov+OlM7OP0HJXYc1Ts6OMN6mEp35Nfj9
	S+mPxzdUKndmfbEz/Ml+UdHTNrZq7ba9bx7smj4laXr++eAlt1WjPtkWujT6xVQ+y7jf2D47
	8b8SS3FGoqEWc1FxIgBoA0SjPAMAAA==
X-CMS-MailID: 20221007132636eucas1p29fa012432043435685baf0b2789b4041
X-Msg-Generator: CA
X-RootMTR: 20221007132636eucas1p29fa012432043435685baf0b2789b4041
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221007132636eucas1p29fa012432043435685baf0b2789b4041
References: <20221007132256.2543136-1-j.granados@samsung.com>
	<CGME20221007132636eucas1p29fa012432043435685baf0b2789b4041@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_062650_527198_BB578FF7 
X-CRM114-Status: GOOD (  14.34  )
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

An ioctl (NVME_IOCTL_PTHRU_WLIST) is added in order to control the passthu
admin opcode whiltelist. A new struct (nvme_pthru_wlist) is used to pass
an action (Add, Remove, Test), opcode number and result data between user
and kernel space.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/nvme/host/ioctl.c       | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/nvme_ioctl.h | 14 ++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 73e4287d2c44..76393d50a798 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -50,6 +50,36 @@ bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
 	return true;
 }
 
+static int nvme_admin_cmd_whitelist(struct nvme_pthru_wlist __user *u_op)
+{
+	__u8 opcode;
+	struct nvme_pthru_wlist nvme_pthru_wlist = {0};
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (copy_from_user(&nvme_pthru_wlist, u_op, sizeof(struct nvme_pthru_wlist)))
+		return -EFAULT;
+	opcode = nvme_pthru_wlist.opcode;
+	if (opcode >= nvme_admin_last || opcode < 0)
+		return -EINVAL;
+
+	switch (nvme_pthru_wlist.action) {
+	case NVME_PTHRU_WLIST_ADD:
+		__set_bit(opcode, nvme_admin_whitelist);
+		return 0;
+	case NVME_PTHRU_WLIST_REM:
+		__clear_bit(opcode, nvme_admin_whitelist);
+		return 0;
+	case NVME_PTHRU_WLIST_TEST:
+		if (put_user(test_bit(opcode, nvme_admin_whitelist),
+			     &u_op->result))
+			return -EFAULT;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 		unsigned len, u32 seed, bool write)
 {
@@ -586,6 +616,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		return nvme_user_cmd64(ns->ctrl, ns, argp, false, mode);
 	case NVME_IOCTL_IO64_CMD_VEC:
 		return nvme_user_cmd64(ns->ctrl, ns, argp, true, mode);
+	case NVME_IOCTL_PTHRU_WLIST:
+		return nvme_admin_cmd_whitelist(argp);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 2f76cba67166..748ce70517ba 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -45,6 +45,19 @@ struct nvme_passthru_cmd {
 	__u32	result;
 };
 
+enum nvme_pthru_wlist_action {
+	NVME_PTHRU_WLIST_ADD,
+	NVME_PTHRU_WLIST_REM,
+	NVME_PTHRU_WLIST_TEST
+};
+
+struct nvme_pthru_wlist {
+	__u8				opcode;
+	__u8				flags;
+	__u32				result;
+	enum nvme_pthru_wlist_action	action;
+};
+
 struct nvme_passthru_cmd64 {
 	__u8	opcode;
 	__u8	flags;
@@ -104,6 +117,7 @@ struct nvme_uring_cmd {
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD_VEC	_IOWR('N', 0x49, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_PTHRU_WLIST	_IOWR('N', 0x50, struct nvme_pthru_wlist)
 
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
-- 
2.30.2


