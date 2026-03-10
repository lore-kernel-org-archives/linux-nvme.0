Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96520FD4F13
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGYykbg+OoPSVrBuSLqw+hISIdL4nGnaMw8Q0N/GNyc=; b=AAtcRnP6rUiAeMPKMXnGUvUKqL
	g+dIQRnHCp8zEjG6UrHnkV34CZgazBssF1BI0u2e2tK4LWEPGcTJdmkUyQEDahh+G3KeZOqIJV9B4
	JCUxZVX95LtWfwJc6VvAFMF16YvBrAD5APW39QoVuMcaviaTTn/pJkJ7mlaa9e+31iCxMcgEHDzhj
	ByROgpt5oRD+3E/76tVhwZhsPE+Sl0SOyEALwOWqHF6aILG7exCikdtx7N/yhxV0Lybr1uS4LeRbP
	3XVz1bCtBjeE6eGgSBwTa/BgrM0IolL4j0xu4p8MgFWdpO8LsoGXjKq8zKRyZEUaYXy2dVPC95n1I
	Xek/HllA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01UE-0000000A2f7-2ggY;
	Tue, 10 Mar 2026 18:07:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01UB-0000000A2ea-3Sr2
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 18:07:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773166033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGYykbg+OoPSVrBuSLqw+hISIdL4nGnaMw8Q0N/GNyc=;
	b=IOcaMiQOgF+qcn76jHg1klgeS1iCcFydtnHj8v00kd/9Vz4Kt5sM4d/6eZbnvSxRGPUM7u
	J6WTswNR/omelRYax+p8wwXxwCeeT6qKAQKlz63S4vCY5QNW/GVs/V9X0l6UO4xmbDZYHU
	WNgI5GoyjqUHoIf68ayI+5n+0aElfus=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-O2SzThmCOQKKxDcn1RdvDg-1; Tue,
 10 Mar 2026 14:07:07 -0400
X-MC-Unique: O2SzThmCOQKKxDcn1RdvDg-1
X-Mimecast-MFC-AGG-ID: O2SzThmCOQKKxDcn1RdvDg_1773166026
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8695118002CD;
	Tue, 10 Mar 2026 18:07:05 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.255])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED368180075C;
	Tue, 10 Mar 2026 18:07:02 +0000 (UTC)
Date: Tue, 10 Mar 2026 11:07:01 -0700
From: Chris Leech <cleech@redhat.com>
To: yunje shin <yjshin0438@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, ioerts@kookmin.ac.kr
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN:
 slab-out-of-bounds)
Message-ID: <20260310-ladle-underuse-50f571ba519c@redhat.com>
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
 <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
 <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
 <CAMX6_QH7xiTxLbF4pZHVs9Umw=j70c-dmb3t97c6XBEEEg-kpA@mail.gmail.com>
 <20260309-scalding-propeller-e00bf0af6519@redhat.com>
 <CAMX6_QHe04XZR9s_eD8vg0njhkvLn4B+Xx2cW4R1gcKZFsw4TQ@mail.gmail.com>
 <CAMX6_QG_Xx=1shB+76GKdMyB3-JW9nRiC+1vik=382FyFCT9cg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMX6_QG_Xx=1shB+76GKdMyB3-JW9nRiC+1vik=382FyFCT9cg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: V36GnP8X8ZSN56BnpvDzoc5iNxFDmCSoZtMdnnShvH0_1773166026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_110716_270677_7B547722 
X-CRM114-Status: GOOD (  19.61  )
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

On Wed, Mar 11, 2026 at 02:52:36AM +0900, yunje shin wrote:
> Thanks for the review.
> 
> Yes, I triggered the KASAN issue by injecting an invalid dhlen The
> reproduction steps are:
> 1. Connect to the NVMe/TCP target on port 4420 (ICReq + Fabrics CONNECT).
> 2. Send AUTH_SEND with a crafted NEGOTIATE payload where dhlen=200. 3.
> The kernel target code in nvmet_auth_negotiate() then iterates
> 
>     for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
>         int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
> 
> With dhlen=200, this reads idlist[30..229], but idlist[] is only 60
> bytes (indices 0..59). The accesses at indices 60 and beyond read past
> the kmalloc'd slab object into adjacent slab memory, which KASAN
> catches as a slab-out-of-bounds read.

Thank you, I appreciate understanding how this was triggered.
 
> While the standard Linux NVMe host driver does use hardcoded halen=3
> and dhlen=6, the NVMe target is network-facing and must validate all
> fields from the wire. A malicious or non-standard host can send
> arbitrary values. The same applies to halen — if halen > 30, the
> first loop also reads out of bounds.

Yes, this code absolutly should validate halen and dhlen bounds.

> Regarding idlist_half — yes, idlist is currently a fixed 60-byte array
> and the DH offset is always 30. I derived it from sizeof(idlist)
> rather than hardcoding 30 so that the bounds check and the DH offset
> stay consistent with the array definition. If the struct ever changes,
> the validation adapts automatically instead of silently going stale.

The 60-byte idlist (and 30:30 split) are part of the NVMe specification.
It's the maximum amount of space while keeping to a 64-byte struct.

I'd rather see this made clearer with a define for the limit, but not
adding code that appears to calculate it at runtime.

Thanks,
- Chris


