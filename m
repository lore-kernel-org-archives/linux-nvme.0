Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAFDE6BF3C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LdJVqXRIK4MPnW0UBX/tzXNFanNilVzCHZaDiU6kEj8=; b=urMz3PgruR04D+4+vGubcQS3uK
	CDoOxJS3QoWevLIxO2N5gdm/KvdqZqKnX6noL0+arv0MvMn586wURIi+49jqrHRYnG3fyFhXxJOmh
	DFEncEzdo5Pb7T6a5w1vzmzenBdDNg8ZZhOSlUUk2uZqAfriXg0i1dTfRwvYP3zzJ6Hqq3zmTwDn7
	H+RPSQNtTW1OwXlwBti8Eik00cYC/kMZ+4Mn6KpnqvgD+Ll/Xm3hkUKGrIKpLY3cwdveJEeutTGZj
	oSTAI4w0t97kMa/pbNEaInty5WN/OsNgrts9Qbqz7+oRLgVAcE/P/RpPk2fCBSIAAjLiwUyuCFYEs
	kFau9pxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6d-0000000237g-2EV1;
	Fri, 30 Jan 2026 22:36:47 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6S-000000022rZ-1o41
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:39 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-11f1fb91996so1773869c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812596; x=1770417396; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdJVqXRIK4MPnW0UBX/tzXNFanNilVzCHZaDiU6kEj8=;
        b=WyFYNHX7eLZ6sqEH+ia8rJgpGdfn0+vbHcO6xDF9m3S+Zd13eTGxPWOyndFMJ7vXRA
         LPG7ri6+IXpGJpjDZ/sn52u6J9jeLyD0bJkwWkLYhNOvzERZN7TLpCezxSbWNmlEy8O7
         dXh29db0eRT2Eupy7HvTW6HkYz3NEOTWkZfM6o0cNMRtqC5yINOL6eYjL911A2sjwoR9
         BUVzb/gDSMSYOldFEtzNnYNaRViKK00qjoHbRzcQW5lM7rv6zM75f6cpsUzhAvwO9x4u
         atwzj59PeTwjQ2mh1LerK5P0bsoV0cSimQPhN3kAzbvKLwt5y9oaRKrPzZvyVjGClAse
         GKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812596; x=1770417396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LdJVqXRIK4MPnW0UBX/tzXNFanNilVzCHZaDiU6kEj8=;
        b=uXrSQRQvHw7euxT/avKU2TtzahqrsE2fTZEVzwQ8I1YEhIMPCj3HRwT1uqvpQ+kbzE
         wrAnk4bsodED49pnucWoqiBDMhFKe5qxY4Dmx4cGGh1LWp4R9jt+YhwkpUIVoUS95xTS
         KT0RIU+n1TknJta+u0lCqnIhM8IlOhYfoGGhVhqRu1zhoFCbBHaRIFf5efA9lfFOGk0z
         pCzDSzZjx3Xj8T+EDgTX5leuHUvy7jRDQq7tNwe58mp73CtARzscJQa5iTpZH5q6ZiW5
         NolDKBGa9Br8DJCVLtp5e5gRS7OWMoPkLHGBIuSMqXAOwqEqiTrD0VC35bnOglg08KCQ
         XT9g==
X-Forwarded-Encrypted: i=1; AJvYcCUeNIelPk/UzxWVj4O4btBdXAmoeoHeRVNpLuRSw0HZVVbhtqBOGQ5QsMQ3zfaKPjJIo+0hHNY7iTpA@lists.infradead.org
X-Gm-Message-State: AOJu0YyrUoR/JRciKBL5hDjOx4oEbP0dUZa+G/lZlNpxpyQjPie6MzdC
	d0cNFJBcKvpUiH5M86cP1PY7GiiwGM99AbEU4XaMHZMTCW2/36kXfkeT0V1WAxSIFWc=
