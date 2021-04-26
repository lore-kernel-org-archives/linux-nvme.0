Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448D1C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 15:19:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5356135A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 15:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5356135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=spmEEZz1OGVw7So0xoYF7Q1q/Z2bwzwg0hb0qkesC60=; b=ivvPhVkOUWXKrw093b+IYjW64
	xAYII3uPVRnjzbHvOdTmQ8kvGOPwGl5ppRcYfZeUhkuIIVfAAnSyyjTVkmsV0O2TqS1rvj4pFqGX4
	E/9WS97oolvZ+2rRLkl50C8uvsIJkm/oTswYPFz2OM0huilIaCBp46HtCAoFfVqAHdeGQvB0rxY6k
	2ixZMaQtxkCjmsTt2eG1N8/sBYpvRmKq9sfLHU61pfPXR9995osRAxgRXMjxmmxl8RO/vk+NjGGiJ
	2eMca7oyYpRkzYIyGVNEjC2k52DmUftbY/7E4ES0tGIAnQxAAeHARCfNF56mH2XY2gUZ15d+rjzIg
	ClujYBXMA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb30f-007wwg-Pd; Mon, 26 Apr 2021 15:18:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb30b-007wwL-3i
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 15:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=4qxuMDA2jkb3xlCZf/MkasXjabaHRvw4Whl59SpuDXE=; b=IJqIztNAfRsBqgZiIqDEuhAGyr
 +6WegK/jHCB7OAtTJynQV9SAiQufDiUJKVG8HzhZbrjEmECpy0Sirn/D0P66XUmkviBkuDaQIwfzJ
 2/SeFS7oponYerHkXgDnV7GU1z17Myytv9nSYInI3RHTMGyIyBB7ipSJ4AQ7wV0+p8Ho+En6VPPvY
 6o57am+RHIX8tm18zX0DedjvyMT8NpQZxlp1ODHW4khz4YbBjiIGAUy/AIypFjm7RndoZpX51+9Ba
 /UBlO1rZ8rmBVqzAkLc/F8G17VxbBSBb6IFavEam1JWUjtokoqbiOfytdjD3Tqx2j8tVF1hT2EiGB
 ktO7SFnw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb30X-00G2dc-Ec
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 15:18:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619450320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qxuMDA2jkb3xlCZf/MkasXjabaHRvw4Whl59SpuDXE=;
 b=VXFv8+PkbO9Hb9l2E63hyvs4Nu/CP4GF4c+RtEWT2pYo6M/DfLAVIv7Qu12KHb9tMKODtg
 bffCia2XkePBBJyGKDwe3t9yi51aWR2ebeLrPalKQkm7r+YrvgMEnVHaW7PPNKoDkvgw44
 YHT4KZsJ2DQkgyyCu2kIZFpCElV+f8M=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C7FD8ABE8;
 Mon, 26 Apr 2021 15:18:40 +0000 (UTC)
Message-ID: <22475a77214fb26f4653600bdc5d40a2aeb76678.camel@suse.com>
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
From: Martin Wilck <mwilck@suse.com>
To: Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Christoph
 Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Date: Mon, 26 Apr 2021 17:18:37 +0200
In-Reply-To: <9c65df32-bbf5-68b3-566e-3b79f7e6f893@huawei.com>
References: <20210423133835.25479-1-mwilck@suse.com>
 <65167282-84e7-d08b-f97d-edb0d1372a49@suse.de>
 <9c65df32-bbf5-68b3-566e-3b79f7e6f893@huawei.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_081845_809504_D6A2FD39 
X-CRM114-Status: GOOD (  21.80  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2021-04-26 at 10:31 +0800, Chao Leng wrote:
> =

> =

> On 2021/4/25 19:34, Hannes Reinecke wrote:
> > On 4/23/21 3:38 PM, mwilck@suse.com=A0wrote:
> > > =

> > > If such a timer is encountered in run_timer_softirq(), the kernel
> > > crashes. The test scenario was an I/O load test with lots of NVMe
> > > controllers, some of which were removed and re-added on the storage
> > > side.
> > > =

> > ...
> > =

> > But isn't this the result of detach_timer()? IE this suspiciously
> > looks like perfectly normal operation; is you look at expire_timers()
> > we're first calling 'detach_timer()' before calling the timer
> > function, ie every crash in the timer function would have this
> > signature.
> > And, incidentally, so would any timer function which does not crash.
> > =

> > Sorry to kill your analysis ...
> > =

> > This doesn't mean that the patch isn't valid (in the sense that it
> > resolve the issue), but we definitely will need to work on root cause
> > analysis.
> The process maybe:1.ana_work add the timer;2.error recovery occurs,
> in reconnecting, reinitialize the timer and call nvme_read_ana_log,
> nvme_read_ana_log may add the timer again.
> The same timer is added twice, crash will happens later.

Thanks a lot! I think you nailed it.

I had another look at my dump with this in mind, and indeed I was able
to prove that the timer of the same NVMe controller had been started
(at least) twice. This explains why it looks as if it had been cleanly
detached, and is still running nonetheless.

In particular, I saw this:

[ 4389.939928] nvme nvme36: queue_size 128 > ctrl sqsize 32, clamping down
[ 4389.962709] nvme nvme36: creating 4 I/O queues.
[ 4389.978462] nvme nvme36: starting error recovery
[ 4389.978509] nvme nvme36: failed to send request -32
[ 4389.978724] nvme nvme36: Failed to configure AEN (cfg 900)
[ 4389.978732] nvme nvme36: Successfully reconnected (1 attempt)
[ 4389.978739] nvme nvme36: failed to send request -32
[ 4389.991420] nvme nvme36: Reconnecting in 10 seconds...
...
[ 4441.399435] nvme nvme36: queue_size 128 > ctrl sqsize 32, clamping down
[ 4441.407647] nvme nvme36: creating 4 I/O queues.
[ 4441.445655] nvme nvme36: Successfully reconnected (1 attempt)
[ 4441.699665] nvme nvme36: starting error recovery
[ 4441.719493] nvme nvme36: Identify Descriptors failed (881)
[ 4441.735409] nvme nvme36: Reconnecting in 10 seconds...
...
[ 4510.891400] nvme nvme36: ANATT timeout, resetting controller.
...
[ 4517.035411] general protection fault: 0000 [#1] SMP PTI

The protection fault was caused by the anatt timer of another nvme
controller. But I could see the anatt_timer of nvme36 still linked to
an active timer_base, about to expire 44s in the future. Calculating
back, that timer had been started around 4441s above, whereas the timer
that expired a few seconds earlier must have been started at 4389.9.

Regards,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
