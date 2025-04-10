Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9ECC369A8
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QA3KmfyehebAVYU6nJ2T2c+brMsRMYEk+lhYLvrsBos=; b=ZyqFdCIxsSJQ41iychLMj5pAJT
	O4BrPM4Ixy+LYq95I4YNA2dfmUfG1NVhIfMhaUGElzl8bx1/4QSlW/5fEhUyeqoCfn7zOo1+3suXB
	Sm5eXInHca8baSyq8CFC/SSos4F/h7LiDvjIkVY9b66RO4Ib0xnjHsZswLArYW+SJpvtSlblNuHUc
	5z3wnovR0TMG0teV7VCtzMrSB0DdZnHmyKdnReN4/rkTmKg9AHKnluDBiqAMwanzbSUZyjVrs48l6
	HHOLXJY7hndsG3fpwCxfMr3Bi+4O0llYHtbb1D5o8Hd1vhc6kia6zTz4J4r9R+WYvsgxSlZtMerBB
	ZDIez3kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qu6-0000000ATGn-2yQa;
	Thu, 10 Apr 2025 12:21:10 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qu1-0000000ATGK-2tHn
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 12:21:09 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-736b0c68092so533023b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744287664; x=1744892464; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QA3KmfyehebAVYU6nJ2T2c+brMsRMYEk+lhYLvrsBos=;
        b=dNGAA0WMjOuIu8a7kz9AsKWzVS8LdVKJw2BkP5RidkSwitow/P15S2NuYUgSUFwx9+
         5ZXvnyhvZRYug/2HqABQ6qSLJWfI/X9EnJup5qyUgYuX/wTrmEDllBhZ2tzWiVyZakGw
         IsEbyUZCevK4WjqVaefDIGid8kCSYp3qLo7I996JQeXRI6leEjOeK+ypsTvMBNQIgyyD
         kUzyM1drA/htINgp1glxXvMpvzKpsx1J1jsv+Rup7KFsyqTBMwJ4yYokG+ikQbswb/lp
         sNQBEJniQHyD7en1WajO9j89+dsWs+P2d6yl9P9PvGfUyW7fW9c8iyZ8J2ptJg020d+l
         eo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744287664; x=1744892464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA3KmfyehebAVYU6nJ2T2c+brMsRMYEk+lhYLvrsBos=;
        b=DORSHqZtjHKdKzFH9QiVwV/J5I+o3fp47OI1yKJyqxxs47q6WQfcyxqHcEviY9pEWq
         QnlJzo657wwbBUE9lvpSR8pJN5FxE8ziuySOViClKiw7BmY2chm/KirKGYE/qMh32ugr
         FwDcCvuv5xCaW7+TcLiZNxxHapWUTKW1QxLkgar31iRSksJkUU4GXzhxrgPEfqzvbEtq
         uGnP9lft1+iEnf2oKRZh5WuY7duzUzo1V0tlpZKd8iypghp9CNDpUwNCyw1QD5bElrhR
         qt8tv0aji6o1uX+R1BPyMWnbCxy01vFlquwSRvlNiecBg5hNe0qSkQRXKzwruX5hjsEz
         9CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGbDxpkzLEbVl+xP9194uWwvRYdIbIwxPIQpm4qoafMN9nbXMQlDcJJn1Yj81208iIlqHZwF+tdMwj@lists.infradead.org
X-Gm-Message-State: AOJu0Yyh7GYlgeJWCOeSNsUAE99LjBqoUh85ux6UE9t+mDrpGBYjU9DB
	i/t0FWmGsIN0DBIE7Z9eLjgTx/MWjBaUWkC3okCVDppAUzVz8vcz7O8WrfClHGc=
X-Gm-Gg: ASbGncs18nzYnAM/+BKMBLw1Z/A1iwe1TFQM4Q89IVOe5UT1lWnRUcwetrXtGVm77+r
	/7Pfobo5ApwQtfBw6th2v85O/JMvmMNSbHjmoR8vh8J8krRZqURmzlywOeSUyXXSeOyRCqVVfgi
	0Ox6PLB1nOsGXLtFCKRLYGIaMoEd4nY0nh0/ljp2OYYYd2KFlDN4pH8b/Ao2ZAavskK1miTHKAR
	jwkOBh64TKYk+ZrW3MIolHksxcLJp63c6uO3H3R29hsSSzSpPJJzS0fw6mWD2ZDIfPJvv3Gng23
	2mP6U4BY3pO1WlWVBwpxXyIWYFg5QuTP
X-Google-Smtp-Source: AGHT+IHWEik9cQ/zd7MNWUUIFcGAk9FcVDtEQndrP8Td2l3ETeq8NPgDcfTXskJhRwicaofka10BIg==
X-Received: by 2002:a05:6a00:398d:b0:736:b101:aed3 with SMTP id d2e1a72fcca58-73bbee3255emr3213252b3a.1.1744287664085;
        Thu, 10 Apr 2025 05:21:04 -0700 (PDT)
Received: from localhost.localdomain.com ([2001:df0:a640:1::4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e38258sm3186109b3a.107.2025.04.10.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:21:03 -0700 (PDT)
From: Jiewei Ke <jiewei@smartx.com>
To: hch@lst.de,
	linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	kaiqi.chen@smartx.com
Subject: [PATCH 0/3] nvme: add support to delay retrying aborted requests
Date: Thu, 10 Apr 2025 08:20:51 -0400
Message-ID: <20250410122054.2526358-1-jiewei@smartx.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_052105_924924_D9D239AA 
X-CRM114-Status: UNSURE (   9.75  )
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

Hi all,

In this thread [1], we discussed a potential data corruption issue in NVMe
multipath scenarios when retrying I/O during path failover. According to
section 9.6 "Communication Loss Handling" of the NVMe Base Specification 2.1,
to avoid such risks, the NVMe host must close the connection and wait for a
sufficient period before retrying an aborted request. This ensures that the
target has enough time to detect the connection loss and clean up any residual
I/O.

With this patchset, the host will close the connection and wait for
delay_io_retry_time before retrying the aborted I/O.

Comments and reviews are welcome.

[1] https://lore.kernel.org/r/DD72B155-35CF-47F6-A342-13445A9E432F@gmail.com

Jiewei Ke (3):
  nvme: check IO queues liveness during controller reconnection
  nvme: add support to delay retrying aborted requests
  nvme: export delay_io_retry_time to sysfs

 drivers/nvme/host/core.c      |  3 ++
 drivers/nvme/host/fabrics.c   | 23 ++++++++++++++-
 drivers/nvme/host/fabrics.h   |  3 ++
 drivers/nvme/host/multipath.c | 54 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  7 +++++
 drivers/nvme/host/rdma.c      | 27 +++++++++++++++++-
 drivers/nvme/host/sysfs.c     | 37 ++++++++++++++++++++++++
 drivers/nvme/host/tcp.c       | 27 +++++++++++++++++-
 8 files changed, 174 insertions(+), 7 deletions(-)

-- 
2.36.0


