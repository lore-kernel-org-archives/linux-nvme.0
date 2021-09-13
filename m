Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:02:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DDB6103B
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94DDB6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xc/baq9Ey5QksSQHZCFuaiE/qKbpEag46INB/GlWOqQ=; b=kBn3W/Fn+DAAp6
	9f7FR/YnCnFpt6WkG22U6LwCx8esAVtMSzzUW76J50HBbvr4k2UTtAX1V0C/+/e+30qxw2rtglqMz
	5vOOa4cz0UdNhQzvWK4hQWPckPbw7kwQR939XW9LIcwPBMYDwzEOWlICU3YjUh1wA2QZKW9/o45P1
	QIvxpDo0oLTIKusFBf5NioVhU+Du7mN2sfLV+PZHkV5866GtDonFop+Uw+6+cdhSxrB3J3rIXoIxa
	jtMssB4VNcYkFYgFXGXy9GujNn1x3rdgnm4Ci855tsNVXeyb53l4UolIpdknVp5nFphII8Ai3+ZMm
	dnIRgT8WjuqjgA1ZThdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPt5D-003Gdo-PU; Mon, 13 Sep 2021 21:01:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPt0y-003Evu-7s
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 20:57:21 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4937260F8F;
 Mon, 13 Sep 2021 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631566639;
 bh=ODYbK8NiwkBDHwaLuRbXsg7uTSlfwDcVSfV6q8DAF48=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DgDAuyBk0LEteIKvFaVlY3K7yobk+GAhjzJac3FouLCvU4Q0zD8rInK+ZXqzpPpJ5
 Uh6qzUUYJ7LI2p43uo8sisYnJkWemssavmM6JSCta9Jm4JHZz8xBwc7jQrlV5RaGNG
 fWLzRbsV5JV2PDSq7e0aIeoI4dALddp8wLzhR3PdDPcIerWTHJzOunz+6h2hQPY5LC
 sxMSJqQPC7DWfQdYBRt/skHZdQBF1arVt7qAIrfNkKHn4ZtGH2Kqw2vpE70PBYBgu9
 8AnTxjLjcrYNaf5lTE+LuFYfJVDZJsPGVHUPMX1+CNbt9PbW/n7SnDuMT0D1MpdE/k
 bSWgK6cGiewHg==
Date: Mon, 13 Sep 2021 13:57:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@fb.com
Subject: Re: [PATCH v2 2/3] nvme/multipath: cosmetic: keep ns nsid locally
Message-ID: <20210913205717.GE3283786@dhcp-10-100-145-180.wdc.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-3-anton@lightbitslabs.com>
 <20210913160220.GB6442@lst.de>
 <20210913201935.GA83181@anton-latitude>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913201935.GA83181@anton-latitude>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_135720_354418_016A6424 
X-CRM114-Status: GOOD (  16.28  )
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

On Mon, Sep 13, 2021 at 02:19:35PM -0600, Anton Eidelman wrote:
> On Mon, Sep 13, 2021 at 06:02:20PM +0200, Christoph Hellwig wrote:
> > On Mon, Sep 13, 2021 at 09:30:22AM -0600, Anton Eidelman wrote:
> > > Keep the nsid of the current namespace in a local variable.
> > > Change the type to unsigned int to make checkpatch happy.
> > > 
> > > Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
> > 
> > I can't really see any improvement here.  Also checkpath as so often
> > these days is fundamentally wrong here.
> 
> Do we you prefer to scrap this commit?
> 
> I just wanted to get rid of multiple occurances of "ns->head->ns_id",
> and just use a local variable that only changes
> once in the for_each iteration.

I personally think "unsigned" is a well defined type in C and we should
ignore check-patch complaints on its use. Otherwise, I don't have a
problem with the patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
