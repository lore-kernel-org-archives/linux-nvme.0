Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F368D68B12
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LOLHAUJhptSneCwD15uTXeURWvGOUY0U2+/TzxvTOCA=; b=MSTrYGv7vXNe0ixjmgqOMc9LuB
	IddQUEu3eoKv+JG9JTytY78fno5d/HvcO2VKtKnoQVtE9ejR0DTzWw56D+rWvgOgl7Cz2XQBojrSj
	983vIU05sxEtRp3SN/4y1WpidS3sMm/gbhq/ULJe5TFU6N6nRsthMJCzqo/iE9ZIEilSSLY/NYNPv
	aUR/VJsueh7VAleHtM65boCAik3Rl4MyMOklqAaGFE+VWrCfV2L0Q4QT6mblzel7Ite19Iittu8h0
	BiciqXSf50ffPuAPOz8sJlNmTIKn5sV1XS10hRRfTmTcrN+acES8gIC+tBTS5yhFIKtyVqJxoIaKZ
	gUOc3NTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBZq7-0000000A2lF-3s5t;
	Thu, 14 Nov 2024 13:24:51 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBZq4-0000000A2kQ-13Nb
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 13:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1731590679; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dExcrHdI4NLng30EjTasoZWqecc0YZU02PEJaX/N0PYWfsCOQ9ayZLHsqvPAcqp/CE/yRWRv4OWgUUhlS0WpLi6VTmVksGrhZQy9nhOXI20cze96kSHmFJQEFOinPgR9fBvOIKHf76z9XJDEhIvgkEkr7+DXcgyip9JISyIQVMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731590679; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LOLHAUJhptSneCwD15uTXeURWvGOUY0U2+/TzxvTOCA=; 
	b=KxRh7YzCezAMVh9HRq/UJNwFhYhFBWnhS30Q9koDfP9VRhvsAgC5yfhkqYIz6i7ta5cUfQ7he8gLxjaF9nbnNo1+QEMeCvDIk1yoTg30IGrbemZdCrN2I10ZqG519ZCnSZCPRjMaqocd5ofGWNUgW1U6AeIpj+nYv30Qn8iAgxw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731590679;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LOLHAUJhptSneCwD15uTXeURWvGOUY0U2+/TzxvTOCA=;
	b=lZLferIzClsWcdjwTXRpftqe8X2iKjiOOFof9B69o418/NUtoi5emPQxcCcF0oha
	P6BLbeBqRsoZPP4EaurChRXOLwLglaCEh9xmP7mrJ+uNoDANNsW1KlcCzG0/4duu1sJ
	N0EGhD27wTjVTV8tzjArw4/e5v4Z4Yem2pTI7yZE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731590648390658.8815358439043; Thu, 14 Nov 2024 05:24:08 -0800 (PST)
Date: Thu, 14 Nov 2024 13:24:08 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: =?UTF-8?Q?=22Pawe=C5=82_Anikiel=22?= <panikiel@google.com>
Cc: "axboe" <axboe@kernel.dk>, "hch" <hch@lst.de>,
	"kbusch" <kbusch@kernel.org>, "kernel" <kernel@collabora.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"sagi" <sagi@grimberg.me>
Message-ID: <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
In-Reply-To: <20241114113803.3571128-1-panikiel@google.com>
References: <20241112195053.3939762-1-bob.beckett@collabora.com> <20241114113803.3571128-1-panikiel@google.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_052448_384244_E4CA2003 
X-CRM114-Status: GOOD (  28.75  )
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






 ---- On Thu, 14 Nov 2024 11:38:03 +0000  Pawe=C5=82 Anikiel  wrote ---=20
 > Hi all,
 >=20
 > I've been tracking down an issue that seems to be related (identical?) t=
o
 > this one, and I would like to propose a different fix.
 >=20
 > I have a device with the aforementioned NVMe-eMMC bridge, and I was
 > experiencing nvme read timeouts after updating the kernel from 5.15 to
 > 6.6. Doing a kernel bisect, I arrived at the same dma pool commit as
 > Robert in the original thread.
 >=20
 > After trying out some changes in the nvme-pci driver, I came up with the
 > same fix as in this thread: change the alignment of the small pool to
 > 512. However, I wanted to get a deeper understanding of what's going on.
 >=20
 > After a lot of analysis, I found out why the nvme timeouts were happenin=
g:
 > The bridge incorrectly implements PRP list chaining.
 >=20
 > When doing a read of exactly 264 sectors, and allocating a PRP list with
 > offset 0xf00, the last PRP entry in that list lies right before a page
 > boundary.  The bridge incorrectly (?) assumes that it's a pointer to a
 > chained PRP list, tries to do a DMA to address 0x0, gets a bus error,
 > and crashes.
 >=20
 > When doing a write of 264 sectors with PRP list offset of 0xf00,
 > the bridge treats data as a pointer, and writes incorrect data to
 > the drive. This might be why Robert is experiencing fs corruption.
 >=20
 > So if my findings are right, the correct quirk would be "don't make PRP
 > lists ending on a page boundary".

This is interesting.
I had the same idea previously. I initially just changed the hard coded 256=
 / 8 to use 31 instead, which should have ensured the last entry of each se=
gment never gets used.
When I tested that, it not longer failed, which was a good sign. So then I =
modified it to only do that on the last 256 byte segment of a page, but the=
n is started failing again.
This lead me to believe it was not a chaining issue specifically, so I went=
 looking for other hypotheses, eventually setting on 512 byte alignment.
I never saw any bus error during my testing, just wrong data read, which th=
en fails image verification. I was expecting iommu error logs if it was try=
ing to access a chain in to nowhere if it always interpreted last entry in =
page as a link. I never saw any iommu errors.

 >=20
 > Changing the small dma pool alignment to 512 happens to fix the issue
 > because it never allocates a PRP list with offset 0xf00. Theoretically,
 > the issue could still happen with the page pool, but this bridge has
 > a max transfer size of 64 pages, which is not enough to fill an entire
 > page-sized PRP list.
 >=20
 > Robert, could you check that the fs corruption happens only after
 > transfers of size 257-264 and PRP list offset of 0xf00? This would
 > confirm my theory.

I'd be glad to if you could share your testing method.
Currently I use a desync image verification which does lots of reads in par=
allel and is the only method I've found so far that can repro in a reasonab=
le amount of time.

 >=20



