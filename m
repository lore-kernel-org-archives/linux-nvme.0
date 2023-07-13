Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74C4EB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 02:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YehPWc9aFlW6/NTf6IIYASvqF01WKshGKkkWyBDSDU4=; b=MNHAP2/gToFeyMmLjhreUkYLv2
	sWMkE6wRPdnWU+bTLawhR/rx2RjL8mhagTuLtgqCzyqM6h0TlvCAz3RKA4/4cFiDnAQV2/NMpKJoa
	C6+DfIj9RTq5CIzh+jkAhaA/AQeg5WBAKAYL6tcfQZVENmLu/mhA5SOHkuBBIY7mQnMmO5EbOqeHk
	gN3bGIZMElqWKLc3L8zTMG5jYOdjHI3G5Fw+56lcXEeIkSmgr8lS59nMGVepZgWmE0GkLYmhDdl5g
	OP7WFAvDTHVvDmqD8uqMnhHkeUm61MWsxZ05ju77RtuMwzIhV8k+v/CbYFvuNpjbesdkIwGKA7EU5
	Zi70OAIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJmU2-001mEj-1Y;
	Thu, 13 Jul 2023 02:55:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJmTz-001mAw-2R
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 02:55:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689216906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YehPWc9aFlW6/NTf6IIYASvqF01WKshGKkkWyBDSDU4=;
	b=Nht1N8P2ogWLLL5OgVAeVRQOF/J51RUtE36dRCETxc2OHTVjLClWTcUIDcEAZaZ//0DSs0
	G6sx534Kqw7+dW2nHn1FNZrDKFTRSEf3TeVWqEdSXKDV2E4IDOBLPlPgEMdzsUip9ZPcvR
	k/hcZ2fkAJxq9KCkzUMfeo+pfTHuiS4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-uQBwATMkNCqt64XzvttnyA-1; Wed, 12 Jul 2023 22:55:02 -0400
X-MC-Unique: uQBwATMkNCqt64XzvttnyA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F21B888D196;
	Thu, 13 Jul 2023 02:54:59 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-29.pek2.redhat.com [10.72.8.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 96943492C13;
	Thu, 13 Jul 2023 02:54:25 +0000 (UTC)
Date: Thu, 13 Jul 2023 10:54:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: ensure disabling pairs with unquiesce
Message-ID: <ZK9nV7JN0n5iZ82H@ovpn-8-21.pek2.redhat.com>
References: <20230712154004.360561-1-kbusch@meta.com>
MIME-Version: 1.0
In-Reply-To: <20230712154004.360561-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_195507_938224_7053F500 
X-CRM114-Status: GOOD (  15.27  )
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

On Wed, Jul 12, 2023 at 08:40:04AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If any error handling that disables the controller fails to queue the
> reset work, like if the state changed to disconnected inbetween, then
> the failed teardown needs to unquiesce the queues since it's no longer
> paired with reset_work. Just make sure that the controller can be put
> into a resetting state prior to starting the disable so that no other
> handling can change with the queue states while recovery is happening.
> 
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Don't wait for a resetting state as that could deadlock. Just abort
>   the disabling if the error handling can't set the state to resetting.

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming


