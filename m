Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C432AC4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:35:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C19E23406
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C19E23406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=74yn4EihlGYYqU0bPHVztP45sBbeoV537rc4Iye6aoA=; b=j8ilZvwQ2nqkNIC/SBoRy1k29
	CByJoEuIjxszLoepuV6KLTdVjqt4r3xtiMY81M9Nl+hO4lvZf2jQCyrjZ3nvCmwKSxpq43pJBHzBb
	K4DjnbrHvaTovjEE3AzlvaBhUEIbGulwFdWDCmY5753pPfeghh/NkdyWLVh6CD5cp//yi1lpLmKyh
	cSCqwK9Th3n3cuwx17vDAPx4pdbLPVo8CLJF7iz2YW72PPS5XlAXNdqQXkVyBuRquxXesRH6z4FJ3
	5FYABR0ysNDz+tAoboII2k6Z6Ac6mRo9zwTUIEkcjowOTKkvwzBcSuvG1+r1PTcLgt2aHHhHwgFv4
	HNVlqzpdg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmu0s-000311-DK; Wed, 09 Dec 2020 07:35:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmu0q-00030b-4x
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 07:35:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E1B996736F; Wed,  9 Dec 2020 08:35:45 +0100 (CET)
Date: Wed, 9 Dec 2020 08:35:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor
 isn't found
Message-ID: <20201209073545.GB10205@lst.de>
References: <20201205152901.56665-1-hare@suse.de>
 <20201207153121.GA3679937@dhcp-10-100-145-180.wdc.com>
 <20201207153443.GA6236@lst.de>
 <20201207154650.GB3679937@dhcp-10-100-145-180.wdc.com>
 <20201208140352.GB2919@lst.de>
 <20201208191703.GE27155@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208191703.GE27155@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_023548_343917_7E1B0250 
X-CRM114-Status: GOOD (  21.28  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 09, 2020 at 04:17:03AM +0900, Keith Busch wrote:
> On Tue, Dec 08, 2020 at 03:03:52PM +0100, Christoph Hellwig wrote:
> > On Mon, Dec 07, 2020 at 07:46:50AM -0800, Keith Busch wrote:
> > > > But as I just outlined it just papers over buggy controllers.  I really
> > > > don't think we should just silently do that.
> > > 
> > > Okay, that's fine with me too. I agree with you on what the correct
> > > event sequence should be, but I just thought this looks like a fairly
> > > harmless work-around.
> > 
> > I see three major downsides:
> 
> You only listed two. :)

Yeah.

> 
> >  (1) it papers over our host side bug where we do not process the
> >      different AENs in the order that the controller generated them
> 
> We only have one AEN outstanding at a time, though, so we can't process
> them in a different order than the controller sent them, right?

In a more theoretical than practical race the next AEN could have
completed befoe the workqueue that executes the previous one has run.

> >  (2) the code is black magic as there is no indicator why this condition
> >      would happen
> 
> Would it help if Hannes adds a dev_warn() that this log refresh is
> occuring from a controller's inconsistent reporting?

I really want to settle the discussion first as Fred has an extremely
strange interpretation of the spec.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
