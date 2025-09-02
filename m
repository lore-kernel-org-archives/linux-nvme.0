Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50487CA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=; b=oVz09McAD2iGSYjSVSltb4so/y
	UFJWUrVv+xjDoFR+F1swmCah4d2h2oSiEpmcRCoqbjkj/0+0MVqqam/XOMJ0ahXTJFo8A2uNz9LsK
	OwSKr4MNUIotHIiRByU/2QmLcqU8z4mqcnUYoZziqpQ1mhxpsPX1Ge+LwevKy/tryFRxQgrm6KAfT
	OmPhWi0GhPa2kELHMGCu6JXKycn8iQNFQYvO/WAAyDsunYjbBraQGPzyHpzGkcV+3OnJYMZR/ae/y
	7yMw7fF5zQ6AiO+wLlLeUV3XnI6XNesTLiG/mr1FfIkpJ9euR3oW7CGylI/ToLK1PYoPGNiflpKe+
	LMzICLVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQBU-0000000HJoL-1i9z;
	Tue, 02 Sep 2025 12:32:24 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utOEu-0000000Gfvv-06LU
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 10:27:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48B7D1F453;
	Tue,  2 Sep 2025 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756808866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=;
	b=dgWiBNNguzvImDtBQyuRlvJjJdmzQZreJnZBTkws1U6sr49cTlEAcnI6mRVfBjU/+/CRn0
	kbIze76LFBYhsaI8NtoQdU6YBLHgJiXnn2Z58E2/zhr/AP5Hfi+8XRzcGO2K1ZIrpvltdE
	4Ga9H73uxIGt41xAoMTyFg/xOcbJ2jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756808866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=;
	b=mAizxFrJJL9CbzrXiszNaUfDOsjiZD2/xK+KIopjGH+N/9rWibEQb4DbSAaluJEDLGo1J+
	4s3OO6e1Wp7whoDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756808866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=;
	b=dgWiBNNguzvImDtBQyuRlvJjJdmzQZreJnZBTkws1U6sr49cTlEAcnI6mRVfBjU/+/CRn0
	kbIze76LFBYhsaI8NtoQdU6YBLHgJiXnn2Z58E2/zhr/AP5Hfi+8XRzcGO2K1ZIrpvltdE
	4Ga9H73uxIGt41xAoMTyFg/xOcbJ2jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756808866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=;
	b=mAizxFrJJL9CbzrXiszNaUfDOsjiZD2/xK+KIopjGH+N/9rWibEQb4DbSAaluJEDLGo1J+
	4s3OO6e1Wp7whoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17E6E13888;
	Tue,  2 Sep 2025 10:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hkLSBKLGtmguIAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 10:27:46 +0000
Message-ID: <15097ba9-c84f-427c-8a9e-9823385dfd14@suse.de>
Date: Tue, 2 Sep 2025 12:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] nvme-fc: use lock accessing port_state and rport
 state
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
 <20250902-fix-nvmet-fc-v3-4-1ae1ecb798d8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250902-fix-nvmet-fc-v3-4-1ae1ecb798d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_032748_213125_61BE41D2 
X-CRM114-Status: GOOD (  13.77  )
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

On 9/2/25 12:22, Daniel Wagner wrote:
> nvme_fc_unregister_remote removes the remote port on a lport object at
> any point in time when there is no active association. This races with
> with the reconnect logic, because nvme_fc_create_association is not
> taking a lock to check the port_state and atomically increase the
> active count on the rport.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

