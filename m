Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CDC77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 05:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=akqWWvNqyjfv/TQVzZ9RV+oiOR
	M+hHTzEly/FKKyWJm96BJYL+cjx9hUGOue6M27ZGPqgssBMRek72SOyFCUzCo+AUuEg0Qe6fTlnub
	4UjgKvmJWK7OttUw2UmB3GsoUOPXCZLFbjjun8NGwwJPogfH8JUsap73ulhy65Mx/+yKlxct9ikA9
	8USJywZJhfPo77Hah2FkRxH6c6szIdL/hv7qe+dTTgKKjqDtF6Nwyy44clMNfUlJo5l8tUKanME63
	aYMT9XLfm1ZN7Xo+MagVSmYHGD2/AupwPCgNpKgZO4FXJZ474+ITiKFAR713DJHZmpoQv2jVcCgLm
	UQfTmS9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Eiv-000jbp-35;
	Sat, 20 May 2023 05:01:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Eit-000jam-2q
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 05:01:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45A0A68CFE; Sat, 20 May 2023 07:01:41 +0200 (CEST)
Date: Sat, 20 May 2023 07:01:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, james.smart@broadcom.com, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 2/2] nvme-fcloop: no need to return from void function
Message-ID: <20230520050141.GB32314@lst.de>
References: <20230519094052.48575-1-kch@nvidia.com> <20230519094052.48575-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519094052.48575-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_220144_067370_DB10645F 
X-CRM114-Status: UNSURE (   8.39  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

