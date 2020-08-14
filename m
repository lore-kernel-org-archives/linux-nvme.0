Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345EEC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 08:20:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009C0206B2
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 08:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELTX2ROi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e779GlPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009C0206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SWvI99KThACtRHoAc6CzX71GhgDZz78sqK1ltL/HZW0=; b=ELTX2ROiJBo7j9O6fcGDxNNM1
	LntfRTHqg8g1lKu8cfuiCPS2BgVM5uHfEINhonL9coagAYDWaBBWckDd3sOLhYdhO0r9FJUdb4Spm
	jWFJafkOHv4KKDkAXNKx4F3qZBn7SLJZgcuM9EpATXO+mTAQQ+edBpASXPwqvh0CDVgzc8Z5DiJzT
	fb2XTRr8fUurwyYxfrRkCv7VAP4rc1CcC8v5uxQTM7HkcaleyU3hvWo9rRDYKuo0zx33yKvqEFhTd
	6C9XgVweijv4/lu69oH7XnmAOLH+/G1hYP1m6iW70rQ/1VkxTZSlwGECI2v2xupnL32ThSwFs5l0/
	hE52ZU6OQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Uwm-0006kd-8F; Fri, 14 Aug 2020 08:20:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Uwj-0006kB-M3
 for linux-nvme@merlin.infradead.org; Fri, 14 Aug 2020 08:20:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IheH4M90UCMp03WHkMzMiVJsWhI4288wsYhJMVOMSq0=; b=e779GlPpOLTVjGUSFEOiKIjOVD
 kZrK6Hg4CzDv7GgRKpDnSt6xpIcg3hEZwWbsFObBf+IdnwqbVK5jOn7Z0Ysd6S5Kq/Oj/mXwXVe8N
 4jkbxau8MlIHTTKNE0utwh6jELnUYq1E8TGp9aRBitBdJAHqJWhumkXfEPnBs94uPhhEAkp7QFMmo
 JmOYOlB40ILD/chuBNQ6GdVABvfqAzm2iSjDPlgrs3fr97pHHiEU9RGi4ozf6gqm6ZXTEwLyVRqra
 rZXLM2UNiFpRInX/fJtnweTuEU5zY2adp6gPYxdb+D1QLQVOn0stePfiqGxdU57PFY9FLy+hN/JUo
 GEC1HXNw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6Uwh-00052x-T9; Fri, 14 Aug 2020 08:20:15 +0000
Date: Fri, 14 Aug 2020 09:20:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200814082015.GB18371@infradead.org>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6>
 <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 11, 2020 at 01:48:20PM -0700, Sagi Grimberg wrote:
> 
> > > We saw that in case of path error, nvme reservation cmds does not get error handling.
> > > This is true via the blk layer as well as nvme-cli.
> > > 
> > > We are working on implementing nvmeof stack and
> > > this current behavior is blocking our host from running nvme reservation cmds during path error.
> > 
> > What's blocking you from retrying this command in your host software?
> > 
> > If we truly want to provide a way to hide intermittent errors on
> > passthrough commands via automatic retry, it may be a little longer
> > before such an interface hits a released kernel.
> 
> I think we need to keep the passthru commands as they are, but
> reservations coming from the pr_ops maybe we can failover these
> in nvme_pr_command?

Yes, if issued from the multipath device we should try another path.

> 
> What is the semantics in scsi btw? Didn't see any failover functionality
> for pr_ops...

SCSI has no native failover support, but dm-multipath should support
this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
