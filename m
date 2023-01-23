Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1613C25B50
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrS+1KG7KfQXCzTcZRauBvj5GxNfks7sKAZ8Wf7Qo6w=; b=XnILGqSinWcm2oyJzR9ZAnC6rX
	OdV9Hjg5/y/XVMX+SSFdizycLmbea+pTo+8H8a36/vXxa0OUjK4depw/0GD8vhHVniUtOXzfwVOOD
	g2x5ENxL1tCrFq2azwbcAliDSRJqu3OXcy9NtkkSVBea/0oi62i3Z2uZ0u+/eDnRgQMswTUFYnlgf
	Uvzk3+gVPBdUnQ7bY9YCYDtzoUcm52sFg3/1tabn8WM8j41fyvqttTnJieBp35eKeCvN4yT5HJVwh
	kc9eLzk50MlCPCTFmoKjFRAwdO8v4l3wj0yv6WEQdjih/zOkZ66Mib5KtBN0NF3PUuaPiwlnylBbh
	j815WBig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJu4O-00GpLI-OF; Mon, 23 Jan 2023 10:28:56 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJu0h-00GnfD-7u
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 10:25:12 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230123102458epoutp021f2635cedae91df820f90675c3e2ca1f~86SMX80re1647716477epoutp02X
	for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 10:24:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230123102458epoutp021f2635cedae91df820f90675c3e2ca1f~86SMX80re1647716477epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1674469498;
	bh=IrS+1KG7KfQXCzTcZRauBvj5GxNfks7sKAZ8Wf7Qo6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LopGNSq58HJFucVUnVlTaie0Gmf0Sjsm7oShU/SYgvEpHA8a1q2oqGaVg35ruFwid
	 D/oGoArtvFWHI9sjpPrk3vq2994ZXU7MbvFwdi6EyGe1VfeQ/ft4+ro79kIxO3GYms
	 X+c41enS0S6F/s3zTjCDMk5fypoadK1lvtaI+aDw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230123102458epcas5p2925670b364328ad3905ce94b3cf021c8~86SMGbKAZ3159431594epcas5p2c;
	Mon, 23 Jan 2023 10:24:58 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4P0mST01XPz4x9Py; Mon, 23 Jan
	2023 10:24:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	38.5C.55678.8706EC36; Mon, 23 Jan 2023 19:24:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230123102456epcas5p3e0cebc4b2c75115c12de8078a14936ac~86SKyuqAe3073230732epcas5p3K;
	Mon, 23 Jan 2023 10:24:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230123102456epsmtrp1204cfc146c1eb8289e1e6154781d199b~86SKyI_WZ0755007550epsmtrp1o;
	Mon, 23 Jan 2023 10:24:56 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-ec-63ce6078659a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	12.B2.05839.8706EC36; Mon, 23 Jan 2023 19:24:56 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230123102455epsmtip17ff01c2841cb7cd6eff718f193985e8b~86SJ6vAOQ1699816998epsmtip1B;
	Mon, 23 Jan 2023 10:24:55 +0000 (GMT)
Date: Mon, 23 Jan 2023 15:54:31 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Keith
	Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Message-ID: <20230123102431.GA11000@green5>
MIME-Version: 1.0
In-Reply-To: <20230119164128.2159217-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTQ7ci4VyyQe87S4uVq48yWUw6dI3R
	4szVhSwW85c9ZbdY9/o9iwOrx/l7G1k8Nq3qZPPYvKTeY/fNBjaPcxcrAlijsm0yUhNTUosU
	UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
	9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz1px8ylwwVa5i
	64zTbA2MFyS7GDk5JARMJOZcesHWxcjFISSwm1Hi+o+drBDOJ0aJ/4t3MkI43xgl+puXM8O0
	HJu+kQUisZdRYumaZ8wQzhNGiUlvJwFlODhYBFQlfn/SBjHZBDQlLkwuBekVEVCUOA8MABCb
	WSBZ4uvpI+wgJcICLhJzdpuAhHkFtCWWnv3BDmELSpyc+YQFxOYUMJeY0XiMEcQWFVCWOLDt
	OBPIVgmBt+wS875vZIG4zUXi6qwLbBC2sMSr41vYIWwpiZf9bVB2ssSlmeeYIOwSicd7DkLZ
	9hKtp/qZIW5Ll5h94hkLhM0n0fv7CRPInRICvBIdbUIQ5YoS9yY9ZYWwxSUezlgCZXtI3Jo8
	CaxVSKCLUWLJH84JjHKzkLwzC8kGCNtKovNDE+ssoA3MAtISy/9xQJiaEut36S9gZF3FKJla
	UJybnlpsWmCUl1oOj+Hk/NxNjOC0qOW1g/Hhgw96hxiZOBgPMUpwMCuJ8J5ZfDpZiDclsbIq
	tSg/vqg0J7X4EKMpMG4mMkuJJucDE3NeSbyhiaWBiZmZmYmlsZmhkjivuu3JZCGB9MSS1OzU
	1ILUIpg+Jg5OqQYmtTXhvRksHbn9TmHXO+WrFa9mmU/gs54d1p2x0ve7UPemCtWDMy3m6WhE
	B+zhPasdUu/YwayWMe92p9j72n77n2u9Z6zpMd6/Puh7zWfJRysmd2wO0gisjfS3nbpE9HGW
	0rsNX3zsCzi2PvAWr5vua6B2ICZ5Y63YNQO1mbwREZGWz3kaGw10L1gqzP60pOIf4ydRtSVa
	0dkfmRQ2P1my/EjV+ZCbj9f5VUs9Nf5zxNJNJcyu2WP/DYcTn4osXZ5kPeksTwt7Uj2PLfCu
	55L8x49qy3zWn+43Ewtx/nQ54LXn20a/76tvuCuWJMlah01yuM0jsGLS9CtXVgmtfce9avrD
	u9pXXp5oyZebcE2JpTgj0VCLuag4EQD0E33+FAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnG5Fwrlkg7erVSxWrj7KZDHp0DVG
	izNXF7JYzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8zl2sCGCN4rJJSc3JLEst
	0rdL4Mq41P+CveCUdEX3gsuMDYzzxbsYOTkkBEwkjk3fyNLFyMUhJLCbUeLx5neMEAlxieZr
	P9ghbGGJlf+es0MUPWKUuDxvKlsXIwcHi4CqxO9P2iAmm4CmxIXJpSDlIgKKEueBjgCxmQWS
	JX43t7KClAgLuEjM2W0CEuYV0JZYevYH1MQuRol7T2eyQSQEJU7OfMIC0WsmMW/zQ2aQXmYB
	aYnl/zhAwpwC5hIzGo+BXSkqoCxxYNtxpgmMgrOQdM9C0j0LoXsBI/MqRsnUguLc9NxiwwLD
	vNRyveLE3OLSvHS95PzcTYzgQNfS3MG4fdUHvUOMTByMhxglOJiVRHjPLD6dLMSbklhZlVqU
	H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT4pOgNbr6IknX6/kZo/sS
	hNQ2b475wvjhwn/xqU+sn3ftP3c5ZZG5arNmNP/tR6u4NBmlmKIm+GR5T1A7MXGil7jRxfDE
	Gf818oP6VR7YaM8sb2NI5RPf0fK775lqr+WFA5tKLEWU9xZc+lK0+Ytk8mKBWRwrfJZZNfz+
	ZMPC5bbnVrDHw4WsSruf3Ylpefz33+Y5d/hsLI+F2+REsz5RvBH3YkPz9i8iVTx7+q6aPFhr
	emS1gq6B/sZ/6g4vHX5vmqpr7XG1Y+vkZslJJwW5tGtWri5a2cBnlvG4I1kr/pJqmrnOU/Hl
	6+8tCHg72Td+Ut+HrVknj51UWLjcOjDjXxFjo/t+m5W8nqv7T6QosRRnJBpqMRcVJwIAQxrE
	OuMCAAA=
