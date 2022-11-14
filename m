Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE16FC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 06:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0zSxY75gbC7kt7AnpmGVNyr7/uxwj+iBZhgFwtPRXi0=; b=dD0FtMidp9DTnZY6LMqZLc1rH/
	1+MLDGEnV9JvNy17JKNqkUZTibpLHI5p1UltXKrmXmgpQmx7+vFF/IiW7dK/xdwGMxm7Mgy3Ht/rt
	4u/7QZGdEFsP3Z61aqAHcr7Swv9yh5QT5TZWTVCvBNRKbYUV96KlzIU+l2XqkP1GrQnEThaqSvQP1
	mO4UQnhbWvUMYNT1q6fVODFWJ8NoJGQWUAuGLkt2BkqqVQu3tnbJ9WwY8Rl0Fdo0weKPUxlOogRe8
	PHhsWhA9wfzSVsqr4xeZC7+xlnP3WKtkYow7D1GirmtGShpTkjHu612kQrz+HlKd0Bv47MMjMcBtZ
	5QlvFFLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouSX6-00GALc-AS; Mon, 14 Nov 2022 06:01:24 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouSX4-00GALQ-At; Mon, 14 Nov 2022 06:01:22 +0000
Date: Sun, 13 Nov 2022 22:01:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tiago Dias Ferreira <tiagodfer@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: netac nv7000 has bogus namespace ids
Message-ID: <Y3HZsp2NG5lYaf01@infradead.org>
References: <CAJuHpLb+TVvxfcdBTMGk__vmevUa-4ZmdqO00shNvwJkuzPovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuHpLb+TVvxfcdBTMGk__vmevUa-4ZmdqO00shNvwJkuzPovw@mail.gmail.com>
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

On Tue, Nov 08, 2022 at 09:55:48PM -0300, Tiago Dias Ferreira wrote:
> Hello,
> I'm sending this commit to fix the issue where just the first nvme is
> detected due to bogus namespace ids poorly implemented by Netac:
> https://github.com/torvalds/linux/commit/3943eaeb9ac167ff6f8d099459ab158eb1fc8bdb

Can you send a patch with the quirk for the PCI ID?  You can get the
required IDs from " lspci -nn".

