Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E68C5472F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kgt1rDhB3tqHgknqxyoONMHMo+OxvdM/AzWNdimoAOE=; b=2wG8a0I0fVt+yAtP5Djy1ZzFkw
	xFxvNWdRdbXpTr2r2r7X2+8S/5J3fgtA4NecTNlZjSeinv13ufmXZMA0l9m1HP+SOzv0oD/b+j8d2
	9ZmfhLz6jfVVJNJ0PnyDXkrjglwiBvAQKin4JbXDToURAFe4AptpG32GN/euPMfKwpFoZWIjAjCez
	xAXwflha56Sqv4R53W4vSmVmDKA0PmXpFiplHekbjMVl/H4Z9TtqgsKBK1OInEACLKGuYpwqVbQRH
	FtVD0UActRCli2saSTCUQIe0pleodi32IPOeGuxOwaw/YxXibM4W0MwG40VVGBGrVADh29V+hONY6
	te/tYr7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siyek-0000000C04t-0ahj;
	Tue, 27 Aug 2024 16:02:54 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siyeT-0000000C00T-0b6L
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 16:02:38 +0000
Received: from mordecai.tesarici.cz (unknown [213.235.133.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id BB8E91F64C8;
	Tue, 27 Aug 2024 17:55:41 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724774142; bh=Kgt1rDhB3tqHgknqxyoONMHMo+OxvdM/AzWNdimoAOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yr2QCciqpjJLdknVeRsD7PsgDs/BjCz1fzFb54yBUI3dAxCIH/yC8BaQmC7/rIZta
	 R4kjf3UbLQCx1HLrAE4H2MgHezkcmPDFZQZ9nmLAlnCgcG7tHoQyc+4tzcXxmxeGY7
	 trJ1BuKWBR09O0Y0zhR9kjieTqui1PosnMmSEtljfZmWeWRlO47Ec6PMVNuitXt+Tm
	 ZbHUJnds5/jNYa0TE/npvMr4Rh6uHf2OuRT36H8OkM3E45X4PNypdTIftik36Eqlf5
	 UAsu0FwczQ62eO0gD/RQm/Whj1+48funVWiYx6oo8oGD4OY2icw65WKNjg03OqWYJY
	 hzHJcftv+yBNQ==
Date: Tue, 27 Aug 2024 17:55:36 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 1/7] swiotlb: Introduce swiotlb throttling
Message-ID: <20240827175536.004785f3@mordecai.tesarici.cz>
In-Reply-To: <SN6PR02MB4157AE3FA2E0D2227CC94CC0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-2-mhklinux@outlook.com>
	<20240823094101.07ba5e0f@meshulam.tesarici.cz>
	<SN6PR02MB4157AE3FA2E0D2227CC94CC0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_090237_350180_5C49B015 
X-CRM114-Status: GOOD (  30.65  )
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

On Fri, 23 Aug 2024 20:41:15 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Friday, August 23, =
2024 12:41 AM
> >=20
> > On Thu, 22 Aug 2024 11:37:12 -0700
> > mhkelley58@gmail.com wrote:
>[...]
> > > @@ -71,12 +72,15 @@
> > >   *		from each index.
> > >   * @pad_slots:	Number of preceding padding slots. Valid only in the =
first
> > >   *		allocated non-padding slot.
> > > + * @throttled:  Boolean indicating the slot is used by a request tha=
t was
> > > + *		throttled. Valid only in the first allocated non-padding slot.
> > >   */
> > >  struct io_tlb_slot {
> > >  	phys_addr_t orig_addr;
> > >  	size_t alloc_size;
> > >  	unsigned short list;
> > > -	unsigned short pad_slots;
> > > +	u8 pad_slots;
> > > +	u8 throttled; =20
> >=20
> > I'm not sure this flag is needed for each slot.
> >=20
> > SWIOTLB mappings should be throttled when the total SWIOTLB usage is
> > above a threshold. Conversely, it can be unthrottled when the total
> > usage goes below a threshold, and it should not matter if that happens
> > due to an unmap of the exact buffer which previously pushed the usage
> > over the edge, or due to an unmap of any other unrelated buffer. =20
>=20
> I think I understand what you are proposing. But I don't see a way
> to make it work without adding global synchronization beyond
> the current atomic counter for the number of uI'm sed slabs. At a minimum
> we would need a global spin lock instead of the atomic counter. The spin
> lock would protect the (non-atomic) slab count along with some other
> accounting, and that's more global references. As described in the
> cover letter, I was trying to avoid doing that.

I have thought about this for a few days. And I'm still not convinced.
You have made it clear in multiple places that the threshold is a soft
limit, and there are many ways the SWIOTLB utilization may exceed the
threshold. In fact I'm not even 100% sure that an atomic counter is
needed, because the check is racy anyway. Another task may increase
(or decrease) the counter between atomic_long_read(&mem->total_used)
and a subsequent down(&mem->throttle_sem).

I consider it a feature, not a flaw, because the real important checks
happen later while searching for free slots, and those are protected
with a spinlock.

> If you can see how to do what you propose with just the current
> atomic counter, please describe.

I think I'm certainly missing something obvious, but let me open the
discussion to improve my understanding of the matter.

Suppose we don't protect the slab count with anything. What is the
worst possible outcome? IIUC the worst scenario is that multiple tasks
unmap swiotlb buffers simultaneously and all of them believe that their
action made the total usage go below the low threshold, so all of them
try to release the semaphore.

That's obviously not good, but AFAICS all that's needed is a
test_and_clear_bit() on a per-io_tlb_mem throttled flag just before
calling up(). Since up() would acquire the semaphore's spinlock, and
there's only one semaphore per io_tlb_mem, adding an atomic flag doesn't
look like too much overhead to me, especially if it ends up in the same
cache line as the semaphore.

Besides, this all happens only in the slow path, i.e. only after the
current utilization has just dropped below the low threshold, not if
the utilization was already below the threshold before freeing up some
slots.

I have briefly considered subtracting the low threshold as initial bias
from mem->total_used and using atomic_long_add_negative() to avoid the
need for an extra throttled flag, but at this point I'm not sure it can
be implemented without any races. We can try to figure out the details
if it sounds like a good idea.

Petr T

