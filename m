Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C45ECDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBn68FHTYI28xBlwqzgXlF7SWv6Pv1eAGT/Ojgy/yFI=; b=RSmerukWf0FP46TVghuc+dilQ+
	/sSwJVifLGGFi9uLwcZ/HSpxx/c9yUv8vTA2x86G/Z3LSiTxE725EFj7JTx1B646snMcTkhVD6ZWn
	VVz+wdakgM2mmJyGXX8wAHQATBTbrnQ4+3OrmvGTEeqwyKKXQJLHPchi9rlzpJJgTLWAY3SxL2swy
	eONDi7nqsWmf4mPgQgQ4rh0h7n3kxADMt4dJxaI1i/p6DrVI9S2NaNQ5V1DpEJm9vtdKvVlwsXBHc
	d40klnTd3Y2QOV8FvY1Q2URgHQUXdl5Q1PpYko3T2vMOmTxiZ25HXKX6ve1zhU2c6KvD16WH5yeg7
	4DeMFppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsUFN-00AV4p-26;
	Mon, 16 Oct 2023 20:31:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsUFK-00AV4H-36
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 20:31:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0D9B5CE1750;
	Mon, 16 Oct 2023 20:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAEEC433C8;
	Mon, 16 Oct 2023 20:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697488284;
	bh=glJNuSY9nGZfmboKHAiUsm1oetWvUSIAEGzimvpHmlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+AOEMrd1d7KHqh3wMfqW11wSgrHUbYGj8+8NWEkPVp0CwK63vBciBViFwRG80rKs
	 wutE8FOE3NTH5LmIvEA5dDNFBjuCo91QFlfU5PJIaVR7n49UELonWDrhLlWS9fEx9T
	 D0I8LqXViPMKdK3eX/kJZSarWlugO60jvXfgHkf4vofMsmlJ3DSQBYzLpBakGhUciR
	 I6q/3LUf84YoxwnTC6mvla8ls82DKp+Mm4mHHTlUiDeDV9G5bGa13AnxjMq3WzVp20
	 nonB7TQShGhSeiZvF7j+NYdY6X+Wupq7Wdx2PP4twFRq7L88vjCOa+YFOpHNdKMlH7
	 jTHM2mWXmsckA==
Date: Mon, 16 Oct 2023 14:31:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: sanitize metadata bounce buffer for reads
Message-ID: <ZS2dmakCEln97UNi@kbusch-mbp.dhcp.thefacebook.com>
References: <20231016202124.2957213-1-kbusch@meta.com>
 <90fd6d9e-5bcf-40d8-b85b-9d33c91406b6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90fd6d9e-5bcf-40d8-b85b-9d33c91406b6@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_133127_192178_7534337E 
X-CRM114-Status: UNSURE (   8.34  )
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

On Mon, Oct 16, 2023 at 02:25:11PM -0600, Jens Axboe wrote:
> On 10/16/23 2:21 PM, Keith Busch wrote:
> >  	if ((req_op(req) == REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, len))
> >  		goto out_free_meta;
> > +	else
> > +		memset(buf, 0, len);
> 
> Do you need this else?

The 'if' condition just above copies user data into the 'buf', so yes,
we need the else to separate how buf is initialized for each direction.

