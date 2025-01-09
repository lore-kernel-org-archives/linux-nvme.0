Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DF6E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8z5CkXWyMi/D4Z3NOATWeozJt2iBFHFltpjHR+p5wAU=; b=4W3QQfG3/1k4XLYw6R2fnEEO7V
	sq5Vz2YCqVi5Gse1tAvzC0YIxnaSuKoWIzO4aZC1aBYUvRalArXiIJYYo9x9trnVQ5dH+N0MnpxSr
	f8Gu6b0FqgllcIVkW9VVY/1VjiDXvO6Q5fFmbuxHcyy25KSeWNIZtDi4TtLqZg/1zuObW//LwZ7hq
	DnN15URROvXnpB7orroK8lOScRh5aUuQglJRyFgVSf0AoifW7I19eRPO0ebwWNIFk5BiR8yoZjHwD
	H/7z2185v94KwOb/8OVryFYwu8Mdg87dDL26vhRdLAw049iKOXXTMjx3BDOVCnWsvxFU55XepV6RR
	kkDv5YDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnh8-0000000B9gC-3ur6;
	Thu, 09 Jan 2025 08:15:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnh4-0000000B9fn-2wdY
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 08:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736410505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8z5CkXWyMi/D4Z3NOATWeozJt2iBFHFltpjHR+p5wAU=;
	b=EhNFsjNF1LuZD4XYm8Tks53nmpWqBkoIh9snKZRNU1GK2coHO0tVdAhx8ggiSPpAUkTD51
	21RnH67yuX0LnQrEA6XduPOMlnfxGQDYfRg4PPJLWH/Wg7nMQyE3qCF3B09hSobdAB7sj5
	msqmt8sRjeW9sRSeE/GVZO9Cc2LFL4A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-8fCmwubBOUKYHjEKZt6joQ-1; Thu,
 09 Jan 2025 03:15:03 -0500
X-MC-Unique: 8fCmwubBOUKYHjEKZt6joQ-1
X-Mimecast-MFC-AGG-ID: 8fCmwubBOUKYHjEKZt6joQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FFD91955DD7;
	Thu,  9 Jan 2025 08:15:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.139])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6724519560AA;
	Thu,  9 Jan 2025 08:14:53 +0000 (UTC)
Date: Thu, 9 Jan 2025 16:14:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 03/11] block: check BLK_FEAT_POLL under q_usage_count
Message-ID: <Z3-FePovuu2dEbfG@fedora>
References: <20250109055810.1402918-1-hch@lst.de>
 <20250109055810.1402918-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109055810.1402918-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_001506_808982_452806F8 
X-CRM114-Status: GOOD (  13.24  )
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

On Thu, Jan 09, 2025 at 06:57:24AM +0100, Christoph Hellwig wrote:
> Otherwise feature reconfiguration can race with I/O submission.
> 
> Also drop the bio_clear_polled in the error path, as the flag does not
> matter for instant error completions, it is a left over from when we
> allowed polled I/O to proceed unpolled in this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


