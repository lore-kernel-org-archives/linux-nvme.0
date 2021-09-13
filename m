Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F5C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 10:25:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C6C6108B
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 10:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1C6C6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TLEzl+VbtoeQQ90VhIrHY8lwIRzTbFp3ezXav1fiZOY=; b=3Qm0LyUTy0U/4U
	5VKB2nWf8RI74xlh7Nu1Dx98838UhcQj2FpoKmDngOV7jRu27WWca3xkPLr/HBkcaiQyEs2R6Xi7F
	yuZTdeUvHxoT9GD/jz0Qz5E/JH1gbyvmCxUEgCWz7rV1kbxCuLhzWn4zKJrw3PgFoc6Al1HaW7jOD
	yZyylGFh+1/CaMXx1vrofsKEwHnSUfmUJ37Ux45eWk6ehLoWBcxWde8eR0TNS6BNHwWLRx+b9FqdE
	QqACRQ0Lh2FcSipCeRmE5lcYetGvHt3YJsgwvC+Na/rldyd528/S2ipnhKmC1vTSW+Uwhs+0eYhDn
	b+BCtPVmQP28WMdUyC0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPj8X-001Fu9-UE; Mon, 13 Sep 2021 10:24:29 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPj8T-001FqP-An
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 10:24:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C53F421FD3;
 Mon, 13 Sep 2021 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631528663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g9nuf3e2j7dL++6EWv0XLIzaGaTYV35YYa6PvI3uxbs=;
 b=HLRbgSSNDCAA1bF+qqCriEDTdOL3fuPDw7TAQ1fp4WKlNT/0ePZnc9JE9cFpY9e8VX/JRW
 vAkR3OpZtUucmvxvF6PNp6UXchtszSAVrVpfdl6EqSqGWnbBpceVaWCwR30H8kJ/AEeWAX
 ik/EFUVzz70rCmW4lH4UuFYKeMGTWs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631528663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g9nuf3e2j7dL++6EWv0XLIzaGaTYV35YYa6PvI3uxbs=;
 b=CSw0CB9wSPtCLX/UnmjjB7mWgw+m43CBxd1m4MltW8BxrXrYXWw70NQWdTJyzrD1zA1qi4
 2gsQl7v9S2A1NjCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 6F15DA3B91;
 Mon, 13 Sep 2021 10:24:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 5DFA1518E59C; Mon, 13 Sep 2021 12:24:23 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH nvme-cli 0/2] Support commands for NVMe In-band authentication
Date: Mon, 13 Sep 2021 12:24:13 +0200
Message-Id: <20210913102415.19044-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_032425_623176_CE89F043 
X-CRM114-Status: UNSURE (   9.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

this patchset adds two new functions 'gen-dhchap-key' and 'check-dhchap-key'
to help generating and validating host keys for NVMe In-band authentication.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  Add 'gen-dhchap-key' command
  Add 'check-dhchap-key' function

 Documentation/nvme-check-dhchap-key.txt |  31 ++++
 Documentation/nvme-gen-dhchap-key.txt   |  52 ++++++
 Makefile                                |  17 +-
 nvme-builtin.h                          |   2 +
 nvme.c                                  | 224 ++++++++++++++++++++++++
 util/argconfig.h                        |   1 +
 util/base64.c                           | 100 +++++++++++
 util/base64.h                           |   7 +
 8 files changed, 433 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/nvme-check-dhchap-key.txt
 create mode 100644 Documentation/nvme-gen-dhchap-key.txt
 create mode 100644 util/base64.c
 create mode 100644 util/base64.h

-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
