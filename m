Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C44ECDFA1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 23:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4wkCEvbItL3WZKrzfXnbN6Oj08YbUXmiC9XsodxCFkg=; b=4IOzoQz4AIL7eDR4wSshgrg7zt
	MyQrXU0ZNWXAeNfYwOwoY+nMBNpYXk64J+Z1B5YeT+cv6qsTZPHLQgXwNvj7toiMVcXSKA1lqziWQ
	KFlUlEW4q0x4SP11V7H/TOp/vZndbXzC5IPAK3VaS0ijxfCN4Awe+B86qBOWcZHuS7y0ZPmMAgYT8
	vHvDoRAA2gQg6YAdsYItta2VH9yYeSsk9a6CG1OYV+MTP4Y1PzIW4vA2MUPuSI4BLz7sQ2Jy5M+FH
	jFHyqTXVOCYq7GhFo/EfCVMAgaKuK2SFP60bEPECJ58URPQuU8LBSftT1Y3o0rVDwE5jonaNw3yFz
	ngLh5d4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onT34-007Vra-MX; Tue, 25 Oct 2022 23:09:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onT32-007Vqg-Kf
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 23:09:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5A6E661BA9;
	Tue, 25 Oct 2022 23:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A3AC433D6;
	Tue, 25 Oct 2022 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666739364;
	bh=qXV1N5AKEWYecLSXfGCSgGxs5o9LCx1bJAfsulfc5Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjDd0U0F2OoXbekqFRjqb3s/W48Cuh+oqk2oy+Ac9OxFFqoyt+ieE64Z1ucRgfMiB
	 L2PfT0rpmyTvHtMW3eYaa/VBacQgzc5VIfxK9ntw1YYxWS/xRDUtfk/EPhT4Bw85SR
	 AfJJEKb9rZBWfuIe4kWTJn6vFGMhMlTIx4JUvvdwxV1JutQm3zxI9J9XB5CVvWPvlt
	 nCf2+QRvU9N1Vy8jSnUpm01UI7K1XAtZyrcYMmCHRZcrakXsKoCQcx7ahNzHodfIUk
	 dedGaKza/pqZPMp28jvw1bD54MfB7c567risFLqF4PWEh6jygeaSzk7W5wjdmSv2S/
	 cTh6rRfm7NtGw==
Date: Tue, 25 Oct 2022 17:09:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, oren@nvidia.com,
	chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Message-ID: <Y1hsoZNjDMhDbemd@kbusch-mbp.dhcp.thefacebook.com>
References: <20221002082851.13222-1-mgurtovoy@nvidia.com>
 <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me>
 <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com>
 <20221025151914.GA23422@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025151914.GA23422@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_160928_748621_0EF19423 
X-CRM114-Status: GOOD (  21.12  )
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

On Tue, Oct 25, 2022 at 05:19:14PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 03, 2022 at 01:16:36PM +0300, Max Gurtovoy wrote:
> >> I'd make this named nvme_pr_type
> >
> > Most of the enums of this header are not named.
> >
> > I don't understand what is the convention here.
> >
> > Usually, if it's not a new header file I'm trying to keep the file 
> > convention and this is what I did.
> >
> > If all agree on named, I'll send another version.
> 
> I think named is better, nvme has some weird unnamed enums that
> even combine totally unrelated fields which I always found confusing.

It's carry-over from the early days when structures had so few constants
that giving each field values their own enum looked a bit silly, and
enums were considered better than a bunch of #define's.

As far as naming them goes, if the only usage is its definition, then
what's the point? If there's a use for a named enum somewhere else, then
yah, that improves readability.

