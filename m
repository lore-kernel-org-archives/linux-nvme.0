Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B537C04FE0
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mG6IRZ9q40lCvRAwlcOpEAtXBD4DfqCDrz6tzkiMxmU=; b=GCbV0IWX+WvC33fxS3LAPv+ilh
	XpA3zZrKTkNJJw1T07kY1JxoYNh2JOQQp9KCXgqfVUTlWKWwXtK+ng61lTDC2bosMR9TtpWM8ZZRc
	NTonODNXMX0m2Ko2YT7a7Qz1KL0lTy7PSf+bbVkKAGa9Z0Qd1cWyix6mf14TK6QKb72otPkPUYzfq
	1Pft6CY3RcqJdNQ915rlNayiCiy3yMc90dqwvEZOTFDsfpkXCoQGjDooDYU703u+BL5GWWq8T931J
	ihlI+EyX4NCILzv5VFvkZyGPkXjnv+2KWIb2C3DKaNhp01zVorsEDFG+x/FiQ17+wN+rqRp4qG5Ih
	4siOo+sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUOZU-00A0EP-0r;
	Fri, 11 Aug 2023 09:36:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUOZO-00A088-0H
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 09:36:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE09421870;
	Fri, 11 Aug 2023 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691746592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mG6IRZ9q40lCvRAwlcOpEAtXBD4DfqCDrz6tzkiMxmU=;
	b=CGhHuE4YaF4bmtRkYoBrXX+70/+I6zm0J7t1YOLsDqFbvJRQwXNsn+fq3ELwDix1xNHgLU
	B2WJMOwVD5h10TpDipyHXSPXYpsK+jS8YWhVxLd7Ht5YhUvIWZxwfTXTDvhHxmFn4Z1gxd
	uM8s/lMTAT+alv/fi8Em/q+kveRN4dM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691746592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mG6IRZ9q40lCvRAwlcOpEAtXBD4DfqCDrz6tzkiMxmU=;
	b=7KCrtASSd2Js+drBRfgJqsl79hLSuiRGBZQ+PdSSsgu9plM2GX/Sy3JobLZUcMLlNM/u9e
	UXgUvXp0AXLqQVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB759138E2;
	Fri, 11 Aug 2023 09:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XWSYMCAB1mTEHwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:32 +0000
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
Subject: [PATCH blktests v3 07/13] nvme/rc: Add common file_path name define
Date: Fri, 11 Aug 2023 11:36:08 +0200
Message-ID: <20230811093614.28005-8-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811093614.28005-1-dwagner@suse.de>
References: <20230811093614.28005-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_023634_264386_70369D42 
X-CRM114-Status: UNSURE (   8.39  )
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

Add common file_path name as global definition so that we can reuse it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c11848b59c49..9c802ddc872d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -17,6 +17,7 @@ def_local_wwpn="0x20001100aa000002"
 def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 def_subsysnqn="blktests-subsystem-1"
+def_file_path="${TMPDIR}/img"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
-- 
2.41.0


