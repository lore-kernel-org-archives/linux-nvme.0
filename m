Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9002EB64D8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+vnjEXreH0/b3cB4UY+FUlsrwX6QWE/ExjGOEW3daVI=; b=ovLZxeemiuh9YfVkr2q6yvvnd5
	1lXIM+gNMfOyFijCI67frxvcLuG1+hwyF6Ck1YcDOSwi91VBfBK5lgRF4+0ngOn6OJJTwEymPuTeJ
	c4+bembqLqHWiLUjdESM2vpc0MXJj4yLUVMcw6C+pPJ+DoDmi4DS3pnFu2suFj/p2aWToKw9/Rk+x
	9pFu6SovD58m/OBDqTQzjimyOoXlKZU9QSvk6eZPUOfwqZzsp6oorF0P/SiBxBkI1M+JpZ7J0M+QX
	WsabUR/WQ9TqoqekdZA1/WZwGgdvMBuYLH4p9//zussvfSxYaEFkDDMY9ZbtWG0U1eigyp/8sCJ6w
	yHklcuNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbKs-00BNNp-2Z;
	Tue, 20 Jun 2023 13:23:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbKq-00BNNJ-0m
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:23:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687267431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vnjEXreH0/b3cB4UY+FUlsrwX6QWE/ExjGOEW3daVI=;
	b=BbMonW6a8EDoHuk14Cd9Kgx2VSyu7yit9F76Zj7xh3rU9FAj01oEdFJqMfG4ziGGiyT+rY
	OWgV4MjJNUAckKLEB2O8bY5kyfNJJ/22G2u9fi+26HYkYnXFy4ZLcw8z2umPgdXaq2kyLs
	SuVrs9QFLrNz2nSkdtmz9k5pem9WlCw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-AjoKta6FN1SRDXonwpNjKQ-1; Tue, 20 Jun 2023 09:23:49 -0400
X-MC-Unique: AjoKta6FN1SRDXonwpNjKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EED528EC100;
	Tue, 20 Jun 2023 13:23:45 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 126D7C1ED97;
	Tue, 20 Jun 2023 13:23:40 +0000 (UTC)
Date: Tue, 20 Jun 2023 21:23:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_062352_346676_2FEB491F 
X-CRM114-Status: GOOD (  14.56  )
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

On Tue, Jun 20, 2023 at 01:04:33PM +0300, Sagi Grimberg wrote:
> 
> > Hello,
> > 
> > The 1st three patch fixes io hang when controller removal interrupts error
> > recovery, then queue is left as frozen.
> > 
> > The 4th patch fixes io hang when controller is left as unquiesce.
> 
> Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
> connect patches?

I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
extra maintain burden wrt. error handling, but looks Keith worries about the
delay freezing may cause too many requests queued during error handling, and
that might cause user report.


Thanks, 
Ming


