Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1239CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 08:09:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7606112D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 08:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA7606112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=COEOzQYUwR9d2PN0C1qBVUmyQJN4pyAmhGJp+uEpSQw=; b=wwo+4DCWFIvy/VGBIpar8K3389
	VkCoudif7a6XqxUmn0u4XAil8IzimKKliEDqG/Ga0154KgNenqh80Fk7TNasUjcKjBfywwb2e/rDh
	mSXefp96Ub4p9I+pa5ngn8wTe3pVHkqRcZyEZCbC0a+rHTxOjg0jBMfwXZFJlYXiVRX1Zwuufb/vS
	KjnkGwWFKw6QuTblmizx2iffMw+haK+z8MeK2MjXCJrXUTAdRUJYLt3xGj+InyQqGKKkfH4qChF7v
	uBBt72MkYWOhvrC7G6iVk9nn1FvWdc4R+4l7nRsuZlKvlTvkH84I1Qz34F2AHeKk7DJAr+pY4yl7S
	evA2UAqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkMBp-000w9h-78; Tue, 09 Nov 2021 08:09:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMBm-000w9I-V5
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 08:09:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6213367373; Tue,  9 Nov 2021 09:09:03 +0100 (CET)
Date: Tue, 9 Nov 2021 09:09:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
 oren@nvidia.com, benishay@nvidia.com, borisp@nvidia.com,
 aviadye@nvidia.com, idanb@nvidia.com, jsmart2021@gmail.com
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Message-ID: <20211109080903.GA28785@lst.de>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_000907_172298_A2FEC89A 
X-CRM114-Status: GOOD (  19.81  )
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

On Mon, Nov 08, 2021 at 08:45:11AM -0800, Keith Busch wrote:
> On Mon, Nov 08, 2021 at 04:46:57PM +0200, Max Gurtovoy wrote:
> > Hi all,
> > Commit a2941f6aa71a ("nvme: add command id quirk for apple controllers")
> > was merged to fix a regression in apple controllers that was introduced
> > after merging commit e7006de6c238 ("nvme: code command_id with a genctr
> > for use-after-free validation").
> > 
> > This series is comming to enable the same quirk for fabrics controllers
> > that used the command id index in the same way that was probably used in
> > apple controllers.
> 
> If there really are targets behaving this way, then this looks good and
> necessary, however unfortunate. A TCP target triggered the need for
> valid tag validation in the first place.
> 
> Are there really fabrics targets behaving this way, or is this series
> anticipating they might exist? Apple disregarding specs is nothing new,
> but I would have hoped no other targets would do this since most vendors
> care about interop.

Seconded.  We probably also need to document the broken targers in the
nvme-cli documentation.

