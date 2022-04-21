Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45940C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 06:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yoq4Rh14uIplYWx3JGoICohqmuiV1Yo5F6nUCEJ4aTM=; b=hG7dp+CncIvQ6siQgVPQD2pbem
	lXOovZiTbwwJyNaW1ab6YZQ2Sa9LEJgaMaANb0qYhrsAcSt2/YDKpMoogeoThA9R7RrECpA6QjfP1
	0qry0d+yAA1NLRt+AZO86PSaPFfQHJsnc6XtZNWDFSzp1uAJZS7A0+mIR9OGRsZRo26Ae0pJqI8nI
	z+JFwGP8rvBYINTnIlyEYJz1pBk+leFQB/WW5m8JgcqQKGA/CJJOWGrunpGVbO46gtGwMyO36gdat
	A1Z9ss1QwFpOYDHhYYUMZbTh27zhNZ9Pef0lwnL4fUR02rG4zlLDyMaTRZilIP+FycuGpvKxMPuiM
	XHA3upxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhQEg-00BhWc-Jv; Thu, 21 Apr 2022 06:24:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhQEZ-00BhUN-JV
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 06:24:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DFC9260F93;
 Thu, 21 Apr 2022 06:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99E7C385A1;
 Thu, 21 Apr 2022 06:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650522246;
 bh=DOFw4L9az3DU5b90Fdo72Tbgr20jrBqwWs0Fec98yRA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rnRA+LDLgPpHIwm4YaAbf7zZbEoPQsaX81SvBNp6y/gdZPIWGc1hqmTAoAITziTtG
 av0kIpP2o8vyyxp4b16jWD6HKgL/8/g8MJ5zQLJ7vEmWghfBs10ie9KUtfTfmebOGg
 xhTqjHAAk8uWkU+z/psvWBap8DdYfK5nQqJrN4aM=
Date: Thu, 21 Apr 2022 08:24:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tanjore Suresh <tansuresh@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <YmD4gkbq+Ar1albY@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
 <Yl+kzdPG2EvAGCFG@kroah.com> <YmA9RZIIypzWOWV8@kroah.com>
 <CALVARr7Ms7+jL3EyTNNRaOB6co0ycWQtCWCDU+0zVjOnKEuK7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr7Ms7+jL3EyTNNRaOB6co0ycWQtCWCDU+0zVjOnKEuK7g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_232407_698179_4A8C6EF7 
X-CRM114-Status: GOOD (  12.01  )
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

On Wed, Apr 20, 2022 at 04:12:38PM -0700, Tanjore Suresh wrote:
> Greg,

<snip>

You sent this in html form, which is rejected by our mailing lists.
Please fix up your email client and resend and I will be glad to point
you at this thread on lore.kernel.org with responses from other
developers.  Or you can just look it up yourself :)

thanks,

greg k-h

