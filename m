Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A74FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhtmeoLhSVw8TxG3EM8WGDxXWprw20ODCHZnU0rs1oc=; b=0c+QyGPMO20J/ZbLwZcSS/2atW
	/8w1ijulo/gRvLUa0CMfLyTUZuWREEXu/ND+XxuOzYce68Int4cCtX2V4LeKLuvTCZzX1vv6a18tt
	vp277GK/HJQb8yCAcrdVFNE993cAOL7dpUbVZH4LTDw1+TZi7XN2I7yAm3TmUeESJWWZbXuNn/b33
	6J2VYCouYbT9dRmLxuGwK871y691nQo1osEic2zK5tfJBhOSLNXiVQPlCaSnzse9aKLHc157aJKWb
	IaaeICbVxQL4jFWmfWn0QPV4+wRz2rd4lcf/UAkSL7jyWPZgfHRb5/8+Czw9bh8yqqptzf2TGlzFk
	g4jff5Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzJa-00ExE2-Pv; Thu, 14 Jul 2022 13:55:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzJX-00ExAr-Pc
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 13:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657806934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhtmeoLhSVw8TxG3EM8WGDxXWprw20ODCHZnU0rs1oc=;
	b=gL+KacSeljxCh4scBAzvbkf4J3Kkqg8Y6f34MFNVUzyvGJXi14KqofdP3iFNJSvTBxaEmt
	8VJXR0/+CIWIZmvj05jNG5pOpIyvUAC++sgoyKCyipyCwzwDLa/1vrliYTj/38+ptPGQEx
	qy33lIkpU19/svELuVTTxbpIh8WldBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-JLYhTxIqP1mO5l_seL57XQ-1; Thu, 14 Jul 2022 09:55:32 -0400
X-MC-Unique: JLYhTxIqP1mO5l_seL57XQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96B5A80418F;
	Thu, 14 Jul 2022 13:55:30 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1618A2026D64;
	Thu, 14 Jul 2022 13:55:22 +0000 (UTC)
Date: Thu, 14 Jul 2022 21:55:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, asml.silence@gmail.com,
	joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com,
	ming.lei@redhat.com
Subject: Re: [PATCH for-next 1/4] io_uring, nvme: rename a function
Message-ID: <YtAgReh6PnevFwzX@T590>
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110800epcas5p3d338dd486fd778c5ba5bfe93a91ec8bd@epcas5p3.samsung.com>
 <20220711110155.649153-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711110155.649153-2-joshi.k@samsung.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_065535_950368_8F7ACD5F 
X-CRM114-Status: GOOD (  11.20  )
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

On Mon, Jul 11, 2022 at 04:31:52PM +0530, Kanchan Joshi wrote:
> io_uring_cmd_complete_in_task() is bit of a misnomer. It schedules a
> callback function for execution in task context. What callback does is
> private to provider, and does not have to be completion. So rename it to
> io_uring_cmd_execute_in_task() to allow more generic use.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

ublk driver has same usage, and this change makes sense:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming


