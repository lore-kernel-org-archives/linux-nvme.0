Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF5EC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 07:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0XnrpU5UW5XMZWE3ApKcCmIuJwHMWGroUxRj0Jjss8=; b=OJhngTV5BbTlYnJzACaxt0mma0
	OPM7tqTxiq1+jtVB1xJKy+0HYVK7cXAtWfLbpucE33wkmda38GCiy6pk42vW8MJo8MT9vPNbkhtdA
	bifBR/drxUJ3271QOD47b1pqS73CuqhZ48SipaJijzvEvrK45civj5QPsErlwm83DtCdmbo/IXp2C
	b9kgezpJV6g6KNz7ksf+LJrlrHTru0IpzXqoNhfa5fl8Qor4gyHNjIawtEBG7esGwMow9/4BRyFmk
	w8mdJYMCkmq71SFbir79xlqTAOGUFyCDXVpiTzXE/C2SwbftLnvT4NjmrNQ3BdLeW9vhe5nMvOKTb
	yuTSIP8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op37V-00DvO4-VE; Sun, 30 Oct 2022 07:52:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op37T-00DvLy-0o
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 07:52:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3508A68AA6; Sun, 30 Oct 2022 08:52:31 +0100 (CET)
Date: Sun, 30 Oct 2022 08:52:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-auth: allocate authentication buffer only
 during transaction
Message-ID: <20221030075230.GD4214@lst.de>
References: <20221028135027.116044-1-hare@suse.de> <20221028135027.116044-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028135027.116044-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_005235_246076_972F1130 
X-CRM114-Status: GOOD (  12.28  )
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

> +
> +	/*
> +	 * Allocate a large enough buffer for the entire negotiation:
> +	 * 4k should be enough to ffdhe8192.

should or is?

> +	chap->buf_size = 4096;

why do we even need the buf_size member if it is constant?

> +	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);

I think this needs to be GFP_NOIO as we can hit this during a reconnect.

