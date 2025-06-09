Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ECBC61CE8
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LTOO+ykzs3i46FrydtkJyj4Q7gGo0Ib8nnYqxvNaO0=; b=sRJEqZJqc5kfwj8NAqRRR5YHiW
	9gSyQKIuyeqDBQ8+eq+xUv2v8nFLxjsespxFkUIKXNCZw17quaFIUKs4+ebrDyhmGpXFtca29M9xS
	JWqlertAnq35i0dWX5O8Z2Y/xTUun9RaoUslP9DCU7TTK2HG2N60MT49sldAql6C3AXJPbrT9DUMf
	Cc3yEU0tp8W5yoE5oqo27MraYuVOGC2/JpVJZPeFG0/LX82UFep8oAX64GVfCzprtr4N2J/LNJn+0
	tt2Ezyp2O05fFmCcB/GCvCp4IgkrnzVZigmYAMjAasvcavNsyTb/JJwiiEF9781ZsRSbD2ZPh04+R
	+AcOx7HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOZ1e-00000003oHa-2GVI;
	Mon, 09 Jun 2025 09:42:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOYou-00000003mei-1wDI
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 09:29:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A07361156;
	Mon,  9 Jun 2025 09:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4007CC4CEEB;
	Mon,  9 Jun 2025 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749461371;
	bh=x/EnJWl/k0jsWW6PMMleDnU0RrJaBN65jDQeKCebf9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcCM6Xef1yXTIWZcPmZjtcgsQzFN2XcKqh4ZFgV/ssN08Df0aKJHSfW//3gGknsq4
	 WAAVwhOUqvFQIwxv3rTywGa505tQWx/zpxsFsZzwo9mD6MGKmnby8DbAQlAXmp9Xg6
	 eFXBxwvw6SfZbk/imnjKFjU5HvxLFkcz26baZpWESbsVhgp7wWWAlyj0/HDaCxSdPh
	 AP3oJSH6CU+mTNrtuzcW+tVnuvFC9V8xLGQVhaml2twXc4LLF4iioOMA4i8TBgTU/X
	 NYSq+NV8ws968V9Peb1nASUuJTkJJrWdIqfwfXLb0+9A8RgPkWWgcWgpx6j4vSJWvz
	 +qSltiFz1+BLw==
Date: Mon, 9 Jun 2025 11:29:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aEapdy-c6G35Q-vx@ryzen>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-4-kbusch@meta.com>
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

Hello Keith,

On Wed, May 21, 2025 at 03:31:05PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Register the nvme namespace copy capablities with the request_queue
> limits and implement support for the REQ_OP_COPY operation.

Since you never initialize Descriptor Format (DESFMT), you will use
Descriptor Format 0 (No SNSID, 16b Guard PI).

That is understandable, since your block layer API intentionally does not
support cross-device copies. But I would have expected you to somehow
mention the descriptor type format used somewhere in the commit message and
somewhere in the code (as a comment).


I haven't followed all the work that has happened wrt. PI in the block
layer recently, so I don't know, but I can see that nvme_set_app_tag()
can set a app tag in the request itself, and that nvme_set_ref_tag()
supports both 16b Guard PI and 64b Guard PI.

Do we ever want to set the ELBT/ELBAT/ELBATM in the nvme_copy_range struct?
And if the namespace is using 64b Guard PI, do we want to use Descriptor
Format 1 (No SNSID, 32b/64b Guard PI) rather than Descriptor Format 0 ?


Kind regards,
Niklas

