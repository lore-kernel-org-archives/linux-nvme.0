Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CDAC001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 11:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDAhw9eRdNKsV1ijHWKTKzdqUh/Rv/zY5LtVB/qhHdc=; b=bf/rzqjqOZuQsIz3CcuzNjyeY+
	+W7bo0acTjFCwvlMPaR3T3sViCAhUsSDTbbRlvn77tAqK2ChA+bwZjJw10l9yqApFS13tCt1Pe0YL
	mhRznyykElzuBxuljQeCzjcTCCHxUTMDzjGcqjWYFoUJBc9Me+4MikVq9UMFKnSjSIvaMtKiUNaj1
	fi2ME83CkfPcUhT2LVDoN5RmE6wbOzxFtpJ4fgwTS0cnP95/kFsQNCHeqRxF6fcD8fxRbd/x2Ff3v
	zIWRrtYQiBSfHPFSJjBrTL6uuIZszFpBtFhT8FoLyeNnH7Akw7WERAWdMZAjSOHkLVNxJQKEEC4ok
	9OHjpQBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3be-007MCa-1H;
	Thu, 10 Aug 2023 11:13:30 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bb-007M7h-1k
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 11:13:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFAA32186C;
	Thu, 10 Aug 2023 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691666003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDAhw9eRdNKsV1ijHWKTKzdqUh/Rv/zY5LtVB/qhHdc=;
	b=0zl5ZoB9tGmAAsDkFBE3TZIhVEnSei+sKnsz13yH6ruKO7a+ktb5Abp/isenQucv3qyjyZ
	9XYDZm8OeKOfOCZvyiHn7yLlYnOaAzlbZFMYerA4PmVAB0ZAotLT5Du1pDlwmz5mdVZSLc
	U8VdOU3i/5K4EdmLh5Uufa/jFBbFpfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691666003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDAhw9eRdNKsV1ijHWKTKzdqUh/Rv/zY5LtVB/qhHdc=;
	b=qnLmABrDYI4xOL723VUNdBawiiOI21d0YZA7f6JWgK8GxBVA06G2t0R44HOIx+gaUveV6z
	BdhhLJLvdAPEKaBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1D15138E2;
	Thu, 10 Aug 2023 11:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rxY5M1PG1GQ7LwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 11:13:23 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart2021@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 03/12] nvme/rc: Add common subsystem nqn define
Date: Thu, 10 Aug 2023 13:13:08 +0200
Message-ID: <20230810111317.25273-4-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810111317.25273-1-dwagner@suse.de>
References: <20230810111317.25273-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_041327_740418_8E795BDC 
X-CRM114-Status: UNSURE (   8.60  )
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

Add common subsystem nqn as global definition so that we can reuse it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4f3a994d75ce..c11848b59c49 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -16,6 +16,7 @@ def_local_wwnn="0x10001100aa000002"
 def_local_wwpn="0x20001100aa000002"
 def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
+def_subsysnqn="blktests-subsystem-1"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
-- 
2.41.0


