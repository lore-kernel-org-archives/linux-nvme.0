Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F36ACCD1A5
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Oct 2025 03:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ibXRoeaySX78RFSu+m8DZA78GB7YAHpBsMVeutqEJxM=; b=sLaqC0lZe8xzXj70dViW6/WSt2
	sNL1dKk2TWNiNxqsqRltmThBv4glJfknwQWwdj+NqfjYAEWl0yYCz0YqPooREoXdZhTBLMUcBlm+Q
	ie6QJxPWGvMHm/AUXw8jz9QlfQWKd8Pj7UhgagXMVUpj+dA0q/7Xe6iCGUL/DFmFjVbFbma1ykYCR
	BwvM0CjbmlxHuaZA6BTVT5F3kuOK0CbNSQbEmQb8O2PXH3ALRpkn/opfieKpfzyWDCfE6IMIrjDWB
	zjiPsmUO0ywHMhC3zTl35DRE2mguUK5Mn7mwsVpLANcXzpk0PQZe0PD25J2Gc8XijKXbWhKM6Nhnx
	7OuV0V6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8T3-000000089ER-1mfK;
	Fri, 24 Oct 2025 03:27:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8T1-000000089Dv-1e8u
	for linux-nvme@lists.infradead.org;
	Fri, 24 Oct 2025 03:27:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761276470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibXRoeaySX78RFSu+m8DZA78GB7YAHpBsMVeutqEJxM=;
	b=gTxaxpRHi8/tKIuk3y/qEKrVn7qg3DYxY+WxW0LHboRydtCJYxf0i7nV88SliK0lo4Oxv3
	c8WChZ7nByyTaomXxVkqbLtb++O4+FJim7SB2JuKI4KMAqGFSvID+3n9jnHsSW+Y45AT0O
	IDIrYv0OF9xf7IXH1NR7LNGqZ2q+Qvw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-8SvPHszkMW-c28UCoYrY1Q-1; Thu,
 23 Oct 2025 23:27:46 -0400
X-MC-Unique: 8SvPHszkMW-c28UCoYrY1Q-1
X-Mimecast-MFC-AGG-ID: 8SvPHszkMW-c28UCoYrY1Q_1761276464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEC721800245;
	Fri, 24 Oct 2025 03:27:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 336F9180044F;
	Fri, 24 Oct 2025 03:27:33 +0000 (UTC)
Date: Fri, 24 Oct 2025 11:27:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] io_uring/uring_cmd: call io_should_terminate_tw()
 when needed
Message-ID: <aPryIDKfN1GB3Ips@fedora>
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023201830.3109805-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_202751_499851_7F8E5A17 
X-CRM114-Status: UNSURE (   9.77  )
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

On Thu, Oct 23, 2025 at 02:18:29PM -0600, Caleb Sander Mateos wrote:
> Most uring_cmd task work callbacks don't check IO_URING_F_TASK_DEAD. But
> it's computed unconditionally in io_uring_cmd_work(). Add a helper
> io_uring_cmd_should_terminate_tw() and call it instead of checking
> IO_URING_F_TASK_DEAD in the one callback, fuse_uring_send_in_task().
> Remove the now unused IO_URING_F_TASK_DEAD.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


