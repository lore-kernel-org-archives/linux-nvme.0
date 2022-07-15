Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EEFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 00:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SC5STAxYMrLw8OuznMuUxETRPPpQbdlO5stq5P8p8NQ=; b=GjVFwVQq2jR35jdUJh5bf/DWaa
	ZLqFu1c0VT70iZjzr7yr1klpUDXO/QJBPa+Iz+iZWXXIFJabvFzTCc9fc5FpTHIVUg/77C+p7qoYR
	G9kLw8D7k4bywA5HPdc8PHn0p3FuHkRm/D5V50NCcxFn9sP+6s7Ou32csGqNhq/mLkBW3FAACea5D
	ZYBW93HL0yAIJ+q6gdsijAKCcBL5ez83egDcovXTRkmOW6X8wbx5I161c+KjsAarQ+YmchiQSeCXF
	CThQDpVHDNCnpyTyL5LgmnraOQzXmRN6Wftl9Vyj9s4J4SIe8KYOyVkeSGVfHisGLQgqWGEgES/9w
	aNbTaRrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC9b9-002uuZ-AX; Fri, 15 Jul 2022 00:54:27 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC9b7-002uuK-5W; Fri, 15 Jul 2022 00:54:25 +0000
Date: Thu, 14 Jul 2022 17:54:25 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: axboe@kernel.dk, paul@paul-moore.com, joshi.k@samsung.com,
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	a.manzanares@samsung.com, javier@javigon.com
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd
 file op
Message-ID: <YtC6wT4CYq0an/vX@bombadil.infradead.org>
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <30dee52c-80e7-f1d9-a2e2-018e7761b8ea@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30dee52c-80e7-f1d9-a2e2-018e7761b8ea@schaufler-ca.com>
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

On Wed, Jul 13, 2022 at 05:38:42PM -0700, Casey Schaufler wrote:
> On 7/13/2022 5:05 PM, Luis Chamberlain wrote:
> > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > add infrastructure for uring-cmd"), this extended the struct
> > file_operations to allow a new command which each subsystem can use
> > to enable command passthrough. Add an LSM specific for the command
> > passthrough which enables LSMs to inspect the command details.
> >
> > This was discussed long ago without no clear pointer for something
> > conclusive, so this enables LSMs to at least reject this new file
> > operation.
> 
> tl;dr - Yuck. Again.
> 
> You're passing the complexity of uring-cmd directly into each
> and every security module. SELinux, AppArmor, Smack, BPF and
> every other LSM now needs to know the gory details of everything
> that might be in any arbitrary subsystem so that it can make a
> wild guess about what to do. And I thought ioctl was hard to deal
> with.

Yes... I cannot agree anymore.

> Look at what Paul Moore did for the existing io_uring code.
> Carry that forward into your passthrough implementation.

Which one in particular? I didn't see any glaring obvious answers.

> No, I don't think that waving security away because we haven't
> proposed a fix for your flawed design is acceptable. Sure, we
> can help.

Hey if the answer was obvious it would have been implemented.

  Luis

