Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA84C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 10:22:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CC960273
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 10:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14CC960273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n2gUgSIgAj9eb3dIsUJAzVrygXCWhMwvVtCx323hbzk=; b=AE0Dwg9+HvhMEmezzywYRM6+8f
	joM2X7Czx+zFYPXx2R+qaK7rpPeGxE1Ev+YDKJzDp7lX3NKKOU9BWkDAsmJQ5ysUIYmaEyJEP5aFG
	HKz+L94fb8adFtb3u/IEkMkzAXmWvoen2thBjMezZOc9VP3/dghGUiaG5vc9ERMgwORTupdP3fHWd
	/rkL/pQvmNneFqyu7kzTNlrtz11iFbJXMgSQs7PJ0CvwGVmuXs7WlLZ1/qqomFrMEwe5cRI8CBhrB
	txc5NRYpPieFODvwOk7sfsuvQek7TsmKAkEypHBdb/OB5b1wjGIq+uxcVtRldulvFSzvsQJKWzNrD
	qF9hl3mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkkk7-0055lN-Ks; Wed, 10 Nov 2021 10:22:11 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkkk5-0055jr-Ez
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 10:22:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC14E21B13;
 Wed, 10 Nov 2021 10:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636539725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2gUgSIgAj9eb3dIsUJAzVrygXCWhMwvVtCx323hbzk=;
 b=s5WPclLApj6VTZD2JY1svclNq/wt0ib4TXHiMdFwlRafjAuMiuVZON9pVtxaVBOPXcbema
 f4tglGpLkSbqR8n78UzCIJ1n34WMXDPZhEWIIWw4W0wIFQCr3lyqMUCnwz5SoeDsc2nFpj
 82wXg/rlbOl/T6+QHURfhDcQcEDSstU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636539725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2gUgSIgAj9eb3dIsUJAzVrygXCWhMwvVtCx323hbzk=;
 b=a+jEixb6pafMJgikEnh5kbjvhIXB0eUvOlPoloqwiX10io2vJ3fjhMlhCbgfNendm3+Q5/
 CGsit7jXABemwIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C143F13B7F;
 Wed, 10 Nov 2021 10:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rFj9Lk2di2HZMwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 10 Nov 2021 10:22:05 +0000
Subject: Re: sorting out the freeze / quiesce mess
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20211110091407.GA8396@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <477f3098-39be-ad07-e2fb-3ef3309c4dce@suse.de>
Date: Wed, 10 Nov 2021 11:22:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211110091407.GA8396@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_022209_686811_AF25A255 
X-CRM114-Status: GOOD (  15.53  )
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

On 11/10/21 10:14 AM, Christoph Hellwig wrote:
> Hi Jens and Ming,
> 
> I've been looking into properly supporting queue freezing for bio based
> drivers (that is only release q_usage_counter on bio completion for them).
> And the deeper I look into the code the more I'm confused by us having
> the blk_mq_quiesce* interface in addition to blk_freeze_queue.  What
> is a good reason to do a quiesce separately from a freeze?
> 
IIRC the 'quiesce' interface was an abstraction from the SCSI 'quiesce'
operation, where we had to stop all I/O except for TMFs and scanning.
And 'freeze' was designed fro stopping all I/O.

But I'm not sure if that ever was the distinction, or if it still
applies today.

And yeah, I've been wondering myself.

Probably we should just kill the 'quiesce' stuff and see where we end up :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

