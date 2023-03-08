Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D10EC64EC4
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Mar 2023 23:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJZnbVtBo81CfHv4TrSA9KiSrR4o3KG/0d0r7zJ+QLg=; b=Xt/U8pN9WmnC4CW+JCkrppFwmb
	xUk8KC/3OfJNVv4PzvOmn5jbPOGJHYS7m1lVQlZUgWugz1C9wMexRJdeuGE5kHV2TyBcY0HuaCeKJ
	E9kXGekIsV0XK0ZYzhN6LL4sOg9RX7/c4LnXb3lI6tqJIdDs1m1T+pWT58juhJGVUtJk+8czYdMil
	+RdBJ9rlVP8ZjF7zH3j/d9NxuSE42Uw/Y+0B5v8G7i+AtYCs31LaRBORThgZThcLKvRddrE9q/y51
	RsK+wOWqghN/rz0lGFym6yX0EuMZ+ox2GI44N9+WaJX83td2vXBYdq0gGq0pUH/8OTjH+kAiUZzHm
	cX8JwyJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pa3fL-007Dz1-5M; Wed, 08 Mar 2023 23:57:51 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pa3fH-007Dxn-8U
	for linux-nvme@lists.infradead.org; Wed, 08 Mar 2023 23:57:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 936B3B81DBB;
	Wed,  8 Mar 2023 23:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7B5C433EF;
	Wed,  8 Mar 2023 23:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678319863;
	bh=xMeWR9uiEYPcyBM65k911cDR206YkJ7DdRC7i0DuY9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMt2BRN7/Dk/FSLK/xGnFRnAgomG3nAPM4sHtQrpZv/GvwBOdbsOL4rT1HbcRPh63
	 wphr+qOrC9iSNfbKcsJHFa4OTBv3ejifiv+PgXFyQ+7XmCSq3hS9OKMFLpP3PjTV5e
	 Q1cLvdqShCLSIMq25ULLzBlBmUH0mj497NQZYcmNBdUSzHONPSEBQBts2E8Y04/EkB
	 zHDIfRFstrXVPmk0XjaNIKXiJGphtI31bfNps/zWvD27RZDaYh4aIvBCTkuAzgntQv
	 q3Ab9Pd9MoTSdDyVesP3JtO/T9UB86cRytSbpL6pCokeEQbbMtPSikBvslUV3RVY8I
	 duV5m5P4EmGWw==
Date: Wed, 8 Mar 2023 16:57:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: print correct opcode on timeout and error
 handling
Message-ID: <ZAkg9J+Br3EF2oCU@kbusch-mbp.dhcp.thefacebook.com>
References: <20230307163045.5882-1-akinobu.mita@gmail.com>
 <ba7cec63-2518-c68f-0dd6-b0a936132720@grimberg.me>
 <1e81d4f4-6b3a-ab7e-e81f-dd0af6590a50@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e81d4f4-6b3a-ab7e-e81f-dd0af6590a50@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_155747_495660_8F80C912 
X-CRM114-Status: GOOD (  26.28  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 08, 2023 at 11:51:21PM +0000, Chaitanya Kulkarni wrote:
> Sagi,
> 
> On 3/8/23 03:06, Sagi Grimberg wrote:
> >
> >> In timeout and error handling, various information is reported about the
> >> command in error, but the printed opcode may not be correct
> >>
> >> The opcode is obtained from the nvme_command structure referenced by the
> >> 'cmd' member in the nvme_request structure.
> >> (i.e. nvme_req(req)->cmd->common.opcode)
> >>
> >> For the nvme-tcp driver, the 'cmd' member in the nvme_request structure
> >> points to a structure within the page fragment allocated by
> >> nvme_tcp_init_request().  This page fragment is used as a command 
> >> capsule
> >> PDU, and then may be reused as a h2c data PDU, so the nvme_command
> >> referenced by the 'cmd' member has already been overwritten.
> >>
> >> To fix this problem, when setting up the nvme_command, keep the 
> >> opcode in
> >> a newly added member in the nvme_tcp_request and use that instead.
> >
> > I'm wandering if we should just not reuse the cmd pdu for a subsequent
> > data pdu...
> >
> > It will take more space allocated per request (up to a few MBs for lots
> > of requests and controllers)...
> >
> > but will prevent from propagating this to nvme core...
> >
> 
> Is there a way we can do this without increasing the memory usage ?

The data pdu has to go somewhere. There doesn't appear to be another free area
other than the command pdu, so if that's off limits to preserve the original
sqe, then more memory is needed.

