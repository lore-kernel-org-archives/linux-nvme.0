Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08999C4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 03:15:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA4B207E8
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 03:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HaK4eZMx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vV477CxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA4B207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rKjZluYoWMDt+35QjzKZPB7FWxBgL9jm2/BAqPChBsE=; b=HaK4eZMxrcaldi1eHnHAxM6JC
	Ql9AHdVPMLjo+l06uXx0khPUfZGXcPpdG+fzoZzl/nxYC8Eif04Mn1GL3firR9+9Vzvv24pqDorPL
	H1juG7oCe4dK+ps8Swyzzp32/98hqsb12H7Cd0arPvzBWvqwd/4ch0lkGCkCZpvQAjNeJfEousEFx
	uqvuXf0mXMG71Rk8Zc9bl0TqxCnQC+5tU3zWBZPyt5+RrFx5476THHRZ8u7EQUs7kekliU/gsHYuM
	NaFP9dDtMz234rfrEL/oN6Ojq8VjvfOwufplhtKW7nnxkHaLfEr44TGmc1KM3JD6Qf3kLpvF6barW
	GY5HKYM3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXyPW-0007Fi-EH; Thu, 29 Oct 2020 03:15:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXyPS-0007FM-2b
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 03:15:30 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4145320791;
 Thu, 29 Oct 2020 03:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603941329;
 bh=C4kjXqI7ewtdQmVp492Kw8rJuNeRKJNHLGIoAabBliE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vV477CxOyIFDZhPvYZTMh02IiC9MZGr9eDWUaT0QqMjMbv3ElclNmWeBg+AUpC1eY
 TfrIs0LTHkwbKJK1nSrfdrbx7cuVrWA6ReS8mJESNofzaZyPsqf203DQeXWenTDzqg
 5rTIAvIbALEeJBg5h7HzLVW6Ij+iRIEjAQY3VXZ0=
Date: Thu, 29 Oct 2020 12:15:21 +0900
From: Keith Busch <kbusch@kernel.org>
To: Gloria Tsai <Gloria.Tsai@ssstc.com>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201029031521.GC20928@redsun51.ssa.fujisawa.hgst.com>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201028171726.GA9897@lst.de>
 <HK2PR02MB4004EC30D14A16B59FD22A44EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
 <20201029023306.GB20928@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029023306.GB20928@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_231530_312110_A005E414 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Jongpil Jung <jongpuls@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>,
 "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
 "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 29, 2020 at 11:33:06AM +0900, Keith Busch wrote:
> On Thu, Oct 29, 2020 at 02:20:27AM +0000, Gloria Tsai wrote:
> > Corrected the description of this bug that SSD will not do GC after receiving shutdown cmd.
> > Do GC before shutdown -> delete IO Q -> shutdown from host -> breakup GC -> D3hot -> enter PS4 -> have a chance swap block -> use wrong pointer on device SRAM -> over program
> 
> What do you mean by "wrong pointer"? At the place in the sequence you're
> referring to, the PCI BME is disabled: you can't access *any* host RAM,
> so there's no "correct" pointer either.

Re-reading your message, I do see you said "device" rather than "host",
so my response may not be relevant.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
