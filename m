Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7276DEF99FF
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=60jyQ1ZIQG8Pf4xFK6xEZaP994isrxae0+XCbgekpxA=; b=IN6wrNO6011MuvO1nbfUrO6AFn
	Kxo6QgtHwyzaPlSATfRjJLnA0KPC7xDCPvToZ+XWNzroaphkZLFTJ5j5zA+shKOs8mbeTAVM8lXhi
	a4Nbp8G7tRM3qGxWLm/7d4dmj9ijvHAdCPHBYCdBz9PzgKhqUpCn6vaC32r0zmqhkh7XqYl6lHWL7
	Mk3zs/xt/EafyDlxv7qPHHHWDogsFayHPcPTuwKWwWiPb2z0fM9MH+2AlVmsIi01nujOb8YaUr45J
	ZJi0Q82p9qJH4xAo+K29sFAWBpzwXFdbW9b2KaoXAQJjSHPbEv2kXLAY4EkmIgN8zoksFnJ1Q+fDd
	z8rmtQbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gu-00000004FRe-2Qnt;
	Sat, 14 Feb 2026 04:28:44 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gl-00000004F9h-1yEX
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:36 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-1271195d2a7so1945571c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043314; x=1771648114; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60jyQ1ZIQG8Pf4xFK6xEZaP994isrxae0+XCbgekpxA=;
        b=gWC4GcauV1dpOOGlH0KlT5OX40KwmZ58jeLwdJWzhDBy/NXAxjy/QSTt576vnlIJ0H
         1RcIspxWdZjKylkQefC9pCaLLSCzEZqIxe5DO5oLWE8t98rj98lzySEBjf4F2AGzsxKg
         7rt4EqngtZMEGnZtG3K8x3Z69/kz3Or1YA1xKMCI3XHGtTH53ke9/9DYLgpJIPZPiLYC
         7YsoxLz9Iisv8Fu+oy2/FZ9YqjhFJenRICtx8asvAlxdrAd1Mw0uM7Ji4KlTsd6RPEkd
         iusagX5NfF2R4Hd8fytHI7JqpdZe6whMARDUncmJmi3ILfFW8LOE5Qq3cHoeWDgjwRY4
         B6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043314; x=1771648114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60jyQ1ZIQG8Pf4xFK6xEZaP994isrxae0+XCbgekpxA=;
        b=Izro3rjEBucirKMi9tSu15Y6f8YebisfQbn7PP8tlDZeWIFPYmE5h2ws3Ek8O5rLcz
         rVjzXb1AtBvV0V1DrMZSxky8AL5vaWceiTFwMQtAia8YXDiTZ4MBCsvHA3JuYWKPmbT5
         iUSSUhP6dmhfpR6bTdgych5xeWAHiIV+5FZRJXNHU2KQcE+/I885rBqBezVDMK0mGA1P
         scXsfl98N+0bG1RjtoNlJOkfnNuLlEbFGBse2xiCJktCLmhupDGJk+RQ9auW71RxGkgp
         3RHnhD7V7R4Rdp0020SnwOAxCVaLs4j6sV5uagvKIQVAcKzaf1oHJrW2Q4fQkjMuRi0Q
         GUsg==
X-Forwarded-Encrypted: i=1; AJvYcCXBciGKHdM+e4p8SBfrOIeM/hA7fLMRXS7/2az8EgTMBfIyyLk2mE4/Jjg0mr+MTDyKAypHIkmXY7my@lists.infradead.org
X-Gm-Message-State: AOJu0YwfaPmcW2VzeGbDQzSWEp6dj4O0gjTj8Mxbk3MUjhlt5VNoQz83
	ekmnPRoyu5YLWzDZsA+YkYCExCKbSkJcCuYGuhj4pmevlvXXsMG8hg6jGJRHmzuG2lg=
