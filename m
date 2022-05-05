Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A03FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 06:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ib7Saupcz/aIYpBCFrcB7+QodrAU2Lft1wfm1uZtabM=; b=QV+Pltermezuk2ovs1by2H3ziP
	UO4bqANCXVfsek3+c0P6m4WUP8JRu+e3wwz6fmO7qcFCbBN0YQHissYMLpk29hU5VjD/7Oe0XyLnH
	Atqcrs6GmnMHFxFT3pXRpRXnuf76GFD1YTjVPiWceoKLo8zc5qFqtB7ejDjyixw2erlcSeXBAeSuU
	WwTYNF7dF71ULyu8DXDMy862c343YGbLtMsAuTMBpSEwtmrmITRvvDhry1vFshGj5LE/PBY75pWw+
	HtQip4QBBnq5Ki+FwH9+QsD+xp1Tr6+3uBm2WRUoBfZEw5md1SbtJsaWGrph1I+QWMhntdOlA4ZJZ
	IFwRFqKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmUl8-00EA1O-Nc; Thu, 05 May 2022 06:14:42 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmUks-00E9uU-Ro
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 06:14:30 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220505061423epoutp037bbc539bff51eadce433ce876fc616f9~sINUglcx30216202162epoutp037
 for <linux-nvme@lists.infradead.org>; Thu,  5 May 2022 06:14:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220505061423epoutp037bbc539bff51eadce433ce876fc616f9~sINUglcx30216202162epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651731263;
 bh=ib7Saupcz/aIYpBCFrcB7+QodrAU2Lft1wfm1uZtabM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qv9O/nfkIY5vK2SxPBFWLZdPW2SPikMsKLJY8Zjh+31sP5xX4tXO21yRtse4P44rQ
 saHJvZ2Sm1bWoB8kxY9nJ6x2sicVEhwJost1tcXkoMV8FR5OtAh+fhb1bPGz0Utbdi
 Hylqhkl2usxDePtVKuycwhtkGOOLKYsutjD9wlDU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220505061421epcas5p21991254baf450fc581724ad23e574a4c~sINTcLEgo2128821288epcas5p2h;
 Thu,  5 May 2022 06:14:21 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Kv3Ld4CdCz4x9Pv; Thu,  5 May
 2022 06:14:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7F.EC.09827.93B63726; Thu,  5 May 2022 15:14:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220505061151epcas5p2523dc661a0daf3e6185dee771eade393~sILHy-gtd1769517695epcas5p2r;
 Thu,  5 May 2022 06:11:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220505061151epsmtrp20684764884270b665f0ba15c5f110d63~sILHyNEw01668816688epsmtrp26;
 Thu,  5 May 2022 06:11:51 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-ff-62736b392868
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D5.1A.08853.7AA63726; Thu,  5 May 2022 15:11:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220505061150epsmtip2e512a4614935dc31b296ee79ab22e635~sILGM4Mhq0280102801epsmtip2X;
 Thu,  5 May 2022 06:11:50 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: [PATCH v4 5/5] nvme: add vectored-io support for uring-cmd
