Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F6DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y8HXqoZS0yakVP1rRgpLH13VjxuiqLVz2udIjsoRQfM=; b=gfg8IJdSlZFW1V+AhahoNkvmQc
	ZCirhkvpNOuUFzweA8nDPN/kOIWqy7wdX7Mr0FeTQcg2smR9pSEBTAMETyg3PGb/X2Xz5E3V4jMxB
	DGN6NyiMQud1nw284T0qArabZZKBQDw3B0EoRmruuDwPm5Txh1uBYsuQa1/CCBzpH2u/VpsyBW3Nw
	n5Gw1D5r7TNrQ6e2VXJqMUxaZdl4mbtVw9mouA63ibcBdhtbqdGoVlPkdD6XHQeQxwXeK7gPhNfjN
	ucJ9Evd+9kWLAlPRRT1g/Am6ugVyG+s+esWkgA3+XZfK2S2ZOF47HFlBdaK35yo/u2xwu38bJJEyL
	dJHVMxSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTlmA-005h4o-VK; Mon, 14 Mar 2022 14:34:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTlm7-005h46-Vb
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 14:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647268458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8HXqoZS0yakVP1rRgpLH13VjxuiqLVz2udIjsoRQfM=;
 b=hKzWUxHBY1SHZ8PrWp9zuCtYZBHJo8JGQPelbFxlf52r9hkjL30yhjwGk3wrwP0ZQGFJgi
 WevUq3ETcT3ayfMJ9tfcU5hf5JAQzlCohf6/BKS51I5K2PXvoqAXyPpx0V8KR0rlPmISuq
 E4U2EpXknlWB2VPK4gzJl6hR8uLp5ZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-YmGGBlXHNb-y4s2yNYNVQQ-1; Mon, 14 Mar 2022 10:34:12 -0400
X-MC-Unique: YmGGBlXHNb-y4s2yNYNVQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10280804186;
 Mon, 14 Mar 2022 14:34:12 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0208E404C309;
 Mon, 14 Mar 2022 14:34:02 +0000 (UTC)
Date: Mon, 14 Mar 2022 22:33:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, pankydev8@gmail.com,
 javier@javigon.com, mcgrof@kernel.org, a.manzanares@samsung.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [PATCH 09/17] io_uring: plug for async bypass
Message-ID: <Yi9SVXAs8TlIcIkU@T590>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152711epcas5p31de5d63f5de91fae94e61e5c857c0f13@epcas5p3.samsung.com>
 <20220308152105.309618-10-joshi.k@samsung.com>
 <20220310083303.GC26614@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310083303.GC26614@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_073420_117718_E578B6DF 
X-CRM114-Status: GOOD (  12.98  )
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

On Thu, Mar 10, 2022 at 09:33:03AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 08, 2022 at 08:50:57PM +0530, Kanchan Joshi wrote:
> > From: Jens Axboe <axboe@kernel.dk>
> > 
> > Enable .plug for uring-cmd.
> 
> This should go into the patch adding the
> IORING_OP_URING_CMD/IORING_OP_URING_CMD_FIXED.

Plug support for passthrough rq is added in the following patch, so
this one may be put after patch 'block: wire-up support for plugging'.


Thanks,
Ming


