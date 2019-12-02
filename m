Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E24C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:29:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D897620722
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hw7/HUYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D897620722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NFa1o08vCsi2nh+0T2eTWy/camkl882Kd/JO6gqSss0=; b=Hw7/HUYMhXp/29
	kmgmZ6IcFT4IHCV3zcomNEgySOT2/yQjLEhThHjRXm9oL8/rahxy94vv74HJclI4htUH2IZeAdUYb
	v4fZK7L/fMdNFc4ik28JnMK2rke2J8s2Jfc1FAD5JwQHldeP4P22o38URqBnJtitflcJBRhtCoMjF
	bjUjZS57sTkQgnYv/YlOVqVGDMbvRfOnSOc54Gf2599zWdGqWveS30doR6C8WWIM/ucT0vWiZlXv8
	Ow6ChcYXD9+rBaH9S9otO48sG0jgF2VVcFS5Gg9R/NCSSRIO+jgK6zM9fW0Gp76B3YSpefjcobsw1
	y5njL/73hje3Zvc/VMOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iboZS-0005l9-Vj; Mon, 02 Dec 2019 16:29:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iboZQ-0005ko-7B
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 16:29:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5AE5768BE1; Mon,  2 Dec 2019 17:29:05 +0100 (CET)
Date: Mon, 2 Dec 2019 17:29:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
Message-ID: <20191202162905.GA7683@lst.de>
References: <20191202155611.21549-1-kbusch@kernel.org>
 <20191202161545.GA7434@lst.de>
 <20191202162256.GA21631@redsun51.ssa.fujisawa.hgst.com>
 <10e6520d-bc8c-94ff-00c4-32a727131b89@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10e6520d-bc8c-94ff-00c4-32a727131b89@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_082908_412203_FD04C9ED 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Ingo Brunberg <ingo_brunberg@web.de>, stable@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 02, 2019 at 09:27:14AM -0700, Nadolski, Edmund wrote:
>> I don't have such a controller, but many apparently do. The regression
>> was reported here:
>>
>> http://lists.infradead.org/pipermail/linux-nvme/2019-December/028223.html
>>
>> And of course it's the SMI controller ...
>
> Does 5.4 show the exact error code?  Perhaps we should selectively allow 
> just for that case?

They'll find other ways to f***ck up.  Looks like at least the controller
in the bug report also doesn't have an subnqn and the nguid/eui64 are
bogus.  I wonder if we actually do users a favour by allowing that..

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
