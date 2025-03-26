Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BEFC36008
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Mar 2025 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PjXUOGWXY+dEUkurv+VbTf8nEAUGXROEdkAf6TL7DIo=; b=1PjmUIY3qo026OWexkuLT4jBXB
	i1fjgV/He3cdrB7F/FpMDCARBXgVUzbNkp2LMkGyz7n8dK4PY2AYpmBd/mfIbEjNSndOn1KS6boe0
	UsxVghcqcFLZtC0ksZ0cYnOYqd/XOATDtpOR2pu9eCKda0/IFvdShmrhhl5cJ8vGchCrvA2DbH9xU
	9fhOIJ753qZQ2sCr+htpIzcMoQxZf+MWHvjqRLDyZ9PB2zt2f6QlSTm8GLfAjNetxMCA1MIfNpEkY
	ocV1gQ1qd+yYZirVXbuib8K3KJ3iuF9Wtg8l+TlH640v3seDp5T+aOUJpM579yWQTc69w0Cr8JLRS
	fGEEWNQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNoG-000000089MD-01rx;
	Wed, 26 Mar 2025 10:16:32 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNn5-000000089CL-1THV
	for linux-nvme@lists.infradead.org;
	Wed, 26 Mar 2025 10:15:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742984107; bh=PjXUOGWXY+dEUkurv+VbTf8nEAUGXROEdkAf6TL7DIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wi+fRXn0vlqTGbsDsCqCf/OO72c4cxz78MqWCvsFE+t6RrunMMW4Tc3FunG61vZEQ
	 nC40zRQiEYYX5y4ErIKodiSsGmbWe19vMOHZJFNHpqu4v8WCR9KQ2uJCMuvrXrgR6g
	 I59Ja6KE17RNjDYRzWaqgX01j9jirawEr0xpUL0U=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 3C53A2C6; Wed, 26 Mar 2025 18:15:05 +0800
X-QQ-mid: xmsmtpt1742984105tcv5o0dar
Message-ID: <tencent_0E548E922D6CA7EC6F5789C998AF10CE0806@qq.com>
X-QQ-XMAILINFO: OakVxA/3u/8RmOETleq5qSYaxMMIZGSFHnTuqvXwD+wdwhyhxE3ajGIfwmEmYX
	 7rN/G8ggiWvIGXiq6qzeqkhu19z285WgraWDfHA2xlH0Xij4AfdR0uOulp46tASOUrcvkDyuf3Mk
	 +p+hc9sVa/+eXR9mKZ82HvCnI+MVxlSDLwOl+m3zWxcGJ5XjQD75SvFVHPj0axcafhq0+20woQwT
	 BwdNvBObmKGj5JfPHlbNlmooaZDiy9sAoPtYpoYXs5l1spBbspPdHxFDvwr6jZM1iDmJoF2vr6/i
	 v4kPWgYJnwkInJ8hG3wxJirJixPpkFxTVSQOLhBSwpWM8909p4xgMhAdT2+MJplO0lH9tgJwoZi5
	 4u352/QJmWSYgevQ3L3TY599RxTybjgtsaxchGyzpXZQNhfUEk0Q5OoMZbr7j4k5+/vQCNWiZ1Op
	 o+QPEC76E0KBQwZfc4SB58ppb7jPV0vDizTbh3sovw1NUEw1CIGiRJZ1FcdxHxeQe0YEu0aZ0qsV
	 0umS5y2RtZxQtXdg3sotFBmaZLaqJeYHfN1VfqMHa+QoXcacsf/hC4HobN/kT3jUppWZYEqYBwc/
	 X4jvW/9GMenGGTowETfGPKb2pBVsozHUD8rehlFIw9jtBui+K+6n5c0japyFVzdEsD9opXmpETsW
	 pvOBSydFZj19ky8u2WbyDJ7yaT0qP+on9wAYO5TSgCrxgSt0x3NwQkYVnscvVqGrHXUrQWieZbDp
	 /lRXUjHQGzBBCjxp86VcZOt0HeWl1p7QBM43NAcfvaOaDsy1jLtC78DeljYLiS+JZVxw/wIbz1jj
	 mpgtCI8qv8unColQed8KJlqpV/QfwFap3GeV7Dt9q01oTE4+74juLPPCbJUg+lLurDEPq9ER7r30
	 KCOLBs6O0zwcOGKEmwuKotwUGj390MJJQuXCccQoE3hGdax7tvHkS+siLxQl0PYeEAtcj5G2/QVs
	 P9nDz0yz0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 1/3] nvme: Add warning for PST table memory allocation failure in nvme_configure_apst
Date: Wed, 26 Mar 2025 18:15:02 +0800
X-OQ-MSGID: <20250326101502.1348301-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
References: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_031520_211578_7C5130FD 
X-CRM114-Status: GOOD (  12.60  )
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

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

Currently the function fails silently on PST table memory allocation failure.
Add warning messages to improve error visibility.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2d89fac86c5..fb0404fee551 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2678,8 +2678,10 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 	}
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
-	if (!table)
+	if (!table) {
+		dev_warn(ctrl->device, "Failed to allocate pst table; not using APST\n");
 		return 0;
+	}
 
 	if (!ctrl->apst_enabled || ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
-- 
2.25.1


