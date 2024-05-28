Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D640CC25B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rYg0TTRzA8O3sBmCaNFcaodzlZZszlkh1V5SLXZSiEs=; b=fbgM7FCtjRiIgsvRRPVWQXXRJy
	RCmbvXU0sR1yuTEeBMLeBv0wF+foqBrA/1UF5jAl4AeB45wX1OFn92wQWMrh/qSnoOGnvw6B9fvvm
	FckexcngYDS7kSoHe1veuzceITvhpzys1orX/HnQq+q3N1ddACKKOzktU0M+iAGqMTiKPbjQDd7wf
	zOZLS7RgimLgYeaPYJ29mVIzHTVO/uS333/lT/1zSrFbqecX+Qn74Bmr5HPUIVVG6REkNEWA+uH8G
	iDOCx315BnVuJElFBAjQfo5fWwUwJniBwAXtWkN5VonVFIXVQT3LfBPb94kpoGBfe1h/xNOCVJp9y
	jXsyQX1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBuoR-00000000KbU-1EiP;
	Tue, 28 May 2024 11:16:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBuoP-00000000Kay-1HjX
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 11:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716894971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYg0TTRzA8O3sBmCaNFcaodzlZZszlkh1V5SLXZSiEs=;
	b=XLlsmF87p0CF7Fhe0JCeM3oPDNWy4GPhIPPeoZyNkO6e1tOJd3jQ49eTFXBBf5zyxbOZSQ
	Qrwi9dIuYufumQn2JleegjdvlxlFgHu/tDe1ooArZ2iLL6Rk3XdOXLkgzQZWhcFq3Pv2vp
	YCoeL+E9X9sAcBIO5Gac4xRfl7Kb9nM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-iVtCDwhVNzKupBwSEjm7lg-1; Tue,
 28 May 2024 07:16:06 -0400
X-MC-Unique: iVtCDwhVNzKupBwSEjm7lg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 486FC1C05131;
	Tue, 28 May 2024 11:16:06 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A8603400059;
	Tue, 28 May 2024 11:16:05 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 9094030C1C33; Tue, 28 May 2024 11:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 8C6013C542;
	Tue, 28 May 2024 13:16:05 +0200 (CEST)
Date: Tue, 28 May 2024 13:16:05 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Eric Wheeler <dm-devel@lists.ewheeler.net>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 0/2] dm-crypt support for per-sector NVMe metadata
In-Reply-To: <206cd9fc-7dd0-f633-f6a9-9a2bd348a48e@ewheeler.net>
Message-ID: <971e4bbc-62b8-18bb-e847-1d2e58f2a07f@redhat.com>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com> <206cd9fc-7dd0-f633-f6a9-9a2bd348a48e@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_041613_442704_D6447FB5 
X-CRM114-Status: GOOD (  19.82  )
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



On Mon, 27 May 2024, Eric Wheeler wrote:

> On Wed, 15 May 2024, Mikulas Patocka wrote:
> > Hi
> > 
> > Some NVMe devices may be formatted with extra 64 bytes of metadata per 
> > sector.
> > 
> > Here I'm submitting for review dm-crypt patches that make it possible to 
> > use per-sector metadata for authenticated encryption. With these patches, 
> > dm-crypt can run directly on the top of a NVMe device, without using 
> > dm-integrity. These patches increase write throughput twice, because there 
> > is no write to the dm-integrity journal.
> > 
> > An example how to use it (so far, there is no support in the userspace 
> > cryptsetup tool):
> > 
> > # nvme format /dev/nvme1 -n 1 -lbaf=4
> > # dmsetup create cr --table '0 1048576 crypt 
> > capi:authenc(hmac(sha256),cbc(aes))-essiv:sha256 
> > 01b11af6b55f76424fd53fb66667c301466b2eeaf0f39fd36d26e7fc4f52ade2de4228e996f5ae2fe817ce178e77079d28e4baaebffbcd3e16ae4f36ef217298 
> > 0 /dev/nvme1n1 0 2 integrity:32:aead sector_size:4096'
> 
> Thats really an amazing feature, and I think your implementation is simple 
> and elegant.  Somehow reminds me of 520/528-byte sectors that big 
> commercial filers use, but in a way the Linux could use.
> 
> Questions:
> 
> - I see you are using 32-bytes of AEAD data (out of 64).  Is AEAD always 
>   32-bytes, or can it vary by crypto mechanism?

It varies. I.e. if you use hmac(sha512), full 64 bytes will be used.

> - What drive are you using?

Western Digital SN840

WUS4BA119DSP3X3

> I am curious what your `nvme id-ns` output 
>   looks like. Do you have 64 in the `ms` value?
> 
>         # nvme id-ns /dev/nvme0n1 | grep lbaf
>         nlbaf   : 0
>         nulbaf  : 0
>         lbaf  0 : ms:0   lbads:9  rp:0 (in use)
>                      ^         ^512b

Yes, I have this:
lbaf  0 : ms:0   lbads:9  rp:0
lbaf  1 : ms:8   lbads:9  rp:0
lbaf  2 : ms:0   lbads:12 rp:0
lbaf  3 : ms:8   lbads:12 rp:0
lbaf  4 : ms:64  lbads:12 rp:0 (in use)

Mikulas

> --
> Eric Wheeler


