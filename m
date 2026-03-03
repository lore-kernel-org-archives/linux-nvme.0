Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33702EB3649
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 01:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ah5DDGh7BfQs6F/18En8GMWxi7ztoLX4jw5ciTni7N8=; b=OOS1d1r7YpNC7fxxQ6HtmyWPni
	X6atz4Wie1TA8XMOekfEOrfEASVdIgrljYLe2arFE3CokJI7VHV83GEBLmr4fyrmrQyOWV4SFuOEb
	0mm2MsMXt7vNMmyPBDc+ThXAhAxbCcQAFi8GLw7o+/AG33WM0raOy56cwv8u+hmJJ7il+CwsIkxru
	vvA+MjG3C1V0et3rSE0V+LPiAkW0CZsOyAIEzLUjHuu0oNQSuQ9gDnk2vc8u2uuFF5yk9W6PM+vyJ
	CUhs6RKRVoBBCFJD9SUAHwzgb4AeR6vPCXtgM46BgZf2QZHXLvUS21Nl/a1tQXknpO2qG+B356nzY
	Iajw+MMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxEKC-0000000EKbk-0UcK;
	Tue, 03 Mar 2026 01:13:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxEK9-0000000EKbB-0fWK
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 01:13:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772500399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ah5DDGh7BfQs6F/18En8GMWxi7ztoLX4jw5ciTni7N8=;
	b=O5yQRg1WfmLJKDcNLq4K/2YGCcGbIDtZ98NfFo/B6wbteFaeh0bfEXMQE+TAP/2NRxhnjn
	YQ7ND14dunVH1BgZj1us/pRgTIkR4gerWXmBL6GMtXJnEwkOcT00YNAWigsKeGEsCqTqFK
	10ZOtoAWv8cXUpSwUTFcZj/VAVH+uBk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-42YCB_dJMnaSCfW2gt0wCw-1; Mon,
 02 Mar 2026 20:11:43 -0500
X-MC-Unique: 42YCB_dJMnaSCfW2gt0wCw-1
X-Mimecast-MFC-AGG-ID: 42YCB_dJMnaSCfW2gt0wCw_1772500301
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E410195608D;
	Tue,  3 Mar 2026 01:11:40 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.250])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 14B6719560A2;
	Tue,  3 Mar 2026 01:11:36 +0000 (UTC)
Date: Mon, 2 Mar 2026 17:11:36 -0800
From: Chris Leech <cleech@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 04/21] nvme-auth: common: add KUnit tests for TLS key
 derivation
Message-ID: <20260302-crewless-multiple-5bd14f68a73a@redhat.com>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-5-ebiggers@kernel.org>
 <1de7ef59-4236-4372-81f6-60d5a4f1e253@suse.de>
 <20260303002649.GE20209@quark>
MIME-Version: 1.0
In-Reply-To: <20260303002649.GE20209@quark>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: fw9wj9-qELyvD8rcAqh7B7Oh3VeeiMcXPWdjDlL-a3I_1772500301
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_171321_274883_2A336CD1 
X-CRM114-Status: GOOD (  25.06  )
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

Hi Eric, I'm reviewing your patches but just wanted to say thank you for
the details on this comment and respond to them quickly.

On Mon, Mar 02, 2026 at 04:26:49PM -0800, Eric Biggers wrote:
> On Mon, Mar 02, 2026 at 11:04:43AM +0100, Hannes Reinecke wrote:
> > Which discrepancies do you see between the specified algorithm
> > and the implementation?
> 
> I'm looking at the latest NVM Express Base Specification, v2.3.
> 
> First, there's the following:
> 
>     The host computes KS as the hash of the ephemeral DH key resulting
>     from the combination of the random value y selected by the host with
>     the DH exponential (i.e., gx mod p) received from the controller
>     (i.e., KS = H((gx mod p)y mod p) = H(gxy mod p)).
> 
> The actual code skips that step when deriving the PSK, and just
> considers the DH value directly to be "KS" and uses it directly as an
> HMAC key.  That is something that should never be done.  DH values are
> not uniformly distributed and must not be used directly as keys.

We might have an issue with the secure concatantion generated PSK here,
and a shortage of independant implementations to catch this in testing.
I'll take a closer look at it, but at a glance I think I agree.

> Second, the only mention of HKDF is in section 8.3.5.6.2.  Assuming that
> corresponds to what was attempted to be implemented in
> nvme_auth_derive_tls_psk(), it does not match because (at least) the
> specified label does not match the one used in the code.

The AVE stuff in NVMe 8.3.5.6 is _not_ what nvme_auth_derive_tls_psk() is
doing. Most of the TLS handling is specific to TCP as a fabric
transport, and is in the seperate "NVM Express NVMe over TCP Transport
Specification".  In this case, section 3.6.1.3 "TLS PSK and PSK Identity
Derivation".

I'm fairly certain that's sorted now, after some confusion caused by the NVMe
specs calling for HKDF-Expand-Label vs. HKDF-Expand.

- Chris

> Those are just a couple things I noticed in a very quick glance.
> 
> (There's also the key reuse bug I pointed out before.  But it sounds
> like that's a bug in the spec, not the code.)
> 
> - Eric
> 


