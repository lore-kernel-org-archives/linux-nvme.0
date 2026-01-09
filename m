Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96196D232CC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 02:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=09fZuRtKBthvUPFZRfmDU+5G5cxlC+xjTolnVnh0EhI=; b=e/wCsq+9PJXBdFlrZtrEHbpkcC
	Q0+I3WjG4Fb6Nvf6Gcx57pkkuV73EgcY37NxJI9rn/1akaY0SSIMHFuRj5d0caO/P7lqNyv0vDtiy
	XrZkoB/PS6t2pb/EDAtf9BY//vsqxjgfKNqR7TB8pvdlxsGUbq2tWHgQMBsPXOyKK0XLM+2TBsYZn
	OcN73MqGb1NrWE56drgKyd85KCheQlmPIxz1VYoSJbjbNv9sr1cupGltodpoRtOngont4tsGFf3L0
	fICmzJUTEbV6QOiDmzcFeSrGIyd9LplPuQDv4cgxLjWZxGx0uhXtaJKkm2Ms5zukva1lfBWAJBeN1
	sMyEXGsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve1yR-000000016O5-2adS;
	Fri, 09 Jan 2026 02:11:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve1yL-000000016NO-1dJW
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jan 2026 02:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767924687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09fZuRtKBthvUPFZRfmDU+5G5cxlC+xjTolnVnh0EhI=;
	b=Sd0vxm0pUqwYXg5/eeFBH8k4X1MtmxkgDk2rv1VBxJK0xDNewytX2ywSGzySiyInpal2xp
	eupfwKEjwzBRJOq6yQXpXwf/t+WkdnOiIDIv/aGF1N/Qq+Tchm/5GLq8ss6tqr4vRnXfEn
	joyK5mK3+kn4bfz4y1YB1VN6T/B8Uyw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-A_n-5HUKMWaEy_K0o4HrYg-1; Thu,
 08 Jan 2026 21:11:20 -0500
X-MC-Unique: A_n-5HUKMWaEy_K0o4HrYg-1
X-Mimecast-MFC-AGG-ID: A_n-5HUKMWaEy_K0o4HrYg_1767924676
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CBA9195608F;
	Fri,  9 Jan 2026 02:11:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.172])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4C1230002D5;
	Fri,  9 Jan 2026 02:11:02 +0000 (UTC)
Date: Fri, 9 Jan 2026 10:10:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
Message-ID: <aWBjsa2RZ_uaO9Ns@fedora>
References: <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
 <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com>
 <20251204110709.GA22971@lst.de>
 <0571ca61-7b17-4167-83eb-4269bd0459fe@amd.com>
 <20251204131025.GA26860@lst.de>
 <aVnFnzRYWC_Y5zHg@fedora>
 <754b4cc9-20ab-4d87-85bf-eb56be058856@amd.com>
 <20260107160151.GA21887@lst.de>
 <aV8UJvkt7VGzHjxS@fedora>
 <20260108101703.GA24709@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108101703.GA24709@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_181130_501910_80566465 
X-CRM114-Status: GOOD (  21.97  )
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

On Thu, Jan 08, 2026 at 11:17:03AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 08, 2026 at 10:19:18AM +0800, Ming Lei wrote:
> > > The feature is in no way nvme specific.  nvme is just the initial
> > > underlying driver.  It makes total sense to support this for any high
> > > performance block device, and to pass it through file systems.
> > 
> > But why does FS care the dma buffer attachment? Since high performance
> > host controller is exactly the dma buffer attachment point.
> 
> I can't parse what you're trying to say here.

dma buffer attachment is simply none of FS's business.

> 
> > If the callback is added in `struct file_operations` for wiring dma buffer
> > and the importer(host contrller), you will see it is hard to let it cross device
> > mapper/raid or other stackable block devices.
> 
> Why?
> 
> But even when not stacking, the registration still needs to go
> through the file system even for a single device, never mind multiple
> controlled by the file system.

dma_buf can have multiple importers, so why does it have to go through FS for
single device only?

If the registered buffer is attached to single device before going
through FS, it can not support stacking block device, and it can't or not
easily to use for multiple block device, no matter if they are behind same
host controller or multiple.


Thanks,
Ming


