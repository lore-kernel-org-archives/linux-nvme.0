Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA14DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J89NmbsltTIUWRi67SrsyAxUlHplDI9cjXCb8El47TM=; b=5FibXrEzkp1bVWXyPbTFKItpCj
	+z7UW/JfobNdHJcsuEtcx9LBTgglkOqQXbKZ6PCwaKaA6Xxg/SU86XCofhRb0MeswWCHsZJY96jTw
	+Uyph7MoGN/etxuEoQy8nKRzGrZov0cZwFafjl4THfzyAu6gkPIvFEmY9WgNHsff2zNIgLqrMcCsb
	MLe5EBzz6f5ikIqT/+oHvXpm1ckKMiDOEgep4Kj7KM4sqC8AM8TFukXD82/PTtws/+5QgFRoG+ASM
	Wo6VO3kSspOoK54o5ytngM39SyIJPYB7SgGe0HdD4c5X37TyQrxrH/CY9U/BY5abH8JJX6sNggYmb
	KbWuXZGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIAsG-00495z-TY; Thu, 10 Feb 2022 14:56:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIAsD-004959-KW
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 14:56:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B463661AFD;
 Thu, 10 Feb 2022 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4478AC004E1;
 Thu, 10 Feb 2022 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644504999;
 bh=I+gIcY+KfvtSU0JaeIJ0CIXiLVlwL3aHah5tuIc7NZA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q8QRs2XqQFepijiM7/NN1q2GqcdaCOx416RHZWlgBNP9kkNC9vEbHUUgI0LXcyLAT
 ef8do+sIhS8il5uGw0UCTP43qbim0qRfur0OOVWovLXZXJ+JQUm93z1VjtGSrtIIIH
 DGlA86q+MbRwXZPEM1d+BNVXsrdjgHa+fLhGo+fS68a7IyX3fw8MMFgDoV3nZV0hmN
 pPPOtZPizgdOpaisXrnkgGYP3+OvxIeQpP63cSGP1rtDOZl5gYNyxW8PRc2lND7t6X
 JRdMb/sjjfv4U01wYFtU8zxldgzAvvubYxI5PCi79ZHPvj6ttBHTQkCsshcO/Dh8Mh
 9oeiw1mOjGAqg==
Date: Thu, 10 Feb 2022 06:56:35 -0800
From: Keith Busch <kbusch@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 m.heingbecker@googlemail.com, linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_065641_753138_8A407219 
X-CRM114-Status: GOOD (  28.21  )
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

On Thu, Jan 27, 2022 at 08:02:07PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 21, 2022 at 10:09 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Jan 21, 2022 at 08:00:49PM +0100, Rafael J. Wysocki wrote:
> > > Hi Keith,
> > >
> > > It is reported that the following commit
> > >
> > > commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
> > > Author: Keith Busch <kbusch@kernel.org>
> > > Date:   Tue Jul 27 09:40:44 2021 -0700
> > >
> > >    nvme-pci: disable hmb on idle suspend
> > >
> > >    An idle suspend may or may not disable host memory access from devices
> > >    placed in low power mode. Either way, it should always be safe to
> > >    disable the host memory buffer prior to entering the low power mode, and
> > >    this should also always be faster than a full device shutdown.
> > >
> > >    Signed-off-by: Keith Busch <kbusch@kernel.org>
> > >    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > >    Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >
> > > is the source of a serious power regression occurring since 5.15
> > > (please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).
> > >
> > > After this commit, the SoC on the affected system cannot enter
> > > C-states deeper than PC2 while suspended to idle which basically
> > > defeats the purpose of suspending.
> > >
> > > What may be happening is that nvme_disable_prepare_reset() that is not
> > > called any more in the ndev->nr_host_mem_descs case somehow causes the
> > > LTR of the device to change to "no requirement" which allows deeper
> > > C-states to be entered.
> > >
> > > Can you have a look at this, please?
> >
> > I thought platforms that wanted full device shutdown  behaviour would
> > always set acpi_storage_d3. Is that not happening here?
> 
> Evidently, it isn't.

Apparently it works fine when you disable VMD, so sounds like the
acpi_storage_d3 is set, but we fail to find the correct acpi companion
device when it's in a VMD domain.

