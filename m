Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4786C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:28:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653FF23B79
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653FF23B79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PrRgOUStw/71THvRHzVeTRYfYhoi6MOeSgoonl05lcw=; b=B3Q2vUKzWv2IUmDDPCsB9yfVd
	csycXWqWpgFSpF97SENozMoEfKNlggJeSkelcdNNcDer61WP4u4x4abS7QGhFuD9sTFZSg+TKZ/t2
	AJjM0ozxI9v30BfRbyDk7ofPiYUXN8q98JdhuL9nNoZDKVrh7OCKrSwLAqT4A3EbqVjGSqyOmFX79
	8UX1O7vZGPGYmfN7gGXIiG+Uxs3iBVK4dZzSxcUopyRaxeRUo1esi3F2rPtHyqi7EJuTSNTPA0XPu
	cjnYZm8rfc+hMinorfrLU7C+Hz54U5gbK6ULmB3OhGU5S+vGlWwGtkrfeLllXqGVSzuZR8QQvb43y
	JkP03DXHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmttU-0002D1-HH; Wed, 09 Dec 2020 07:28:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmttS-0002CN-4J
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 07:28:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 658036736F; Wed,  9 Dec 2020 08:28:06 +0100 (CET)
Date: Wed, 9 Dec 2020 08:28:06 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201209072806.GA10037@lst.de>
References: <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_022810_323399_1E92F294 
X-CRM114-Status: UNSURE (   7.46  )
X-CRM114-Notice: Please train this message.
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
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fred, stop this bullshit now!  I'm sick and tired of you misrepresenting my
opinion again and again despite me correcting you.  This is not a basis for
productive work.

The only thing I requested is what is said in the document:

"A controller shall not send this event if:

  a) the change is due to the creation of a namespace (refer to section 5.20); or
  b) the change is due to the deletion of a namespace (refer to section 5.20),

as the Namespace Attribute Changed event is sent for these changes."

The Namespace Attribute Changed event has no way of notifying the host
of a creation of new ANA group, so strangely interpreting that entirely
different event to be part of the namespace creation does not make any
sense whatsover.

Creating the group at the spec level is not due to creating a namespace.
That might be the interpretation of your management backend and is an
ok implementation, but nothing in the spec implicitly creates groups as
part of namespaces creation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
