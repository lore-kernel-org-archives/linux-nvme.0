Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58093C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30B561040
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F30B561040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=VLKSxgEB6jLgSn
	aIzqxqikizv17whu3hQLELq3OKXV3RQtKG2mELbmv/Eu/U5jMh33z61fG25uZ5lyitN7CP1sfAmyz
	c63mjYhyYoHlfVbFZBYadajOZ/O0GH+Dx6BipCkdxTHUBaKsJocZ2x8O3PeWXhldIMoNYCyGRN53B
	U9ZMmFBiLrF2e7xSpR9V/SZz5494odJIMVoCq4AQKvieP982ZXzMC+NqeZS5tQqa+rJkWB4a6fDh5
	CM2IWHQyceTNO+sAqiQ1iIz8yeYJIzJa1Tao9KplKFYeaTIYTt/pzZNB+2cCGwD/bjXHTJ+jknpzV
	W+dAqKGXyVAzOJoqm7wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maHYn-00Cqyz-6y; Tue, 12 Oct 2021 13:11:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maHYm-00Cqyp-4w
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 13:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=ZraYERc4CScaR9zr40dKW5Uord
 PjVTpK5l/FFxRIZIFMwm9dCiQTFc3M4UAT/QY21kj/ydBSUnsKgzFTcPEMyzC0x17yJfrimRmgXic
 qgAWA08u1/7bZrwsjdcYe533Ii+ARdPQ3aZftOTSY6LZpXWqr8vnqWjfngVOthC7sHGsnsjXgr+RH
 8hQ5I3Igoqtoh/fHBnRJL4fDkZu4rPkXSkGDn22IOEA5U51Jt9DX9+JpJ8t4PVcdV1BVFJfeugvsJ
 RscRr0nDuzqY1YRJvdl5C50MrpjfuGlr53lvPcYNc6RRznam8BIHmbe71JoNMVwJdO6XjVeh7kRLz
 7q4QXqUw==;
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maHYh-009PrU-2i
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 13:11:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3EDE267373; Tue, 12 Oct 2021 15:10:30 +0200 (CEST)
Date: Tue, 12 Oct 2021 15:10:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3 0/7] nvme: support unique discovery controller NQN
Message-ID: <20211012131030.GA11640@lst.de>
References: <20210922063525.143045-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210922063525.143045-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_141107_222994_4826E0FD 
X-CRM114-Status: UNSURE (   7.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
