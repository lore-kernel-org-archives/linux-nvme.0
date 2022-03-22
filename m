Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CA8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i6kulhjPujqwJDmykuNNeUYdnADo+4+ZPvq18WOIHeU=; b=g7UBMTu4B+6IgMLuxPWDnIDFML
	2g3ica0B4jADyOJdlhWhjCO0Z4otMlJkK7oqbJRh6HHD+NCG2rpQVktmFGPfYT7M0u9onTdQyTZEv
	Y+XsWHVDrKZhFu+bcWsFHxjcjL2di67+Q+IqJPuNQfFJSvu/1WJiGuzEGfkSmY6mTOu9hef5AUR1b
	JMNY78U9Tx4qybxSAfxwdUsTlqjKZUmZdYTNHyQvwAdxsQkPUFW2MBv9IhAnykTgphW1lNnZhPFCs
	6cQRHpwe0SO906QYLxSfXw5NXPZB74BgzLQJ7DOg3JkdQRYu/XDAUZl4w3qEQGXws8Im94WMsFXyY
	E18s4cpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWdIY-00AuMN-JP; Tue, 22 Mar 2022 12:07:38 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWdIT-00AuJd-1W
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 12:07:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0FB3210F0;
 Tue, 22 Mar 2022 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647950847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i6kulhjPujqwJDmykuNNeUYdnADo+4+ZPvq18WOIHeU=;
 b=dJcL1Oj/DGFzckQaKpJ+HPU6e+joQAnUwEKUs5JL6drL7usWIl9BWRezKlgwr/kfBjQJW8
 UfVoizPRe5ptZTF4yumYfU9M9eDomQkUqeZQ3R0q+SR6lCRuUdMOmp+wGQW7skwIV0PNpT
 jw+8D5isjJUXzrQ5ZeF+WhMhKTCA9aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647950847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i6kulhjPujqwJDmykuNNeUYdnADo+4+ZPvq18WOIHeU=;
 b=sfP30wrRaPmfaZM3nFu7cP5xkS09Q9xkAz9hDiCgDqmwp38+l9L4D+lvfnpK9skvLXZqJ/
 s3vpoYu9M6aOCXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1D7B12FC5;
 Tue, 22 Mar 2022 12:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UFzcLv+7OWI8XAAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 22 Mar 2022 12:07:27 +0000
Date: Tue, 22 Mar 2022 13:07:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, lengchao@huawei.com, hare@suse.de,
 mlombard@redhat.com, jmeneghi@redhat.com
Subject: Re: [RFC PATCH] nvme-multipath: break endless loop in
 nvme_round_robin_path
Message-ID: <20220322120727.k2drakwc4sr4rclq@carbon.lan>
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-3-cleech@redhat.com>
 <20220322111743.GC29151@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322111743.GC29151@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_050733_277255_DCA70C8E 
X-CRM114-Status: GOOD (  15.70  )
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

On Tue, Mar 22, 2022 at 12:17:43PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 21, 2022 at 03:43:03PM -0700, Chris Leech wrote:
> > This is a backstop for the odd loop construct in nvme_round_robin_path.
> > It counts how many times the head pointer has been passed, as that's the
> > only thing guarenteed to stay on the list.  Once is needed to start from
> > a different place and check the entire list, twice is excessive looping.
> 
> Shouldn't

d1bcf006a9d3 ("nvme-multipath: Early exit if no path is available")

> take care of this?

IIRC, this addressed the issue that we started to dereference a NULL
pointer if there was no path left.

Chris' problem is that the iterator always returns the same
pointer. Personally, I prefer the solution to introduce some sort of
sentinel over the one with the locking.

