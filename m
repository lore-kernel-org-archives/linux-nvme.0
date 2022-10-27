Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C421FA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ouVHjes5/dwtDQy2o9+LjpnxMZGXDGl3Qzo2LcjI8ks=; b=YE5jXhhdGO6mgSWH/ED3m6ZwE7
	nEGTAFnt5AHXiBICkcDuYnLBQvHSeu252EKYxGlWlOTI4Lwb+pKsiX3X0IeKBvMzysvbaqXe9rA6R
	R1ynogdoM9FxYViIVLTWc9p7xYDoYrAnJGUDInuUwKNM2BqKLWALa7Yo5s4lWY8XixlXX38kO/3Me
	MqrW5mQRLFkHKgL3Dy3ib3q4WjnLK6gLkD5gT+YwiqR1c0XESazXyy4rOMqEydygusUx0LvBo/v4X
	IqP6xpGsatSZQuri3FNjNC4gATdKjbM7uOb9h91EF3Wev36FvDcc0TxeqrLm6WY77P0g2RJBEMnpv
	snIFxT/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6Ud-00EKNu-6b; Thu, 27 Oct 2022 17:16:35 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6Ua-00EKMp-8Z
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 17:16:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A8176B82722;
	Thu, 27 Oct 2022 17:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51187C433D6;
	Thu, 27 Oct 2022 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666890989;
	bh=Zv1urG2jYQaq1bwAIZsRNHzXXofeTcjsquQZ1JK/QeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGJsYnEuWS+K6DSZJyqGk9h7+UlxzI7TXzj+qO22QI7ToXiO1fVWN+j76gB8sX7Cz
	 ojM/f3uvD0/0q3cMHCrXNwuHAo34g3e5Kf4BPaNDJDFaE0ddx2xdihE+jErpS2Q0pw
	 TTflV6I2WpUCJlR3OTvSSAsfXcnW6nCASi9kpvA5yGYF2Jdvfqv37dBALCjlnKpPoK
	 Fv6Iv3G58jhDYxSiv7ItE1rsTg1yExOqftvAJ3uBAQF80p/aqpnas8l6CD9jK+IIlb
	 1m5EZNGdZIQMM1Qz5dPM0UrTRxUT2uqsGvV9pr5YKSZc+RP2yxYLxCctGqrKlCWoV3
	 LIHunXvjG0suw==
Date: Thu, 27 Oct 2022 11:16:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: michael.christie@oracle.com
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 10/19] nvme: Move NVMe and Block PR types to an array
Message-ID: <Y1q86YvRtZPBJDck@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-11-michael.christie@oracle.com>
 <Y1qhXQYOpEUk2uqF@kbusch-mbp.dhcp.thefacebook.com>
 <a74266ce-3839-5d2f-abc4-cb30045d811c@oracle.com>
 <75564e1d-3169-cd50-ea17-53ef96a3a35e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75564e1d-3169-cd50-ea17-53ef96a3a35e@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_101632_465785_F51965C2 
X-CRM114-Status: GOOD (  12.63  )
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

On Thu, Oct 27, 2022 at 12:13:06PM -0500, michael.christie@oracle.com wrote:
> Oh wait there was also a
> 
> 3. The pr_types come from userspace so if it passes us 10
> and we just do:
> 
> types[pr_type]
> 
> then we would crash due an out of bounds error.
> 
> Similarly I thought there could be a bad target that does the
> same thing.

Well, you'd of course have to check the boundaries before accessing if
you were to implement this scheme. :)

But considering this isn't a performance path, perhaps these kinds of
optimizations are not worth it.

