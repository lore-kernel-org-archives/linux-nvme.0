Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C465EC5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3VkCFKbjNrLwtouWIDw6GDDltxVMuQbx8wqFyQI/v70=; b=WMUn3yFkS8miX2SQxLgQ1acGf+
	6itCoQuNbisxEaC2uwel2DKfIGEaPdKiFIjLwH6+HN0drWPNSI2o4gemEW4/0lOz5OL1sPALqYjop
	G9sbnlDTIVExLrqkrTn+xDpLDdSojO7pjGnOP6kHLxsf8MGECyCg1gY807W/Aa7PeYKgJoblbBeoE
	taX76hwxUWCN3aR17Avd4beTmE+HBT/sfGo8WepjRxE5eCiBdKABjQfXNE+xkvu5Cb2epztKgKiP0
	qYBdgs9uMkUlyoRwfTOjNAHN94Z9nxm8IO4beccBnO/6A5P91SlhCNjb8y20Bx/KDYzP/qejX5QIo
	G4SvhwSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9uT-0000000GO4w-2GaL;
	Wed, 12 Aug 2026 14:26:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9uT-0000000GO4k-0GK5
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 14:26:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 81E5343C77;
	Wed, 12 Aug 2026 14:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C1B1F00A3A;
	Wed, 12 Aug 2026 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544784;
	bh=3VkCFKbjNrLwtouWIDw6GDDltxVMuQbx8wqFyQI/v70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JqtsOa2B4VPG1FkfPJ3TDaHzRNuVQrQ1ZFLDuvuD8ngFDSfrvEFIjGPDGzNE2+Be7
	 oSQ3DoM+B3H9OXQnTcCZvA1+kI6+jjsIXfVlj99KxzJvK0g0g2O2Vu1OFmmKh2afvm
	 u5iRy48Yo5VXl6iiMI1swbx3n7oNCqmWzfiu7qCokQ33WOweS972hDVDhPkOKUXC5p
	 AVLFwuj9pChaqwB6qL6KdGvuJPE3PLzHTrRdd4MjI7CIpEFn/ijZqTqdHCQND97izh
	 0wwj1v/EwpysQIU3qtmgdfLa6KucPoWCtreBza1HvakEn+hSqsLZzBHm+02LslPBxt
	 +xrpcLhlEQBtw==
Date: Wed, 12 Aug 2026 16:26:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <anyCi32WjlR0hyeC@ryzen>
References: <ansfMnm1WntoQRi_@ryzen>
 <20260812105941.55577-1-rihyeon8648@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812105941.55577-1-rihyeon8648@gmail.com>
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

On Wed, Aug 12, 2026 at 07:59:41PM +0900, Rihyeon Kim wrote:
> Hello,
> 
> Thanks for the suggestion.
> 
> > Wouldn't a nicer fix be to change nvme_fc_ctrl_free() to look more like
> > nvme_tcp_ctrl_free(), i.e. something like:
> >
> > +       if (list_empty(&ctrl->ctrl_list))
> > +               goto free_ctrl;
> 
> I am not sure whether that would work, and I may well be missing
> something.  From what I could tell, nvme_tcp_create_ctrl() does its
> list_add_tail() last, while nvme_fc_init_ctrl() does it before the
> nvme_change_ctrl_state() and queue_delayed_work() checks, so on those two
> failure paths the controller is already on the list and opts would end up
> freed twice again.  The early goto would also skip the ida_free(),
> put_device() and nvme_fc_rport_put() for what nvme_fc_alloc_ctrl() takes
> before the list_add.

The fact that both rdma.c and tcp.c does:
1) if (list_empty(ctrl_list)) goto free_ctrl;
2) call list_add() last (after nvme_change_ctrl_state())
3) not have any ctrl->ctrl.opts = NULL; hacks anywhere in them

suggests to me that a proper design would be for the fc.c driver to look
the same as rdma.c and tcp.c.

I'm not familiar with fc.c, but I can imagine that the goto free_ctrl label
can be placed such that ida_free() (and whatever else needs to be called)
is done so after the free_ctrl label, while nvmf_free_options() is done
before the free_ctrl label.

But sure, I agree that such a change would have to be done by someone
familiar with the fc.c driver.


> 
> Keith suggested moving the existing clear from fail_ctrl: down to
> out_put_ctrl: instead, so I will send that as v2.

Looking at the Sashiko comment:
https://sashiko.dev/#/patchset/20260811125310.165487-1-rihyeon8648%40gmail.com

"Will setting ctrl->opts to NULL here cause a guaranteed NULL pointer
dereference during teardown if DHCHAP authentication is configured?"

makes me even more certain that it is wrong for fc.c to have a
ctrl->ctrl.opts = NULL; before calling nvme_put_ctrl().

The nvme_put_ctrl() call will lead to a call to nvme_free_ctrl(), which will
call e.g. nvme_auth_free(), before calling the ctrl->ops->free_ctrl(ctrl);
callback. So some existing teardown functions in nvme_free_ctrl() expects opts
to be valid/non-NULL, and that the it should be freed earliest by the
ctrl->ops->free_ctrl(ctrl) callback, and for all other fabrics (rdma, fc),
this appears to be true.

Note that the same Sashiko link also reports a sysfs NULL pointer dereference
that is possible by the ctrl->ctrl.opts = NULL;

To me, it seems like fc.c should simply look more like tcp.c and fc.c.

That way:
1) No ctrl->ctrl.opts = NULL; hack needed in fc.c.
2) The sysfs NULL pointer dereference is no longer possible.
3) Teardown functions called by nvme_free_ctrl() can continue to assume that
   ctrl->opts is valid.

Perhaps some of the fc.c maintainers could have a look?


Kind regards,
Niklas

