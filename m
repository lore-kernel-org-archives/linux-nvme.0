Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73479C61DC7
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OaUA8Dc1meh97pV77Cye8TgVNNLWmdMWYl7BHMypKCE=; b=SOz1wJ7Wtu5do3pDPbAI+PlNK1
	d+mS9yG/JfrDwHK+XEYCOBskwER7IvXddkXP62/5G0e8E8YsEgU26emx+MR5JzuKSZ2WJfQr/taoT
	Ehly0XTwtkMKwIs5I7n544Fz1GwaXolLQLLFvfaGXhTL+El2ONRgBnseenASjDvyvIqNTGGspIXF9
	ZLtG+BZcpPrMGvUIZorFjwLqm3YdrIofCvbj9hZDF+bFojrIMZZE/+mpkJvq7LX+JZUKkFH4JWMbV
	1HSuEPUUAYeI27BCk/0z/WpFmiPSEQgvecdngJ6LeLhXYRpjptug7X7sjgYngqOPOTtzp5ZBK7KZ1
	aHD1NZ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzX8r-00000003oJp-3qMI;
	Thu, 27 Aug 2026 10:15:29 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzX8p-00000003oJ8-2HrY
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 10:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787825725; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=OaUA8Dc1meh97pV77Cye8TgVNNLWmdMWYl7BHMypKCE=;
	b=qnnAcLu9qItAXmeI1rHIGhhAf88H9ldDi1SoC3xPwVS/li95svNww7Gt0WbFwnJ4sKTBWnoay6tGEKYw8PVDTUwj+/ryMQ+1qaiD7txty3/NLQ+ROXg/7j2W+XLB9t4yqfKa/i34SgQhOhVtAC7iPFl3iypXPPqqcJZ9A+81iO0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X9jIKIq_1787825724;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9jIKIq_1787825724 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 18:15:25 +0800
From: Yifei Chu <Chuyf26@linux.alibaba.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: verify the hostid when looking up a controller
Date: Thu, 27 Aug 2026 18:13:44 +0800
Message-ID: <178782562474.1583664.13272859585248116560@linux.alibaba.com>
In-Reply-To: <f6ac3bea-c224-423c-a85f-3501da5ce21a@grimberg.me>
References: <178707054946.2644927.16076495238405774277@linux.alibaba.com>
 <20260819055146.GB326@lst.de>
 <f6ac3bea-c224-423c-a85f-3501da5ce21a@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_031527_739693_1665419B 
X-CRM114-Status: UNSURE (   9.92  )
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

On 2026-08-22 22:56 UTC, Sagi Grimberg wrote:
> The hostid is not a secret either.
>
> I don't have a problem with the change, but I don't think that this
> should be positioned as a security fix, its more a correctness fix.

You are right. The hostid travels in the connect data and is just as
forgeable as the hostnqn, so this cannot stop a determined host from
claiming another host's identity; it only keeps the lookup consistent
with the identity a controller was created with.

I have posted a v2 that rewords the changelog as a correctness fix and
drops the security framing.

Yifei Chu

