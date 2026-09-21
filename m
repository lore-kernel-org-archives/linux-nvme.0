Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE48C982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 06:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iodCEYwww0qr9a+atXSNwRfrNopv7OmyXOzDAj38Zsc=; b=N9enHR77otmA7d0SRlCdVChLA/
	uQDJnwUh/OoEC1egIOrOiCmap3duX/+ke6Ce+rPlWXUdvqdfeYbwUVL7UCU3EF7MuSOON5iyhE5xD
	8FM3Y581imgPgQDbUUF73srv7tcJmwSaA9Og5G4pu39kUVj3kMW731idFDEsAKRuchtNFWQORIzlC
	XVYwXDTJqlGP6tufZqPzOhSNEFqWfk9ZeZINOhzyVp2BXC8lNAhv9zPk14kSJ656BxaU5q54Iikm5
	a5hA84b3CSZL+OTasd8p+gJfQSopevmfVgYuZaov9xPmTUjpyPqj219tL9SswpCEwo/XpIUw2b0xp
	h8jWfm0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Xwd-000000018EP-2Xvq;
	Mon, 21 Sep 2026 06:56:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8XwV-000000018Dv-1XAa
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 06:56:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E822968C7B; Mon, 21 Sep 2026 08:55:55 +0200 (CEST)
Date: Mon, 21 Sep 2026 08:55:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: loberman@redhat.com
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: add iopolicies sysfs attribute
Message-ID: <20260921065555.GA13785@lst.de>
References: <20260920164000.45508-1-loberman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920164000.45508-1-loberman@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_235559_570654_EE4DB611 
X-CRM114-Status: GOOD (  15.88  )
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

On Sun, Sep 20, 2026 at 12:40:00PM -0400, loberman@redhat.com wrote:
> From: Laurence Oberman <loberman@redhat.com>
> 
> The subsystem iopolicy attribute only shows the active policy, so
> there is no way to see which policies are available. The block layer
> solves this for I/O schedulers by listing all options with the
> active one in brackets in queue/scheduler.
> 
> Changing the output of iopolicy the same way would break existing
> userspace, since nvme-cli compares the value against a bare policy
> name. Leave iopolicy unchanged and add a read-only iopolicies
> attribute that gives equivalent visibility:

Given that we already have a file for the current iopolicy, can we
kill the [ ] notation that makes it hard to machine parse the value?


