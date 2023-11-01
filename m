Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E203BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5UIfMBVdGIbdKNzRDMLvhiScyxGbvuh4NifZMx02eQ=; b=hWPhbo2uORwI4Lyal0Cg5KAuMm
	FiIq5y9+ysmh3t98VOLLgJKNNKG5op5EKa32nmTfAtfqO3qvXUpj/lPui52wYHKgr4BUTWRXaZuCq
	t4jOALLLRwTMXZFqt249QqInT2xgCQw1rd8l4NetGAqF5fvdf5vd9MCxitIt1sKlMrqpHw3dXA16y
	aGOx7rnFg7TuOpir55iDT8raUzuV3o96H4sydb3MokcnQ1l7+j/i3eIOqj7si+owPRO+d3wZvk8M5
	lZBbHSLJrsNtFxJu0bkCFvqe178qGm9XqKDVldqPXn1b+P63yffqLTdmqoyPy8E2GqmEctTW3vaqp
	HCgNogYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyANL-007UVA-36;
	Wed, 01 Nov 2023 12:31:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyA9N-007P2n-0L
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 12:16:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698841003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5UIfMBVdGIbdKNzRDMLvhiScyxGbvuh4NifZMx02eQ=;
	b=aZ5mEXzxW8/GXvcWV22XW6XEVVcUUYsiJy2VvSbnZE/m0hrDOahBJhGV8GLDIetUFI1vLy
	nD1tOHm1m5vekifavTUGz37hyayt5LE0nTFZyJ07ITCchI01okVR9jJJd0tim1tsZv7CN0
	xEacZrM0LPOEctKBBIDvzET2qIOjmbs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-rsj5tSE7PqiyMazlfvH37A-1; Wed,
 01 Nov 2023 08:16:40 -0400
X-MC-Unique: rsj5tSE7PqiyMazlfvH37A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C7E02803022;
	Wed,  1 Nov 2023 12:16:38 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA5C11121309;
	Wed,  1 Nov 2023 12:16:37 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D85C230C2A86; Wed,  1 Nov 2023 12:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id D3EFE3FB77;
	Wed,  1 Nov 2023 13:16:37 +0100 (CET)
Date: Wed, 1 Nov 2023 13:16:37 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Hannes Reinecke <hare@suse.de>
cc: Ming Lei <tom.leiming@gmail.com>, 
    =?ISO-8859-15?Q?Marek_Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>, 
    Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
    stable@vger.kernel.org, regressions@lists.linux.dev, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-mm@kvack.org, linux-block@vger.kernel.org, 
    linux-nvme@lists.infradead.org, ming.lei@redhat.com
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
In-Reply-To: <ab02413f-4bf2-4d92-baf7-62fbd106f5df@suse.de>
Message-ID: <fd2e3ba-d681-4856-3d50-9f63a2fcb0a8@redhat.com>
References: <ZT+wDLwCBRB1O+vB@mail-itl> <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com> <20231030155603.k3kejytq2e4vnp7z@quack3> <ZT/e/EaBIkJEgevQ@mail-itl> <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com> <ZUB5HFeK3eHeI8UH@mail-itl> <20231031140136.25bio5wajc5pmdtl@quack3>
 <ZUEgWA5P8MFbyeBN@mail-itl> <CACVXFVOEWDyzasS7DWDvLOhC3Hr6qOn5ks3HLX+fbRYCxYv26w@mail.gmail.com> <ZUG0gcRhUlFm57qN@mail-itl> <ZUHE52SznRaZQxnG@fedora> <ab02413f-4bf2-4d92-baf7-62fbd106f5df@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_051645_220430_7837C83D 
X-CRM114-Status: GOOD (  11.89  )
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



On Wed, 1 Nov 2023, Hannes Reinecke wrote:

> And that is something I've been wondering (for quite some time now):
> What _is_ the appropriate error handling for -ENOMEM?
> At this time, we assume it to be a retryable error and re-run the queue
> in the hope that things will sort itself out.
> But if they don't we're stuck.
> Can we somehow figure out if we make progress during submission, and (at
> least) issue a warning once we detect a stall?

The appropriate way is to use mempools. mempool_alloc (with 
__GFP_DIRECT_RECLAIM) can't ever fail.

But some kernel code does GFP_NOIO allocations in the I/O path and the 
authors hope that they get away with it.

Mikulas


