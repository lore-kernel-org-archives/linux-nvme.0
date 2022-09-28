Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940C1C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ia4ZSrrQtLIdMz5ybT5O1T3411H4IKHJVybLh9Azdk4=; b=ffrPPdl/yZY/+M1dpcV67PCsAr
	nUxiqlItju4f00VjOURSpMDhINsOIbg84hpQn16WkwKW1T2B1wnZm4BpLCUvY3C0Tv1P9/jmVEo5q
	KGoO1TYh+ctNlgvD6Try+WNYYz/98D7nu72p7VJR3X/eMaFxWUAe74vKbCmakaEfWZmYzTULM9lWO
	1eG8KGo9avYbV7+de6bO6Z1BfGPYb1oMGxOsAo3gF6QAXy9ViPXcD8jnc9b14ClGij0Z4+CHAkcO0
	88vfN+kMwbOHJZA9c3+RvSf+iVeA3CTEQbe5SnzbCeMe0wCnD9APR/7jkI3PhkCSfd076mGWQ29/O
	NQ+5a9RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaSG-00HFr0-R5; Wed, 28 Sep 2022 17:02:40 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaSE-00HFpj-4h
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:02:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAD4221CCE;
	Wed, 28 Sep 2022 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664384553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ia4ZSrrQtLIdMz5ybT5O1T3411H4IKHJVybLh9Azdk4=;
	b=ntH7wUcGf1OeQTpmHNi/DVHEUt0wklthhvbxFe+kjsd3F3ceNBbxfsVwdc2oBYPWmxHtIX
	rwfAq4JmpetJXLhkvRao3I3VQTeWJ0X4IFLlntxgqPR3WkkDaIx4F9xHXqGK6whqUB2ZNm
	33wiJiqxCFMmLNLYbxIMTHcml3cKsDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664384553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ia4ZSrrQtLIdMz5ybT5O1T3411H4IKHJVybLh9Azdk4=;
	b=vAPecD62W+kW9GFcaaoiFAUtror7AYJWsqldcY+yGBn01UoGrfe8CxveS1fatm9Tdj0uVj
	Esqu2wf5il1erbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC66C13A84;
	Wed, 28 Sep 2022 17:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BjvyLSl+NGNaNwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Sep 2022 17:02:33 +0000
Date: Wed, 28 Sep 2022 19:02:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Yogev Cohen <yogev@lightbitslabs.com>
Subject: Re: [PATCH] nvme-multipath: fix possible hang in live ns resize with
 ANA access
Message-ID: <20220928170233.x4s5lc6qb3s4n43k@carbon.lan>
References: <20220928135816.132213-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928135816.132213-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_100238_348475_B25C1E86 
X-CRM114-Status: GOOD (  18.42  )
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

On Wed, Sep 28, 2022 at 04:58:16PM +0300, Sagi Grimberg wrote:
> When we revalidate paths as part of ns size change (as of commit e7d65803e2bb),
> it is possible that during the path revalidation, the only paths that is IO
> capable (i.e. optimized/non-optimized) are the ones that ns resize was not yet
> informed to the host, which will cause inflight requests to be requeued (as we
> have available paths but none are IO capable). These requests on the requeue
> list are waiting for someone to resubmit them at some point.
> 
> The IO capable paths will eventually notify the ns resize change to the
> host, but there is nothing that will kick the requeue list to resubmit the
> queued requests.
> 
> Fix this by always kicking the requeue list, and if no IO capable path exists,
> these requests will be queued again.
> 
> A typical log that indicates that IOs are requeued:
> --
> nvme nvme1: creating 4 I/O queues.
> nvme nvme1: new ctrl: "testnqn1"
> nvme nvme2: creating 4 I/O queues.
> nvme nvme2: mapped 4/0/0 default/read/poll queues.
> nvme nvme2: new ctrl: NQN "testnqn1", addr 127.0.0.1:8009
> nvme nvme1: rescanning namespaces.
> nvme1n1: detected capacity change from 2097152 to 4194304
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> nvme nvme2: rescanning namespaces.
> --
> 
> Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
> Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

