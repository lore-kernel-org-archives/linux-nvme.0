Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33531C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1KSLaatp3cre3CzR8Ip2uqLz3QDE4omCUvg/2ygq+h4=; b=DCCwyV5So0xNfH5jw1DTSZui2/
	tNfG2Rb5Rgc8wOZA9uYov/6B02vuAPbWmsWcdmWy+6Pse59G0s4gjLaaS5mmxRzYNnjzWe0XNgH6P
	9cVpo2jJpQ9odM+3KK4rSH90I/tVBrDskG7WHGf5W1AnuRkYCmV/7uZ9EsLrBYVTn26klJe1AIZYQ
	xRRt9tanDLyIoSw3UptY99XfwhyLKOvsDYu/zXJ8eveBpweo0OvuxE+qplEQoPGQiQVHTRVEdvYbn
	VgSf5mvF9finbGkp3bPSNQpiZFB4qOREZfLqrbbkAC2lTu6Zlix0/rIcItHcfw3BQTX2XQwt1tZf4
	so0saztA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4HF-00FCbG-3A; Mon, 22 Nov 2021 08:02:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4Ar-00FAuG-Sx
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 75E941FD26;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KSLaatp3cre3CzR8Ip2uqLz3QDE4omCUvg/2ygq+h4=;
 b=H7R72D9lHKdFXOmAu823dVYhWEFarAh5PPjZmHqxx773qI2bC1LzbXin7MlAZRsZLgY1wu
 ExO/hTMqTL9xw+lpUjRJlif8T40/CofJwxniE9C6wqboaIWELTBDaRlWjbsxK9Bj7WM6f6
 iRE4pIBW12GsPxUJ4wxQMpuCFP2rELE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KSLaatp3cre3CzR8Ip2uqLz3QDE4omCUvg/2ygq+h4=;
 b=tuhqjwzPZeXYj8stOX6bKrKVlQIep9/eDCa2AtPBkykt54DrIygVmHG5NX29ojEwvKRGnJ
 sx7khoNVfv/H8hBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 50D7AA3B89;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3DC4551917F1; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/9] nvme/rc: clear allowed_hosts subdirectory
Date: Mon, 22 Nov 2021 08:55:17 +0100
Message-Id: <20211122075524.26207-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122075524.26207-1-hare@suse.de>
References: <20211122075524.26207-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235538_214959_48E7D440 
X-CRM114-Status: UNSURE (   9.78  )
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

When removing a subsystem we need to clear out the allowed_hosts
subdirectory, otherwise removal will fail.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 086c094..aa223df 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -262,6 +262,7 @@ _remove_nvmet_subsystem() {
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	_remove_nvmet_ns "${nvmet_subsystem}" "1"
+	rm "${subsys_path}"/allowed_hosts/*
 	rmdir "${subsys_path}"
 }
 
-- 
2.26.2


