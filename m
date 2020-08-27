Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B2DC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:01:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0652620678
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KhWXCsPl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhJ18CJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0652620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y/IPzPdOPPqVOqtzsFlNc9Jvrk0ji8b0bKAs/8/HgLQ=; b=KhWXCsPlPreF30b+Mig237icr
	cOxojthItlvXQBaydI4j4jcPfcN/Nb0dQMiQmh2wl41T4uicLNHYkk7fgGJpug0V0sGhPTJG+LW8H
	QgEmjdLkG6o9aB80HxNFog1iG/z8qWdIgfL1VrLvoxbswKyZ1ELbHExBD+pWTCNVnFL177X1PuenK
	Y73M9JoEXOJnwQVIXBY2ZWrTK3rQOtOufzQLOajHFp6WccKBpSmUucYUEx3Ix0KoF4DmWkQ/ou+HC
	u3mp77/9OIq1bMykhzU+iFDS+72/Hwb2sFphU72pZN6v+uY5ayyHl5MjG23CVNsnvLJu4YuvvtzIv
	iN4EMuVRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBJOo-0001G8-56; Thu, 27 Aug 2020 15:01:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBJOl-0001FL-6p
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 15:01:07 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 795FF20678;
 Thu, 27 Aug 2020 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598540465;
 bh=+jRn5/x2Cn9B+Uaw6OdWSzuUG6h+1XhekMjRvXwB/A8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uhJ18CJrnJ/EmIyJpAKkfxLSGytmtwE8i/Dy00KjqNwutiVCjU8cWA5ZgGb67DqFL
 MRxkUOzM/nNTaQwSDU813rHNnEa3IzGGihph/X0nLvOc+Ik+iVuH58Vh7eH8R/I+YP
 pCiZqrMF6RKnCK4KnNjSBytesfTocPeEEQpnzO+4=
Date: Thu, 27 Aug 2020 08:01:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
 <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CtnNgZDpT-8Wiwvs18-h4fmxv3jPmW4AqWXgT-BqNLYw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA5qM4CtnNgZDpT-8Wiwvs18-h4fmxv3jPmW4AqWXgT-BqNLYw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_110107_342837_BC4FB9A3 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2020 at 12:11:56PM -0400, Tong Zhang wrote:
> On Fri, Aug 14, 2020 at 11:42 AM Keith Busch <kbusch@kernel.org> wrote:
> > > > On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > > index ba725ae47305..c4f1ce0ee1e3 100644
> > > > > --- a/drivers/nvme/host/pci.c
> > > > > +++ b/drivers/nvme/host/pci.c
> > > > > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> > > > >               dev_warn_ratelimited(dev->ctrl.device,
> > > > >                        "I/O %d QID %d timeout, disable controller\n",
> > > > >                        req->tag, nvmeq->qid);
> > > > > -             nvme_dev_disable(dev, true);
> > > > >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > > > > +             nvme_dev_disable(dev, true);
> > > > >               return BLK_EH_DONE;
> 
> > anymore. The driver is not reporting   non-response back for all
> > cancelled requests, and that is probably not what we should be doing.
> 
> OK, thanks for the explanation. I think the bottom line here is to let the
> probe function know and stop proceeding when there's an error.
> I also don't see an obvious reason to set NVME_REQ_CANCELLED
> after nvme_dev_disable(dev, true).

The flag was set after disabling when it didn't happen to matter: the
block layer had a complicated timeout scheme that didn't actually
complete the request until the timeout handler returned, so the flag set
where it is was 'ok'. That's clearly not the case anymore, so yes, I
think we do need your patch.

There is one case you are missing, though:

---
@@ -1267,10 +1267,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
+		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
 
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	}
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
