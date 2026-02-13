Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BD1EF48CA
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 04:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=guGtY1JCXFXTjV1h91oQJKpMb6fkAzkGxE/Lmcv0SFQ=; b=xyXRtQ3PsC3X9uDe1RoCO+S8OM
	f7UAIsG9/AP/Z50oR/vX3ekDPq5zgufm7gie2i+23vGX/9aOHqBC4OpjZvMQF3ncIJGNxRqp8pGj0
	LZ2vVZcKIJoxVXgjEySLy1NMIvgILRYTIDrZA2iHPkZd45z1XUA8fH5AvwnnCXQt4hEfPqY25TgP+
	wtugUVrE+K09Om0OhFCC0vHcIhwKXZEHMvLHQXkFWOtKuDyKvvV6S5c45guTQ5lw0cO8wFLejgQCI
	gwsfuiiZ0yLZ2o1BN8cBm4hfxKkzl1qBVQEqMHXO/PXspF4c/etFSoSNjTsx1YtYPlTl4HVKB24bJ
	3CWJY9sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vql2X-00000002yzb-44Ml;
	Fri, 13 Feb 2026 04:44:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vql2V-00000002yz9-1UsL
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 04:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770957860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guGtY1JCXFXTjV1h91oQJKpMb6fkAzkGxE/Lmcv0SFQ=;
	b=LIF938SYuKys/BpDY5nsT6JxmyJBRYtw+vx2NE2O/JSYOS+Jg1k5RC1q1rxFY0ikf6U4os
	o3njIHe6wGBhXGFZ/M9ulMUDozWYxej4OwFUJSaWcr9KlpmwNsKZAn7FPFt/1LcETanTFn
	D2bjoLMGMPFLhJjiWH5yUgtchSuyd4s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-RPHmPoipPfONhgWznoVn8A-1; Thu,
 12 Feb 2026 23:44:16 -0500
X-MC-Unique: RPHmPoipPfONhgWznoVn8A-1
X-Mimecast-MFC-AGG-ID: RPHmPoipPfONhgWznoVn8A_1770957854
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 344A61955D4D;
	Fri, 13 Feb 2026 04:44:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E333E18003F5;
	Fri, 13 Feb 2026 04:44:03 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:43:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Jens Axboe <axboe@kernel.dk>, nilay@linux.ibm.com, hch@lst.de,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
Message-ID: <aY6sDstii_R_zOfs@fedora>
References: <20260212080135.1673063-1-yukuai@fnnas.com>
MIME-Version: 1.0
In-Reply-To: <20260212080135.1673063-1-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: lPr0i-hjslmAokyoPB7vIYjxRdt6V7XHyHStLjCBVQ8_1770957854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_204423_472194_05FEA56B 
X-CRM114-Status: GOOD (  12.64  )
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

On Thu, Feb 12, 2026 at 04:01:35PM +0800, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
> 
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.

debugfs lock doesn't depend on queue freeze, so the implied deadlock isn't
obvious.

Can you explain a bit why freeze from another context may cause dead lock?


Thanks, 
Ming


