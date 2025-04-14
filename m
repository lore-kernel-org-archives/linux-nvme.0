Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CEDC369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUzu+uSZj/hfwD9M5ITtfP+0qmZDzERARlyERZJDuis=; b=bCmRxbhzqI9/oD5tkUEiI2td/m
	uy8/gZaZ84kiWvOyp2L0lAwWJwifWdQORkbJAK9XnkGYrmYkkK4+9+rYxYCcGZsl7bf4j/kefnKGY
	gD8EEtebioebk5d1mYFeWn76y+umNxO/HfMwZR3S6iZLDtQnLLFsrrX5ACOsN3QieYGiO8UJyAF17
	7S0PiJNto7yzHuC+dZlKoGp4WaNaFVHOdg2UwkjGrrL8Wcr+lrG4cR4NSZ9sTUu7HbLv1UdcW1s2D
	h8EDqpLcV+iz/kC8fD7UMt760X7of1IQVNTPDsqbn6ojZAnpqPI5IOb7bj8OcRkOB/AWZJez7oUAw
	Kw4VxKmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4HxC-00000001lBV-1S6r;
	Mon, 14 Apr 2025 11:26:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4HqZ-00000001jkg-3L1n
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 11:19:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B225E68AFE; Mon, 14 Apr 2025 13:19:16 +0200 (CEST)
Date: Mon, 14 Apr 2025 13:19:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, wagi@lst.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <20250414111916.GB13225@lst.de>
References: <20250414090959.2015-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414090959.2015-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_041927_979353_7F4C26DC 
X-CRM114-Status: GOOD (  16.87  )
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

On Mon, Apr 14, 2025 at 11:09:57AM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Hi all,
> 
> we have encountered a customer issue where the NID values for additional
> namespaces on the same device are not unique in all cases; the NGUID is,
> but the EUI64 is not. Problem is that prior to commit e2724cb9f0c4 there
> devices worked without a problem, but after that all NIDs are blanked out.
> This results in udev not creating persistent device links anymore and the
> system failing to boot.

These devices are so broken that we absolutely should not support them
You've also received that feedback both in person from me, from Daniel
and from the nvme technical working group.  I'm not sure why you insist
resending it instead of telling the OEM that specifically requested this
spec violating behavior from their SSD vendor to stop doing those
broken thing in the many months you have known of this gravely incorrect
indefensible behavior.


