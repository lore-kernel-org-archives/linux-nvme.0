Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA340C19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 07:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7yGkZAn/OmXQli8ICq0HHq+oMvsON2swusFgrcd4TyM=; b=gh8iKF/uBW49aQjYGpYGxvuExn
	5qKtXkNfpE6AWmiNuO0di3jK/etIlZ5A2yqocTwhk/IMxclW0yY+usJwdRGPZ9oN/hdVrQnRiLLEn
	Ccbc75drmwUCsCENLtDmKmsHTKNIYn84HgzFv9W1DoJD96FJeGo55JM6lqse7AS3t22LzoHMgkWhs
	SBXmIEjbzie+9tA03KjmPFDctCqNroWM2b0s4RcNLqDmzEhpJpTBHTrC6lImJBI/Ky6bXoMN1ke6C
	2hzeGQ5Oe2WjfEOtQaL0lNjmkzyy7r33GMNT76D/jP+3ixL9d9wpYdmzm9nZKPqwgglq+bucBhkKA
	br+YLkSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJXZ-002KCI-C4; Tue, 09 Aug 2022 07:20:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJXU-002K9E-9M
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 07:20:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8814668C4E; Tue,  9 Aug 2022 09:20:29 +0200 (CEST)
Date: Tue, 9 Aug 2022 09:20:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 08/20] nvme: Add helper to convert to a pr_ops PR
 type
Message-ID: <20220809072029.GE11161@lst.de>
References: <20220809000419.10674-1-michael.christie@oracle.com> <20220809000419.10674-9-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809000419.10674-9-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_002032_495163_D00B4538 
X-CRM114-Status: GOOD (  11.39  )
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

On Mon, Aug 08, 2022 at 07:04:07PM -0500, Mike Christie wrote:
> This adds a helper to go from the NVMe spec PR type value to the block
> layer pr_type, so for Reservation Report support we can convert from its
> value.

Without a user this is going to create a compiler warning.

