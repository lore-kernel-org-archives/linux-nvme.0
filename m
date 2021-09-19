Return-Path: <SRS0=MITl=OJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3068C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 23:06:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8136960E52
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 23:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8136960E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YkatBeHP8qEo+PATUmBQOTe9kYLzQ3pl9Dnc1PFxCUc=; b=xwn0vSJUO42RB9
	Ab+TzXyYnSZp2PnbfdCIlgSZx7jxfd7yWZdA9yrUpxKzSComZldC6P/2f1uWUHhugjE1FtKUnQcCC
	SQupsiDFvbEZZnewMnefStulmD0vb6gu4WdfJ9NRb3cKiWS0LtjNLMrp8sVJGfT2lQ/dw9vrV4A3S
	D5RIUjKnnYa2++a0ZD98cI+6cBHkt1dOSRUpq+bk53Pi0PtQMSfBUzggOZ79nNpE76Ig9utUj+BLK
	AuXrvJqPekRiKPbcI1FVe28+WcaqUNfuYtwX/crCEOqMiCe9OSARGUhnK3u32nPL+IO671fiq7zCB
	FGhBCRam1xzcACGuPlaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mS5sT-000NX3-Fs; Sun, 19 Sep 2021 23:05:41 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mS5sQ-000NWk-JA
 for linux-nvme@lists.infradead.org; Sun, 19 Sep 2021 23:05:40 +0000
Received: by mail-wr1-x42b.google.com with SMTP id t18so25515707wrb.0
 for <linux-nvme@lists.infradead.org>; Sun, 19 Sep 2021 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WKzmMSfRPlR3srLq1C3p6gPmVLEve2GJXTd6Sojc6sU=;
 b=j4Zg4rpXdWKxD2+f5dnqsgB3d+c27x56mfGOqOm/yAA6FkbVspHJezAmAQMDkk4si/
 XhqZCLy6oESNfuzbc7lHyzW80lXdxzMVeTsg+7kuCJCJxC/DsxyAdoe4iOqSHTdREeft
 sL0bKkNe6E/SPL9bafT2V7qyit7SrkJntskgXYP9hsvwIitnSgHL+aW1AlVwKtfJ0DGx
 +3pjREhN6jc43nbDdETzz96y06qGNfhoI8HuwHhramOakryEGAtM7nCXmH+enhSlSoOC
 AxzSOlY+y88hM7sg7N7aczzj/FF3InuR6ueBwhSYnXxFrm/yQTJKdcPz1mgkYhgalMni
 woaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WKzmMSfRPlR3srLq1C3p6gPmVLEve2GJXTd6Sojc6sU=;
 b=zHOJmuOQ+LC1YL9ReG5ectkWBBE8o9bi7I49LtYuTpsug/PTnhmFhCSwhBSwrF1SsR
 1agEEie1WuyPE55v+X2Sb2YkQrXb7BNlK3YQllojwATvEeeAg0LWQsGRklCxwbNk8FLo
 EYRJlvoc5J0MA92ssi37LQGMCb/qk88irP4s5Wbwd1rbYWSrUoEdgxlIkHyf+FWeIPyJ
 p5UgynrqXRiwr5kC6GoxFE7BzGbT8Oi7uKVHie140JYMq872eD3BKCDMY090MQjDNYRq
 9rrIEXp3mKqB1aT/fK0D1HUf+1h2CADg6k9uEMGKZkZ3RemKGDJ9jlv/8KYdDJAzQhC2
 KTOA==
X-Gm-Message-State: AOAM532moqFJ4Y5uhHLsc7AsY3HLOoVoguKx9zDwz0kI60U6FcUExkzf
 dKEk+EPuQUFRX/ErQkTIvuk=
X-Google-Smtp-Source: ABdhPJxCXCUx70afSlJev9Xg++vMuA4WAMVHKKctPLIcNaNgDm7qy6VbqSW+pLGOKIjfyj9HeTaOIw==
X-Received: by 2002:adf:c148:: with SMTP id w8mr25293908wre.317.1632092733324; 
 Sun, 19 Sep 2021 16:05:33 -0700 (PDT)
Received: from anton-latitude (c-76-23-2-87.hsd1.ut.comcast.net. [76.23.2.87])
 by smtp.gmail.com with ESMTPSA id
 g1sm20910849wmk.2.2021.09.19.16.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Sep 2021 16:05:32 -0700 (PDT)
