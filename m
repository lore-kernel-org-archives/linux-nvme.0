Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD45F433D4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 01:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vN4LCRH2zFd+r1GpwLP5obMDV2tytrGGDaWcrG+6scA=; b=Gv3Kf7dBAQgK962jlUxIF2OUQC
	SjtW3in4LsDIh9wORqha4U+GCrlS7vemiabaHOmgUXgCQp6QHAXQOuD0b2qVQI8IA1IuTKLRz2HlR
	JA8XphhpCt10Qqh1F+NHGajNKQUUHdZqM7dcvOnAvk7LlG9SQFSzvMp1V/6BfLmmbuHyLcQHVr241
	1e9WhVdeifwhoDdiTuxojhk3eXP5cFidUeS64Dx2LN4EStfC6QlgrN52QagqMXWUsZ+etel6EzIO1
	Y2ritmA6/yPZjGdE/ZF7BqhKEgh+A57RaA4MjTBk7gAAOGNrjuWGIOEEI70i1icuIBsVCeSLRjErQ
	68GJ8gcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDBN5-00000001qGW-10kr;
	Thu, 16 Apr 2026 01:18:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDBN2-00000001qG5-2tpU
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 01:18:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776302293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vN4LCRH2zFd+r1GpwLP5obMDV2tytrGGDaWcrG+6scA=;
	b=FE38Or8svUOd7qHxrDetNDcsde6PJ0gYSb/WhHdHpcVaHwLFzjv9gEyFSxoU1SgTjpIsM5
	7yzRFJ9+46F/0PyNbIn9yY5TG+oKGeBflNTVLJWM3y2iJxQR52qihEF9PRgBcmdEHAWHSP
	Fp7uPnaqlT0cWM6ZVqSnLbhAfcicuZA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-dVyUMxZuPeGT3tDqQDvQeg-1; Wed,
 15 Apr 2026 21:18:07 -0400
X-MC-Unique: dVyUMxZuPeGT3tDqQDvQeg-1
X-Mimecast-MFC-AGG-ID: dVyUMxZuPeGT3tDqQDvQeg_1776302286
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F982195608E;
	Thu, 16 Apr 2026 01:18:05 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.224])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B4E43180047F;
	Thu, 16 Apr 2026 01:18:01 +0000 (UTC)
Date: Wed, 15 Apr 2026 18:18:00 -0700
From: Chris Leech <cleech@redhat.com>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvme-auth: Include SC_C in RVAL controller hash
Message-ID: <20260415-coroner-hamlet-36ab7e08cd30@redhat.com>
References: <20260415230824.2790058-1-alistair.francis@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20260415230824.2790058-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: e_FDUARiOKXWzRGNYo6v-uMQG_cjjEr1LPMVDWMw6Sk_1776302286
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_181816_804210_4DB08FF7 
X-CRM114-Status: GOOD (  13.60  )
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

On Thu, Apr 16, 2026 at 09:08:24AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> included in the Response Value (RVAL) hash and SC_C should be included.
> Currently we are hardcoding 0 instead of using the correct SC_C value.
> 
> Update the host and target code to use the SC_C when calculating the
> RVAL instead of using 0.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>  - Rebase using new nvme_auth_hmac_update() functions
> 
>  drivers/nvme/host/auth.c   | 3 ++-
>  drivers/nvme/target/auth.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Thanks, this was a good catch.  Fix looks good to me.

Reviewed-by: Chris Leech <cleech@redhat.com>


