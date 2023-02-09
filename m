Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D714FC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 05:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVXEkJ44UOaSvGnDlk3c4boXtILdVJ5UVQM5njCTD5c=; b=QM8qk66Oou21HOsxTCHzGYBk5P
	Jnr53bZhlrATlml0l10izOri3U5SkvvN9TVKUbhLpaCOc7hHirOlFCf6pJJ3bgS3+lVlb1MbRRsXm
	IjXJB8+IHaupttiJMBjYvTh2fPKJxNgkPJIckl866qyx/nkxdtTJPQ69UIicvjxdDNMj366mUdYxY
	J99RGzg+/w/gVcp3ijKwFhiBFCTWwSJ0Ll2C244J9f7xOsfm3PIYqcO8T0NfcI454iEBqUU9m3Qw0
	VMF2hX8c/gbE0BWmFruylKSrqMDHNGY2yk9rJAYTgZqSQETugqRReMBx/SlVUqHXudgvnrZsA8HLx
	ARDYaUQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPzJs-000CAk-6h; Thu, 09 Feb 2023 05:18:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPzJo-000C9i-MC
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 05:18:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7C8367373; Thu,  9 Feb 2023 06:17:45 +0100 (CET)
Date: Thu, 9 Feb 2023 06:17:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Irvin Cote <irvin.cote@insa-lyon.fr>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci : rectifying the nvme_probe teardown path
Message-ID: <20230209051745.GA8420@lst.de>
References: <1517857586.68818728.1675870734911.JavaMail.zimbra@insa-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517857586.68818728.1675870734911.JavaMail.zimbra@insa-lyon.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_211800_914339_7E7C2EBC 
X-CRM114-Status: GOOD (  17.10  )
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

On Wed, Feb 08, 2023 at 04:38:54PM +0100, Irvin Cote wrote:
> >From ced363dcd3ef076e509bfbb4ce9815ebaff6aee7 Mon Sep 17 00:00:00 2001
> From: Irvin Cote <irvin.cote@insa-lyon.fr>
> Date: Wed, 8 Feb 2023 11:38:39 -0300
> Subject: [PATCH] nvme-pci : rectifying the nvme_probe teardown path
> The nvme_probe teardown path did not account for
> undoing the work of nvme_pci_alloc_dev, which is
> what nvme_pci_free_ctrl seemed to be intended for.
> Thus I displaced the call to nvme_uninit_ctrl
> from nvme_probe to nvme_pci_free_ctrl and added
> a call to the latter in the teardown path of nvme_probe.

Can you explain the problems you are seeing?

> index c734934c407c..db480bc64c7b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2731,6 +2731,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  	struct nvme_dev *dev = to_nvme_dev(ctrl);
> 
>  	nvme_free_tagset(dev);
> +	nvme_uninit_ctrl(ctrl);

->free_ctrl is called for the final put of the ctrl, calling
nvme_uninit_ctrl here does not make sense.

> -out_uninit_ctrl:
> -	nvme_uninit_ctrl(&dev->ctrl);
> +out_unalloc_dev:
> +	nvme_pci_free_ctrl(&dev->ctrl);

Also calling nvme_pci_free_ctrl directly and not through the method
table is also wrong.

