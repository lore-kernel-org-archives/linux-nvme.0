Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DC2C7618D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=i8o4SZFV+c4CSFF3vj7Z6F9wQK
	VZB4FFjkW+SgA7sSbpHe6iSLllz5PaQTqda16JV4lGdfLty8v9ib+DN/ZF0lZiG62aE0K62ggNNud
	X0G2L+/wB4kBypx/LtqCM5m/ONe+kQhN0Q3KlntDScxNb5fW22VciRFS+k51fNcEOSHl24TamZhDH
	B8sHKQFwMOq6VLr3l2qT8DzS3KbjRvr3ExHMT0KJahNxQ04DmTy2GpMo275OfcsPgKsmvdTgjBYg5
	HL4p79BFKJ4qW0fCYfBvvIRDV7Y57eRAr6z+clb3qpGuiezPUEZ4Cj0/8M6BVR02YTXv5FHQYuLL2
	E83+zxeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRP6-00DUdp-1J;
	Wed, 15 Mar 2023 13:42:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRP2-00DUak-1m
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 13:42:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F73B67373; Wed, 15 Mar 2023 14:42:49 +0100 (CET)
Date: Wed, 15 Mar 2023 14:42:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, hare@suse.de
Subject: Re: [PATCH] nvmetcli: set up the target only after the network is
 configured
Message-ID: <20230315134248.GA25623@lst.de>
References: <20230228163615.436692-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228163615.436692-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_064252_741683_67FB3EDE 
X-CRM114-Status: UNSURE (   7.78  )
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

Thanks, applied.

