Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AC2C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYJVw2KOEOeRNl27dzNh93/57IU4aNAeeDjJhFbam0k=; b=oxRsEyNbjCo2UdoigaIblhycM1
	sxeV2zn+Z/2Fzn4tDRwbGvehNpLE2TZZYA7ryK6vzb7JKvmS2Q7KTY24ugwjPlpWQ4NfjkIhK1vb2
	HSyCrkpvuvBTQY/JGJ/D0k512LyEQKu5dkfZEtugwtsx2ITR+KzozMEKMSPeYNM3tRLsINuassX4+
	os3lRs1Qf57VmZieffVdj/w4cZlqAG6VBSJ88Rv2CQ1MK+M8iJVvf773fo/fdmiPTegMTk5Crczk9
	gUvTDCjfbVvQcz+Y8P8iMHWRK9P3ABkrCx+Tzwtih1Vi79cqyzueiktpDO8Ciwnq28BlPsvAHCZjZ
	B8JeoBwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr28-00BtEH-Kd; Tue, 17 May 2022 06:50:16 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr0f-00BsPo-N7
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:48:47 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220517064839epoutp031947c41e2916caacb72167e088f1757a~v0arJnEL30389803898epoutp03G
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 06:48:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220517064839epoutp031947c41e2916caacb72167e088f1757a~v0arJnEL30389803898epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652770119;
 bh=SYJVw2KOEOeRNl27dzNh93/57IU4aNAeeDjJhFbam0k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qge2yrA7OHjbbmtlaZ8VccIFg9cVEepti4UqNNcecExBTO4Fns/seWr0GgOAjjTxX
 /rKUZxlMc6dAzP1Vy3LbnxjCjh0sCU+FcgNNCWdeo9iL1T7pc0DgyZnDmWh6IVkhII
 E7CebLx+7/pbFbvK0ScYGpT+K9YA3pNAfwB5IvKg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20220517064839epcas5p34e127e89015662fdc2494bc213b0d53f~v0aq4Kptj0742007420epcas5p3M;
 Tue, 17 May 2022 06:48:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4L2RXh08hlz4x9QL; Tue, 17 May
 2022 06:48:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 96.63.09762.04543826; Tue, 17 May 2022 15:48:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220517053712epcas5p20c6a2b123709d7df1a1df8c9b1c91125~vzcSR16Re2529225292epcas5p2x;
 Tue, 17 May 2022 05:37:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220517053712epsmtrp24622078779ee7e686f3c4783ef825bc8~vzcSQ2avh0947009470epsmtrp2c;
 Tue, 17 May 2022 05:37:12 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-ee-6283454046ce
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 B6.1D.08924.88433826; Tue, 17 May 2022 14:37:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220517053711epsmtip11c363c65f074b452223bcb037e469f29~vzcRTJPSY1464814648epsmtip1d;
 Tue, 17 May 2022 05:37:11 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH 2/3] nvme: enable uring-passthrough for admin commands
Date: Tue, 17 May 2022 11:01:46 +0530
Message-Id: <20220517053147.7925-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517053147.7925-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTQ9fBtTnJ4OBPNYvVd/vZLG4e2Mlk
 sXL1USaL828PM1lMOnSN0WL+sqfsDmweO2fdZfe4fLbUY9OqTjaPzUvqPXbfbGDz6NuyijGA
 LSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
 ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
 dsbUpXsZCyZKVazbuJWlgfGZaBcjB4eEgInEjlelXYxcHEICuxklXvX/ZIZwPjFKPDu0lQ3C
 +cwoseLCc8YuRk6wjqcXX0MldjFK7Dm8hhGu6sLJa8wgc9kENCUuTC4FMUUEjCRuv40B6WUW
 8Je4sn4fO4gtLOAmsWrXSiaQEhYBVYm+j5UgYV4Bc4mpD06zQ6ySl5h56Ts7SAmngIXEvD0+
 ECWCEidnPmGBmCgv0bx1NtjNEgKP2CW+ntnHBtHrItF07RULhC0s8er4FqiZUhKf3+2FqkmW
 aN1+mR0SECUSSxaoQ4TtJS7u+Qt2GTPQH+t36UOEZSWmnlrHBLGWT6L39xMmiDivxI55MLai
 xL1JT1khbHGJhzOWQNkeEvd77zNBwqmbUWLdivdsExgVZiF5ZxaSd2YhrF7AyLyKUTK1oDg3
 PbXYtMA4L7UcHsHJ+bmbGMGJUst7B+OjBx/0DjEycTAeYpTgYFYS4TWoaEgS4k1JrKxKLcqP
 LyrNSS0+xGgKDO2JzFKiyfnAVJ1XEm9oYmlgYmZmZmJpbGaoJM4r8L8xSUggPbEkNTs1tSC1
 CKaPiYNTqoFpgnHhVL4Pz24kCZ2t/xo80+J23tlJuk8MO6uPnLHg4vktNkt8b9dyn6NdX40U
 z0ZJNKgXnlFQX/RnX+I0j02ap2c7nJ/3dYu8e8hthyNWXEYW82Jnvbgpe+vBFv0vk32jz57h
 rlp1KD+HZa3X7tct0x7+31dsVynKYvwywkFhTnTahb98p599edTFt1+J4Wqb1KZGYY7JMoY5
 Hjp80tuTzHeY3azXWv3oZNiej0uVT/TPvffwfjWr+jMOzj89nA/P7jz+5PA070kzhe/MTNp0
 7lv48dea5/skHLnPy7ryrbpil3fq89pPF14faGOqUsl6eLLNN/nkyof1HTsV12j/kv093b/A
 hMmvftmOKTYHeJVYijMSDbWYi4oTAdFXlu4dBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSnG6HSXOSwbtZohar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 WxSXTUpqTmZZapG+XQJXxtSlexkLJkpVrNu4laWB8ZloFyMnh4SAicTTi6/Zuhi5OIQEdjBK
 tF2+xAyREJdovvaDHcIWllj57zk7RNFHRoltjU+Bijg42AQ0JS5MLgWpEREwk1iwYB4LiM0s
 ECjR3XMfzBYWcJNYtWslE0g5i4CqRN/HSpAwr4C5xNQHp6HGy0vMvPSdHaSEU8BCYt4eH5Cw
 EFDJv28nGSHKBSVOznwCNV1eonnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlec
 mFtcmpeul5yfu4kRHM5aWjsY96z6oHeIkYmD8RCjBAezkgivQUVDkhBvSmJlVWpRfnxRaU5q
 8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MU15ZzZw49fhF0b1rmxY49bTcUF4R
 6npTZdo2ua6gtvw7Lkbbdv0L/b3nnty/PS5XGTcVO7T6rLrayxpg93jWjUfJrbqhVQHeGn8t
 096wrPRn7+3yXp9f2vf01tJlDfOYZPgj/8ReKfH4YceSm2nMEXu6VHaZC3dRt7ZlR/6jz1e4
 Qu7bGnofvhC94cXxqZNXH50Q3sLSbiiZ0bfq1bPF96JPblt0anbvlX71qdeabn6/MYH12pHr
 13MMnukKNNvOMCv/2X6h8xT/Jn27aQVLj6pHZ3lUpc9cvPpyoW+xxZukyRtmn65emxSRdOFs
 9l3uKZ99n/5OcZJcsO5yHe+FeTdm+m/Q+zpVZ972DvYGDSWW4oxEQy3mouJEAC7v5b7WAgAA
