Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAC6CCFA02
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 20:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=; b=Whmpy8bdPdwmdUAc0X/ux69lP5
	+jjrDr/F3Ffx5bbAKjMsmCgA2WR46JT0AplcAliwnSb/gpNKzJcTI/OXMa41Qx6P00AjLudKrZltH
	W2srSgXZvq9zX6Q68QT5EIU3AQWAVyaUnS4FWNKxlERbHp+jSnSqrq9XG/ATNBK/YY3yyMbCLX9Ie
	OXxQ/P1kmWLmhWOKUeUGWjKxmNz0Uwwetbx4sNjc9ssFDGJNCzDWadWwxq33dMrwvFP3n2PwTrzIA
	OpneTym1dELJwNkqUcmBysvGvUkDPTknQ8JwOnN5LrE1xZYOvmMGKP1yGfDbRG89EE87O6es6IkG9
	jOp72nPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEvpa-00000006mPK-3jZD;
	Fri, 31 Oct 2025 20:34:42 +0000
Received: from mail-lf1-x163.google.com ([2a00:1450:4864:20::163])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEvpX-00000006mNn-2oLG
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 20:34:41 +0000
Received: by mail-lf1-x163.google.com with SMTP id 2adb3069b0e04-592fac6c37fso325797e87.2
        for <linux-nvme@lists.infradead.org>; Fri, 31 Oct 2025 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942877; x=1762547677; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=Dqtk4EW4Vtvj8OPXgWeAQcv6FcUbjEM6XjNC+YxEKflb53GhS4ih3q3qsBxWtp3/qA
         +JyWFzAPL+9kd7FPX3yIN0OBVNpTrvNY9BJ/yKlUDa0yPbKxKESBNUaR7HsO2z2o9wHw
         PLhT/1pBYY9qeYFAOrwq5CBUP3PdFpE01k8A/QbjAHiXgJso/7dcFKMDXAFubynQuG3W
         ggONsLnKexrNtWn6aGwRWIfn0lS7jAOLy+tC/vG++gTVoxRPmzov0wvSqj4oiwYgMkHN
         hmFx0qSK5vk0qvTBZ+y4XQ4LfqIuIdPLTk8rsIO5EBx/GV+yjNILajRYtqkRQpfUusZ2
         etMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942877; x=1762547677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=pT3+2yTAy0xJVId+3GRUz3xy4P/v5aIKQxigdK4O/6Xzl+XaVcULIND0OzxvIeBAXe
         EcRwIokx1wKDrYML1rZomSd0XawP+GE2ZpTVXL6NcYT1eSo8L3zCxNSvo7VLg21raY+u
         Oh+8HIYLDNnvBIIhO/GkwUxMnb+hhMterG31tb7wD/PPRJjmZDV6b+2Dntbw7NQJPy8B
         VUo4JpF6VCuw2BlACDzA4Xj764/SMwK/Xr39/e+oPhBCvqpE/AyjtL1FZMC8dne6FsoG
         Wi5tXZGwxS6X7vAapSqsOvAsZu1nqcccvM+KH0wPMVyVn5NEEriaG9DrsRStnlac2mCQ
         mshA==
X-Forwarded-Encrypted: i=1; AJvYcCURLlpPjba5JKbPQiXY2uH/wKPxDQXXdsMyhURQQkJLJy7K4bJCUdvYzx51tL1rfEkL0CssFN37D8iC@lists.infradead.org
X-Gm-Message-State: AOJu0YxrEBzh4IlgvPaF0g46fe0pUUnIN+nVZLvzDE4pocsczNyMr+rF
	UiIriYFxJWZNTU2gC/f9NpnLZ5ZiSbj55WA+gAWsiSo5d78TUO/2p41FptT7UMVQZ3EgQ2UIr2J
	M9VgYtzMotI5G4o3ek4ieqewHO2Wh9prBjDLg
X-Gm-Gg: ASbGncuMHewCOYwK2jW791gbopC70RY8S4WZVdyk6qJ8HUzeHiK8GGhosEJwNxLf3xI
	Y7vmh3MJlOb66JhhfcMLLsUkzoHzG0V6vMzk9u2Tvm/KFJV9IsHQTMIwy63ir61+oLKu30YZkcm
	831J2/fJQaX0OaJ2a4RjXMyj2hPAQHoe2rBnnhYmu1yHSY5E3VDCAg6XjwUzZj+qDnNiDFHuFi5
	1XiYHFYGSsJm0Hjz2hJYNd6K9DtzPZ/PusQ8PF6p8Hq48hycr+TsjfEthLVA7ziGFj6y0uJDirM
	Hf/eUzEAslVIJdr1MUjCVuhbVICtd8L0Hm13l4RrHnSbUrtZIE3pKpFCVSklfC07/g19ZPXLjkb
	2yiR5VH3BIFhVRnwl4u3TIJHzD4watuI=
X-Google-Smtp-Source: AGHT+IHYGUnO7bV47O6a0JaarTqAfmI/2Y9l++bnlFY3ld+pOZSgy8vCnY+sYVKLt/9KYUiwgYpMC6aTC4ND
X-Received: by 2002:ac2:4c4f:0:b0:592:f7b4:e5fb with SMTP id 2adb3069b0e04-5941d4ff894mr969734e87.3.1761942876878;
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f3a30cbsm287556e87.27.2025.10.31.13.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4EBCF3400FE;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 465FEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Fri, 31 Oct 2025 14:34:27 -0600
Message-ID: <20251031203430.3886957-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_133439_919792_F970C978 
X-CRM114-Status: GOOD (  10.48  )
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

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd.

v4:
- Rebase on "io_uring: unify task_work cancelation checks"
- Small cleanup in io_fallback_req_func()
- Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
  is only used once (Christoph)

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: only call io_should_terminate_tw() once for ctx
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  6 ++++--
 drivers/block/ublk_drv.c       | 18 ++++++++++--------
 drivers/nvme/host/ioctl.c      |  7 ++++---
 fs/btrfs/ioctl.c               |  5 +++--
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring/cmd.h   | 22 +++++++++++++---------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 26 ++++++++++++++------------
 io_uring/io_uring.h            |  4 ++--
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 19 files changed, 101 insertions(+), 87 deletions(-)

-- 
2.45.2


