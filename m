Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C7BC5478C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZzVY1rE4nuBeeTGJE+eDzU+/KFUPmhj+EbPbIqSZ4c=; b=O1V+CPmAUKSfeTjPKHCz+Mq1Vw
	9Dg+C7zpD7aqpQXU5vnfrnOqZ2O/MKVCXjg3pRrcT9b/ebf2ogA3DhlBuEtVVD6sCixNPk0pKeqV9
	AQ30tS6mt+h0dmb+/Xd0dfORDBygb+3Yy9LJdcxlCXmCz7dcy3f9sxGEzXnbCD5dXoJNEFf3xCtGO
	xwRcTVCLaY9jwvRtFEHjKYvHvrv/GUhbkVk2X6aKlsQxqbjb0Ip+FRwEnqYXSefVyStBemcf5rWep
	X6KjOYIVfL/PGoD0o4itSN3dueGnj/I1KEIrmyn0erCNCo9OTakVDs3XO5aeMEX9gf9U1BLlK0oeB
	kt07Oz0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdYdl-0000000AISJ-0Pva;
	Fri, 23 Feb 2024 16:43:13 +0000
Received: from mout-p-201.mailbox.org ([2001:67c:2050:0:465::201])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdYce-0000000AIHe-47Hu
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 16:42:26 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ThG4Y4khgz9srX;
	Fri, 23 Feb 2024 17:41:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708706509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZzVY1rE4nuBeeTGJE+eDzU+/KFUPmhj+EbPbIqSZ4c=;
	b=e8+lqrCeUGLoeWHdMU2NT7TaFTqF+HMvYcUIDjJsltURgi0xQ/bx7qGFNQsEJYhQHMZsNe
	nMoOe/X4Lct1Kp4ZiNdvtgX///gTTodyn0euqKyxAR7nCtXXLqUkxJ4S6LcCfYb5MPWsbE
	Rhgy7btRp3nuFVbDEv4hzdAXPkCO/cP1DErzN/0zPuDj1jQMe2i570+hF9/d34b6dBh1tH
	yNSN17DLBKPXBt9MtVGwcWkbRDh8qYbWXR5/lkabo3HBYOUrAbkaXGgi6calsgTdR9vUW1
	y4NXoSKSDxK0oZOw1bVwbG+TOCepPI0Xw5TwgT8KYbcGt0kuAYfnQojkef5EPg==
Date: Fri, 23 Feb 2024 17:41:46 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, mcgrof@kernel.org, p.raghav@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <43yvte5buxg4jv7nlguiz5eu5l26lkzz6cpa4snnvjqokbyg7i@42s52upzhrdi>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
X-Rspamd-Queue-Id: 4ThG4Y4khgz9srX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_084217_342253_4CC2BD5B 
X-CRM114-Status: GOOD (  17.33  )
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

On Wed, Dec 20, 2023 at 04:03:43PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> I would like to discuss
> 
> Large blocks for I/O
> 
> Since the presentation last year there has been quite some developments
> and improvements in some areas, but at the same time a lack of progress
> in other areas.
> In this presentation/discussion I would like to highlight the current
> state of affairs, existing pain points, and future directions of
> development.
> It might be an idea to co-locate it with the MM folks as we do have
> quite some overlap with page-cache improvements and hugepage handling.

I am interested in attending this session. As we are getting closer to
having LBS in XFS[1], we could then have the LBS support for block
devices for free if we use the iomap to interact with the block cache 
(!CONFIG_BUFFER_HEAD).

So one of the focus points for this discussion could be on adding the LBS
support to the buffer_head path for block devices and blockers (if any).

Another important discussion point is testing. xfstests helped iron out
bugs in page cache and iomap while adding the LBS support for XFS. If we
add support to buffer_heads, then how are we going to stress test the changes?
I doubt just blktests would be enough to test the changes in page cache
and buffer_heads.

[1] https://lore.kernel.org/linux-xfs/20240213093713.1753368-1-kernel@pankajraghav.com/

--
Pankaj

