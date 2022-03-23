Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FACC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ThZ03wyGTM1/NSQkuA9whCPI0RXV+T5UMXXAYPKChAc=; b=WucPMf5e4XNJCLkeOYkCGs1Vay
	Wf5ZTIL51pW0p12vc40Qti3DpPkcKwzEYbCzp8HDUwIOUtPBONfcfVqVf+dz6vkoZyaDSNEbd0wtq
	IkGcKApqYcDEzQq5eDCmGsJW+vXglbeYLPW83YPNxWvABL/yKdlAiBhm6IIl+Xk2lYyYhaUg0Na6X
	ySaDutkEiq9H6pqCodDEy+1ksKoGdA6vbEDLW8c0dDYyig4fN8F4bb6kV6xNUfT2oy7ITqSAEEg5J
	Ezhn713FONVe3lznx61xj3AkFi4yJ0Ahj5Rhb2681FOz3pvsy0eo3QcaqrX6jUrU2xp21h3e66HdY
	eUDr9nFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX4i6-00EQbH-WE; Wed, 23 Mar 2022 17:23:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX4hn-00EQUV-5c
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 17:23:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E779F68B05; Wed, 23 Mar 2022 18:23:26 +0100 (CET)
Date: Wed, 23 Mar 2022 18:23:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org,
 "Knight, Frederick" <frederick.knight@netapp.com>,
 Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Message-ID: <20220323172326.GA2280@lst.de>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <089e3056-e603-bd9e-6680-52a26cafa72e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089e3056-e603-bd9e-6680-52a26cafa72e@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_102331_387089_E8E077A0 
X-CRM114-Status: GOOD (  18.12  )
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

On Wed, Mar 23, 2022 at 01:17:32PM -0400, John Meneghini wrote:
>  1. All hosts will connect to the existing Discovery Service with the Well Known
>     Discovery NQN and retrieve the Discovery Log pages for the HostNQN provided
>     in the Fabric Connect command, as it is done today.
>
>     It was assumed that Authenticating with the Well Known Discovery NQN would
>     would not be needed or supported because:
>     a) The Discovery Controller controls the Authenticate work flow and
>        returning AUTHREQ=1 in the connect response would break legacy hosts.
>     b) It doesn't make sense to have a Well Known Discovery NQN as a part of a psk.
>
>  2. Discovery Controllers which support Authentication can return Discovery
>     Log Page Entries with Subsystem Type (SUBTYPE): 03h - as defined by TP-8014.
>     These DLPEs will contain Unique Discovery NQNs - as defined by TP-8013
>
>  3. Hosts that support Authentication can then disconnect from the Well Known
>     Discovery Controller and re-connect with the Unique Discovery NQN. These
>     hosts should expect an AUTHREQ=1 response.
>
>  4. Hosts that don't want to support Authentication can ignore the SUBTYPE 03h
>     Log Page Entries and operate normally. This would include legacy hosts.
>
> Hopefully, with some kind of a design like this, both legacy (non-authenticating)
> and new (authenticating) hosts and discovery controllers can interoperate.

This makes much more sense.  But why would a host that is part of a PSK
setup even use the well known discovery controller at all?  Whatever
mechanism is used to share the key should also distribute the actual
discovery controller to be used and avoid that entire step.

