Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA8CC3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 20:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XdJZfrg6g97HSc/RwOoOLLVG1jP9Ixy6aCxlYes/dW0=; b=ItDLIOZhMdiLDmeyy66NdDO40i
	NlPYW7Tc7pIQ//J6LzRWX9Vsl1rYPv+bPP5O8/HTgRwkhOCZVRDz+Wcp+67i+QWJizVd9k0EJ0kGq
	0KUvTqZ7bTE8vOwZnUToKioVgZUUwv8EpkzGyej6jTOkQLCT0MQ5vypSTP7MgT7UgJYSpFgRcQdjI
	zIc47ALVY0JBNU/erEkrBjpd4rLsBpBpTeTXG1gGt71+aTp2b6DwwXUhSkCHj6VxAtCrZA/DWnna+
	367wMzWt+9IL/p/bSaHCp2wD1zkIHmnbnoG63UTeyBKdsKHdhAM2hv0XWQeQTGMSFI+Y6pWJh9Bqx
	2rC5ZtIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scWJu-0000000CWde-21n1;
	Fri, 09 Aug 2024 20:34:42 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scWJq-0000000CWcz-48fH
	for linux-nvme@lists.infradead.org;
	Fri, 09 Aug 2024 20:34:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1F376CE1381;
	Fri,  9 Aug 2024 20:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B29AC32782;
	Fri,  9 Aug 2024 20:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723235674;
	bh=RBfEm9wmc26AmCzjLP11zlf1txKlmVbH6yTJNEJLmgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pz8lrPf2l+ZEM0AgU5Tz0J+IgLzsq95BtbJ157XmpWSQsrcE3eG6KZLtUsfsc/rTr
	 kYpphwNxHsKyP4nfdWuDmpy/oGjeSEZQjByBLdGtT3/vj9gq2OOPdtX9JXypwkmpnY
	 58CNdo0kZAZ/sKRb+WGFj/KdvpjvskvEhYOUUXgT3I6zi31p3ir5I4hSD+oOIMSQam
	 7Bc0g7BBMjeWhJODPPQYQAbOMlXx16OfdVVNh9GJVjO/2KpGZkn+JZoIs4spGRkyjm
	 BppeQS7V9zEmuQDEAA4dFw3mQOF55WZCirm7OisSkgC1GNJRyzkqonrwSqCaJDfv6I
	 OidGD88cxgDSA==
Date: Fri, 9 Aug 2024 13:34:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [RFC PATCH v2 0/1] Add visibility for native NVMe multipath
 using sysfs
Message-ID: <ZrZ9WKimhqSJXGnn@kbusch-mbp>
References: <20240809173030.2281021-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809173030.2281021-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_133439_220054_CCC1607F 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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

On Fri, Aug 09, 2024 at 10:59:56PM +0530, Nilay Shroff wrote:
> # cat /sys/block/nvme0n1/multipath/queue_depth 
> nvme0c0n1 423
> nvme0c3n1 425

I am not sure this matches up to the desire for 1 value per file. What I
thought we wanted was a directory for each path, so it'd look something
like:

 /sys/block/nvme0n1/multipatch/nvme0c0n1/
 /sys/block/nvme0n1/multipatch/nvme0c3n1/

And each directory has their attributes so they print exactly one value
instead of the multi-line output. You'd know which path the output
corresponds to from the file's directory.

