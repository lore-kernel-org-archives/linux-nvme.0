Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76526C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 20:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1dZCizAc6cgHD+wJAh04UwFmsWDkfuIss6Ga+ao5DSQ=; b=EDe0luzvNNDfNdi1AvMbzajoCn
	Qkg81y7PUB1bwlqvrnIkVdJn9zXttDNHcSxBgI7NOQtyqR2wdRs/nwox4/VtSKtHFRlvy786woPA1
	wiBGxUDWDAyDGkXWoIFL3C+ybVOUb46tEayiWVvoLLprtfLcqx7a4tNSjmJuCsOt0ktq6eSIFWYUD
	r1pxq88YsBvSXs93qdqmovbqOQ9uAL16AcGP+6wdTqRTDfkqb/gej5le3PCSot80p/hNOE0VZHr/K
	N+pu/v8GSwlRLQ4d2QVDWit2UpaOzgY2aLgr4Lqiz5LAWgJx0ne2thkjcfsu5hcmPXr+iJ6xDrkq7
	yOKP0o2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBLBn-00Ds2r-1A;
	Thu, 07 Dec 2023 20:41:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBLBl-00Ds1w-1Q
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 20:41:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5F59062158;
	Thu,  7 Dec 2023 20:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5102C433C8;
	Thu,  7 Dec 2023 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701981700;
	bh=LOhflGTFy5+P3SPZmFDfOw/LjBHnHOYWS4pyyFR3d9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCDdVxRJ5TATP4fMyEtGynTzg0rVnkMgDTuIocsLg3cPo0ldefF9PiCWqhYnBIeGK
	 tz6wMNsn8zL7su0A6V0ctK3s2MWIc4Ixhp/cuWQzFZcP414N7+4GzVt7o+UZphzoWz
	 x962FFpVey+2x/2MOQ7BufGifCmr7gAB27c9BMthhTRFam5OTLbqMli4Hip7WEiwdv
	 uDNQmJUgoc4lYYhEjkJSork+wkoZ/Qjc4TqhDRFlSAl3GvnSpkLDgQg7Db6+aWTx9w
	 fEPs37S6oZh0TfQYcYToZZibuZDQgl0MrOH55FilLDXQ4/u7RT3SAzmtkvYiw2v3Pq
	 yjFls2VJ/INoA==
Date: Thu, 7 Dec 2023 13:41:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: enhance timeout kernel log
Message-ID: <ZXIuAZ_mfnW6Ydhm@kbusch-mbp>
References: <20231207183250.2947699-1-kbusch@meta.com>
 <d66d032f-e564-4a76-b9ce-cc09ab94188c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66d032f-e564-4a76-b9ce-cc09ab94188c@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_124141_521319_E87AA478 
X-CRM114-Status: GOOD (  20.68  )
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

On Thu, Dec 07, 2023 at 01:38:04PM -0700, Jens Axboe wrote:
> On 12/7/23 11:32 AM, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Kernel configs don't necessarily have opcode decoding, and some opcodes
> > are not even decodable. It is still interesting for debugging SSD issues
> > to know what opcode is timing out, what request type it came from, and
> > the data size (if applicable).
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/pci.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index fad4cccce745c..49771919b01f1 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1284,6 +1284,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
> >  	struct request *abort_req;
> >  	struct nvme_command cmd = { };
> >  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> > +	u8 opcode;
> >  
> >  	/* If PCI error recovery process is happening, we cannot reset or
> >  	 * the recovery mechanism will surely fail.
> > @@ -1361,11 +1362,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
> >  	cmd.abort.cid = nvme_cid(req);
> >  	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
> >  
> > +	opcode = nvme_req(req)->cmd->common.opcode,
> >  	dev_warn(nvmeq->dev->ctrl.device,
> > -		"I/O %d (%s) QID %d timeout, aborting\n",
> > -		 req->tag,
> > -		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
> > -		 nvmeq->qid);
> > +		 "I/O %d (%s %d) QID %d timeout, aborting req_op:%u size:%u\n",
> > +		 req->tag, nvme_get_opcode_str(opcode), opcode, nvmeq->qid,
> > +		 req_op(req), blk_rq_bytes(req));
> 
> Your additions look good to me, but I do wish that we'd be equally
> verbose on what the other values are. Ala:
> 
> 	I/O tag %d (opcode: %s %d) ...
> 
> would be a lot more useful, for example. I find myself having to dig
> into the source for a specific kernel sometimes when looking at various
> nvme errors, which is really annoying.

That is annoying. I'll add your suggestion in.

