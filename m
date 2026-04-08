Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2324710F994F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9eIase9MrbCDpbX2Fno+abJ9znIIpiE2HpS5zpMgQP4=; b=mUSlUY2mV33FcSfv3UJKXLGqDx
	D1UUOHTJBGjS5qp4gibDFYdQhm/1Yeiq2P8/UDo9hFUEQn5Xp/adJh2QcZCq+YNWAvoQZ3yfH8nyf
	2U4nEOYqeahwQ+P54QSFADsnFgPrj+7NPcqg9SJuF60Pyj2VJYSGLpK0Or8FhL1ClhYiDXcZLxiw9
	bLH4AtFy/x8L8TcAba4dWUy47Rp1/LVn1XCK+p0eV/omA6cLd146BnLiGOHpr6okiqadHaeoHt9Ix
	a28fFUvf/BL3pIaOUeDQkNH5ocbYXqq3SNrFDUAIOXhdt77w/WAbPU5UF/AsG0mqLqsrodcez7w37
	YYqIHUFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAUaT-000000092Ka-3TEN;
	Wed, 08 Apr 2026 15:13:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAUaR-000000092KB-3pFy
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 15:13:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C4743408C4;
	Wed,  8 Apr 2026 15:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4CC19424;
	Wed,  8 Apr 2026 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775661178;
	bh=fg4ALS1hRJNXN7qhHZRPtXoxqqoOjto5zDty7ZAcsk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWxIgfKFvdxYUeNL7R0cKmas9QHcKNB+2nu3MZSJ2yDeWYynsLNbQGf8lx9uzRw2J
	 UfUo8/AgGMC7TZYCpMC7BFs42SQTcA5JSYgcWTFy8eOmnrCJQnsK06mJBB/afGrOPR
	 4urnW7k8FjZBChztsAYVg/sU+/j8Yjzj8N1u4c1dYENmh9Z6fGirnS14Up8EMx1pC0
	 yDOz08hV7218KS4VJcMLJW9pkzt0uF3tXpisT37l10+hKUEDo8MPtCg/T/R+dnto4d
	 CyFQIK6oa50FZK+hsSDdTMHR6lUvMtxTeMqAvOkC9Rl1W5YGUL8bmOzSuOvyGn4OI2
	 ATZv41sVhqpHA==
Date: Wed, 8 Apr 2026 09:12:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: add missing MODULE_ALIAS for fabrics transports
Message-ID: <adZweLxr4bzQ5ulV@kbusch-mbp>
References: <e3076c80ee2e0c4a2cae0374afb617a3365946ea.1774944415.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3076c80ee2e0c4a2cae0374afb617a3365946ea.1774944415.git.tanggeliang@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_081259_986940_AEA8C4C4 
X-CRM114-Status: UNSURE (   9.38  )
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

On Tue, Mar 31, 2026 at 04:17:31PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The generic fabrics layer uses request_module("nvme-%s", opts->transport)
> to auto-load transport modules. Currently, the nvme-tcp, nvme-rdma, and
> nvme-fc modules lack MODULE_ALIAS entries for these names, which prevents
> the kernel from automatically finding and loading them when requested.

Thanks, applied to nvme-7.1.