X-Gm-Gg: AZuq6aKiRcexDld3qrug6BvbK6OYE9bH3a9TT/nKJl9Ztykbtl2gxfFxGONLQfCwmqa
	5AFwGJ6dtiwUgSN+62KqfnQ/QxAKtGyKp3/4lA5P1isHbZPpw41sjAemkLTIQ5f26SBjeTmkkd7
	tSozcbnDW60lqTCZg7wdx2TCaZX8OdStAjgQja8zkF83lNT3YlawCezB3SEVF93bdInt4rM0z7z
	f30LMJZuXKCAc9zKbG+L51ajx+2SvAIzsG7SY0fcu4hx8Zw1lZ9IG8jikHR7wxkH/vfOwmIPAyD
	alzoYW8mmQs+hV8/v8CXBpqZ2RlAuehLDT5UBSfabPCYkVbS8MYTQV69uW75Xtmtk8hl0C4N1H7
	3awc0L7WQiYzCoDSXhF8jbyXUSUHGyjgmNcol95GQ0FRG6EnvaRmzNJvd36Ya9vS9ri94/Z81uM
	ZCDnzvm1B2li1Csr8WCQSFMzenkwBfQRzd9A==
X-Received: by 2002:a05:7022:606:b0:11b:d4a8:d24d with SMTP id a92af1059eb24-125c0fbc90emr2380277c88.12.1769812595440;
        Fri, 30 Jan 2026 14:36:35 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:35 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 13/14] nvme-fc: Use CCR to recover controller that hits an error
Date: Fri, 30 Jan 2026 14:34:17 -0800
Message-ID: <20260130223531.2478849-14-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143636_677793_72BDEA7A 
X-CRM114-Status: GOOD (  14.91  )
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

An alive nvme controller that hits an error now will move to FENCING
state instead of RESETTING state. ctrl->fencing_work attempts CCR to
terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTING
and continue error recovery as usual. If CCR fails, the behavior depends
on whether the subsystem supports CQT or not. If CQT is not supported
then reset the controller immediately as if CCR succeeded in order to
maintain the current behavior. If CQT is supported switch to time-based
recovery. Schedule ctrl->fenced_work resets the controller when time
based recovery finishes.

Either ctrl->err_work or ctrl->reset_work can run after a controller is
fenced. Flush fencing work when either work run.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f8f6071b78ed..3a01aeb39081 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -166,6 +166,8 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
+	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -1866,12 +1868,59 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	}
 }
 
+static void nvme_fc_fenced_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
+			struct nvme_fc_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
+static void nvme_fc_fencing_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl =
+			container_of(work, struct nvme_fc_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (!rem)
+		goto done;
+
+	if (!ctrl->cqt) {
+		dev_info(ctrl->device,
+			 "CCR failed, CQT not supported, skip time-based recovery\n");
+		goto done;
+	}
+
+	dev_info(ctrl->device,
+		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
+		 jiffies_to_msecs(rem));
+	queue_delayed_work(nvme_wq, &fc_ctrl->fenced_work, rem);
+	return;
+
+done:
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
+static void nvme_fc_flush_fencing_work(struct nvme_fc_ctrl *ctrl)
+{
+	flush_work(&ctrl->fencing_work);
+	flush_delayed_work(&ctrl->fenced_work);
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
 	struct nvme_fc_ctrl *ctrl =
 			container_of(work, struct nvme_fc_ctrl, ioerr_work);
 
+	nvme_fc_flush_fencing_work(ctrl);
 	nvme_fc_error_recovery(ctrl);
 }
 
@@ -1896,6 +1945,14 @@ EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
 					 char *errmsg)
 {
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: starting controller fencing %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_wq, &ctrl->fencing_work);
+		return;
+	}
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
@@ -3297,6 +3354,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
+	nvme_fc_flush_fencing_work(ctrl);
 	nvme_stop_ctrl(&ctrl->ctrl);
 
 	/* will block will waiting for io to terminate */
@@ -3471,6 +3529,8 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_fc_fenced_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
-- 
2.52.0


