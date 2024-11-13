Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8893D41C2C
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=; b=iZPp2wDeoUI6PlnRbFPOxB4d1Q
	6Ir5b8OdMv/PRlqGdY9yL+433wMdLO7PyxO1ci1l0TwxxegR/4sGuP4wfb11ngHpuyW495zRImZVE
	m0SnMQ1Yw4SGE8mKY2z0IO6EBj75eqG1SjL7kuWhVO+8QA2GMZK/GBAGnSrFn5EnuZWddkmlrM1h6
	6MhLH3NiQ1Pg8ozey8DKUkLJcj9DLRIcyXhHpIXslBCn7qeuspZamb8ED9gncAXPo6oBNs5RP7Psm
	w91iYZ2oO+bj1IwgDzdA3rl6wEFNxnS/wijM6pTen8/sP9wmrIYLne1yEzqHRRDPKQ1n5apq4kcwH
	2+2k8t9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBA9T-00000006LgF-3FuR;
	Wed, 13 Nov 2024 09:59:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBA2c-00000006J7C-0u3D
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 09:52:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BDE61F44E;
	Wed, 13 Nov 2024 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=;
	b=jwD8zBD+7TLVq0Jl3wxTBY3/X9q6doxXBUP1NqgMdTd9YfxKvWcl3eXaRQYqrzOc56vZQO
	/ZQMQMuE1A1BuRmPQb2j5EDoHpbpGy9/oPwhIHrIh8FRH5DrUhodkWi7bRlaBLeXXku/LR
	NK0jnCyZr78TnLQiCDcFOG+eV8jhKSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=;
	b=sNoc5gOqveYMjQScvBQYt3veOBuH4Rj/SGILe63oII59XOt31Usp++u3gfFEG9VkAfeKra
	4ipvXI/OGkTeKEAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jwD8zBD+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sNoc5gOq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=;
	b=jwD8zBD+7TLVq0Jl3wxTBY3/X9q6doxXBUP1NqgMdTd9YfxKvWcl3eXaRQYqrzOc56vZQO
	/ZQMQMuE1A1BuRmPQb2j5EDoHpbpGy9/oPwhIHrIh8FRH5DrUhodkWi7bRlaBLeXXku/LR
	NK0jnCyZr78TnLQiCDcFOG+eV8jhKSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=;
	b=sNoc5gOqveYMjQScvBQYt3veOBuH4Rj/SGILe63oII59XOt31Usp++u3gfFEG9VkAfeKra
	4ipvXI/OGkTeKEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6468A13A6E;
	Wed, 13 Nov 2024 09:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9LX2F8B2NGdhFgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:52:00 +0000
Message-ID: <a04aec90-b526-4e0f-af3d-affefc4b6cf3@suse.de>
Date: Wed, 13 Nov 2024 10:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] blk-mq: remove unused queue mapping helpers
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
 storagedev@microchip.com, linux-nvme@lists.infradead.org
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-8-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-8-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BDE61F44E
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_015202_447810_2EF7EABA 
X-CRM114-Status: GOOD (  10.05  )
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

On 11/12/24 14:26, Daniel Wagner wrote:
> There are no users left of the pci and virtio queue mapping helpers.
> Thus remove them.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   block/Makefile                |  2 --
>   block/blk-mq-pci.c            | 46 -------------------------------------------
>   block/blk-mq-virtio.c         | 46 -------------------------------------------
>   include/linux/blk-mq-pci.h    | 11 -----------
>   include/linux/blk-mq-virtio.h | 11 -----------
>   5 files changed, 116 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

