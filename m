Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775FC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 21:55:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7105C61A1E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 21:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7105C61A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tbfUKk+SWXXCHBUTB7rSsr1yU4RAl0PB1PXJrQFWnZw=; b=I2BYAsw1u8kt/rTYqeYja4drm
	z0Vu6MJszt6Q4tYOxYnzw/Y/4vWuJORuJlmFA1MGPMaj4Q2nCtCSJsLXLClYRb/an8Ll7ThIW7NN2
	RtvyB6Z9Nq6o0xlTms73/XplYC/k8dfVRF3iQnsaZucU3lbvz4Dq8BmCeEgK9raLP/JLQ6ZLtJ+jw
	ihIKFxKkgpNwrfY8MIKGqkxFUyY17y1LjZcD8HipoLPcgcUuBoesfD9HAiOIgeKZCZgcawzaBMq2W
	cbvVqZ/vBK1UdysAf2nBnVA/RguxcXU9mzvuOMEiwl7RcpF/zdkn3nnBWM8pdfhTpnnjoGkMdG0jB
	IogkWY4PQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPXw9-002FdE-Sc; Thu, 25 Mar 2021 21:54:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPXw4-002Fcj-An
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 21:54:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10A2F61A1E;
 Thu, 25 Mar 2021 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616709274;
 bh=3ncias+M1a4vuMRF0WOSKH16HKDL6QwYIbHsNqkuSAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uKqmPtjvIrJriIm2MLWIw69SZmycA0TUC1LY0ZRpIBRqizLaMm4zk/dB0+o4vMZDw
 a2dW3jZHZY1xbl4cep+JarafXXhB3IDNpxO8PuWumC6AOvCAHLwkfGwWejvS5Eo4Kq
 Yg4Fn/sXlJbytTWT2PkmzXYxcmKTrOimh2hlUrKBW3InTdEsgiQ146HF/ZjBp2WKYE
 PVuG5MKY/oiTyBUGYB99yz70xBEd9ikDBwJQQgonIsRYbRhnC56smhtVO6oQVWvfvO
 3cuI8jOOMXOgQXHqII9Lxe1/cq7gOxJeiHZ4Qs8jKNI7kfbZjw731SR/5fNdE6ykZt
 VS+2aHqtSbtoQ==
Date: Fri, 26 Mar 2021 06:54:27 +0900
From: Keith Busch <kbusch@kernel.org>
To: "George, Martin" <Martin.George@netapp.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 hare <hare@suse.de>, "Meneghini, John" <John.Meneghini@netapp.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
Message-ID: <20210325215427.GB32286@redsun51.ssa.fujisawa.hgst.com>
References: <20201205152901.56665-1-hare@suse.de>
 <cbfc78e1-87be-cc09-9b8d-44bf0659eb26@grimberg.me>
 <92763a7271a1eb07e28901e3e91345568202eda3.camel@netapp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92763a7271a1eb07e28901e3e91345568202eda3.camel@netapp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_215436_716467_0E7E8DF8 
X-CRM114-Status: GOOD (  28.64  )
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

On Thu, Mar 25, 2021 at 10:55:51AM +0000, George, Martin wrote:
> On Wed, 2021-01-13 at 19:13 -0800, Sagi Grimberg wrote:
> > 
> > > If ANA is enabled but no ANA group descriptor is found when
> > > creating
> > > a new namespace the ANA log is most likely out of date, so trigger
> > > a re-read. The namespace will be tagged with the NS_ANA_PENDING
> > > flag
> > > to exclude it from path selection until the ANA log has been re-
> > > read.
> > > 
> > > Reported-by: Martin George <marting@netapp.com>
> > > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > > ---
> > >   drivers/nvme/host/multipath.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/nvme/host/multipath.c
> > > b/drivers/nvme/host/multipath.c
> > > index 74896be40c17..ee4a42dc99a0 100644
> > > --- a/drivers/nvme/host/multipath.c
> > > +++ b/drivers/nvme/host/multipath.c
> > > @@ -667,6 +667,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns,
> > > struct nvme_id_ns *id)
> > >               if (desc.state) {
> > >                       /* found the group desc: update */
> > >                       nvme_update_ns_ana_state(&desc, ns);
> > > +             } else {
> > > +                     /* group desc not found: trigger a re-read */
> > > +                     set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> > > +                     queue_work(nvme_wq, &ns->ctrl->ana_work);
> > 
> > btw, I just commented on the original thread, but I do like this
> > one better.
> > 
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > 
> 
> We now have a ratified ECN which clarifies that a NVME_AEN_CFG_NS_ATTR
> is sufficient for announcing a new namespace along with a new ANA
> group, as opposed to additionally raising a NVME_AEN_CFG_ANA_CHANGE as
> well for the latter - available at 
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-ECN.zip
> . I hope that finally clears the confusion on this topic.
> 
> So could we now have this patch pulled in please?

Yeah, I was fine with the patch initiailly since it is harmless and
provides higher tolerance to unclear behavior. The ECN essentially
requires this patch now, so again:

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
