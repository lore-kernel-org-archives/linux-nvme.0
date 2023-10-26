Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C59AC25B67
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPmQecDXHzcTOT8HCq8cWu7IAndzVIEptXImht37IBg=; b=WTgUOUiAtVlMM+D4d3WXMb44fU
	jgkuBNrXYSouqbhj4KQGLFJQECB/ULTH6jEdpxFDJrTak2V0h74oZl3RG3mjIKYav6K01TgjCWCvR
	GTgNuFMEby/ZXAjUOMaVhwciOqBg3CY4Cf6llXpsbdEmHh8ST4d2OM6WkWPipX10jwk5cx599j5Gz
	sxUotyoINtnmaS+Nm2DPkosIXQuPseyoExN8ZjtxLNA761Rv3TjCHw0tCtMsyoGG7PQZ3N4Grv7iu
	BJshrC1HAEH6lNGrTZa7DYXfmeFEhUws6r72oUdcevHX24y1DO7l7yKhfuFuWsVdQO55kVKcLQlao
	/y43fmYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0zf-00EcnF-1Y;
	Thu, 26 Oct 2023 14:05:51 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0zb-00EcmD-38
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 14:05:49 +0000
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 75961735;
	Thu, 26 Oct 2023 14:05:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 75961735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1698329142; bh=gPmQecDXHzcTOT8HCq8cWu7IAndzVIEptXImht37IBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AxBCAlBVV6EODx3CFle7qOQD/elpu7cIUDePeE+yVaFagigLU4B5UzzHyEyp7UKHk
	 9rgPP2dDRchzlakozXZj+ZsSYvJUt/vOlgt+7tjAGgRv8vn6VH4v6k2IrKIpZnMCsa
	 BOoWSKbA7fac3vEqgbAZ5R37QGD37HyDjyWxPij5+YmKql8bFHA/9fiNAOaiRHzHDX
	 ZK9zPkcu8lEtDtBJcsq3fJzwYQBdwhwXBsqpP+8SaLg8/NPUHja9e5L53qN/k/GNoa
	 x7kwWbxCpWolRxjp4pxeISdD6LNzccPsZoS89NCHMiE4AyDB1VLlOeGFVXQ7Oo/719
	 Om8BGKuIUBNIw==
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>, James Bottomley
 <James.Bottomley@HansenPartnership.com>
Cc: Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
 Justin Stitt <justinstitt@google.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
In-Reply-To: <20231026095235.760f5546@gandalf.local.home>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
 <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
 <20231026095235.760f5546@gandalf.local.home>
Date: Thu, 26 Oct 2023 08:05:41 -0600
Message-ID: <874jid8one.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_070548_008461_C3374822 
X-CRM114-Status: GOOD (  11.72  )
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

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 26 Oct 2023 07:39:44 -0400
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>
>> While it's nice in theory to have everything documented, it's not much
>> use if no one can actually find the information ...
>
> Does kerneldoc provide an automated index?

If you go to https://www.kernel.org/doc/html/latest/ and type a symbol
into the search box on the left, you'll get directed to the right place
(if it exists).  For James's system_state example, it makes it clear
that there's only one reference - in the coding-style document, of all
places...

I've never looked into that index to see how hard it would be to access
without a browser.

jon

