Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1114C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 17:25:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCE36138B
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 17:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DCE36138B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c9Jp+DSlvFuADon2+gE7QzFS0pLBQIC2qIBsOWw2Grk=; b=BUyR69bTVObEPV5g7tEeUK8CdT
	XmqX3KQGruHDSxbTspVHKeY4OKPp/8goqEogLxKrn8rXn1Sog3EZYLdM2mNlqGNr6c5yZZo12zYX7
	GJ7EFVkZIkS6wOfug58/nd8CTgy3Uxt4EG/rmCDpPctmJz3r7KFNdXpd/189kllmtf/fLDaFvwqdu
	lE+hCYCoql4ooJzR5tADXwSrytBW56XnNIKa+dYubMj7sdRzi8PSaDmA/xeG6WVEw82jit07GE3ZX
	CWvK1lEOwttndFgVYNbnar5uvl+z3CBK/zVZ3zEype2Ms+PuYzQlLbrutJaXz0NZ8MGG3D+jc1CgZ
	0THIFSXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdFKr-005JLP-Ci; Wed, 20 Oct 2021 17:25:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdFKo-005JKm-I7
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 17:25:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB12768BEB; Wed, 20 Oct 2021 19:25:00 +0200 (CEST)
Date: Wed, 20 Oct 2021 19:25:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH] nvme: drop scan_lock and always kick requeue list when
 removing namespaces
Message-ID: <20211020172500.GC4167@lst.de>
References: <20211020055910.110695-1-hare@suse.de>
 <e44c4a84-c678-ebb2-b267-c7557d824ac2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e44c4a84-c678-ebb2-b267-c7557d824ac2@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_102502_772622_50560C2C 
X-CRM114-Status: GOOD (  12.66  )
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

On Wed, Oct 20, 2021 at 06:33:48PM +0300, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
> Christoph, Keith, Hannes, Chaitanya,
> Do you see any issues with this?

No.  I'll add it to nvme-5.16.

I'd love to kill the scan mutex entirely.  For that we'll probably
need a per-tagset freeze in the block layer, which seems like a 
pretty good idea to start with.

