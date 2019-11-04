Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4BECA9ECF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 09:50:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E3F21D7D
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 09:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tVKrI8R8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E3F21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hvy6kTi4InwVhFZXkGlacbxBJMVXRegGEUmCj6NeXKY=; b=tVKrI8R8a099hd
	BK3EOZNx112AjD4xXU9k3ZQ7rCT4ZS/vNpfOgFjWjOx0rMsZYEb6NeLsElQKz201r8izsEzfuTGoc
	Oo0IeXbjqrjeji1Fvk8nmoP2/fDWogSi6G70UI2B78fEXvlk6bkMwHMzpy91m0XhIfxqtDo6SlMhB
	cQK/FsgObd/vse68mySS0Y7xerTuoDBjBnSADeq7/QHCxLYH11v8FqgXAn++upG8rW31sGbprH+os
	WQHTHts4oEYRW9PerVURzSuDC+GmS2a7cEP4XlnKTngOi0SyUAd+889Vhh4b77FHPObI+3FZ8fupy
	YIqP6sbi+rQVJki9X04Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRZ0Z-0003kK-DD; Mon, 04 Nov 2019 09:50:47 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRZ0W-0003jt-Mz
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 09:50:46 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8632EB2E1;
 Mon,  4 Nov 2019 09:50:41 +0000 (UTC)
Date: Mon, 4 Nov 2019 10:50:34 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvmet: Always remove processed AER elements from list
Message-ID: <20191104095034.GA3193@linux-lxv2>
References: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
 <20191104081338.gdrk2a4mlov2io6s@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104081338.gdrk2a4mlov2io6s@beryllium.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_015044_895837_A4BCA5EF 
X-CRM114-Status: GOOD (  11.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 04, 2019 at 09:13:38AM +0100, Daniel Wagner wrote:
[...]
> BTW, I got feedback how to produce the oops on our custerms setup:
> 
> Test Steps:
> 1. Create two targets on node n1 as target side (tgt1 and tgt2)
> 2. Run perf to write data to tgt2:
>    sudo ./perf -q 1 -w read -o 4096 -t 60 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4421'
> 3. Deleted tgt2 node n1 configuration during perf execution
>    and reboot the node n1 automatically.

I assume thhis "perf" is some kind of performance test. So it should be
possible to create a blktest recreating this issue.

I'd translate the "perf" line into something similar to 'fio -rw=read -bs 4k \
--time_based --timeout=60 --iodepth=1' and then running on a mpathed
nvme-loop and delete one of the controllers while the IO is running. This
should be a fairly usual multi-path test. The only thing I can't see yet
is, how we end up with unprocessed AENs here.

Byte,
	Johannes

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
