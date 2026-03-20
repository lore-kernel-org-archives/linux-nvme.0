Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C800109879E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CeFWF30cJFOlAu2FX7TnkDgLG4ViuaQJmdWgPCwTBjQ=; b=Gz+JHtcCuc50gDJp46DrYikFgu
	IrBXLGtP4ihiXNm+SHUd3uMWxR8NrNrRSwQJgw0yPmd2+qJuxunNYh03rbXIQ0pmZTl/1GgJbTQmo
	7+gd655/2X/IVrCtjk4WJQSb7GrvtBnXoH4/n3d1sCPXN1DE4JGAkJCp5+3mVb5wzhx50rUG21o0q
	2V4xjmI1ryokjhJUxgMbk5SLIlB0bR5XW8V5bj9MbTzA6dD+hfaYeE5ffhuJpdPdzvodVXQGHAkn/
	c+RgDcsJ2sTINovarPYTBuT+QKxDxmrohYPbl6l1/TqzFu1ll6nEBYg9MEroCMdcK1aaEyIVV+tBC
	uNt/tW4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3cL1-0000000D5Np-1zRj;
	Fri, 20 Mar 2026 16:04:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3cKz-0000000D5NU-33p5
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 16:04:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774022676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeFWF30cJFOlAu2FX7TnkDgLG4ViuaQJmdWgPCwTBjQ=;
	b=VCTzzl1RPAd6UwjkR4BXXdkGZLTdJc4HdQAIHA5KVj2IfJXQhGYqtblEwZTdB5gmobwazO
	Qttv6LUxjDC8Nlc4pZkuaB764WjJKSnv+te9k4+CriQo7kI53ZuYhYnYowYAqsaBKrz5fY
	BIHUF71gvDgRaC6AjtjOSLvQHzOd75Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-ACC_PRoLONaKx1as4az1tg-1; Fri,
 20 Mar 2026 12:04:30 -0400
X-MC-Unique: ACC_PRoLONaKx1as4az1tg-1
X-Mimecast-MFC-AGG-ID: ACC_PRoLONaKx1as4az1tg_1774022669
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2D6C195605E;
	Fri, 20 Mar 2026 16:04:28 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 80DE430001A1;
	Fri, 20 Mar 2026 16:04:25 +0000 (UTC)
Date: Fri, 20 Mar 2026 09:04:24 -0700
From: Chris Leech <cleech@redhat.com>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yjshin0438@gmail.com, Alistair Francis <alistair.francis@wdc.com>, 
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: Re: [PATCH v4 2/2] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL
 with SC_C
Message-ID: <20260320-gallows-squealer-43a95debdd62@redhat.com>
References: <20260320002045.1927526-1-alistair.francis@wdc.com>
 <20260320002045.1927526-2-alistair.francis@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20260320002045.1927526-2-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: wVO5EFY3jsR7gVqsDiahwhvyN-wwlHvd1_J24vBwjm4_1774022669
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_090437_839429_002079C2 
X-CRM114-Status: GOOD (  11.18  )
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

On Fri, Mar 20, 2026 at 10:20:45AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.2 of the NVMe 2.1 base spec states that
> 
> """
> The 00h identifier shall not be proposed in an AUTH_Negotiate message
> that requests secure channel concatenation (i.e., with the SC_C field
> set to a non-zero value).
> """
> 
> We need to ensure that we don't set the NVME_AUTH_DHGROUP_NULL idlist if
> SC_C is set.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Looks good.

Reviewed-by: Chris Leech <cleech@redhat.com>


