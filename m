Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D9FC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:44:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EDE610A2
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EDE610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V2+m2UTAZRUBPX4SY4Ncph7dJ8xSlvMCLSFe9i8vtOE=; b=ODPjl6TXUyiGqw44snHeqpEF66
	F5o0X9DGl755RW2QjRfIvGr56qPxKEMNfJLBVaR82NoRV+vlefZdhwfBjWs3VrE5D7J8st7DwywfL
	LD4Wqr6lHpYXlJ3Li5SXJFB/5V1CO54l6d1qQLjL6BfstOZm6Sk0ZChPAFxoyg8spywOkIClhu5v+
	EJ9ll5kytP9DX1VAiISUh0dRO46vmKEyZ3v7xLe5N93XNR9IPFNkxR3TeeAJXo0CkaGtSbYQlEhjf
	pfRlyEo9GzqxwzJR6tRfA2EGXlhDOCoA0yjS+op/3Cp155pF7CifdMP+ThkPZSc/18fwaQSEir5j9
	uyRrwL8g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljQEZ-004gBO-9j; Wed, 19 May 2021 17:43:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQEW-004gAv-8K
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 17:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=MgmGKdrjxQjVJrNrwKPh1/cM8j/bhvMuA3axYzV1sN8=; b=LjmH27K0zmO+bd0vBbLhGE2hH5
 0vfeOIZvwYg1OLxD4ysLR6PtjG/tEKO8ysOuY3AmFXcV1wNqwDpgEG3BY7YbSmhhXbUaD8CzYCrtq
 nCs7Upa0U/OWQ6efoPSozFZY9vsHp5sad0UK84BYmzAJ4znA7KzrDgvkVKwbPam2gWDHmp1vfUCa9
 Stwq5XWx4CFAbqnYoUeY7w2C/ov5QpfpywJDrM20dJxEcCXBroX1pJPesmWdoSJSytJ8uBPCiTjBb
 Jmgu2GifFI47S/pePPiYiBf8oyKYL7TlSYN6UhKsIPlwFac12sF1bxkCI1OHw8ofRMbvOu7ewrkJf
 8kBz+v1Q==;
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQET-00FfSu-My
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 17:43:47 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 gb21-20020a17090b0615b029015d1a863a91so3935764pjb.2
 for <linux-nvme@lists.infradead.org>; Wed, 19 May 2021 10:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MgmGKdrjxQjVJrNrwKPh1/cM8j/bhvMuA3axYzV1sN8=;
 b=cK15GMTw0XhfUAfCJryNorqTPF4cFSd8ACJ7i9Tng8tKBFaswXF3NxZ068WgsCbF07
 WS+zPFGXB6EpF6UVU0nmFtzL0cAVKsyPJhnJUq+mS8uWghrAhTf/ANz7rYyAepNrp9oa
 GpPsTUk9Fl5q+7GL8/1CdF55fK6gO+H17tbppGzWnGWfR2dHwjJ4aiwzS+n24Qana4oT
 wIDVRMEgr9LdsDPQ1NSwyhxSBrBe4eM5RE32XAoPh02bNk3g1CJe8yIkMdWg7139KR6l
 55XMum9gIalUcQ+JyjO6gIeEVIsLgurf6kl+V6u02GWx4cjK3UFrUmGW4kQSQIf7v+BA
 Y2tw==
X-Gm-Message-State: AOAM531Xei5jjLv4pVDCWhMD+7w2YvmdvOanVpJKEbfazSux2z8XoDYd
 WRBIBQyemPqZX6eiEfkVvQzNxPbEYv8=
X-Google-Smtp-Source: ABdhPJxbhpgo6eIUUsw0FOgYR8k8Jgzp1zGfwOIchy+c86jhhTwTUjL+fvF3u19uQh4dQxrV24Pamg==
X-Received: by 2002:a17:902:541:b029:f0:3187:409b with SMTP id
 59-20020a1709020541b02900f03187409bmr742582plf.47.1621446223143; 
 Wed, 19 May 2021 10:43:43 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:a498:37ce:5a01:2259])
 by smtp.gmail.com with ESMTPSA id l10sm46639pfc.125.2021.05.19.10.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 10:43:42 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/4] nvme: protect against possible request reference after
 completion
Date: Wed, 19 May 2021 10:43:36 -0700
Message-Id: <20210519174340.1144806-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_104345_774865_99274A4E 
X-CRM114-Status: GOOD (  12.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Nothing in nvme protects against referencing a request after it was completed.
For example, in case a buggy controller sends a completion twice for the same
request, the host can access and modify a request that was already completed.

At best, this will cause a panic, but on the worst case, this can cause a silent
data corruption if the request was already reused and executed by the time
we reference it.

The nvme command_id is an opaque that we simply placed the request tag thus far.
To protect against a access after completion, we introduce a generation counter
to the upper 4-bits of the command_id that will increment every invocation and
be validated upon the reception of a completion. This will limit the maximum
queue depth to be effectively 4095, but we hardly ever use such long queues
(in fabrics the maximum is already 1024).

Changes from v1:
- lift param_set_uint_minmax and reuse it
- simplify initialization in patch 3/4

Sagi Grimberg (4):
  params: lift param_set_uint_minmax to common code
  nvme-pci: limit maximum queue depth to 4095
  nvme-tcp: don't check blk_mq_tag_to_rq when receiving pdu data
  nvme: code command_id with a genctr for use-after-free validation

 drivers/nvme/host/core.c    |  3 ++-
 drivers/nvme/host/nvme.h    | 47 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c     | 17 ++++++--------
 drivers/nvme/host/rdma.c    |  4 ++--
 drivers/nvme/host/tcp.c     | 38 ++++++++++++------------------
 drivers/nvme/target/loop.c  |  4 ++--
 include/linux/moduleparam.h |  3 +++
 kernel/params.c             | 19 +++++++++++++++
 net/sunrpc/xprtsock.c       | 18 --------------
 9 files changed, 96 insertions(+), 57 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
