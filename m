Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03BCE810B1
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k9LGDOwHykkauIoDt6YUEfS+xSiVyjQ/+X3igF0gM7Y=; b=wd9EfGx23sEHVjYEoj1ip+A5ex
	uAxqU4IGDpWLGE7Hk2vyQ1sYlvnvJgJwnAjYQPBdQobxEqYZ/qh0vAH1ZsrnSd0t84ZcP+eigJtG3
	xZHJ4e0WOXf+e1AEH/j9sxgpmB5ZD47D/oYN6B+NXAjHeKlaeunIrxWGcrCVfwpu3kKe+UDKrj2xG
	02DRvBPY9VkN51HGRGO/A3SyLfwivhde1KqcdSRjFWNHptwIwDfnjkj+O4UQGzyDRy2mn79pqDHdP
	ZYXdbFmqewLc6ZoBnPPIYzkRmFc8moIWli/M3CDGzcuVwbt6KKwPJL5a6wiAfHYahmWDhFTU6bduj
	iY9WVVLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlRAr-000WpA-2r;
	Wed, 27 Sep 2023 09:49:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlRAp-000Wmn-1j
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 09:49:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695808176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9LGDOwHykkauIoDt6YUEfS+xSiVyjQ/+X3igF0gM7Y=;
	b=YW0rhy1qJGa+MIpqlZ5L5zqsCYtfjZurSSrSkbt+diK4LS6W7uOux3S36So7bjesiOUjD/
	Y8wU+cxqBOJpf69rNE0WfhxBqN4EqyjqmvXG2EYFf9p395PEkHFyYBO77ffHf816g2e+wq
	42G/lBuH8eQee0W0ESNSw79hFgrca0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-bLFv743GP_GGbuL8sWYgFg-1; Wed, 27 Sep 2023 05:49:33 -0400
X-MC-Unique: bLFv743GP_GGbuL8sWYgFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEA13185A79C;
	Wed, 27 Sep 2023 09:49:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1001678B;
	Wed, 27 Sep 2023 09:49:29 +0000 (UTC)
Date: Wed, 27 Sep 2023 17:49:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com,
	jmeneghi@redhat.com, mlombard@redhat.com
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Message-ID: <ZRP6pCFd8+mWpUcS@fedora>
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230925163123.16042-2-emilne@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_024939_661777_D72CA9DF 
X-CRM114-Status: UNSURE (   9.49  )
X-CRM114-Notice: Please train this message.
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

On Mon, Sep 25, 2023 at 12:31:21PM -0400, Ewan D. Milne wrote:
> Returns a count of the total number of active requests
> in a queue.  For non-shared tags (the usual case) this is
> the sum of nr_active from all of the hctxs.

hctx->nr_active is only updated if BLK_MQ_F_TAG_QUEUE_SHARED is true
and blk_mq_is_shared_tags() is false, so hctx->nr_active isn't
available if BLK_MQ_F_TAG_QUEUE_SHARED is false(the usual case?).


Thanks,
Ming


