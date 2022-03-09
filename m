Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277ECC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CaryvCONEenorkG6wvciODWvEydEyaCKpadyzXr2EqY=; b=mjqTjNpRW+7NAeahVP4x3fXu1U
	IOd01KArnt8v/goOYxBBdO8IHyJ7X0hfMeQPkWf/tcW1QS9TaqguIJ+zIU76cIta82yoggpS5IaDk
	26fuZi2ILnsevYWN96cekaA1CxtCiMCMWGzocQY/GXfQnDtpqNKQ/QshoTzsF3KBeD2oS5cNG2cfa
	JzrderL09/D2JGZkAmbTX4owOaM5/lSicIu0ZUY723GNkynRiasq5QvvOsb/dAgt+hwtFNkkutOBn
	6SYPFiVeTHEnLAfvmxXynlj1y9fuCARdi7eid6OYWZQ/s7Ti76DbeSEEvWomThBZGKKTNlGJtlzQC
	0TOl4cvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRk2v-006if9-FV; Wed, 09 Mar 2022 00:19:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRk2s-006ieP-24
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 00:19:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646785151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CaryvCONEenorkG6wvciODWvEydEyaCKpadyzXr2EqY=;
 b=UEplenvDG6vCrTCOBnAvfSw5iYVtI7mTuhM42OKud+b9y0HpmWsHEjjQl5zUvPj9PvV3XE
 RgSBk521wHWdiidAb9Uxxn3IBbgfKWLVzdRq2gIBvl+s64hFLOkE3zV/0kodIjMeo4kA4l
 WJbbtflIcMdPCGIRUZzLGWG7t3e+4Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-XLOX9gQrOyiGu8xYz4WDUA-1; Tue, 08 Mar 2022 19:19:06 -0500
X-MC-Unique: XLOX9gQrOyiGu8xYz4WDUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D249C180FD71;
 Wed,  9 Mar 2022 00:19:04 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34FBC66E36;
 Wed,  9 Mar 2022 00:18:51 +0000 (UTC)
Date: Wed, 9 Mar 2022 08:18:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <YifyZ9MoUws/7esK@T590>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
In-Reply-To: <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ming.lei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_161914_235772_608181E1 
X-CRM114-Status: GOOD (  30.14  )
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

On Tue, Mar 08, 2022 at 11:52:38AM -0800, Keith Busch wrote:
> On Tue, Mar 08, 2022 at 05:45:20PM +0100, Maurizio Lombardi wrote:
> > Hello,
> > 
> > I recently received a bug report complaining about disk corruptions when
> > issuing a NVME_IOCTL_ADMIN_CMD / IDENTIFY ioctl() with cmd.data_len =
> > 8192 bytes and the buffer address not aligned to the page size.
> > 
> > This is the C program that we used to reproduce the issue (tested with
> > 5.17.0-rc6): http://bsdbackstore.it/misc/nvme_ioctl_512.c
> > 
> > simply run it by passing a path to an nvme device:
> > ./nvme_ioctl_512  /dev/nvme0n1
> > 
> > It appears to be very unpredictable. Sometimes I hit disk corruptions
> > after a few tries, sometimes it takes hours. Sometimes the ioctl()
> > returns success and sometimes it fails.
> > 
> > We suspect that the root cause is that the nvme-host driver doesn't
> > enforce the 4096 byte limit for the IDENTIFY commands as the
> > nvme-target does (see the nvmet_execute_identify() -->
> > nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE) code).
> > So if we pass a 8192-byte buffer not aligned to the page size, it will
> > need 3 pages on archs where page size is 4k and the nvme spec says
> > that the data buffer may not cross more than one page boundary.
> > 
> > Does it make sense to you? What's your opinion on this?
> 
> You are telling the driver to prepare a 3-page PRP, so it makes a PRP
> list. The device knows it's a 4k payload, though, so it thinks your PRP
> list pointer is actually a pointer to the data destination. The device
> is corrupting that memory, which could lead to on-disk corruption if
> that memory is concurrently used for a data-out command. Observing that
> type of corruption is probably not deterministic.
> 
> This was an unfortunate pitfall of nvme's PRP method: the transfer
> length is implicit, so both sides need to agree on that for everything
> to work. If either side is mistaken on the transfer length, then you get
> corruption.
> 
> In short: don't do that. If your application misuses the ioctl to break
> it, you get to keep both pieces.

Given NVMe spec states that data length of IDENTIFY command should be
4096bytes, and PRP list can't be used. 

So looks nvme driver need to validate the command before submitting to
hardware, otherwise any buggy application can break FS or memory easily.


Thanks,
Ming


