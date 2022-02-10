Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A044C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bADiQVPs362Kw43hvObHyexcjp2X/vnA2kTvuVlh1PI=; b=xuE0cTfyRsWKb1RQX5qo9Bkh0e
	NlwM6mnVBE6NfLtgcHC5+Fmv0V6kQRX5uER/neBd02/1YSWs6PI7PXz0NSYXRMDKqOxHt5aD0jHGH
	zU4j851DM6IksnSyDwoKAe6kNrwNnnJ54M9Y5ohbFdxax1wV1Ny55bXywjKZefKzqVoLEX7vba7G2
	awkLt5aC7os4RoaLasdEDow/5V7GZCWjIPeMZtKHoV06X8Bsaj90ig2jVd80pGyJMbTHg0wiSMdg+
	MhoLY2vcFZVZDylEeXqsiqLeHZ7vsJXle2XCoJFD7yRP4Hx4kouuasY0P03j6U0oryLOueTk91CeF
	fheJ9/Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIEaU-004gLG-1f; Thu, 10 Feb 2022 18:54:38 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIEaQ-004gJw-OO
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 18:54:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 436CBB82717;
 Thu, 10 Feb 2022 18:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E112C004E1;
 Thu, 10 Feb 2022 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644519272;
 bh=cJZMxTErs9pjcy2gQC8c6spFkWFZsvMX5ljqxIN6Or0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sR+cpFkta7JODYHVPFIsfrZrWtOsb8GI9mYFBMjDzH5XOHyasIWfqkDTsinc5TFnQ
 bhNBTFlgszBDGuZK0KqMAz3fHLFpb7gi9vjcoNcNEwk0dShcSLIX/T4AY+upT8M/HH
 kWzGim7Nw1RsK+c5dMgqPoXqH/3XVHtIRwOB7cNAfPez3JmDY+uU+XDQo20lTEuLP5
 iHzExPp2WRAeuvi/shfi/Z6PlXcGvHxJjNTSpinlN/rMpvoe4yeCVYLjQ3oOMstwSr
 y51pcQXVW/te9c5FuJSwF0wdyVZyfzAraMvX4D5O2qv91iVG/JFJ+Hmqvj3v3Gz3Ec
 9O2MzlHkB8SOA==
Date: Thu, 10 Feb 2022 10:54:29 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Len Brown <lenb@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 m.heingbecker@googlemail.com, linux-nvme <linux-nvme@lists.infradead.org>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220210185429.GC1617879@dhcp-10-100-145-180.wdc.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
 <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
 <20220210182423.GB16171@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210182423.GB16171@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_105434_953730_F8614BBA 
X-CRM114-Status: GOOD (  18.40  )
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

On Thu, Feb 10, 2022 at 07:24:23PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 06:56:35AM -0800, Keith Busch wrote:
> > Apparently it works fine when you disable VMD, so sounds like the
> > acpi_storage_d3 is set, but we fail to find the correct acpi companion
> > device when it's in a VMD domain.
> 
> I guess the acpi_storage_d3 is set on the VMD device and we need
> to propagate that down the entire bus hanging off it.
> 
> Which kinda makes sense in the twisted world where vmd was invented,
> given that vmd is Intel's evil plot so that only their Windows driver
> can bind to these devices, so the property also needs to be set on
> the vmd device.
> 
> Nirmal and Jonathan, can you help to sort this mess out?

Just fyi, I'm not sure now if my previous comment is entirely accurate.
I'll get some more info from the reporter to confirm.

