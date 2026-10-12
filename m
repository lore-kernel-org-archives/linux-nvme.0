Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181ADCA9ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LMBzO7OLXXuEGs3hvtSdM4niUS4jG81WbBB8rl+DCkQ=; b=fK9bfuDezFKf1SAQCHGgf1sdNP
	GxhwoD+3TwlinSvH8IhZd3LuHCxsn5vHtxdXf/ZkHM/EKf/o8rUh69hwZkT6Rh4h5ZaY7U4O43Axf
	TcQ/FZCEUR/t/yQdyBsbVb+0F6sO6zIISP3TRaxvz0aqPcfi4lOg9N607kWWVq8XuVi9bQwnlKzPB
	Qhddag//5d5uUktEiaOyTcj1jvJsBHJD2b6UO9ssaIiw5UdGxD8FLuaCer/W6ADrFDAlpcP2cKbi+
	61UYEOJnegYC8fi5hAbvfOz25qz+9hOpsuI+oP7L6eG6BHbtOcy5zI7I14ezRk+wdlxQYNUVWdQ9p
	CpPTvYYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGlu-0000000AeYg-0lmH;
	Mon, 12 Oct 2026 14:12:58 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGls-0000000AeXN-248k
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 14:12:57 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1880695f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814374; x=1792419174; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMBzO7OLXXuEGs3hvtSdM4niUS4jG81WbBB8rl+DCkQ=;
        b=jAJh5tEOx7iufdLyhdN2iRgGysCTEo+G8gxNfGYB4yhWR7I34PyV2nne2VJW/mhQO+
         XzRHt4xSKw5cK9UNnl6yjtbWISt00HWVchBhpVVYnnFKFN8XXZCca544v1w4D0YP8cVT
         +Ro1NAd1QO8+nwcZR0o5yAIQ2aavAEYeQ16uKBi68QP/tHBTUWxhW6gMep76udXl0svD
         qVOZCuXHBmd9MnNmTnFNmn7eHtAXxA9Gidiak+wzMizzcwkfBIDCTZPdFFYTem1MXPkG
         2QM/YX2Y5RLP05PwAK8ExUDxRHKySJl+SklTX+xeSoTpSZTmX6FUoHcYxOsQLuc+BBE6
         lVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814374; x=1792419174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMBzO7OLXXuEGs3hvtSdM4niUS4jG81WbBB8rl+DCkQ=;
        b=QuozN5ldp/unNKSSoc+AWhDS6FQpfVm8SD/Xw06m1pwiToSSbc2lfLBJWttPlGyTpv
         c8oWACXAUICIr0XHhpLmFj7ollYwpNguEGfS1GQF0dJv2sanEEA6Oy8WopJ599JqkDgh
         khYiQL/FWrnjLPhdEycPcwqAWP/uP4jmWDASL1XMgKFjOZmBYTusCQghM0LNtofG8mTJ
         d47tMKg8TUvcu+stJicIwGG/4+gfP3LxytnfV8oEYevdZH+2jrlW8N49LL5tI+Z5ZjUV
         Z7t8WnlUSvhrnaW9dgOqaXhO+hagbk5A0857ZwxuMsZ8fsCfeZQrmQNRoZYXn5kSyLpG
         nuXA==
X-Forwarded-Encrypted: i=1; AKwUvBxzeXp/kH+NOkYKbKt8zG//gpsZ9yLdueUSY33pVCJ3+wD4JjpU0F1ZGsIijDteMWOJXvRXmVH61zRs@lists.infradead.org
X-Gm-Message-State: AFq9FYJ7RYz2k9dWm1xhJLKy3i+GT3ZylgiByS/wKYnEh8fxBAIiAyC7
	Bh0K5htVs+AeKGFwW0NaAz5w1noiNZgFcEKlH+uSFxNjVJzO/xCZEk8Q
