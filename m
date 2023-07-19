Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00F8C001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wZHZbJliWjmHWQLMiJzESHYuCEtNquI+C+DYAnC7jN8=; b=lF3xnTjCIUgzJPHex2iND8vSTu
	sudMyED87THS2+Mrx74MKrpeU4qPhkXrplJmAaLi4kNoPKpZTxBD2eMql9f4zL0Cn1Oj8ODTWSwc5
	hjyotgUFyUhuXIl7iFVlqCmpI/wlYgpwhnUMkizjsIeTW3EG1VKLvbR4OmCw9a6AAA75rpuMAsZIq
	qFwEf5sIp99SKiiKQ0DsOz/nRJhTYVrTn7eSNM1TN2VQ78eY9uu6FwAnRfuyQV/MxBI9PBN1RWqfV
	HG4ZWq/B1aYPSI2QghnNNajOSG0hUw++Ltd8jEaXKqf2HzxzDSFlzNwQhD0aNZpzO02nlfVqcYe7i
	5nbPQB/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM2kx-006Qjf-2j;
	Wed, 19 Jul 2023 08:41:59 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM2ku-006Qdb-1a
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 08:41:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C03031FD6B;
	Wed, 19 Jul 2023 08:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689756111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wZHZbJliWjmHWQLMiJzESHYuCEtNquI+C+DYAnC7jN8=;
	b=H22CJa2Gy8DvcsllRAN8rZYp/aXWR0UINmrKEGCGT/FkBSCT7XpoJ69WhHCb3DfRue1eWb
	V0jlvNGPJ6xymJl8oJmaX+FEbdIxGfRdnAzlEs6ynhsalb9ZfuBjEfTb2C9b2QaG9preCD
	03Ou3iW/VBmZVa3ZGBm6+N/0Lbl/42Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689756111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wZHZbJliWjmHWQLMiJzESHYuCEtNquI+C+DYAnC7jN8=;
	b=x4ZdnOc9bWYQxqjNoxCUTfjX9mLl1HE+OQkzVB5e6V0O6ZmaqcVjOvZvpwF0Z7+TFr+Qbt
	zs++fOReCVTtnXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B19DE1361C;
	Wed, 19 Jul 2023 08:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bps2K8+ht2R5BQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Jul 2023 08:41:51 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 0/2] Remove CONFIG_NVME_MULTIPATH option
Date: Wed, 19 Jul 2023 10:41:45 +0200
Message-ID: <20230719084147.16272-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_014156_718593_58F6336A 
X-CRM114-Status: GOOD (  10.93  )
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

> "Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated
> and will be removed in Linux 6.0\n."

patch1: As stated in the first warning the multipath config option has been
scheduled to be removed for 6.0. As we are past this point let's drop it.

> "Found shared namespace %d, but multipathing not supported.\n"

patch2: The second warning is causing some confusion for Dell's PowerPath
users. The native multipath support has been deliberty disabled, because
it PowerPath module will provide it. As the native multipath is enabled
per default and always built-in, just drop it.

Daniel Wagner (2):
  nvme: drop multipath config option
  nvme: remove warning for shared ns when multipath=N

 drivers/nvme/host/Kconfig  |  9 ----
 drivers/nvme/host/Makefile |  4 +-
 drivers/nvme/host/core.c   | 12 -----
 drivers/nvme/host/ioctl.c  |  2 -
 drivers/nvme/host/nvme.h   | 92 +-------------------------------------
 drivers/nvme/host/pr.c     |  3 +-
 drivers/nvme/host/sysfs.c  |  6 ---
 7 files changed, 4 insertions(+), 124 deletions(-)

-- 
2.41.0


