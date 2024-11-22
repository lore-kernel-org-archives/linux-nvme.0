Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E601E6916C
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUKtnclFBM/Sk8n6FgGdmxXR2SFOnV5OXLeWLDM+/Kg=; b=oeFos+kUL/Fwrui42y0Q7bAcoI
	kM+NegNRhpA21do4PbJNixKN/euUAtbY5iHh5G9Kh4yLSJ1QNjt14UFj6k5urX0011jmaEg7PXc5n
	dlRloTHBiuR4vWOktGADh0OoVbvQRyQnCLgdJgr9icnFcoPV3pp9DZW+RM9IquwiMh0svgoRzaF2C
	3gWkFbtpQoRmV/eb2KIkTtg1oCG+Zi2lZsriQcrw7+YyRUZvKWhKIQ57Oh6c0Z/JhSaga10l5fdYw
	TRR+tC1iaQjTP7NFlzJ/M13xUG4OQOwUmBPERx8QWPZzRhYVBYegI0tjl+AzQnEffFm1fKXYlK3pL
	7ODa/QEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEVlF-00000002k7C-0kal;
	Fri, 22 Nov 2024 15:39:57 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEVlC-00000002k6p-3mcH
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 15:39:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A2B08A40FFB;
	Fri, 22 Nov 2024 15:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD8C4CED0;
	Fri, 22 Nov 2024 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732289993;
	bh=e2AdF9OTfkivQ6vfutepTSoVuE4EmbAUxopve11xF+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxHjoSCp7QvBBh67fZIA3E+mM6vIexZ05u9R0Tp6Rr3cT6ULn5LCEEUGk/pH54qXr
	 l4AN7VLuFItHZSHeQ/IRj4r8a3ZxfNU3D0EvyRbkltEsWTb1NKk80uJ2kEPTCnJP6G
	 ljUKUMCdA9jqaERgxxcNGqNMxOY8JpUXy0W7SNk6GczJzeyP22SoLzAoxkywiMhLte
	 vpIIYfL3ovZHbmVzQKKppUtyTh5zKXV96Uny/7ZEVaRmTPAh3ruTKOvdwU/qx47kkw
	 oAaZpiMY8Px/85XqPfydiLzBOg9F42VsncEcwHERRmdQOrCwkdO1GeXi66nXhMpajN
	 A28qtjVxvNxqw==
Date: Fri, 22 Nov 2024 08:39:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
	mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com,
	kernel@xen0n.name, jmeneghi@redhat.com, bmarzins@redhat.com
Subject: Re: [PATCH 1/1] nvme: always enable multipath
Message-ID: <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122120925.GA25817@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_073955_005989_AEADB834 
X-CRM114-Status: GOOD (  15.35  )
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

On Fri, Nov 22, 2024 at 01:09:25PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 21, 2024 at 05:03:21PM -0500, Bryan Gurney wrote:
> > Since device-mapper multipath will no longer be operating on NVMe
> > devices, there is no longer a need to set CONFIG_NVME_MULTIPATH=n.
> > 
> > Always enable NVMe multipath, remove CONFIG_NVME_MULTIPATH, and use
> > the code paths that would be used if CONFIG_NVME_MULTIPATH=y.
> 
> As mentioned last round not having to build the not tiny multipath
> code for embedded systems and other small builds that never require
> multipathing still seems like a sensible idea.

It's not just embedded either. I have plenty of single port datacenter
PCIe NVMe's that claim multi-controller capabilities. I think it's some
artifact of SRIOV that some versions of the firmware can bring.

Anyway, we only use the one physical function, so they're certainly not
multipath devices here. We disable the CONFIG option because while the
nvme multipath IO overhead is low, it's not zero.

