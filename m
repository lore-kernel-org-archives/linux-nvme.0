Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D30C61D85
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8EYyCryX7PBKswSadGF3aphue0eBdpRNIdFAo5BTQRU=; b=w5ougLEFfidO8UC/N7KImW7BBW
	OCkQ6uX7IuN4RERHrpi5/Io+eUlMaUgk7gmAPbyCjZF/OwAWAwrLQLbeKvwPN6DaGGW7lwDd0lapM
	yiY5EANRNr55SDRhvJmCujxjNYb7voAduY15mUj+sDjsa30IzLwSsLp6wypPZAU3kL3EGGQDOPu9v
	8PhCpEHvJSOZgHN+hwlAJj24Dup3ybtaAGDYfwgkIUUkqkULv86YmwBtzF9ZBHTaJEcbbspHo8KeH
	S9KVBQ5yT1TepZYbCApzfrPZirNFAb95H4HTO3on8WDIGIQS/wvyNFVYWrCj2MVdi1yBDF/8yjZ1c
	rxpsO5EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5bLe-000LcY-0x;
	Wed, 22 Nov 2023 00:44:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5bLZ-000Lc0-0t
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 00:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700613844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8EYyCryX7PBKswSadGF3aphue0eBdpRNIdFAo5BTQRU=;
	b=Gx7+uJumHVkKVd3zfeVk/Q1Rhl+QCHo2AInIPLlPBTAMLeRJRaFAh0fD5k8ppvrZ72ssTY
	vaYNCoQykX6EZVnauNK+39fxvbckXnhjRgoWj7nLdD6mSQ+nG1M/czOdaE/sxbE50L279K
	HaQda4mEl3ERx6tFJBNj5p9XgeGz7hQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-Y5BE8AH3Ofu_IuaI0chxBA-1; Tue,
 21 Nov 2023 19:43:59 -0500
X-MC-Unique: Y5BE8AH3Ofu_IuaI0chxBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3B4B1C05191;
	Wed, 22 Nov 2023 00:43:58 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EBA31C060AE;
	Wed, 22 Nov 2023 00:43:52 +0000 (UTC)
Date: Wed, 22 Nov 2023 08:43:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, joshi.k@samsung.com,
	martin.petersen@oracle.com, ming.lei@redhat.com
Subject: Re: [PATCHv3 1/5] bvec: introduce multi-page bvec iterating
Message-ID: <ZV1OxMPsJYq7Tyaw@fedora>
References: <20231120224058.2750705-1-kbusch@meta.com>
 <20231120224058.2750705-2-kbusch@meta.com>
 <ZVxsLYj9oH+j3RQ8@fedora>
 <ZVzRmQ66yRDJWMiZ@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVzRmQ66yRDJWMiZ@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_164405_405652_CCBE06CF 
X-CRM114-Status: GOOD (  16.18  )
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

On Tue, Nov 21, 2023 at 08:49:45AM -0700, Keith Busch wrote:
> On Tue, Nov 21, 2023 at 04:37:01PM +0800, Ming Lei wrote:
> > On Mon, Nov 20, 2023 at 02:40:54PM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Some bio_vec iterators can handle physically contiguous memory and have
> > > no need to split bvec consideration on page boundaries.
> > 
> > Then I am wondering why this helper is needed, and you can use each bvec
> > directly, which is supposed to be physically contiguous.
> 
> It's just a helper function to iterate a generic bvec.

I just look into patch 3 about the use, seems what you need is for_each_bvec_all(),
which is safe & efficient to use when freeing the host data(bio or bip), but can't
be used in split bio/bip, in which the generic iterator is needed.

And you can open-code it in bio_integrity_unmap_user():

for (i = 0; i < bip->bip_vcnt; i++) {
	struct bio_vec *v = &bip->bip_vec[i];

	...
}

Thanks,
Ming