Date: Thu,  5 May 2022 11:36:16 +0530
Message-Id: <20220505060616.803816-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505060616.803816-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmlq5ldnGSwapXchZNE/4yW8xZtY3R
 YvXdfjaLmwd2MlmsXH2UyeJd6zkWi/NvDzNZzF/2lN3ixoSnjBaHJjczWVx9eYDdgdtjYvM7
 do+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5AI4o7JtMlITU1KLFFLz
 kvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVVIoS8wpBQoFJBYXK+nb
 2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ3yceoil4LNwRd/3
 8AbGGwJdjJwcEgImEvOuNzF3MXJxCAnsZpR4uPQIlPOJUeLOg4mMEM43Rom9G44AORxgLQ/2
 CUPE9zJKtK1rYYdwPjNKTG2fzwxSxCagKXFhcinIChEBeYkvt9eygNQwC5xllJh26xArSI2w
 gLPE/pcSIDUsAqoSO66vYwKxeQUsJS4dvsQCcZ68xMxL39lBbE4BK4mOo70sEDWCEidnPgGz
 mYFqmrfOBrtaQmAhh0Rb10FmiGYXiZZrVxghbGGJV8e3sEPYUhKf3+1lg7CTJVq3X2aHeKxE
 YskCdYiwvcTFPX+ZQMLMQK+s36UPEZaVmHoK4kxmAT6J3t9PmCDivBI75sHYihL3Jj1lhbDF
 JR7OWAJle0hM3r0HGri9jBKzV79kn8CoMAvJO7OQvDMLYfUCRuZVjJKpBcW56anFpgVGeanl
 8ChOzs/dxAhOvVpeOxgfPvigd4iRiYPxEKMEB7OSCK/z0oIkId6UxMqq1KL8+KLSnNTiQ4ym
 wPCeyCwlmpwPTP55JfGGJpYGJmZmZiaWxmaGSuK8p9M3JAoJpCeWpGanphakFsH0MXFwSjUw
 7bwQte2OxKuJH7x3ODI4HD0zv3912B0TRz9DobrHW9vOfKl0MF1zeomngMT/PYGXJRa+O8zs
 FvG/NpE5Wz91ouxH/q2eTs8uO73ZypUX+8mz99aPs4Z//f88vXLiIiu75++/p3nENx3/v0lq
 V8ed3sVbqr6IvrttFd6deDeYU+1DuKsO1xGJZdevbOPRuDJLwK+hUvzNJ39Wm8NBM2MDmQ6e
 P1/C5D9LwnK9gd7FmH2mzHvfMX9q+PA5eFp17NtoiaOlK37uF+M1Mua+LLTU21Vo04FZz6+8
 ivcQnfKMe5ZEZmQNo8Kao9qVrCrh0RYfdR99FpFyvlp8wN19aoV7w/Lsud+fNkSV3/m38PVq
 PiWW4oxEQy3mouJEAECDis5GBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvO7yrOIkg1lrzS2aJvxltpizahuj
 xeq7/WwWNw/sZLJYufook8W71nMsFuffHmaymL/sKbvFjQlPGS0OTW5msrj68gC7A7fHxOZ3
 7B47Z91l97h8ttRj06pONo/NS+o9dt9sYPN4v+8qm0ffllWMHp83yQVwRnHZpKTmZJalFunb
 JXBlfJx6iKXgs3BF3/fwBsYbAl2MHBwSAiYSD/YJdzFycggJ7GaUOPegEMSWEBCXaL72gx3C
 FpZY+e85kM0FVPORUeLQyVdMIL1sApoSFyaXgtSICChKbPzYxAhSwyxwk1Hices1ZpAaYQFn
 if0vJUBqWARUJXZcX8cEYvMKWEpcOnyJBWK+vMTMS9/BdnEKWEl0HO1lgbjHUuJ+92oWiHpB
 iZMzn4DZzED1zVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95Pzc
 TYzg2NDS3MG4fdUHvUOMTByMhxglOJiVRHidlxYkCfGmJFZWpRblxxeV5qQWH2KU5mBREue9
 0HUyXkggPbEkNTs1tSC1CCbLxMEp1cDU/6GZoXmRJKP11n1/fCL7L85cuUC3LsZfQj/DgeOp
 She/SFWcq/OO/zpuR6wPOzM9rG1LfCO/pTymZ9Ly9OXv2hr+6rvN+Dmj3qH2IOePp3OKJ69o
 W1HFmyb17cws3cimy+n2/3+GCbuv2rXCkG/b3aoZft0JzjsTwh1KZxT3HZZJEZhYFZN0ROQS
 /6TlVVb/XLaYMmyr4OQrObNsqdziG6HG6vm12zmin3FJrGp4cWCSntCT1WsCubyOWPW+tb9q
 eFm+bI73O43fb4wy3YurzqUnSq2Mfn/l9WeGR6e2nNNf1yT8ez2b/LOX+RGX/z0s8Hvgkddv
 ebXtY3HWP7710y9qaz69KanCnXtsxhMlluKMREMt5qLiRAD1Gj4k/AIAAA==
X-CMS-MailID: 20220505061151epcas5p2523dc661a0daf3e6185dee771eade393
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220505061151epcas5p2523dc661a0daf3e6185dee771eade393
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061151epcas5p2523dc661a0daf3e6185dee771eade393@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_231427_417406_CDA36F4F 
X-CRM114-Status: GOOD (  19.61  )
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

wire up support for async passthru that takes an array of buffers (using
iovec). Exposed via a new op NVME_URING_CMD_IO_VEC. Same 'struct
nvme_uring_cmd' is to be used with -

1. cmd.addr as base address of user iovec array
2. cmd.data_len as count of iovec array elements

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c       | 10 +++++++---
 include/uapi/linux/nvme_ioctl.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3687cb8d7428..8c3b15d3e86d 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -409,7 +409,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 }
 
 static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		struct io_uring_cmd *ioucmd, unsigned int issue_flags)
+		struct io_uring_cmd *ioucmd, unsigned int issue_flags, bool vec)
 {
 	struct nvme_uring_cmd *cmd =
 		(struct nvme_uring_cmd *)ioucmd->cmd;
@@ -446,7 +446,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(cmd->addr),
 			cmd->data_len, nvme_to_user_ptr(cmd->metadata),
 			cmd->metadata_len, 0, cmd->timeout_ms ?
-			msecs_to_jiffies(cmd->timeout_ms) : 0, 0, rq_flags,
+			msecs_to_jiffies(cmd->timeout_ms) : 0, vec, rq_flags,
 			blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -557,7 +557,11 @@ static void nvme_ns_uring_cmd(struct nvme_ns *ns, struct io_uring_cmd *ioucmd,
 
 	switch (ioucmd->cmd_op) {
 	case NVME_URING_CMD_IO:
-		ret = nvme_uring_cmd_io(ns->ctrl, ns, ioucmd, issue_flags);
+		ret = nvme_uring_cmd_io(ns->ctrl, ns, ioucmd, issue_flags,
+				false);
+		break;
+	case NVME_URING_CMD_IO_VEC:
+		ret = nvme_uring_cmd_io(ns->ctrl, ns, ioucmd, issue_flags, true);
 		break;
 	default:
 		ret = -ENOTTY;
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 04e458c649ab..0b1876aa5a59 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -107,5 +107,6 @@ struct nvme_uring_cmd {
 
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
+#define NVME_URING_CMD_IO_VEC	_IOWR('N', 0x81, struct nvme_uring_cmd)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.25.1


