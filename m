Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B9C5ACD9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s3fqXvzyXvSkPNqF2AQDdIHN+00Y2ULzRkpGKXJkYm0=; b=HHBb6ss595mPKbJzVkkYHgScNp
	RWPRcCVpfQCOGgdQydhtjCjsxi0pAymiZWcnuaJIXYz7wjn1ToyNkKbX9BO+m0oG7PZsH/ROcx9/b
	+stDQvpzLrcWoKxHtp7t/GD9ECXqhYBMReklP4T4jja7qtSdX5MNIi9WU+1TmFkwi1jkf+vSD0FLY
	YLlc8fMguC94qWXyBBagIAQTAXf/a1dZG+LiSTxgWXhWPTV6mC5RkQ/H0lojKa7l/2mcocJrd0MAZ
	XkXsG3xWUShD4nq28cwyCwCuZrXf5CFTmVKvJmN61EOQNH6P8E1ozI+fOx8H4iwcJg8PsiwFTgL+M
	xWofhbvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTaS-0000000FJ2x-3cO7;
	Fri, 20 Feb 2026 16:42:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTaP-0000000FJ2G-37Gd
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:42:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A0273E6FB;
	Fri, 20 Feb 2026 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771605754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3fqXvzyXvSkPNqF2AQDdIHN+00Y2ULzRkpGKXJkYm0=;
	b=0RCqZz6haT/uShD3tq596qisaIzLXVVaXXCaRuy5jywv6j5axK+8rTpwzLMuJzwdd4HKFG
	0y/zBTnpQuMHrA+8PT3fluFA8LkMAsKYfTm4OXA0BsijH89ZoMkh0o9+Fd9vnmTzVqKRbx
	hHXlU9CejlKNCJ1x88XgLO963WpBQOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771605754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3fqXvzyXvSkPNqF2AQDdIHN+00Y2ULzRkpGKXJkYm0=;
	b=DhQJPnOQKauKbwJ18xybgfQzgLDqcLuSSNd7sc5oq7RxT0+7SeyaK3DOKeXGMVxMaNbJoE
	CVbCQWE7bGsR3+DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771605754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3fqXvzyXvSkPNqF2AQDdIHN+00Y2ULzRkpGKXJkYm0=;
	b=0RCqZz6haT/uShD3tq596qisaIzLXVVaXXCaRuy5jywv6j5axK+8rTpwzLMuJzwdd4HKFG
	0y/zBTnpQuMHrA+8PT3fluFA8LkMAsKYfTm4OXA0BsijH89ZoMkh0o9+Fd9vnmTzVqKRbx
	hHXlU9CejlKNCJ1x88XgLO963WpBQOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771605754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3fqXvzyXvSkPNqF2AQDdIHN+00Y2ULzRkpGKXJkYm0=;
	b=DhQJPnOQKauKbwJ18xybgfQzgLDqcLuSSNd7sc5oq7RxT0+7SeyaK3DOKeXGMVxMaNbJoE
	CVbCQWE7bGsR3+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27B7F3EA65;
	Fri, 20 Feb 2026 16:42:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rU9kCPqOmGnsMAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Feb 2026 16:42:34 +0000
Message-ID: <8d50557c-86a8-4364-b5e7-d40b36ad9f60@suse.de>
Date: Fri, 20 Feb 2026 17:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet: lift blocksize restriction to 64k
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Abdulla Nasirli <nasirabd@fit.cvut.cz>
References: <20260220151259.20372-1-hare@kernel.org>
 <20260220153237.GB14359@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260220153237.GB14359@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_084237_931586_5ABF1CBA 
X-CRM114-Status: GOOD (  11.10  )
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

On 2/20/26 16:32, Christoph Hellwig wrote:
> On Fri, Feb 20, 2026 at 04:12:59PM +0100, Hannes Reinecke wrote:
>> With commit 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
>> we can now support up to 64k block sizes, so lift the restriction on 4k for
>> file-backed namespaces.
> 
> Still not sure this is a great idea by default.  Yes, modern Linux supports
> 64k sector sizes, but even then just for a few file systems.  And this
> changes existing setups, which will now break when upgrading the kernel.
> 
How so? There cannot be any existing nvmet setup with an LBS backing 
device, as the device will be rejected when trying to setup the target.
Which breakage do you see here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

