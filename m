Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4222C28B2F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HUdJzoaJl7oqqgbw6nYWMYJgkpxQPEA6dFQ+w64K7q0=; b=jAOPm3SztkGz8DgoSyE5waFvQa
	leFl7fvOi7BhYmTNkefZ0bpqfQEubAm6PtWM9RGYVhefYNOZCM2Gz0UEX+XmpfusRTaA4T5CL0occ
	/VkyqSEQk1zs6Yq93JxSQsuDKx5ovWwR/STfQOESzjDJHg8sQdruDs/EgjAQtXcsOZKdsnTvIJ7ii
	/om4PEJfpNUttldwGvsL+MqBi19DaOrJ7N8OFRcayCnN/168M0pzcUkcrXbe/TEiQco1UOQOu9Sfg
	eq3fhREvvfXwZ6F+3C+Cet0UvF+3YqALKGOY4Ecfhfu6//MxfPQ49EAq64Di5C8e/mMpWlZL8dl2r
	wcrZuSzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts4mu-00000006h9M-0d3o;
	Tue, 11 Mar 2025 18:57:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts4ji-00000006goo-0gQ7
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 18:53:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741719230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HUdJzoaJl7oqqgbw6nYWMYJgkpxQPEA6dFQ+w64K7q0=;
	b=eBbKOEATMXGSMxkjSthHF7hZnAHUyJg2IUbcqTQ5jNT2rltz4Nbol8bsNMJWJcc1smMdyY
	5UAyNfpUfx4RZksf+yixBApWge5CO+C2B6dhSdAz3GhdICv3Hq8efmujwAkIxYh0WUcBvp
	1uHFcrRWAiBLyVXQue+gy451x2xKdU8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-15nAYX_xMgSe-QtKub6gXg-1; Tue,
 11 Mar 2025 14:53:48 -0400
X-MC-Unique: 15nAYX_xMgSe-QtKub6gXg-1
X-Mimecast-MFC-AGG-ID: 15nAYX_xMgSe-QtKub6gXg_1741719227
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B83321955BC5;
	Tue, 11 Mar 2025 18:53:45 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.17.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0230F1955BCB;
	Tue, 11 Mar 2025 18:53:43 +0000 (UTC)
Date: Tue, 11 Mar 2025 11:53:41 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-tcp: sanitize request list handling
Message-ID: <Z9CGtUqkAR6uWWs-@my-developer-toolbox-latest>
References: <20250307132802.111513-1-hare@kernel.org>
 <20250307132802.111513-3-hare@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307132802.111513-3-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pA2VtMBijkPS0q9xolYyXTiZNYJ2dQiY0oPGO_8aF7U_1741719227
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_115354_273970_C5EDC90A 
X-CRM114-Status: GOOD (  14.83  )
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

On Fri, Mar 07, 2025 at 02:28:01PM +0100, Hannes Reinecke wrote:
> Validate the request in nvme_tcp_handle_r2t() to ensure it's not
> part of any list, otherwise a malicious R2T PDU might inject a
> loop in request list processing.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/tcp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

...

> @@ -759,8 +762,12 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>  
>  	nvme_tcp_setup_h2c_data_pdu(req);
>  
> +	WARN_ON(queue->request == req);
> +	WARN_ON(llist_on_list(&req->lentry));
> +	WARN_ON(!list_empty(&req->entry));
>  	llist_add(&req->lentry, &queue->req_list);

Are we happy with a WARN here, or should this be handled as an error?
The idea of an duplicate R2Ts creating a loop in req_list is
frightening.

- Chris


