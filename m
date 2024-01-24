Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD24C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/ln/sIVWOuXBbspsMM3T2QHbikKMaBqXjJNFQYBhPs=; b=RpzFKFdzbsLz4mfAlmpKF4K8lK
	/jyFMUQfpOoil9yPbvjJfcdQFzTY1spc8yTdMwh4oPkszyfURIrwll4nGIF6aAMrDoDn5IGSWXWE1
	sKOqFAmJBGC+gXcOXr+HMsiNt37nr+gtItDU54EyRiUJGwC3V0d2Z5Ok+OQdPa4E+QkkXPjIYPy/R
	qLGWExgfe0kKUSCAMtcAsXraCYWXyYZ7lxGG/PVZngb5gCbEVUabPQJFNOWe1jTMfyqifHNapVfOR
	VgXjMdc8u5vJC0dvc50d4QC/jp87AAdo5p+mu9T/5BFhZaJnr895O+bMKS9FhAV0SdvpF/3w9P5tE
	+5y0SyHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZDC-0026vp-0C;
	Wed, 24 Jan 2024 09:06:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZD9-0026uq-0x
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 09:06:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A040268AFE; Wed, 24 Jan 2024 10:06:16 +0100 (CET)
Date: Wed, 24 Jan 2024 10:06:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Message-ID: <20240124090616.GC27760@lst.de>
References: <20240111000855.1800481-1-alan.adamson@oracle.com> <20240111000855.1800481-2-alan.adamson@oracle.com> <20240111070441.GA7889@lst.de> <c44ad0e2-8f08-4b46-8be2-29b69a8d88b6@nvidia.com> <07b397bb-574e-4f7b-b754-085b348e1510@grimberg.me> <c377ad47-f908-44bf-999e-9a828a2891be@nvidia.com> <e79e6423-3fb0-4c81-b68e-7a5ea0807027@grimberg.me> <718a0a43-40b2-41a3-98d5-dc2eebb41681@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <718a0a43-40b2-41a3-98d5-dc2eebb41681@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_010619_483651_3B4F1A42 
X-CRM114-Status: GOOD (  14.99  )
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

On Tue, Jan 23, 2024 at 09:11:32AM -0800, alan.adamson@oracle.com wrote:
>>> This allows us to get the ctrl or ns object associated with the struct
>>> device
>>> we get in the sysfs, then based on the device class we update
>>> logging_enabled
>>> flags for either ctrl or ns respectively. In nvme_init_request() I use
>>> ctrl->logging_enabled and ns->logging_enabled based on admin or io cmd.
>>
>> I was asking why should we have a show/store that operate on both ns and
>> ctrl?
>>
>> Why not have a show/store in nvme_dev_attrs and a separate one in
>> nvme_ns_id_attrs ? Then you don't need the awkward is_nvme_class() ?
>> the ns attrs can access the ns in a normal way like the rest? Or am
>> I missing something?
>
> I did have a version that used nvme_ns_id_attrs but didn't think it was an 
> appropriate place for it.  I can go back to that.

nvme_ns_id_attrs has been renamed now that we're using it for more than
just ids, so adding more attributes if they fit is fine.

