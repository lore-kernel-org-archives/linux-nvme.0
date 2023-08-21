Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F39CEE4993
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9qjHM63ewJnoN0R3RiE8BJvKc2Z69bN6pVonrBX5veQ=; b=MTt1quOnMvdnKUVZNYp18Pj0td
	1ARXc/18oEGrAD11/gncR1fmXmTbLJksnGyw882gwGtmMksXUsg+5/uCqxM1G4n2x2jIBlBey9TLR
	p18gkrrVmIfGmrDW0uA5P1SIciJdJA8AocejEh/+bYTCMoGYgUfxb2gfewObNless0+TzSAcWU3bU
	Wk8kV+Xz32raQNY1RxEkrDFgR3a1WitscdO4Kvje29FgxYdSiLdxc0X3xfyUxESKdWfXFG2tXO5Wh
	2vr7xgIfoXMc981g5M4tI+FFi+ksthB5Sf7L9mU5XEqGNxDdqysWPv03u1lm2KcxIcMqXTAnjKBNI
	9H3evNQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qY6ZH-00EFRN-1z;
	Mon, 21 Aug 2023 15:11:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qY6ZF-00EFQy-0G
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 15:11:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 19D7E637EC;
	Mon, 21 Aug 2023 15:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6F0C433C8;
	Mon, 21 Aug 2023 15:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692630701;
	bh=tbKCeWn0ZjvA3hj7JRQTS8xhr3rbKXqfbESVm3EMXkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKB/m4pOugUDDPydHqMovCsKdthip5ADQlKUoqoXDXCCSTlFDIBNQZydM6j/yqY/+
	 sFN0oa83Z/XOnQQTJcf1vpK2uKnk+tW+MFHk5n61ajzVnrKTp9+HtVOHbo493oIJuJ
	 vWGizY4RynHlckatme6nUT8x6MKW8fND//lw4i0xWJyR2yZrKD1A/g3ER1/k23r4CS
	 RzJXd8hUFPcklgZ2bw1MwWlwbPhYWQbexrY0GnmOlXARi26A9GU4kBmbRAzN60k5Gm
	 3emxKDWlWYsiVwIkSNykid+JjupQ/dGjH4VDww4dmru2P0mwMkhL7gbx0o530hxImi
	 FOlxcv1RqV/hQ==
Date: Mon, 21 Aug 2023 09:11:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
 <20230726131643.GA16186@lst.de>
 <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230821_081145_211479_20369D42 
X-CRM114-Status: GOOD (  38.31  )
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

On Mon, Aug 21, 2023 at 03:37:55PM +0200, Daniel Wagner wrote:
> On Wed, Jul 26, 2023 at 03:16:43PM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 26, 2023 at 01:52:04PM +0200, Daniel Wagner wrote:
> > > FYI, I got a a bug report [1] with a 'stack smashing detected' when running
> > > 'nvme sanitize-log /dev/nvme0' on Debian. Originally, it was reported against
> > > udisk. udisk recently added libnvme which does now a sanitize-log call, so this
> > > problem might exists for a while.
> > > 
> > > We figured out that an older kernel such as 4.19.289 work but newer not (it's a
> > > bit hard for the reporter to test all combinations on his setup due to compiler
> > > changes etc.).
> > > 
> > > There was a bit of refactoring in v5.2 which could be the cause of the stack
> > > smash, because saw this recent fix:
> > > 
> > >  b8f6446b6853 ("nvme-pci: fix DMA direction of unmapping integrity data")
> > > 
> > > [1] https://github.com/storaged-project/udisks/issues/1152
> > 
> > If you think it is related to DMA, there are good ways to check for:
> > 
> >   1) force that an IOMMU is used for this device
> >   2) hack nvme or the blk-map code that we never do the direct mapping
> >      to user space but do the copy based version, and then enable
> >      all kernel memory debugging helpers, most importantly KASAN
> 
> Collected some info:
> 
>  - this happens only with devices from MAXIO Technology
> 
>    vid       : 0x1e4b
>    ssvid     : 0x1e4b
> 
>  - Oleg bissect the kernel and he landed on 3b2a1ebceba3 ("nvme: set
>    dma alignment to qword"). He hacked the kernel and this made it
>    work again:
> 
>    --- a/drivers/nvme/host/core.c
>    +++ b/drivers/nvme/host/core.c
>    @@ -1871,7 +1871,6 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>                    blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
>            }
>            blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
>    -       blk_queue_dma_alignment(q, 3);
>            blk_queue_write_cache(q, vwc, vwc);
>    }
> 
>  - modified the reproducer so that it allocates a 4k buffer with a well
>    known pattern and checked the buffer after fetching the sanitize log
>    [1]. The first invocation wrote 0x940 bytes and the second 0x5c0
>    bytes. Note we just asking for 0x200 bytes.
> 
>  - modified blk_rq_map_user_iov so that it always uses the copy path.
>    The problem went away. Though forgot to ask to turn on KASAN but
>    given that we know the device writes too much data it is likely also
>    overwriting some kernel memory.
> 
> So what's the best way forward from here? Introduce a quirk and always
> use bounce buffer?

I don't think we want to bounce to kernel memory for the device to
overwrite it. I suggest just change nvme-cli's stack allocated santize
log to a use page aligned and sized buffer.

---
diff --git a/nvme.c b/nvme.c
index 181141ad..7f98a506 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2376,7 +2376,7 @@ ret:
 static int sanitize_log(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Retrieve sanitize log and show it.";
-	struct nvme_sanitize_log_page sanitize_log;
+	struct nvme_sanitize_log_page *sanitize_log;
 	enum nvme_print_flags flags;
 	struct nvme_dev *dev;
 	int err;
@@ -2419,13 +2419,19 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
 	if (cfg.human_readable)
 		flags |= VERBOSE;
 
-	err = nvme_cli_get_log_sanitize(dev, cfg.rae, &sanitize_log);
+	if (posix_memalign((void *)&sanitize_log, getpagesize(), 0x1000)) {
+		err = -1;
+		goto close_dev;
+	}
+
+	err = nvme_cli_get_log_sanitize(dev, cfg.rae, sanitize_log);
 	if (!err)
-		nvme_show_sanitize_log(&sanitize_log, dev->name, flags);
+		nvme_show_sanitize_log(sanitize_log, dev->name, flags);
 	else if (err > 0)
 		nvme_show_status(err);
 	else
 		nvme_show_error("sanitize status log: %s", nvme_strerror(errno));
+	free(sanitize_log);
 close_dev:
 	dev_close(dev);
 ret:
--

