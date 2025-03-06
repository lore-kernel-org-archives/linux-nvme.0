Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E45AC282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5oXJl4YQpA7wYZtrfaFJNCBYMCXPzWbB1dnnaaCw9lQ=; b=bspvpL+EFk/5vcFq9l+u14mCr4
	Y0NViWlHBy79xIq5Ny4gzAhB+oNf6V1/gvw2EVWTHBd5KxzQtEe0Nqu8hsnPh0GH2/vNLG97JSdGZ
	XjC+tMAoE3nE4IeUoRrEcVFYNTBt3cjk+tfnNX93dZ0oP0i6B6TLVrLi0oeOrEt9Ij7VZFE7x6y74
	+DkeMcBslJ8+IThdsbCgNbfpgCjOm4YgUGwrLrU8r8FscZztKGrimgcMUhO5/jMnozkVLmHPm95ar
	ytfoiS3t3e+5TzhNssPU4jUTYZbSY+sweycI5vlYTRtx/8Euee/YYEsEsPIef58+aQ91TEQMk73DS
	TPBNcEEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqClI-0000000BGkT-30aW;
	Thu, 06 Mar 2025 15:03:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCj3-0000000BGV6-1Cz7
	for linux-nvme@bombadil.infradead.org;
	Thu, 06 Mar 2025 15:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5oXJl4YQpA7wYZtrfaFJNCBYMCXPzWbB1dnnaaCw9lQ=; b=QlP83gOgNU4aoTpJvlThc8pas/
	wUkXOk4O5vkCoRd/g1aO+7J97ZEaoqcy45OJheJ7uQOcXkX0GZ6uRzWEXSl9R5Ra+7H3JYsfD6kRd
	k2nUerCWR0Goa/blYl3kQO4nn8NNHwuZUp46Za9wUzmAyACC7+MBnYXj/9L8gG5NBZwbW1rIXmZQy
	qA4PajHfDy6E4dyD4jReo3Y00dQecuLG7cwkoTBU4r40qXihv6cs6XythmX7P4oXFNKmyRLl4AG/z
	dF/v8O2ANtouVv9+rmmUkjlk9DJ5iPU56cw5L0M1qS+jaLsn2zdBpZ49szMhXQ0OaNHWd675YfhG2
	ffT+U9VQ==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCj0-0000000182X-1oOW
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 15:01:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9B27BA432A2;
	Thu,  6 Mar 2025 14:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AB7C4CEE0;
	Thu,  6 Mar 2025 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741273282;
	bh=jZlvV4iZTdSil+zgfLGfHzpyML/Vo7QSZIW0eHQ6HKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sU7gRBZBqEdXDYByqDmxKuk/FfCYoU2HtU7hdkuZYJ6xwiOp3nhXrsIF++PX4TVnt
	 2ZQpwJ6VWfPq9yNbrzYpBuHkm9Vgt7TL46FBkJMKAu6yzXxuG+CJzxXMtPvqoWO5CF
	 K75udfwe5iklckYNXUP21uQSYJx8zucM24JmKcO85CYzsXsAzmC2XRBCL8zFjZIoqL
	 yMx8+U2TlZbX4eJzDroPws3lUDIxP77Z1H/9daFpC3QnhRugYNdeFEGkOjIBr6OQVN
	 BOFMhZWYAwlMTydy5uY+RonPGVLTqPZmnYgzkCwNIf+leX8rJ+BhjGj0nsRfdeCgNw
	 fECfkaRK1uD6A==
Date: Thu, 6 Mar 2025 08:01:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8m4vzE36UHWjwep@kbusch-mbp>
References: <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
 <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
 <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306141837.GA21353@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_150126_602509_1C942A55 
X-CRM114-Status: GOOD (  15.07  )
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

On Thu, Mar 06, 2025 at 03:18:37PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 06, 2025 at 08:12:03AM +0100, Hannes Reinecke wrote:
> > Single ported.
> > There is a range of Samsung NVMe where one is a normal, single ported,
> > NVMe, and one with a nearly identical model number reporting CMIC.
> >
> > Causing _quite_ a lot of confusion with the customer (and L3) when
> > used under MD, as for the first hotplug works, for the second ... not so 
> > much.
> 
> If the device is indeed entirely single ported and Samsung can confirm
> the setting is incorret and not easily fixable by a firmware update
> we can quirk it.

It's not one vendor or device. Making this a quirk is a good way to get
the mailing list spammed with requests to add yet another device to a
quirk table.

Or consider a true multiport PCIe where each port connects to a
different host. Each host sees a single port so they're not using
multipath capabilities, and the admin wants the MD behavior that removes
a disk on hot plug. Or even if one host sees both paths of a multiport
PCIe, they still might want that hot plug behavior. The module parameter
makes that possible, so some equivalent should be available before
removing it.

