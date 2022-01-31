Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C783C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Oxgbf6ZYhcCysOJ2qcL78wk/QfStpj+gRuNs7cgD/ms=; b=4dXHmXWhndjMJBzFYV9MCSbvW6
	IAD75+r655efE4bh3zUdW0DMvGfQA/yoRh6nSZ1ThjFwUxooOJwHFX7k42rMFp8v27jTCoedv9049
	HrUW68z57MLygeBmRyD18r7jqwc89WTZKXNzhLFf9ugLsxpAy165T8u35rXRulwv/g0D0/0OS69ft
	tHVhRJ7uKdj7J9GYA6wQ0hl01umQd1H43kYYgG1xDlW1rLs+Xhz3u8Zj6G3HymixqbbG93SKSstVn
	Hp6sx7EewmfVjpqL6idBg8HTB+b8MmkvHLELEz3Ennzr+In5Ae813vqz33/EfuD8X5TZK3+giogXG
	3S3c79Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEXdR-009ask-Mg; Mon, 31 Jan 2022 14:26:25 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEXdM-009asQ-Jo
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 14:26:23 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20220131142616epoutp01ae6b482ff9f9f243831762699a0c2394~PYR99k0Ot1521915219epoutp019
 for <linux-nvme@lists.infradead.org>; Mon, 31 Jan 2022 14:26:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20220131142616epoutp01ae6b482ff9f9f243831762699a0c2394~PYR99k0Ot1521915219epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1643639176;
 bh=Oxgbf6ZYhcCysOJ2qcL78wk/QfStpj+gRuNs7cgD/ms=;
 h=From:To:Cc:Subject:Date:References:From;
 b=mbxO9nH4YkbG57q0Qkc9M9tkt3FNqQZwvHfDAvVf2eQM8K1/UYKr3SIiDqnaOBKuj
 oxkVudONN26K8cYnKVCBKuT/t033al4a31xQAhokoI3wUGLUvY3EznGLhli9wn0ijh
 sD2aieQc3y1E7OqZkjymiSUQ65S09RS6j/75L2Ao=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220131142615epcas5p473144b2a651fd679cd1646997b47a13e~PYR8z7Tba1783617836epcas5p4H;
 Mon, 31 Jan 2022 14:26:15 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4JnVjZ1M40z4x9Px; Mon, 31 Jan
 2022 14:26:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 96.0A.06423.F71F7F16; Mon, 31 Jan 2022 23:26:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220131142354epcas5p3ff940846a88ae6fcfd8f9b3acb421913~PYP5X9OW90640006400epcas5p3Z;
 Mon, 31 Jan 2022 14:23:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220131142354epsmtrp2886b465bd841bec76a879357f3fff3b0~PYP5W6Ro_2852828528epsmtrp2t;
 Mon, 31 Jan 2022 14:23:54 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-66-61f7f17fd56b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 21.8D.08738.9F0F7F16; Mon, 31 Jan 2022 23:23:53 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220131142353epsmtip1c83bb0f3d81f5bfcb1cb2140ca591ce3~PYP4SCkno1624516245epsmtip14;
 Mon, 31 Jan 2022 14:23:53 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, joshiiitr@gmail.com
