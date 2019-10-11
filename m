Return-Path: <SRS0=FTT0=YE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB6ECE58C
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2019 16:27:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD630206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2019 16:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hq3keNXk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUhW5xYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD630206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LFp3EOQ9ywMucaL0ZA9gVqJq4e8OnrhZMqcZFBGuR1I=; b=hq3keNXkGWp36u
	p/G5yda7ImgKkTh6qpnSNG8J/BlOcDOBIiw7QcFpKt2pnBSmndxzVcX+zWaMkEGIOYShID6msZuk2
	/F62OyJ157JQVn1rgEnZvpMHQY1nPQ5E1/q6s0eOiZuE7h9rPjl+57upmq+hU4Vj4RerJPu9Z2oXI
	xpFT4SPpou9aSlymplFH+jhrSOvLV/0M3cfRuWrSuVqaLqHT2d30wpvXLpasZCUR2UO5e5fBtGZe1
	tlTwhQ8YNV508pI1X/vafroQJ5Epcl8c0oMzckJ0MDXRgM/+lcjTvG8+f+cHafWtO5ynJJusUw+2H
	Y/fp01jve6ozL11XklFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIxlI-00073t-31; Fri, 11 Oct 2019 16:27:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIxlF-00073G-2J
 for linux-nvme@lists.infradead.org; Fri, 11 Oct 2019 16:27:26 +0000
Received: from C02WT3WMHTD6.wdl.wdc.com (unknown [199.255.45.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8628F206A1;
 Fri, 11 Oct 2019 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570811240;
 bh=tmp9ua/qCr1uT3pCwrIoZ+/OWUgw6c+anmB4plpE57Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nUhW5xYFPBgH/eIpGlc28m+okEQRv91DxkYJWffEQDIpUY9S+c/W5GmyMxICwePMH
 GJlqQqlcMCWaGNAhOieuthTSxQkjnYAKjRq9FQ5l3kg+WMjOJETX90cYKpaXe0NDHb
 MpOhFLN+8w/0ZeSZtieRXLUN/oTrsy0ExRk4Oe7M=
Date: Fri, 11 Oct 2019 10:27:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Subject: Re: [PATCHv4 0/5] nvme: double reset prevention
Message-ID: <20191011162714.GB75437@C02WT3WMHTD6.wdl.wdc.com>
References: <20191010165736.12081-1-kbusch@kernel.org>
 <12fd3758-ff71-c02d-1545-5ce8189c2c59@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12fd3758-ff71-c02d-1545-5ce8189c2c59@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191011_092725_128797_3701B413 
X-CRM114-Status: GOOD (  16.28  )
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
Cc: James Smart <james.smart@broadcom.com>, Judy Brock <judy.brock@samsung.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 11, 2019 at 09:58:52AM -0600, Nadolski, Edmund wrote:
> On 10/10/2019 10:57 AM, Keith Busch wrote:
> > The main objective of this series is to prevent double resets. This sort
> > of thing is known to have happened if a timeout occurs at roughly the
> > same time as a user intiated reset, like through through PCIe's FLR.
> > 
> > The double reset could happen because the controller disabling had been
> > occuring outside of the RESETTING state when we can't schedule the
> > reset_work, which is to occur later. When another reset schedules in
> > between these events, the controller ends up in the wrong state.
> > 
> > The end result of this series is simply to block subsequent resets by
> > initializing the controller state to RESETTING without actually scheduling
> > the reset_work.
> > 
> > v3 -> v4:
> > 
> >    Renamed nvme_reset_schedule() to nvme_try_sched_reset_work() and
> >    documented when it may fail (hot remove). I'm open to suggestions for
> >    a better name.
> > 
> > Keith Busch (5):
> >    nvme-pci: Free tagset if no IO queues
> >    nvme: Remove ADMIN_ONLY state
> >    nvme: Restart request timers in resetting state
> >    nvme: Prevent resets during paused controller state
> >    nvme: Wait for reset state when required
> > 
> >   drivers/nvme/host/core.c    | 91 +++++++++++++++++++++++++++----------
> >   drivers/nvme/host/fabrics.h |  3 +-
> >   drivers/nvme/host/nvme.h    |  5 +-
> >   drivers/nvme/host/pci.c     | 78 ++++++++++++++++++-------------
> >   drivers/nvme/host/rdma.c    |  8 ++++
> >   drivers/nvme/host/tcp.c     |  8 ++++
> >   6 files changed, 134 insertions(+), 59 deletions(-)
> > 
> 
> Tested-by: Edmund Nadolski <edmund.nadolski@intel.com>

Thanks, Ed.

Christoph, any remaining concerns on this? If no, do you prefer I push
this to 5.5 or 5.4? This fixings reported bugs, but it ended up a bit
larger and later than I originally hoped, so I'm okay either way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
