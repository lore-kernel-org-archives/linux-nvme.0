Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DECC4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Nov 2022 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FrmmzRFz5MnJ4iSipBuAKk4nM6DsSVFXSbzsN6IuUs8=; b=QzFIuafRmeNgH4FFYIGwdmNjSD
	jxvlmjw2gl8O+c+emsnM/dP+kn7tR92taRu0gYjd0zo0QsI7QTf9PmUPwpQcO/XtCYjPtJhfZShGr
	lNwrQ6tnOotEAN2u3Jx++3RMka5NMv/j0CQXV7gDGBhJQU4bbZ02tlPgBelsjleFPYFgz9CyOvTFp
	htcdegsC8thR0TACLAj9C1fCDLDq0gn8SgIfbG0hdwQLQeb3ecgSa6Z7e6wKtsRS/ww5LlXNCmcP9
	JckL1iDaRN/b8zWQz7NOkkHo0IZBlq6+V0Lhy5dtbgo/StV2/FbT5hhfT5wSBeUv9Gnqq+svdpU2r
	dd5HcC3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqcc-002fds-9x; Fri, 04 Nov 2022 06:56:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqcU-002fbH-39
	for linux-nvme@lists.infradead.org; Fri, 04 Nov 2022 06:56:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 815DC68AA6; Fri,  4 Nov 2022 07:55:54 +0100 (CET)
Date: Fri, 4 Nov 2022 07:55:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/6] nvme-auth: allocate authentication buffer only
 during transaction
Message-ID: <20221104065554.GA16790@lst.de>
References: <20221102075224.70869-1-hare@suse.de> <20221102075224.70869-2-hare@suse.de> <be22e517-50da-03a7-7504-1a592e04803c@grimberg.me> <a2f7ab14-4c1f-6f46-eed9-69345c42c61a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f7ab14-4c1f-6f46-eed9-69345c42c61a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_235602_463690_06E74904 
X-CRM114-Status: GOOD (  13.37  )
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

On Fri, Nov 04, 2022 at 07:49:41AM +0100, Hannes Reinecke wrote:
> I didn't want to clutter the main nvme structure with the chap stuff, so I 
> kept it as a private definition in auth.c, and did a private allocation.

I think keeping the struct private is fine.  But adding two pointers
to the nvme controller for it, that is one directly to the
nvme_dhchap_queue_context for the admin queue as we'll need that
before setting the number of queues, and one to an array of the
I/O queues seems like a perfectly reasonable tradeoff.

In fact that is the exact two pointers we need for a list_head :)

