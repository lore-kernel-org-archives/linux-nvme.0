Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B380C48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 07:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jND7F25IE4z/a9Sp3v0wX1T0s93hpHYhO5IHNdK0n2k=; b=Ix/P2Aftj87T+3oh89uBij8B4e
	w4cVpmOU048umxZmH8bemttg5CfCq1qAJI+/PXGq0ntov5e4UtHbZwQbSyhy9uAMAOVBywBCCkQrL
	X2UQZTGcqXttI02KkfD0p1raLBWs1B+FztE6pk3ze8ooDK7YeRlHx0kncLj1C+TyUfRUVtTzquzYx
	72z6MewDrj+2tMxjSjUnZRed5Yfqp5509bGLIeYAMe4wAJoItNEFgcYNjHmDOr/VVjf55eb5u8GPj
	KdrCGl16Fwe2rOX39X+kfvXSaFiduPYgpo4iNAXJXd3PjP82yMran/0Bo16P3fnFk8+GGC9HQSswf
	7z4A5NKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZn1h-00000008Dui-0pg7;
	Tue, 13 Feb 2024 07:16:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZn1d-00000008Dt5-2L8w
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 07:16:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06923227A87; Tue, 13 Feb 2024 08:16:03 +0100 (CET)
Date: Tue, 13 Feb 2024 08:16:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, oren@nvidia.com,
	oevron@nvidia.com
Subject: Re: [PATCH 7/8] nvme-fabrics: add option to disallow T10-PI offload
Message-ID: <20240213071603.GA24160@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-8-mgurtovoy@nvidia.com> <6gx7xdmm54po74oihiazqsdk4sln4h7754f5qx5lc7rxdhy4of@wip6kfi7yktr> <a4a17b72-84a7-4ace-ad15-5c7b3a54929e@nvidia.com> <acr7me2i63tk33ljxst55ifobw6vqnp7mtnsiuv5fszwimrcyj@lnmydpvawzfu> <juclu4662fnok7u6bh5hnekm7ggqly523nnh5mfbzf2nyompjr@ykwshckwj32s> <20240123090413.GF30773@lst.de> <fdd1c81f-caf3-4f34-96e8-f4d8ffc26203@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdd1c81f-caf3-4f34-96e8-f4d8ffc26203@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_231617_761547_F7567BB6 
X-CRM114-Status: GOOD (  16.46  )
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

On Thu, Feb 01, 2024 at 10:28:50AM +0200, Israel Rukshin wrote:
> Do you mean to do something like the bellow diff?

Yes.

> Regarding extending the existing boolean flags, are you talking about 
> hdr_digest, disable_sqflow, data_digest, discovery, duplicate_connect and 
> tls flags?
>
> I will try to do it without breaking the existing nvmecli, but I am not 
> sure if it is possible.

I'm pretty sure we have a bunch of fs mount options that allow a version
with paramters and without.  dax is an example, but you might have to
look at older kernels as the dax-supporting file systems got converted
to the new mount API in the meantime.


