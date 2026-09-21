Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64889C982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6gXmW4UXVfkRmgjmxz6ooHCPLTvMZVSsUjwaz8wmJfM=; b=SbLAo/b+WRHxCVQH/zdg/h94SV
	EP9IZ2TcuSjCJmsu+5GTlKrdFo2FM/z2l8SdMxHyH0/y241fiBXnOJLM2zg9L/SDADRkCeCEWl3Mx
	Jwqo1y7VavxtZQDvVhXP+EW6UgNGssgf4ZmebAN1P0KiB203xeR8QzMl8j5UINQTzKpgmuPjTk3rN
	zNoYSS2ZNLzgEs90o/sHAx7sAgojueAJfbmYXo77D4U1xVpTICRGm6qzfpWRl8dwd/sNYbQXwZbK7
	CraaQJbbzbNvGW/oBj6pgLv3KHkCgx6ghHJjHsOM+wxhk9pP131CitDiR6I61kSL/SRfr541F208o
	nBPHKLaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fU7-00000002VB1-1WAr;
	Mon, 21 Sep 2026 14:59:11 +0000
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fU5-00000002VAh-0Us6
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 14:59:10 +0000
Received: by mail-pz2-x0d.google.com with SMTP id d2e1a72fcca58-85469a33c9cso4142101b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790002748; x=1790607548; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gXmW4UXVfkRmgjmxz6ooHCPLTvMZVSsUjwaz8wmJfM=;
        b=bXZKrQXPEw86c9RwSc2qa9/lz2UtK7rsLEHNhtq8OSfK0MB7HRS+tk6yqITw/+blvq
         Oh6EvY5ziMViObuCqXPVfu4ZppEeGexcaxL+utMd8XD8288xjm+NpZ8nTglCUA/3qWVp
         VM5UDWdpYxqs8IRYWndXPhw4c7Cc+s3hT7CnCu88UKUNs43QEMY4thXCoGxsm2jGkmmn
         ugVOHy6Wi5c7mHcw0Nq0DEHhyCEcTDxXNMpEHsk0LuYWyoEOn0JgdkTxhEndKl5nTMlz
         GqKC7TLJ0xIRMqsf/RWgeSve2r+FhbWXplOd5egmg3W8vThPu7sttHbTC7Rd0aHeiUdt
         zoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002748; x=1790607548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6gXmW4UXVfkRmgjmxz6ooHCPLTvMZVSsUjwaz8wmJfM=;
        b=hFnSsYYuomIpPE2OZDGOKYCmrcprEZpFMj400or/Qtkzw9crtdzk/DdMGdmanbMOgW
         O1G4+oVmfdTa2vSVZcw7kmKpOPNQhNABEgcyDwTP9z6Bb4UC3MOWwyJoaCn2gs1xOEkO
         CWOryZXpykoyz5TXBjLUL9E9ETLKunjczp0MOOLb0+M9zdTEx6FFRCaRThHV6ITpj8uS
         2vbhayFL3OCbaoZ4hxLpGv+GTA7j5QaAB8KlEWhxbAbwKPLdFbZT05Enj55NVobeGc5X
         ge06/41aCaKpbWV+sDtSpB1ij4zTjifa7xSFA9ikLgJn6fzc9WdNG4eyP1a48DnHpNh1
         Vphg==
X-Forwarded-Encrypted: i=1; AKwUvBw9Aq6KHe9u8NkYVg0RTZ6f+7hWvAuz/oFfoZUN0ZW3gpY/tIJYtap2mKgac/wpCJUCJRd8o5Skn4Rm@lists.infradead.org
X-Gm-Message-State: AFuF++nP+Kn/YwU/G0SH16MI8cZ4H+RKnAKmGLFDvjlecc6ribOp46Je
	ZRKDdxOkOA6nOo5Pa6lpN4MCJYzLL4jk+7pn+sQsUnXrLoxqbnjz6sZgGobkNw==
X-Gm-Gg: AYBFou0Q35YJLfQhCKxglXZuEsdBAAHNxYcv/dGDQQ0/Vz0DVZBdIBnOSeSkyh+ogbU
	zlx9SdnDtxnBqAvnt4T4RU/8KBkIrKfeN1LaZfdAb5eoYTw2leJ2/2DdPMMtPKUM3MP/NFfQlNO
	/KbH80mgZPLgu/Ik+jVYLm1Aua9eHjZvVOzS4Qm35BnSOqVGr4LEZ2r7zxqUINqbUxyOzkirrgG
	Ve6RgSYfMoMcoIqwxairmPHSzmFisgfqGcJkrvOteeGgYff7QmyTn9cR7rERcivJLMsNfcDGkG3
	5rWZHFCB6wIABuFwuiGfpRZzulsMn/mN6J/ipZ0tBWgcanxPyPCuIMX3+r3ttGkKcvVkp+9zOTI
	kU1lp4LVseJLx9NdmiA0gW6xHwV2uSCUrFwuUXWPGelo9H0hVpsDhlKQk3zVNXA5TYHeKHiyKN4
	It8xeJE8USqcdjg2oBKckfaiyz35ryNEH6vdtNmq/2SdY9l7UTWpEUDi+JSTYOVBHnTBvF7Leyw
	GUhc9rqhWS64ax2f1kUqEq2Qg==
X-Received: by 2002:a05:6a00:174b:b0:879:757b:4cd6 with SMTP id d2e1a72fcca58-879757b6aafmr5596402b3a.3.1790002747974;
        Mon, 21 Sep 2026 07:59:07 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:70bd:a3d:dfa4:3859])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a8dfe20dsm3536613b3a.19.2026.09.21.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:59:07 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-fcloop: fail LS request synchronously when remote port is gone
Date: Mon, 21 Sep 2026 21:59:02 +0700
Message-ID: <20260921145902.17223-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2ad8b13c-b548-4574-9c61-5224833e1bad@flourine.local>
References: <2ad8b13c-b548-4574-9c61-5224833e1bad@flourine.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_075909_179715_648F4058 
X-CRM114-Status: UNSURE (   7.58  )
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

Hi Daniel,

Thanks for the review, you are right: the async -ECONNREFUSED completion
is how an HBA would behave, so failing synchronously in fcloop changes
that.

I dropped the fcloop change. v2 keeps fcloop as is and flushes nvmet_wq a
second time in nvmet_fc_unregister_targetport(), so the LS completion
queued by nvmet_fc_delete_assoc_work() during the first flush has run
before nvmet_fc_free_pending_reqs() frees the remaining requests:

  [PATCH v2] nvmet-fc: flush nvmet_wq twice on targetport unregister
  Message-ID: <20260921145651.17131-1-ngocthang2710.1999@gmail.com>

Hannes' blktest request is covered by nvme/071, sent separately to
linux-block. It fails with a UAF on an unpatched kernel and passes with v2.

Thanks,
Thang

