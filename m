Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD9EC369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JxGOkAbVdmj7AmHw1DY9h8eefv02QpbrHu8t7QJiRLw=; b=m6WLqzi6CBK2b6JC1HQoxR5326
	OK+zTgGJbd73a7d3SyotUjXsaA0LUwJ4SjULvJcGdY32sany2POX9sDFN2p6q2zDXhmnRD0N6DY0J
	b8cycOEEyw5zrBhIenzNsdlSVzWnJFAppFGmgnwkzS2tikyR/6nz0mL23JMNXzHyX8hiqlA/nopqp
	aK08fyqzAo82Bgq7+e4/VP3ATp1Z+Np7f/4dZ94Fzk8/lOHkmQaud1tln3Ih4ZuVRJI5JQZ8Jdqke
	KDmkPMz4sJHb6uLWioDI5RmvTU+teQULHgikCdDRrj+DSGYKkayqH0iMon+fpQVPPX19h0ShHn1+J
	bGeKJHwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4O57-000000031b5-45Tk;
	Mon, 14 Apr 2025 17:58:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4O55-000000031ac-33sv
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 17:58:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 11DAEA4A146;
	Mon, 14 Apr 2025 17:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF146C4CEE5;
	Mon, 14 Apr 2025 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744653530;
	bh=ZNn/kiHP/e/f8CiGEnI1Fw0s3hL8+dt9l/8Au/xM5e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDbazaS+q2HUAODMV5Gc7jLhEzKMq7OdU/p9DY+T7sQykbFUUyhzMSy0H3i1uAtVX
	 xXziXzESTt9w4TWbD8fK64t20pppd+K7XSzAnt6f+YxS6ezv0HRQVV8BdCzsRk02S2
	 QcEKUIs73ijWvLY4hnGw3z3r78lFUcmRObOzW4pS032rRIDUtQNp/cAWa1cA84Qhg3
	 F1Bwg9tsW55L2pBoP3zTLf5iQHfS21Iq7vA0sh5V1Q78WpHBytDajImBkCPx1viMU4
	 /FXAwrrtSn0hnEfVbxzYZ5JbA1o1QNxKxGJ+hYHYSQruSs5uyUrK59Y/2S+VIthxAC
	 MpdAr/LHWcLuA==
Date: Mon, 14 Apr 2025 11:58:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] nvmet: pci-epf: Clear CC and CSTS when disabling the
 controller
Message-ID: <Z_1M0VrD1STfeGjP@kbusch-mbp.dhcp.thefacebook.com>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-3-dlemoal@kernel.org>
 <Z_eCmfXXjmarMnQl@kbusch-mbp>
 <e1337822-e0d4-43b6-8fdf-8df521f23cae@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1337822-e0d4-43b6-8fdf-8df521f23cae@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_105851_830299_A992C1B6 
X-CRM114-Status: GOOD (  22.98  )
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

On Fri, Apr 11, 2025 at 09:32:53AM +0900, Damien Le Moal wrote:
> On 4/10/25 17:34, Keith Busch wrote:
> > On Tue, Apr 08, 2025 at 11:47:32AM +0900, Damien Le Moal wrote:
> >> @@ -1895,6 +1912,11 @@ static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
> >>  	nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
> >>  
> >>  	ctrl->csts &= ~NVME_CSTS_RDY;
> >> +	if (shutdown) {
> >> +		ctrl->csts |= NVME_CSTS_SHST_CMPLT;
> >> +		ctrl->cc &= ~NVME_CC_ENABLE;
> >> +		nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
> >> +	}
> >>  }
> > 
> > I think this is probably okay, but I don't know if it's necessary to be
> > messing with CC.EN that the host didn't request. The qemu emulated nvme
> > doesn't do this, at least. But it looks like that would all work out in
> > the end anyway, so again, I think it's fine.
> 
> Maybe qemu clears/resets all the registers of the BAR when it does a shutdown ?
> I did not check the code. But here, if we do not clear EN, *and* the host does
> not first disable the controller before trying to re-enable it (like the linux
> host pci driver does), after the shutdown, we fail to detect that the host set
> EN again since we can only detect that by polling and comparing to the previous
> value.

The spec has some text explaining the host needs to handle a shutdown
controller with CC.EN set in section 3.6.1:

  To start executing commands on the controller after that controller
  reports controller shutdown processing complete (...) utilizing the
  CC.EN bit:

    o if the CC.EN bit is set to `1´, then a Controller Level Reset is
      required to clear the CC.EN bit to `0´ on that controller and the
      CC.EN bit is subsequently required to be set to `1´ as part of the
      initialization sequence 


So I guess some hosts just aren't handling this? No biggie, linux will
react accordingly either way.

I didn't find anything that requires a shutdown controller retain CC.EN,
so clearing it on the condition is probably fine. I never really fully
understood why a disabled vs shutdown-ready controller needed such
distinctions anyway.

