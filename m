Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3977C44501
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jan 2026 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tae9U7McvW0hfPoFDeOkrv1yDXDhuBS782pMRzhzkVk=; b=4UQlnS8guJEXA8EubCHLEaBfgF
	bakCi7KtRZSyYnAlO4BF/7kQMwqAm6rqMWdQoxaTXn8gPPGrPQlgctCFdyqxwZCS5UciDH4eTqAXi
	0jYaohLdT4NeK/ccKpwS6hAYdKJLlMY+FKwYoN7NSn9ZKOwfq87eX8yEGM3hC/DAk0DHFP5KRe2gw
	BgcWciy4oxeNopDWtpdwISPFnwuiVg2y2eB+fFTXyeCQTufB8VXof5UkgBzYjD3KoFXvu6H7+JKx6
	7Ht/eit/YlgFJtqo5BtsFTPzdq4ObHmJ7eA3sj8CblvWjM5d9MELQ5Gq8JiIzF5UoHjnvzr0Q49Ts
	AhMHPrmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viTxz-000000058A7-1ONG;
	Wed, 21 Jan 2026 08:53:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viTxv-0000000588q-2KuO
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jan 2026 08:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768985604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tae9U7McvW0hfPoFDeOkrv1yDXDhuBS782pMRzhzkVk=;
	b=Wb6C1+/I1YCMELiH2ww+GRPiQKU4nNmKUV+NpS7XvjBd7smm3QZubtVlTBKnxFBg+19hEY
	Fi1lenI8AaOEge7y3Dye5lLowT+bHCcBhkiQSScHO37NdAd4DA628RHdYzgjG1WSm6fwOU
	h6rkKWjUoC3dtzWfi/CGX0fmBcth478=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-z_KCQ28HOmKlPseQwUEmZg-1; Wed,
 21 Jan 2026 03:53:22 -0500
X-MC-Unique: z_KCQ28HOmKlPseQwUEmZg-1
X-Mimecast-MFC-AGG-ID: z_KCQ28HOmKlPseQwUEmZg_1768985601
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F17719560AE;
	Wed, 21 Jan 2026 08:53:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDF9219560B2;
	Wed, 21 Jan 2026 08:53:15 +0000 (UTC)
Date: Wed, 21 Jan 2026 16:53:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU
 in nvme_tcp_poll() on the latest linux-block/for-next
Message-ID: <aXCT9sFChMdhwNYw@fedora>
References: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_005327_665612_1AB33BFD 
X-CRM114-Status: GOOD (  12.59  )
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

On Wed, Jan 21, 2026 at 10:50:00AM +0800, Yi Zhang wrote:
> Hi
> 
> This issue was observed on the latest linux-block/for-next during CKI
> test, where enabling the poll queues leads to a tight busy polling
> loop and 100% CPU usage during "nvme connect".
> It seems was introduced from v6.19-rc1 and cannot reproduced on v6.18.
> I will try to bisect it.

It may be related with f22ecf9c14c1 ("blk-mq: delete task running check
in blk_hctx_poll()").

I guess it only happens when `nvme connect` takes a bit long time, not sure if
it can be reproduced 100%.


Thanks,
Ming


