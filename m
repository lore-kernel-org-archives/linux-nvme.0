Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA72FEB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 00:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R9iHfOD/vO8uwMzm3mcAdfEih6GadZu/HkBIfv0PcKo=; b=1R8ybYFluH6y74cbvOY31yz675
	koqzBSM9Ynb+mOYjc3zaXomJlNP2xphZTX7kW1U30tyZvmbvGJUkf4WHrxkRf1936Njgb5+b+I6wM
	/aiXf39uib8O7pXwyuK7gRN+O2KU+oKcqLhlelian0bniM6MX7WA9PRYT+vsVI6U8iVLTB0JgiglE
	+IR8J+aHoQRng3iwx8qe0/E9u1YwmJTSVpVZEN8YwuC50MCGqUIVhHbywBT7GYJch2Z36D0lgPz87
	dGIOxQsIG8RZtE4f8QiWgzCroxbDnEKcWVc0BOPTntpN6E9Q6EWep6N03gI/XNyFmVAX+xTCCn8v0
	QQK+vI8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9EXQ-009YFq-0x;
	Wed, 14 Jun 2023 00:39:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9EXJ-009YFI-15
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 00:39:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686703136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R9iHfOD/vO8uwMzm3mcAdfEih6GadZu/HkBIfv0PcKo=;
	b=Z0az2RHoA6fqHb/Ur+R2zqHn+s91pfWNFDK2S3dO4e3+P/yToEGNYa7loCQxrYutnXapix
	iMNdD4XK7mVCrbm5OcfVCwiwYyjoMKAdsVdKVNjSHG+A2GqkXgfLcNa5fjf7idQTeT0zRm
	sHWveQOQq8t+km/RqZWCxCxXE1UXM6k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-ET0woB5OMiyqLlLl_AOuPw-1; Tue, 13 Jun 2023 20:38:53 -0400
X-MC-Unique: ET0woB5OMiyqLlLl_AOuPw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A60CD3C025D3;
	Wed, 14 Jun 2023 00:38:52 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 59608492CA6;
	Wed, 14 Jun 2023 00:38:47 +0000 (UTC)
Date: Wed, 14 Jun 2023 08:38:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Message-ID: <ZIkME5kc9E4IoJff@ovpn-8-16.pek2.redhat.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
 <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_173857_448349_508BDD4C 
X-CRM114-Status: GOOD (  19.06  )
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

On Tue, Jun 13, 2023 at 08:41:46AM -0600, Keith Busch wrote:
> On Tue, Jun 13, 2023 at 08:58:47AM +0800, Ming Lei wrote:
> > And this way is correct because quiesce is enough for driver to handle
> > error recovery. The only difference is where to wait during error recovery.
> > With this way, IO is just queued in block layer queue instead of
> > __bio_queue_enter(), finally waiting for completion is done in upper
> > layer. Either way, IO can't move on during error recovery.
> 
> The point was to contain the fallout from modifying the hctx mappings.

blk_mq_update_nr_hw_queues() is called after nvme_wait_freeze
returns, nothing changes here, so correctness wrt. updating hctx
mapping is provided.

> If you allow IO to queue in the blk-mq layer while a reset is in
> progress, they may be entering a context that won't be as expected on
> the other side of the reset.
 
The only difference is that in-tree code starts to freeze
at the beginning of error recovery, which way can just prevent new IO,
and old ones still are queued, but can't be dispatched to driver
because of quiescing in both ways. With this patch, new IOs queued
after error recovery are just like old ones canceled before resetting.

So not see problems from driver side with this change, and nvme
driver has to cover new IOs queued after error happens.


Thanks.
Ming


