Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1819EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iH25GN8X3LsVgQP0MS+L84U1GQXae5Y6ao4JIVTErZ4=; b=m3fteGwwvYm51e1aG6uiUzpxVA
	pdivDxIvOWYlECNtw0h8hZ1BCgQ3v0apen3aCEL4c1tbkJxAvv72bRc8/sO3VywZCbcNw783BeDIM
	/1mNt6Ojonu64DkqX7jlmQozHFX39b3IOyAyzVXguJwfjKYVw150/Q0GQgtAKxE279WlNlMU6KiUA
	oVF9bpzoa9tM5uBEN0XkCBClIiy4t0IZXAjnd0DWpHSIPGfZelbeeFaUYqzWs0un23z/wvQEEdT0o
	eC/wXlWltTzdwPpoRF7YGMVoNqAgDwL7uWWCkqGdWSJJkaC5oqOxz/Go0Y7ktaeA7zmHWu6+NpmFr
	mRTeX+bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBlQU-00CfXR-12;
	Wed, 21 Jun 2023 00:10:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBlQP-00CfWs-2T
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 00:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687306215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iH25GN8X3LsVgQP0MS+L84U1GQXae5Y6ao4JIVTErZ4=;
	b=WDO9UxlJ6VgD3OvFoREjx1M2LYHPQyOvvuH1raOoq5W7bEnOkzoBfurNApvPHDAMHpxUR/
	dyTu2sNQsT11K3Sd7fyvZg04zhC/koU3UqrQ1XwPG4zBT716G9Vlw4cJFVMKy2dv+m81hq
	CcF32Zt3YTUNv6RPwK69m5U3NkxEptU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-8Adca8xZP8ivkXME51V3PQ-1; Tue, 20 Jun 2023 20:10:10 -0400
X-MC-Unique: 8Adca8xZP8ivkXME51V3PQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B823809F8F;
	Wed, 21 Jun 2023 00:10:09 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D5C7D492C13;
	Wed, 21 Jun 2023 00:10:04 +0000 (UTC)
Date: Wed, 21 Jun 2023 08:09:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_171017_886140_D81EBC2A 
X-CRM114-Status: GOOD (  18.93  )
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

On Tue, Jun 20, 2023 at 04:40:49PM +0300, Sagi Grimberg wrote:
> 
> > > > Hello,
> > > > 
> > > > The 1st three patch fixes io hang when controller removal interrupts error
> > > > recovery, then queue is left as frozen.
> > > > 
> > > > The 4th patch fixes io hang when controller is left as unquiesce.
> > > 
> > > Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
> > > connect patches?
> > 
> > I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
> > extra maintain burden wrt. error handling, but looks Keith worries about the
> > delay freezing may cause too many requests queued during error handling, and
> > that might cause user report.
> 
> For nvme-tcp/rdma your patch also addresses IO not failing over because
> they block on queue enter. So I definitely want this for fabrics.

The patch in the following link should fix these issues too:

https://lore.kernel.org/linux-block/ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com/T/#u

I guess you still want the paired freeze patch because it makes freeze &
unfreeze more reliable in error handling. If yes, I can make one fabric
only change for you.


Thanks,
Ming


