Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB27C001B0
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90cNh4Bi52C1dPFcxhnxB2L27ZIRksUdZWLV4c0yzA0=; b=xBWWAnLmvyhBUyY6ykKPLDa+e8
	TjD4xedy800YYJ0yLi3v+uAFVX0eqoOVha+8NSS+kQ+Yl72K6rzQCNOXX0ULh8g9LKUyiZUIdVPMS
	6JYWSIjJPmVpEDAmHzv8IRCUo/rTHAwcf1lvvZ4jj/xpbZkkqTE2BJ9hHcwY4lXBBK4kFs3ZbQeZN
	SsMOq1/NaGSmn4Ue5382uvaiD0RSvQK00TBYF6m4OzzMEdyM1A/4JNw33+XkEqQJaULUaIKdZ1a5E
	jHP/0ZrKOVailS4yDjutYg8qqPRXlGC1/SzsBgKYWYEhmK87Bd+KAZdrGIoJUCZ+HICwckc9sitSo
	8jTA/iUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeWU-00AXA6-1q;
	Wed, 26 Jul 2023 13:25:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeWS-00AX9P-2X
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 13:25:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AA226732A; Wed, 26 Jul 2023 15:25:45 +0200 (CEST)
Date: Wed, 26 Jul 2023 15:25:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Ewan Milne <emilne@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC 0/2] nvme-multipath: additional iopolicies
Message-ID: <20230726132544.GA16873@lst.de>
References: <20230726132305.33739-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726132305.33739-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_062548_972413_74593A97 
X-CRM114-Status: GOOD (  15.93  )
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

On Wed, Jul 26, 2023 at 03:23:03PM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> as Ewan raised the issue that we are suffering from a buffer-bloat
> problem when using the round-robin I/O scheduler here are additiona
> I/O schedulers to improve the situation.
> The schedulers are untested, and are compile-tested only.
> I just putting them out here as I had several requests for them;
> I'm happily improving them upon feedback.

FYI, the policy for nvme-multpath has mostly been that we want to
see very solid used cases.  So in addition to actually testing
the code, I'd like to see detailed and solid use cases.  And preferably
just one new policy and not three if possible..


