Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BEBC9830E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2026 07:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eofGbpKzYy4pS2F+hufAR6Lu21I/5i0IX2p0adL7Y98=; b=CGuvJ/+Y9BVhqOIHTjR1cI23x1
	E9LqumO4m8FhIDWav8l/CNIxNQJJhnyA/2b8U5j9ukTN5U9o/0Swd59H+3jy6cYsNYry+umGt5Fp7
	3P+rom0wuq4d2edNKiX2xCyFLTaqJDIyZ6L1i8DM+dpmnARqJBDXN5UBDj3vJwKtqjpo6aMar+7DC
	HJHiLpeFydFNY8OxA4a9Bo35pttX4Owo5MmbOPGMT8SAC/G6+kewL+Om7vSc/2w/Klf5Iy6+YqdMO
	SSdm84EE9Q0hTs53SxJLd/p0GZ3ibShLnNo53KdxLpPoJxTfQ7kfM3YKRQEIPi2yTNzI2UJ2Dx34D
	yPiZk9Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAj13-0000000G5hL-06ha;
	Sun, 27 Sep 2026 07:09:41 +0000
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAj0w-0000000G5ge-1xFV
	for linux-nvme@lists.infradead.org;
	Sun, 27 Sep 2026 07:09:35 +0000
Received: by mail-dl2-x0e.google.com with SMTP id a92af1059eb24-144df39b6cfso1578317c88.1
        for <linux-nvme@lists.infradead.org>; Sun, 27 Sep 2026 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790492973; x=1791097773; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eofGbpKzYy4pS2F+hufAR6Lu21I/5i0IX2p0adL7Y98=;
        b=AkcHLdLo/o96sFOQw9m5iAhQ9xsMabj0DYJ0h17/utTlX/+D+uF0X4+0xEqHRmaOV2
         H2XEnP5lQWAMk9t7HpesBvZpa8nQBmBfPkwL40SHGuAUudhW2SmKjEv0hgY821ctnF6F
         7YAA/eWgQ6il5MCbNPYzYCu9KK17oj0gEvfktuGJZTep6ZHQ8VDYDsmG7uCtx4Zx68qK
         4o2LqZ8mfpxRFG6anPP6oImn3T1FOykAkVBzUqbTH7KP7T4tFo91UQ2Opv7eWMRPjtJ/
         irdUt87M3NWCnQgPtte0Oaus1jxBTJMlOgFPRv5OBIkp8+Bs5gpc6OwuiGB6zLfLO84y
         sHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790492973; x=1791097773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eofGbpKzYy4pS2F+hufAR6Lu21I/5i0IX2p0adL7Y98=;
        b=OsaVINtEeAtPg7lc+z7qWHnoAh8EYiGvSa9ibhXH+dLui3j3SOUjscjtKbwIQp7fy9
         CzzwLVkqLHjhM2LVyPZCifM2FJS4BrrRrgWftJmpU7PQ/d0WSw0A71wgSmbM9COX9Qu4
         l7ZOi9AHWDJUpEBciNgLVcTQRmJf08ROWpuJ5g6g03tsVC1hGtHgHkr8FQOVD2h8fzye
         TFQ7fXVxbeqxeMcStBEItdqdHI7CQ9Rz34UCLVkrkUw4J+nV9J4to6fwbjM1cTY7WP5r
         1snS2Grur3Lbwrz9YcbssDZYtydnlz5/Pk4w2r7ZCou9TtpBQhZRE4j1xe9YFI808FVW
         uvdw==
X-Gm-Message-State: AFuF++mhDwrJ4WbSqVZKv3IyubPMmESnY3iiP6/x9eb7gZb1WGtFNtLv
	c6pD78f5HrYho7T1/YhZbjP2DQy1Id39FKeQ2Pxkf47UYNW+im0PFYRWQUP3pi4rjWQEK1NvXSq
	Bn8b3qfc=
