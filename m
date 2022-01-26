Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0782C28CF5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=dG0Lyakv5St+s+Mwl5AuNbPzjv
	cdMntml11+lWsp0jzSWXv17bYg/nbQl/ffz+gpXm75it0Fg99A+c1eSa12A0vyHzRGByea4AaHzFN
	r4ychvLJg5gkj4CjV9cIqh5aAusXUV0ZcqDHuJhGKd1q7ietA+3rM0lVKUFZ+Ep0vIo0n2KY27wU+
	OcPfaHIwaN27ejbPStkjNAhFjtQdedJUMrO0/DnOt+f7mrq0SJmASlXkgYxKHD+nW/rCFysTrr9Yr
	TzXW/zwIgw6tWjzy+If0amfetlxO11v9dXvS9C6PQEgStp6q8fyt7cfOT5X68GPWXoWjM41Mkvi3+
	mxsJM9jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nClqr-00Culi-SQ; Wed, 26 Jan 2022 17:12:57 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nCkwO-00CZ37-Hf; Wed, 26 Jan 2022 16:14:36 +0000
Date: Wed, 26 Jan 2022 08:14:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qinghua Jin <qhjin.dev@gmail.com>
Cc: qhjin_dev@163.com, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix typo
Message-ID: <YfFzbKAc/jQosCWa@infradead.org>
References: <20220107022258.396058-1-qhjin.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107022258.396058-1-qhjin.dev@gmail.com>
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

applied to nvme-5.17.

