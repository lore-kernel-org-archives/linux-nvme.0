Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D036BC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8X7Kvg1RLyBFPKW42kaS/rpzOPZ8cxfXuK4VuAbewHw=; b=WwQViaNjOx75bHPMNstV6n8W8I
	Gec9x2PczElRnHIFZvvc1IkEw5TcOo3YSFRyRLmQHiDDUUwm1+souQHuhG2afVnijKD5/f0WmOjdW
	tniTTE2XR3B7UkwyLxtgkqO1zZyiguBRIK9WVEj3TpuGU/AtDp5roCG8iAHPkSZNIbEzm3przdQhL
	G7ia9iAfSYeOsmqrhBXEbxNm92ABEq85ykffH1Y4YkIg5Dv4Oc2mHBD/D+IEytNo0ma4tuHJFgCPj
	vkiydikOFQObkiUqDnb4tJKd5z+Vb0wAfUQtVfBRSx99OnvAqTazrI+EHwdcdGjdfYDMPvlGnMgXJ
	YlV/ueIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olZQ1-000sdi-MQ; Thu, 20 Oct 2022 17:33:21 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olZPy-000scI-Cl
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 17:33:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id F4051B828A1;
	Thu, 20 Oct 2022 17:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40DCC433D6;
	Thu, 20 Oct 2022 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666287195;
	bh=MjfXHu4FwW4pFzBtnl6lMUktQ3H3soNGx30H6Dzd9Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zq4ZAAabNJscRP66mSuU8O63pzSvwwB97XEfaNo0Ni9noqKWNMsVWimqlIT2yIEEQ
	 NBF/nDgJ/d5km1glw51d8h07wstKtW99U3/ReZfC/5xwukeX8uSa0O073zMt3zptdo
	 sowmWhhZRAl6RcZy9TsPv1qPO4b7S6+BrOaJ1eiyBBUJeHa7HtHwE0dpnD0pi6a9OF
	 8/T1nUtD0N6YHZnZdXcKDN9wPzKfgB4sGwUvWOKrv2VmZmucBjiMF5VVAtOr61oqS6
	 URBwHj2E0UAhqs37apsDLDepxXrOniBQIO6D4VuD15xRav5c7G7SCh78o/074XBFsW
	 1SEV8vX9WlIww==
Date: Thu, 20 Oct 2022 11:33:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Ken Lin <ken_lin5@hotmail.com>, LKML <linux-kernel@vger.kernel.org>,
	michael.jao@quanta.corp-partner.google.com, derekhuang@google.com,
	chi-jen.chen@quanta.corp-partner.google.com,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/1] nvme-pci: disable write zeros support on WD SSDs
Message-ID: <Y1GGWOzAvZe4tj/d@kbusch-mbp.dhcp.thefacebook.com>
References: <20221014083058.1451914-1-ken_lin5@hotmail.com>
 <TYAPR03MB3085DD9F15177F126E9DF7C6AE249@TYAPR03MB3085.apcprd03.prod.outlook.com>
 <CAD=FV=WH9N4Vx6e7Qr8q1fxsTRh=1kHBcg5RuWxOmruJEvr4kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WH9N4Vx6e7Qr8q1fxsTRh=1kHBcg5RuWxOmruJEvr4kw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_103318_606761_C5949F5A 
X-CRM114-Status: GOOD (  25.23  )
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

On Thu, Oct 20, 2022 at 10:15:56AM -0700, Doug Anderson wrote:
> On Fri, Oct 14, 2022 at 1:32 AM Ken Lin <ken_lin5@hotmail.com> wrote:
> >
> > Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> > Write Zeroes command"), Western Digital has the same issue:
> > [ 6305.633887] blk_update_request: operation not supported error,
> > dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES)
> > flags 0x0 phys_seg 0 prio class 0
> >
> > So also disable Write Zeroes command on Western Digital.
> >
> > Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
> > ---
> >
> >  drivers/nvme/host/pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 3a1c37f32f30..5c1b812a3c2b 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3517,6 +3517,8 @@ static const struct pci_device_id nvme_id_table[] = {
> >                 .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> >         { PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
> >                 .driver_data = NVME_QUIRK_BOGUS_NID, },
> > +       { PCI_DEVICE(0x15b7, 0x501e),   /* Sandisk 2280 NVMe SSD  */
> > +               .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> 
> So I'm not really an expert and don't really have the context, but you
> CCed me and so I took a quick glance.
> 
> Something smells a little fishy. ${SUBJECT} talks about disabling
> "write zeros". The patch description talks about disabling "Write
> Zeroes". The patch you reference seems to disable "write zeros" by
> setting the quirk NVME_QUIRK_DISABLE_WRITE_ZEROES. ...but the contents
> of your patch doesn't seem to match. Instead it adds the quirk
> NVME_QUIRK_NO_DEEPEST_PS.
> 
> As I said, I'm not an expert and maybe everyone will tell me that it
> all makes sense, but it seems weird.

You're right: this patch does not make sense with the subject!

