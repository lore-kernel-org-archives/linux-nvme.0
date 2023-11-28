Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463DDC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LpVEY8YkHjpDwIlEvEDHbaJFUum4pdbV7KMbI6JKmsM=; b=SfsBBUymC1lmSwumaH2IuA2O+9
	vI1B4DpD5khba4xxPnHGWtaLOdNBbtU8cvg+c5mapSEzr8iCkemPhTYY4giko5WFGWywxjbqPfXvd
	p77jw4zo8qqKJ35PUnPwLx+BMqU9VuV969JThzV0T46iyT0297jReQtNjZs729taivdX4SzSRxW4i
	pyyQIEkZOncuLGFY27voIB8XDysijRzFmH0PtKd7mBP1w4njxXR0phzRHb7T+X+ynC/hBRD4h7ngK
	P77j6jUZKxX2AZcs+NbCRnfVPg6XlNZC4M9lIok/Ve6eYVdSSAir+2WW65MrJhIVH8+H0HuIT5yJP
	eYmUPQRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r85JZ-006Lxz-1s;
	Tue, 28 Nov 2023 21:08:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r85JV-006LuH-37
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 21:08:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4B7636157C;
	Tue, 28 Nov 2023 21:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40750C433B8;
	Tue, 28 Nov 2023 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205693;
	bh=H1n0/0ZWiphOnQ/0+HECM1KvuLVot5qfm9D9IAn5bnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfrZB/3btONDC+l0vt/mvr/uMQg/clPtqt8h8ANgheRVGyCq23Vd/fB3oE3yTgWUp
	 OVelBnbuA+57s8FZb09HDfGJMJlls6UpqlfMF9X+4VSulGH1ZLiPn6wRaC5sEQVNVl
	 An/86an28YNcxozcPDvt+PbOspBKJYQm6LvPABFax5JuKclkhyBEyQbzJfGyw+ci/o
	 5uOfNOc9w+tiQajs2ILKqRO6U4CWfLvtIYvddXj5LDwmFZPkRHbBum1+9bzTcEsw1M
	 AB4It99NawDu1OpZJJEjEsmwXFNs956aEdXRFLs8O5zeQqvikfz3agCYX/uCjeKz12
	 5EdXLDs8AYdOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/25] nvme-auth: set explanation code for failure2 msgs
Date: Tue, 28 Nov 2023 16:07:28 -0500
Message-ID: <20231128210750.875945-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_130814_057208_C1BB461F 
X-CRM114-Status: GOOD (  10.51  )
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

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit 38ce1570e2c46e7e9af983aa337edd7e43723aa2 ]

Some error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 7c9dfb420c464..d67076e98b4bc 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -835,6 +835,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 
 fail2:
+	if (chap->status == 0)
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
 		__func__, chap->qid, chap->status);
 	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
-- 
2.42.0


