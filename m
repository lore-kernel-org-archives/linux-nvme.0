Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121DDC3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XM0iWyJOe3c+/RiaPTFV57HeHzaWMj5q7/dFUWmvh5c=; b=j/bH/5q2df/epyU9MYuTfRXyUH
	H25/QcBa+tdMsOSny5zmPtRGfhGMVoYroyWeOr4PROx4TMDVbxj7gy1HuelG67rO8eIj3O8rK/T0g
	h6QntG7mjei3vbszu07sDOG9ywCEP30mR00xBZOpp5BBC142doaNHXP/Y+Pbvqf+rVe8KYhqLzYlX
	/nz0dqneR4OtN3r4jJtTn+5Fu3YpvZs+Pn0M5+Q9QItopn/uNgr2cvmvaCnv3pn6bA81Sd+kOJ+Gj
	az9Sl8VQAjH/HEIoCVOzcVvG06fYCNW5NbnvKvP3O9A69iAvX48ITPlNKn8Ukefn6bjY8DpLUOMB5
	2kkYXdQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGpF-0000000CmZ8-0SqW;
	Tue, 23 Jul 2024 14:49:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGpC-0000000CmYT-12U8
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 14:49:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1D5C68D07; Tue, 23 Jul 2024 16:49:05 +0200 (CEST)
Date: Tue, 23 Jul 2024 16:49:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 5/9] nvme: split off TLS sysfs attributes into a
 separate group
Message-ID: <20240723144905.GC20994@lst.de>
References: <20240722120226.88737-1-hare@kernel.org> <20240722120226.88737-6-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722120226.88737-6-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_074910_450151_A3BFEE66 
X-CRM114-Status: GOOD (  17.44  )
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

On Mon, Jul 22, 2024 at 02:02:22PM +0200, Hannes Reinecke wrote:
> +static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
> +		struct attribute *a, int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp"))
> +		return 0;
> +
> +	if (a == &dev_attr_tls_key.attr &&
> +	    !ctrl->opts->tls)

As-is there is only a single attribute and you don't need the check for
the specific attribute.  And the point of making this a separate
group is that we'll want to not have that check in the future as well,
right?

I would have also kinda expected that this attribute group lives in
tcp.c, is there a good reason to keep it in the core code?


