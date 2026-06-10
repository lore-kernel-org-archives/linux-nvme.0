Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105EDCD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ztcf9fR8UqkW24Nn8EhRZQilFGz74oO4bPpIrdxN63Y=; b=FgCFHWgIdW1uJrK6RPbG0ToEOS
	MDiRiqf7vTVGQeUdYZRr36RjilnkjPtk5T9czJcqObFGj8n06iSpm2O4HCd2D739u3JO+ifFmnuK/
	1QgO26R929GyAEQKlxooIHCqURJx8zGttLjosSxSnM1kikwiAD9Is57i/sHgiK8JI+HQYGfPLkimc
	uyLVeoS7zuzZAAumFh+yiuAi+1mYYZf9daFZLWBMmabEk/jhtm+f5nHTtayNXxAhffwykYEWWF+De
	7G7yCh6sFNqo5ORyoqU572ajHXijT1d/q0D5joADVUEJ3A1QDCLKIjKOCEiDxBh7oEgTSGZqjcSar
	83AjXZuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJy2-00000007tmr-3FeM;
	Wed, 10 Jun 2026 14:31:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJy1-00000007tmh-3njF
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:31:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A9D1740430;
	Wed, 10 Jun 2026 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468BD1F00893;
	Wed, 10 Jun 2026 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101901;
	bh=Ztcf9fR8UqkW24Nn8EhRZQilFGz74oO4bPpIrdxN63Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I3eCPhJ5fsgrmPR6LBYElojowwx0/yONeS8VjLJlWYe+MJavEvb17zx9I92kdkpUM
	 IisrzMNuRAIROmSwFOXWHRowb9OM5p1w2Zp1zIeXHuB/SLaKm1igJoFUnYazVStcjS
	 UrhbPAn/maZNvtx8umKa593iMChLJv1vqciPkwJSUk5GTwKT1mCPtLxWhAWEQal3MY
	 z2E/t4woeiHjBLp/B73ZJim3YUv/LGDEaQaBbl6AmH/JQvQXhcuH9XM82DLFjemWuI
	 K7w2Cs64fJ9EJstxE4mLIkbpSMqEd7c+J8I9Ek0FIRE2rsiJC2E3aQhJxBv2yiOnXj
	 A02Y1jjB9CKKg==
Date: Wed, 10 Jun 2026 08:31:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com
Subject: Re: [PATCH] nvme: make some sysfs diagnostic structures static
Message-ID: <ail1S6BlIlJ2jxsn@kbusch-mbp>
References: <20260610085332.3213760-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610085332.3213760-1-john.g.garry@oracle.com>
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

On Wed, Jun 10, 2026 at 08:53:32AM +0000, John Garry wrote:
> Building with C=1 generates the following warnings:
> drivers/nvme/host/sysfs.c:397:25: warning: symbol 'dev_attr_io_errors' was not declared. Should it be static?
> drivers/nvme/host/sysfs.c:444:30: warning: symbol 'nvme_ns_diag_attr_group' was not declared. Should it be static?
> drivers/nvme/host/sysfs.c:1150:25: warning: symbol 'dev_attr_adm_errors' was not declared. Should it be static?
> 
> Make those structures static.

Thanks, applied to nvme-7.2.

