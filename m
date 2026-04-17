Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7341AF436BF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aLM10jOwdSOCKnbr47lCVYbynLEmuueYz8PH1kR1jlk=; b=jvnXjNLYIMT61bArXbH9AHTwQ5
	svDnp8t5ipXfMfTra0o0Nv44v4Gj81QMzW0LmUxWzeRLeP43we9SJR/il5/COtv3qR74v9Yv6HhdH
	XmoW6TJrzy3aqsatDk+pyBNcqi7iUCYN94DT5szzCerr9dtH4FiUXoBffk3CdQkIL2tbV/HOdOQHH
	dYp6LDwWK7W96+LskTshWl0Vr7TU3vp7gCOhzzdN5v5yP7oPJgJbX0+N55Z53oRau0l0YwgAq8neP
	lVuMNT0jS8G+Z2WaAClcedKg6cbhEKjYppsTTjTC1elonUK4Spq3MU5dRd/YjQn8leUnJV8rb7Dav
	dx5Uhxmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDmWN-00000004Ifi-1IgZ;
	Fri, 17 Apr 2026 16:58:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDmWJ-00000004Ien-2DKY
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 16:58:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776445098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLM10jOwdSOCKnbr47lCVYbynLEmuueYz8PH1kR1jlk=;
	b=KhTCX4Eb6yVQmg2PNvhfBUieXFdIDhhQZitx5jpcc7/fu8AvJVKdKzXA0iEd98RDutoh4c
	ZRQMHKeHQU1FargI/pUibcTJv4SqriGnkyLssdpdqoyeSzW4RURMZIhB1oPAeBFwdQbktK
	ATz6XveuAazYSPrtH4QsMp3mPlEsln0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-3qTGo_kRMMyDgF51cl9okQ-1; Fri,
 17 Apr 2026 12:58:14 -0400
X-MC-Unique: 3qTGo_kRMMyDgF51cl9okQ-1
X-Mimecast-MFC-AGG-ID: 3qTGo_kRMMyDgF51cl9okQ_1776445093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2037E1800282;
	Fri, 17 Apr 2026 16:58:12 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.224])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 106C51800660;
	Fri, 17 Apr 2026 16:58:08 +0000 (UTC)
Date: Fri, 17 Apr 2026 09:58:08 -0700
From: Chris Leech <cleech@redhat.com>
To: alistair23@gmail.com
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yi.zhang@redhat.com, mlombard@arkamax.eu, linux-block@vger.kernel.org, 
	shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/2] nvmet-tcp: Don't clear tls_key when freeing sq
Message-ID: <20260417-9fecb7f3795b98707372292b@redhat.com>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
 <20260417004809.2894745-2-alistair.francis@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20260417004809.2894745-2-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: IoSyDUq1x6lbRV8XxVRYcajGVocBjveBFEhmmKj78kQ_1776445093
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_095819_876049_6ECFDF93 
X-CRM114-Status: GOOD (  14.94  )
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

On Fri, Apr 17, 2026 at 10:48:09AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> part of calling nvmet_auth_sq_free() on success. This means when the
> host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> check for !nvmet_queue_tls_keyid(req->sq) fails.
> 
> A previous attempt to fix this involed not calling nvmet_auth_sq_free()
> on successful connections, but that results in memory leaks. Instead we
> should not clear `tls_key` in nvmet_auth_sq_free(), as that was
> incorrectly wiping the tls keys which are used for the session.
> 
> This patch ensures we correctly free the ephemeral session key on
> connection, yet we don't free the TLS key unless closing the connection.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  drivers/nvme/target/auth.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Chris Leech <cleech@redhat.com>


