Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5857EEE4996
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZ4ton4wktRlg2SquHDeanynudOTu7BF/gu7/NeFubI=; b=xKzvy6Dvad6E6j36kKxI14DLsA
	sw9+/xozELOvlpo0pXdEgXowS5359cOaWp6TwZZYc3tLqLYRkv/8R1TZyrkaxqbzO3F2lG1Qnokk4
	hNVadwCkv+Nusm6UD21Gm5/xTy8/o4e/LpaR5K7uIVxx8eA3oVx+RaoDra7SxwpiBNX4YPnjRDle+
	MLYkhpoD8wNJTGme2lCcIJEPn4FL8+QDH0lxOaN0TSOVt6Tu81siV8HjZ8FiA/e6OZhgjMmOZdniX
	xoG4SBwCBvynKm5A8jvEqumTbIUNcIX/e/bU/SkkuInAeOAiQ8IeV+FJF8j1xbAWYtADsT++0zd5X
	dr1hJs8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qY56O-00E5fP-2E;
	Mon, 21 Aug 2023 13:37:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qY56L-00E5ex-0X
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 13:37:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C91A206B4;
	Mon, 21 Aug 2023 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692625061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ4ton4wktRlg2SquHDeanynudOTu7BF/gu7/NeFubI=;
	b=Ws6X+3RxjLqupjHrUS6QcHj/d26fhKH2f3qqcv2crYUSchPQVsaAU8TqCGjSoAUm2wVWjU
	DhghoRuZb9JyeEhU7f1HVi7h0N7QwoiiitG6EPcLl9R4Zbn6nMe2amGv6PcpDTwzZIZsJf
	o37fBIIAfpIYrEaQXsoWXVEeAabWCTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692625061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ4ton4wktRlg2SquHDeanynudOTu7BF/gu7/NeFubI=;
	b=bVdBldobD9eJ0CxwMNiMVf9NA5ZkjvGG/vX5HiuPVF5A4tHmp3yKWs6TM5djh+iKUBZv4x
	UUr2jmEudOCOgUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4413B1330D;
	Mon, 21 Aug 2023 13:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wuGYEKVo42RpYwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 21 Aug 2023 13:37:41 +0000
Date: Mon, 21 Aug 2023 15:37:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, 
	Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
 <20230726131643.GA16186@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726131643.GA16186@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230821_063749_375017_F2C3A5CC 
X-CRM114-Status: GOOD (  25.88  )
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

On Wed, Jul 26, 2023 at 03:16:43PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 26, 2023 at 01:52:04PM +0200, Daniel Wagner wrote:
> > FYI, I got a a bug report [1] with a 'stack smashing detected' when running
> > 'nvme sanitize-log /dev/nvme0' on Debian. Originally, it was reported against
> > udisk. udisk recently added libnvme which does now a sanitize-log call, so this
> > problem might exists for a while.
> > 
> > We figured out that an older kernel such as 4.19.289 work but newer not (it's a
> > bit hard for the reporter to test all combinations on his setup due to compiler
> > changes etc.).
> > 
> > There was a bit of refactoring in v5.2 which could be the cause of the stack
> > smash, because saw this recent fix:
> > 
> >  b8f6446b6853 ("nvme-pci: fix DMA direction of unmapping integrity data")
> > 
> > [1] https://github.com/storaged-project/udisks/issues/1152
> 
> If you think it is related to DMA, there are good ways to check for:
> 
>   1) force that an IOMMU is used for this device
>   2) hack nvme or the blk-map code that we never do the direct mapping
>      to user space but do the copy based version, and then enable
>      all kernel memory debugging helpers, most importantly KASAN

Collected some info:

 - this happens only with devices from MAXIO Technology

   vid       : 0x1e4b
   ssvid     : 0x1e4b

 - Oleg bissect the kernel and he landed on 3b2a1ebceba3 ("nvme: set
   dma alignment to qword"). He hacked the kernel and this made it
   work again:

   --- a/drivers/nvme/host/core.c
   +++ b/drivers/nvme/host/core.c
   @@ -1871,7 +1871,6 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
                   blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
           }
           blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
   -       blk_queue_dma_alignment(q, 3);
           blk_queue_write_cache(q, vwc, vwc);
   }

 - modified the reproducer so that it allocates a 4k buffer with a well
   known pattern and checked the buffer after fetching the sanitize log
   [1]. The first invocation wrote 0x940 bytes and the second 0x5c0
   bytes. Note we just asking for 0x200 bytes.

 - modified blk_rq_map_user_iov so that it always uses the copy path.
   The problem went away. Though forgot to ask to turn on KASAN but
   given that we know the device writes too much data it is likely also
   overwriting some kernel memory.

So what's the best way forward from here? Introduce a quirk and always
use bounce buffer?

[1] https://github.com/storaged-project/libblockdev/pull/951#issuecomment-1676276491

