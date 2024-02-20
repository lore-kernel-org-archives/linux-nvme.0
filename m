Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D50C48BC3
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nVdg1PJbryLNJr8OPoKP6QSZt+qIgtFAGudvSq/1sw4=; b=jSdkHdRG3ueJ0JNgj108sG2yfW
	oSlk5p07vdasym3cZO+DquNIVKfdHgjSZV2SxD4HuYXdOg2m1AlmtPa9xRy6db2i8oV0DdxRt8tX6
	++ssR8juM0/6vxpVCuChW/Jp2JX9c6d9UfZ/tykrJk/DfpOdJBfaiYLr6dA+safIi6/lT/jySgJQw
	1pVribQqN4N9mDxkdNeibdAL998uf9qf+3r+uAC/3ONph2OtJakdjMKloHCr2N/wzfoOybGwzmInt
	7WtqwHs7PL0cZMOqIjIw+uuNqCT5QkRnSocZ2lAQicH+oY+v1euXd6H2hSOyL9UnSG4dXrcc1jaXm
	JO8xuqxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcJyh-0000000DQG8-05ex;
	Tue, 20 Feb 2024 06:51:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcJyd-0000000DQFL-2IpF
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 06:51:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A55F368AFE; Tue, 20 Feb 2024 07:51:31 +0100 (CET)
Date: Tue, 20 Feb 2024 07:51:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Message-ID: <20240220065131.GA9150@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-2-dwagner@suse.de> <20240216094909.GA19961@lst.de> <jfjchxptpfcpolpy2etiigflqvfcp2nzk53iwb6rx2zsdfd6by@h6ezfayjfqai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jfjchxptpfcpolpy2etiigflqvfcp2nzk53iwb6rx2zsdfd6by@h6ezfayjfqai>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_225139_751509_3D30FF0A 
X-CRM114-Status: GOOD (  13.24  )
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

On Fri, Feb 16, 2024 at 05:44:02PM +0100, Daniel Wagner wrote:
> James answered this point on my attempt to make this synchronous:
> 
> https://lore.kernel.org/linux-nvme/0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com/

That needs to go into the commit log.  And I call complete BS on that
to be honest.

> Ideally, we could agree on behavior which is the same for all
> transports.

sync and async opt in it is.  I'm still pissed FC did this differently
without any proper discussion of the tradeoffs.

