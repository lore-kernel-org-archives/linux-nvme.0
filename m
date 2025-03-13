Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C51FC282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 06:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k9JhKjMkgVQElkxRxhb/hV4J8R3LNXAfdESv36gNoHo=; b=W49T7c5ZIQH39GktHWhXAggoP9
	iyvm5RUSMAbmbrNoXFJKHa+jMvjthiGWCTy4SFDvJqAm+9RpWwgS5CEqZRH0T9RlkRLcxIpv9etHB
	RMKBzWAQEUjKIsnO1qkijvwMeHkGY9INOb9Hn3DklKZquPE/+1DYEqBdZQmTKO9rzFcXYIWtU5oZI
	Bv9GwvkvxqjqV/4CSdVt2geBt6wXDP9+xshvZOA49mG1JWXhiTig/RIGqyUQoWoQUtlLSwnuW2dJ5
	hUdM7wbbX5GKDoG/EFxH9+g/IGK5EKtorh/jf2cHJcQh0OTomjRfJRnftDF4aavs1wHOYd2QJzgRg
	K9/E2odQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tscD7-0000000AEia-07C4;
	Thu, 13 Mar 2025 06:38:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tscBa-0000000AEXn-3jh9
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 06:36:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8287768D09; Thu, 13 Mar 2025 07:36:51 +0100 (CET)
Date: Thu, 13 Mar 2025 07:36:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: chaitanyak@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 02/11] nvmet: Export nvmet_add_async_event and add
 definitions
Message-ID: <20250313063651.GB9967@lst.de>
References: <20250313052222.178524-1-michael.christie@oracle.com> <20250313052222.178524-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052222.178524-3-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_233655_071895_797BBA92 
X-CRM114-Status: UNSURE (   9.94  )
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

On Thu, Mar 13, 2025 at 12:18:03AM -0500, Mike Christie wrote:
> This exports nvmet_add_async_event and adds some AER definitions that
> will be used by the nvmet_mdev_pci driver.

Can you add a little explanation why mdev needs it by pci-epf not?


