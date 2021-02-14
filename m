Return-Path: <SRS0=P1pc=HQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2570AC433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 11:01:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E72264E12
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 11:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E72264E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K2ILsapXo9wg0GzgcYYAlrSh/ILurH0oIpczFleFNPw=; b=0maj2pDItvNbpJoXU4dT7OmMmF
	iCzTBMX3QaX9AZKZ0CcU8nKtP3AAGyxd2GkGzuxB5XcWBS7WxjM7UvLZD2gzqmBlHkUPmmhzx5ySA
	LLsZLIXgBjOkzthy7xMLss36VHdfm7P3qlf7e3ZmvuiZZRPG+etooOaDFH93yIU5M8r3KaMFRw0aM
	AhEhZSDaWirAKk3vkrymBYuiNStxS2YlyrOJfrDSNa7Cf8vNkUMGseQW2uwc70Ybdisv7j3q81Lyb
	xAFPPYelB9H/rtlb8RrxrSvlA/JUbhAKXvPCnahpmQHA0BwXG3kZY4noB/7boTW/k2rTwlkdthgaI
	MPlLSWfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBF9k-0004g3-6Q; Sun, 14 Feb 2021 11:01:36 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBF9i-0004fk-62
 for linux-nvme@lists.infradead.org; Sun, 14 Feb 2021 11:01:35 +0000
Received: by mail-pl1-x62e.google.com with SMTP id a9so22955plh.8
 for <linux-nvme@lists.infradead.org>; Sun, 14 Feb 2021 03:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=mOZxdPl62vTxa1seyULq2LEYhBqFX9nRgQnsMxYO5DM=;
 b=X5G3VXdfl5mUyPXsGUD9ySthbkGeEeruXUPHqOPh4tfMghZ/HS5a4N3bWwVsvUNUgB
 9meDENXVCjMWFuZEbEvPWvy+MHg5W0KT+jyF98Urq4C/T1o8FZeaoOgMY/8zLlL3Tld6
 R+U4j8x6jUytVBO2lJk9FCmWoJPKx5lu0hYWR9dbT2YLxPi2Q87LQigoduVcBymPXOGQ
 z375R4VfGYJF8LbuxhEk9wxkgcdUmZ+Xl2eCesWCJVO8w7WIJEfO9pbnsk5TI6HEZH4J
 WK6NglUD30+LX6k63KgO4/5uQDhR6HgsQGADHwDHayZs0wLAa6QOwtEZKu3LKlzFjLrr
 ScwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=mOZxdPl62vTxa1seyULq2LEYhBqFX9nRgQnsMxYO5DM=;
 b=CPwl5t1E0f+ZIvyE6ox6jiNpogTvf49eVJkPJgrsVruOZnQ9/53JpcYAWjWkoinX/u
 XFHALOKsj9wA243NqBZchzVc3izBoVG94qpDZ9n/4mM9r7iJZ/BRKrmQrvSEXTipjvo2
 2aHB8ed7XF5hAcu6jHOK3te7kA4dwPJ8/OI3LjDyXothXeTDbF1nDRP6yZT1EPbURSzO
 VedTan+Wpp3bBRCkm2gaIwnUxc3Z56E0BhUEzBdk409YSz3T4fLx+sm4KwDNAA6HmhlQ
 maTu7o5ImqJ8lU230yMcIV11/XmN+iXWawMFuM+PJmq97FxSNmqxpn7GOgaxmq+FL5O3
 HeWA==
X-Gm-Message-State: AOAM533iBQIrWCwcg9UaPeV4Qwvps5Dchm995hscOw0hKeThvDdKxjxW
 U1Jkz8/NPW74ChYEUu73nj35VdyFkvyGqg==
X-Google-Smtp-Source: ABdhPJyohlzYe3vEoDIsh77V+3fz5Bt0/12KeyCLvwEoIbtXrdCC4p7o605Qz9QlYmytLY1tF9POzw==
X-Received: by 2002:a17:902:8483:b029:dc:3e69:4095 with SMTP id
 c3-20020a1709028483b02900dc3e694095mr10564061plo.66.1613300490301; 
 Sun, 14 Feb 2021 03:01:30 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id d5sm14223514pgd.86.2021.02.14.03.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Feb 2021 03:01:29 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: support I/O passthrough for multipath
Date: Sun, 14 Feb 2021 20:01:24 +0900
Message-Id: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210214_060134_270409_71B20C8A 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

This series is to support I/O passthrough for multipath I/O.

Currently driver exposes block device for the head namespace.  Also, the
path will be decided by the driver with the I/O policy defined to the
actual hidden device based on ANA state.  This means that userspace is not
allowed to I/O passthrough to a specified namespace target which is hidden
by the driver.

This series is to support passthrough to the namespace attached to a
controller regardless to ANA state (e.g., inaccessible) and decided path
by the driver.

Please review.

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
