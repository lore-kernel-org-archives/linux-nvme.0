Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B0CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XLQ8mMO0hzeJi8rzxsf9luStKEDEI8Zafy1QgR2AB2A=; b=G9pjtdTfVBqrjFCj+8Hbl3eIP1
	yrUNuiLUrN7EWFEN1ObtwTIxyyAfJr1L8gIpP7L3R0gK8XqSALbB9ylDTPU3w8dp+cx2h+nhDNVAg
	Dy0aWtIzjOHVq3y/TDkgyyjR3U6qYCxUNOnGrjzBiIOAW1BphzoGjDkisbS2RkruwmNUSuG0oAn3Z
	bJ18wCnDgiwnrgjFGK5BQFFoiijs/5abJ0dx5Ky+E9eW6VRVNAz6WxZR+CNy5bFJqm3SgaIWIldgL
	UtFD/rAEtiz4PG6CEC5lKS0stmWaQ8S8HIkdobZACOXOji4wO30J3zdynvLBJROE/McLNauk3p86q
	ZJXFkXDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzEdJ-000i7e-8C; Thu, 09 Jun 2022 09:39:17 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzEd1-000hvk-2D
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 09:39:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A9E43B82C8B;
	Thu,  9 Jun 2022 09:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CE7C34114;
	Thu,  9 Jun 2022 09:38:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KWO6SD/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1654767533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLQ8mMO0hzeJi8rzxsf9luStKEDEI8Zafy1QgR2AB2A=;
	b=KWO6SD/+lFHS9/dt8B1qD6KGi1uc18TwUSdHr8x8fDXwydBzf8WzB7SrX2t2wQPHZ7u2ig
	AwGmSU7A2YIpKbZTIRhmrT/3mDj0D/9tuVIaUYdc8zhps4iSGZJu9jUPR+h8IrTQYzwMxl
	vU6uRNynWcY3WJIJnd5zo7rUxOPcgHc=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6f35694 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
	Thu, 9 Jun 2022 09:38:53 +0000 (UTC)
Date: Thu, 9 Jun 2022 11:38:47 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "R, Monish Kumar" <monish.kumar.r@intel.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	"Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <YqG/pybFg0P5yQ9a@zx2c4.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_023859_575716_2B63F742 
X-CRM114-Status: GOOD (  18.97  )
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

Hi Monish,

On Thu, Jun 09, 2022 at 09:32:02AM +0000, R, Monish Kumar wrote:
> Hi Jason,
> 
> I would like to provide justification for this Samsung X5 SSD fix added.
> We were facing SSD enumeration issue after cold / warm reboot with device 
> connected ends up with probe failures.
> 
> When I debug on this issue, I could find that this device was not enumerating 
> once the system got booted. Moreover, we were facing this enumeration issue
> specific to this device. 
> 
> Based on analysis, due to deep power state of the device fails to enumerate.
> So, added the following quirks as a workaround fixe and it helps to enumerate the device after cold/warm reboot. If new Samsung X5 SSD's are working fine as expected, we can remove those 
> fix. 

FWIW, all of that should have been in the commit message. Also, "based
on analysis" - what analysis exactly? I have no way of thinking more
about the issue at hand other than, "Monish said things are like this in
a lab".

In any case, I believe the 970 ID predates that of the X5, and
destroying battery on those laptops and introducing boot time delays
isn't really okay. So let's just revert this until somebody can work out
better how to differentiate drives that need a quirk from drives that
don't need a quirk.

I sent this in: https://lore.kernel.org/lkml/20220609084051.4445-1-Jason@zx2c4.com/

Jason

