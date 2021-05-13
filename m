Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD0C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 15:49:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82136142E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 15:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82136142E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aUSR6gf57FUUBYLuS95hp2ygdOoBww413GY6HNTo/Yc=; b=Y+jLvyfE4vvT1lGwhqyR17xg0
	NjaW+n6Au3UMBsep86xQsTPf8wwgxmlHtT3wc2jxL3SFtojP3btu4Mve+FMP3iWZC+4L7k1irDnNG
	pZvCBZ5yVNeF+600C3SoMZ9n9mCaSnRv1pLRT7xo25gp55IJRYY/Dr01uhkfnCoMU+Q9ewBSOYCx8
	0LPme15oWegWHJdawvuwd+530SyVarZMtRHRU46Un+fbvzb+eHDi7mkspdoRc3MZqT1EXwSZff4sX
	Lw6VKAmIjJAu5hdMcyMwchtsnTUMt0exVSrbqgdIQvcr7HghdQlMLwWcra3arjMo8pV6RTTarx+c/
	6bwAaDPrg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhDZj-005uVu-E1; Thu, 13 May 2021 15:48:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhDZb-005uVM-Cd
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 15:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sm1vMmRzP3W1SJiWRC2c2mfaRvKX4/vxVS49V8b7OK0=; b=V080aYZKNUzDOrt7jqbJHkxARY
 XgJ5nLYSkWgHeNBsrgrg/P0n16a0dx3BE962s6v3YHUAYwSoock4hzS606pJv/tUl/hCWaSrmvti5
 dGJX3yJXGio91GiojTNRxS95uOQQFuL59rB32lW81P0XDk4jbYp3mSfQYX25iuTSRPxkUHOpHjZk6
 qErTq+5/78XtOSwaPrNxIPhAGat4kHExuKwbP9DaGBZfDRZD3+AtFaxBhgkdQJmbgjdxp7rcL89xP
 JKTegP0TNdOAacnq2o1U7dsy16cmaUJSZNjmVxrEX836LMvDRRQzgf/Rc/rnLWQeg4y7fybPqFfAB
 kTb2djLA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhDZY-00BMh6-R8
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 15:48:26 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9756461354;
 Thu, 13 May 2021 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620920903;
 bh=KTSGkGVmFB7RWUNT3wbOOJ547U+3DuZxauUvDpch8p4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RPkOHD/TNI+zkyABr8LDpaqVGp1fa5q0kOgeq/S5RMOUA22iNnMM59m4THC9l5w7/
 ejzssEnMhV0I6NnPL7UdKwHCVBpJ1W+FkaS3eZuajUyT3bOjXhkznLzETPkTJ3zeSZ
 47H2Pmst4cRHUxSiHYI79+Cj0UuxHq5iFDW9O6D1o5hRvQTKtw6DJFFZyuVroigBpT
 5OgYBsSErdx4eZtrQx3G7F6bKrNEgWiTpNHacRIn7beNsPCmZJ/Yr6ldd6f+szzXML
 VrNQyDtSJDXeHGKawY5foy3v4CMXrDWBdBukxrW490O7dc84EqJTphFmwL0qd3ZPSh
 bbWEIs5wkJjLw==
Date: Thu, 13 May 2021 08:48:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210513154819.GB2272284@dhcp-10-100-145-180.wdc.com>
References: <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
 <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
 <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
 <20210510183040.GC1857448@dhcp-10-100-145-180.wdc.com>
 <9a6fed85-2f8b-8398-1e8b-cd44e6004f40@grimberg.me>
 <20210511030051.GD1857448@dhcp-10-100-145-180.wdc.com>
 <88879279-fff5-b26c-2c1c-52a700a1c40a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88879279-fff5-b26c-2c1c-52a700a1c40a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_084824_939390_A42AD286 
X-CRM114-Status: GOOD (  31.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 11, 2021 at 10:17:09AM -0700, Sagi Grimberg wrote:
> 
> > > I may have a theory to this issue. I think that the problem is in
> > > cases where we send commands with data to the controller and then in
> > > nvme_tcp_send_data between the last successful kernel_sendpage
> > > and before nvme_tcp_advance_req, the controller sends back a successful
> > > completion.
> > > 
> > > If that is the case, then the completion path could be triggered,
> > > the tag would be reused, triggering a new .queue_rq, setting again
> > > the req.iter with the new bio params (all is not taken by the
> > > send_mutex) and then the send context would call nvme_tcp_advance_req
> > > progressing the req.iter with the former sent bytes... And given that
> > > the req.iter is used for reads/writes, it is possible that it can
> > > explain both issues.
> > > 
> > > While this is not easy to trigger, there is nothing I think that
> > > can prevent that. The driver used to have a single context that
> > > would do both send and recv so this could not have happened, but
> > > now that we added the .queue_rq send context, I guess this can
> > > indeed confuse the driver.
> > 
> > Awesome, this is exactly the type of sequence I've been trying to
> > capture, but couldn't quite get there. Now that you've described it,
> > that flow can certainly explain the observations, including the
> > corrupted debug trace event I was trying to add.
> > 
> > The sequence looks unlikely to happen, which agrees with the difficulty
> > in reproducing it. I am betting right now that you got it, but a little
> > surprised no one else is reporting a similar problem yet.
> 
> We had at least one report from Potnuri that I think may have been
> triggered by this, this ended up fixed (or rather worked-around
> with 5c11f7d9f843).
> 
> > Your option "1" looks like the best one, IMO. I've requested dropping
> > all debug and test patches and using just this one on the current nvme
> > baseline for the next test cycle.
> 
> Cool, waiting to hear back...

This patch has been tested successfully on the initial workloads. There
are several more that need to be validated, but each one runs for many
hours, so it may be a couple more days before completed. Just wanted to
leat you know: so far, so good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
