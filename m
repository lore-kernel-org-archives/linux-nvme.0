Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC4FC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Apr 2022 07:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iLfGpB9jq8uMC6jlu+ucWDjdlB/6HL+1A4z2H2bL63E=; b=RqmOipd2TJhmgWm1LE7AVhcfvn
	WWiwFlu+mmETNzfMLKTraiRVkU7UY+mLw6bp3on5TZLfvXN/vrVnHhueHAIJaG0ApO3vsbOQgDft8
	4p+KMKxz312hHoRoXNh4/T17xKJQoS9rsVBHPNAv7K93mkiqCbFBdQZUDm82DMGpStpgkqRCTl2Jd
	7tpsoBdThJBvS6Xcy/OroDeO8A3hH/+zx4dMNLyI9e8rpH8+p74oF7rOkGd1yUfBz3TSi296xLjGE
	3lQRrts33zz0986m4hNzjcd0g6tnuqcIpNogpXONkDbjdmwhRbq8cjOqPGZn/GQKCF00K8DBE8PGV
	G6u1SOaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkhu2-00Dr06-Go; Sat, 30 Apr 2022 07:52:30 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkhty-00Dqyo-Ah
 for linux-nvme@lists.infradead.org; Sat, 30 Apr 2022 07:52:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 09B13B81A79;
 Sat, 30 Apr 2022 07:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F04C385A7;
 Sat, 30 Apr 2022 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1651305142;
 bh=7WU6Hv+j5IpVc4WlVEIwGBU4ZFEmt4nHCYEncgGlcn8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bftjN0qO/SG4jvtvjb3gkReAtIDReW4NuHomITzamBvbFKa47b+q4or07Bz4gvkPP
 m+LASPvPyfaXDV9V359Bep0eUtfJmK1BBYPx3yTUU2z9UDIGBf4Q7h9pxJLnG/LDDl
 Z2O+IfJ/Fea8Ya7bACgDQdH/i++YLQiyKRyAS5To=
Date: Sat, 30 Apr 2022 09:52:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tanjore Suresh <tansuresh@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <YmzqrqfVLQ9/4KXp@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com>
 <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
 <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220430_005226_564072_DDCAEA5C 
X-CRM114-Status: GOOD (  15.85  )
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

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Apr 29, 2022 at 11:03:07AM -0700, Tanjore Suresh wrote:
> Rafael,
> 
> That is a good observation, however, many of the use cases in data
> centers (deployment of devices in data centers) do not exploit device
> power management. Therefore, I'm not sure that is the right way to
> design this.

Yes it is, enable device power management and use that interface please.
Devices in data centers should of course be doing the same thing as
everyone else, as it actually saves real money in power costs.  To not
do so is very odd.

thanks,

greg k-h

