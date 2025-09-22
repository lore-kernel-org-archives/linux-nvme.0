Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A949CA100F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iSsu8SdjKa34eNAQRnJyMvwZPeN2tUvZSqDEmcgsdug=; b=GNKXp8aAjVCmMx1mx7XiktVuvd
	f532pUWuDTkSILFZ/l7I0eWXTTfGA7pP3PyA/66WWKzFC5OJMZsjndtN2nX2nVyb63Gx7BqY69Bsc
	u0WQgskSP3qGR92vaDVva8jeVAHQzDRjADiG68IdHAk9TjmpfQTRgofHe3/VoKpNEnhnQ6F7YBLXk
	OG0UFENd6eFJuwQaMQ7r7F1n5K+fOvSIQlVhzm8YYZrhvxYSS0IrBuR+MVZ+UATvnNBGzQPVNmSUa
	sQZUb54T5KKH6jlv+8lthQNzNBsj4VZnRHzsQDPeMAS2avgDocMLSNBLJGTKVWSNjXKWynnWFjcG1
	J44SI1SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kNA-0000000B872-3PG5;
	Mon, 22 Sep 2025 17:30:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kN8-0000000B866-1OMN
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:30:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08447227AAF; Mon, 22 Sep 2025 19:30:34 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:30:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, hare@suse.de,
	mlombard@bsdbackstore.eu, linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC 1/1] nvme-core: register namespaces in order during
 async scan
Message-ID: <20250922173033.GA13802@lst.de>
References: <20250804114355.30212-1-mlombard@redhat.com> <20250804114355.30212-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804114355.30212-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_103042_515145_3BC8DA1B 
X-CRM114-Status: GOOD (  10.37  )
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

This idea looks fine to me, but I hate duplicating the logic
from SCSI here.  Any chance you could try to factor the logic
into a common helper?


> +	struct async_scan_task *task = kzalloc(sizeof(*task), GFP_KERNEL);
> +	if (!task)

Always keep an empty line after function declarations.


