Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B20C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:49:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0735820833
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rtW6SR+c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/xBUQMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0735820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RiWszNSS1oDuRK+V1KBCsTT83RZkUbgOsyMM3095Igo=; b=rtW6SR+cvni6g5
	WEeSMFX/8/vH5d2EUoPrTYZpf3JIKztEuiWVGBQNp54XqeGogLM0C2dMQsXl8R4GHecMtUQTCLeq4
	wuiKFpnBR6/FYhdphoNhn0loCTRQoYaJUhUUz+Dm0P923T2gOKo2rrCC1AET7MhPNefi8kOD3Jhvu
	xqGNL3qifuyu6ICQz+ikIbh4Zam+QfbcLeIbl7tBzwUJ3+YRmiaqb5WhfAUi2Wv8D1MmbYUR+czSj
	uFvNhqfIog3Fyin+4pFUvKqGizMqyPJu4oVmw3QI4Rpb07ujOLbYRIbEhT6t5AmmHGHIR7QlSZV20
	HoPrDlny5ZvbkAh+KAVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iboss-0004HG-Ss; Mon, 02 Dec 2019 16:49:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibosp-0004Gw-98
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 16:49:12 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC45620833;
 Mon,  2 Dec 2019 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575305350;
 bh=dl7YPTjiSsDGSMM4fgriTyrms1OqhUdtc/Xq3QqyzSY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J/xBUQMeuHZLwmelT36sfTlY7e/n6R+NyVcr5A5Zzz6op56R7pxyZO/vSZoXf9lZW
 mhbDy2wpSUZWs6Cd4muiFRvfmQ4fNm547uEE8DDqD0jU2hRu7L6m/qa1jaK2KvnR4W
 EUiJdDyMnlIG50SNc6ss9zpMuhWL+Rh5uG7snQX0=
Date: Tue, 3 Dec 2019 01:49:03 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
Message-ID: <20191202164903.GA21650@redsun51.ssa.fujisawa.hgst.com>
References: <20191202155611.21549-1-kbusch@kernel.org>
 <20191202161545.GA7434@lst.de>
 <20191202162256.GA21631@redsun51.ssa.fujisawa.hgst.com>
 <10e6520d-bc8c-94ff-00c4-32a727131b89@intel.com>
 <20191202162905.GA7683@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202162905.GA7683@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_084911_343756_2303CAB1 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: Ingo Brunberg <ingo_brunberg@web.de>, linux-nvme@lists.infradead.org,
 "Nadolski, Edmund" <edmund.nadolski@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 02, 2019 at 05:29:05PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 02, 2019 at 09:27:14AM -0700, Nadolski, Edmund wrote:
> >> I don't have such a controller, but many apparently do. The regression
> >> was reported here:
> >>
> >> http://lists.infradead.org/pipermail/linux-nvme/2019-December/028223.html
> >>
> >> And of course it's the SMI controller ...
> >
> > Does 5.4 show the exact error code?  Perhaps we should selectively allow 
> > just for that case?
> 
> They'll find other ways to f***ck up.  Looks like at least the controller
> in the bug report also doesn't have an subnqn and the nguid/eui64 are
> bogus.

Indeed, they will find creative ways to break it.

Customer or OEM requirments are poorly written, like "Must report NVMe
version 1.3". Nobody bothers to mention that it must also be compliant
to that version, or even realize they never cared for those features in
the first place.

Compliance testing like from UNH should have caught this before shipping
with such a device, but it's a cheap device, so maybe they skip that step.

>  I wonder if we actually do users a favour by allowing that..

I think it's too late now. We did successfully use such namespaces
before 5.4, even if they're fundamentally broken.

Johannes also commented *not* to consider these errors when this
identification was originally implemented, so either he knew vendors
screwed this up, or had the forethought to know they would.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
