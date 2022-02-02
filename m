Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49525C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 05:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=5V57cS9BxKfulTP7Ztma6csBIbEaR1UeGUMfSIpuxOw=; b=eN+jX2b6l1p3EXrrEX9JKg0zCt
	3MhBNtaEKdRRpd7g5e/76mhvdImLFuR8ygFpAwA3baN8CInfTXpAJfKeasYJCRNHXbog6Pwu0wRUY
	W4Gd9cVI+F77goenzASEDe9OSP0JFRCMMNOdZ5+qfUPvbTp2L4+GfdSmpCrue9Pcq3wQPL0st74KJ
	G6Pxz9/XVza3r+3GfoX4J4jBV4VIRGtcIf7EAOpA9qAtAffpe/csr04irWZsu84n1AxItNNwQ+8kP
	BgOLvHtQyT+qP/zodj8qLpuuCmk162nFRMr+c4t+UjE/An3RG1tfDBC5mrUWYRcghfs7K9OZMUyb2
	NAV8ioig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFUHf-00Ha4I-Oz; Thu, 03 Feb 2022 05:03:51 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFUHb-00Ha3x-4a
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 05:03:49 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20220203050343epoutp01d200a2c8ff7e04a72a0c1e4e6ff24f41~QLipC01BM1801818018epoutp01Z
 for <linux-nvme@lists.infradead.org>; Thu,  3 Feb 2022 05:03:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20220203050343epoutp01d200a2c8ff7e04a72a0c1e4e6ff24f41~QLipC01BM1801818018epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1643864623;
 bh=5V57cS9BxKfulTP7Ztma6csBIbEaR1UeGUMfSIpuxOw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=TVM2t5SMrJkQRFzFUWBDefsxmtmv/7d6LM4WV5MizZwxOQY0bEPw1ZTyee88IS+x2
 ul9XwFNhXpzJmT5pN12BiFO+awNzE3FfJDIVJOVfufp3EzEWG7EuzFd10R5uUZvhsl
 ObRSxUiPDfPOfQbqFmxZ48aJnshUieuv9HzQiwzc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220203050342epcas5p24b179676bbc72a81ec827057efe3808c~QLioxYTxf3129831298epcas5p2D;
 Thu,  3 Feb 2022 05:03:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Jq652732bz4x9Q9; Thu,  3 Feb
 2022 05:03:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DF.C5.05590.5226BF16; Thu,  3 Feb 2022 14:03:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220202103751epcas5p4914ecb890c2977eebe711ed7296940ba~P8dGeNnKv1455314553epcas5p4Z;
 Wed,  2 Feb 2022 10:37:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220202103751epsmtrp1cdb79879ecb184e4f16727258ad2f9e9~P8dGdgF_c3210632106epsmtrp1a;
 Wed,  2 Feb 2022 10:37:51 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-b4-61fb62254826
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 70.30.29871.FFE5AF16; Wed,  2 Feb 2022 19:37:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220202103750epsmtip10c5fe4ce9353651f142da62d0f3095ef~P8dFfBsZH2181821818epsmtip1t;
 Wed,  2 Feb 2022 10:37:50 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, joshiiitr@gmail.com
