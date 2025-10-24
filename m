Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0C9CCD1A5
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Oct 2025 03:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBGpZ+b69w7Vm+EhedHcipsUWTvIk6iy1D0IPGn2dk8=; b=YduDHYMFGro+C9LHW0lmPqY7HF
	q27LJvS2ZZyd5Vox8hhO8VwZCA0CjO9OIR+RBBkVyFvyY+OsJye3EQnXngq/ab/Nn5g9EWu4m178c
	+zwMXINIVPT9+946nM2rckK5QRfYqjspfBExgtDX6QQVd3MvF69HrRlKkApfQP0GwgFpL4TX7Z/YD
	ZPbnJ4+eRWmUEuOK3/lDyzCKpO2twOECJKMi35BiANQoE+YlT30pZMbAEhcAY0llA7B9WHjcu+8m/
	LroZqtkCQfY5BRI8qN02XPToSr84CWkVYMKT6yoYQJucBVaZ/1Vf5pzJ9ML7oPipLVDo5qMuZ+zza
	M4NkhfDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8Rv-0000000891j-0Efl;
	Fri, 24 Oct 2025 03:26:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8Rq-0000000891M-1esL
	for linux-nvme@lists.infradead.org;
	Fri, 24 Oct 2025 03:26:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761276396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBGpZ+b69w7Vm+EhedHcipsUWTvIk6iy1D0IPGn2dk8=;
	b=e/26v4C+9bqPGqN5yv3iN2RMvSK+s8oamJegy5WrnKnfEv0Kdj04qPvja45n/iHwi0Z8hx
	GstjK8PBx4XTR+7UlLklA6rDBHFWhvemlrKo4vNvh0KBfcOlL3mbYlXmOsS73g1lEe67Qh
	ktJJPr2PIx0mDOnjaUyNbN1hDx/ul28=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-3XNFOwubM4iZvHWkmhe5wQ-1; Thu,
 23 Oct 2025 23:26:31 -0400
X-MC-Unique: 3XNFOwubM4iZvHWkmhe5wQ-1
X-Mimecast-MFC-AGG-ID: 3XNFOwubM4iZvHWkmhe5wQ_1761276388
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0420B1800378;
	Fri, 24 Oct 2025 03:26:27 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5367F19540EB;
	Fri, 24 Oct 2025 03:26:16 +0000 (UTC)
Date: Fri, 24 Oct 2025 11:26:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] io_uring: expose io_should_terminate_tw()
Message-ID: <aPrx05jWsnraLetW@fedora>
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-2-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023201830.3109805-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_202639_361293_77DB0436 
X-CRM114-Status: UNSURE (   8.89  )
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

On Thu, Oct 23, 2025 at 02:18:28PM -0600, Caleb Sander Mateos wrote:
> A subsequent commit will call io_should_terminate_tw() from an inline
> function in include/linux/io_uring/cmd.h, so move it from an io_uring
> internal header to include/linux/io_uring.h. Callers outside io_uring
> should not call it directly.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


