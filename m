Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7677FC02198
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2025 08:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SF47QeG5TaL/T9e6uPJYCfxP1H3sooJJbbsjMznKkM=; b=dmoaspY8Pa8bGeO8VrmsKs/LNK
	5MPkGU6n/THBWX3ENdvZkgCoWVtgRUzmwV+fU6ww7EYnYhReYw2WxspHmbowCcEuvQEAkSbXygEc+
	49trHlR+YEpIN/huaEaPAEt+v4AEMjadwkJIhpcC0AsDvylygEhBnisU+dtpGkgacGSJ7yTHwMEII
	nUpldV9YW+FWUxkmIYOCQd99Ia5SFSDHxXojU4prWxqGsVT9oHyI/3eeYQwgUzzAImIAvJKDmJ4Ef
	G6zb3LxmOKASLg1Zai2vY/WFnS1r+zxLVm2X7vAg5lHGbx3lRo5RAQ7FPicjejSpFl24/cI3xDUWo
	ysNfH6zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiqeU-0000000E2S0-0Bh8;
	Fri, 14 Feb 2025 08:02:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiqeR-0000000E2Qm-0m2I
	for linux-nvme@lists.infradead.org;
	Fri, 14 Feb 2025 08:02:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 294015C592E;
	Fri, 14 Feb 2025 08:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADABC4CED1;
	Fri, 14 Feb 2025 08:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520138;
	bh=l3XZQZvQkDfNzwgQzMulETJqMg/v4VRdfWXQoC2LOHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L3qppVIIP+ahp81b49lSkbjwy5K9C9UyhosWNcaQGiw5qDh0X5p2nCkZgbLAlRQKH
	 uDxu94M/yWiz6+aknLYC/MtsVSIXcO7nKCs/wIJE+35tzGmnXHCYw/sP0+tQkVtMAS
	 qGWCd/sl7yZp1SWoBLIPpbSr2JBrjGBh8gnhgJvOxMxXh99Lq/TQFVsYkdrlVYUnyB
	 Mwoh1FvSrXtyWWz9gbZeQivvVY2UkVmKHTQCBzhmtuSJG7Or1fxWBLZU9d8RIFMdqo
	 eqdFzFoNAsKXpHxI50pCkfUp6ykDG7D/pEkHFfOdOIzx0C1daijmWCABA6QuUvU9Eb
	 5lgOuqx0DEAjQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 14 Feb 2025 09:02:03 +0100
Subject: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
In-Reply-To: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250214_000219_281757_B8617AA3 
X-CRM114-Status: GOOD (  10.32  )
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

The fabric transports and also the PCI transport are not entering the
LIVE state from NEW or RESETTING. This makes the state machine more
restrictive and allows to catch not supported state transitions, e.g.
directly switching from RESETTING to LIVE.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 818d4e49aab51c388af9a48bf9d466fea9cef51b..f028913e2e622ee348e88879c6e6b7e8f8a1cc82 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -564,8 +564,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;

-- 
2.48.1


