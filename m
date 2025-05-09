Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B309C3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TI+lqoakue1vqU6ntC7FWieJmorrU9xopJiLS6kNlk8=; b=RxMa5Hnlsx8XOjoa2rgIsTNUe1
	x7VngoNt6DQmAtAhsMAbPh7SEDXDDFKLTnI18CRMG51sWmbvM8weJOHR2CneTJzGMLGvj/xZ+85Ik
	c6jZgDcBT+mGUWprPLTTWf25BkrGOgh0pefawTnVAMrcY83lH8zlwjLWj6k88T7/HFH0pb79rvMAX
	5pxTCQogOmNMlaT0JEjdJoURBRdD62JfLRIuj97dgDt36oIYV2blKCmKUgOh3/EyA1ti6O2U3E6K+
	nsPqNSiBxmWPC6qdqaQwQeJPVXswBzAgwvwirwArZin6OSbP7yKYoMnvh3twUS/DOuPPvlPza3IEy
	V/9IlnSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRdf-00000004SFn-12rH;
	Fri, 09 May 2025 17:35:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDPiw-000000045ze-42Vj
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 15:33:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3AE7E45271;
	Fri,  9 May 2025 15:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB2DC4CEE4;
	Fri,  9 May 2025 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746804798;
	bh=tB/bA2V/t/WDghyifCPPVUC+NmJx1TaJ7jE6vGRPhhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIFKnhbagbG6+u/7+8B+raQGdnQu/ArFoxlt/FPx5TJaPe2NZy7tHaF3ZJT0r70pl
	 I+6xM7ogC0Wu6txdyKiGABgGfXLd38eaqaHHw8XwrGlC4W48+mgzRFKTIDNFfQqgrR
	 SKKsbbY/zESVDrC6u4G7iYU751ZrOsWfBBmvlzuOkYt4Ap8auu1oiS67JciK2LkIJK
	 p0K22WyHy01JNjUmTgdqViTBsyl4RDYX8DQt4LfRh0zCzNK52YhVWIBkS3uDO5f/sh
	 fa1zajQ2iWGNowrmmwH3C/KlQJCGnZgX3mbVwythT93mzaHVxprceIEZgcgW4jZ7tx
	 /9YWfUSQMmHnw==
Date: Fri, 9 May 2025 09:33:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bryan Gurney <bgurney@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@kernel.dk, jmeneghi@redhat.com, mlombard@bsdbackstore.eu
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
Message-ID: <aB4gO7mAYDO3Bm3A@kbusch-mbp>
References: <20250509151627.20434-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509151627.20434-1-bgurney@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_083319_019690_0D1534EE 
X-CRM114-Status: GOOD (  10.56  )
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

On Fri, May 09, 2025 at 11:16:27AM -0400, Bryan Gurney wrote:
> +	if (has_uuid) {
> +		list_for_each_entry(h, &subsys->nsheads, entry)
> +			if (uuid_equal(&ids->uuid, &h->ids.uuid))
> +				return -EINVAL;
> +		return 0;
> +	}

You're returning success too early here. It may have a unique uuid, but
that doesn't mean we don't want to check for nguid and eui64 too. If
those are not unique, they need to be blanked out to make sure we don't
expose these on the namespace's sysfs attributes.

> +
> +	if (has_nguid) {
> +		list_for_each_entry(h, &subsys->nsheads, entry)
> +			if (memcmp(&ids->nguid,
> +				   &h->ids.nguid,
> +				   sizeof(ids->nguid)) == 0)
> +				return -EINVAL;
> +		return 0;
> +	}
> +
> +	if (has_eui64) {
> +		list_for_each_entry(h, &subsys->nsheads, entry)
> +			if (memcmp(&ids->eui64,
> +				   &h->ids.eui64,
> +				   sizeof(ids->eui64)) == 0)
> +				return -EINVAL;
> +		return 0;
>  	}
>  
>  	return 0;