Subject: [PATCH v3] nvme: add vectored-io support for user-passthru
Date: Wed,  2 Feb 2022 16:02:52 +0530
Message-Id: <20220202103252.2103-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmuq5q0u9Eg9v7FS1W3+1ns1i5+iiT
 xfm3h5ksJh26xmjx9OosJov5y56yO7B57Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNo7f5HVsA
 W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
 ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
 7Iwp3/ewFbzXrdj7Pr2B8YRqFyMnh4SAicT5DydYuxi5OIQEdjNKvN62iRnC+cQoce36AxaQ
 KiGBb4wSEz9UwnT0zDwMVbSXUWLT7v9sEM5noI5FN4AyHBxsApoSFyaXgjSICDhJTH98DmwQ
 s4C5xLq7n8BsYQFniW3n17KAlLMIqEp8aBACCfMCldy8cJgNYpe8xMxL39kh4oISJ2c+gRoj
 L9G8dTbYDRICp9glFpzawgzR4CLx72YXVLOwxKvjW9ghbCmJl/1tUHaxxK87R6GaOxglrjfM
 ZIFI2Etc3POXCeQgZqD71+/ShwjLSkw9tY4JYjGfRO/vJ0wQcV6JHfNgbEWJe5OeskLY4hIP
 ZyxhBRkjIeAhsWlBOSQMYyVWv+lmmcAoPwvJO7OQvDMLYfECRuZVjJKpBcW56anFpgXGeanl
 8FhNzs/dxAhOiVreOxgfPfigd4iRiYPxEKMEB7OSCO/ehd8ThXhTEiurUovy44tKc1KLDzGa
 AoN4IrOUaHI+MCnnlcQbmlgamJiZmZlYGpsZKonznkrfkCgkkJ5YkpqdmlqQWgTTx8TBKdXA
 ZMojXVai+7zL8WqE38Ib1qdf22648tb92xVTm2arzS0sL843Nd5ojMs9OtlYoDW6RktQta+u
 gaknv+ZiU6fKn5abb1+ceDJvyZb/N9qbuu58t6/te6z967ZNd0G2mW5zxqKZOe0zIkriAppb
 X9Sf7giRCfmpwFzz0SDjuOm1oAvczI+yD58KdNbcwyYwO7LS5Vi+XXlkonBX4y1p49aKGY4q
 IpoT31nNTHm4YM100eW5QaIrph5kthILf38ieuGegvhfLMu+3j1e3K1kWFin7/No93/XpBuH
 pE4EHN8kztfxRti7mF3G8Od2Jd95/Afz1YPl08WPz/Pa6805qYj1hNnF9f2lfX6e99z/vlNi
 Kc5INNRiLipOBACsN3LWEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO7/uF+JBu/+KVqsvtvPZrFy9VEm
 i/NvDzNZTDp0jdHi6dVZTBbzlz1ld2Dz2DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObR2/zO7YA
 tigum5TUnMyy1CJ9uwSujCnf97AVvNet2Ps+vYHxhGoXIyeHhICJRM/Mw8wgtpDAbkaJ20t5
 IOLiEs3XfrBD2MISK/89B7K5gGo+Mkp8WXONrYuRg4NNQFPiwuRSkBoRAQ+Jlu8bmEHCzAKW
 Eh/uGIKEhQWcJbadX8sCEmYRUJX40CAEEuYVMJe4eeEwG8R0eYmZl76zQ8QFJU7OfMICYjMD
 xZu3zmaewMg3C0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwaGppbmD
 cfuqD3qHGJk4GA8xSnAwK4nw7l34PVGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJ
 JanZqakFqUUwWSYOTqkGprpzb5KCKk690CpQusN+hjORfdbr0ibppnOr1zlsMLpWe6J/w8UH
 DenJ65e9ahNd5tPCWpl94teEIgtF/Xs/t+6tn1dz4nTk56Vm9veLtU3mGavcXVq7tTvjWsQO
 p/PGM6+mvJLgkombkT5dMiUmefePj6nvO5dydEnNkXDMncjGu8nGMfHPinY1z1kms3jEjL4k
 HzuXb7BBID2jZkVLe8Hjr+4/L6SaHTmd+G6tCc9xia4mrpw5W1nE5mhXJUmkhO+MuO7S73xY
 aVaH6Z45axTrTt1S8+957CMQs/fDQk/bm+L5yw5w7f8e+09t0cTXQfPZ/Fed+B+Tb3V108wF
 27k/5e7cxbE+KbZ6Xe6RKiWW4oxEQy3mouJEAEE9LYu8AgAA
X-CMS-MailID: 20220202103751epcas5p4914ecb890c2977eebe711ed7296940ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220202103751epcas5p4914ecb890c2977eebe711ed7296940ba
References: <CGME20220202103751epcas5p4914ecb890c2977eebe711ed7296940ba@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_210347_570788_8C2B17BB 
X-CRM114-Status: GOOD (  24.31  )
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

This patch does not include vectored-variant for admin-commands as most
of them are light on buffers and likely to have low invocation frequency.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---

Changes since v2:
- remove wrappers (hch)
- update commit message (hch)

Changes since v1:
- added new ioctl rather than reusing NVME_IOCTL_IO64_CMD (hch)
- dropped block-layer helper and open-coded in nvme instead (hch)

 drivers/nvme/host/ioctl.c       | 36 ++++++++++++++++++++++++---------
 include/uapi/linux/nvme_ioctl.h |  6 +++++-
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 22314962842d..80ea4bd95be6 100644
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
@@ -235,7 +250,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 }
 
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd64 __user *ucmd)
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
@@ -278,6 +293,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 
 	return status;
+
 }
 
 static bool is_ctrl_ioctl(unsigned int cmd)
@@ -296,7 +312,7 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ctrl, NULL, argp);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp);
+		return nvme_user_cmd64(ctrl, NULL, argp, false);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -340,7 +356,9 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, argp);
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, false);
+	case NVME_IOCTL_IO64_CMD_VEC:
+		return nvme_user_cmd64(ns->ctrl, ns, argp, true);
 	default:
 		return -ENOTTY;
 	}
@@ -480,7 +498,7 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ctrl, NULL, argp);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp);
+		return nvme_user_cmd64(ctrl, NULL, argp, false);
 	case NVME_IOCTL_IO_CMD:
 		return nvme_dev_user_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
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


