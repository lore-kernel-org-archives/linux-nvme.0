Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254AFCCD185
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sa0hyLl/CuAPqN8piNUXRod9YatWS5sLJjv2OTB79g8=; b=p1TW/hdFmP/4+AArMQfcK63Npr
	yel7X4GicKG6+ywPhN5BBSN/0/0axmFm1nCb9plWHCXdFndcRqzl3hxrGoqwsd6+v5flbWhE8ubkF
	5R97a5eNGrCDC2QvTaq7dQ5gluHJ1l+HMn+G+zwlq5La0bOxhVL0TNkPZs/Ax76sSUbiOTVWtCvqh
	F5w7HiMPc5jHSYfdEvqijooO+lpC8GVRroApuI9X5JLzBqL01PaYD/5EbCHl+c8XKgGVuDTCpjEdx
	klRr56Z8ExWLkq3BD44gSEeG7R2DrF3WKTlbXGiRILSE8ZGC8HgjI0+TLzv8/w9qIJjiJEbg9K+9F
	kedeM2DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8FMI-0000000Cpvb-1JsG;
	Mon, 13 Oct 2025 10:00:50 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8FMG-0000000CpuI-0Gdl
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 10:00:49 +0000
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760349643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa0hyLl/CuAPqN8piNUXRod9YatWS5sLJjv2OTB79g8=;
	b=1li8TwzZhoICH9uuKMFiVylAENaNEecMvoJE4L/hJWX0yks3goxmK5aCyM8L3Lk7tDpWOP
	BFasLTqJbp7IRj1C738QUlRBfGaX/T6Xu/INu7xA0xpkzFkK1FA/BpsJvGxFLnst0N1ufR
	fvkjBa5T8jfYisZWR4cHHYA8xbdvNxxBCi1twl9TwwNie+dwdUy7wOAoCqwW2qyVfiI4k6
	VVLMMhBOWYLSRJDz7zQRchVYCBQibBLQREC9UfFEZ+agxKImmrL9Kks4wt6sK1pHnWanWv
	iWnKl6aV+fM+QQrlC1XvzasgnqDbJmY/dxmOFI2b1osfqn67B1ZiVfuRcB/9xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760349643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa0hyLl/CuAPqN8piNUXRod9YatWS5sLJjv2OTB79g8=;
	b=aPGeZ/XYOy7puJGDMk1N9AIu2A71OJ+SNAdl88f+tdLjG+uu3h9AgJbCcHKYhlFN6F2j+l
	ehc8X3iOzGsiaDAw==
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, tglx@linutronix.de, maz@kernel.org,
 gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, Linux List Kernel
 Mailing <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [bug report][PPC]: rmod nvme driver causes the kernel panic
In-Reply-To: <31838b50-e420-405a-af23-6c6ede281386@linux.ibm.com>
References: <31838b50-e420-405a-af23-6c6ede281386@linux.ibm.com>
Date: Mon, 13 Oct 2025 12:00:42 +0200
Message-ID: <87h5w3f7ed.fsf@yellow.woof>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_030048_237463_9F4B0401 
X-CRM114-Status: GOOD (  10.34  )
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

Nilay Shroff <nilay@linux.ibm.com> writes:
> Hi Nam,
Hi Nilay,

> On the latest upstream mainline kernel, I am encountering a kernel
> crash when attempting to unload the NVMe driver module (rmmod nvme)
> on a POWER9 system. The crash appears to be triggered by the recent
> work on using MSI parent domains, discussed here:=20
> https://lore.kernel.org/all/cover.1754903590.git.namcao@linutronix.de/

Thanks for the detailed analysis. This should be fixed by:
https://lore.kernel.org/linuxppc-dev/20251010120307.3281720-1-namcao@linutr=
onix.de/T/#u

which currently is in powerpc/fixes-test

> Possible Cause:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This looks like a cleanup ordering issue introduced by the recent MSI par=
ent
> domain rework. The PCI/MSI teardown seems to assume that the MSI descript=
or
> remains valid until after the domain teardown path executes =E2=80=94 whi=
ch no longer
> appears to hold true in this sequence.

I think the reason is more idiotic than that, the msi_alloc_info_t
passed to pseries_msi_ops_teardown() is always all zeroes, thus we have
the NULL pointer deref regardless of the sequence. See the patch I
mentioned.

Nam

