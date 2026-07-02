Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5C1C43602
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPIBHTIIs/jKSbEJtsh2IqWCQxh8MJS72IjSx947Xj8=; b=maAyqutkxw2ntMAQgGxEDH5npc
	yDTF1RjKh8VFZVZeee1F2pGC9zpnUHFIsNaXDyZHD8x9AHHhszTyXEEB6tUW+cBfgqGAslIiZSWjS
	bAUAdnMvXHFBK+w7wytdPkPKP03bEpbAPHASmKuMd3V8aPRdDxD8ncOJDPet1haIGh+xcyduDCK/z
	mTz8kgLFP3Vcpw3nnzsEU9+bQ4XTDFWWTdO+srVnDL/VHmBDxyxuF43pkaHNLjPfzu1QvJkqLcYuj
	a70BGtkpb0BBKZz/aeqG0TeUbrnVmIH8iqGYqMfsf0Gv6FswWah8ZVjcD/ew04Z4Chj+i2vjhyFQ0
	WrbwdPCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfB1x-00000003f8a-1yeq;
	Thu, 02 Jul 2026 06:36:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfB1v-00000003f7q-0fv2
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 06:36:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 516EF72B3D;
	Thu,  2 Jul 2026 06:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPIBHTIIs/jKSbEJtsh2IqWCQxh8MJS72IjSx947Xj8=;
	b=qdo4MY6rXaOxAk9Gx57e88dadOATDkIq3AKlnYJGCXtKu8ya4viHvlNp8BP78qdqAJh1oA
	wOi7PNlBeyKfpHH2bAn1LO3Csqrwbe6/jq2t8I0FHHPNf9R+35zVxf2UWLDUktpQUZi5VD
	T0e5syuyLqAY0Ymk/bahzzCUgPxm5Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPIBHTIIs/jKSbEJtsh2IqWCQxh8MJS72IjSx947Xj8=;
	b=YAoyuR+xIMSFT0wGyxR4fAyGX+x34+9Of3eclvY8JkbySq5mLarsJ++MUHuMg97UR5Ov8I
	OGo9OqklCHgALCBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qdo4MY6r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YAoyuR+x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPIBHTIIs/jKSbEJtsh2IqWCQxh8MJS72IjSx947Xj8=;
	b=qdo4MY6rXaOxAk9Gx57e88dadOATDkIq3AKlnYJGCXtKu8ya4viHvlNp8BP78qdqAJh1oA
	wOi7PNlBeyKfpHH2bAn1LO3Csqrwbe6/jq2t8I0FHHPNf9R+35zVxf2UWLDUktpQUZi5VD
	T0e5syuyLqAY0Ymk/bahzzCUgPxm5Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPIBHTIIs/jKSbEJtsh2IqWCQxh8MJS72IjSx947Xj8=;
	b=YAoyuR+xIMSFT0wGyxR4fAyGX+x34+9Of3eclvY8JkbySq5mLarsJ++MUHuMg97UR5Ov8I
	OGo9OqklCHgALCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F073B779AA;
	Thu,  2 Jul 2026 06:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RBspOdgGRmq/TAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:36:08 +0000
Message-ID: <897c7ba2-de2b-4603-ab51-8a9e12e4d794@suse.de>
Date: Thu, 2 Jul 2026 08:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: add missing NVMe documentation files
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260702034845.3066876-1-kanie@linux.alibaba.com>
 <20260702034845.3066876-4-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702034845.3066876-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,infradead.org:email,infradead.org:url,suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 516EF72B3D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_233611_355463_8121ECD8 
X-CRM114-Status: GOOD (  15.27  )
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

On 7/2/26 5:48 AM, Guixin Liu wrote:
> Add documentation file entries that were missing from the NVM EXPRESS
> DRIVER and NVM EXPRESS TARGET DRIVER sections, so patches touching
> these files are properly routed to the NVMe mailing list and
> maintainers.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15011f5752a9..7f8d52f8aab1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19367,6 +19367,9 @@ L:	linux-nvme@lists.infradead.org
>   S:	Supported
>   W:	http://git.infradead.org/nvme.git
>   T:	git git://git.infradead.org/nvme.git
> +F:	Documentation/ABI/testing/sysfs-nvme
> +F:	Documentation/admin-guide/nvme-multipath.rst
> +F:	Documentation/fault-injection/nvme-fault-injection.rst
>   F:	Documentation/nvme/
>   F:	drivers/nvme/common/
>   F:	drivers/nvme/host/
> @@ -19409,6 +19412,7 @@ L:	linux-nvme@lists.infradead.org
>   S:	Supported
>   W:	http://git.infradead.org/nvme.git
>   T:	git git://git.infradead.org/nvme.git
> +F:	Documentation/ABI/testing/configfs-nvmet
>   F:	drivers/nvme/target/
>   
>   NVMEM FRAMEWORK

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

