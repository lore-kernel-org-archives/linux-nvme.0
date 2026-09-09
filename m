Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AFAC79FBD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P1kymuGqdAzFhcYg4rZW0qBDuOZo6IIQ9a977MAFPAo=; b=pyF6uqxnlN1GHbwdnSsbBCRrof
	eqvRoh+EjEVqjfi7odUlFZlvgRiS33Ozjcw7Ew70vWwpvo5RZ1JbeweGzLrjsEWhMFVWMZRcDZfKj
	2fcM3ZYzTwblbkNCPyb5ORW5QiJ2HB36fp93XNZDiOOXCLMWYsmQTtuBjoTYRkXWQRDFUZ4dn7aAd
	1J7bGBLOFvkGTTP+rWoiws31fupdvOdszt1TifNMDE5mVZ7xMU7oclu7egvJqBfB6YqmW/esL5Ote
	36/W8D4O3IlIDrfcjAnz96ZDZe7jf9pIDwzhZokh0bPydryx3XYnWag+wWQkhbhevwiokG/j7KOSy
	/Rh7GT7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Ki0-0000000CFpo-1oOf;
	Wed, 09 Sep 2026 15:59:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Khz-0000000CFow-0Wm3
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 15:59:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=P1kymuGqdAzFhcYg4rZW0qBDuOZo6IIQ9a977MAFPAo=; b=I1NKm2D+Awn8DIvOiuQoPaGeyt
	KbSZVZHKDyWiyNf29hTyHdFwqCW8rpYFuvAeHCGjCF5d1crovYXeKQaTAAttSyv7cIDn+t4fv+fZA
	m/hy78diL4d7h1s63ylUs4AHscvMDByymxaou8IU6sY0nmLkZXmUJ4IhdtC0lDtsEul3SS+eE6bQc
	lqWTkEDIFmkIdAQqldTOv7vM5NgX+LXQhvGDqw9UrHPfSn8jaftKVI9HID9OK2r2WS9zE2P9fqIvo
	CyRp+UftxxLBJpOwtlPQ1V0+GyRlXkNIrs5aS2uPxis8I36moGx6oMvcebHHuWeGOC1Q/HtqDjd4m
	vNys0VRg==;
Received: from mail-oi1-x261.google.com ([2607:f8b0:4864:20::261])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Khu-00000001PAo-1gAs
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 15:59:33 +0000
Received: by mail-oi1-x261.google.com with SMTP id 5614622812f47-4b25ea8ef6eso35180b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788969567; x=1789574367; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1kymuGqdAzFhcYg4rZW0qBDuOZo6IIQ9a977MAFPAo=;
        b=RNPtGTukhT1/CA+zvhO+6nwHJX/d7s4vpjcdQhSACAy1jE7AWbZ2rXGRIm0RIJFhk9
         QJcY0BsVXXBohrYIWbPKdH/0EORUTwl8/8SxZamPbTglomhD4sLBLYIYUPrafUHW3+Pn
         pIOiZFzmvROnWU6FYeyMkLG2j5mzoqLZmVq2LfXh5GgLopdcFK+ubTl3dfN28HHNvFjC
         o8vZedefntG1Vpz8DpHaF97/0oLWCS00uvxjnTWFyDIArY/mh3dd2k8759MamCous2DC
         UUaezH/YDK8FtHz/kxHoItBZ648PscEx8rOGJxtRj9F7NHryhxXDUj/eZFfQX7pamHhs
         ydGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969567; x=1789574367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1kymuGqdAzFhcYg4rZW0qBDuOZo6IIQ9a977MAFPAo=;
        b=ROf/q0HNps/uqNhcYlXaVmyC1sN6dDiwBnBDlEtVBKuCPTXEExeXEtUdzC87sbGojB
         hudELDYPfyxxzzlDkzjOVtJyRTfZYdRql0EWw1eAbp4u5kBLqlHo7BWCfduCI46bIWIU
         jVGvokheoopKV9gW3j/B6tjPcnN4gvOZJnD3aHDDFv/r5hl7UCSJulzwbC9ihvW2Jk3j
         kAnbXl9XxJRGpM3acztmnbB+LoNlcdZDzu3XCdu3zMqDGzxHgqmFABs+eUBYTQt3JJtS
         Nzfhj93WBJpkNJ6/bUoT8o2NuIuKtIZK0DazfgQ/2+ywAV4eprFHLlPuU6OWQ31EMw/j
         jNVw==
