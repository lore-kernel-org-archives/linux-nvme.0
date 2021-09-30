Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E75C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 20:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6515861A35
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 20:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6515861A35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iVRplVxoe0EMwvESaYPHlXBTNp78Fiz+tBwTcqpodqs=; b=Ch53L5YJtzFjeQ
	v+m3MkAvXD0YPvH3ce/nWb8VwhjmC5INRNISAF2z1I7pVZeyn/i2rGs0ajwjo7T3AyeLjrey/1u1V
	SNIilBbx2KF1HuWNgD+7j03ZEl71Q/pnfpw8xyXuxsdpljNWgxNYG5EKGMG0Lfk4klNCFctijw/Dk
	Xd0x8LqRTDqGfOY9Z1Ks/k1rnHsLCGzptHw2/Hcsn0Fh/pi4VV2a3u1X8EDH3IukblSHx10eH88Pi
	3mJjbxzgWJK6kp1DdAc0iXRficFoVLQ4DqihpLwhwEUv4nFfRWMAbppI+25YT5sc7U/wZU+p2G/+H
	lahMfs+jA5a1+2n7RSeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mW2Sa-00FxQ0-B8; Thu, 30 Sep 2021 20:15:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mW2SX-00FxPf-92
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 20:15:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E92161A08;
 Thu, 30 Sep 2021 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633032912;
 bh=/v4wb+KhwWqHypB7i7iVjlbXFY95Zvr884GbnPb0KXE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BsYTIBbSC6K16tHaETbJNjCAgoCwhz3QzsSTtJlkxGjyhPNDjtjw/Mq1Qyy5PQIO5
 MrU2KCoMp5dfVWYYWWJ99lBXcTp+TqTPit9mhiidtSW2R64nHFwYwt1WTOvb7sp0ic
 YhIdUYFwQke8ea4iGnpt/dXYH0MpOfAcxLyAY3iYzzZfwiHVTjkv9up1AcpLnxY83w
 RseFFRO9SINJ+Kvfz3lQ4ilK+5VISGivsGWreKRziXPPPjtB6cC0NdTwqoE8RlLIky
 E3k3S3nUHBpCJ+5D3M2JmR0gSrcWU8shtXIj76/RGJ6F3H5obf9KH49VzL4Vq+6q2X
 MoJeG4unO5QFQ==
Date: Thu, 30 Sep 2021 14:15:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
Message-ID: <20210930201510.GA94540@C02WT3WMHTD6>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210928204052.GA390773@dhcp-10-100-145-180.wdc.com>
 <d969a4b7-4d3c-9df7-5a7d-9700bff37d50@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d969a4b7-4d3c-9df7-5a7d-9700bff37d50@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_131513_365709_FD816A3E 
X-CRM114-Status: GOOD (  29.45  )
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

On Wed, Sep 29, 2021 at 12:00:20AM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/28/21 11:40 PM, Keith Busch wrote:
> > On Tue, Sep 14, 2021 at 06:38:55PM +0300, Sagi Grimberg wrote:
> > > When the controller sends us multiple r2t PDUs in a single
> > > request we need to account for it correctly as our send/recv
> > > context run concurrently (i.e. we get a new r2t with r2t_offset
> > > before we updated our iterator and req->data_sent marker). This
> > > can cause wrong offsets to be sent to the controller.
> > > 
> > > To fix that, we will first know that this may happen only in
> > > the send sequence of the last page, hence we will take
> > > the r2t_offset to the h2c PDU data_offset, and in
> > > nvme_tcp_try_send_data loop, we make sure to increment
> > > the request markers also when we completed a PDU but
> > > we are expecting more r2t PDUs as we still did not send
> > > the entire data of the request.
> > > 
> > > Fixes: 825619b09ad3 ("nvme-tcp: fix possible use-after-completion")
> > > Reported-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
> > > Tested-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > ---
> > > - Keith, can you ask the WD team to test this as well?
> > 
> > I finally have some feedback on testing, and it looks like this patch
> > has created a regression. The testers are observing:
> > 
> >    [Tue Sep 28 02:12:55 2021] nvme nvme6: req 3 r2t len 8192 exceeded data len 8192 (4096 sent)
> >    [Tue Sep 28 02:12:55 2021] nvme nvme6: receive failed:  -71
> >    [Tue Sep 28 02:12:55 2021] nvme nvme6: starting error recovery
> > 
> > Which we had seen before, and you fixed with commit:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=825619b09ad351894d2c6fb6705f5b3711d145c7
> > 
> > I only just recently heard about this, so I haven't looked into any
> > additional possible cause for this regression yet, but just wanted to
> > let you know earlier.
> 
> Yes I definitely see the bug... Damn it..
> 
> The issue here is that we peek at req->data_sent and req->data_len
> after the last send, but by then the request may have completed
> and these members were overwritten by a new execution of the
> request.
> 
> We really should make sure that we record these before we perform
> the network send to avoid this race.
> 
> Can you guys check that this restores the correct behavior?

Unfortunately this was unsuccessful. The same issue is still occuring. Please
let me know if you have another patch to try. I'll also keep looking for a
solution as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
