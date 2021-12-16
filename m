Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25629C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=hLrL2cw/5b3mG8B2xOZnnUJz/U
	Xy1ZSF30XxX1mDYZkNMBbbAbfv5tBNFXQhiHWpTF/1x/or9hSrZ/SwMCljIPJdy+5nJaTMthNiUiI
	thSZO1mGeBYP3IoO7zHGkiwL+0xd7bRSHozr6fyx+2NLEyMf7MXgz2TKUa84QxPXaEIQlvOA5AWQ9
	ILnETUi4lQU4Dd76ZKzcoPtRLuYP1sJp/6tdF4ZOXvlAZ5eFvigTudLhGCC/+LEPzXEpw/AiOiwcE
	ve+HIdpUCOO/H3weMOUXLWn9mprKgDpzkKkh3uDt8kSTzccJOMbFRm7kfdtsh+oMeEZeCiGF4MLb5
	NJRm0xhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxmHF-0049Aj-D7; Thu, 16 Dec 2021 08:38:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxmGx-00496T-L8
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 08:37:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 05BA368BEB; Thu, 16 Dec 2021 09:37:51 +0100 (CET)
Date: Thu, 16 Dec 2021 09:37:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCHv2] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Message-ID: <20211216083750.GB24927@lst.de>
References: <20211207135549.100950-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207135549.100950-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_003755_869609_346AC8C5 
X-CRM114-Status: UNSURE (   8.03  )
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

Thanks,

applied to nvme-5.17.

