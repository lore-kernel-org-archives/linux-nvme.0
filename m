Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BC6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2CEeh/D0rsUa/vy7lt+na6OhzOPgh9ByOArtcsQU54=; b=hsWfJGwCXRM9Qlsat79Uhn+MRY
	bMbeQiVmhNVxJ9jkoiynkTzVRP53V7XPG7FVxNDETwXIrLvwDqTpoLDlhkHT5ggNnqzBIBMQlpXex
	WG6j81po5OLjhVpP4mwZ8O+SManUXr7YqjsmsTpG99kI94ZNje4l8VkPgounaLqy8tPVkP5JdmhCR
	eKhTCOjLjyRGLU7XT5obWR1hvI7eTiNs0nOWDyWw2TTHeYSipnwDGsb1LMrV4nWASU4aNUBrjuKNV
	9LKIjZHSRx0IjNuz5dP3rdNFCDYWbezPyTujrMMdA1PrI0JwFkzVkdvpFnIfkRer6onLHYeX6VsSv
	XNTMiGbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWcWL-00Anf7-GZ; Tue, 22 Mar 2022 11:17:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWcWI-00Ane7-3z
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 11:17:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6B35468AFE; Tue, 22 Mar 2022 12:17:43 +0100 (CET)
Date: Tue, 22 Mar 2022 12:17:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 lengchao@huawei.com, dwagner@suse.de, hare@suse.de,
 mlombard@redhat.com, jmeneghi@redhat.com
Subject: Re: [RFC PATCH] nvme-multipath: break endless loop in
 nvme_round_robin_path
Message-ID: <20220322111743.GC29151@lst.de>
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-3-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321224304.955072-3-cleech@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_041746_333629_0D8C9F69 
X-CRM114-Status: GOOD (  12.75  )
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

On Mon, Mar 21, 2022 at 03:43:03PM -0700, Chris Leech wrote:
> This is a backstop for the odd loop construct in nvme_round_robin_path.
> It counts how many times the head pointer has been passed, as that's the
> only thing guarenteed to stay on the list.  Once is needed to start from
> a different place and check the entire list, twice is excessive looping.

Shouldn't

1bcf006a9d3d63c1bcb65a993cb13756954cd9c
Author: Daniel Wagner <dwagner@suse.de>
Date:   Wed Jan 27 11:30:33 2021 +0100

    nvme-multipath: Early exit if no path is available

take care of this?

