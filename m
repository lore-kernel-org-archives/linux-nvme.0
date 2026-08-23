Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B70C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mgmLDD8I+m91E/TDwBlvrYsst4TEQoPOkr2lpfwXOek=; b=XLEQTWoPMQertf
	tGtU2Af8bKbQ9u9wAjr5osaeEjkUyexVheg3BephUDt5p/5GIKKit8/td2ksO6c43xC2Zahsylr6Y
	WL8HdiT4tpMKxwWYMHvEeLsA3sThS/CHY77jXckn6JhWsgrlfgo7yjfTkYwuQMAtoWMlGKP3EGOlQ
	iaSI0UOkgeehJODHjIleTwu4fMa9RQT6NORqgd3nwoe23895Z1ITulyRu0q1iM4i6ffKQYTB6b48L
	a0gobpkZa7EcWSgwMoSWsCVOD6dTuwfIi5M6kiyWF3n5jqM18EHJ/dRpJoX3ieNnG4lUzObE4ivrg
	I7rDr8ovJMFrlZVe4Wgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3t9-0000000FBTt-0Jbi;
	Sun, 23 Aug 2026 08:49:11 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3t6-0000000FBTF-3SX1
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:49:09 +0000
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so4867190a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474946; x=1788079746;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mgmLDD8I+m91E/TDwBlvrYsst4TEQoPOkr2lpfwXOek=;
        b=fs4+mzpet6M40DCnI+3pij3q052GdkRG9MlnB84HwWDSMLowxhvQDKiI0giq/SPgs8
         srll8IH8Fi3D5IuTMH4NnrgWVTLv5tpmC7YTpWgpvobZ6ELpRqyO4Z39Om09Q4ql3Lah
         aQTShJ4KBw3/82ptiguPNJe03wkIwtp3fh1SEvOqPaCRCrGNIri3NSWg2eXFzoyBJvtO
         7TKYgiO/CyBan8TQHCk7dc4JXYTEcKXx2rDPZq6PnegTNbOnS0Wpec8ryMTGDliWOKaU
         t++1ahqssUDOvLahhXkPgHZyjeepdcbJPJ/M4G/dvs1D4QwdbYLcibXLnxNTaLthU9tw
         Disg==
X-Gm-Message-State: AFuF++nhS5t5nzfvWOQuO91YGomEJACCVggZU2o+/QeQ3RxX1jGXH9A8
	L2ahBr9IbZt8dtVOBGrqvNkOdCcsEFOayAxKPdOoq4oYHoGYTOpU6WUHOhwuBA==
X-Gm-Gg: AR+sD106DzWDiCF5IIKqi3bkx+Qq3z+BJPZL24tXahQv/ifkKT54nYEzJC9QovJD1eY
	ptU+BXCvyFLICZrydkx+Zc1CKkYbMPyRYIhhOoaHi5yK5gjVeqIgYAuchHBs5v5bcblvFQU0o36
	my0IctDW3JO85zw8C34HgWMPy9c1cqT9qyG99ZTPG5wUc2HfzO6JcLUUCkXhj0Ee1vdfVYnGiYv
	5ZTqdiajfnBKoubeP6CulUpcPCkwwF0TMgaH9E6KDnEZRuGmqcQXSPmSvbtdITatKqQKRI4IQ7Q
	BR6OOLyaaRiJ0ZK8B4/Upe//+UA+I8Dak4BZVrj0llNJ5ht1dgAkmNr57dk4GC8hl8W1Ll29exL
	Co9w8LjWIJTdILQgU7bFXUnU9BgORh0NyazHB8nMtkSSWV8bgIxivFGiMtmWA7oD8xGZ1EuJpv1
	5jUg+b0ugv1YpoXU8f1pWOK7M6jBl4i4oM1ITk/wO7v0gU1I+JshtzsRmSXLO9cingUUFfKax+r
	1ZB0f40ufmpKTgWAcv5yueQooTsUW3RAG6FPgFkh4Zm6DyP77M=
X-Received: by 2002:a05:6402:20da:b0:6a3:ff14:ebc9 with SMTP id 4fb4d7f45d1cf-6a42f1bcdd1mr18265227a12.11.1787474946052;
        Sun, 23 Aug 2026 01:49:06 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm2566761a12.1.2026.08.23.01.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:49:05 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/6] Support per command retry timer
Date: Sun, 23 Aug 2026 11:48:56 +0300
Message-ID: <20260823084903.193188-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_014908_871154_DDE6FF26 
X-CRM114-Status: GOOD (  12.93  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We have a single retry timer per request queue. This means that different
commands will absorb the latest crd levels returned by the controller for
any command. This is both inacturate and may theoretically create a
starvation when the controller will return different crd for different
commands in specific patterns.

Fix this by adding a per-command retry timer, that is only accessed/modified
when a command RETRY disposition is performed.

Addionally, respect controller crd level also when failing over a request.

Lastly, add some infrastructure to be able to set different crd levels with
the error injection framework in order to be able to exercise these paths.
This includes nvmet configurable crdt[1,2,3] subsystem attributes, and host
crd level error injection.

The first patch is a standalone minor optimization that can be taken outside
of the patchset. The second patch adds a generic helper that allows for
multiple call-sites calculating the completion crd level, patches 3+4
implement per-command crd for both RETRY and FAILOVER dispositions. Patchs
5+6 are added primarily for testing.

Patch 7/6 is an RFC blktests addition to exercise the new code additions.

Sagi Grimberg (6):
  nvme-mpath: No need to protect req->bio with requeue_lock
  nvme: add nvme_crd_msecs helper
  nvme: add per request retry timer
  nvme-mpath: support controller crd when failing over request
  nvmet: Add support for configurable crdt (command retry delay)
    attributes
  nvme/fault-injection: Support for error injection with custom crd

 drivers/nvme/host/apple.c        |  1 +
 drivers/nvme/host/core.c         | 32 ++++++++---
 drivers/nvme/host/fault_inject.c |  8 ++-
 drivers/nvme/host/fc.c           |  1 +
 drivers/nvme/host/multipath.c    | 97 ++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h         | 14 +++++
 drivers/nvme/host/pci.c          |  1 +
 drivers/nvme/host/rdma.c         |  1 +
 drivers/nvme/host/tcp.c          |  1 +
 drivers/nvme/target/admin-cmd.c  |  4 ++
 drivers/nvme/target/configfs.c   | 62 ++++++++++++++++++++
 drivers/nvme/target/loop.c       |  1 +
 drivers/nvme/target/nvmet.h      |  1 +
 13 files changed, 209 insertions(+), 15 deletions(-)

-- 
2.43.0


