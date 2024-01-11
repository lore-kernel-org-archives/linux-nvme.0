Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0032DC47077
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pDrA/wsRRpRnHSTNX7rKAsJFAQ2h6Xmk1YIZh0oYqJE=; b=I3KXxnEO1l5OHPNKIggB242Da0
	BEcV1OKsk9bxhY5d9i6XjjciTZHYlH7NrbEqnTkjJ5Wik+MreMgMwoZeZ91KJe0lWMiGVhCr6lsN0
	8ZNnx1I6djqutrmhhMv/jcFWKA45rzrodemeYrAKhm59AX326TmMHJYlgs6uBgPPUQ7qmq659e1TX
	9fVf4zhEnxJH2iyE+ygO3xVQW57aQOIrXK/yPCltSMm/8YT2dXUxkdorDRoXcmu7cCjBG99uUsioC
	iKmv75KsZi3TGNsC0q0TsRxHZcu6OdMwbANmiQWAYzenRBpquXM1EWXhn4ymTuVQslwPdULxiqM9w
	9dmpE+yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNp7X-00GD1K-0v;
	Thu, 11 Jan 2024 07:04:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNp7V-00GD07-0V
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 07:04:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2785E68D08; Thu, 11 Jan 2024 08:04:43 +0100 (CET)
Date: Thu, 11 Jan 2024 08:04:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Message-ID: <20240111070441.GA7889@lst.de>
References: <20240111000855.1800481-1-alan.adamson@oracle.com> <20240111000855.1800481-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111000855.1800481-2-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_230453_341357_E6E6DF5D 
X-CRM114-Status: GOOD (  10.26  )
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

On Wed, Jan 10, 2024 at 04:08:55PM -0800, Alan Adamson wrote:
> +int nvme_sysfs_add_passthru_err_log(struct device *dev)
> +{
> +	return sysfs_create_group(&dev->kobj, &nvme_log_attr_group);
> +}
> +
> +void nvme_sysfs_remove_passthru_err_log(struct device *dev)
> +{
> +	sysfs_remove_group(&dev->kobj, &nvme_log_attr_group);
> +}

Isn't the normal sysfs convention to have an is_visible method
instead of dynamically adding/removing groups?

Otherwise this looks good to me.


