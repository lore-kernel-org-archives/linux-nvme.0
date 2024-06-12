Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C4DC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bYjuWPJtQLDvvNKeuoBi+ek+WEDnKSAN6kpuXyK3u9k=; b=Lc0K9sq4PtMRBTt9vVIp7exRIP
	e334yy8J4jxaSgBpZimMuRuw99Zvl75TtGg6o3fG+dzFgHgT5SE1OfyS01oGfS3vS/desBNxdParn
	JwDklZDpsw+yP4nF6ux/HDruMVY4HzBTs2pUD+XC/isjjZeK5L8f3LMvISXoSESDDVil9X/qlPi39
	NntUMHlWQpsMflvtNpacvZooLdbI3EHvXmlAoK4FJlk8I7L441Ko9R1+T1pABnA1JudM2BmyfzfwQ
	orH6p6nWcf9FRQGebEE3luFfuNgGcuSaEg2n4otsmAu/3O7hpng784zqouR4VbZvM8mLWq9KU1oG9
	ZCDbYCmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOhm-0000000CtpE-2LMV;
	Wed, 12 Jun 2024 14:12:02 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOhj-0000000Ctnn-1J38
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 14:12:00 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12F62DACB4;
	Wed, 12 Jun 2024 16:02:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718200980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=bYjuWPJtQLDvvNKeuoBi+ek+WEDnKSAN6kpuXyK3u9k=;
	b=PD796aNpkXHvz8SAhnG7fTfPeHYl7rHIPpI2lEGEsNcS7uYKFqqp/1YgWIJnWX9tW4ExBO
	bAoFpATYy5TrdzbtMa4JtInjBqPMZdDbHv1F9RHQ1BBUFIXDNsWMX62x+OkbUHOempzkaC
	anYJdCIckPKsHpQssp83kRk9A8HAK1j0Sdh6AQQneicfUO19YKJFwTv+McAReEo/+Dybzo
	M21nty71dQPdaAK/R/UnxL+RCb5p8RHvhnzS+mtuVcX1z47YbL4dx76GId50TYuhX/m72t
	wgjnxOAgExDprlCgZKDLoxusSk/b/gGFimhh8YbdOIiVy+EHGJWJ/MRv2k8M5A==
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 12 Jun 2024 16:02:40 +0200
Subject: [PATCH] nvmet-passthru: propagate status from id override
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-nvmet-passthru-fix-v1-1-f583f8affa2f@suse.de>
X-B4-Tracking: v=1; b=H4sIAH+qaWYC/x2MSQqAMAwAvyI5G7Ct+1fEg2i0OVil0SIU/27xO
 AMzEYQ8k0CfRfAUWPhwCVSewWwntxHykhh0ocuiVhpd2OnCcxK5rL9x5Qerpirn2qy6My2k8PS
 U9D8dxvf9ALgLIIBkAAAA
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_071159_636679_132F0A2A 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
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

The id override functions return a status which is not propagated to the
caller.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
While reading up on something else, I discovered this part and it looked a bit
sus. Only compile tested.
---
 drivers/nvme/target/passthru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index bb4a69d538fd..f003782d4ecf 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -226,13 +226,13 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	    req->cmd->common.opcode == nvme_admin_identify) {
 		switch (req->cmd->identify.cns) {
 		case NVME_ID_CNS_CTRL:
-			nvmet_passthru_override_id_ctrl(req);
+			status = nvmet_passthru_override_id_ctrl(req);
 			break;
 		case NVME_ID_CNS_NS:
-			nvmet_passthru_override_id_ns(req);
+			status = nvmet_passthru_override_id_ns(req);
 			break;
 		case NVME_ID_CNS_NS_DESC_LIST:
-			nvmet_passthru_override_id_descs(req);
+			status = nvmet_passthru_override_id_descs(req);
 			break;
 		}
 	} else if (status < 0)

---
base-commit: 6bfd66808f973cf1bb234e54d0cd51a15bba2996
change-id: 20240612-nvmet-passthru-fix-5754c63f2938

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>


