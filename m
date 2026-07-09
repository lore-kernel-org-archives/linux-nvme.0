Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE34AC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wRcj18O/ejQs3n7adhVLpF0E4qu2VdMnY3SUaitDxTM=; b=n7tBk88XPqYds36VBqBAc6PmE3
	8EEzukiVp61bAgR4ZFC4+UJ8hpccXmnPNE4QDqaRt6MpWZbsfYPOR1jFMJSQBEhr6qB3WAUqVyYxJ
	CcORW3nqIadEh3DUw7wiSN/E3kTCIR5PjaJNh7DQcAFiSA4xIRTyyZ7O2QlyhaYTuqTBsbtuhSTrr
	w19sTxJyWQF2r1cPk+ztIvV1DEDF/VYL7vFf210NuTYvwSQUgJUpA8fTWnw2IDRAAEefbL6VesmAk
	XtqEbG27dds7y876xpsveEI7fraduiWRvSTJxRbbIup4AVosZjcouCSyBU9w6jAlbYA7t6lblLXaN
	TKdHQWDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiHq-00000001AeX-3aMl;
	Thu, 09 Jul 2026 06:31:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiHo-00000001Adc-2DXm
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:31:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE1F268BFE; Thu,  9 Jul 2026 08:31:01 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:31:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 10/18] nvme: add context annotations for
 nvme_subsystems_lock
Message-ID: <20260709063101.GD18056@lst.de>
References: <20260706141452.3008233-1-nilay@linux.ibm.com> <20260706141452.3008233-11-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706141452.3008233-11-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_233104_715269_30404E85 
X-CRM114-Status: UNSURE (   9.64  )
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

On Mon, Jul 06, 2026 at 07:44:12PM +0530, Nilay Shroff wrote:
> +	/* Initialize unpublished lock-guarded variables. */
> +	context_unsafe(
> +		INIT_LIST_HEAD(&subsys->ctrls);
> +		INIT_LIST_HEAD(&subsys->nsheads);
> +	);

This is still making a mess for no good reason :(


