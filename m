Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E40C27C77
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2r7MKAg6vOI9CQHj9QnmN2izcLv5sbG9WOrlm/Tmo8I=; b=cPetk2nXvpJZ/3u5qFBUYMkNs7
	khAKfWbx7NsptGFtp8UON/bG9puR4ysuaJysMkb4bh1BpVlVWhG3v6yhzJf5S6POfW6ifVsFU6E9W
	9HzhUY4YFe7VEOqUqv51A0NfJ3NmWvh/HhFloNSZvYUTaXAy4zEeHwukKdC81d6TdsI+c64yAuAcz
	uuubHBJh3ZV6xM8Ud0m0t2Xe0jn9cwkzh0w9aLEdpva0bsLC6XyJV89NyYbfqnbA+bcOCcHCWmle7
	avLvisqB+tsjwQF01Y32eHxwx604HWsyLA+Msu6tDLEAtPOrKndS/q81+XP+f7r7kN0nhS6l67DKz
	ZnfcvxDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz39-00000008V1L-1WHE;
	Tue, 11 Jun 2024 10:48:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwfd-000000082FC-2ru6;
	Tue, 11 Jun 2024 08:15:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2r7MKAg6vOI9CQHj9QnmN2izcLv5sbG9WOrlm/Tmo8I=; b=EjquMjAPqnDlpXVcH00m3wLUma
	HBMW+BrRbmDC3qK8USUrNP5uwWh5RTsvthScUAHjP/numwEW0GvZbwHNdPVfBRbMhHLaUZYnApjM6
	7H++aYmkPnopj+oXYwmmwZH37tX9YEyCKngc1Uv1eYHKz/A3jG0D4rNuTj+h85pdFJLpD98jzWqqD
	NFMXj6PS09QhJCmduFV4M/VVYQP/Rmew1mgWadAgQ2NRMUUjTS3Wy9LVfdhBsZaMRfAZemoSJ10c6
	Hdv5be2Fzj7aTiGiNRFMx0xihRal1ywxSvLp8lbjOvoeyLYoODhr12Y11+/xtdjmyKjI9t24Sjfe3
	CMm2mAew==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwfW-000000021FH-3LzX;
	Tue, 11 Jun 2024 08:15:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E567122D2B;
	Tue, 11 Jun 2024 08:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718093749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r7MKAg6vOI9CQHj9QnmN2izcLv5sbG9WOrlm/Tmo8I=;
	b=Msni/WWtQLJC7aiHZZiIPHdLoVyj8dvs0ywS03oXyJvZOgwHsNbEtMFNNO/rKPPwIVlOTY
	c1E1VE43mVs+c82WXEHd5kGOw9r1nGpnTlv/8hcy40zaNCRaYIIWc1L4DQqC+daZ2ZJ4FO
	MR9U/2yYW0xdzUkr2wVwGOmAbopiS+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718093749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r7MKAg6vOI9CQHj9QnmN2izcLv5sbG9WOrlm/Tmo8I=;
	b=jzzrLP1ZySMJr/ZpnKFyGXiwELwFPv7+mdiJjZVwlAeIGClmXFhoxCoKqdvUasa9E9ZDL2
	k/hSZ7RUw5WKZYDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718093748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r7MKAg6vOI9CQHj9QnmN2izcLv5sbG9WOrlm/Tmo8I=;
	b=Qr6H2VmmwLwr7pMkTPc1IokvvR4M2YocGyeffhfCeL+fAvcnsb5fEvomUeoLAXoe+JGH4e
	8M3jjuywd208xFOoLE6NVO6cmyBZFpxxulLERQX4AFhnF4GlsMoMZtCanQx148T9MG9Uqk
	uPc16jDnqAa/RN/AE7ZGr8tZbqoW/Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718093748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r7MKAg6vOI9CQHj9QnmN2izcLv5sbG9WOrlm/Tmo8I=;
	b=9xNbjaTNKIkHrIWVNAWqobr8/55RzaflSr0XLs4aXDQe/ZVLfdWVr681lzwfO99s/69NMi
	1sxmXZD4BgTrA7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9054B137DF;
	Tue, 11 Jun 2024 08:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPB/IbQHaGbxWgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Jun 2024 08:15:48 +0000
Message-ID: <b586980b-0a5a-4371-bcb7-e578633ed71c@suse.de>
Date: Tue, 11 Jun 2024 10:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/26] loop: always update discard settings in
 loop_reconfigure_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-5-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240611051929.513387-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.29 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLex1noz7jcsrkfdtgx8bqesde)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_091554_371041_9CCB3BF7 
X-CRM114-Status: GOOD (  10.17  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 03:48:18 -0700
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

On 6/11/24 07:19, Christoph Hellwig wrote:
> Simplify loop_reconfigure_limits by always updating the discard limits.
> This adds a little more work to loop_set_block_size, but doesn't change
> the outcome as the discard flag won't change.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/loop.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


