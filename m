Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CBDC3F2CE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:45:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578242166E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nKakLeDB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qssAsY7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578242166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=azMduGC1/UYAusqRaLUo5FZ+psamwbM0vr57hBpNLyg=; b=nKakLeDB3me3vy
	5cf6AWxzmatq6lC5/gND5e7zkCeEV5AxagxKQxC2P2wfNVPeQ1kLfkhJMsrL3hJQnNSIwInuuVQAR
	P/q78QxHnTixJVkENjpG23AB7gmioYUY/5JMvZ9jEIT/Uc3U0z75U3D5Nol3zyT7mWH3rK+o4Qbr9
	aPyxlKQ/8dxTe2/H3kYXy1aBS4zyx2lAAaEXxxEK8sBm/Gj479ktBGM/TU5HU3iGJwuYKIAO7Kl8U
	W760TKkQCSRFpppVPPJoYCoDR6ZRy/rZReX1wxV4ZMh9gL5AIv+ux6858GCKdms0w8TLNB3guC1Ti
	dr5OGP8c52nGgZkbjPPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9X95-0006vs-HS; Wed, 04 Mar 2020 16:45:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9X92-0006vG-HT
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:45:17 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 300D52166E;
 Wed,  4 Mar 2020 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583340315;
 bh=YEdFrdcDHkvQj5Bc/k9U15fDiaHx1XoMTze/K+lZyvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qssAsY7pZJ9wI41xP2wtCuwfW7C5jgMPbLNVT2GdB9HjF+Na/IvZs9o/9CbDYYwG/
 N2rtJGz6SsZd8XIWSo/kjoK3w9U1M7DbF7jIqV8jQAXgesGZ9VKhgXsfwvZz/UZDDD
 ChSov9W7dckVaOQK7eUZAH31KwqBLj77FZrRgbts=
Date: Thu, 5 Mar 2020 01:45:09 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme-pci: Remove tag from process cq
Message-ID: <20200304164509.GA21865@redsun51.ssa.fujisawa.hgst.com>
References: <20200302194616.2432-1-kbusch@kernel.org>
 <20200302194616.2432-2-kbusch@kernel.org>
 <20200304160518.GA11029@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200304160518.GA11029@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_084516_599146_3BF69681 
X-CRM114-Status: GOOD (  20.62  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 bijan.mottahedeh@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 04, 2020 at 05:05:18PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 02, 2020 at 11:46:15AM -0800, Keith Busch wrote:
> > The only user for tagged completion was for timeout handling. That user,
> > though, really only cares if the timed out command is completed, which
> > we can safely check within the timeout handler.
> > 
> > Remove the tag check to simplify completion handling.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/pci.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index da392b50f73e..db84283f2a5a 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -991,14 +991,13 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
> >  }
> >  
> >  static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
> > -				  u16 *end, unsigned int tag)
> > +				  u16 *end)
> >  {
> >  	int found = 0;
> >  
> >  	*start = nvmeq->cq_head;
> >  	while (nvme_cqe_pending(nvmeq)) {
> > -		if (tag == -1U || nvmeq->cqes[nvmeq->cq_head].command_id == tag)
> > -			found++;
> > +		++found;
> 
> Any reason for moving from found++ to ++found?  I always find the infix
> notation a little odd when there is no need for it, but that is just a
> personal preference.

Heh, not intentional. I will keep it the same as before.

> > -	if (nvme_poll_irqdisable(nvmeq, req->tag)) {
> > +	if (nvme_poll_irqdisable(nvmeq) &&
> > +	    blk_mq_request_completed(req)) {
> 
> Do we need to check the nvme_poll_irqdisable value here?  If it got
> completed by other means we should be fine too, shouldn't we?

Right, we really don't care how a request was completed. We just want to
know if it has completed.

So I'll change it to this:

	nvme_poll_irqdisable(nvmeq);
	if (blk_mq_request_completed(req)) {

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
