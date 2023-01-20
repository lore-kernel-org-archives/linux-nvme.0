Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C15C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 21:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kNf3zXfOkcaUTRgVzaFf1lUCrh8pqGbP1uGqTNmoGBk=; b=TPLmsz631ykyJIgB+mlRh/TXix
	rbHzxYHNHVixDL8Wey8pdXvTNlM/SZiaE60L7MM4m6C/hbPAM3N+rYK+2XaiYYA70ESbvym2jOUQr
	lQRTsQ+W1KKOEHhn14pygpzAGw/nCTQInmkBVLiInSfhDVgRanOUjZWaXNDYQP+2HaqoRVFk3WrgB
	EhESChlQv5Pqe47xhJKBK5qmb+lWPvGfvGoVSNV4hP1dLZW0ggRzYDI1FcumNt9s8fQGwkvSuZ+F+
	siA69kw3hFHipKi69FK/3+2G+5sinsS7h73CS0D8g9DhKTNwDL7JXO65GWjp9YUFZIqm9xUagM/Re
	ONLwsBtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIz9c-00CQxS-Ks; Fri, 20 Jan 2023 21:42:32 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIz9a-00CQwy-0N
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 21:42:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E472DB82A67;
	Fri, 20 Jan 2023 21:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54521C433D2;
	Fri, 20 Jan 2023 21:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674250946;
	bh=fVNSkKoESPcvgGRk+AdBUaQokIOwJ+lbnnJOPqHaszo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmi0DjjxvXG5OggJ5PdVJRdoAG86I1kLQWTq5TfsOdNaEx9NiGJMl56S79HM+kKnA
	 105dd3896bm5Whv211D+VP9VWf+2iiL4upxwHZOOjEqUT3gwixm4OXtDzSSWkQIBSG
	 /OLjlJlzLgYYR1N04AHuynwEJr1H+AhKs0ZoTpGWrLPeOd4tCi89PgobSTAboPJd4l
	 JcL2OZrvAqKQyhEzDyEZDDJPKeQA4LAf/mh/Lu7w7nvvjywYyUIgfPiZZDSFwzgYR0
	 Xv6VHvVbbbQwbnxZ4ufcV0r49+5Xw5M79UGMIGC7OEKHwc+a2rofbLgY401YUZCCtp
	 RjK9Jk46H5lug==
Date: Fri, 20 Jan 2023 14:42:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_134230_227388_6F97D5E1 
X-CRM114-Status: GOOD (  15.33  )
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

On Fri, Jan 20, 2023 at 02:50:46PM -0500, John Meneghini wrote:
> We have a customer complaining that when they hot unplug/plug their nvme-pci device the device name changes.
> 
> For example, when they hot remove /dev/nvme1n1 physically, then reinsert it, it gets identified as /dev/nvme4n1.
> 
> IIRC there is nothing about nvme_init_ctrl that guarantees the ctrl->instance will be the same because
> ida_alloc() will only return the next free id in the bitmap.
> 
> The fact that nvme_remove ->  nvme_init_ctrl many times results in the same
> ctrl->instance is just a happen stance and there is nothing that guarantees
> /dev name consistency in Linux. Especially in the case of hot unplug/plug
> where the controller may very well be marked NVME_CTRL_DEAD due to the
> ungraceful disconnect.

That is correct. We don't know the identity of the device at the point
we have to assign it an instance number, so the hot added one will just
get the first available unique number. If you need a consistent name, we
have the persistent naming rules that should create those links in
/dev/disk/by-id/.

