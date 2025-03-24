Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EAEC3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1sv49oDN1xKsV2NUXgnCogWe3PpX1iIJir56ZLLLVGA=; b=Ue+8zZiEwvFn795S4lvYTDq1W4
	pbh5oXxzcujT12v07ohIWNLxSM3jkOnYhX7zNOUxzz5qevfwXTW25RMAsSRW855vVz4wZsc0z5Qbz
	gINrWElS/gNmtpH3kwd2mGiw3QX7Jkm9yF+28EIkT4GMiNYJSrJeCbWjC9AHn5fJKYSov4dAXWZtQ
	ArmKE578AQgu5G8+rdVliBeWZsPfegI0Gt0zyghpfEueJBx2rUd2tz371omuQBFmIZpnRjNLY5NqY
	kQ9ColSQIDnnG00bCbKzjs7Z5RI3pbEdk11iSDGZJLwNy9CXlSUzMc1vdCYycd2hhiKXRS5KYiNaF
	D/4wezag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvc-00000003rH1-08Oj;
	Mon, 24 Mar 2025 17:49:36 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvZ-00000003rEQ-27Si
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 17:49:34 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso10161381a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838572; x=1743443372; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sv49oDN1xKsV2NUXgnCogWe3PpX1iIJir56ZLLLVGA=;
        b=BWUaiTnhmDMeazcbH+C9rDJvqPfJLCY0utM19UKgAsc4fdNf927nO0t0/8XkvfyUYe
         3HK4b3MSeTe7xOtQGb7ZP6Hm98w61MQONxs1P6ATqZmwjUW6DFRuiF8NuJqXeq6bFSas
         t46WrbV3EhUasgDxVPA4KlJUC0RJoXGOCcCZNzoqsKG7r9IMelFkmC5AHYFn/b4gzIYN
         5FqgX/eNRnzuMCLHN7o55ujWnPENjiboCEwfe0NaYU2UVmSGYLnT8O6MDF7ZRon171Xa
         hTj+BlzxhT0tsW9m/gIoZZ8nu5jcFYf3IIgnyiFCKvIWdcTVCPUud7ypW5u2GE0ONNhZ
         9rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838572; x=1743443372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sv49oDN1xKsV2NUXgnCogWe3PpX1iIJir56ZLLLVGA=;
        b=tnJRYZcjtVeUdhGubctIo2O4toFFpLes4RXpqs1c2hTSbj+mTPVm9W3paXTFLl1QGw
         yUavxsNyarJK8BW4Uj4UXywhtqDMBBCkfx4NTigksEyYhTc4i+D6pYXW4ui9EQpfGf1Z
         6+mkZNDItNZXvpMFjyVcJyEIOVK9cBa9//vj9ApIpBXuTenEUhzYkyijXVUZ2v5uqhh+
         qQRm4cvNEMVpAbgkBWwA9PlJ6uvDeXUqIPVdfKMyuaSwdQJv4Xa8UwJ1t2k3bAw0BBFJ
         y1v7f1Mi8lx5/Kvm1kdiNV/1BlhKB37+8EDPagTkLp2TqvETz6OyNYXcBVaBAb9rpNU7
         4HPA==
X-Forwarded-Encrypted: i=1; AJvYcCWMjIhFZ5BPGCI/iWoAZQKJnJ7K1I0qi3Fn675yu2EISn4/ng5ElFtNZ/pTMqvZv0lEd28QUiQ1QnW6@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6zgaFoMjSc9tGN/cQuD4HrOje8IxlyA6sTmrBc+3Gznxb/OtK
	52zzw5h566n5aBjYItSfuYMbioyEfyswHhC9isXrK6GjGWhTTMEHW0Ov0QgQOTA=
X-Gm-Gg: ASbGnct8W+D+OQDLBNRZXGH+cJYIe3KEh0RsH6cCm2YFpRG0FjR2I4xZEtxfAcQy7r+
	iNWNDZAbx2Vxtkx2gf696INL8mpHIUfB5C0UTVi7+3pKZhHfMFmuEFAnfx+5JC/tahmhxE2UoS+
	PbBumWkJg6zXOvvbaIPv5Yhp9cWnPf13C/FXCrjB43uPWURp5mSRSusSha0OPddye8zu7WpJ2yk
	eaD3+nWpSW8sfdeorH3j1d5OlljcdGcx8v8yQBgUJfMda7vdM9xGqj7ibPFBN/GUIIbLpFt/fqN
	iZooJz0lXRXfJCNKwXTe35SPX+jrethU/hiK8MgyiMkHI2YGvF/hRzr++wgXsQ==
X-Google-Smtp-Source: AGHT+IEe9Qsrj9Tx3gawv4u8ZXOCtS9RKc+Qk59288o/J5HEW/yh9fX1sI/yXy0vvkeFj8ITzHdkKA==
X-Received: by 2002:a17:90b:3844:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-301d43a2db5mr29060034a91.11.1742838572358;
        Mon, 24 Mar 2025 10:49:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:31 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 1/7] nvme-core: Read CQT wait from identify controller response
Date: Mon, 24 Mar 2025 10:48:54 -0700
Message-ID: <20250324174909.3919131-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_104933_551920_F6B6BE46 
X-CRM114-Status: GOOD (  14.51  )
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

From: Jyoti Rani <jrani@purestorage.com>

CQT wait tells us how much time in milliseconds nvme controller needs to
quiesce pending nvme commands after learning loss of connectivity. Read
it from identify controller response and store it in struct nvme_ctrl in
cqt field. ctrl->cqt will be used later on to calculate the total time
inflight requests need to be held before they can be safely retried.

Signed-off-by: Jyoti Rani <jrani@purestorage.com>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 1 +
 include/linux/nvme.h     | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8359d0aa0e44..f4b3c6a42e90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3364,6 +3364,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->oaes = le32_to_cpu(id->oaes);
 	ctrl->wctemp = le16_to_cpu(id->wctemp);
 	ctrl->cctemp = le16_to_cpu(id->cctemp);
+	ctrl->cqt = le16_to_cpu(id->cqt);
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e..7563332b5b7b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -344,6 +344,7 @@ struct nvme_ctrl {
 	u32 oaes;
 	u32 aen_result;
 	u32 ctratt;
+	u16 cqt;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2dc05b1c3283..7a94c01f0f06 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -361,7 +361,9 @@ struct nvme_id_ctrl {
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
2.48.1


