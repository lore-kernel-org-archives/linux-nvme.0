Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E2FCCF9E9
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 02:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=; b=GEFusINYPikkK5DMCN2eGG4C5b
	evhY+qOo5QsxzqoDgwvFW6jvHUKosNqXjm/fcDhOVZy17oSbmq+ju1g4X9+p1WckYAC0TGNRuQrOH
	FHJCNfM4GLLwOjj9iflXlbvsget9y2RD6/O7N4ba2cAYhNMjyy6EddisrZPr0CMxu0VbkBggYSDgA
	e05tFdYptuVXEQXokQSzSEmmoblgiO9pZ2+eLi4W9dHFQXclNqt1BA4BXHrGOQ8rCh5qGvs6jSroZ
	sN/lxxBoActXU803Vw5wJg1Mmsy116cJcGcZPCzExXRPB5sDUh1nC+55TMkmAq69DfenfqJ0GEIWg
	NZz33KLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDCZz-0000000CzH6-1fgg;
	Mon, 27 Oct 2025 02:03:27 +0000
Received: from mail-ej1-x662.google.com ([2a00:1450:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDCZh-0000000CzBz-03Wh
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 02:03:26 +0000
Received: by mail-ej1-x662.google.com with SMTP id a640c23a62f3a-b6d3f38416dso89035366b.3
        for <linux-nvme@lists.infradead.org>; Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530587; x=1762135387; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=;
        b=QE6SfVF7L0b5+Jz6zGmcTDcwVxKSsUj++FmNDb0HfbNhQB4bG9QyRV1tZn/PN0zWda
         6M98hi3WcGvbgz3wJol4csItZMQK5jlNdPuW/qI46KCNaLu5eMj2Y+mw6u6p7KuQCmlW
         pG0XUUqIopJRO9exsMR15ccAdhHOoYLzLLhlxK7btdt1Q01KaxpPj5p1JTzXECDYpNyr
         GU5hiDpLSH0BvfCP6soU6O/f8udsBVkcA2jQgol3s7LOmQPE9ugM1g3SwhfeCIiBD7nZ
         T0WpBR6kwS4PWdzwwpM5xKtfgqdXWeWYiR/PsjjEeGyGp53AjekPU8/oSwHHim/R36yv
         ydSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530587; x=1762135387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=;
        b=JkFteWTHzBhFLmuB1RxrXskVXq34f5dPE+vRbEljB8MO1/LHeJtmLeg0Q8lg9iK0hR
         QtJQsvQniEvm8WKiRTmUIY40AjDdFYbBtqtB8YMiDLiRNklUXZpiZ/cnrOZFGiv/GP3l
         Dw9CGhgaBQczZZXII1IoaFFwTZXwdllv4L/2Zq3FIa6EKHfZbiwvwjNRzseRoln5Pv++
         nrjOJRLj8wyBltpYdRtWVa3IMbQCj/8XkMfNddLo4k9QhBLSlDtxjb4dk4Au+pWppciu
         A2sqrFIU+rCAmsf6wI1hnV/67vaHdHtqYy5CIwKYcAluc6uMiBFHrzA6xpCF75dUGGK7
         lBdg==
X-Forwarded-Encrypted: i=1; AJvYcCVk42rVgkDONF8KfShlFZmwQyFrj3Mi8GIPzTa8KXt01PGK/fYkBIkjT+bLlV41BCT0FHUje5OqP4/R@lists.infradead.org
X-Gm-Message-State: AOJu0YxCqfBneZB9bnIuUpBH1kfVbfPNh/UprqwYO/7uJefmzJd4SBVJ
	CugnbmK5+wlT+sSVzLKbMPZJrhLlukPhCPWRjM1i0DjWXii8B+OKAkzqjDKnXlsRG64SywXnPAl
	8CIxvmhs9x97D1oBDoScJ3m7uqtnSPi8AYJc0
X-Gm-Gg: ASbGnctt9Iy6HJ1ySMxYZTY2NWmnPDyIXE5nIS2H/S6ZWJ7KsGVQ+BsgPW1lAAVg5UU
	ECYhEi0RTgcWuhrmqtwg4XFHJEfY+fiF5Zs1pISDj12GGlWjJ8K22xXrSX/toJXdytnq8GkMLIv
	WwbjzoYFVsAd2lULjyYr30QrUGwOe+QcaSCHCmcstgwyPYx1/XRk9p7Yi4en24qq6B33GPshMlG
	E33aCuGnBo9+lv9w+vAgOkHb03Qd9+GKX/xFmAra5nhwP3IofjvfXiCnW+V4ifjrv/u3nWoyIID
	LAgCmHQ57UHwKVnQNRVvPzTxtBJNgCA7/ECQgzFVvPlj8afjg/XzL7ERT/4K8gBzh7jifWO9eBN
	lAiY6GIWdi42E0YzCipzZgJSzqmsI7Vw=
X-Google-Smtp-Source: AGHT+IE4hiP03f6lofOOS2+HxUXFo5vKINW/jUKRpaO25HyrXJmcC0Z82zfs5/zGzfiuKTm+aQhmKlmbZdW6
X-Received: by 2002:a17:907:c24:b0:b38:7f08:8478 with SMTP id a640c23a62f3a-b6c72716445mr1473292866b.0.1761530586723;
        Sun, 26 Oct 2025 19:03:06 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d85418ef1sm55541366b.47.2025.10.26.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 46DBB3402DD;
	Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3C232E46586; Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
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
Subject: [PATCH v3 0/4] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Sun, 26 Oct 2025 20:02:58 -0600
Message-ID: <20251027020302.822544-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_190309_217977_9B0FC345 
X-CRM114-Status: GOOD (  10.06  )
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
save 8 bytes in struct io_uring_cmd. Additionally avoid the
io_should_terminate_tw() computation in callbacks that don't need it.

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (4):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  4 +++-
 drivers/block/ublk_drv.c       | 15 +++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 fs/btrfs/ioctl.c               |  4 +++-
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring.h       | 14 ++++++++++++++
 include/linux/io_uring/cmd.h   | 29 +++++++++++++++++++----------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 21 ++++++++++++---------
 io_uring/io_uring.h            | 17 ++---------------
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 20 files changed, 116 insertions(+), 93 deletions(-)

-- 
2.45.2


