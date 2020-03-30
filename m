Return-Path: <SRS0=mOBO=5P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B6CC43331
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 13:53:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D77206CC
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 13:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d7h62+Jp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vUJuqJD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D77206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5aYHC0ULKZknnFxfrY7DR1RZBwHrprnxQDSaseoEuZk=; b=d7h62+Jp6NgmlO
	E6akuSRiZIz9vcqLbnclQW9CXaUHkdv8+s+UfY3NBIsMmLIbOf3oneiU83cvrWI76LOVe5Yt2xzPW
	ZAWf2rcGBZBoWOdzmu/SGCFE57Rf4/jBk0H2yLymY5EomHjU5/WdNSLdR77FryDqgiLr55aXD299C
	PP2CFoOgQ3xwRORuMfsjl1p866fplOi5/pp4lKrbUY/6jksHE3U6YwvD4OmpoEZMuF8b0cNIL2SZW
	STFSTiR9DhIvawgoG5Ai+VdR42KjrTQ2B+tAEVj4CEzOhz3WcNpkCwOeo7iekUk1CLFUVEbN4rzKG
	JAxIxO4OBfreLp520ERg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIur4-0004qJ-Eu; Mon, 30 Mar 2020 13:53:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIur0-0004ll-AF
 for linux-nvme@lists.infradead.org; Mon, 30 Mar 2020 13:53:27 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53AFA206CC;
 Mon, 30 Mar 2020 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585576405;
 bh=9fj94aO+4iZ5CJVZaUxcTEXkFO9lNUuFcHzpzx0huIg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vUJuqJD9rP+HVMcF2vqQ/l2b7bWGsDibN/cJ6LOXo70nGdl2Sv2L3HajIyzdCENtf
 UBeBcJxxwtOxqAmQFfarvAsuPG6VLuLcMaNZRSZjOrU0BffsCnKwbsfYUWxGcgK4Ld
 poJII5poqzXZhxe3nQoK0eTu9BIUcPCC0yvN0cyc=
Date: Mon, 30 Mar 2020 07:53:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
Message-ID: <20200330135323.GA32604@C02WT3WMHTD6>
References: <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
 <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_065326_417967_77AC54F9 
X-CRM114-Status: UNSURE (   7.82  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ming Lei <tom.leiming@gmail.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 30, 2020 at 06:15:41PM +0900, Tokunori Ikegami wrote:
> But there is a case that the command data length is limited by 512KB.
> I am not sure about this condition so needed more investigation.

Your memory is too fragmented. You need more physically contiguous
memory or you'll hit the segment limit before you hit the length
limit. Try allocating huge pages.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
