Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A623E98FB5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mTKXUcUNIdEGUVYVs81OSSJFUZMoqu0erJuhnU3Jbx4=; b=YLeP8ISDYETKbr4HhxkhNelWLP
	w5QsVmqC5Jx5u6tFwJ54FY0fg+Y2stQm5anFFyNIbRXk5Wm147ZjOxMMyRoWHquW9yoHruBvrKmMC
	Jfbey//p4vGqDavjaYxxuVnN5hkw3kSxPrHAIP2SrZvl+bQDYn875xiRbrNpOhStU42yvnCbewASq
	U9tWeCCH82xispVGz5qNeJ+h7tN7MoW89dHywEsyh9Qu8qd1PsOWRwpX3WWuxqhlkjCpeYIegbNlp
	68zAJVQOCt+DenqQsazyy53l9yMgUIQO+AVA4xRnqSfHN8l1SnLy0AT3ghMAXTpvvT7arD06CX3PK
	H9vn86Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAiZO-00000009k7x-0pvG;
	Thu, 09 Apr 2026 06:08:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAiZG-00000009k7c-1AY5
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:08:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3BFE68BFE; Thu,  9 Apr 2026 08:08:35 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:08:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Christoph Hellwig <hch@lst.de>,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	gregkh@linuxfoundation.org, security@kernel.org, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: bound sgl->length check in
 nvmet_tcp_map_data()
Message-ID: <20260409060835.GA6389@lst.de>
References: <2026031805-stretch-skid-ae5b@gregkh> <20260319012630.1802025-1-kumar.shivam43666@gmail.com> <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu> <CA+ysrSLau_52n+4JMvQ=EtqY-cyWhhZ_pLOyeNL=mwkjkNvoUw@mail.gmail.com> <20260320074825.GB14485@lst.de> <CA+ysrS+9bWdF1LvxoZaZW_JLZ97H-RXM548Cm8ZW5KQAD+NCLw@mail.gmail.com> <20260407063000.GA6992@lst.de> <DHNK8IM7F6PF.1LX1Z2KTRK5JO@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHNK8IM7F6PF.1LX1Z2KTRK5JO@arkamax.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_230842_462767_9BF61C12 
X-CRM114-Status: GOOD (  14.71  )
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

On Wed, Apr 08, 2026 at 08:30:12AM +0200, Maurizio Lombardi wrote:
> Personally, I would pick a default of 2 MiB, it should be large
> enough to avoid excessive splitting while still being reasonable from a
> memory perspective.
> 
> Sagi? Any thought on that?
> 
> I have seen a patch on this mailing list that makes mdts configurable
> via configfs, so in case of need a user could still change it
> to his preferred value.

Right now that just allows adjusting down, so picking the larger
value sounds sane.  We can still increase it later and/or allow
adjusting above the default to an upper cap if needed.


