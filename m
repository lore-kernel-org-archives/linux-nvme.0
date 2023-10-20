Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AE5C001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 04:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nKur3i6JgyLSH1tfcJATwzEzft276RmoLHM/DIvByJ8=; b=tHuRpd989ozS0CkRXxl/ij3HQ1
	kNMQCRUH0dxaPtIfMFzP8pcjj93GRYdkLY7psTCLeNjHHlSEVNbKh9RkmE1BTdBw77acHtGzub4KO
	SUFgITQaNs2iP6sbvSqnRiravDlOSSpJO8fodIT08xvxbUA74o5rR3gbHK7P72GAnnkHfrJiq2H1/
	lfGdKcbJ8QxzMb1h0QlvH4vVxAY4OviLMVHgocfii6C0D0pXeCjfUCz5mvlbuP2gIKXX1IlIxjhnz
	JDmc+sdEvEo7xWda73pk+s5q69OzPIbXwvpvj+zzwGXKxrKMOa424AIh/DIeIpZqNzSO/zmrFjt1P
	YfgFaSjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qthPT-001D1w-1q;
	Fri, 20 Oct 2023 04:46:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qthPQ-001D1V-27
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 04:46:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DEE867373; Fri, 20 Oct 2023 06:46:46 +0200 (CEST)
Date: Fri, 20 Oct 2023 06:46:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <20231020044645.GC11984@lst.de>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com> <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310182248.9E197FFD5@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_214652_846798_A11655DC 
X-CRM114-Status: GOOD (  13.56  )
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

On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> Almost all of the remaining strncpy() usage is just string to string
> copying, but the corner cases that are being spun out that aren't
> strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
> and memcpy(). Each of these are a clear improvement since they remove
> the ambiguity of the intended behavior. Using seq_buf ends up being way
> more overhead than is needed.

I'm really not sure strscpy is much of an improvement.  In this particular
case in most other places we simply use a snprintf for nqns, which seems
useful here to if we don't want the full buf.

But switching to a completely undocumented helper like strscpy seems not
useful at all.

