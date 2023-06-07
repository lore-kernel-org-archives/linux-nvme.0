Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242B7C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Udh/Vtqb23Sw8g+BkC8HMo4Q973SRGdJCkPyY7KWLNs=; b=J4IkxP7vBlpkAkj6ZaR/DdExIA
	1rxzq93iARj6ojhHJCdcqtrZ+pbQyvxr5gMn5Qw4jyBN82UZq7FkNzHxwQxSaVtZd7SOtvt0cnh97
	GEVDWSpkMgieDTjiPXQ4PY3LSnE88464NNTeimpZaK3q9w4ltaXdS6PThzitpgRbqWnJyzHkit2aC
	t2Oy0kVpV2LM0ZfySJ+tI/uL/teV4zfW7nyi9Z/6eDKEtCGVomiyoBNAaNnPhRHGf/qFui+ttdDKw
	GdOhqWuYeA6zdY207oFRIAzt27JW8rWIfAjyWZVaKLwn4bywl92JAj4XoG0i3orEv7Es1JOLj8i+2
	TxsGK4Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6t3u-0064l8-0o;
	Wed, 07 Jun 2023 13:18:54 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6t3q-0064ju-1o;
	Wed, 07 Jun 2023 13:18:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B2C71FDAB;
	Wed,  7 Jun 2023 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686143929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udh/Vtqb23Sw8g+BkC8HMo4Q973SRGdJCkPyY7KWLNs=;
	b=AG50lh6cNYbwFkDgaT6ESY/6kXvuXC7sDHKKcw8pqjJuajtZFb5iJMjU+bUHLK8tmhUW/e
	3ggaoVJAuSiXjFOzMcU4WcpaNZCGv6jm+/3d19A6Snff4yAvXS0PckIuYdEhm38+y+iNCH
	we5Xow+88Kal0HjgD/hcxHzey97Vt2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686143929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udh/Vtqb23Sw8g+BkC8HMo4Q973SRGdJCkPyY7KWLNs=;
	b=yrTu3ioEdQb/jvgg+opgbJOkJi/9oj9MdczoHd3QPBmppQ7hl9wTr/b/RUlZdWJ4DBVXYd
	uqhxaF5C7dZDCxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3BEE1346D;
	Wed,  7 Jun 2023 13:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xHLBMriDgGQvYwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 13:18:48 +0000
Message-ID: <82a4143b-f800-09b9-98f2-6cda791877da@suse.de>
Date: Wed, 7 Jun 2023 15:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/31] block: share code between disk_check_media_change
 and disk_force_media_change
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
 Josef Bacik <josef@toxicpanda.com>, "Md. Haris Iqbal"
 <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-um@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-9-hch@lst.de>
 <30183892-dce6-6946-2f7a-1bc693a657a2@suse.de>
 <20230607122131.GB14579@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230607122131.GB14579@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_061850_752423_DFACFF6D 
X-CRM114-Status: GOOD (  11.90  )
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

On 6/7/23 14:21, Christoph Hellwig wrote:
> On Wed, Jun 07, 2023 at 02:19:00PM +0200, Hannes Reinecke wrote:
>>> -	return true;
>>> +	return __disk_check_media_change(disk,
>>> +			disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
>>> +						DISK_EVENT_EJECT_REQUEST));
>>
>> Can you move the call to disk_clear_events() out of the call to
>> __disk_check_media_change()?
>> I find this pattern hard to read.
> 
> I suspect you've not done enough functional programming in your youth :)

That's why I said 'I find'; purely personal preference.
If you're happy with:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
(In my youth? One is tempted to quote Falco: "If you remember the '90s 
you haven't experienced them...")