X-CMS-MailID: 20230123102456epcas5p3e0cebc4b2c75115c12de8078a14936ac
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_ae12_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb
References: <CGME20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb@epcas5p1.samsung.com>
	<20230119164128.2159217-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_022508_840912_A8964174 
X-CRM114-Status: GOOD (  16.45  )
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

------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_ae12_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Jan 19, 2023 at 08:41:28AM -0800, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Instead of appending command effects flags per IO, set the known effects
>flags the driver needs to react to just once during initial setup.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> drivers/nvme/host/core.c | 83 +++++++++++++++++++++-------------------
> 1 file changed, 44 insertions(+), 39 deletions(-)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 7be562a4e1aa7..d7d2c2b342ba4 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -1060,41 +1060,12 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> }
> EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
>
>-static u32 nvme_known_admin_effects(u8 opcode)
>-{
>-	switch (opcode) {
>-	case nvme_admin_format_nvm:
>-		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_NCC |
>-			NVME_CMD_EFFECTS_CSE_MASK;
>-	case nvme_admin_sanitize_nvm:
>-		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK;
>-	default:
>-		break;
>-	}
>-	return 0;
>-}
>-
>-static u32 nvme_known_nvm_effects(u8 opcode)
>-{
>-	switch (opcode) {
>-	case nvme_cmd_write:
>-	case nvme_cmd_write_zeroes:
>-	case nvme_cmd_write_uncor:
>-		 return NVME_CMD_EFFECTS_LBCC;
>-	default:
>-		return 0;
>-	}
>-}
>-
> u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
> {
> 	u32 effects = 0;
>
> 	if (ns) {
>-		if (ns->head->effects)
>-			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
>-		if (ns->head->ids.csi == NVME_CAP_CSS_NVM)
>-			effects |= nvme_known_nvm_effects(opcode);
>+		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
> 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
> 			dev_warn_once(ctrl->device,
> 				"IO command:%02x has unusual effects:%08x\n",
>@@ -1107,9 +1078,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
> 		 */
> 		effects &= ~NVME_CMD_EFFECTS_CSE_MASK;
> 	} else {
>-		if (ctrl->effects)
>-			effects = le32_to_cpu(ctrl->effects->acs[opcode]);
>-		effects |= nvme_known_admin_effects(opcode);
>+		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> 	}
>
> 	return effects;
>@@ -3122,6 +3091,44 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
> 	return ret;
> }
>
>+static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
>+{
>+	struct nvme_effects_log	*log = ctrl->effects;
>+
>+	log->acs[nvme_admin_format_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
>+						NVME_CMD_EFFECTS_NCC |
>+						NVME_CMD_EFFECTS_CSE_MASK);
>+	log->acs[nvme_admin_sanitize_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
>+						NVME_CMD_EFFECTS_CSE_MASK);
>+
>+	log->iocs[nvme_cmd_write] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
>+	log->iocs[nvme_cmd_write_zeroes] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
>+	log->iocs[nvme_cmd_write_uncor] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
>+}
>+
>+static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>+{
>+	int ret = 0;
>+
>+	if (ctrl->effects)
>+		return 0;
>+
>+	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
>+		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
>+		if (ret < 0)
>+			return ret;
>+	}
>+
>+	if (!ctrl->effects) {
>+		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);

ctrl->effects is not getting freed if controller does not support the
commands-supported-and-effects log page?


------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_ae12_
Content-Type: text/plain; charset="utf-8"


------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_ae12_--

