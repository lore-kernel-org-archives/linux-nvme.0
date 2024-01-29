Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207F6C47DDB
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 11:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Cp2iPAGXUoqXPHaVx5499Qi46AZzBhL+IVoDxtjd8jI=; b=mX+EW/fBtCRnuTz8AT+8JkQG2f
	XcczgOr286vguuShxT0VV6Wp54rnsXMFsqJ1Twb9jH88D8WTZS0Cbnog9kNEZyXOnhuAd9ETf9MBQ
	J3vtupM5NCycO85PJkJH8rsqeZJyqLFC3OhZu4a1FxaBAdGHAeeZ0prJNGATbiTT2LgRVMQg7xivs
	HzXjJg0Jx1h/c8Iy3nuSKxeI6MqruhPj6ePQcZQs6GzbKTRFhoenBUypkMK3IB2abdVa6XWBwGxYJ
	9mQ/UBwSscB5ySJrm/FnqG2rkraPSPzI3iN4O2kf46DpbMRql5fheMslDjfKR9Ectg8zYLnYv+AWs
	6k6GtEuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPTu-0000000CLNz-32zB;
	Mon, 29 Jan 2024 11:07:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPTn-0000000CLJN-3vJ7
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 11:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706526421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cp2iPAGXUoqXPHaVx5499Qi46AZzBhL+IVoDxtjd8jI=;
	b=NtNnO0kx6VbhYCE7VfookrI0Ynke3Zs3NpEYE7s0nBadJ86kaFUHO0Y3/G9TexEVTTvZS8
	StOmzCThGmSlOgIBg/qIhJZcJyd//KRD+5S6IqoUK4mqG7l6bBOJV7Q5p+QHdHk7lMP/ey
	UjrxdfOzBqUY1m5wbTRpdmsH5hynzWY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-JbJgoQdlOiOQcV6zXJNfkA-1; Mon, 29 Jan 2024 06:07:00 -0500
X-MC-Unique: JbJgoQdlOiOQcV6zXJNfkA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-290eaca24d8so1222392a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 03:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526418; x=1707131218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cp2iPAGXUoqXPHaVx5499Qi46AZzBhL+IVoDxtjd8jI=;
        b=CDARZTH3RPt+0WN+TSs7SEMgSozMIQSpq5U6Tj7RrbEnaytlDZGKB2ouL9AGbJpRaM
         4mIHa8pA9lM8o3UgzgsMlNpGRQfKbJLSoIXkyD1XcSLkCtzLkHl1B4ogxHd+/f/Pi0Cz
         JgmtoHwdVs1TIspYz/f2d7duNhWmjPf84rL1sDMy4VRHs3ukLXMtEUpHqdj+QMA6Y7iZ
         9LcFnjxnZKIEpUGQMJ6gjsfoul8tkkPnt61aCVFmqkqrI0Q+Qeb5VCQrZtmYOqgyPXcP
         GrF2HFv08QIkD1FVfCbpp+5G7/un2KCwuUS7Q6vMMlKVnW9EbQzLRTvew7GsLczdjmuQ
         /0rA==
X-Gm-Message-State: AOJu0Yz0r1xwgI2KPU5qPIbV6/MPJNcG1qJYlCncAsl3dHZUVxVGMBNN
	uJzpTm+wQbFk52GPcfckkxUI5bOB9yfKl7LaKG6Jwp/bMiQy7mng5GkFvyPYBvBotsyKoBYDOwF
	eXP4yB+PtoWxgwXBdh94yAhvivNSKkVn6dzrjJn17dFvsY87QVABiOYn5h/OOLN0i2FPnDe5uPw
	M=
X-Received: by 2002:a17:90a:5d8e:b0:292:af3b:ee4f with SMTP id t14-20020a17090a5d8e00b00292af3bee4fmr2527853pji.22.1706526418426;
        Mon, 29 Jan 2024 03:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe0TO1n7iOJfqSd1Xt8//WX6Xwr2uSpUA6lDze7TgoTJK4u387rAJmv2atEy8j2fI5YVtvKQ==
X-Received: by 2002:a17:90a:5d8e:b0:292:af3b:ee4f with SMTP id t14-20020a17090a5d8e00b00292af3bee4fmr2527841pji.22.1706526418080;
        Mon, 29 Jan 2024 03:06:58 -0800 (PST)
Received: from nyewale.pnq.redhat.com ([171.48.38.219])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a520100b0029552a03219sm2791124pjh.29.2024.01.29.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:06:57 -0800 (PST)
From: "Nitin U. Yewale" <nyewale@redhat.com>
To: chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	jmeneghi@redhat.com,
	loberman@redhat.com,
	nyewale@redhat.com
Subject: [PATCHv2 1/3] nvme-tcp: show hostnqn when connecting to tcp target
Date: Mon, 29 Jan 2024 16:36:37 +0530
Message-Id: <20240129110639.45542-1-nyewale@redhat.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_030708_090908_10D2EFC9 
X-CRM114-Status: GOOD (  10.46  )
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

Log hostnqn when connecting to nvme target.
As hostnqn could be changed, logging this information
in syslog at appropriate time may help in troubleshooting.

Signed-off-by: Nitin U. Yewale <nyewale@redhat.com>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d058d990532b..5eb53c2566d8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2753,8 +2753,8 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_uninit_ctrl;
 
-	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
-		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr);
+	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp, hostnqn: %s\n",
+		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr, opts->host->nqn);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
-- 
2.39.3


