Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC46EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X2gSwReoCstxp0yfakYn+xDiXkvABM4Pp3Zg8Rzn21w=; b=v4XwnIsDEcQdnSBRgU/nfozMJU
	Z3Crql25Xfk6VdVYay6fQBytQw91sQsl1Zc2Er3KJ4RtucXF+KjCaGaTpIcLNsi6yQortTNg78jsK
	VLfEn2/cAald4HrknIdPyckpcpSskBhVPyA3ntKq2PInqiKySjxo15JFnY98/o7bO+alKitCZQRag
	d0dFawOzPVQF9RR8qNoLSvBsS2D3QmVP8pmm4JUqPcldpYdQT1snc80FMjQyW+ufjzKvcjbabwWpw
	aOncHywQosLu1+YFgLUl5i3uAVBtMv6NbahkOZhbD18qMqHckV8X2gfvuTVn59rvQZFOcTy5E9O+4
	J5ohmnvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEK1J-00EVv4-1I;
	Wed, 28 Jun 2023 01:30:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEK1G-00EVsb-1p
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 01:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687915833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2gSwReoCstxp0yfakYn+xDiXkvABM4Pp3Zg8Rzn21w=;
	b=UTtmFXxOV7x0csJbtxs9pe/moIyWnlTL7c6SZM+c/4tqL/pIAasKpSt69RjsNrY/Y23Ph0
	0BQUKzHM8jsPxMsgZPc9YfPSAy/fEOhlQHC6JqIJfYGUfGQZQIWeqDS+rE8cl9uk3uPNQq
	L12Xpl6J7qt8wM/aV3haXnSAFXsnGtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-zyFfhG8BNu2gvkt4SSEG7A-1; Tue, 27 Jun 2023 21:30:27 -0400
X-MC-Unique: zyFfhG8BNu2gvkt4SSEG7A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18F2B104458B;
	Wed, 28 Jun 2023 01:30:27 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC1E3492B02;
	Wed, 28 Jun 2023 01:30:21 +0000 (UTC)
Date: Wed, 28 Jun 2023 09:30:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJuNKGy5dXPC6i+H@ovpn-8-21.pek2.redhat.com>
References: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_183054_703085_B1E10395 
X-CRM114-Status: GOOD (  29.47  )
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

On Tue, Jun 27, 2023 at 11:21:36AM -0600, Keith Busch wrote:
> On Sun, Jun 25, 2023 at 08:26:48AM +0800, Ming Lei wrote:
> > Yeah, but you can't remove the gap at all with start_freeze, that said
> > the current code has to live with the situation of new mapping change
> > and old request with old mapping.
> > 
> > Actually I considered to handle this kind of situation before, one approach
> > is to reuse the bio steal logic taken in nvme mpath:
> > 
> > 1) for FS IO, re-submit bios, meantime free request
> > 
> > 2) for PT request, simply fail it
> > 
> > It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
> > always set for PT request, but not see any better approach for handling
> > PT request.
> 
> I think that's acceptable for PT requests, or any request that doesn't
> have a bio. I tried something similiar a while back that was almost
> working, but I neither never posted it, or it's in that window when
> infradead lost all the emails. :(
> 
> Anyway, for the pci controller, I think I see the problem you're fixing.
> When reset_work fails, we used to do the mark dead + unquieces via
> "nvme_kill_queues()", which doesn't exist anymore, but I think your
> scenario worked back then. Currently a failed nvme_reset_work simply
> marks them dead without the unquiesce. Would it be enough to just bring
> that unqueisce behavior back?
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b027e5e3f4acb..8eaa954aa6ed4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2778,6 +2778,7 @@ static void nvme_reset_work(struct work_struct *work)
>  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>  	nvme_dev_disable(dev, true);
>  	nvme_mark_namespaces_dead(&dev->ctrl);
> +	nvme_unquiesce_io_queues(&dev->ctrl);
>  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>  }

That may not be enough:

- What if nvme_sysfs_delete() is called from sysfs before the 1st check in
nvme_reset_work()?

- What if one pending nvme_dev_disable()<-nvme_timeout() comes after
the added nvme_unquiesce_io_queues() returns?


Thanks,
Ming


