Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2448CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:08:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F05C61163
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F05C61163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TwlROdb4t5cLnA/aACD1ee20Rj3di9CgrQPxls8XDoM=; b=mC9NFMcyVM1grS
	j5NXmHVQ2lPLfP+FgaRJWMz2IysC6goucUsAOSPS+w0/r/LPXbqC31CwYwhOp6xsf3P99iiS8ny/2
	ZNjUu3AaU/fCcKioQbUO3rkNYF8CRgNhM6mapulBG8ofCUBBNO+5/as7FuEayOEYMYW7D6PyuRlGj
	4HbeWyb+w2Y5BNMjNSL+3q5npnYzdorYK85ZEHR0Nvtm/m06UXhxrMre7U66tKMuiE8HH0shHxfHV
	AgNtUlzs8Wqx91/GOx8AIUWMKzCv6mEvraomukCIGid7UGzkEzRA4nrB+BvnKkjX1bQ1McoSZ8bdD
	U+k3qvgGcHTasvycHj2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2Y0-004NyH-8d; Tue, 14 Sep 2021 07:08:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2Xz-004Nxh-6B
 for linux-nvme@bombadil.infradead.org; Tue, 14 Sep 2021 07:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=dfl1sK45D1Zp1CN7VKwgHtnSAsfPpe+2vVKDvLnEe0I=; b=H5uutOkD1jWUZJMgn4amsEw11C
 k9rBxJIBvGNbQJCkx7AVJGvPgynHibJaUg1qea8H/A9YrwCFsQ9q8yz4JX40lmNDqNQTXFUUh4Got
 ITVTWQWZOGus/7ETddAjiGYzvE4EI3fd4IHDjTZ2pA9a9yzHLlR1fMp2L4hjXl7d48sQBnwF8UCoh
 eD6ooTiNcN0iFg/nfL4eWZRMovzeXx+47St185N+SKV+/zKhyVVPxF+n16akmnXG2mqHQU8GIx5Fi
 z7grx9cIY9VzEi8YjndBWpCn7AVoK2Na77XzW6q5IDZGfDE0iYNVzziAa+YIvt+w1PCTNX4gZFnS/
 3ciQEvGg==;
Received: from [2001:4bb8:184:72db:7baf:b601:6734:7149] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2Wy-00EMmu-Gp; Tue, 14 Sep 2021 07:07:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com
Cc: Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: fix an integrity profile unregistration race
Date: Tue, 14 Sep 2021 09:06:54 +0200
Message-Id: <20210914070657.87677-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this series fixes a race when the integrity profile is unregistered on a
live gendisk.  This is a slight twist on a patch sent by Lihong, which
I've taken over as she is out on vacation for the next two weeks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
