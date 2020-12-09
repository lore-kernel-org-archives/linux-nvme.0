Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB17C4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 17:47:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32C223C92
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 17:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32C223C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TjnY/lhHJWvNWtaGSoS+06ubzNb9a91HlBaTUyCaem8=; b=0PmMEptTMa6QuJBCiKURBO4OH
	J+78xfrV0h74Af2unTh4TiLDVZ+oaCuHWpZeknrQAX8v5mbdLbgoEG3R3ujf8n+wv8qbVnapb7iwx
	Dn7XDV7y0ceOiQzVXtqo84UiLroea8ki+req7tWy/mPFieZ0jHidKiHQOStrPYm0JPvrGnLOG1Z+a
	7tyD0PfnJ7NjSEDmV6httaylv65Y8Jfc8CqxabQIWAbRtQOLOPmy/NY8nMHqZIN3+l0bElrhUTtGs
	F9/emDQp8L6b0Pu5dLeTFKLUkpnJ5wZBvwl/YnrxdO5MqRWTWOIFW+oI5HSURkTGOM/9iHuD0UxYj
	2cF5JwXCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn3Yn-0001us-77; Wed, 09 Dec 2020 17:47:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn3Yl-0001tf-0Q
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 17:47:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 630B268B05; Wed,  9 Dec 2020 18:47:19 +0100 (CET)
Date: Wed, 9 Dec 2020 18:47:18 +0100
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201209174718.GA19512@lst.de>
References: <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
 <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_124727_180319_A41DA77F 
X-CRM114-Status: GOOD (  15.78  )
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
 Hannes Reinecke <hare@suse.de>, "hch@lst.de" <hch@lst.de>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 10, 2020 at 02:39:36AM +0900, Keith Busch wrote:
> > The use-case I'm trying to describe is that the admin on the storage array
> > is creating a namespace and attaching it to an existing subsystem,
> > completely without interaction from the host. It just so happens that this
> > new namespace has a different ANA group than the existing namespaces in this
> > subsystem.
> > Then the array has to notify the host about this.
> > And the whole discussion is about which AENs this controller/storage array
> > should be sending.
> 
> Fred keeps saying the spec's rules for NVMe's namespace create command
> from section 5.20 allow him to not send events, but it turns out you're
> not even using this command? Why would the spec's defined behavior apply
> to this proprietary use case?

I think we are in an even deeper mess here than I though.

 - one issue is the fact that the exception gets creating vs attaching
   and deleting vs detaching wrong, and that probably is my fault.
 - the other one is the wording should be shall not send the event
   when the creation is ONLY due to the creation of a namespace, that
   is not when a new ANA group shows up (and the way how ANA groups
   are created is out of scope)

So if we do a textual interpretation of the spec, the controller does
not only need to send the ANA AEN for the case we are debatting here,
but also for the case I specifically wanted to exclude.  Sigh.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
