Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C89BC4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 16:19:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F060F23BE3
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 16:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F060F23BE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0jfO0U7RUApakZW1VCB+e6jjZ3p2rHsbz5+dSkZzut8=; b=HQ0iakTHVzVsdx780gZejIqyW
	+XcptM/Trpi/0XNFJWcb2BgZlyGQUy7TV1JV41qbnpL8PNebCdEdldmzoYsixRyfMBZpfQeCdj3eq
	8LmC9WPNSjYB8UIyUgyZVwcS3tgrpkB1stvE2hQpz/kLoFdMdEfbwJnaNo4pjFiHfuFxuEjGUnTWy
	W4lbsEu4TFPu2GVr4JRNVWuWJOxFyMx6qwff1UrGO2xl6bXwSbT13rkMu6GCy4O4No7CQJR79qw4u
	OxOERu6h1iaovPJY3JVhyUZ8ZJFhClF+t060ptlvvD0mUB1HRoHKSLfa38tOqv2YwIMopUsDtXB8n
	HmlnwVg4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn2BU-0006RB-Vu; Wed, 09 Dec 2020 16:19:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn2BT-0006Qd-0p
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 16:19:20 +0000
Date: Thu, 10 Dec 2020 01:19:11 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607530757;
 bh=LBadIz9xHu1eJpvjToNwQ5hMOdyl8nXPc1aZxuerk8Q=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=MzzpVh4UEamTbyziyZGLirmmWln1i11O+jMIwr1VM7Y/LapyGtQOk5KxUUYFOlR/K
 DCyMkostYBGQEjK8L2bZX8VMDQ5EGrufGzOEMC1oTp5SY7V+V8kfo2FLvPuYbx5I7+
 PlmnvGvAQDYwveaZu5U2OuDxrrhuqWPeYPcl5O09KyvZdyRJJtSWEhGGhpH3DHo+Qs
 saT2NaQSlV72EjXam3QUvGepW37DaT8xy6i/DNo16ij60DZvGvN5Uos5IlX92pUF0h
 K1wq2jcU/L+EM/3Es6gidC5wly+2+dxQ/rJhTseZKfNZCAgd6k9ixH0c1tlLlUCWx0
 sSlKcZKweurkQ==
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
References: <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_111919_386082_6FAA8739 
X-CRM114-Status: GOOD (  15.90  )
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

On Wed, Dec 09, 2020 at 05:02:05PM +0100, Hannes Reinecke wrote:
> On 12/9/20 4:53 PM, Keith Busch wrote:
> > On Wed, Dec 09, 2020 at 03:20:57PM +0000, Knight, Frederick wrote:
> > > When a namespace is created (and contained in an ANA Group), the act
> > > of creating that namespace results in a change to the ANA Log page -
> > > therefore AEN.
> > 
> > That is wrong: creating a namespace doesn't do anything to the ANA log.
> > Only attached namespaces appear in the log. Creating a namespace
> > doesn't result in automatically attaching it to any controller.
> > 
> > You are thinking of Namespace Attach from section 5.19, and the spec
> > doesn't define any special exceptions for events resulting from *that*
> > command, which is also the command that triggered this thread.
> > 
> Actually, no, we're not thinking about 'Namespace Attach'.

This patch is the result from an Attach command, otherwise the host
driver wouldn't have found an unknown ANA group for a new namespace
during the rescan.

> This is a normal namespace creation on the controller side.
>
> I do agree that 'Namespace Attach' would have different constrains and rules
> under which AENs will be sent, but this is not what our initial use-case was
> about.

The use case in this patch is about getting the host to recognize the
ANA group of a newly attached namespace. If you stop at namespace
creation, then this patch doesn't do anything.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
