Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA20AC07E97
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlszBjOY4v9e30H6w+I08NlAofN0K1JQn1ljbWROkGg=; b=KNEZ1Lb5328wZi7G0cNzOlVK9C
	Bu9eT8NmDY9wB2qSxvNQnuncYNJEIWT87Y/b5zwFEUnNn6P+rFWkDjsoqNhncY6xctTczhb0bFO7y
	owm+mixaNkTLGU/RdYqw3NhEtva08yhCJBbD8ITIWYTs4XZ56PKW4A+zdJ3KRCu8BIRzseUxpXM9N
	O9AwZeEQSSQIJZ5qaFRg+SoVMSlZyYr4a2bPzL2SZbQ4KFW+s0hyO3SA/+AO9KVQqpRXkSrpBMWCV
	sTbjkSjpWa4fytGFwJK/V5BlpMSF6VmYZnB2ddN1UYP5KzOCwYkEIjtLuOytMgT0BWbZ5ap2XgUxL
	hqsvwM1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7xm8-005Lyo-0k;
	Tue, 28 Nov 2023 13:05:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7xm5-005LyK-24
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 13:05:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C62A9227A87; Tue, 28 Nov 2023 14:05:08 +0100 (CET)
Date: Tue, 28 Nov 2023 14:05:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231128130508.GA8221@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de> <20231127141857.GA25833@lst.de> <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com> <20231127155649.GA1403@lst.de> <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com> <20231127163333.GA2273@lst.de> <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_050513_823561_34AA53B1 
X-CRM114-Status: GOOD (  17.35  )
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

On Mon, Nov 27, 2023 at 09:46:43AM -0700, Keith Busch wrote:
> > 
> > Yes.  But does it care about the tuple size, or the actual size of the
> > metadata field even if is bigger than the PI tuple?
> 
> tuple_size is the same value as metadata size regardless of PI usage.
> See nvme_init_integrity() for how this driver sets it:
> 
> 	integrity.tuple_size = ns->ms;

Yes, for the case where we actually support integrity in the kernel
for a given device.  But if the device has a metadata size larger than
the PI size we still support it, and just let the device strip/insert
the PI.  And if nvme-cli wants to report detailed information about
the namespace it probably needs to report the actual metadata size
as the tuple size won't be reported given that we're never initializing
the kernel PI support.

