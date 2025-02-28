Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D3FC19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eRccp4VYUJ7iVLOPuYyafBpr1ah62bhkdlT4K+RL4I0=; b=Ag0ZjBmDoBOpZXfmqIcMj7oZUH
	7LrTrkx/8FwwVGzn1MlXRa7Cg+lF4Jva5gZy1F3l3BNsyCJ6AqJhgKLaEcFVT4xXGVdNTS9joqRRA
	D8NzbaUt6gz2GYp383s/ItX55oS83CNbfD30o9hpsoJO+8D2Y4SxeQ7puC9ClC369j7J1rpK+GYAS
	N9RljPjhtCufrg2Hn3Ebt2+uBC7WTk6UD2GUiPGwiRXTlbTEpL5UDMNxFX56aC+bI2YeSmVIRtxJ5
	6bLNFjitVpXArr+wCGsPqeZxdvL+8Clb+CDkabApUOP4wZQG35qLD51ZifCiOqOpqde0yF+4lS+yy
	wM3blWDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvYm-0000000A8nW-1zaK;
	Fri, 28 Feb 2025 08:17:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvWc-0000000A86Y-2amX
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 08:15:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRccp4VYUJ7iVLOPuYyafBpr1ah62bhkdlT4K+RL4I0=;
	b=aANMA/6N9+ADwy2OIwGJIeR9PLNRLSrp3kjkslju/epL5+WAy2U3EBnSpBBO/KPlStuxk8
	Qoh6nPOSg5VCUqL+7z/mGPWjMiX/C+P6RS2Wwdv062O0lmc8YBPx+JENP4L6nlb9/FwJHL
	1PV0OXEdDesy88tQ3QvPlLX/YwEIFUU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-3m0H-eIGPiCjoB2yxgVL2w-1; Fri,
 28 Feb 2025 03:15:11 -0500
X-MC-Unique: 3m0H-eIGPiCjoB2yxgVL2w-1
X-Mimecast-MFC-AGG-ID: 3m0H-eIGPiCjoB2yxgVL2w_1740730510
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A23D180087B;
	Fri, 28 Feb 2025 08:15:09 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 012F9180098C;
	Fri, 28 Feb 2025 08:15:03 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:14:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 5/6] ublk: zc register/unregister bvec
Message-ID: <Z8FwgbNtpu-bDZfR@fedora>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223916.143006-6-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_001514_725997_8C4A2BC7 
X-CRM114-Status: GOOD (  10.70  )
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

On Thu, Feb 27, 2025 at 02:39:15PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide new operations for the user to request mapping an active request
> to an io uring instance's buf_table. The user has to provide the index
> it wants to install the buffer.
> 
> A reference count is taken on the request to ensure it can't be
> completed while it is active in a ring's buf_table.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