X-Gm-Gg: AZuq6aLucfqXnOlqltzW8NS3AZCF/btC7VxosBHR+1C6eEXFCrwjKF1mBLvGJgLUsYn
	BQmWouknDA5KJk1/abyiArQs7Oz8LNgPXe7782hDaqZSkz0DgOS3JwpRfxGQGa+dKvJKG2sgGB+
	u7bNo8sRx380rDseB526uAibSSJ/6V6Wjiassh7oINWvgWsAkn6fioD9/Pdzhl1yF5hpXNjt3ED
	TN3wbeg4Omq/qyc0ayCKgGkUrRfoR4a3RoHausVPRb3omEho9KpE0X8evB7dFPK8lT4BgQaKi81
	bnfSVZUpX/k6Na/9FZao7jlMA4zGm+k+3Q+KS44NeBUwBVPVcp/RWx8ocG7SI5PJYEBRjMODKef
	rSiIqCKyiBQzZQYvZ8aldXZmO8r/CpMSYaF2z0qTwx6pjekwloArWtqmz0mniPectaI3JgF9l47
	dtIuVMkf+58qXOcMJR1Rq5pFqsv0hh0lON2uZHzA6HVwuzaQ==
X-Received: by 2002:a05:7022:793:b0:124:9acd:32d1 with SMTP id a92af1059eb24-12741b6348bmr821445c88.9.1771043314205;
        Fri, 13 Feb 2026 20:28:34 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:33 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 16/21] nvmet: Add support for CQT to nvme target
Date: Fri, 13 Feb 2026 20:25:17 -0800
Message-ID: <20260214042753.4073668-17-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202835_524178_36615FA8 
X-CRM114-Status: GOOD (  17.66  )
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

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
time limit for attempting Cross-Controller Recovery. CQT is added as a
subsystem attribute that defaults to 0 to maintain the current behavior.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c |  1 +
 drivers/nvme/target/configfs.c  | 31 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  3 +++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            |  5 ++++-
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 925a81979278..5077a9ddba44 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -743,6 +743,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		id->cqt = cpu_to_le16(ctrl->cqt);
 		id->ciu = ctrl->ciu;
 		id->cirn = cpu_to_le64(ctrl->cirn);
 		id->ccrl = NVMF_CCR_LIMIT;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 127dae51fec1..c9b7a2eeeee5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1637,6 +1637,36 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
 #endif
 
+static ssize_t nvmet_subsys_attr_cqt_show(struct config_item *item,
+					  char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cqt);
+}
+
+static ssize_t nvmet_subsys_attr_cqt_store(struct config_item *item,
+					   const char *page, size_t cnt)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_ctrl *ctrl;
+	u16 cqt;
+
+	if (sscanf(page, "%hu\n", &cqt) != 1)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	if (subsys->cqt == cqt)
+		goto out;
+
+	subsys->cqt = cqt;
+	/* Force reconnect */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
+out:
+	up_write(&nvmet_config_sem);
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cqt);
+
 static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 					      char *page)
 {
@@ -1677,6 +1707,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_vendor_id,
 	&nvmet_subsys_attr_attr_subsys_vendor_id,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_cqt,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
 	&nvmet_subsys_attr_attr_firmware,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a9f8a2242703..886083bb7a83 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1718,6 +1718,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	ctrl->cntlid = ret;
 
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->cqt = subsys->cqt;
 		ctrl->ciu = get_random_u8() ? : 1;
 		ctrl->cirn = get_random_u64();
 	}
@@ -1958,10 +1959,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	switch (type) {
 	case NVME_NQN_NVME:
+		subsys->cqt = NVMF_CQT_MS;
 		subsys->max_qid = NVMET_NR_QUEUES;
 		break;
 	case NVME_NQN_DISC:
 	case NVME_NQN_CURR:
+		subsys->cqt = 0;
 		subsys->max_qid = 0;
 		break;
 	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 0ed41a3d0562..00528feeb3cd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -265,6 +265,7 @@ struct nvmet_ctrl {
 
 	uuid_t			hostid;
 	u16			cntlid;
+	u16			cqt;
 	u8			ciu;
 	u32			kato;
 	u64			cirn;
@@ -342,6 +343,7 @@ struct nvmet_subsys {
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	u16			cqt;
 	u16			max_qid;
 
 	u64			ver;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fc33ae48d149..f6d66dadc5b1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,7 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_CQT_MS		0
 #define NVMF_CCR_LIMIT		4
 #define NVMF_CCR_PER_PAGE	511
 
@@ -368,7 +369,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[34];
+	__le16			cqt;
+	__u8			rsvd388[124];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
-- 
2.52.0