X-Gm-Gg: AYBFou1S4LcmrtCZqQKwEubdNwWY8wSTIS3QlLoo6ZsjgiuGEUSmWc2Z9ZEXPbq34gV
	tR1Wbe6C2wST6f9lmKqcYZTiBjH1ffXckT8y+1KvqbWyrgPuGOp3MlHocfBmqMgqD+1l6rpK9Zn
	8/90OorSeMBtmhq4YZDGu2jWVVs8voWG+ZvMbgAxFfHKrxRiGFieqz9/d5m0f36Su48Y5LeXeH9
	tQVrCeLlZHHjAqpIq3sPVymnM4SpHuP7+iwtPgN0sqSI7Vl13aRHmH8NRFNPWxVqozS6BM8gE5i
	jyH9WWwhyoOQqTiffMz0Q4Rg3gNh7yh9BbLtmt6GLLle9p02YoOne/L4uXLErKpWKO25SUkpYl+
	fXIwIlZUYEIz3nwRTwAZivnqtF9kgXvPZsqnDHCtECBzWmCTh4w3GxhNE4+Otw4hL6AcM2u6Kjb
	z1+s74GV3VYlmMRdUcnVq+O+AiWosx8l9b03HdPEazWxZJ4sHniq/4mfPHQPhpQeqRmHH9l9rB6
	HL+FCeq97tyYl1W3WfM6BUShYQaaAKSMPnMDIUb3+6O
X-Received: by 2002:a05:6000:454c:b0:487:c3e:8df8 with SMTP id ffacd0b85a97d-48dba77cf87mr12555139f8f.5.1791814373901;
        Mon, 12 Oct 2026 07:12:53 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:12:53 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	James Smart <jsmart833426@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] nvmet: fix stale data exposure and ZNS validation
Date: Mon, 12 Oct 2026 16:12:27 +0200
Message-ID: <20261012141239.156408-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_071256_550731_FB19C429 
X-CRM114-Status: GOOD (  14.44  )
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

A connected host can currently receive stale target memory through three
nvmet paths.

The FC transport sends a read buffer even when the command completes with
an error.  Some errors occur before the command handler initializes that
buffer, so the host receives data left in the allocation.

Zone Management Receive writes only the Number of Zones field and the
descriptors returned by the backend, while the transports send the entire
requested buffer.  Reserved header bytes and unused descriptor slots can
therefore retain stale data.  The handler also does not verify that the
transport data length agrees with NUMD, allowing a host to increase the
amount returned beyond the size described by the command.

The PCI endpoint transport allocates each read segment at the length of
the host's SGL data descriptor and sends every segment in full, even when
the descriptors describe more than the command transfers.  The excess
reaches the host uninitialized, on any successful read.

Patch 1 makes the FC transport send read data only for successful
commands, matching the TCP and RDMA transports.  Patch 2 validates the
Zone Management Receive transfer length and zeroes the report before
filling it.  Patch 3 rejects NUMD values whose byte count wraps the u32
length calculation instead of accepting the wrapped request.

Patch 4 fixes a related PCI endpoint bug that patch 5 depends on.  The
transport reports every error it detects itself as a successful
completion, because nvmet_pci_epf_complete_iod() reloads the status from
a CQE that only the nvmet core fills in, so even a write whose data
could not be fetched is reported as written.  Patch 5 then makes the
transport reject SGLs whose data descriptors do not add up to the
command's data length.

Patches 1-3 were tested over the loop, tcp, rdma (rdma_rxe) and fc
(fcloop) transports, with a zoned null_blk namespace for the Zone
Management Receive fixes.  On the unpatched kernel, a failed Identify over
fc returns data, zone reports carry stale bytes and accept a transfer
length that disagrees with NUMD, and a wrapping NUMD is accepted.  With
patches 1-3 applied, none of these occur on any of the four transports.
Patches 4 and 5 are build-tested only: no PCI endpoint hardware was
available.

A tested reproducer for patches 1-3 is available privately on request.

Andrea Parri (5):
  nvmet-fc: only send read data for successful commands
  nvmet: zns: don't leak stale memory in zone management receive
  nvmet: zns: reject a NUMD whose byte count wraps
  nvmet: pci-epf: report transport errors in command completions
  nvmet: pci-epf: require SGLs to match the command data length

 drivers/nvme/target/fc.c      |  8 ++++----
 drivers/nvme/target/pci-epf.c | 30 +++++++++++++++++++++++++++---
 drivers/nvme/target/zns.c     | 17 +++++++++++++++--
 3 files changed, 46 insertions(+), 9 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.53.0

