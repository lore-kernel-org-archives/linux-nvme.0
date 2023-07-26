Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FCEC04E69
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+dGeQazKVtEZfgImF+w31ZCjMos3YCov32HlfqtR9k=; b=VHwD7X47NPHOxWSRsORoC4iVq4
	hP+Zn+BJ+KU2WOj1LEsThQBbx+PE+EdUYPw9tfDmNEhyeo8WlmXGyxaf+K1zrzmKDLzytNI9UpNSL
	NawiFzH5bZEY7tTSqKfkrtlvLRhtWNX2y0+vCIAgH8wcYpfzmGcUQozYba12fb56SxMobSx1h+gXj
	kdWrcDAHC+6KgdGj2uEXyPLRu8jjCpvFi1pQn7dR9Us9xu3CghwV6jl5K0fLZk5O2ERIqg9uGcHg9
	p0nQmm+rYju7wKktkeA0qfP8Curacde45eDp7dBF8NdmiLyBf7jFOOn37VKkNSl94asOGu3UU2wnH
	GIhqP8CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOdv2-00AP33-2Z;
	Wed, 26 Jul 2023 12:47:08 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOdus-00AOsp-2T
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 12:47:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90ABA1F890;
	Wed, 26 Jul 2023 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690375617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+dGeQazKVtEZfgImF+w31ZCjMos3YCov32HlfqtR9k=;
	b=dirLWdHJ5gRbTQEir1JA9cGvhWdeJGW2Xdgvd5sYv9asSdbfDCViiTW2oYDnXMtgr3N6QW
	yjHpHHS9e8SGv4FnUX/L5j8FeWuJxCyE4UtkxLH5RsxwhZlUdmhzKXBv3zJddW9kG8kX3q
	rUgIjfb6AQjqHJirY+ArugOr/OOuKkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690375617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+dGeQazKVtEZfgImF+w31ZCjMos3YCov32HlfqtR9k=;
	b=1It0nfLs9+10+PRYKFhV1+oGbZ1V2BU734t1ZiMYavD1unKHjBVL5GImTvm0tQ7/2qRsm2
	jyVgPtaUMrwL2VDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B04E139BD;
	Wed, 26 Jul 2023 12:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1WuKHMEVwWQ6UAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 26 Jul 2023 12:46:57 +0000
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
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 08/11] nvme/rc: Add common def_subsys_uuid define
Date: Wed, 26 Jul 2023 14:46:41 +0200
Message-ID: <20230726124644.12619-9-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726124644.12619-1-dwagner@suse.de>
References: <20230726124644.12619-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_054658_956387_7B635C02 
X-CRM114-Status: UNSURE (   8.29  )
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

Add common subsys uuid as global definition so that we can reuse it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9c802ddc872d..7f5829a2e58d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -17,6 +17,7 @@ def_local_wwpn="0x20001100aa000002"
 def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 def_subsysnqn="blktests-subsystem-1"
+def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 def_file_path="${TMPDIR}/img"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
-- 
2.41.0


