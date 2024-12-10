Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47D2E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 21:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8L8ZtXQH0PCylh+PCRNX0eEGsR3a8/OZSXdBxtjCsT8=; b=NMiw6Gy2aIPwAn0bPPRfU21rvy
	bhTrJ8OjUdCvnKSR+0dgDWaieKeV6C7EAX8wrbOl7wNYI85yJYAfJuN9Ni3/tlRLbD+UbAop8gHhc
	wyZsexj7yXVUMWurfyYbpbPKPwROLy7ol1XR2EI90p6Oe2mCVqTeWZIbO/KoeXFRWZTfEkT3ABUP0
	nnLK0DgiNVKw1xqQGVa01unBwOL8rWdtzjL0608zJneZpjzZAY6+976FG33kCQ26a7tPBAsS697+I
	NIOIg581YQD/mvGVT7kqLqiNlIBowY4/2tMiYHpA+yHN+Fzy6VBGIjq+6vQK2LKMRjOJqcQdwChS9
	jOSnMAIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL7ul-0000000CpfG-36ik;
	Tue, 10 Dec 2024 21:37:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL7uk-0000000Cpf1-1vYl
	for linux-nvme@bombadil.infradead.org;
	Tue, 10 Dec 2024 21:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8L8ZtXQH0PCylh+PCRNX0eEGsR3a8/OZSXdBxtjCsT8=; b=aZpkCVlC1u0cyPSysL76SaaQBM
	VUFUBqxw/wY6SsoyeW/vzoX8EcUQZ6k7+wW8ahGJ4mK4pyQ58CSjXOelUr1y77R8sCzlVgbvXLPLX
	uZA8pTgOc0Kk3ge9jV3p+uREV1+maJphO8GGvNCBcsE+1jQ0T8WRVPuaFQ3CSVAa/ShSyD/U6dL3j
	3Kp3OcTZP5H/T27szis6GUmwLn9hme7kGWUHpBjxevRcsfZiXkp42bGamiV69Z4gL0fk9H7bAvnGV
	+JHnnKxkgcbFtnEhTcAQR56QXiTifSc6xrJ34EK8VF8Gg/kYZ8D6+yqPgn0+o9Vvo9kM1lB+NARkb
	pnC9buKQ==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL7ug-00000003jMm-2Obe
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 21:37:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9C7C8A41AC8;
	Tue, 10 Dec 2024 21:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22535C4CED6;
	Tue, 10 Dec 2024 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733866618;
	bh=kVLRhtKdianMhUJiBSB5RAuhhAuiqmseZ4Kt3QafGag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Af3/xZFNdYfHWsxxQzQUff+pnIlPOYBAgqLPr+T9Cg+233TH4HS9J2TRQ8CUynX1g
	 3I8xauzpo7m+sHqSNRv6CH8nEobOcKLcAIg2ci8so+RlMcZObPK+Ap5KXQXzPvl0bp
	 z8uAstSs8XKOqGbWjREtE/2NO9sZGo44IYCd0PsDmFjaa03vqlKtc1uDFPdcBxl/+A
	 d+32XunHNN2HaIIODU30f0Xjo/sbZ78bioVNEk34Lw/BiTFZ3v/3T8ViAUOHxhrkqf
	 aaUMCfyCMMuUwntX93+Ffsw7KJU6nkSvjN6kOWE6e1vtrmjtk1YCdngBtTPhfGtuLg
	 72lTuUYdqZ/EA==
Date: Tue, 10 Dec 2024 14:36:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Pawel?= Anikiel <panikiel@google.com>
Cc: Robert Beckett <bob.beckett@collabora.com>, axboe <axboe@kernel.dk>,
	hch <hch@lst.de>, kernel <kernel@collabora.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	sagi <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <Z1i0d5Ht8zUHhSu-@kbusch-mbp.dhcp.thefacebook.com>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
 <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
 <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com>
 <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
 <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_213703_034288_4D12B2C3 
X-CRM114-Status: GOOD (  26.24  )
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

On Mon, Dec 09, 2024 at 04:33:01PM +0100, Paweł Anikiel wrote:
> On Mon, Dec 9, 2024 at 1:33 PM Robert Beckett <bob.beckett@collabora.com> wrote:
> > [...]
> > I have no further updates on this. I have received no further info from the vendor.
> > I think we can go ahead and use the alignment patch as is. The only outstanding question was whether it is an
> > implicit last entry per page chain vs simple alisngment requirement. Either way, using the dmapool
> > alignment fixes both of these potential causes, so we should just take it as is.
> > If we ever get any better info and can do a more specific patch in future, we can rework it then.
> 
> I think the 512 byte alignment fix is good. I tried coming up with
> something more specific, but everything I could think of was either
> too complicated or artificial.
> 
> Regarding the question of whether this is an alignment requirement or
> the last PRP entry issue, I strongly believe it's the latter. I have a
> piece of code that clearly demonstrates the hardware bug when run on a
> device with the nvme bridge. I would really appreciate it if this was
> verified and my explanation was included in the patch.

I've pushed this to nvme-6.13 with an updated commit message here:

  https://git.infradead.org/?p=nvme.git;a=commitdiff;h=ccd84b8d6f4a60626dacb933b5d56dadca75c0ca

I can force an update if you have any edit suggestions.

Commit message copied below:

Author: Robert Beckett <bob.beckett@collabora.com>

nvme-pci: 512 byte aligned dma pool segment quirk

We initially introduced a quick fix limiting the queue depth to 1 as
experimentation showed that it fixed data corruption on 64GB steamdecks.

Further experimentation revealed corruption only happens when the last
PRP data element aligns to the end of the page boundary. The device
appears to treat this as a PRP chain to a new list instead of the data
element that it actually is. This is an implementation is in violation
of the spec. Encountering this errata with the Linux driver requires the
host request a 128k transfer and coincidently get the last small pool
dma buffer within a page.

The QD1 quirk effectly works around this because the last data PRP
always was at a 248 byte offset from the page start, so it never
appeared at the end of the page. Further, the MDTS is also small enough
that the "large" prp pool can hold enough PRP elements to never get to
the end, so that pool is not a problem either.

Introduce a new quirk to ensure the small pool is always aligned such
that the last PRP element can't appear a the end of the page. This comes
at the expense of wasting 256 bytes per small pool page allocated.

Link: https://lore.kernel.org/linux-nvme/20241113043151.GA20077@lst.de/T/#u
Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
Cc: Paweł Anikiel <panikiel@google.com>
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