Date: Sun, 19 Sep 2021 17:05:24 -0600
From: Anton Eidelman <anton.eidelman@gmail.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, axboe@fb.com
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
Message-ID: <20210919230524.GA451482@anton-latitude>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <b6dd0d15-041e-209e-953c-1b991c0738c9@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6dd0d15-041e-209e-953c-1b991c0738c9@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210919_160538_692499_52564B9B 
X-CRM114-Status: GOOD (  31.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Well, this works for me (passes a test that gets into
the described scenario deteministically),
probably because we nvme_start_queues() earlier
in nvme_tcp_configure_io_queues().
Same is correct for rdma transport.

On Sun, Sep 19, 2021 at 01:19:39PM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/19/21 12:57 AM, Anton Eidelman wrote:
> > nvme_mpath_init_identify() invoked from nvme_init_identify()
> > fetches a fresh ANA log from the ctrl.
> > This is essential to have an up to date path states
> > for both existing namespaces and for those scan_work
> > may discover once the ctrl is up.
> > 
> > This happens in the following cases:
> > 1) A new ctrl is being connected.
> > 2) An existing ctrl is successfully reconnected.
> > 3) An existing ctrl is being reset.
> > 
> > While in (1) ctrl->namespaces is empty, (2 & 3) may have namespaces,
> > and nvme_read_ana_log() may call nvme_update_ns_ana_state().
> > 
> > This result in a hang when the ANA state of an existing namespace
> > changes and makes the disk live: nvme_mpath_set_live() issues
> > IO to the namespace through the ctrl, which does NOT have IO queues yet.
> > See sample hang below.
> > 
> > Solution:
> > - move nvme_read_ana_log() call from nvme_mpath_init_identify()
> > into a separate function, nvme_mpath_update().
> > - call this function in nvme_start_ctrl() - here the ctrl is ready.
> > 
> > Downside: in case nvme_read_ana_log() fails, we do not find this out
> >    in nvme_mpath_init_identify().
> > 
> > Alernative solution:
> >    nvme_get_log() in nvme_mpath_init_identify(), but don't parse.
> >    Then nvme_start_ctrl() can just queue_work(nvme_wq, &ctrl->ana_work),
> >    along with scan_work.
> >    The ctrl->ana_log_buf contents is valid for scan_work,
> >    and ana_work will re-fetch and parse it.
> >    Downside: fetching an ANA log from the ctrl twice.
> > 
> > Sample failure:
> >      nvme nvme0: starting error recovery
> >      nvme nvme0: Reconnecting in 10 seconds...
> >      block nvme0n6: no usable path - requeuing I/O
> >      INFO: task kworker/u8:3:312 blocked for more than 122 seconds.
> >            Tainted: G            E     5.14.5-1.el7.elrepo.x86_64 #1
> >      Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
> >      Call Trace:
> >       __schedule+0x2a2/0x7e0
> >       schedule+0x4e/0xb0
> >       io_schedule+0x16/0x40
> >       wait_on_page_bit_common+0x15c/0x3e0
> >       do_read_cache_page+0x1e0/0x410
> >       read_cache_page+0x12/0x20
> >       read_part_sector+0x46/0x100
> >       read_lba+0x121/0x240
> >       efi_partition+0x1d2/0x6a0
> >       bdev_disk_changed.part.0+0x1df/0x430
> >       bdev_disk_changed+0x18/0x20
> >       blkdev_get_whole+0x77/0xe0
> >       blkdev_get_by_dev+0xd2/0x3a0
> >       __device_add_disk+0x1ed/0x310
> >       device_add_disk+0x13/0x20
> >       nvme_mpath_set_live+0x138/0x1b0 [nvme_core]
> >       nvme_update_ns_ana_state+0x2b/0x30 [nvme_core]
> >       nvme_update_ana_state+0xca/0xe0 [nvme_core]
> >       nvme_parse_ana_log+0xac/0x170 [nvme_core]
> >       nvme_read_ana_log+0x7d/0xe0 [nvme_core]
> >       nvme_mpath_init_identify+0x105/0x150 [nvme_core]
> >       nvme_init_identify+0x2df/0x4d0 [nvme_core]
> >       nvme_init_ctrl_finish+0x8d/0x3b0 [nvme_core]
> >       nvme_tcp_setup_ctrl+0x337/0x390 [nvme_tcp]
> >       nvme_tcp_reconnect_ctrl_work+0x24/0x40 [nvme_tcp]
> >       process_one_work+0x1bd/0x360
> >       worker_thread+0x50/0x3d0
> > 
> > Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
> > ---
> >   drivers/nvme/host/core.c      | 1 +
> >   drivers/nvme/host/multipath.c | 9 ++++++---
> >   drivers/nvme/host/nvme.h      | 4 ++++
> >   3 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 97f8211cf92c..884ca1f6f80b 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4325,6 +4325,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
> >   	nvme_enable_aen(ctrl);
> >   	if (ctrl->queue_count > 1) {
> > +		nvme_mpath_update(ctrl);
> 
> Does this ordering now becomes subtle as it needs to run before we queue the
> ns scan?
> 
> >   		nvme_queue_scan(ctrl);
> >   		nvme_start_queues(ctrl);
> >   	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
