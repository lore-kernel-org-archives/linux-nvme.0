Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247BAC3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 05:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hE0MXGZMpk2MjjB9KslygeILx33BVOj3O1wz/Y/lL+k=; b=UW6RqOAE4A+dtvohZ6IVKPdjr6
	3RI32ECWEDg/NJ95TMM6IQzrKf9Yrcd0TcQhih/Z8HKYzw149cBAEQaHNLcry8FmU8DSlz+3t3ya9
	IgMNX5zFkL6FOODwnZTXV7Tq5PvF6W69XPLgCKIaAHk8Ch4HRWV4PVr5Nnw+dlJNNT/5E282Agdx4
	jkjMk5+wrS99OYHRF9ZbVzaG0QqlAWthYKIp3zVVfbVwrONLXwU56xzjvvHJ+x3i7fdqK00Pra5/f
	3/pHXpJ+RDuetYL7dUCVNhFHdO0HFkpY5ftEpSk3c0Jo80FoWTrBYV8mY1nJKXILx/CvuaBCpMCv1
	uUnkhHJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLcOl-00Fwxr-0u;
	Fri, 05 Jan 2024 05:05:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLcOi-00FwxS-2V
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 05:05:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 15A3460F73;
	Fri,  5 Jan 2024 05:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BADC433C7;
	Fri,  5 Jan 2024 05:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704431131;
	bh=bDiPV3uyCW5UPugzq4bCJlkKgkGFl8NKchlqBqf/QT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUdMMVXMCmG1nuAMLxS0yIP7vE4rqe2372HxRHZ6kQSbiAMbrsN4S3wEGiej6i9dq
	 x9srvxJ+dbKU1MKWATpZRRnC9VNxgnfVBcmlFMT/fkA/KXY6jj+FnHVmYcIaURj9bH
	 I1Un5KMB0n8/almphcEIM474YEW6ucE5m4tmBa0tZ4U+kHmVHVH/s+iBMlzib1Sgu7
	 6ZM8mNFtqmQ+12U+rzHWpJbM0XRAm/mAsHdPBGjC5QRxUhhm/9LwQjkLMXRUBJcbs2
	 GDvMR9ZURZtxjq2oPfVJMJOIsbQvGnb6XPQuj+/pZyLK3+b16eFHTKwYr8915KqzN8
	 +CVFMJEpto6+A==
Date: Thu, 4 Jan 2024 22:05:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 06/16] nvme-fc: Do not wait in vain when unloading
 module
Message-ID: <ZZeOGTv0B1i8hkSB@kbusch-mbp>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-7-dwagner@suse.de>
 <20231219043514.GG30580@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219043514.GG30580@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_210532_880059_F8BBAFC9 
X-CRM114-Status: GOOD (  19.41  )
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

On Tue, Dec 19, 2023 at 05:35:14AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 04:30:54PM +0100, Daniel Wagner wrote:
> > The module unload code will wait for a controller to be delete even when
> > there is no controller and we wait for completion forever to happen.
> > Thus only wait for the completion when there is a controller which
> > needs to be removed.
> 
> This whole code looks fishy to me, and I suspect this patch only papers
> over it.  Why do we this wait to start with?  If we've found that out and
> documented it, the code really should be using a wait_event variant that
> checks for the actual condition (no more controllers), because without
> that you might still have a race otherwise.

The synchronization here does feel off, but Daniel's change looks
correct to the current implementation and is a minimal diff to fix it.
Do you want to see this re-worked with a better wait condition or can we
proceed with this?