Subject: [PATCH v2] nvme: add vectored-io support for user-passthru
Date: Mon, 31 Jan 2022 19:48:47 +0530
Message-Id: <20220131141847.4791-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTU7f+4/dEg8+TVCxW3+1ns1i5+iiT
 xfm3h5ksJh26xmjx9OosJov5y56yO7B57Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNo7f5HVsA
 W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
 ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
 7Iz+++cYC35qVhz59YS5gXGfUhcjJ4eEgInEunv72LsYuTiEBHYzSsx4tJcNwvnEKDF/QR+U
 85lR4ua2mUwwLWtuz2eBSOxilGjtXcYOV9W4eilQFQcHm4CmxIXJpSANIgJOEtMfn2MBsZkF
 zCXW3f3EAlIiLOAsMfWuHkiYRUBVYseLL6wgNi9Qyeqf+1ggdslLzLz0nR0iLihxcuYTqDHy
 Es1bZzODrJUQOMcu8b/vLRtEg4vE1Jd3GCFsYYlXx7ewQ9hSEp/f7YWqKZb4decoVHMHo8T1
 hplQ2+wlLu75C3Y/M9D963fpQ4RlJaaeWscEsZhPovf3E2hA8ErsmAdjK0rcm/SUFcIWl3g4
 YwmU7SGxa/4LsBuEBGIl9h9ZxDSBUX4Wkn9mIflnFsLmBYzMqxglUwuKc9NTi00LDPNSy+ER
 m5yfu4kRnBi1PHcw3n3wQe8QIxMH4yFGCQ5mJRHevQu/JwrxpiRWVqUW5ccXleakFh9iNAUG
 8kRmKdHkfGBqziuJNzSxNDAxMzMzsTQ2M1QS5z2dviFRSCA9sSQ1OzW1ILUIpo+Jg1Oqgalu
 895N4f13GK5cUVl/4+Kc8Iv3k/h2njEyvhfVLxRy+1z4bNFbe3k7A6zX/FlYnS+Ya8AnOiXp
 5/M/C2UZNrI82fCzQlN4pYdfk+IPqduZr144v6ybu6n1SskZn1ynTwfUnexiPB65iBnWGAat
 0bp3ff2DTeHse+eqJK+ZlV+5+LWl+yORivQC/d7l3wRm3+VsqXm3c0J5+ez40i7ZW9Mf7177
 5eLWuwI7otbnuZ05atYksbJJRV6XNylaMbA52dHrarF3opOyxvqYsKrbEi+cOQ8m7FU+qWDS
 LfdCtP2ew8o9PdN4tp/LmOyz/c+brE2OF36+4rm7Xf6C6svMzitFp5MeGh/XDTsQFnzlUIsS
 S3FGoqEWc1FxIgDnWIrPFQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSnO7PD98TDVpWWVqsvtvPZrFy9VEm
 i/NvDzNZTDp0jdHi6dVZTBbzlz1ld2Dz2DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObR2/zO7YA
 tigum5TUnMyy1CJ9uwSujP775xgLfmpWHPn1hLmBcZ9SFyMnh4SAicSa2/NZuhi5OIQEdjBK
 9H7pYYFIiEs0X/vBDmELS6z89xzMFhL4yChxZTJQMwcHm4CmxIXJpSBhEQEPiZbvG5hBwswC
 lhIf7hiCmMICzhJT7+qBVLAIqErsePGFFcTmFTCXWP1zH9QieYmZl76zQ8QFJU7OfAIWZwaK
 N2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCg1NLawfj
 nlUf9A4xMnEwHmKU4GBWEuHdu/B7ohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNL
 UrNTUwtSi2CyTBycUg1MB056nN8h1fOnSMoqZ+HS16HH99ncZmR6+Oxg2qEprgE/BF1E5Q6c
 Vpju3m2uZu/kIXPv/c3WuwH3dOdf/vhKoYZl5VP7Oz2PzVpVSmbOaN35lUvFVUw95SpPB9Oy
 ucnC1129ZUVsNS79Mlyxq4/zhsaqI0d/zfu+6L6D3PqFxxZZ+Zgfe1mTc9l4ara31V4zq4NC
 AsJuT5be7HYR3uV4/PQi+8+X1VeeTpuV91hna86GrGlOh3ZmPf3i/2DrgVpW2XXLJj/79PfK
 2Wiz3Xp7mbcVT1yco7lCZor2zUKJ50+10k6JfTc4u6Xc+uDu6TmNxZyhSS8sJ7xfZPJMpis+
 +8blI3aqPX4TGlKuZr8UaFZiKc5INNRiLipOBABK1pURvQIAAA==
