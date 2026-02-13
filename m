Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E356EF48C6
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 03:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hNjsk/uff9pARkaRzlte1yX2NQYGh3GjyfK1pUQCaAc=; b=IO9KeeaBwGw4QwrhMWE7k/xqKD
	kuAJ0vcjLhJPY1CvNiDeGz0uZOk3+nCd7J6AZ36rapdlxI7GSuVSKeRamRCnOuFSnsw3yYl0+uk74
	m4uD30rk+ZZW2VrFD8DVTwptyBR8kQBQlgjX1Ye6WlDB+w5foM3mKMy2gYbE4JV/rGb0TZqK47Boq
	SBW3gdCRAi5HtPlearFN7orlOGLJFhZgD+JvKKfT12sgG1/nKtuDAViqoelxfgEPWfKQNw40AQhY3
	aPU35aYUHyModwfsqSHAHJRlu5BhwNtrsVTEb2/fjDoN1nUFfEmSofDgf/pywHGBK9/nTRrISLfTq
	KUFVHb4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjkO-00000002uG0-3FGL;
	Fri, 13 Feb 2026 03:21:36 +0000
Received: from mail-qt1-x864.google.com ([2607:f8b0:4864:20::864])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjkH-00000002uE2-3r57
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 03:21:31 +0000
Received: by mail-qt1-x864.google.com with SMTP id d75a77b69052e-506a65d8698so72611cf.3
        for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770952888; x=1771557688; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNjsk/uff9pARkaRzlte1yX2NQYGh3GjyfK1pUQCaAc=;
        b=BGaUxOXmivK7hcOvsjr6s8qYAFUwrel0elitoYZwqV7pUFce1WllEOiLgf27cSX+Aa
         Nw636314AaB+4ickmqA8f4KIemAIcm7dT1wXp5sUivV0RNxD+RD7mK6/coQW8UN7z9DL
         DQDiUIfkCsaL8vyj5UwPsNQJzX35JcznXT1hdHjKaElxNqMZGZuRs41w8v726BtMVkFU
         92q7SGLiJYy/S5RCAlg1UjQJxqQ3q+bPlGpwGVsIXK3Mck0fbPmAxZ6JYSUthG9tO9bx
         AGBFoMqsctlhCeZwPeFLXSrI8GQfqwV4deQhFE+gJGOPVEtCCCL7J9ajBi61oU28UBTl
         i1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770952888; x=1771557688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNjsk/uff9pARkaRzlte1yX2NQYGh3GjyfK1pUQCaAc=;
        b=BvwV3Q/WzolsohjouB6/EnmsIbu5Cv+Xa4DyPPlwM6Wloery4nIP3LDWjTfv+5P0Kg
         tSZwZPhD3wpSgNSi5xy0++BO9MZ9ExO08G3SqYf6XsHPUxFkDz4+UFjG/y2G+K1cDDst
         qKJmfFY3LhvSqgXTBL20vItF/XkAAsGVOKWfIA7+Spv34Nh/ev1ix793o7gUtVhkxVLW
         W8zzR5AgOVlUHASnAKzip47PIIXGj6LCeNgjwH1RDB9z5NLSpuVRW0evaz/uZEHxxZBg
         Sk/1u6Bp8cFnVi3kWPQPpb1mrtO/LdjZ0sPrJ8GQGfuxxwqZceKtlgmBazvhBZ7PKRLv
         U3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Bkrrl8Q3ptb+u+26XP0a40vuseeyf68B0Lpq+l+EmdSRM/GiRnK8RT2pJYK99T6O8eoQVq2LB68u@lists.infradead.org
X-Gm-Message-State: AOJu0YyGleEUmUenhT8RtLNWdsXFyXnqcYlkvlhruUAajF2wiUv0ni+7
	KsAjoZAeVo2lmCSSuEBXnR+ijl2yvt8GYcS8DZXrWannYgy1J0u5aiu8VcJxEvZLXTq92Gxgb6M
	3wcK52xo4VMYEebSM+6S0QjYt5giGfuEP4QNoKzC3Mu1PySIDJpwC
X-Gm-Gg: AZuq6aL4m8L6E91xiqvepYGcn8dJpimQhWI6UPNkcrnhurRmx9A2hKeG2zuuSnfgtOU
	zvg0nBDtdjlOTISOHiiFHcmHHFcGf9jG2llkcrtca1keNaesnYZVtg7kykOe6tpJE+eEVnZc635
	qSQ4uz74CIdU4hGr2expnnAVyRdNCz0WCFjrf8b379/Ae9+oNgdaSJRCy1Aeoaj2WY8YfzN3Nk2
	iAWnVd6vbFMNt6Mcc2DigRbaesW02ZDwNEui2NF8peWggH9/pvK2nN1oBrhwlQtrx6Rzic5yOxs
	Mq8x5Ol+5Dl3z9cMgNqVFrMX2VzHYLLiD7Ng8UfwQFQTbPMn1WtOSAp7a1E0Wnzn5WPmUCdiFCs
	2RAeBDzA5Zqy/aSBL9mZkjp4+8JCR1D0ey/X9x+Y=
X-Received: by 2002:ac8:574b:0:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-506a6a604damr9881811cf.6.1770952888246;
        Thu, 12 Feb 2026 19:21:28 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50684b8e231sm4821541cf.8.2026.02.12.19.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 19:21:28 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8A5DA34050F;
	Thu, 12 Feb 2026 20:21:27 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 73459E41DCC; Thu, 12 Feb 2026 20:21:27 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Thu, 12 Feb 2026 20:21:16 -0700
Message-ID: <20260213032119.1125331-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_192130_130410_C8ACE8BE 
X-CRM114-Status: GOOD (  13.15  )
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

Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
requests issued to it to support iopoll. This prevents, for example,
using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
zero-copy buffer registrations are performed using a uring_cmd. There's
no technical reason why these non-iopoll uring_cmds can't be supported.
They will either complete synchronously or via an external mechanism
that calls io_uring_cmd_done(), so they don't need to be polled.

Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
even if their files don't implement ->uring_cmd_iopoll().

The first commit fixes a few bugs where IORING_OP_URING_CMD128 isn't
treated as IORING_OP_URING_CMD with iopoll and provided buffers.

The last commit removes an unnecessary IO_URING_F_IOPOLL check in
nvme_dev_uring_cmd() as NVMe admin passthru commands can be issued to
IORING_SETUP_IOPOLL io_urings now.

Caleb Sander Mateos (3):
  io_uring: add IORING_OP_URING_CMD128 to opcode checks
  io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
  nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check

 drivers/nvme/host/ioctl.c |  4 ----
 io_uring/io_uring.c       |  4 +++-
 io_uring/io_uring.h       |  6 ++++++
 io_uring/kbuf.c           |  2 +-
 io_uring/rw.c             |  4 ++--
 io_uring/uring_cmd.c      | 11 +++++------
 6 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.45.2