X-Forwarded-Encrypted: i=1; AKwUvBz+9Ay5gjd7RLywMxP8TLNunBYxZWJcPHzWFO7sEJrVHN+V8MnU0ZutcUqubG9oPF6E8cBppUjND7LO@lists.infradead.org
X-Gm-Message-State: AFuF++mCv4Dvaz92r1eEDACuCpvGN3bKkYp9kyoyDLvDRSlcECvnYzDV
	z9vfa2BPFeqBCC9sUQnlXckCAKHUmyn74k8gC05NNjEDzenI7Ks8/9zEanfuDhbPjN/VIaDi4pg
	3R4H+hiarcdxCPC4HQEETDj3mF6zBQbltvO17Gb0ZKj1doUb/jpuv
X-Gm-Gg: AYBFou0NShcNDv0j0DqrQUOTaVOAwRPYMc8eXFf1O68ih5nrVNoxfExE9hqqF1u+h8q
	Im43rejEOnbmooB2azoLJ/bkZxMxwvqSuCxoPZNGetUbN0hbxQrQuVbHU6lBThvkLp7NYo+Ki0g
	gVzu18QDbyHp/kLq6iZmrxtYJjnQTu+k1mBPGkA5g8m2FqPTVQergnsKi+iWZpIjlTo3eJJFFlG
	HUkLtFOafoyBqF0hgdL39HzKxWaKzGIa/LyMcv2be4OkOrqARrnxQZuP3sUX7Hs4ORXjPLApGpm
	mQZ0p7vixnIP7D4nY+R1H9ELyRKeH54FUbHRgKZwRJtbysZoP2Pzkz8R0KDmQ6XWc4sX/CKFbSK
	4XCaXTQwQXRfQGWpx
X-Received: by 2002:a05:6830:d0b:b0:7e6:6f9f:7445 with SMTP id 46e09a7af769-80273409dafmr51350a34.3.1788969567419;
        Wed, 09 Sep 2026 08:59:27 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7faf7de412asm2209894a34.7.2026.09.09.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:59:27 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E67B7401FD;
	Wed,  9 Sep 2026 09:59:26 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DC4EAE4026F; Wed,  9 Sep 2026 09:59:26 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Ming Lei <tom.leiming@gmail.com>,
	io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/3] io_uring passthru: set result on blk-mq request completion
Date: Wed,  9 Sep 2026 09:58:45 -0600
Message-ID: <20260909155848.2069290-1-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_165930_599865_59D522CC 
X-CRM114-Status: GOOD (  10.93  )
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

io_uring NVMe passthru currently receives the NVMe status and result in
the blk-mq request completion callback nvme_uring_cmd_end_io() but
doesn't post the io_uring CQE until the io_uring task work callback
nvme_uring_task_cb(). The status and result must be plumbed through
struct nvme_uring_cmd_pdu, taking up 16 bytes of the 32 available.

Store the status and result on the io_uring request in
nvme_uring_cmd_end_io() instead of nvme_uring_task_cb() so it doesn't
need to be passed through struct nvme_uring_cmd_pdu.

v3:
- Inline io_uring_cmd_set_res*() (Ming, Jens)
- Document that io_uring_cmd_set_res*() must be called before
  __io_uring_cmd_done() (Joanne)
- Add Reviewed-by tag (Joanne)

v2: https://lore.kernel.org/io-uring/20260902225708.2379840-1-csander@purestorage.com/
- Keep io_uring_cmd_done{,32}() wrappers to reduce changes in uring_cmd
  implementations (Joanne)

v1: https://lore.kernel.org/io-uring/20260827185722.3234622-1-csander@purestorage.com/

Caleb Sander Mateos (3):
  io_uring: move req_set_*() to public header
  io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
  nvme/ioctl: call io_uring_cmd_set_res32() in ->end_io()

 drivers/nvme/host/ioctl.c    | 19 +++++++++----------
 include/linux/io_uring.h     | 32 ++++++++++++++++++++++++++++++++
 include/linux/io_uring/cmd.h | 34 ++++++++++++++++++++++++++++------
 io_uring/io_uring.h          | 31 -------------------------------
 io_uring/uring_cmd.c         | 19 +------------------
 5 files changed, 70 insertions(+), 65 deletions(-)

-- 
2.55.0


