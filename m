Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E01C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MIAPKQa6lkAf8qNeeTmBzZK6T6GNiHeqE1SEw2fYU0M=; b=c1vt5ApvqaevryQ6g8kruIkF3l
	Bqriaz2TgDaZraz16dq6R+HYR9cLn///luZm+dftdd1qXWd2wIhawpq816lt698AifeOu1Ew00Dcw
	Ad0UpgbcCj/LmeX5/mqInoqmGY6We+oaoa128rIM9OJVchKyBOjGasNb/pOV/iTa2zdSAvu5xfROW
	1VSOK8xe+ora9nLFmyGYMTIU7WUSL+mC8B55ceotdp1Li4DhCc6gEtjI479Ck7rGrQOwbOnEjAvai
	J86It48EcKBnME548BuWeHCdkW3ef0kCfP288L6jNcQ8/t3p/pPoRVtvBfcIe+AWM/XlYN3tmeThM
	/SHwiOSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk5nz-007cPV-Rd; Thu, 28 Apr 2022 15:11:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nk5ny-007cP7-3M; Thu, 28 Apr 2022 15:11:42 +0000
Date: Thu, 28 Apr 2022 08:11:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Message-ID: <YmqurjF+q0Vvmxwz@infradead.org>
References: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
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

Thanks,

applied to nvme-5.18.

(with a slightly shortened subject line)

