Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DE8E7718E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Dec 2024 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1IcPfFbWoUBqvJSanhGuWYWlu2ObW6L/daxhAa6qLKk=; b=jQiIehKHLpglp7bdtLwQNH/ziv
	TFMTc7GSDku764UXl33exjYCExf8+pjU+MQ4A90A/Z1zioYJkyLZvLS6ic30FCcK7esXs4rUoWd1Y
	Cb9DJkdK2gBWM98mJUlE/lNOH6Dhcj27iPaon7aeMPVliVIHvIRGRoRKTTgIn0toKK8oKg1Yr5H7z
	bAnGpyLyGFaARD2aD+gsql6MwCyKxj9GVa6rHAQT+0bxcVgvyzdetEn69Ay/Y9pPEsywHFyZqwql4
	oU50C9KNC5sDzUEI2MBAHkulGReXh1IyemWBwswlsPx5uWWcTrEqeZhBlOwkPDOyg05g15KligIlK
	XKriIPPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQlNM-0000000Fd8P-3RJf;
	Thu, 26 Dec 2024 10:45:56 +0000
Received: from mx.swemel.ru ([95.143.211.150])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQlNI-0000000Fd5W-416T
	for linux-nvme@lists.infradead.org;
	Thu, 26 Dec 2024 10:45:55 +0000
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1735209946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1IcPfFbWoUBqvJSanhGuWYWlu2ObW6L/daxhAa6qLKk=;
	b=KotxGFUC7/FiHod128i8iympIKObgxdmAf0IjAZz62CZu1bmCyzCqDE7i06sOZYaSbtLXo
	WFjuAyBRteG7L2elOjzjS1nGlKPNH7rLzKQXZWTWbOTCAOBnijY3I39M1BTOUpfDiBGmN6
	/1xfrbx2bwshxk3pMqZJ/GQkRF9esHg=
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com
Subject: =?UTF-8?q?=5BPATCH=5D=20nvme=3A=20Enter=20string=20size=20calculation=20=E2=80=9Csubsysnqn=E2=80=9D?=
Date: Thu, 26 Dec 2024 13:45:35 +0300
Message-ID: <20241226104546.13705-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241226_024553_494326_61BF6BFF 
X-CRM114-Status: UNSURE (   8.91  )
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

When memory is allocated, the size of the string 
is calculated nvmet_subsys_alloc(...).
When memory was accessed, constant size was used.

Fixes: 95409e277d83 ("nvmet: implement unique discovery NQN")
Reported-by: syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a84181c81389771eb46a
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/nvme/target/configfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index eeee9e9b854c..2f74204d000e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2247,14 +2247,15 @@ static struct config_group nvmet_hosts_group;
 static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
 					     char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%s\n", nvmet_disc_subsys->subsysnqn);
+	return snprintf(page, strnlen(nvmet_disc_subsys->subsysnqn, PAGE_SIZE),
+			"%s\n", nvmet_disc_subsys->subsysnqn);
 }
 
 static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct list_head *entry;
-	size_t len;
+	size_t len, nqn_len;
 
 	len = strcspn(page, "\n");
 	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
@@ -2271,8 +2272,9 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 			return -EINVAL;
 		}
 	}
-	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
-	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
+	nqn_len = strnlen(nvmet_disc_subsys->subsysnqn, NVMF_NQN_SIZE);
+	memset(nvmet_disc_subsys->subsysnqn, 0, nqn_len);
+	memcpy(nvmet_disc_subsys->subsysnqn, page, nqn_len);
 	up_write(&nvmet_config_sem);
 
 	return len;
-- 
2.43.0


