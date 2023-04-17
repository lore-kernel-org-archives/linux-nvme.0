Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C92C77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 07:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRdnQCKny8giW3OyExxPhuJqL89+ZaGGJFW/ztJq/GQ=; b=SKTzILB/liMVgNeYWw/te3TVpp
	+2rICC8UVNMdf58R7wz6Nt0y8Spllool+haPQmfnIkRSjTM0VGNmviBR6rrm5/Gk1Vhub68sFBo1D
	Efwemwkw2xWayMIaOMJX5PN/KrI5GFM4cibEoXDfe7kIqAXdcb/xIP7SZhT7KdyP6N4UW6uBC4wqB
	wELr4szQBxJD/uyIMDcdrZMy5lcgA0yjAZhm1N4CnIGkfo6v+swuf+p916md0UrNtg356yqLtEQlk
	+X418C+eZenAYajDyymSP0fYEWjmME0lPeFQRNFaWF61ZLM1Td3kQu8gqQs1WQC0DzEK7X+yAt5lE
	XXjOXUCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poJRL-00FCy5-1m;
	Mon, 17 Apr 2023 07:38:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poJRE-00FCqC-0b
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 07:38:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681717087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRdnQCKny8giW3OyExxPhuJqL89+ZaGGJFW/ztJq/GQ=;
	b=Hchb+DzdLmaEMJW/XuahMEGmJ/qRwq8KffahtKBOejxVNe6LYzbW1H1+u2/+IJ68l0R8n5
	dTpt60TGimXkJC0R46WZbnYjq6s2D2xckS66GYQF24erkfOq19v6tTHu+XPzJJPmI95o+T
	opcXVCebkUS+VBzuGJZ+AlWw7nV9hEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549--G3PADyWMEmGXGJVJmaYgA-1; Mon, 17 Apr 2023 03:38:03 -0400
X-MC-Unique: -G3PADyWMEmGXGJVJmaYgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 980DE85C1A7;
	Mon, 17 Apr 2023 07:38:02 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AEFB40C6E6E;
	Mon, 17 Apr 2023 07:37:55 +0000 (UTC)
Date: Mon, 17 Apr 2023 15:37:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, lifeng1519@gmail.com,
	ming.lei@redhat.com
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Message-ID: <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413132941.2489795-1-fengli@smartx.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_003812_346028_B0D9602D 
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

On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
> The default worker affinity policy is using all online cpus, e.g. from 0
> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
> have a bad performance.

Can you explain in detail how nvme-tcp performs worse in this situation?

If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
on other non-busy CPUs via taskset, or scheduler is supposed to choose
proper CPUs for you. And usually nvme-tcp device should be saturated
with limited io depth or jobs/cpus.


Thanks, 
Ming


