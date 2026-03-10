Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5AFFD4F34
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 20:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ph8h7Z3c42DjREBZqPAGzIBfE7ES/TtS9+NAaOI9FsU=; b=BvutsBS3PVzsi24oxTzbEQRayM
	VJb9yDinMgXo/LzBLaIyFAsffw5p4O7pXv0gG5ytf3TELtI5qBHhLujC3j66Iiw5Mi+YPssnaaHTs
	aKZcF6lnVDHJRzBy7H76Cae4qEO97TeE3tYfIKEN61sgBn0V4V1dHFU2X+AuTbMXIdsg3511JnvY+
	C+9H8nEwRCe7nAq8SooMrD7pDA5V5HqQsI199lHbRxTfTEuVQ31OZkTOqTVDPCgw2U5OuoGyFmSjQ
	RGzkpCttH7KSclGWwuvvScYfZ5Wd8OoTgK/faK2sVJxlzWQ7QmSxvNhlBXswvYorPbhUkKuFsxU9z
	ivwXi6QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w03zE-0000000AGXQ-0d1M;
	Tue, 10 Mar 2026 20:47:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w03zB-0000000AGX3-1VAN
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 20:47:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773175644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ph8h7Z3c42DjREBZqPAGzIBfE7ES/TtS9+NAaOI9FsU=;
	b=D8DD6K1Qrf2pnFvYegPeyi8/colxVXBHcynNqJGT8XC49qwwdoIAiSnM9yS5JEIy+eQIsQ
	sAnvjodo3y3ACEY4Qvg7B2vICOPEZ+HHAGfrphrxmfHPTA5jI/mA8kRpXj8qRDNdNzHK12
	plxm2Q0ADFtPxOw7zZOs58HzZoQkaIw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-cXEsoc7_P_KZxh4XoI7n5Q-1; Tue,
 10 Mar 2026 16:47:17 -0400
X-MC-Unique: cXEsoc7_P_KZxh4XoI7n5Q-1
X-Mimecast-MFC-AGG-ID: cXEsoc7_P_KZxh4XoI7n5Q_1773175635
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5725195608E;
	Tue, 10 Mar 2026 20:47:14 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.255])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9064D3000223;
	Tue, 10 Mar 2026 20:47:12 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:47:11 -0700
From: Chris Leech <cleech@redhat.com>
To: YunJe Shin <yjshin0438@gmail.com>
Cc: hch@lst.de, hare@suse.de, ioerts@kookmin.ac.kr, kbusch@kernel.org, 
	kch@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me
Subject: Re: [PATCH v2] nvmet-auth: validate negotiate payload length(BUG:
 KASAN: slab-out-of-bounds)
Message-ID: <20260310-video-foyer-58fbf3080e9b@redhat.com>
References: <20260211160859.GA11869@lst.de>
 <20260212013338.1417091-1-ioerts@kookmin.ac.kr>
MIME-Version: 1.0
In-Reply-To: <20260212013338.1417091-1-ioerts@kookmin.ac.kr>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: v6zLM4yQSX9XXgzlaO0RO17MWZIvS2cwxZrRJCx7qBA_1773175635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_134725_468975_CAC04B77 
X-CRM114-Status: GOOD (  14.25  )
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

On Thu, Feb 12, 2026 at 10:33:18AM +0900, YunJe Shin wrote:
> From: Yunje Shin <ioerts@kookmin.ac.kr>
> 
> AUTH_SEND negotiation requires at least one DH-HMAC-CHAP protocol descriptor.
> Validate the payload length before parsing the negotiate payload to avoid
> out-of-bounds reads.
> 
> KASAN splat:
> [ 1224.388857] BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send+0x1d24/0x2090
> [ 1224.407035] The buggy address belongs to the cache kmalloc-8 of size 8
> [ 1224.407998] allocated 8-byte region [ffff88800a6537c0, ffff88800a6537c8)
> [ 1224.412412] page dumped because: kasan: bad access detected
> 
> Use struct_size() for minimum length computation and move the negotiate
> restart flow into a helper so the call site stays compact.
> 
> Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
> Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
> ---
> v2:
> - use struct_size() for negotiate payload minimum length
> - split negotiate handling into nvmet_restart_dhchap_auth() helper
> - use NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD instead of NVMe status
> 
> drivers/nvme/target/fabrics-cmd-auth.c | 48 +++++++++++++++++---------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> ...
> +	size_t min_len = struct_size(neg, auth_protocol, 1);

Maybe this could have been struct_size(neg, auth_protocol, neg->napd)?
But the target code also enforces napd == 1, so it ends up being the same.

Reviewed-by: Chris Leech <cleech@redhat.com>


