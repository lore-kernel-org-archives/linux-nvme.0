Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7AECC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wlLfHbDSUrN7CXKZ+MqEYuHZY8+TDxgiwYGRiNZQVZ0=; b=R9SxYFOeB6uZMfVt3Iyk8qr6J4
	YniRwr0/y4B3dfCyyhHSYyjZvapbBpdkiz7A8INeatItdoTSuC4gqDUjQz/34EwR1gj7CR2tZ+uRN
	FbPau1O8yymH41ls20/E8KvQXijElQ+Ei9YbiGhvajD4C693/QEUKniTih3IcFBjrelkOVkRuuU9o
	YBMqqz8aaa/pixL71aCePIVQu+k/TFM1gD4ijOh+8TUXEN0C3CJVA70iSLdPX4AjtW7doNaye/CRf
	5zAmLePHO1DERIafD20twt5qeytl4RhjlE3/JyzHO3NICHqFPsESxH20np1kRRfnP4wUA/bBkZbet
	k8TnJc+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGegA-0000000DOz4-10vp;
	Tue, 13 Oct 2026 15:44:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeg8-0000000DOyr-3xQT
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:44:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AF0E343AC5;
	Tue, 13 Oct 2026 15:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4221F000FF;
	Tue, 13 Oct 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906276;
	bh=wlLfHbDSUrN7CXKZ+MqEYuHZY8+TDxgiwYGRiNZQVZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h+JMI8F3jvV76wNKbGHsfuYUUc4ZUNmFGo7/mmCcxZ47ke+rE47F9f7pqGAmCwlUi
	 ydZapk0m8A46m/w7MmkAshKZciWun3gpFmkrZjUvGXjeMSZepVnApAa7Y2Nm9Zh+nH
	 LXz/hG3EG9O6GYNU4rWfR/qf4k61xrgKNHIk4/XIL7XeUnyZN1ySd1r0rgVeOfbiz7
	 9l133LZ+419/vGadNDVffNfkIJG71hbSCWppicbm7BdblsnvrkMgaFCleDzJ5D//Rv
	 KszdVlPQzqyidKzdJrKu0+893E9nbhhr7J19cx6+aCkvVsH5l6x4GIqJ6jBYHf3A4e
	 mcI5LmlDSr80w==
Date: Tue, 13 Oct 2026 09:44:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: tjdqudcks0424@naver.com
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: reject undersized AUTH_SEND payloads
Message-ID: <as5R4w5JpoQFV9B1@kbusch-mbp>
References: <20261008183810.10455-1-tjdqudcks0424@naver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008183810.10455-1-tjdqudcks0424@naver.com>
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

On Fri, Oct 09, 2026 at 03:38:10AM +0900, tjdqudcks0424@naver.com wrote:
> From: Sung Byeongchan <tjdqudcks0424@naver.com>
> 
> nvmet_execute_auth_send() allocates and copies the initiator-supplied
> transfer length, then reads auth_type and auth_id through a common DHCHAP
> message pointer.  The existing zero and transfer-length checks do not
> ensure that both common-header bytes are present.
> 
> An unauthenticated NVMe/TCP initiator can complete ICReq and admin CONNECT,
> then send AUTH_SEND with tl equal to one.  KASAN reports a one-byte slab
> out-of-bounds read when auth_id is loaded.

Thanks, applied to nvme-7.4.

