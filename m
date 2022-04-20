Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0099CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 06:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+gZduF2psfthY6DZICa9pGL/YCscA8r6rtJLOIe55U=; b=EZU3hLIKo8OT/7jac5fBmicZU3
	yFHdVg1OCAAi9EH/ghV6FaBKMxwxI1DAYDdZlEd3OgEwiANOQjzCTX8nxR9oylD3CjPjZOpgwfV84
	0TMwAHqC9gJztNiYWbGaCfTUe9I8SrZvEWSHRn9dotlNXrkB0MGR68dTHbcPh5k2Azw8v95B8UX7p
	vNFIfGoI6c/uI1nwwK8Rrw36QB7hGerTlWbAko/BroY/z/rx/0wFRmTG3hvANg/VOwK0AYl9RQIIh
	KPcAnz5cbmSosm+PS/sZjwA69/Hz2rI5BJtdYGmUS+fOif8OiQWLQk1lgOJ/MVDi+VeGSof6Xycx+
	zgnfOQGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh3bS-007VLk-Ov; Wed, 20 Apr 2022 06:14:14 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh3bM-007VKp-4b
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 06:14:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D78D1B81D02;
 Wed, 20 Apr 2022 06:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8A1C385A0;
 Wed, 20 Apr 2022 06:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650435245;
 bh=f+gZduF2psfthY6DZICa9pGL/YCscA8r6rtJLOIe55U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gAiFuoZWbfA3Gbp4SxuUGUqH6JkSe/fn7fp5xEdlK/nzTT++Vz8BaPmQUgPR6AAKo
 qpD9ofG9aKOVf4zuM/gyDF8rlIv39oalEu+uV7byAtPbTdqsd7rQqeLrmOIEy1FAxc
 bnfeKWqpizdlXwCr0aCusvizQMdxjb/o/hq7o9KM=
Date: Wed, 20 Apr 2022 08:13:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tanjore Suresh <tansuresh@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <Yl+knjqs5CyUiRjk@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_231408_358154_B517A722 
X-CRM114-Status: GOOD (  10.08  )
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

On Tue, Apr 19, 2022 at 03:35:47PM -0700, Tanjore Suresh wrote:
> Hey,

Please never top-post.

> I did not hear any comments on this v2 version. Please help me with your
> comments and approval so that this can be prepared for checkin.

Relax, it is in my to-review queue...

There is no rush here.

greg k-h

