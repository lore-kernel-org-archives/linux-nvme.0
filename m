Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58092C433C1
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 07:38:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4166196F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 07:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4166196F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KzCVHXch4XpLpL6m6L8oewu/IQ4sfiOLKqTN6DOVVEA=; b=JuUXTHUgQ+LJkbbtkOM+MLcZ6/
	nHMTs3d1dnFbEoQPhW28as6RQcAfcp4dI1pkV+oEyE5nv1z1wboKy8LZWGxlDQUxZwKJkjaDEjC0N
	QFiz2ekTRSdXydur7RRbgd0sc1f2UOSYEB2e3AyTmWRLtAc2txjrHyVpH9T65bOiLkYLNk1pEVong
	qqmZAsYsTBJjyt0SdRJIfbL3auqQ0v3qnhJSIBPHwEJ1IaaSFGBifnW1xy89NePhpPu6G7Ys8efAp
	d4szkzkkPdFZvIs1SplUzXE6ERFdZr0fhUAiLtoBOtNfjy2MniRdqvxJTQ/TNkaOknHh2qFJ22gud
	7tSbxx4w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOF8I-00B5ZX-Gv; Mon, 22 Mar 2021 07:37:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOF8D-00B5ZQ-IN
 for linux-nvme@desiato.infradead.org; Mon, 22 Mar 2021 07:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=iWYlea68c8FzuH+4tg8qDv1Nl0eXO516A6zNqzfMHec=; b=IUo/T/VIuycDnv4C9zh3g+gFlr
 JpV+bUzBRtGfp7q9hGpG5SiqiPHsLm29rmyJoTKXrguZAttgLKY0KJM06GoqkvQNfcyKmWcrZP0CO
 eTLZJbRnmNk5y78ZkpEFK1e0uyU0cIpBd/8e5buzLEG36d7K6GD+qkil/62qJ2FuS8cW/CcJCr5yX
 kJUsaHGZ5NzTD/LjtWMLm9+Jk8iVun58aqQNBX7BVHvQC9vlLzj7yLoybBtvcivoSpRJQqA2KJkr2
 5wi/20P7WqGk0Nh857z2gPpt3DqkBiOKQ9PO262335k3eeZONdANkGdFjhP5JxVOWZwbfpegAhxX6
 +aE+1AAg==;
Received: from [2001:4bb8:180:4ea2:5b87:a441:96f6:10e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lOF7v-0089pY-BI; Mon, 22 Mar 2021 07:37:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: fix nvme-tcp and nvme-rdma controller reset hangs when using multipath
Date: Mon, 22 Mar 2021 08:37:24 +0100
Message-Id: <20210322073726.788347-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Hi all,

this series attempts to fix the nvme queue freeze deadlock Sagi reported.
It needs a little help from the block layer so that we can avoid blocking
on the queue free percpu_ref without forcing the entire NOWAIT flag and
thus also not waiting for tag allocations.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
