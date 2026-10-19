Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750EB606DA47
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vejObQfD;
	dkim=pass (2048-bit key, unprotected) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=mc0Mg6ww
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ygs3X3ENxEn1kcHb0BESwsuMyteLFzl/Orq5Xkq/2Wo=; b=vejObQfDBUNYePkNssNVgBSxKP
	nHx4IkO05c8o5qcNAohLJ+wvlHCc1JJUmmTpdUKMcqW+WZHLzj396cYyH8GLr68YUERGHlxG4fh+x
	NfnxCqWaDUxn9eEANWpvuPe69LgVwMD8jFDpEkEPhIaNPepqhEhyAckzQeDG15gEEGBHBy3tLjRQF
	Am9VdGDDBaxwScjuuLInvjZqLsA+C4oX8CbEnxePPqPU/ecsY6CVk5zFcWlKT8R9chte4+YAmSA7G
	XA76pl9DNxvvfXTpvshdo7KCS5jVl4CvXSR5AB5Mp9ZORgfW986yhGFAFi286iBEHzhH+blU0srGu
	1nDYIQAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIplz-00000007ub1-2LrV;
	Mon, 19 Oct 2026 15:59:39 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIplw-00000007uaF-2671
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 15:59:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=ygs3X3ENxEn1kc
	Hb0BESwsuMyteLFzl/Orq5Xkq/2Wo=; h=in-reply-to:references:from:subject:
	cc:to:date; d=arkamax.eu; b=mc0Mg6wwR0HCL8oSvMRECfHUUb8XJQFOd7ibVmEC+L
	AdK0KjeH/OpJZsLAEQNytt3zB+fwF5sQJLsWP+0tGzKJtJRo4Ku/bdh0kAas9hn11cyIE/
	duV8IV/kkbzoYE8zuwKVAvpwKGgFiH3r/0TtnU7t4QNqmZD6/T4mriXLghYAQB+3vm3lKm
	4NmAURrlIzGYMhaDrPGj4LSweOQh2Tr5jxeMwwvZZhD1W5XJa9r2eUoP93dsl9j9eO+1Sd
	VOIjPsb9nFWbxKEYAsjJo3+nnF36Vn19G0E6rUtXUQ0WV3Go9grjA+FZWDy6gaKofZuzAy
	iSdima2D25sTAZCeWPfg==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 4533d2ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 17:59:33 +0200 (CEST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 17:59:33 +0200
Message-Id: <DM8XU4VWHK4E.351HYUQE39XLI@arkamax.eu>
To: =?utf-8?q?Ram=C3=B3n_Jes=C3=BAs_Miranda_Hern=C3=A1ndez?=
 <ramonjesusmiranda@gmail.com>, <mlombard@arkamax.eu>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
 <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: nvme-pci: nvme.quirks= on the kernel command line hangs early
 boot when nvme-pci is built in
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.22.0
References: <DM8QWISGYBCZ.FC52WMOJDZDF@arkamax.eu>
 <CAP08=V2Kqo8OFrKe7rEk3+J3W65rS8vKpA5a_PBC8qwxvQaKGg@mail.gmail.com>
In-Reply-To: <CAP08=V2Kqo8OFrKe7rEk3+J3W65rS8vKpA5a_PBC8qwxvQaKGg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_085936_879763_0BE37AD6 
X-CRM114-Status: GOOD (  13.32  )
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Oct 19, 2026 at 5:48 PM CEST, Ram=C3=B3n Jes=C3=BAs Miranda Hern=C3=
=A1ndez wrote:
> Hi Maurizio,
>
> Thanks for the quick look and the patch. I tested device_param_cb() on th=
e
> Surface Pro 11 (X1E80100) with CONFIG_BLK_DEV_NVME=3Dy: kernel 7.2.8 buil=
t
> from 616a9f22 plus your change, booted with the parameter on the command
> line.
>
> Result: with the patch the kernel boots with
> nvme.quirks=3D0xffff:0xffff:bogus_nid
> It reaches login with no hang, and the parameter is visible afterwards in
> /sys/module/nvme/parameters/quirks. The nvme0 controller probes normally
> (pci 0006:01:00.0, 64 MiB HMB, 12 queues).
>
> Caveat: I used a placeholder VID:DID that matches no device, so this show=
s
> the parameter is parsed at boot without hanging. It does not show a real
> quirk being applied to a matching controller. I can retry with the VID:DI=
D
> of the Surface's NVMe if that is useful for your review.

Thanks for testing!

It's not necessary to test a real quirk, just be sure the callback gets
called and doesn't hang the kernel.

A useful thing is to re-test if the quirks parameter still works
as before when CONFIG_BLK_DEV_NVME=3DM, to be sure we are not introducing
a regression.

Maurizio



