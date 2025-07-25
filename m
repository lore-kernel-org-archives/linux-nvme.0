Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71DCC87FCE
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jul 2025 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3uXVocTqqOIxcX2TstdWb1IY3XpZaMgOBVLCmLShBq8=; b=x/3WbDv3XBBbWe4kpetqLVLYMI
	1+oRJnqQtNYhmd0M0pNP+SODQM8h7wtOh/XwvubRenq64HKO4a7gQC382su67K7mWPoViwu4dZ3TK
	NehhaY1tWs71dEZLdZ52ZfRgSWdUk5pcxPOupUckfzn88qMmnbwu8R6DMQx682h20hNUrTOjSoWun
	YzF8qFbi3YXphyCDTBJnC1FppP17tX7dlvmcL4UhviG6NoM8Ks/Zh65lkVFdwKCwjvHCstpKHWNFE
	/yRVO1tfPBOtX9rteAojZLYtBpCtjf9Z/aH+/cEj4SkYsO7/7zDBOk2CCIhE5OtEAHMJ9j57XlVKz
	oFoSqwPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufMqz-0000000AOug-15YZ;
	Fri, 25 Jul 2025 18:09:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufMqx-0000000AOuI-0TCY
	for linux-nvme@lists.infradead.org;
	Fri, 25 Jul 2025 18:09:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753466944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uXVocTqqOIxcX2TstdWb1IY3XpZaMgOBVLCmLShBq8=;
	b=P3iVMukp6V4RtVvq9otWGkbl7l/F5Bj67+aANjafEfYpBRk8mRj9UoOFFJzQy7VXJ+p+38
	iYPVi1KRC1kmecvnqIbHY9F2MIULbuAPs4q1q+XanvnxN9YfEV961n0WoUbmkoz76rU9U7
	p0XwJ8IUc3nen46bD8qliRiSGQvTupo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-LOwggCeNPEerEcTZP5u_mw-1; Fri,
 25 Jul 2025 14:09:01 -0400
X-MC-Unique: LOwggCeNPEerEcTZP5u_mw-1
X-Mimecast-MFC-AGG-ID: LOwggCeNPEerEcTZP5u_mw_1753466940
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F48919560B6;
	Fri, 25 Jul 2025 18:09:00 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 734C119560AA;
	Fri, 25 Jul 2025 18:08:58 +0000 (UTC)
Date: Fri, 25 Jul 2025 11:08:55 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	Prashanth Nayak <prashanth.nayak@netapp.com>,
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
Message-ID: <aIPINwQZNxk_7FZs@cleech-thinkpadt14sgen2i.rmtusor.csb>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
 <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
MIME-Version: 1.0
In-Reply-To: <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hVLBaZneu4N4SFO8znLv3tj9zXmREv9MPnKOsirqkoo_1753466940
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_110907_222445_A6F28D44 
X-CRM114-Status: GOOD (  22.67  )
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

On Fri, Jul 25, 2025 at 11:36:20AM +0200, Hannes Reinecke wrote:
> On 7/21/25 17:31, Chris Leech wrote:
> > On Mon, Jul 21, 2025 at 08:36:01AM +0200, Hannes Reinecke wrote:
> > > On 7/21/25 04:17, Chris Leech wrote:
> > > > There are issues with the Retained and TLS PSK derivations due to the
> > > > implementation not adhering to the RFC 8446 definition of the
> > > > HKDF-Expand-Label function.
> > > > ...
> > > Hmm. I _thought_ we had it all fixed...
> > 
> > I went into this expecting/hoping to find the problem on the spdk side,
> > and I'd be happy to wrong here (especially if backed up by another
> > interoperable implementor).
> > 
> > The lack of a full example in the nvme/tcp transport spec to verify
> > implemenatations against is kind of a bummer.
> > 
> Okay, seems that you have been right after all.
> I've re-read RFC 8466 and indeed you seem to be right about
> the encoding of variable length vectors (cf RFC 8446 section 3.4).
> 
> So I guess we need to take this patch after all.

So we're back to agreeing on the correctness of the changes?
Honestly, I appreciate the scrutiny.
 
> _However_: PSKs generated with after applying this patch will be
> different than those prior to this patch.
> Consequently there will be interop issues with existing implementations
> (which will use the original encoding).
> 
> I guess we would need to wait for the target implementations to be fixed
> or introduce a flag switching to the old / compat implementation to avoid
> interop issues.

Yes, it is a breaking change for compatibility with other out-of-spec
implementations.  I'm hesitant to carry a flag for that, but it wouldn't
be too much trouble to implement.

Just don't touch your keyfile?  The tls-key import/export commands are
operating on the final derived TLS PSKs right?

- Chris


