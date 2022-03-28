Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0602C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 06:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VQxFHQHhEDHRXZxPz2JFvKMLdXHwSdtiIhCW6aOFtXw=; b=JRHaF98qyyqD/bPs60VYq17xjd
	PUkfi65nAeH8ytdnXDElrALD3ua5y88qBItsZFc9AJgMaNW11tPoLtT/ZKgrP3olHWqXk2Ta1MFFQ
	yyEXoGREpTK4wf5TETkDNDN4vZEPhJ/intwiBbJ64wTUFzTZaqypJT/h3XlX4rPNhGGwh2mF17AJp
	NauGNxTfbNaVvsW/LHGmfj0uybxb6Z53IxEhowVsyNL1dg7saxTVlMG9BtpdWioros6YciHFFH33A
	oOuglGa9QwApm46qNtxiDBDAoyL1TKLOc0sCWN5v7/Ys7i8ci9aPqu9YAocniHhD/T5G6aiKwkIyV
	hYEXCZng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYikg-007Sa0-IU; Mon, 28 Mar 2022 06:21:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYike-007SZ7-1S
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 06:21:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9E46D68B05; Mon, 28 Mar 2022 08:21:08 +0200 (CEST)
Date: Mon, 28 Mar 2022 08:21:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <pankydev8@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kbusch@kernel.org,
 sungup.moon@samsung.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: allow duplicate NSIDs for the private namespaces
Message-ID: <20220328062108.GA29315@lst.de>
References: <20220324154314.1571239-1-hch@lst.de>
 <20220328053441.v6kr7gza7nj2ldlj@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328053441.v6kr7gza7nj2ldlj@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220327_232116_267067_1524BAE9 
X-CRM114-Status: GOOD (  10.31  )
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

On Mon, Mar 28, 2022 at 07:34:41AM +0200, Pankaj Raghav wrote:
> Is it s/uniqueue/unique/ ?

Thanks, I've fixed this up.

