Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3543CCFA13
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Nov 2025 02:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=; b=0WGo8IHPRTklHogKFs+rKiQt8m
	YBzHRhuoP3UgCrQYWjft6d/fk8/hXJHx6sq1zi0FC3a6l5AV0ApNphbJKcLSt4VDlAPyo5ZmpQr4X
	IwrcZonOLjM6xOeC5bAK/RVoyonBv3DeukHcoJQXg3FOBCw0HlPvvFGScTihi9QKjYMyGCK4zC/nJ
	fLE9Gbn3k6i6tdh2HYDq2Ljk40D07jwI54hoyB8aoCxVria/YTCtA77dloc1v38a5iC9cZl7fGaaj
	3xEUYl8tVvvqz27u4TVBfiRPNN4S3ab8Ao548Sl1Fcd8pZLozxZozDud80+GceRi/4XDV1o2CqJPa
	A71lkHIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHBsW-0000000GYRt-3gre;
	Fri, 07 Nov 2025 02:07:04 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHBsU-0000000GYRV-0eCN
	for linux-nvme@lists.infradead.org;
	Fri, 07 Nov 2025 02:07:03 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-ba4874edb5dso179688a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 18:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762481219; x=1763086019; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=;
        b=hXy9/UT3QS7J4SLrwi89aMTAmsyDLbtEp/bB+i7YNZr9kd5ZOojXLIb8GFBQBhaE+K
         jshhHOG5OOfRoDSFOzOfDiH7awc6cGAvytPQNtbKjJcErsHl8riBYTNpu3HgyV5oe5Aw
         hK3klo/WYfgGT3NUT3yAEUkzKhF/8kqyrIBTnhWYUd967G1tZrHSBINfFyuA3f3Te9b+
         kh7AfIH7OejEx4au7ffLYubYuDC4yVDm3IRBgTxcSPqnhTCkWhDEpRU9OpnLdG+7AuGq
         meAM1iF61cScwtt3ngDEjcVVmKsonYkIMsfG5SZoCouo7D8K1FTVzAuOlIufFrWoHzMg
         FNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762481219; x=1763086019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=;
        b=irFr6tnH9hISgOEmcAH/YxPbbgxXsTqU7Ih4Sczx3FJ9N7YOQSfNqq2y8hh4yKrsZB
         nN8/rZbHnWGQDNWwjYLr9lfJ89LcJ+Dl8sNddRPq7Wvinu1VtjODO+mHT7lzkq/qtmvt
         sW5zf/hIbJTZNyXJlxpM9dCtVZZcjMCor3xfCuSOJ5rXF3ETZlwqAeNiB4aqdva1g9Ai
         NA2m4Bws17NO4cGClB8myx+w4WiPUdWQk+ri6dzHrIliBoexby9RPQEuQUxC4RywnMN5
         a8G4OQ1WIHiUc8Z5Ri7HiAKEDgn+wibmxfHuV+uMyTIO5Fq9gwtwlWF8wO62WsS15oKI
         j/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVMgGAxOG7Rno/J/UyjtATZHrYaXRest0fiYTsJyhGQ8KprROfCtUyqb1usrz80g9wVZtf1BjEnCRIT@lists.infradead.org
X-Gm-Message-State: AOJu0YzXCZotUuMwC8hS1G9Yq4X4ackQpcgQwGJknN2lNR8XkDTtmuI7
	MZ7OzlqmdAEqcC3JDDGpt2irxU/f6i3+94HPXaYP+dpAlBbWEmu4kszk4YXh8esTF+g=
X-Gm-Gg: ASbGncv3zpaAdpG8FghhFnbVj2vKt7sfUeaIiD7qUfdHJ5HHQ27ZjYkRcHzrsSyOPYw
	W2IDAras7fS8zeg8ITZBv35aw9OBjapi9E+39tbFCMB46L8q/Z1zuCu2G1BE0o+EUSIEdRnwoA6
	6mpzKpR9or2YzM4h6jhVP8hPWTgdVLf6u4S+53ii+48znUrdhDEK0YAV7n26ZO4BnBaeskjtV2m
	ZjqVKyWFS6zz/pQ1IYOSB9x3E2USSGkAH7hYQg5U6dVOTq0gwIMpNUO4a4+P4a77CROEcL3zTcv
	Q8sNTS9NctTmupo9EdtsTDXSwoUwUeeaHfmdtlxAfvkME43QsP2VNNiVpxveNVldpY05axnOndH
	DW0Ia+atcQ0qusVDzye/y6Hr25bvoxmpW0HIRacfzalqmqysxXNqQ1r9ibGRvN87/DKM/C1nREU
	+xB0x9QxVq/eZcECbh
X-Google-Smtp-Source: AGHT+IEQ1r7AsblEW15F6NrWnCgQgZkngBPtkNTOIEI5NyInjWIPCo6YMVNtFNrYGdMqGrYdOjvVJw==
X-Received: by 2002:a17:903:1ca:b0:296:1beb:6776 with SMTP id d9443c01a7336-297c04aa6abmr21929025ad.58.1762481218563;
        Thu, 06 Nov 2025 18:06:58 -0800 (PST)
Received: from localhost.localdomain ([2408:8740:c4ff:1::4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm43129885ad.3.2025.11.06.18.06.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Nov 2025 18:06:58 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2 0/2] block: enable per-cpu bio cache by default
Date: Fri,  7 Nov 2025 10:05:55 +0800
Message-Id: <20251107020557.10097-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_180702_201048_AAA47114 
X-CRM114-Status: UNSURE (   7.92  )
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

For now, per-cpu bio cache was only used in the io_uring + raw block
device, filesystem also can use this to improve performance.
After discussion in [1], we think it's better to enable per-cpu bio cache
by default.

v2:
enable per-cpu bio cache for passthru IO by default.

v1:
https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O3hjexFNb_tM+kEZA@mail.gmail.com/

[1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com/



Fengnan Chang (2):
  block: use bio_alloc_bioset for passthru IO by default
  block: enable per-cpu bio cache by default

 block/bio.c               | 26 ++++++------
 block/blk-map.c           | 89 +++++++++++++++------------------------
 block/fops.c              |  4 --
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/fs.h        |  3 --
 io_uring/rw.c             |  1 -
 6 files changed, 48 insertions(+), 77 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.39.5 (Apple Git-154)


