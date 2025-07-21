Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273AAC83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y6CCtxv04upL9PruCfjDd/z4v/YJcurtVUV7bWHXfnE=; b=D731edAeC6fdmaj7XYrPy70zYi
	vkCRbf637/9HT5buebzZzfZM0pfH2BOnDst8Z/W/oqoGQLPsVrVrxRMCzl/9dIf5d8bsSl80D+q6H
	tWHPGe9OWs4zpOYPzq87670RtIVOgTa8tR/jhFSwM8NV9FqFNwY1PemdK8NLPAESwbPJQOZlmoUfG
	BSpwXelMJvaJwexrZ5Px9LN4E8soPU8Jg8UtSL7YWczM26ur44RkMvVNGq+WYra8JgNbYqun6p5HZ
	XN0kraFAo7FlocQaNjvOrYzxthHDpwkinqLGKkphVbuqzf2tngdpnmz6Z2r0yiyEZeXu1+/jC+JTt
	5G82rXjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udtnG-00000000F4E-2imE;
	Mon, 21 Jul 2025 16:55:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udsUq-000000005NN-3xTO
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 15:32:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753111928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6CCtxv04upL9PruCfjDd/z4v/YJcurtVUV7bWHXfnE=;
	b=VvYbO+/iVA0b/AfO9JLjT3xxJfdKhbcvlMLKDDPcGKif3H0tN6F9pf27sNewVLrVAlLkwc
	eFWJbjIaeFGVJttFcSmpfoRO0WKaOhQe1c39utP/Gqs9rEN2EhA6e4vTKkBOmLRTMtWLAa
	e9UtOj6C/1F/nHM0E9JZuYPh837EHkE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-hm7l8eSRPtOc6I2QmQkxZw-1; Mon,
 21 Jul 2025 11:32:04 -0400
X-MC-Unique: hm7l8eSRPtOc6I2QmQkxZw-1
X-Mimecast-MFC-AGG-ID: hm7l8eSRPtOc6I2QmQkxZw_1753111923
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CC9619560BF;
	Mon, 21 Jul 2025 15:32:03 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE1ED195608D;
	Mon, 21 Jul 2025 15:32:01 +0000 (UTC)
Date: Mon, 21 Jul 2025 08:31:58 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	Prashanth Nayak <prashanth.nayak@netapp.com>,
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
Message-ID: <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
MIME-Version: 1.0
In-Reply-To: <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DeZ8y8D8u4A8HgJ2QrYqTRcXNuFFOBzeoD_k7QAG0Dw_1753111923
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_083209_051944_BC83CB20 
X-CRM114-Status: GOOD (  12.24  )
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

On Mon, Jul 21, 2025 at 08:36:01AM +0200, Hannes Reinecke wrote:
> On 7/21/25 04:17, Chris Leech wrote:
> > There are issues with the Retained and TLS PSK derivations due to the
> > implementation not adhering to the RFC 8446 definition of the
> > HKDF-Expand-Label function.
> > ...
> Hmm. I _thought_ we had it all fixed...

I went into this expecting/hoping to find the problem on the spdk side,
and I'd be happy to wrong here (especially if backed up by another
interoperable implementor).

The lack of a full example in the nvme/tcp transport spec to verify
implemenatations against is kind of a bummer.

- Chris