X-Gm-Gg: AYBFou0OUzPIbk9axDpz2neEEuKidPjFUO7UwAwILRi7FP8YT759sBhH+840QAEaYOI
	NFkAEUxfBhEI8vv5vww6wwH7QP1ael5t3YXjE5OrQ1kJlSwPVkS6ybx3/ZVS5Q6vZvU5hYBAqwt
	4P3DDWP3xrxZk4xWm3G82jziQvip3HxhqAM0s29tb199Eyi54/22ranlMXKgfrHEFL/uAO5cHKw
	c5rkF9Fem6S4AQdjG9vyHpcLyaJ9urn/HATVVVkOYvt+n1zXc+1AF6Djb7IhNIj2utH5s3tbqM/
	XJlKlr/ZhHsfUatMqIPXXColYVQqLZEAIxPdxal+N0eEJq3T4FfH2xSE3DN//pH0u6XQxCXFBDB
	ddbYC/VZomAwdfPgTvcQEjS/dfxWVFKmMWmRJe96NqKRwnxQ9OfWIJWv1/pnDP3zBUSoITLGOYx
	px0uO7eA80Ie0AWSCsLW49+KrAEWmHcTKYai9w3nx8DE3fBuZ3UplmDp5UG/x9vcTTGBV6iLJy1
	PQiswSVsKaprz0pO0+dD++Cv04AJxoR1VIJ8Ok6ov2ftjTMJvG9aw==
X-Received: by 2002:a05:7022:d43:b0:143:26eb:18ea with SMTP id a92af1059eb24-146d00b7b89mr5800492c88.29.1790492971652;
        Sun, 27 Sep 2026 00:09:31 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:cdfd:5309:3fdc:3b4e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm10322371c88.9.2026.09.27.00.09.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 00:09:28 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sj@kernel.org,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v4 0/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Sun, 27 Sep 2026 00:09:23 -0700
Message-ID: <20260927070925.47209-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_000934_518753_81DF5578 
X-CRM114-Status: GOOD (  14.50  )
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

On hosts that partition their CPUs after connect time, the connect
time io_cpu selection can land a queue's socket work on CPUs owned by
a different workload. This series lets a control plane set each
queue's io_cpu directly through sysfs.

The first patch adds a small common queue info that a transport embeds
in its queue structure, backing a transport neutral

  /sys/class/nvme/nvmeX/queues/<qid>/

directory under the controller device. The second patch has nvme-tcp
expose io_cpu and managed attributes there.

Changes since v3 [1]:
- Split into two patches and introduced the common queue info that
  Sagi proposed [2], named nvme_queue_info since the PCI driver
  already uses nvme_queue, as Nilay pointed out.
- Renamed the tcp_queues directory to queues so the ABI does not bake
  in the transport, as suggested by Nilay [3].
- Added the read-only managed attribute, 1 while io_cpu is driver
  managed and 0 once the user assigned it, as suggested by Nilay.
- io_cpu now accepts -1 or the string "unbound" to leave the socket
  work unbound, instead of restoring the connect time selection, as
  suggested by Sagi.
- A user assignment is tracked in the common queue info flags and
  still persists across reconnects, following Sagi's earlier guidance
  that io_cpu should not change on reconnect.
- The queue directories register once per controller lifetime and
  persist across reconnects, and the io_cpu accounting moved from the
  queue lock to a controller level lock since a write can now arrive
  while a queue is torn down.
- The io_cpu accounting now also covers a pin to a queue whose connect
  time pick did not bind a cpu, and the queue teardown clears any
  accounting left by a write racing the teardown.

[1] https://lore.kernel.org/linux-nvme/20260909211432.6741-1-saravanand@crusoe.ai/
[2] https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
[3] https://lore.kernel.org/linux-nvme/8dfee10f-89f3-463b-8d16-587873c3394c@linux.ibm.com/

Saravanan D (2):
  nvme: add per-queue sysfs directories
  nvme-tcp: allow setting per-queue io_cpu through sysfs

 Documentation/ABI/stable/sysfs-nvme |  21 ++++
 drivers/nvme/host/core.c            |   2 +
 drivers/nvme/host/nvme.h            |  23 +++++
 drivers/nvme/host/sysfs.c           |  42 ++++++++
 drivers/nvme/host/tcp.c             | 153 +++++++++++++++++++++++++++-
 5 files changed, 240 insertions(+), 1 deletion(-)


base-commit: 2ee54f01f07c0307deaf90ca8691a4643ae0357b
-- 
2.55.0


