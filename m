Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BB9C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 03:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NT8jBtZx4L/Jgg33ebbj78xYB0zArGog9auyhUqIKcQ=; b=4eXXKLvC0jU9gox99I5Ezwykuh
	lOhowsUReuHqiPJwj1hb4L4oBfnN6Wmk0DqH0oWUj9gFN3vqdrfu6m3ltcUeNVEiDXnkoljzF/Y9/
	xSm5LLZT3+xo0RYcO47PEt9GyPhIp/HxgBGf5NIqZGYX16YnoKTcKem1Z5dmcog1maahV0MQzToS4
	MOVZ6hIQkdl4wzRQP0R9oJF4j3RoyysHhHsNCLle+XY9+3MaARXdDybYMxAjLreTuCLSVmjbgi9YZ
	8a8nF5tgTSnMcTVHA4o7RnuqeavGgXDMnZuFTWcNqNtrQpvknXFuCikNCh9y8ji7ZWYf2mfqwnebx
	mwN2ON1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWs7C-00CkDl-R2; Wed, 23 Mar 2022 03:56:54 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWs79-00CkDJ-Ln
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 03:56:52 +0000
Received: by mail-wm1-x32e.google.com with SMTP id
 k124-20020a1ca182000000b0038c9cf6e2a6so272019wme.0
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 20:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NT8jBtZx4L/Jgg33ebbj78xYB0zArGog9auyhUqIKcQ=;
 b=mD0oN9Zn/NKRzAp8vSymjHHi/Kh4aJQ0UPErLwwcwRWGh+b7tE0BBlGWYgKI4P0GkV
 5o7f4CYQ5JmfjUlF69gAvkVP7m/gOs7nxzPygJ6qVyqftady2TLH6tp8718p1453d4Nz
 fKqprEn8xNGzRGmXFJmEBgxuAuY0/Ulq7DwBkqLi+o7JLW32NqJGcOaaizbCD+NerqmE
 TBMI4nebZN84m+YUkOqCVtshpgXCx6BXFJxFvWSH5oWJyo8COM3gpI/p9Q7AWUWsqKmj
 DCnjDlfKG4NRud+D8KeOZdp1FDGWnr0/grtuRY1b82wrjkHXmnwJIETA1cnDbJr9Finc
 knsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NT8jBtZx4L/Jgg33ebbj78xYB0zArGog9auyhUqIKcQ=;
 b=3ED4KHV0udLxAKIYPS4CJgOcVqA9l9LwxAYRFQx3KOI8MqknLXeeRzRk0DngfsG3wI
 yKMnoARqPObWuqK2EgORqysxczUnNAWZ0bpoSUl3EEhp/E/TVE4aaAjQxk/ZXCXhGbKY
 DkAmCXijczmmais9azpgtwdjbVCwyUrPn6sibFCWX3MkiGCQX8oT7ozr7egjbf2sA1J6
 5eDbN8ni0MAnVNoVLCKxne56OIWMZ/CunLa5RA8QY9Uii2wGtXr+Okn9Yiof1ssmls/w
 0aa5WVSix3H2/lVYJ3y3teWyu5KjMUks8Q8+UNY4JurR142MaUYBwZ9wKfy3qFFhxE+Q
 /CMA==
X-Gm-Message-State: AOAM533/ogaX/3/VQPfJxCIOosXlD8g4Wgt0RqfHgBnVr5riZaHsfV5M
 iVpF2n1v5aYAldtJQrsENFebTUBdupzjog==
X-Google-Smtp-Source: ABdhPJyufEe2EPsUEY18CAl1nB5/EM+JXqjYMsd+Gns9g2zwVPpzq70vi5OOz24+TEwSneKfQuYJ4Q==
X-Received: by 2002:a1c:4e19:0:b0:38c:88b8:c1ef with SMTP id
 g25-20020a1c4e19000000b0038c88b8c1efmr6949355wmh.133.1648007808765; 
 Tue, 22 Mar 2022 20:56:48 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 n14-20020a7bcbce000000b0038c7776a300sm3541158wmi.0.2022.03.22.20.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 20:56:48 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: ushankar@purestorage.com,
	Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 0/1] nvme/mpath: fix hang when disk goes live over reconnect
Date: Tue, 22 Mar 2022 21:55:50 -0600
Message-Id: <20220323035551.1524128-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210918215729.388968-1-anton@lightbitslabs.com>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_205651_738573_5D23B5C4 
X-CRM114-Status: GOOD (  11.89  )
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

Revising the original v1 patch submitted on Sep 18, 2021,
which deferred nvme_read_ana_log() until nvme_start_ctrl()
and raised concerns since the former might fail,
while the latter does not currently return an error.
I did not see appropriate to introduce error handling
in the nvme_start_ctrl() call-sites.

Instead, this patch keeps the nvme_read_ana_log() in its original
place inside nvme_mpath_init_identify(),
but defers updating of the existing ns path state
until the ctrl IO queues are enabled in nvme_start_ctrl().

This way the handling of failures to retrieve the ANA log remains intact,
while the mpath update is deferred until it's safe to do.

Anton Eidelman (1):
  nvme/mpath: fix hang when disk goes live over reconnect

 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 12 +++++++++++-
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.25.1


