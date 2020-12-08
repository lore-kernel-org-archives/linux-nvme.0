Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C47C4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 21:47:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9777223B26
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 21:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9777223B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X8sG5PA6zC8HVRxCN5zWH3Lv2c1vXi8Dj2rSz57OqK8=; b=H3Mx65MNcAtdb+6K38mOOElOw
	WVT03NIibiSMJQYo2pzlw9d46HX9ZDxuT3gTyzouPDBncNZewwR6L2l8c+DEeaBZC6fYytli7bQGZ
	hVlP6o3mQoKozxcjP5Di3kvf3AG8f5RIkx9dyEsv+wihGgj5mnBWNzxpEBTzbIUcghOCFdlZsNILE
	LqWQp170giikl1+/3klOF3xXI8Cdg+FYjzw1vg0jgQDRgzK8txEQrqb8pEpo5KNBEDCplrEH0kEYm
	/G+0QjKHRc0fC21bdkQaXGG0JCVvhIueov/WXheUmaeg8Xxkf5OPlS45UOcjOrZ9eg3zWRPZaLyde
	D5l6+6zkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmkp3-0000Dr-2y; Tue, 08 Dec 2020 21:47:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmkp1-0000DP-2e
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 21:46:59 +0000
Date: Wed, 9 Dec 2020 06:46:50 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607464018;
 bh=hascAkrZBPpd12dN8Lz3jnu3IL9fWJ8m67h13kF8+tI=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=pFI/bDLWC5eiN3Unj1ZhHG/yNKsmBpfinGdEAQolfzpGqrEnKlKfgfjbEremSaXq8
 eoMQjr+R1owygh4uh38CUA56ek1iWA5uATickg0iVJlXpl1pyvPSdQpjqKED6eXFFm
 bloVISQvXv+2zkwzyhca69moXykpYx/f5WyIi5nWmG0anNbCYOXQzjRbIB2BZnMwRz
 Ri9vDC7sAEeXRbT545b+EBPyqKcDNbjDi1eRqhQ1tgltWGb8txYeVm8tYP33m2gxmH
 PinqqG9Ic4f8TU5Gz6mZcrMYfJhQml50iV7gimlfdBaSSCcgM6xfFsnNU3hNWCHv/i
 mHomxHTXxd22w==
From: Keith Busch <kbusch@kernel.org>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
References: <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_164659_201605_8459F987 
X-CRM114-Status: UNSURE (   7.80  )
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
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 07:13:00PM +0000, Knight, Frederick wrote:
> Setting up a new ANA Group does NOT cause a transition from <UNKNOWN state> to <some known state>.  The establishment of initial state is NOT a change of state as defined in section 8.20.3.6.
> 
> An ANA AEN is prohibited if the ANA change is due to the creation of a namespace.

Yes, the AEN is prohibited if the ANA change is due to the creation of a
namespace. In this scenario, though, the ANA change is due to a group
entering a state, and you're required to notify that as long as ANA
events are enabled. There is no text in section 8.20.3.6 or anywhere
else that I can find that says creating a group with a valid state
disqualifies it as "entering" that state. However, I do find that
section 8.20.3.5 says transitions may occur from states not visible to
the host, so <UNKNOWN state> to <known state> is a transition according
to the spec.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
