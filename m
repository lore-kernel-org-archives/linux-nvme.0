Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F900C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2PU7ayFlNM9+gj2iboav3vtZiJ1n3MC018lpKOZ2tK4=; b=mFuldd4pTlbLnFCcpCq4XNil39
	jtuXn8Im4Qu9h/q6dLimUemtTVuG6VTR08DsPmYzMxoifepE9aHrj8NgnxmWL8PJk+kfAQVK/Gcoz
	WS0R+oGa7UZFATLAL9SynpOt8I87RMdXjw7KMES2pXX2I/d7gjhyhprskVDGha+84/GrPzvvCMHOE
	TVYhe6iycD9wmB9L7JA7ujIQ95RePpnmSNtlFQtx/662S6FqD1Df+5WfqqikHhTCke1RzZnatibHF
	6Jx9kUkIiKwPYLUy8DuivTDjScE7EgtYX4dEkvV6XY3Yu64E5YM4uSSI/hmT72Uq/neRaKA8T1MSR
	LOvAK3uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSChg-00Fgli-0H;
	Tue, 23 Jan 2024 09:04:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSChd-00Fgjf-0k
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:04:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51D0A68C4E; Tue, 23 Jan 2024 10:04:14 +0100 (CET)
Date: Tue, 23 Jan 2024 10:04:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, oren@nvidia.com,
	israelr@nvidia.com, oevron@nvidia.com
Subject: Re: [PATCH 7/8] nvme-fabrics: add option to disallow T10-PI offload
Message-ID: <20240123090413.GF30773@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-8-mgurtovoy@nvidia.com> <6gx7xdmm54po74oihiazqsdk4sln4h7754f5qx5lc7rxdhy4of@wip6kfi7yktr> <a4a17b72-84a7-4ace-ad15-5c7b3a54929e@nvidia.com> <acr7me2i63tk33ljxst55ifobw6vqnp7mtnsiuv5fszwimrcyj@lnmydpvawzfu> <juclu4662fnok7u6bh5hnekm7ggqly523nnh5mfbzf2nyompjr@ykwshckwj32s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <juclu4662fnok7u6bh5hnekm7ggqly523nnh5mfbzf2nyompjr@ykwshckwj32s>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_010417_415300_F4B3342F 
X-CRM114-Status: GOOD (  19.31  )
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

On Mon, Jan 22, 2024 at 04:28:53PM +0100, Daniel Wagner wrote:
> On Mon, Jan 22, 2024 at 04:27:08PM +0100, Daniel Wagner wrote:
> > On Mon, Jan 22, 2024 at 05:17:11PM +0200, Max Gurtovoy wrote:
> > > > What about 'enable_pi' instead of the inverted boolean logic?
> > > 
> > > we can't change the default behavior (that is "enable" by default).
> > 
> > But couldn't we just have
> > 
> >     enable_pi = true
> > 
> > as default then? This should be the same as
> > 
> >    disallow_pi = false
> > 
> > ?
> 
> Ah, I get it now. This interface doesn't work this way.

The match_table_t infrastructure does allow checking for paramter
values, including boolean ones.  And this would indeed be a good
use case for that.  Extending the existing boolean only own
flags to that would be nice as well.