X-CMS-MailID: 20220131142354epcas5p3ff940846a88ae6fcfd8f9b3acb421913
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220131142354epcas5p3ff940846a88ae6fcfd8f9b3acb421913
References: <CGME20220131142354epcas5p3ff940846a88ae6fcfd8f9b3acb421913@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_062621_185020_A1B1B8FA 
X-CRM114-Status: GOOD (  24.06  )
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

wire up support for passthru that takes an array of buffers (using
iovec).
Exposed via a new ioctl NVME_IOCTL_IO64_CMD_VEC for which -

1. cmd.addr is base address of user iovec array
2. cmd.vec_cnt is count of iovec array elements

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
Changes since v1:
- added new ioctl rather than reusing NVME_IOCTL_IO64_CMD (hch)
- dropped block-layer helper and open-coded in nvme instead (hch)
https://lore.kernel.org/linux-nvme/20220127082536.7243-1-joshi.k@samsung.com/

 drivers/nvme/host/ioctl.c       | 44 +++++++++++++++++++++++++++------
 include/uapi/linux/nvme_ioctl.h |  6 ++++-
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 22314962842d..54788b1b098e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -56,7 +56,7 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, u64 *result, unsigned timeout)
+		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -75,8 +75,22 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
+		if (!vec)
+			ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
 				GFP_KERNEL);
+		else {
+			struct iovec fast_iov[UIO_FASTIOV];
+			struct iovec *iov = fast_iov;
+			struct iov_iter iter;
+
+			ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
+					UIO_FASTIOV, &iov, &iter);
+			if (ret < 0)
+				goto out;
+			ret = blk_rq_map_user_iov(q, req, NULL, &iter,
+					GFP_KERNEL);
+			kfree(iov);
+		}
 		if (ret)
 			goto out;
 		bio = req->bio;
@@ -170,7 +184,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	return nvme_submit_user_cmd(ns->queue, &c,
 			nvme_to_user_ptr(io.addr), length,
-			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
+			metadata, meta_len, lower_32_bits(io.slba), NULL, 0,
+			false);
 }
 
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
@@ -224,7 +239,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &result, timeout);
+			0, &result, timeout, false);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -234,8 +249,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
-static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd64 __user *ucmd)
+static int nvme_user_cmd64_common(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			struct nvme_passthru_cmd64 __user *ucmd, bool vec)
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
@@ -270,7 +285,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &cmd.result, timeout);
+			0, &cmd.result, timeout, vec);
 
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
@@ -278,6 +293,19 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 
 	return status;
+
+}
+
+static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			struct nvme_passthru_cmd64 __user *ucmd)
+{
+	return nvme_user_cmd64_common(ctrl, ns, ucmd, false);
+}
+
+static int nvme_user_cmd64_vec(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			struct nvme_passthru_cmd64 __user *ucmd)
+{
+	return nvme_user_cmd64_common(ctrl, ns, ucmd, true);
 }
 
 static bool is_ctrl_ioctl(unsigned int cmd)
@@ -341,6 +369,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		return nvme_submit_io(ns, argp);
 	case NVME_IOCTL_IO64_CMD:
 		return nvme_user_cmd64(ns->ctrl, ns, argp);
+	case NVME_IOCTL_IO64_CMD_VEC:
+		return nvme_user_cmd64_vec(ns->ctrl, ns, argp);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..b2e43185e3b5 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -55,7 +55,10 @@ struct nvme_passthru_cmd64 {
 	__u64	metadata;
 	__u64	addr;
 	__u32	metadata_len;
-	__u32	data_len;
+	union {
+		__u32	data_len; /* for non-vectored io */
+		__u32	vec_cnt; /* for vectored io */
+	};
 	__u32	cdw10;
 	__u32	cdw11;
 	__u32	cdw12;
@@ -78,5 +81,6 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_RESCAN	_IO('N', 0x46)
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_IO64_CMD_VEC	_IOWR('N', 0x49, struct nvme_passthru_cmd64)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.25.1


