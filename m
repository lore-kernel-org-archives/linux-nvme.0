Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9AEC30653
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 04:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QvfZREhMBkWlAgF6kzq88cGw+lXq0xxYGPoTVBp4SE=; b=uKpgDiPsrwEe57YaW3pzLqVH3m
	r+bJXD3lb7f2rXID0R9i5o4//dAv6v/epOI52NvAJRK8rbesQs5uwBrBAmxNpq8t4BaK3C36LaFFt
	cAtecWighZ3GOYi7DDf+ZZ3z2qI2xbHJm62Kj+z4DtFpeZeyqexTT+7w43RdhGAkBSho9WcQCxdn7
	1fYFRBTfa7TXE3YNcR8k4yn/pWU9qBrpZbLrJBT4+gQKupKi/CjbJPvvNlqdyRnv6aWXUvc804Cfb
	ZCZzMSmIjsV5vaqDALVyps63xxKJR6Bc/hhY4bzbCN5E+++hTo3nuavRkvLP9KzA1oKlh3Sc8WoeI
	R55RvH1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOrip-00000008xmR-0v4Z;
	Wed, 03 Jul 2024 04:35:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOrim-00000008xkO-0UqT
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 04:35:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A9E9227A87; Wed,  3 Jul 2024 06:35:50 +0200 (CEST)
Date: Wed, 3 Jul 2024 06:35:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ewan Milne <emilne@redhat.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: blktests nvme/052 failure
Message-ID: <20240703043549.GA24378@lst.de>
References: <39cc7376-1c98-4f1d-aca3-e155a26535d5@nvidia.com> <7c0621e9-3af3-4ba9-ad96-3f322adc5a57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c0621e9-3af3-4ba9-ad96-3f322adc5a57@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_213556_318305_6C75995B 
X-CRM114-Status: GOOD (  11.46  )
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

On Tue, Jul 02, 2024 at 03:38:40PM -0400, John Meneghini wrote:
> Looks like I didn't test my queue-depth patches with blktests.
>
> I'll pull the new nvme-6.11 branch and try running this test now.

nvme/052 is a known issue in nvme-6.11 and for-6.11/block.  It has been
fixes in 6.10-rc, but only after for-6.11/block branched off.


