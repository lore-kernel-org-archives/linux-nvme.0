Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E113DC47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OjueHzCYhf03K1r9K/c0KZIjzN4c14tDn3wNScF4F4c=; b=KafL9mQIAGJ/j64eFzvygoxWxo
	e7yffsSkjzHpH/eZK9FLiiIhfzc5FxM02L9go2p81MbhwY4gFGdaAauEPfxqWcQ4x7405sar/0MIy
	uMRMzElQSSRGqXYgx4WyO4Mb4yqJZPPtQe84qwwacsACtY5mce9Z10zNakole+qNECIfdMi9q2gq9
	U/RSUt+XPJBVEV9vJiCA3km6PiCH7KXUhDsI5/GAY8inr642xp5f2K9rIVmba8WbiMP9g419CwN94
	XoQtxtaEk7nG37wCwWQ9b0+FjozhKbMi2yhtkVF6YGaR865ygKpnLjAOdUvzgHMwpWji6ipEWrL9N
	dqMnFCgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUP2R-0000000CFIG-1CvF;
	Mon, 29 Jan 2024 10:38:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUP2O-0000000CFHP-1bMh
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 10:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706524727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjueHzCYhf03K1r9K/c0KZIjzN4c14tDn3wNScF4F4c=;
	b=VSRJOKlAXe9IIo71Fh9M+T5XXcJynKzVKsZs+20Ba6svSoWfCMcPNu6yT94Di3z37E6iio
	Mf47/WGoP+5NuZ+b5Vr8bDAOk5Q4DFcvvbJClj3oO9AOt0+g8B3cjvJJiOPolR+aTWMDEy
	fvfwRZbfi1rrVZ1uDkqMyw3n5Z5QCiI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-sl8uJvG-PROgQspt3i6P_g-1; Mon, 29 Jan 2024 05:38:46 -0500
X-MC-Unique: sl8uJvG-PROgQspt3i6P_g-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd66680a39so2437294b6e.2
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 02:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524725; x=1707129525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjueHzCYhf03K1r9K/c0KZIjzN4c14tDn3wNScF4F4c=;
        b=pgbN4hU6osiPtg9yBYue/1m2LA+JiP+xDXLkZn2hvHZeVlK6dx5enJ+7RV4hI1pJ9F
         CpFFI60al8J7gfLna4S31/OHygguVM4bpjhySNnmjG9YUUNlW/2rUe/JsKgx+a2NphnZ
         YYlf5VtLPpoNOafo3GS8UcfaxV6tFIgca5s9jLrzTsywO6l+mcIcQNvBRQvy8rKnCCna
         +fJxlh5oqaKpQg5Uywe/PHzIr6z+oWaHpLShEGP3Q68Jy8PFEoas3TuHxQKmNbXmdTYL
         xqfyj13OMYNQDIc4l827HeRhjkLhcp9ub9XZviHnabX8pbtcLZSIKAGOx22d6bmK7vE0
         Phzg==
X-Gm-Message-State: AOJu0YwpveQEQD2lrIPXrezdjleBwW+ktIlcIR03kf/m6TkvhlvHtSi/
	PIAl81xLJFSjYvQfnoNPDVzpXH0u+Cjzti7wBAPff0sT6hLi2g0fzJzTykeSZFIE0DFr2JYnDjk
	w3WNYnSU0zgmK7biZtVavZVB4q06gd1xaf8+vcIVv7kC5i544btxxZgiKHrE1Ca4h+ACGV5AgC1
	2qy+YuN4qHUPh2Fd+Novc5p+QSdOffNEbbNxVFNUrpEA6NMSZkuA==
X-Received: by 2002:a05:6808:1997:b0:3be:495f:8ed0 with SMTP id bj23-20020a056808199700b003be495f8ed0mr2266325oib.30.1706524724952;
        Mon, 29 Jan 2024 02:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGybJCxIY/MFBnh4SwCk1aPVP/uFdwXJAWr+v0gvst8SiFQN2u7Muef8CZNM1WngFjLO7JckA==
X-Received: by 2002:a05:6808:1997:b0:3be:495f:8ed0 with SMTP id bj23-20020a056808199700b003be495f8ed0mr2266305oib.30.1706524724664;
        Mon, 29 Jan 2024 02:38:44 -0800 (PST)
Received: from nyewale.pnq.redhat.com ([171.48.38.219])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7849a000000b006dddc3e298esm5521654pfn.150.2024.01.29.02.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:38:44 -0800 (PST)
From: "Nitin U. Yewale" <nyewale@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	jmeneghi@netapp.com,
	loberman@redhat.com,
	nyewale@redhat.com
Subject: [PATCH 3/3] nvme-fc: show hostnqn when connecting to fc target
Date: Mon, 29 Jan 2024 16:07:59 +0530
Message-Id: <20240129103759.42653-3-nyewale@redhat.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129103759.42653-1-nyewale@redhat.com>
References: <20240129103759.42653-1-nyewale@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_023848_595383_7B6CA1C1 
X-CRM114-Status: GOOD (  10.52  )
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

Signed-off-by: Nitin U. Yewale <nyewale@redhat.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 16847a316421..7ac565b0f13b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3575,8 +3575,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	flush_delayed_work(&ctrl->connect_work);
 
 	dev_info(ctrl->ctrl.device,
-		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
-		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl));
+		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
+		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
 
 	return &ctrl->ctrl;
 
-- 
2.39.3


