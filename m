Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46963C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 08:51:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CD022CA1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 08:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CD022CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BNCgecnXHLR1WPJTNV8HiXBanxYaGPIQJRSdsOzqor0=; b=QboJ6Hd8OYSAdyP4DMLzJ/IWK
	93RXgnRijz0cboxwpERxCrdf68auCIq/qswl43PdvcQ0lbBZCQZpDP/9giytpSuznv3/z41WH1LII
	BmgFcWhz5K8QTtBrCCcV+dIZ0L7WoAHc+RauEJITr0PYlC0yow5KetENj+wMbhBtNHSdLR3hQIsdV
	xXo20VCgOxGgqT2XiTBXIIop55ebyMMFcxxT3gSoVpV8uQXyocVdJIxaKbhQMv5YzMrXu/qqLWAYe
	F3MWYzrisYP8Z0V4arCgkpr2ZWBSP7ik0OIneroQoyA4Zn7txYUhUJ4Jl9730N4IzWIQEcUaaFrGO
	JVaVDwkVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knHfk-0000ER-EQ; Thu, 10 Dec 2020 08:51:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knHfP-00006K-HH
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 08:51:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 552C868AFE; Thu, 10 Dec 2020 09:51:11 +0100 (CET)
Date: Thu, 10 Dec 2020 09:51:11 +0100
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201210085111.GA15999@lst.de>
References: <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
 <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
 <20201209174718.GA19512@lst.de>
 <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209213437.GA3682670@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209213437.GA3682670@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_035115_719045_E7B939FC 
X-CRM114-Status: GOOD (  12.76  )
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

On Wed, Dec 09, 2020 at 01:34:37PM -0800, Keith Busch wrote:
> Linux hosts currently want an ANA AEN anytime the host needs to refresh
> the ANA log. That includes any condition that adds groups that didn't
> exist from the host's previous reading.
> 
> If the Namespace Attach occurs to an ANA group the host already knows
> about, then you don't need to send an ANA AEN because there's nothing
> new in the log that the host requires. You just need to send the NS
> Notify AEN.
> 
> But if a side effect of attaching a namespace results in a new ANA group
> becoming visible to the host, then that group creation is considered a
> separate event, so the host wants both AENs. I believe this is where
> Christoph is trying to steer the interpretation and the text.

Exactly.  Although as Hannes pointed out, this language:

  If, for an ANA Group, there are no namespaces attached to the
  controller processing the command, then no ANA Group Descriptor is
  returned for that ANA Group (i.e., an ANA Group Descriptor is returned
  only if that ANA Group contains namespaces that are attached to the
  controller processing the command.

creates a bit of a chicken an egg problem in that case of a newly
attached namespace that is the first one referencing an ANA group.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
