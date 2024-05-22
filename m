Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3F0C25B79
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f+lqbfJ22HG6ouRnJlNVNbCJVVohvUQ//BuvvIZ94Fk=; b=LBvigzmF6PZDTi1oWOSiP5Xhzx
	5csejWP6X8ckht+5d/gCWXatGOa3GqCs4JGjES9ftceWt2AZXrYgaJZVbu8Mm28/sZalb7bAJDeqp
	l9fQpbjnzlBWsTXydU3uiYuJiCT4xhicrEr/VMhsoPp4o7rdSsFzersfYL/3LSprh/NHcbMMFZhkb
	xtH8bUzif2r0+y6nkyn0hmjq2xuWWmclwrJNgYmNIpwPGFBP8/ScFPLhV09QvcS6sO91vD/rpucrz
	hyOKrwQYRhRDJsLTfHkwLeERA04y48fdUxzw/mMdhFGtqCQ/rm75vggy25kp3Da1kVjxQCvpqYEQZ
	R/7xk9QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oC3-00000003Qc2-297U;
	Wed, 22 May 2024 15:47:55 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oBy-00000003QZ1-3tev
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 15:47:53 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ee12baa01cso11216825ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1716392869; x=1716997669; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+lqbfJ22HG6ouRnJlNVNbCJVVohvUQ//BuvvIZ94Fk=;
        b=dZNsHII87NuVL0/jaHn6cYsaMEA9jumENsNb6CyOxtJwmZJpOH/DBoHUi3kpkjPg+p
         OcyvPXp7HTqv4ZtAGlx68ni4yyCC5CCSGXN3hhE8uDAV0EW7WIhyVvzWqRo12/6eUUYV
         4M5ggERWQfiIixWP5DQg2um+DS4ZGLygTEgto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392869; x=1716997669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+lqbfJ22HG6ouRnJlNVNbCJVVohvUQ//BuvvIZ94Fk=;
        b=qvMf4oUXtBwN6DFxqJAc4Zs7CYHsrxDyNxovZh7HgqZn03ulec6CSAgYyjwR3+ux82
         PN4K7VFm9WzXp9HLgexRztoyx70pXVzFUN2roCzWoD0MzsJGM5qsUXxGPRbK4mcwOtXD
         3WOJxaRxZxkeoMLq/VrXiFdEjg0GRzcu1hPGGYN8Kpow1ljqrQwEH2cSzPV7BdyD797E
         OeqDIl+vYMoG5VZQSqUZSAaG7cx/fvm/D4IGOPU4d+vFDgOkTY4mql0OL+v8yHlWKZu2
         irbcdDRgDf2VijNzc2yOUdJ8QLjw0aSS5v3eeq6nmCDiS6Lj3Wtwjlum1fAdEg7JrAws
         JS7A==
X-Gm-Message-State: AOJu0YysXQRC/xj0+4OiG0Jh2yJuVM1vFMM5x1Ea4hBTK76hilpb+eQ2
	2bp7twI3IKjTYsWlz6Xud174cJSzpfTqQssuznBOYZrpqzmOTNEDB4ka52ySr64=
X-Google-Smtp-Source: AGHT+IH9bhL1W0lBI4uaEoqev361S/Vr9/EfRyIsUZkjSAvgBM2LxnAoBV9dX8qLGXNG2Ke/ir2odA==
X-Received: by 2002:a17:902:e746:b0:1e4:9c2f:d343 with SMTP id d9443c01a7336-1f31c9760c0mr29438875ad.7.1716392869146;
        Wed, 22 May 2024 08:47:49 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137fc2sm240913245ad.258.2024.05.22.08.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:47:48 -0700 (PDT)
From: Jason Nader <dev@kayoway.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Jason Nader <dev@kayoway.com>
Subject: [PATCH 0/1] nvme-pci: add IGNORE_DEV_SUBNQN quirk for device 1987:5012
Date: Thu, 23 May 2024 00:47:15 +0900
Message-ID: <20240522154716.156018-1-dev@kayoway.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_084751_012688_D9F9A8FF 
X-CRM114-Status: UNSURE (   8.79  )
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

Hi,

The existing quirk for this device was missing IGNORE_DEV_SUBNQN,
however on my system it looks like the quirk should be applied.

Kernel logs before this patch:

nvme nvme0: pci function 0000:02:00.0
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme0: D3 entry latency set to 10 seconds
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme0: Ignoring bogus Namespace Identifiers

Kernel logs after this patch:

nvme nvme0: pci function 0000:02:00.0
nvme nvme0: D3 entry latency set to 10 seconds
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme0: Ignoring bogus Namespace Identifiers

Jason Nader (1):
  nvme-pci: add IGNORE_DEV_SUBNQN quirk for device 1987:5012

 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.45.1


