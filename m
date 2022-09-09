Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F00ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/En3kdHbAnxMtFfNfnxgIqwPpfTB7ZbZfp6zU3yuXo=; b=CMSJ2vUQon21ANlEbjyky2Ga9a
	jwv2C2J1AQPi1nu7s9/Sbj0ul8tqwZ9AtrJkOzqOyCh0VqXl/vfSOp7oLEEFYDPRqW1DodL3j6KnM
	dokP6yO05WTnbR2QIOoQrGMq/ws/tRn+0quXGFAI75xzT9Bc3N2f1XwEYMQdE7EW4MXyNUWZA93vw
	r/p2czAbm08FpmdUdq6d3W/dzZNk1CXdeGfbSHVoaRz2fH5VsYQVeDxRphZtTDbVUJEPAn+BP7egO
	JSTVezxBfk5aQ2PH9VoDXoKSNUko6cwjh5THI4YaX8efDII+iaED9y0xZyIcZZp6jJbm2NKISdG4k
	T5Rw9i2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWh6V-000QrI-Oq; Fri, 09 Sep 2022 16:43:43 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWh6K-000Qhq-TW
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 16:43:35 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220909164322epoutp032f052fb511aa2ca260c2fc280f02b653~TPtwSiUuX0463904639epoutp03b
	for <linux-nvme@lists.infradead.org>; Fri,  9 Sep 2022 16:43:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220909164322epoutp032f052fb511aa2ca260c2fc280f02b653~TPtwSiUuX0463904639epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662741802;
	bh=U/En3kdHbAnxMtFfNfnxgIqwPpfTB7ZbZfp6zU3yuXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtzXCoc/g8QC9TEnDig+zd0OENq6k+2iBWp4kkHAV7vVGFRqAKumRAMnSQrw8Ec4t
	 h0Yyxd8jq6cA2vKgfXAKdIqY8pgIQxyq3O66C/XnQLVF5PnIcVBiz6aMbeSG/CakJR
	 9kB0xJCF9uIszCR5NVc+ttmZYchzyJgrMyHJ5uZU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220909164321epcas5p2b05a3d0d11399e0aa2c23290bc802ae7~TPtvk3XLK3133731337epcas5p2M;
	Fri,  9 Sep 2022 16:43:21 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4MPMHq5x56z4x9Pq; Fri,  9 Sep
	2022 16:43:19 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.83.59633.72D6B136; Sat, 10 Sep 2022 01:43:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d~TPttKa1-h1453414534epcas5p1D;
	Fri,  9 Sep 2022 16:43:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220909164318epsmtrp1f1cb2b4fb6517b9d791f1bd92332982b~TPttJqGP_0279602796epsmtrp1v;
	Fri,  9 Sep 2022 16:43:18 +0000 (GMT)
X-AuditID: b6c32a49-dfdff7000000e8f1-5a-631b6d27f257
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3D.EC.14392.62D6B136; Sat, 10 Sep 2022 01:43:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220909164317epsmtip1d5b6ad46efb59be6f1210b76f3bee75a~TPtr8NXly0068800688epsmtip1a;
	Fri,  9 Sep 2022 16:43:17 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, j.granados@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC 1/2] nvme: add whitelisting infrastructure
