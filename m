Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73691CA0EDA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 04:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y8NQgi8yUSMvxMZpfj0sKKbsRBduLmCSSgHsWqK8gUU=; b=h4UkPueyK/vWwvMPkptZcaVIEn
	vRikBRh5vk+cnfjoE4UzDerwbad8Rda+liuT/mAdXBagjiTgeSDuo0G8AoH/OUtspM/xt+5wUgxTb
	35eIJfdewBteBYpA5Gky3DB4TJMnf1rrd8kBNAhDv6+4/kqiuHAzBWbYGaPeh9VeMRy3I6bt26tx8
	ZTakgXRU1HJaG6WpQoIaFBNM44t28KRRm1+lHp72Pb0e6F3VTqEZRh0f8W4hGnAzw313WYPeUOMS/
	Rr8/ZRSM2mvXGNGu4vLWBUY7NymgVL/uxyjTvBsEay7Sf4eCpEZFo4tN79848mGAmJfXGHsxTqIbO
	A7FsQJSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulghN-00000009nBN-0Sz4;
	Tue, 12 Aug 2025 04:33:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulghK-00000009nB1-0fGb
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 04:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754973195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y8NQgi8yUSMvxMZpfj0sKKbsRBduLmCSSgHsWqK8gUU=;
	b=HNEK7pl+W3d6Ci7kICkMErBvto/t/+Z2URCE0zWyceKHlklr9Qi9pwdKv7qFpFzFNklXZv
	xKwtBbTiNJUIAeWmGKT/WuydWSPRsSxIcqUJPZOTt1nlxrJ3Mf+GBsnaf7uD4Ux3x381sl
	5RBlL6tLfP63kgR9xYobOWFmcR8nS48=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-lZbFn6l6NF6cC2JOvBG4xQ-1; Tue,
 12 Aug 2025 00:33:12 -0400
X-MC-Unique: lZbFn6l6NF6cC2JOvBG4xQ-1
X-Mimecast-MFC-AGG-ID: lZbFn6l6NF6cC2JOvBG4xQ_1754973191
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF169180035B;
	Tue, 12 Aug 2025 04:33:10 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.17.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1156A19560AB;
	Tue, 12 Aug 2025 04:33:08 +0000 (UTC)
Date: Mon, 11 Aug 2025 21:33:06 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	Prashanth Nayak <prashanth.nayak@netapp.com>,
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
Message-ID: <aJrEAia9jVk17y-j@my-developer-toolbox-latest>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
 <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
 <aIPINwQZNxk_7FZs@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
MIME-Version: 1.0
In-Reply-To: <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Hz5gCI7gne1kxVjYf7AJy4dBNmz1JQw-DmrfscUWJU_1754973191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_213318_285906_C71E3906 
X-CRM114-Status: GOOD (  36.05  )
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

On Mon, Jul 28, 2025 at 09:12:15AM +0200, Hannes Reinecke wrote:
> ...
> But: this is an incompatible change. Once we integrate this patch
> the keyring will end up with a _different_ derived PSK than it would
> without that patch. So the _same_ PSK (in interchange format) will
> result in different PSKs in the keyring, causing the handshake to
> fail if the other side is not aware of that.
> 
> > > _However_: PSKs generated with after applying this patch will be
> > > different than those prior to this patch.
> > > Consequently there will be interop issues with existing implementations
> > > (which will use the original encoding).
> > > 
> > > I guess we would need to wait for the target implementations to be fixed
> > > or introduce a flag switching to the old / compat implementation to avoid
> > > interop issues.
> > 
> > Yes, it is a breaking change for compatibility with other out-of-spec
> > implementations.  I'm hesitant to carry a flag for that, but it wouldn't
> > be too much trouble to implement.
> > 
> > Just don't touch your keyfile?  The tls-key import/export commands are
> > operating on the final derived TLS PSKs right?
> > 
> That might be the way out, and in fact what we should be doing.
> However, the fact still remains: after this patch has been applied
> one _cannot_ generate new PSKs until the other side has been updated,
> too.
> For linux it's easy, we can just require 'version xyz' from libnvme
> and the issue is solved. But for other implementations?
> There are IHVs out there who already shipped their products with TLS
> enablement, and they need to be fixed, too.
> And their timeline is vastly longer than ours.
> 
> So to avoid us having to synchronize against all of the others I think
> it might be easier to add a 'compat' flag of sorts to generate PSKs
> with the 'original' derivation algorithm, and then increase the
> libnvme version number once it's in.
> Then we can point the IHVs to that number so that they reference
> that version once their firmware is updated.

I've spent a bit of time on this, and while I don't have patches ready
to share just yet I do think it's worth commenting on the scope of the
change to keep the existing functionality behind a cli switch.

 libnvme:
 - keeping both sets of key derivation functions (this is not bad)
 - need to expose that functionality, so new exported APIs
   (I was thinking something like a flag field over a legacy-only function)
      - #define NVME_TLS_PSK_LEGACY (1u << 0)
      - char *nvme_generate_tls_key_identity_2(..., unsigned int flags)
      - long nvme_insert_tls_key_versioned_2(..., unsigned int flags)

 - support paths that load keys through nvme_fabrics_cfg [1]
   (for nvme-cli fabrics commands that take --tls_key)
      - add some sort of flag there, like nvme_fabrics_cfg.tls_legacy
      - add to merge_config, nvmf_update_config, build_options,
        supported_options, etc.

 - the JSON schema/code would need to support this for persistent
   configurations

 nvme-cli:
 - add a command line flag to keyring command functions
 - convert to use of new libnvme APIs to pass flag
       - gen_tls_key, check_tls_key
        (I don't think nvme_tls_key does key conversions)

 - add command line flag to generic parsing into nvme_fabrics_cfg
       - handles connect, connect-all, discover, discover-all

 - man pages, shell completions, etc.

It may be possible to keep this to just in libnvme and switch on an
environment variable, but that sounds like just as big of a support
nightmare as remembering to pass an option to every command.

If we don't have a resolution by then, maybe this is something we can
resolve at ALPSS.

[1] Side note; with nvme_fabrics_cfg _not_ being allocated through
libnvme, I don't see how the various additions there can be ABI safe. It
looks to me like this struct alone broke ABI in libnvme 1.4, 1.8, 1.9,
and 1.11.

- Chris


