Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C78C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4dLhKp6j7sOETN3pFy8pyv/cRCSOf1QwFOuGxPxPzg=; b=W7n7ko44JoEIs7YM5RUrgNrBcT
	6xlItc4C0Otqov5hUXFr0qRlMjCkQPkoD4PkiFCo1FyThJQrNjseYe4tylsCP6Eg5V23T0eVIzOEt
	RSNqsx4wPZxCW//CwUAnrKeS6UJAsn81FfjudyPqSwuxKf5kjoOZ5fUkyay4fg0Z6WoS8pFrxxWZq
	BFgf/DCM36F7NntQ9VQ9XOkusFkx/9VuYK67z72tJEWb4v7va9ygl4e9QjfY1M2RGkiC/ktKzAzBm
	UMAKOTzfqKXBhYfm2uFyOezWOwRFrrT6DxDJWjP44wBGbyabyHLERH9YwdWSIjMyJrmi50qGx/DVT
	u01CdshQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEYnJ-009ieJ-LE; Mon, 31 Jan 2022 15:40:41 +0000
Received: from 8bytes.org ([81.169.241.247] helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEYnH-009ibq-0l
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 15:40:40 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id E61894DC; Mon, 31 Jan 2022 16:40:33 +0100 (CET)
Date: Mon, 31 Jan 2022 16:40:32 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: nvme: IO_PAGE_FAULT logged with Intel SSDPEKKF512G8
Message-ID: <YfgC8H/EJRLRpgES@8bytes.org>
References: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
 <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
 <fd1c1767-0029-58d2-3878-5bc1a85b8e2c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1c1767-0029-58d2-3878-5bc1a85b8e2c@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_074039_247791_56CF3C64 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jan 18, 2022 at 06:01:06PM +0100, Paul Menzel wrote:
> > >      $ dmesg --level=err
> > >      [    4.194306] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc080 flags=0x0050]
> > >      [    4.206970] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc000 flags=0x0050]

This was caused by a DMA read to a write-only page. Looks like a bug in
the driver or the devices firmware.

Regards,

	Joerg

