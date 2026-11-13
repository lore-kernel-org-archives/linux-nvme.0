Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB8606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=knmI0ng8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TyjSUjc2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Moen4uVA6/CxV9ILOWUwEnAN1ZWvG5CXpvngIeZSs7o=; b=knmI0ng8ZS1Zxx
	sS2GpGOVaKsCgJfGX32Bo8XWJ3sLW5wO1WLYoqkgJDGThbCAK0JzIitKJTBbLGWrjyShGcgiRiXib
	gk7XcUtitGG9hTzo5qua2+uohxXXL8zrw8wYM15nJvkW6PfBEX+qmxguBjBI+t4O8yCpkh/NHYOdW
	vurgpBBuBvdc/bqfwVHC7mKlqPibEq+ao6SaednCZ4g9+ZwYt/P1GSKWE8VjvI0OJ/zW4Ej9eoZvq
	+kwHO7LN9GAcwij1D902POzCEVC5KgWbCELkLR0AAR+raJ+gcEY1+uZFeRyfndmwwOg97UAXxVlYv
	KIKB8dGbTlTT7+cVKRow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRgLO-0000000BSN8-0DTu;
	Fri, 13 Nov 2026 01:44:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRgLL-0000000BSMb-0quy
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 01:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794534282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Moen4uVA6/CxV9ILOWUwEnAN1ZWvG5CXpvngIeZSs7o=;
	b=TyjSUjc2vZmL/a5vrmeSb0MyBkPtye7WGVValnO+ZC+GJ0BHZQntDUzcNAwv1qD7LLqz9u
	LJaCaUmvG2fCOUPONjfmf0bJHmxiJaoGJVyQRaB7FxnNOR2GLzCgzDYOVzSc3DTRD/ueYi
	LQM4yTQixTfXQMz9Nr6WaaZkdLmFE/I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-8nvC4jF9NFSgYvoI6NwXTg-1; Thu,
 12 Nov 2026 20:44:40 -0500
X-MC-Unique: 8nvC4jF9NFSgYvoI6NwXTg-1
X-Mimecast-MFC-AGG-ID: 8nvC4jF9NFSgYvoI6NwXTg_1794534279
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71DFC19560BE;
	Fri, 13 Nov 2026 01:44:39 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57E891800543;
	Fri, 13 Nov 2026 01:44:38 +0000 (UTC)
Date: Thu, 12 Nov 2026 17:44:37 -0800
From: Chris Leech <cleech@redhat.com>
To: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: nvme-tls failing with (61b0ed3be81b6) nvme-tcp: parallelize I/O
 queue allocation and startup
Message-ID: <20261112-c241d8bc9d510b065f2bb277@redhat.com>
References: <20261112-9505880f2c33f0134ef20c39@redhat.com>
 <CAMof9cWw6jDht3++cYcybQohq=Nf6DzY4ZL1m_E0b95r9CRxMQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMof9cWw6jDht3++cYcybQohq=Nf6DzY4ZL1m_E0b95r9CRxMQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G-jWO0HB75VNSb0uDr851mzDCbrIVJ5n0cKXmCH5zaY_1794534279
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_174443_378061_E2A89338 
X-CRM114-Status: GOOD (  18.37  )
X-Spam-Score: 0.5 (/)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 02:35:23PM -0800, Surabhi Gogte (she/her) wrote:
> On Thu, Nov 12, 2026 at 10:46 AM Chris Leech <cleech@redhat.com> wrote:
> >
> > Hello,
> >
> > I was testing some patchs and ran into trouble with nvme-tls that I
> > bisected back to this change (61b0ed3be81b6 nvme-tcp: parallelize I/O
> > queue allocation and startup).
> >
> > I haven't determined what exactly is happening yet, but blktests
> > nvme/062 and nvme/063 both fail with this applied and pass again if I
> > revert it.
> 
> Hi Chris,
> Can you check if the failures you saw are due to an older version of
> ktls-utils/tlshd being used?
> Ref: https://lore.kernel.org/linux-nvme/CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2BmN20Bh3btpLum7THg@mail.gmail.com/.

Thanks for this. I should have found that, but was coming to the idea
that it might be related to having an older tlshd anyway.

> If the tests fail with ktls-utils 1.5.0 as well, please share further
> details about the blktest failure logs and kernel logs so I can also
> take a look.

The initial environment I was bisecting in still seemed to be having
issues, but a clean Fedora 44 + ktls-utils 1.5.0 does look to be working
as expected.  I'll spend some time trying to sort out if I've made a
mess of this system in some other way.

- Chris


