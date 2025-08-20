Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A974CA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oqta/QAQSbFTF1U9PBrhEbnw+rAYvkf7fG5BApOHix4=; b=D4zfz6ohX21QmHkTdTKjIHp2Xj
	1c6uCx8qPcwliv+/uORkazrZfF5tbLrw+QZ92vwgnxVHcvo7+ooolsgQ7Xzw04amQXu+cwdo7s4f8
	Upb7kbXeebAqDp5SXViQALyd8Kg9bv3IN95zcJFGyeE8Mz1V/qJTsEAWoCKFWjN3tGT/qefmQAleY
	fUY0j1yD+Y5IoHn88u9dzFU6FH/zbUZKGjHl++cVOJXiPIOAnjHUMCfCLMfgw6H3/Nf2cG4Hltx+v
	9cZBs6RATRqJX7r0UkC36kDLVjtj5faMChXKAK21XJNRGFR0cEXVpKrjnsuLUjp0LOuSEawbWg4NH
	KtQiRwlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uos2n-0000000FAhg-2pe6;
	Wed, 20 Aug 2025 23:16:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoonW-0000000EmP1-3IcY
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 19:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755719315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqta/QAQSbFTF1U9PBrhEbnw+rAYvkf7fG5BApOHix4=;
	b=PD78AZ10/LvDgscJEOC+QREGMD6lyor7N6TcsK2FOKOcw7sJ7c0FhKIlSLRUPidKHj+Mpb
	nxC7nrzJKx4A4DyDXs1tY5wxQ8oSioahInB3dTOuP1KOS2yB1Wfd0XXeWCjsE5HHjkoImi
	nZisaYlOiJnDyAVyiyh1bLbgo0ZEzAc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-8jsqZYneM8inZW7HC5ma9A-1; Wed,
 20 Aug 2025 15:48:32 -0400
X-MC-Unique: 8jsqZYneM8inZW7HC5ma9A-1
X-Mimecast-MFC-AGG-ID: 8jsqZYneM8inZW7HC5ma9A_1755719310
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B5621954236;
	Wed, 20 Aug 2025 19:48:29 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00675180044F;
	Wed, 20 Aug 2025 19:48:25 +0000 (UTC)
Date: Wed, 20 Aug 2025 12:48:22 -0700
From: Chris Leech <cleech@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: hare@kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: hkdf: add hkdf_expand_label()
Message-ID: <aKYmhusP6povB_TU@my-developer-toolbox-latest>
References: <20250820091211.25368-1-hare@kernel.org>
 <20250820091211.25368-2-hare@kernel.org>
 <20250820184633.GB1838@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820184633.GB1838@quark>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_124838_895560_093A8281 
X-CRM114-Status: GOOD (  19.57  )
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

On Wed, Aug 20, 2025 at 11:46:33AM -0700, Eric Biggers wrote:
> On Wed, Aug 20, 2025 at 11:12:10AM +0200, hare@kernel.org wrote:
> > From: Chris Leech <cleech@redhat.com>
> > 
> > Provide an implementation of RFC 8446 (TLS 1.3) HKDF-Expand-Label
> > 
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Chris Leech <cleech@redhat.com>
> > Signed-off-by: Hannes Reinecke <hare@kernel.org>
> > ---
> >  crypto/hkdf.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
> >  include/crypto/hkdf.h |  4 ++++
> >  2 files changed, 59 insertions(+)
> > 
> > ...
>
> Does this belong in crypto/hkdf.c?  It seems to be specific to a
> particular user of HKDF.

While this is needed for NVMe/TLS, it's a case of the NVMe
specifications referencing a function defined in the TLS 1.3 RFC to be
used.  I though it would be clearest to fix the open-coded implemenation
by creating an RFC complient function, which is now no-longer specific
to NVMe so I moved it out to crypto/hkdf.c

I don't know that there will be other users, it just seemed to make the
most sense there.

- Chris


