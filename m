Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAA1C61CE8
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=otP9rwJqGGqQhuHhnf1Q25W2bhl/dvC8+fqajR3jN0c=; b=DELX7Og4POO9sOnh4Q+bUhcGJY
	41i+mlaSVo8eCI0cEmiHp9jbcadQ30eiQA6kBj54FI4wJB0UXoT2nYRXqDpG3emSTkZkdzW9PUNkG
	AhJ3c+UDp9Huhz9iQhe40I9ulb2KoJCfVCq2bF9EqaIhFsmp7B+e1rLAwrKq5SLwEf2zvRBOmQZYt
	wdZJwO5hN30SIBRddZI2vu6FkfLUNkoE7VTtpxd1QV3sSqnsvHAwK0/vG2e5XjJKnRFBPhVrEZLe0
	/TxPJP5j9dt4zJzN6j8a9DZp4D7YW6+Q7ANqgzaVU+yHmqu8I+SQG9IPHvZTgPuiYPz3zdXzybQLL
	MhjS4rCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOesv-00000004aom-3cBs;
	Mon, 09 Jun 2025 15:58:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOeMC-00000004Vvg-0vbC
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 15:24:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 42EE04A458;
	Mon,  9 Jun 2025 15:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99A6C4CEEB;
	Mon,  9 Jun 2025 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482654;
	bh=9d9nuPgWbDuYdWcXLpKn18o7nThv9hi/O2xpuvdHIO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kehUJkRFfgr9aSbKBSahKsINjIvFNImaabRF+SuqTLDrBqESBJZ9yV2Sk8ntQO9wG
	 9oaNnQeK/dkD2MM413ckX0RkeaLLRkxCVMPCHYd4dFPYkYpve2QOArq7ZGpZsY5Z+e
	 XGez6vQ12OMuHAYYsqwDRBFEmCowotylYnVIU9jaVi8IJUUPljsM67yf3426x2rVXZ
	 oTky2UQAXLY1/c7IZCorKvoGNI4B0Nbm9STkUf9T7vKefyYtvIiigB/owi8hV6Vcsw
	 GYOvh4277mhGp07wYJSIBlzZcoHvv7HgJ/HgPDsyHiSUoTzhQp8xM5ffkeVuqGijFZ
	 ztKucF93MYqww==
Date: Mon, 9 Jun 2025 09:24:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
	axboe@kernel.dk
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
Message-ID: <aEb8nNl73MFNd1Lu@kbusch-mbp>
References: <20250606003015.3203624-1-kbusch@meta.com>
 <CACzX3AtTwR3dWpYw_jwWKTZziz251cb7xobgF2ta5WL6Kr2uBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzX3AtTwR3dWpYw_jwWKTZziz251cb7xobgF2ta5WL6Kr2uBQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_082416_282936_70237B0A 
X-CRM114-Status: UNSURE (   9.40  )
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

On Fri, Jun 06, 2025 at 07:11:20AM +0530, Anuj gupta wrote:
> Minor nit: should use `.nsid = nsid` instead of hardcoded `1`
> 
> > +       /* This should not be mappable for write commands */
> 
> Maybe reword this to:
> /* This buffer is read-only, so using it for write passthrough should fail */
> -- makes the intent clearer.

Err, I actually got this backwards. PROT_READ means we can write to the
disk from that memory, but we can't read from the disk into it.

