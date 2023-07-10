Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27AFEB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 07:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5acEXpJaJrxecyVx0dfv2F5VnAmsfMn8VBXyUUXclG4=; b=ZYe6SgD+XNwKJAo9U9zpAa/1Od
	1MJgJ97HshGYbAtcWMpBQD4fXg9ZD+lY+Zo6/VQw7CPiEuPMRIRBD7DkLRcEpP723bgy9dNUh/HzF
	fneqgAUI4FryidxQ8MJ22FVyVEWdw8I+ticGt6mbVEBwUVF8++iyVcnnb21C72itWk8ElEmETuONP
	9zbnSQcXfCEwChX7wTyRTFSzR/KgvoNDvHOBAlFH+Og4zw9ViXullZTaq/+xEEudKdnIgUzAv42lz
	80YojMDkS82V6o8Bvi+UnK9szTzbXZXRd+SW6nGmFN7pg5In6kkuiPCFVC/I3mn2elKm9U4dFuYSh
	K5jSQAAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIkta-00AeSU-0F;
	Mon, 10 Jul 2023 07:01:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIktX-00AeR5-2M
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 07:01:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46B7567373; Mon, 10 Jul 2023 09:01:11 +0200 (CEST)
Date: Mon, 10 Jul 2023 09:01:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: irvin cote <irvincoteg@gmail.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-core: check id->mc before setting
 NVME_NS_METADATA_SUPPORTED
Message-ID: <20230710070110.GA26047@lst.de>
References: <20230624103502.8772-1-irvincoteg@gmail.com> <c68c669a-21e0-b257-5a1c-bfabf8d6f558@nvidia.com> <CALL+9egLCiTFyOpvt9tUhmkr-x3PoCzi3JeDxZ-FTCyP7BkDxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALL+9egLCiTFyOpvt9tUhmkr-x3PoCzi3JeDxZ-FTCyP7BkDxw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_000115_912313_CD7AE7EB 
X-CRM114-Status: GOOD (  15.15  )
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

On Fri, Jun 30, 2023 at 07:41:27PM +0200, irvin cote wrote:
> >The MC field is primarily for use when sending a format command to know
> >what are valid possibilities. If the reported MS and FLBAS are out of
> >sync with metadata capabilities, then the controller is broken.
> 
> Beware having MC and FLBAS out of sync does not necessarily mean we
> have a broken controller :
> MC could be 0 (no metadata support at all) and FLBAS has no way to
> express that, it can only indicate which metadata type was selected by
> the user.
> In such a case we could wrongfully signal metadata as supported when it is not

The LBA Format Data Structure indicates the metadata size for any
given format.

