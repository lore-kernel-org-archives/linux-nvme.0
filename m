Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC569C25B67
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5LHVEqOcn8c53j+ptT/EDHYxEWMY0Vwte6Z0gu2I1XU=; b=b16+zcmEDFppMWcAyXoaiT9SGb
	F5QsA5mT+p7Tx3+Y+NEMuZZeRJI5IKT3UcF0GFEorxLZ06TSlB2A7iHRVnuDwszT03zIw/WJ+BkbZ
	7pxZN4FHs30uJTEHK1PcOnd1lX4UcwVQ2RNbOwgMOKZgbkBKm+vdNQ7yTBQ/b5dw0IRSZ1Xvb4/om
	U3j8iq6BrDWclr3DsMfoHN4li8pT1eOz360FvtCBpnoApzJWK8ynsete24+5FCMvqk9SGAKQCMXGQ
	XFmxsJ2+hR+7VgAWuZhahq9uvJhiwPXH9z2AAyCbglT9xPeizBzYRlZ8XHupgzHmzUc9sb2i+2Itl
	DKj2uduQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0mw-00Each-0e;
	Thu, 26 Oct 2023 13:52:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0mt-00EacI-0p
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 13:52:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6D2FA63498;
	Thu, 26 Oct 2023 13:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9D6C433C7;
	Thu, 26 Oct 2023 13:52:36 +0000 (UTC)
Date: Thu, 26 Oct 2023 09:52:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
 Justin Stitt <justinstitt@google.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <20231026095235.760f5546@gandalf.local.home>
In-Reply-To: <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
	<20231019054642.GF14346@lst.de>
	<202310182248.9E197FFD5@keescook>
	<20231020044645.GC11984@lst.de>
	<CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
	<202310201127.DA7EDAFE4D@keescook>
	<20231026100148.GA26941@lst.de>
	<710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_065239_336167_3E4F85A2 
X-CRM114-Status: GOOD (  12.02  )
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

On Thu, 26 Oct 2023 07:39:44 -0400
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> While it's nice in theory to have everything documented, it's not much
> use if no one can actually find the information ...

Does kerneldoc provide an automated index? That is, if we had a single file
that had every function in the kernel that is documented, with the path to
the file that documents it, it would make finding documentation much
simpler.

Maybe it already does? Which would mean we need a way to find the index too!

-- Steve

