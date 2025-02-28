Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9D6C282CD
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 08:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RW2S6X5ptZrapMdWo1yqIKyOazSb405vqeZrfbMITc=; b=PACNRuKDk5FsLkW7Lq4bmazz5l
	2Ik1uHSz9EIR82d+EnZpaF5ImgoAxCMm/Gfr345MeQ0Lu79IJyHAMVSSu1NeOIoq2srqbVnZJfX9J
	ZbJCtbz0cy8ITn6sVfIoAhw5Oh2nPXjRLMEhYLvcre8Lm4tqz/2XKoUTKzLIQ+frigRnlB4rkogOV
	+ELAT9MQRYjbzXrKLhv4JO5yeEJ4PpQcv6HzVD+HSJcQNeXSo/zieGaMe6wcH4renaXJvs6zmV6e3
	Z3PP4MmmVwr/3YRkl8NcIrD6yk26MCwjFVXoYKWFFEVNkRydriQg6jI17BfAGH3WV9/UWmAYYV52K
	IVIIgD+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvYd-0000000A8ik-0CUP;
	Fri, 28 Feb 2025 08:17:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvVT-0000000A7l0-1u7X
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 08:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RW2S6X5ptZrapMdWo1yqIKyOazSb405vqeZrfbMITc=;
	b=RLVk5ciFn4fkDlvRmGSlXjewIdx7fiqV4GFY4xzoqCCCG2GGqT6hsy96zORAB+mXlqKHd5
	7ohCjpfBC3ZAJkYUpF/fc3nlU9Gbr9Bx88r28i1rjkSpMktQa/AUE2CC0Z3awcpCw8exwR
	2J6phSwK8OYmbRc3pL4B+g9gzEuIkCo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-Tq3jjiP9Pxm14G1fBQDICA-1; Fri,
 28 Feb 2025 03:13:57 -0500
X-MC-Unique: Tq3jjiP9Pxm14G1fBQDICA-1
X-Mimecast-MFC-AGG-ID: Tq3jjiP9Pxm14G1fBQDICA_1740730436
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1020E1954126;
	Fri, 28 Feb 2025 08:13:56 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1BBF1800359;
	Fri, 28 Feb 2025 08:13:49 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:13:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 4/6] io_uring: add support for kernel registered bvecs
Message-ID: <Z8FwNxRdeRFBEXGL@fedora>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223916.143006-5-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_001403_560357_32237537 
X-CRM114-Status: GOOD (  10.70  )
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

On Thu, Feb 27, 2025 at 02:39:14PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide an interface for the kernel to leverage the existing
> pre-registered buffers that io_uring provides. User space can reference
> these later to achieve zero-copy IO.
> 
> User space must register an empty fixed buffer table with io_uring in
> order for the kernel to make use of it.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


