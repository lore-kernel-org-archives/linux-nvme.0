Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259DDEB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 08:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZfSTZglvIGSrhocBNtgpf2SRGtSqiqusnODT4ZKCd20=; b=wenKdjWeo9O30y5CLcsRSL37ma
	Wc8VtFu7nC3o28ftZR7sEc/2U1sb7oHxRordP+7bug9GSWbtuG07yYEwUd6c7yjsnGmhj2BXC8cL7
	jsfftmcP73mQbxN5CKdbjmcdxpvh1AZKXEY0R7y8CS+EDQgbR1StePyTc9+GoMgTylRUnb2xSf+Tk
	or+VpfYEKizQpv/9j7NCjMqrctBt6DAKg3Tr/6pI80VtGMLgoYm1FgXy3cEi47/ttsJzmnCvbM8Aj
	idqAjPfGJI18RmfnnTY+pxzqqUU8GHysCb6HX61/4+f+OWWXUzs7v6auRGEZnuw8OmJFKmGjqejk9
	7gD5duKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ8mG-00E7o8-0A;
	Tue, 11 Jul 2023 08:31:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ8mD-00E7nf-08
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 08:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689064274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfSTZglvIGSrhocBNtgpf2SRGtSqiqusnODT4ZKCd20=;
	b=HP8e6XrxGZUmoi8cZUdeebNc+vmctAf/eX8fIZvqH2Xlg9C5obzeEgP3HzlEkG4bUJnfQ9
	EvBwVixsmbdJzlRaPK84NHeJthvXJ0qfWyYwgPL4m/B71c4YwF96oKjmYgiGEEQrv/sM5R
	OOynjN5d7u3hPKN1f+DQULF1Ian1eG0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-dI4TuKYXPnSndGRgHvp51A-1; Tue, 11 Jul 2023 04:31:11 -0400
X-MC-Unique: dI4TuKYXPnSndGRgHvp51A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ABDC1C0782D;
	Tue, 11 Jul 2023 08:31:11 +0000 (UTC)
Received: from ovpn-8-22.pek2.redhat.com (ovpn-8-22.pek2.redhat.com [10.72.8.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 388971121315;
	Tue, 11 Jul 2023 08:31:05 +0000 (UTC)
Date: Tue, 11 Jul 2023 16:31:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH 1/6] nvme: unquiesce io queues when removing namespaces
Message-ID: <ZK0TRK89VVatUdXE@ovpn-8-22.pek2.redhat.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-2-ming.lei@redhat.com>
 <20230711082719.GA23019@lst.de>
MIME-Version: 1.0
In-Reply-To: <20230711082719.GA23019@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_013117_215236_2FB161C7 
X-CRM114-Status: GOOD (  15.61  )
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

On Tue, Jul 11, 2023 at 10:27:19AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 11:35:50PM +0800, Ming Lei wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 47d7ba2827ff..98fa8315bc65 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3903,6 +3903,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
> >  	 */
> >  	nvme_mpath_clear_ctrl_paths(ctrl);
> >  
> > +	/*
> > +	 * Unquiesce io queues so any pending IO won't hang, especially
> > +	 * those submitted from scan work
> > +	 */
> > +	nvme_unquiesce_io_queues(ctrl);
> 
> What quiesce does this pair with?

The one done during teardown of error recovery, then removal comes and breaks
the in-progress error recovery.


Thanks,
Ming


