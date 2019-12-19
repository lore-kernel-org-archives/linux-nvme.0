Return-Path: <SRS0=TwGh=2J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13017C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2019 19:05:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8092222C2
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2019 19:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YA6ZOJwy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+X15vd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8092222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tsQLzO+UmOWfSSj2rwR5z9my/FlrO/cGpc/Dk0tsNe4=; b=YA6
	ZOJwynFIWh018zdl6+AIODlSMMCSwbXiDZJzHwioIB1nw9qKaF1b04j4qCbYDF1Sv6yuldvoeyN3X
	P1ThZcwXwQ+k2EpoUGyf1/Z0tvBBfZgDcGiAihP74YrxG7tPiKGS7R4GKkaAAELYjG26ZQyhgoMbA
	aAmABq3GgWMeqixxa8j6SJckJmlzHY/araKmCYE66afGw0NEoK6J6MqH+RJwH1dZ/Y7jFj+GpvLHY
	4rX5Wbwm8haOxDf0EgUL8DNsubBvV87tENe4NM333W8CdttV5Z0BPBVUubje3p+TdLUTyXrU7Pfcd
	z0mFOm4oVx6SPf8U+0dnuOIxlM1MMDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ii17N-0003hz-Dy; Thu, 19 Dec 2019 19:05:49 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ii17J-0003hI-U7
 for linux-nvme@lists.infradead.org; Thu, 19 Dec 2019 19:05:47 +0000
Received: by mail-wr1-x443.google.com with SMTP id z7so7051618wrl.13
 for <linux-nvme@lists.infradead.org>; Thu, 19 Dec 2019 11:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=bN3f8gKQpi1tPAi7KBbd5oQjTFtNBMOeohxO2rvatdY=;
 b=b+X15vd9Xst5NoQedaS2WaDVpS0uU+XAUyH7f7tW7dr/dOkJbmeZT2iFp17mhwHe5f
 YsSY0aqL+0TJGQ0IU+F7VL3KjklS5YSIvMSrJhT933wNh/oG27YTEX9XjPxlKhEQny4I
 YogVvzkVpcuQ6VYHKkdL0pDECcOExd1tpu2GoiYQISRtmWa2JFfCT7eCpYPUPTT3poXC
 5qOuSeMu+u+y7ME8zPY784rTEbDe0uwBGk16U5N29I3K+cd3qpo8izBqsASltHR9B5s0
 o+swDIDdZMInN7iohucfRHktNuuuN7cuBa86m7rfMplLmFbjRbUPp9wayx5T7+sVhaSy
 7AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bN3f8gKQpi1tPAi7KBbd5oQjTFtNBMOeohxO2rvatdY=;
 b=gq7wfHuyZQDiO0I45r66Pmd33CGDF2898qFKKwfLkJBtT2JmW/YKwe9Lod/yx6GzCj
 CfXwPBaAkS/5iNPoAqEp6+rFyRh59Bd/B7zgQ4IxdeDUNwEk0HWk/rO5/srmNdkU8Xns
 Ine90KiOWoQCdj2chL/RZKvTOFfIhf5zsjJFywqg9+hjtChcOqF0bQqGrCUMN4nj4nvw
 I6HpsK2G/F1ME6sNzjzOT6N5L3W35CWkoVAWDwgALQueKpt849tjXl3mRkIxIW9SBJdO
 5dNApSKRkH806gobsNLuOWFVeZa5fktdg0BDI3HikPYfwqWeE35NoPsb4wmsaFpfa1N2
 iSOw==
X-Gm-Message-State: APjAAAV44FQosdp2WkaB1KkSlSIkAZU/HaqE6iw5Tn0ISnTyBYoRPMuF
 B9bEmdO3WBtWeYKHpMFfe1bcnzlB
X-Google-Smtp-Source: APXvYqxKfUekI8DQGMKzvtmsVVYdE4EoekezR+NPVw6XCFEQSHPmFWi4kyBCa98qaWHwlM/XFdTNTQ==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr11545997wrp.171.1576782342983; 
 Thu, 19 Dec 2019 11:05:42 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y139sm7618648wmd.24.2019.12.19.11.05.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 19 Dec 2019 11:05:42 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-cli: Fix systemd service script use of CONNECT_ARGS env
 var
Date: Thu, 19 Dec 2019 11:05:34 -0800
Message-Id: <20191219190534.11673-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191219_110545_976618_249BDB18 
X-CRM114-Status: GOOD (  11.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In testing, some environments are not properly expanding CONNECT_ARGS.

Change systemd service file use of CONNECT_ARGS to be encapsulated by
apostrophes and parens.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 nvmf-autoconnect/systemd/nvmf-connect@.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmf-autoconnect/systemd/nvmf-connect@.service b/nvmf-autoconnect/systemd/nvmf-connect@.service
index 10fb3aa..c60f146 100644
--- a/nvmf-autoconnect/systemd/nvmf-connect@.service
+++ b/nvmf-autoconnect/systemd/nvmf-connect@.service
@@ -11,4 +11,4 @@ Requires=nvmf-connect.target
 [Service]
 Type=simple
 Environment="CONNECT_ARGS=%i"
-ExecStart=/bin/sh -c "nvme connect-all --quiet `/bin/echo -e $CONNECT_ARGS`"
+ExecStart=/bin/sh -c "nvme connect-all --quiet `/bin/echo -e '${CONNECT_ARGS}'`"
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
