Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9C9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDZ6MdWujcD2qa7MjmjgNCV4qox44Ncx+JEvxCyLRJk=; b=dBWoyi8gstCC/4RarFWAKU5mkk
	U4qTMb/mFvH2Bx5ywtUPeoqvqbzxOThv1d7KK3WcaTx29DZQPY+s/ehIV8bkrrZVBrJG/0SDWXcBQ
	9LCOsQYi+8aCtlVTcqcbqGb/9x/iXjNF5cc6CMcoxsrRECPKK0Tam5AAL/sFDHDg/9MJ/urCALobz
	OdQ1GFBPLxbLcqJ/27dNvoY77asmvMa87hNQ/mUqU/AwQ8r9iVqUsIuE3HZTBCeA1v2w+Y9gcBEsG
	jTFTAjtdMXPereddAcBQtghJ2jLYp5uR4VRLTszvT470hDs+TkZ6ThXSFUZFS+oee0/BqTVINHqUb
	MXondhWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2F1-008EAL-1J; Tue, 15 Mar 2022 08:09:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2Ey-008E9p-AX
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:09:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0BE9468AA6; Tue, 15 Mar 2022 09:09:09 +0100 (CET)
Date: Tue, 15 Mar 2022 09:09:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvmet: restrict setting of discovery_nqn to
 discovery subsystem
Message-ID: <20220315080908.GB3082@lst.de>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314105333.56714-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_010912_536285_70FD51F7 
X-CRM114-Status: GOOD (  20.60  )
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

On Mon, Mar 14, 2022 at 11:53:32AM +0100, Hannes Reinecke wrote:
> Changing the discovery NQN only makes sense for the discovery subsystem,
> as any other subsystem can only have one (fixed) subsystem NQN.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/target/configfs.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 9b94af2444b2..58124abdbf62 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1310,6 +1310,12 @@ CONFIGFS_ATTR(nvmet_subsys_, attr_model);
>  static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item *item,
>  			char *page)
>  {
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	/* Only the discovery subsystem can have a different subsystem NQN */
> +	if (subsys != nvmet_disc_subsys)
> +		return -EBUSY;
> +
>  	return snprintf(page, PAGE_SIZE, "%s\n",
>  			nvmet_disc_subsys->subsysnqn);

This completely breaks the existing ABI.  This attribute is shown on
the "normal subsystems" and in fact only exposed for those so far.

It is a fairly recent addition by you and without nvmetcli support, so
maybe we can revert this entire attribute to redo discovery controller
handling, but as-is this patch seems rather broken.

