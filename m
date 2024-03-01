Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF5AC5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=o+YSEiJTG6p4mgBBWtw5QabFX1
	Il7B39ONbBQ6cpuSPfHIH9kKE2EVd4DPSzSSvxa3zT5ikvH3YyMot4rjm6os6exvgYLbJCSX29wiC
	PqwpfT6HrTZkJlcJ0byi4KHxcD4FCg62Io2lsGAjImIlDguDGHRjzEAJJ1z6CRk9E6wPuGC3vkCYf
	h5MHHcal638UYsp8p4fLFL8XTufgukhjeN9yc4UwyMh9dAe10/0s6RW03AYrdiTFTp1RTJF5dvwG/
	62Cva8pgPMsdnZXUHmKM7nIfLMYjCcPliAwb9TFhfMI3i2MXert9EvqqseZzptg4HkPi5wKbPQRZV
	v+ZoP2og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg33n-00000000WFS-33K6;
	Fri, 01 Mar 2024 13:36:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg2iP-00000000Ljh-48yx
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 13:14:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4135668CFE; Fri,  1 Mar 2024 14:14:15 +0100 (CET)
Date: Fri, 1 Mar 2024 14:14:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] nvmet-loop: do not call nvme_ctrl_put() after
 nvme_ctrl_uninit()
Message-ID: <20240301131415.GD3586@lst.de>
References: <20240301112823.132570-1-hare@kernel.org> <20240301112823.132570-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301112823.132570-5-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_051418_178038_F67259DE 
X-CRM114-Status: GOOD (  10.58  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

