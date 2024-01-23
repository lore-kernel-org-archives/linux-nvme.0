Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7640EC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 08:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZsMGTaiO5U6+5XFiM1FQk8K5kvozO9peuTBBeV+H2iU=; b=m1+1d90HXBIFkP6RXp9o07To7Y
	pbgqxxrzKWgoAOzmOOaOCaSGTCj1TRujcZGGbaHqQbSHqGVWFXp2+kdIXNwmSgnr3EqxjsJfIlIMh
	LJKpG7uIPr2NPL2MvaqmJwI7EUziPcDxAhk7NKkSAFGxKfgpA7FlA2DR01IrftqwtKvpINeFtn2is
	EWqbSQDG1TPMsdfAYZeCDun0tr+MSDYveANtY0d9JCImg8FQTbO3pMA0rsrhNKxmd83lYNfTh79O8
	C1mBqIlBXwXVUoX6bK2vvBRwI2U/OvE4YQ6f+MXxfqkyb+Lqg5EW1g0avq+GfAtUF53bLFRILj3cU
	h/pTJaag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCbl-00Ffdy-0u;
	Tue, 23 Jan 2024 08:58:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCbi-00FfcZ-2C
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 08:58:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 523F968BEB; Tue, 23 Jan 2024 09:58:07 +0100 (CET)
Date: Tue, 23 Jan 2024 09:58:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com,
	dwagner@suse.de, oevron@nvidia.com
Subject: Re: [PATCH 1/8] nvme: use Independent ID-NS only for unknown cmd
 sets
Message-ID: <20240123085807.GA30773@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122145659.5574-2-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_005810_860222_8F8094C6 
X-CRM114-Status: GOOD (  12.49  )
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

On Mon, Jan 22, 2024 at 04:56:52PM +0200, Max Gurtovoy wrote:
> According to the specification, the Admin Identify command is not
> part of the Admin commands permitted to return a status code of "Admin
> Command Media Not Ready" for "Controller Ready Independent of Media"
> feature (represented by NVME_CAP_CRMS_CRIMS capability). Therefore, use
> the legacy ID-NS also if this capability is supported by the controller.

Please just file an errate to fix this, not using the CS independent
command in the CS-independent path is just silly.


