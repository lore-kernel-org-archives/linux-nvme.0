Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23729C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 13:34:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CFB221E2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 13:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CFB221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gFZbxMDb2EkqSzFhIAf8pTVrUxK/vcL0p1lvEq0lpDw=; b=CP6ybwWiDdxhdh4FWlTicf23f
	nS2nRfY/qKzfcrAn1ycyOitUilORFWlKPlUmKWFACxSWASW/QA+gLKjYExx6fKk1sGe2wDVaMpDiT
	A9xzTBRK0+ujm52Ym3yv2kQRSN2PfdzGujcu654+bMKp6CN5zzuEa096wQFyO4XUFonUojVWlGSai
	NaMgOQuRZ+WXeC53tFrPDoy/67QIbSTB3Npe9TI1M3/RdKLZXrTcyyleAHzpXKxGMi9jM56RryrLW
	FTaCvT1t6+JB7Vee8ygapKaqdFBi+H8Ay3ucDDWvCBeWN+rhGdO+d5wZl0bE0dYL2B3W/+K9Fx76G
	kcrRrg15w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knM5V-0001KZ-2G; Thu, 10 Dec 2020 13:34:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knM5S-0001K4-Tx
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 13:34:27 +0000
Date: Thu, 10 Dec 2020 22:34:18 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607607265;
 bh=IWn87ZU011oOqgttaLlLsPczzR7kVfBqfQLFPK2SPq4=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hav0XSJjz4pQZL4eUO9AXPPNr20NwYo7AIsAG4uHh1l1I8lTYXSfwieJDVFvk8Kew
 l8oh2aBQUUWseqzCcMUBCSJbfHnfLXBMKn5gBRJ72ok6Cr0YZIJZAwJ2PjibxeBose
 xswElAi8b+mGRgGoMyQvlCz6TIbTlF7cttWu0FqMp8Mydm7D3GDwHFYos0p6ekGt+F
 0cC+n1IICFe9xPtKO5tPO0ByxHPzkHUmIkWYtFde3JBCro9t6EhSlPcJQhZpUOe8Qt
 jRpo8mcfwhZtqHzQNd7qSnQMdtltTw79m3R4FrpVA583I4GQgIoDNC/qZIE60SafLK
 y0mSFW40WyWNw==
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201210133418.GA3645@redsun51.ssa.fujisawa.hgst.com>
References: <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
 <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
 <20201209174718.GA19512@lst.de>
 <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209213437.GA3682670@dhcp-10-100-145-180.wdc.com>
 <20201210085111.GA15999@lst.de>
 <baa8c2e6-1376-1cad-4c84-1129bd80d4ca@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <baa8c2e6-1376-1cad-4c84-1129bd80d4ca@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_083427_105066_2A81860D 
X-CRM114-Status: GOOD (  25.66  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Knight, Frederick" <Frederick.Knight@netapp.com>,
 "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 10, 2020 at 10:13:02AM +0100, Hannes Reinecke wrote:
> On 12/10/20 9:51 AM, hch@lst.de wrote:
> > On Wed, Dec 09, 2020 at 01:34:37PM -0800, Keith Busch wrote:
> > > Linux hosts currently want an ANA AEN anytime the host needs to refresh
> > > the ANA log. That includes any condition that adds groups that didn't
> > > exist from the host's previous reading.
> > > 
> > > If the Namespace Attach occurs to an ANA group the host already knows
> > > about, then you don't need to send an ANA AEN because there's nothing
> > > new in the log that the host requires. You just need to send the NS
> > > Notify AEN.
> > > 
> > > But if a side effect of attaching a namespace results in a new ANA group
> > > becoming visible to the host, then that group creation is considered a
> > > separate event, so the host wants both AENs. I believe this is where
> > > Christoph is trying to steer the interpretation and the text.
> > 
> > Exactly.  Although as Hannes pointed out, this language:
> > 
> >    If, for an ANA Group, there are no namespaces attached to the
> >    controller processing the command, then no ANA Group Descriptor is
> >    returned for that ANA Group (i.e., an ANA Group Descriptor is returned
> >    only if that ANA Group contains namespaces that are attached to the
> >    controller processing the command.
> > 
> > creates a bit of a chicken an egg problem in that case of a newly
> > attached namespace that is the first one referencing an ANA group.
> > 
> Yes, this was what I tried to outline.
> 
> Personally I don't mind whether the controller is required to send an ANA
> change AEN together with the NS change AEN.
> Requiring both will pose an ordering issue (as on fabrics we can't control
> the completion ordering), so effectively we'll have to implement handling
> for AENs arriving in any order.

I was thinking more about this, and it's actually not a problem based on
how the controller is allowed to send AEN completions:

  When the controller posts a completion queue entry for an outstanding
  Asynchronous Event Request command and thus reports an asynchronous
  event, subsequent events of that event type are automatically masked by
  the controller until the host clears that event.

These are both "Notice" event types, so the controller is not allowed to
send both at the same time. The host must acknowledge the first before
the second can be seen, so we can enforce a deterministic sequence.

And while it may make sense if the first event seen is the ANA one
before the NS, it doesn't look like Linux cares if we observe them the
other way around. The only thing the driver needs to do is synchronize
the work queues for each event.

> But I'm also fine with just getting one AEN; the patch will solve that
> situation just fine.

I'm also okay with that patch, too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
