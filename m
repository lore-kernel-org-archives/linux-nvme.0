Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46174CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 06:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpAPDmNA66WNnfJ4AvN0raoD8EJGzen/3LXo27lsL7Y=; b=MAg2Clej26FW6DcevIGjDn+dBu
	BLpYyNy/3BvWZ4A0o16Q6sVUNGViRqmTAYlQbCk9wEVLrjK4Yvu8pgpVJ2N7utVKKdaN3aiAvuRqB
	Gv0x7aJs0eNUuL8TKmy/ZdF7WpSzWA/MkZZhzfgyWf4J8qnD6ngPE73Do6ikjsRt81R2J+fwz38Dc
	pmHu8d3Q949HXtLYvZEEnEWUVFLQmw2ZTCVqiBg3oAIeQQzHJgipkFCFsKhbmkr3Z1DTIOc+jC+oG
	MiYjK6H8NH5kWf72d0unzuz+6RZDmg0yZBPao3e6pxJsHXqMI9jeaHbsUShFv0o4iM/J/yGstN6J8
	VF5FcswA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUIXw-0000000COCY-41Ye;
	Tue, 02 Jun 2026 06:24:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUIXv-0000000COCD-1u4Z
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 06:24:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A4856001A;
	Tue,  2 Jun 2026 06:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BA21F00893;
	Tue,  2 Jun 2026 06:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780381454;
	bh=RpAPDmNA66WNnfJ4AvN0raoD8EJGzen/3LXo27lsL7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LwIXW8A54XgAcI8IXyrpZm+VtfwgbM+MIcaueaafGe+QRdiE5JMHpEJmxHr1kjPdU
	 2YN0S/RblTUFchG64dc8VXPIfsussE0UW3hHlkETI6OYtVphfj2KxF+T+0+dwGwRir
	 LHsBOgR+Jd6HuoPLWvIIKbDqgGpY3JPR2vXhGHeo=
Date: Tue, 2 Jun 2026 08:23:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Message-ID: <2026060255-flagstone-salaried-7cab@gregkh>
References: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
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

On Mon, Jun 01, 2026 at 08:32:37PM -0700, Jeremy Erazo wrote:
> == Disclosure preferences ==
> 
> I'm happy with any reasonable embargo length (14-30 days). I have
> not shared this finding with any third party. Please coordinate CVE
> assignment with the kernel.org CNA.

You sent this to a public mailing list, there is no "embargo" possible.
Nor is this how CVEs are assigned (please read the documentation for
that.)

Please submit a patch for both of the issues you reported, in a format
that can be applied, so this can be resolved properly.

thanks,

greg k-h

