Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418A606A328
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jyv558J6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Vq93N/5Fq7H6xKbEkagvllKvnuvaRbqOr62To/Bh3PQ=; b=jyv558J6+wfYq4oz2gMIBiqKBt
	dGl878SMIdDB4hndmPTxZ1GS/msNE3ZnYPVL/sRu4K0cTacKhiERnT0N6pVPeykBSg5LxJHyeo5v3
	c8yzStf971eoahmz894X1ClbofNYjXCXvwKV9HFaIySi3/LkLxqs9CeXyIGd4BXeQM3BRA8irAJeP
	/pB3SRtOKrIyZWqKK3FbcKfFgn53ZDsm85U4Bj8KjYgZKsa6A84RU2/xuRPvYR5NeHWT6gm7AIqWy
	XXrRDGX0BUxmN+WF4LfrpIgHQaUXf8LkrZ6FZLllMRQ5Fn2StZfJ3SwN2Y22dnAwdR84H5CdNnxel
	8UX3LMLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOWrv-00000004ogD-3rR4;
	Wed, 04 Nov 2026 09:01:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOWrt-00000004ofQ-02nP
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 09:01:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2D8968BEB; Wed,  4 Nov 2026 10:01:11 +0100 (CET)
Date: Wed, 4 Nov 2026 10:01:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christoph Hellwig <hch@lst.de>,
	Robson Cassiano <linux@robsoncassiano.software>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Alexey.Bogoslavsky@sandisk.com
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for
 WD SN740
Message-ID: <20261104090111.GA30750@lst.de>
References: <WnzOhxjlW7w5jwpSIQmUzrvduOStpoX2h3FS@robsoncassiano.software> <20261103075845.GB3882@lst.de> <b0824cb9-e678-4bb3-934d-a1743b164ca8@roeck-us.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0824cb9-e678-4bb3-934d-a1743b164ca8@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_010117_203913_3E906E4C 
X-CRM114-Status: GOOD (  19.17  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 05:31:29AM -0800, Guenter Roeck wrote:
>>> Mark the controller with NVME_QUIRK_NO_SECONDARY_TEMP_THRESH so only
>>> the sensor inputs are exposed.
>>
>> Given that this is an older device I suspect we're not going to
>> see firmware fixes for it.  But given that we had quite a few devices
>> with issues like this, I wonder why nvme-hwmon can't detect these
>> obviously fake values instead and we could drop the quirk?
>>
>
> Question is if the quirk is really needed. Personally I doubt it.
> Normally the thresholds are simply not set. I see that with the NVMEs
> on my system (Samsung SSD 990 PRO) as well. If I set min and max
> values, they are stored and subsequently displayed correctly.
> That means, no, the hwmon driver can _not_ detect if those values
> are fake because it can not distinguish "not set" from "not really
> supported".
>
> I have not seen the patch, but I strongly suspect that it fixes
> a non-issue, unless it can be shown that writing the values has no
> effect.

So should we drop NVME_QUIRK_NO_SECONDARY_TEMP_THRESH entirely?

Robson: what kind of adverse effects do you see without the quirk?


