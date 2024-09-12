Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E26EE6453
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CkZftW9udwK5QvQtQyYpFTweETqgY12L5BpvZI9Bpkk=; b=dO6YXVsIa4TbkEbDhlyW4VrfqK
	Ymkxy4/i+Kzvla0pA9t4y0l9sKFMKuQ5YbuqKn/L+HmsLKrbg8IIYVrIw7WtPF4QQqoA17J+tRt8N
	CeBqXVsnyEMpmE88fJtEEOPip61Q/p/K+jZnu7L25QfGlO0uY8qDXjA2X7rv8W7bWd2QxgOgauam6
	4mW1N6tpOEs+njZ+DC/b7bMGlGpoaNqa2dfICPv2VZ80AW9Dto6XacUo41Tl1Vmw3Qpnp3zncGERu
	ryRYe/dsHBrTtc0e2f77Ir+ARNbMYi1W5Ty3rDrVU7l7V1wobH3VoWsFnqgm5Iq9ztGGTlxSaH25i
	oJiEMBwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYi-0000000C3Q4-2IIi;
	Thu, 12 Sep 2024 06:44:04 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYb-0000000C3LC-2aSL
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:43:59 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 496CFC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726123436; bh=CkZftW9udwK5QvQtQyYpFTweETqgY12L5BpvZI9Bpkk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=CqEXUoYF59L457BCFlcA6q+3baRBSBM7qKG0JHyzQhXPWVvZCR61LdMMYuWf+2yAA
	 r++qtbMyCJo/mHRhc2S/TtvCIunX7es+DW1+Vo7C+ULiC1HY1Sz2kpx4nrdk582qZc
	 M9PJU61rOli/I7kiQ4du0r3ZfQr91Ag2gSgGTQrUyZKcxFf2+6Ok29KAwiQv7sfq8A
	 hKPCTqcllY68gwfmTnwSBLuMK0q2LfxXhq507rANfJ9s/ooxL2gKphl/QQv9aTPKtD
	 JSqcaaWl5GdkWCF3YFL+2oXsxkP8WLEDslMMXoiaIYkfKDM5y35xQz2uPu7hQSZu5e
	 lG5CXdE1UJTdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726123436; bh=CkZftW9udwK5QvQtQyYpFTweETqgY12L5BpvZI9Bpkk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=D2APA0baoAF/u/1DGsBH1w5Q0R0NH3ByDc7Fl2XYwrYqg4ZHjfP99mS7D51TA154Y
	 s9fHndJ+VpTxmR9gI8HMD+POlmLkhihyMNBprH0oS4slumMTmch+f4CD8pj1yxU9BZ
	 cprzjWFf7AsYvo3jklRGoJDO8iwYn5CzcRK9GRhNyXhr3+zNWyDTcH0oGSSp78lCHk
	 HItuRr5Fx/ZRIdbOMHEQL4BlgKgxeF7H6tgDmt2CbkxOkzcs9Nv+CIqdTLzE9uHL8t
	 Zv2iAcTv5brNL7e8HR2wlmM7Bc4U5YPZnbjbfYPupf6+zcqR05fCFq7pKjsdHNd+CO
	 KbgsG0ZDSrZig==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 7/7] nvme: allow send fused commands
Date: Thu, 12 Sep 2024 09:42:59 +0300
Message-ID: <20240912064259.5228-8-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912064259.5228-1-d.bogdanov@yadro.com>
References: <20240912064259.5228-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_234357_853830_A5CAA60D 
X-CRM114-Status: GOOD (  10.33  )
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

Allow a user to pass fused flags for the commands.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/host/ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 1d769c842fbf..affedac90f04 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -220,7 +220,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
-	if (io.flags)
+	if (io.flags & 0xFC)
 		return -EINVAL;
 
 	switch (io.opcode) {
@@ -299,7 +299,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
-	if (cmd.flags)
+	if (cmd.flags & 0xFC)
 		return -EINVAL;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
@@ -346,7 +346,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
-	if (cmd.flags)
+	if (cmd.flags & 0xFC)
 		return -EINVAL;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
-- 
2.25.1