X-CMS-MailID: 20220517053712epcas5p20c6a2b123709d7df1a1df8c9b1c91125
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517053712epcas5p20c6a2b123709d7df1a1df8c9b1c91125
References: <20220517053147.7925-1-joshi.k@samsung.com>
 <CGME20220517053712epcas5p20c6a2b123709d7df1a1df8c9b1c91125@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_234846_181803_50CC746E 
X-CRM114-Status: GOOD (  20.14  )
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

Add a new opcode NVME_URING_CMD_ADMIN that userspace can use.
Wire up support for the case when this is issued over generic char
device node (/dev/ngXnY).

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c       | 54 +++++++++++++++++++++++++++++++--
 include/uapi/linux/nvme_ioctl.h |  1 +
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 114b490592b0..0f46dc7381a0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -569,6 +569,31 @@ static int nvme_uring_cmd_checks(unsigned int issue_flags)
 	return 0;
 }
 
+static inline bool is_ctrl_uring_cmd(unsigned int cmd)
+{
+	return (cmd == NVME_URING_CMD_ADMIN);
+}
+
+static int nvme_ctrl_uring_cmd(struct nvme_ctrl *ctrl,
+			struct io_uring_cmd *ioucmd, unsigned int issue_flags)
+{
+	int ret;
+
+	ret = nvme_uring_cmd_checks(issue_flags);
+	if (ret)
+		return ret;
+
+	switch (ioucmd->cmd_op) {
+	case NVME_URING_CMD_ADMIN:
+		ret = nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, false);
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
 static int nvme_ns_uring_cmd(struct nvme_ns *ns, struct io_uring_cmd *ioucmd,
 			     unsigned int issue_flags)
 {
@@ -577,6 +602,9 @@ static int nvme_ns_uring_cmd(struct nvme_ns *ns, struct io_uring_cmd *ioucmd,
 
 	BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
 
+	if (is_ctrl_uring_cmd(ioucmd->cmd_op))
+		return nvme_ctrl_uring_cmd(ctrl, ioucmd, issue_flags);
+
 	ret = nvme_uring_cmd_checks(issue_flags);
 	if (ret)
 		return ret;
@@ -670,6 +698,22 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
+static int nvme_ns_head_ctrl_uring_cmd(struct nvme_ns *ns,
+		struct io_uring_cmd *ioucmd, unsigned int issue_flags,
+		struct nvme_ns_head *head, int srcu_idx)
+	__releases(&head->srcu)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	int ret;
+
+	nvme_get_ctrl(ctrl);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	ret = nvme_ctrl_uring_cmd(ctrl, ioucmd, issue_flags);
+
+	nvme_put_ctrl(ctrl);
+	return ret;
+}
+
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags)
 {
@@ -679,8 +723,14 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct nvme_ns *ns = nvme_find_path(head);
 	int ret = -EINVAL;
 
-	if (ns)
-		ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
+	if (!ns)
+		goto out_unlock;
+	if (is_ctrl_uring_cmd(ioucmd->cmd_op))
+		return nvme_ns_head_ctrl_uring_cmd(ns, ioucmd, issue_flags,
+				head, srcu_idx);
+
+	ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
+out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
 }
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 0b1876aa5a59..6bcda1be6456 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -108,5 +108,6 @@ struct nvme_uring_cmd {
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
 #define NVME_URING_CMD_IO_VEC	_IOWR('N', 0x81, struct nvme_uring_cmd)
+#define NVME_URING_CMD_ADMIN	_IOWR('N', 0x82, struct nvme_uring_cmd)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.25.1


