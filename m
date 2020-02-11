Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749EEC35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 20:31:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA28206D7
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 20:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TPDIY8OF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPmEzdt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA28206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qcyqrL4tdzA1nj2Jsluhsp4E4HrUxPFzAJGKX3A055A=; b=TPDIY8OF7Jm0yO
	m1x6R8IA1kwoJ5ESP8dcThoBa0u075yMVj9Vn9wwK7V/CQVsIs59erP2qu3bEKz7yT0dXDVJMGAwc
	BvnShe6oefL7qbMfRVbiw3CzBD5HXEMNSpqE95+Sj/vHl8s+w4mKDPQpcY49QqUdXf+RwoGVkhKH9
	j9qC69tBFkwBQvstwTdj/qgxfM+fDHl1RhJTEJiiGgFwF/ndXa9yIsNBDhDWLu1mwAoGR2kGXgjeH
	dNzBg3mR2G2iy6HXM/SwWkKo9sR/ZriX5EmDCJdPHWlwsRp5CFpEkIIwqFqx3wAIFLkWjLcu4KW2T
	T90hpFbkfv95xzka7gGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1cBq-0006nr-Rl; Tue, 11 Feb 2020 20:31:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1cBo-0006nK-2X
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 20:31:25 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A1E9206D7;
 Tue, 11 Feb 2020 20:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581453083;
 bh=xUbiY4bhBcpAIeDjolaKoBuLE7WKKsarUdWNfDCm3pc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QPmEzdt+ZjV5Vc7jlBIjuVc4jqVa779/77bKX0EU9ZdBoumXbejPHetTUSfv9LoEi
 6mhi8cKpuNix+v/FYYoutQcsCyL40OvuwZ9eSpbWTWQjwwMY/C4VfsqhlwpJLoKk9a
 XjUcr1HOr3QbeV0Vqt1h9/K74N2vHFkRxVyStchI=
Date: Wed, 12 Feb 2020 05:31:21 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvme-tcp: Set SO_PRIORITY for all sockets
Message-ID: <20200211203121.GC19458@redsun51.ssa.fujisawa.hgst.com>
References: <BYAPR11MB2712E7D933721CA54EB18365E5360@BYAPR11MB2712.namprd11.prod.outlook.com>
 <675e24bb-8a91-6612-887a-2a0a38a57cda@grimberg.me>
 <a82b08e9-75bd-e14b-7d30-7414df1c90c4@grimberg.me>
 <20200131004818.GC8673@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200131004818.GC8673@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_123124_140054_72211495 
X-CRM114-Status: GOOD (  10.07  )
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
Cc: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 31, 2020 at 09:48:18AM +0900, Keith Busch wrote:
> On Thu, Jan 30, 2020 at 02:51:13PM -0800, Sagi Grimberg wrote:
> > Keith,
> > 
> > Unless there is any other feedback, I suggest we queue it for
> > 5.6 perhaps?
> 
> Sounds good, queued up for-5.6.

Sorry all, I did this a little to late for the 5.6 merge window. I've
started a 5.7 branch and collecting patches there.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
