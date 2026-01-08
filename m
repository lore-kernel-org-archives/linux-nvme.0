Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A529D1488C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jan 2026 02:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e58AvOofkAZMERAjCRNSCzg+OQ2/rgznWXJZC9l5yys=; b=G2OUu/xp5tXB2B2UR2cp0CT7xS
	Gx9tVpiwoTvZicXC7O6yTeNUD4AuuLUBCPF5jhamAQ1FU9f5UlqBT+ymYzl2u3yLUUWZcFHR0YaEG
	Oo5tbSzf2pKJ01GGQUi/3BstbeBIw1GeXvS5QU87cV0nvt6U66qvGvvpEI5KWKkvoAH9VnxFpq/Cd
	91xxjHNdtPQV8crDL+jpeLDVJ2p4w9g7eB+ejF8drwc0vCUVdVpQ4LQzoLEM9mh59BHy5HekONINK
	651hOkup9a9M5Z1USi8HHNJeHs1DvkISfplrc6fLCn4mChPy3XwuBHAqokjuvTqxo7v3r7X1zNMlG
	39VrY26Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdfcp-0000000Fpin-3qIP;
	Thu, 08 Jan 2026 02:19:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdfcn-0000000FpiO-1Pxj
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jan 2026 02:19:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767838782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e58AvOofkAZMERAjCRNSCzg+OQ2/rgznWXJZC9l5yys=;
	b=K7EPUa8/avt8LYSvQr1OBeP/JzSuWpa0yq0pZB2l5HLDE3hvqIW+R3iF8Jdj++yjyn65mf
	kX0cznkHmB/q46MpMzVw8S6d1NCaainFvpcftnRZ3kEm4vjtKz/z/Gm8wRPPMKBrB9eWWl
	aPHnqbROnXMtct1qoL8Obr6mOumFalA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-C5u5R4y1Mv68vhPM4j7ZUg-1; Wed,
 07 Jan 2026 21:19:39 -0500
X-MC-Unique: C5u5R4y1Mv68vhPM4j7ZUg-1
X-Mimecast-MFC-AGG-ID: C5u5R4y1Mv68vhPM4j7ZUg_1767838776
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C016D18005A7;
	Thu,  8 Jan 2026 02:19:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FDBC19560A2;
	Thu,  8 Jan 2026 02:19:23 +0000 (UTC)
Date: Thu, 8 Jan 2026 10:19:18 +0800
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
Message-ID: <aV8UJvkt7VGzHjxS@fedora>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
 <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com>
 <20251204110709.GA22971@lst.de>
 <0571ca61-7b17-4167-83eb-4269bd0459fe@amd.com>
 <20251204131025.GA26860@lst.de>
 <aVnFnzRYWC_Y5zHg@fedora>
 <754b4cc9-20ab-4d87-85bf-eb56be058856@amd.com>
 <20260107160151.GA21887@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107160151.GA21887@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_181945_452979_D4F333A1 
X-CRM114-Status: GOOD (  19.71  )
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

On Wed, Jan 07, 2026 at 05:01:51PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 07, 2026 at 04:56:05PM +0100, Christian König wrote:
> > > But I am wondering why not make it as one subsystem interface, such as nvme
> > > ioctl, then the whole implementation can be simplified a lot. It is reasonable
> > > because subsystem is exactly the side for consuming/importing the dma-buf.
> > 
> > Yeah that it might be better if it's more nvme specific came to me as well.
> 
> The feature is in no way nvme specific.  nvme is just the initial
> underlying driver.  It makes total sense to support this for any high
> performance block device, and to pass it through file systems.

But why does FS care the dma buffer attachment? Since high performance host controller
is exactly the dma buffer attachment point.

If the callback is added in `struct file_operations` for wiring dma buffer
and the importer(host contrller), you will see it is hard to let it cross device
mapper/raid or other stackable block devices.

Thanks, 
Ming


