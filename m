Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2D0C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZuJT/rXxMO+rFin6cO3ross2CDOAzrxXELXwsUyecL4=; b=lXuzeOqBqh9uNIdcv98h6/3+MO
	2nb6GdhPYS9l2CWtaxYg4mZUw8iQSUUcegaarJeKcIbWbNk/fb4ZZwQRfJb7qqBMAXzezMH5LcGOh
	IdPpFXeUoamkfGEVbJjpyM5519+y+83XKUzYY6xrJWZ6bc3q6Hp9KaPUH7G8VWGTxDH4ghopVUTjG
	vFwBxxF2oJos5gOAnAfZjqbBhq21qSKS/5O3N6qO3TJVMw220O86vMRPJS9aDElchzhMZNkLbGbiq
	9Ucb/2kybuXNH9RQLGoLWkrh9VDBQNFUMK+xb0whFFhhojfWRug9Elxv12JsOnQepeWat6wNQ0twb
	RJ6mxJJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSMkU-00DdZM-Hv; Thu, 10 Mar 2022 17:38:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSMkO-00DdY6-PH
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 17:38:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5E6C360A29;
 Thu, 10 Mar 2022 17:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C38C340E9;
 Thu, 10 Mar 2022 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646933923;
 bh=TZtGNlnMeKYZYZnr+kEz+Draosjjn4Tc54E1cha+evo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gD5jy26UZZLT/wEM6AhsXBnZ2T36gah7xQ8omL65PG5t4X4iZZFTv5zLRM6HYPXDa
 3KLTC2pec/gt/HpiSO2SnNOA5+RwpZy6+SdMzqq7HNitoCMkOhBZ20UBJgYPpBRJ2c
 aVH6EPBahbzNjtjjEbhGC5geqAPv5e2bWAPjj0mZzDMRg8bdaRjbF/DbFMSk6E+CWC
 cX095V6EWijGuGG+ap07USohGL12sDk9xHLuiziN1gtGJE+4vpMDaI2pGQt+J+7EW7
 nm7X6XsygZvoFIGu8r8Tu+rsEm687M5kT7H6yKuuT9Toj4wJCMMSTjsgQ6qmZTimUF
 TRq+C79t+0r8Q==
Date: Thu, 10 Mar 2022 09:38:41 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, Sagi Grimberg <sagi@grimberg.me>,
 Ming Lei <minlei@redhat.com>
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220310173841.GC329710@dhcp-10-100-145-180.wdc.com>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220309062630.GA31508@lst.de>
 <20220309162303.GB3949054@dhcp-10-100-145-180.wdc.com>
 <20220310160359.GA3733@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310160359.GA3733@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_093844_881905_CFAD8CF0 
X-CRM114-Status: GOOD (  20.51  )
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

On Thu, Mar 10, 2022 at 05:04:00PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 09, 2022 at 08:23:03AM -0800, Keith Busch wrote:
> > > Combination of a broken application (does what the spec explicitly
> > > tells it not do) and broken hardware (does the most stupid thing when
> > > fed invalid input), not much the driver can do here.
> > 
> > There's nothing the hardware can do either to know it was given invalid
> > input here if PRP2 is page aligned. There's no way it can tell the
> > difference between a PRP List vs PRP destination.
> 
> Well, it can know that there must be at most two PRP2 for Identify when
> the MPS is set to 4k.  Yes, this is annoying especially with hardware
> allerated frontends, but that's what you get for that stupid globally
> harmful microptimization that PRPs are.

Yep. If the host is purposufully tricked into making a PRP list when the
real payload didn't need it, the device will think PRP2 is the
destination buffer and corrupt that memory, and it's not the device's
fault. 

I agree the optimization was not worth the trouble it inflicted.

I don't believe it's the driver's responsibility either, though, and am
completely against the driver providing any sanity checks for broken
apps as Ming advocated. It is a maintenance nightmare and doomed for
failure. Just one example: 1.0's 'Get Log Page' said no PRP lists
allowed, so an older driver enforcing that would have crippled 1.1+
devices.

The app must own the responsibility for using the interface correctly.

