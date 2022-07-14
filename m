Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243BFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 03:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3PqAwSujQrcFKBakWmxqsGxJDNIOKr6UoNvVqvwCEF4=; b=vhnbi5dP9agTIG+INeWmYVsj7U
	H9dBmKSBFkndGF4iZ6knrY0+drweFlsLBxPLZ1QvM3n+EHGtbJ1cq8n/lRTle6BqWZCiDzwh00llk
	VzSiP9kYRYXR0mI8PHQBDrUpCC+scXa9/Q2MO78jrvqPai0ye4mARjV/1lmc1HW2RYwCuU9OQbspK
	TnOqlbLMfxvlDKw63LvEJtUgY5P3PwOlPv73lBBsJKGRku+hmDsSB9nA+N5UGaHvfY3ZMWRS2ONND
	/3c4ah/cwYaWIBLr3EX7w0DRMct7tbGt1DdkOEe+c9tIOFWTEWkxTxknitE69Z1MUjw5QvI5aUYOT
	gUkfJPtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBpix-00AMva-W1; Thu, 14 Jul 2022 03:41:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBpiv-00AMrb-Kt
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 03:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657770064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3PqAwSujQrcFKBakWmxqsGxJDNIOKr6UoNvVqvwCEF4=;
	b=EDC1bRo1y/XQDQk1vWuMH9c3WGg2gPN+Ue7vz/ctamE7A7Jx6bulURSM+ahqhCY0Snmlqa
	fIIrmwEsNIRfmTNO+03JEq52U32q6c6/A/PFMrs8Nl2sSrwQFBdkSa4uscD35BlG59LiZR
	R7ztKKB3LGfKBaahViArA7wrBAG+lB4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-lj0l3Q0eN2CkbUOOcky_hw-1; Wed, 13 Jul 2022 23:41:00 -0400
X-MC-Unique: lj0l3Q0eN2CkbUOOcky_hw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E77CB1C14487;
	Thu, 14 Jul 2022 03:40:59 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D52C40CF8EE;
	Thu, 14 Jul 2022 03:40:51 +0000 (UTC)
Date: Thu, 14 Jul 2022 11:40:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	hch@lst.de, kbusch@kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
	gost.dev@samsung.com, ming.lei@redhat.com
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Message-ID: <Ys+QPjYBDoByrfw1@T590>
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
 <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
 <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_204110_002738_4FF96592 
X-CRM114-Status: GOOD (  19.07  )
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

On Mon, Jul 11, 2022 at 09:22:54PM +0300, Sagi Grimberg wrote:
> 
> > > > Use the leftover space to carve 'next' field that enables linking of
> > > > io_uring_cmd structs. Also introduce a list head and few helpers.
> > > > 
> > > > This is in preparation to support nvme-mulitpath, allowing multiple
> > > > uring passthrough commands to be queued.
> > > 
> > > It's not clear to me why we need linking at that level?
> > 
> > I think the attempt is to allow something like blk_steal_bios that
> > nvme leverages for io_uring_cmd(s).
> 
> I'll rephrase because now that I read it, I think my phrasing is
> confusing.
> 
> I think the attempt is to allow something like blk_steal_bios that
> nvme leverages, but for io_uring_cmd(s). Essentially allow io_uring_cmd
> to be linked in a requeue_list.

io_uring_cmd is 1:1 with pt request, so I am wondering why not retry on
io_uring_cmd instance directly via io_uring_cmd_execute_in_task().

I feels it isn't necessary to link io_uring_cmd into list.


Thanks,
Ming