Date: Fri,  9 Sep 2022 22:03:06 +0530
Message-Id: <20220909163307.30150-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909163307.30150-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTU1c9VzrZ4NZZbYvVd/vZLFauPspk
	sXT/Q0aLx3c+s1sc/f+WzWLSoWuMFvOXPWW3WPf6PYsDh8f5extZPC6fLfXYtKqTzWPzknqP
	3Tcb2Dz6tqxiDGCLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
	8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeX
	WmJlaGBgZApUmJCdcXDPF8aCX3wVkx+/Zm9gnMHTxcjJISFgInH1w23mLkYuDiGB3YwSE9f/
	YYFwPjFK9DYdYIVwvjFKfFvylhWm5evF1VCJvYwSc68+h3I+M0o82HAEqJ+Dg01AU+LC5FKQ
	BhEBF4l3R7awgdjMAlUSsy4uZwSxhQUsJK7t+gdmswioSqy9eJ0ZxOYFit86/xhqmbzEzEvf
	2UFsTgFLiR27XrFB1AhKnJz5hAViprxE89bZYD9ICHxll/h+bCcbRLOLxM+Vu9ghbGGJV8e3
	QNlSEi/726DsZIlLM88xQdglEo/3HISy7SVaT/Uzg/zCDPTL+l36ELv4JHp/P2ECCUsI8Ep0
	tAlBVCtK3Jv0FOpkcYmHM5ZA2R4SO3ctZYMETw+jxLKTR5knMMrPQvLCLCQvzELYtoCReRWj
	ZGpBcW56arFpgWFeajk8YpPzczcxgpOllucOxrsPPugdYmTiYDzEKMHBrCTCy2IonSzEm5JY
	WZValB9fVJqTWnyI0RQYxhOZpUST84HpOq8k3tDE0sDEzMzMxNLYzFBJnHeKNmOykEB6Yklq
	dmpqQWoRTB8TB6dUA5Nx+dbG9FWv+aWWL6pQeid+rKTOQz9ZcqfvTk3urMm2Lx/ODYxef0cn
	n2vV+Xv1l+osvXOnmduGP+z/8KhbqbqtzEybZ63Hm8XO6S8kDpw5dsF5W0QhQ29t/Pa8KZXd
	C5r0o3KPRE+sPtTDFXMm4fqSxjla2jNf9HOliCVmhPa5vNLam/3viNy36e1c2gIysu838iya
	Pmne3OMbRXNO3q/Xj7PtzxMJd2L4vsD17Gbpw4kvX0vty9tuZOwZceb2GT/NpQtdWbQDzQ9W
	Lns2WWHNY/5ERyO/3nU3VPNbKm5zxNuKqx3Yb5xZx1Utf9rRS/Zf2R7rabZtyRfP8s8/vePI
	UyMBtdnmZxqeVYhoKLEUZyQaajEXFScCAPJNIv4fBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSnK5arnSywYXlphar7/azWaxcfZTJ
	Yun+h4wWj+98Zrc4+v8tm8WkQ9cYLeYve8puse71exYHDo/z9zayeFw+W+qxaVUnm8fmJfUe
	u282sHn0bVnFGMAWxWWTkpqTWZZapG+XwJVxcM8XxoJffBWTH79mb2CcwdPFyMkhIWAi8fXi
	atYuRi4OIYHdjBI/DhxlhkiISzRf+8EOYQtLrPz3nB2i6COjxP2e2WxdjBwcbAKaEhcml4KY
	IgJeEucay0HKmQXqJJZM3gnWKixgIXFt1z9GEJtFQFVi7cXrYON5geK3zj9mhRgvLzHz0new
	ek4BS4kdu16xgdhCQDXHjz5hhKgXlDg58wkLxHx5ieats5knMArMQpKahSS1gJFpFaNkakFx
	bnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcJBrae5g3L7qg94hRiYOxkOMEhzMSiK8LIbSyUK8
	KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwJa7c2/Y948TX
	yIdvnu3xSWp6qa37vDtiGnvq7Krfep4v/Yw3/LJw0kua3JzNeUn71/xNW4UXsqT4LJ61O+Sc
	l4RlTs899c824UcLOrNKW0U+HP7Ne+dmr/m6+YW9Ifu787Yy6T46qurrt3CLcU0UX+oSX3OD
	oFeinGkKvpHOezhOu84M0RUxbw0RrUp9tPFcqsTmLUdmLVtW8669JaCncY1/0eK6qqqV07ds
	DOA1Ufm7t7Bg5qGco/+ikuKSrh48Ema7w2fmPd7MBRP7RHc9TT1/5F2C3pLFCuVV0ktOfPok
	O89nSdPvE9acxjcmHTNLkFP3DRJ+e7W3Jale/43f2sPvOdW41v3jihRPXeClxFKckWioxVxU
	nAgAcU68r+ECAAA=
X-CMS-MailID: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d
References: <20220909163307.30150-1-joshi.k@samsung.com>
	<CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_094333_314364_345B3856 
X-CRM114-Status: GOOD (  15.29  )
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

If CAP_SYS_ADMIN is present, nothing else is checked, as before.
If CAP_SYS_ADMIN is not present, take the decision based on
- type of nvme command (io or admin)
- nature of nvme-command (write or read)
- mode with which file was opened (read-only, read-write etc.)

io-commands that write/read are allowed only if matching file mode is
present.
for admin-commands, few read-only admin command are allowed and that too
when mode matches.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 548aca8b5b9f..0d99135a1745 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -20,6 +20,42 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+bool nvme_io_cmd_allowed(u8 opcode, fmode_t mode)
+{
+	/* allow write/read based on what was allowed for open */
+	/* TBD: try to use nvme_is_write() here */
+	if (opcode & 1)
+		return (mode & FMODE_WRITE);
+	else
+		return (mode & FMODE_READ);
+}
+
+bool nvme_admin_cmd_allowed(u8 opcode, fmode_t mode)
+{
+	/* allowed few read-only commands post the mode check */
+	switch (opcode) {
+	case nvme_admin_identify:
+	case nvme_admin_get_log_page:
+	case nvme_admin_get_features:
+		return (mode & FMODE_READ);
+	default:
+		return false;
+	}
+}
+
+bool nvme_cmd_allowed(struct nvme_ns *ns, u8 opcode, fmode_t mode)
+{
+	bool ret;
+	/* root can do anything */
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+	if (ns == NULL)
+		ret = nvme_admin_cmd_allowed(opcode, mode);
+	else
+		ret = nvme_io_cmd_allowed(opcode, mode);
+	return ret;
+}
+
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 		unsigned len, u32 seed, bool write)
 {
-- 
2.25.1


