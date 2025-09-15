Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1ACCAC597
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53Jjui4XqZ/IQp9ciZZrnrpWJSvGUpzV87U1Eh5hxPo=; b=e/yk6gB2jk29Ddw3C026lbt7os
	BGXfGd5+ueHTnol5gJ++xK/tkFWRR5Vb5bTMZ3ux8blzwIzcibNOBpOzAjoCXzCTO/YHKvLnQXyc8
	y90lWL56uxY3isaIofNkQEcR26Vfwb48+9Ln6zd5AgW2gG/k3zyr4KVbAmzEvPhYP0jpCTW5UO+yk
	4otXymGH1/yuHPNv3gBZf/SPWqxR7JPG9sEjGT1zR1/Ie/mFwbe77XJ6/kyGPYCa7AAQ9nXhD9Pkl
	zqgoYaehyJAtIIU8ZXihCErEmAaz0A2sjPtBe1XSk+LImo8FiFTByTERpuhI5ey4hYCes9EUs72zI
	sTg5Q1cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyISU-00000005rqk-1HCV;
	Mon, 15 Sep 2025 23:18:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyISR-00000005rpZ-3sdB
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 23:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757978280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53Jjui4XqZ/IQp9ciZZrnrpWJSvGUpzV87U1Eh5hxPo=;
	b=Vo7EbUONh3wuUIHmbZEe7StNL+sSsVGgFUI+9CoFWBJD1r5guiwgpandhd7VWFy5PCfxBF
	X+EevZT7f18zqZxQLXM2oUBaqXkqrOs4ZLxt7SM3hYrd9a8t6nspTz4k9AAyn3P8hY1gwD
	3X8paoPI1cdpbDtMFVIPAxViUtinOfw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-mW8XYG5YOhSzFtg2P_wzzg-1; Mon,
 15 Sep 2025 19:17:55 -0400
X-MC-Unique: mW8XYG5YOhSzFtg2P_wzzg-1
X-Mimecast-MFC-AGG-ID: mW8XYG5YOhSzFtg2P_wzzg_1757978273
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5531A19775DB;
	Mon, 15 Sep 2025 23:17:53 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.100])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B675F180035E;
	Mon, 15 Sep 2025 23:17:50 +0000 (UTC)
Date: Mon, 15 Sep 2025 16:17:49 -0700
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/2] nvme: fixup HKDF-Expand-Label implementation
Message-ID: <20250915-expectant-limb-a1464f3a1076@redhat.com>
References: <20250821204816.2091293-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821204816.2091293-1-cleech@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_161804_042462_DAF36625 
X-CRM114-Status: GOOD (  24.01  )
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

Bump and a polite review/merge request.
There's been no feedback requiring changes in v2.

Thanks,
- Chris 

On Thu, Aug 21, 2025 at 01:48:14PM -0700, Chris Leech wrote:
> As per RFC 8446 (TLS 1.3) the HKDF-Expand-Label function is using vectors
> for the 'label' and 'context' field, but defines these vectors as a string
> prefixed with the string length (in binary). The implementation in nvme
> is missing the length prefix which was causing interoperability issues
> with spec-conformant implementations.
> 
> This patchset adds a function 'hkdf_expand_label()' to correctly implement
> the HKDF-Expand-Label functionality and modifies the nvme driver to utilize
> this function instead of the open-coded implementation.
> 
> As usual, comments and reviews are welcome.
> 
> Changes from v1:
>  - Moved hkdf_expand_label() from crypto/hkdf.c to nvme/common/auth.c.
>    It's not really an RFC 5869 HKDF function, it's defined for TLS but
>    currently only used by nvme in-kernel.
>  - Fixed kdoc label_len -> labellen
>  - Replaced "static const char []" with "const char *", it's just
>    clearer and generates the same code with a string literal assignment.
> 
> (I've left the crypto emails on this version, mostly to make it known
> that hkdf_expand_label() has been moved as Eric asked.)
> 
> Chris Leech (2):
>   nvme-auth: add hkdf_expand_label()
>   nvme-auth: use hkdf_expand_label()
> 
>  drivers/nvme/common/auth.c | 86 +++++++++++++++++++++++++++++---------
>  1 file changed, 66 insertions(+), 20 deletions(-)
> 
> -- 
> 2.50.1
> 
> 


