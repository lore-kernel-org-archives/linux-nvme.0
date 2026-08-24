Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AA7C5DF9C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=341cGJLnKlasASORCZkznBC2KO5WlGLLTxMiIq0tCfA=; b=GgEZSWaqzU08ntFSbk5HB0HAMV
	+Rj7PpynQYAM0AT7KkOVD7F1U8o1VPEMfpSMQYC6jfaK9bk0HMyxQvfW8gJ4h9BX4SUKmYXWO9mxo
	oQUJwXP+/B9z9nYuFWWiO0RoSpynbwVK8VJLhKgLcoog2rvpofQHTxUJw5/gg4539D9cbKobD957r
	uKPWQq9u+k6cAyiSD7F+ijgyRDMwXA3Gx6+yigN/XdRJdVSaxX69+Dr5e+MHkRz97HShz0GL34ZBU
	yERFg/s89zdxX0QKGvCwlWyMQKFtER8d7Lq223VBe6+dm6vl9TIPSrFebPzyEW99hRkc9+qFYbBjR
	MVMk6o5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyXa3-0000000H39T-1CFG;
	Mon, 24 Aug 2026 16:31:27 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyXZx-0000000H38S-2bwk
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 16:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=341cGJLnKlasAS
	ORCZkznBC2KO5WlGLLTxMiIq0tCfA=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=Wz4PbK1GruIYnUAADBeZ0526j/lvj1fGSKw6z
	0+DEaVmZySmda4tZciEh9e/YnTD85H+o1zViIyf9aEx7bx1MP92uvD6JaNYi8JQIGwqMc9
	fI1dqn/WasoV/YHnkv/J/6bDJs1MITe6NBIeVOl8xXKRO6ctSo/vGfbU1TWiOo2lAdg5TN
	r5xbS84dw61IrpMXGVhHkHwFYlKaDWxmvw9mKeswQUHoJb9UaXIGcK2vM6xc1rUWVbxzC8
	Or4/FfMXvDxiksssT4NxKTBokz9IPhUS726/HjQGlGPM7D9G9Ceb9coRMnbu0g2LR+ZFjz
	965u/vzThS8fOq+bMm8UPrNqg==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 2de62e10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Aug 2026 18:31:16 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 18:31:15 +0200
Message-Id: <DKXBFWLKS911.MABX0LKENDSF@arkamax.eu>
Cc: "Sagi Grimberg" <sagi@grimberg.me>, "Keith Busch" <kbusch@kernel.org>,
 "Ibrahim Hashimov" <security@auditcode.ai>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Subject: Re: Prior report for the nvmet-tcp unbounded SGL length fix in 7.3
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Shivam Kumar" <kumar.shivam43666@gmail.com>,
 <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.22.0
References: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
In-Reply-To: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_093123_956297_44DD6717 
X-CRM114-Status: UNSURE (   9.53  )
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

On Mon Aug 24, 2026 at 5:42 PM CEST, Shivam Kumar wrote:
> Hi all,
>
> I originally reported this issue to security@kernel.org on 2026-03-17
> (Cc Sagi), Message-ID:
> <CA+ysrSJUFi8cHzU8g9Nrbbkcuo0F7vh8CMn3ht15gSk3BbK45A@mail.gmail.com>
> and posted the first patch for it in this thread,
> "[PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()"
> (2026-03-19).
>
> Commit 4a3f002 ("nvmet-tcp: bound SGL data length before allocating
> command buffers"), merged for 7.3, adds the same NVMET_TCP_MAXH2CDATA
> bound with the same status code.

I didn't notice this new patch, but I still suspect that MAXH2CDATA is misu=
sed
and that the correct solution is to set MDTS.

Maurizio


