Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD80C5518F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 07:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A+Quy7vDT6HjNq5ETxtsj4wpd5O+b1BVeFjCp69ybcM=; b=wouecjf5gnvvJDUxv/iAYoT+OX
	UdcliWiKMQv/SO+Lx/dA9VYN17Ca2L79oTyYy9pFK+BFAs0V3zY99Qy6XNyjhgO+D7UOWhe8QiCIK
	qSDGuweUjcl37pMwhIIuKo92KSxQsVDkJjSM6GSTXfocS5NsKeXPUQejUNdAf6j4Pmu0HS7aUGj05
	Cc8CuNn5m6Gm6Np05uaKbOsaWM0X0uv6HkkAxtuBKsCud8MX30XZtq+bPzfRP6kQdRPmUgETjMinO
	9+WJjajOkaV+nzf0csJFh2y7nZtw8NWMRWrGnVHx8ErWWhoZSSLZY8k3BX9rZrb6C78kARtT3jtdj
	G6FAqCvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr9Vc-00000001EID-1TQ5;
	Tue, 04 Aug 2026 07:24:20 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr9VZ-00000001EHf-2J3x
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 07:24:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17C533E94;
	Tue,  4 Aug 2026 07:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785828250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+Quy7vDT6HjNq5ETxtsj4wpd5O+b1BVeFjCp69ybcM=;
	b=L8I9Xe4xZ1KuxiRkwzk9VBW8io0VprkPhdm0c+rCwFDL4CruLS6xESNk/lb0yx/aZTVDZb
	GHBf2R2pUKco5hncmsSiCEdniFJ5pnjK0BUQU7zqAAHcZScwYn+js9yaKYiJhvk7Cc2D/4
	3svHS1rmXCdn4dp7ChXev1IBu1vNlxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785828250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+Quy7vDT6HjNq5ETxtsj4wpd5O+b1BVeFjCp69ybcM=;
	b=9rvDJ8hcxjYOZqr5RCx7HCb/BYcBVi4WDl8o187p0CQaPYtE+SwTYqXlvU/kL+JL11ygnU
	qI8h5yLXvlR5tyDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XKoRrIlv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3D5xaqEG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785828246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+Quy7vDT6HjNq5ETxtsj4wpd5O+b1BVeFjCp69ybcM=;
	b=XKoRrIlvKUWgjO7l/vic7IqQRt7mZVEX+DXHd0CAAlpa0grm3I1EEuivEQcaA2qds6tfLL
	MB5Kj6FL3OO8C3Gnoj1+uV8CEjKDjfkM0q599ZYIT0Y1S6/O5B15+1DjaRegDKyUqUnTOH
	Wi4KN5k+hxou078+KLyC8oE9F847aCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785828246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+Quy7vDT6HjNq5ETxtsj4wpd5O+b1BVeFjCp69ybcM=;
	b=3D5xaqEG/Et79L1237fryqIrP2qCHIA5TYrWDhm8VkU24hVkwesE/qCKJgnvTmzAmbnqaw
	Vjcn8oKXsj/Ru1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F17DC779BB;
	Tue,  4 Aug 2026 07:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U0I9OZWTcWqHGwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Aug 2026 07:24:05 +0000
Message-ID: <aa77d2d4-7e1f-4fef-a2d7-ca4aab1dc03c@suse.de>
Date: Tue, 4 Aug 2026 09:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix heap out-of-bounds read in
 nvmet_auth_negotiate()
To: Guixin Liu <kanie@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org
References: <20260804033800.3975537-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260804033800.3975537-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 17C533E94
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,alibaba.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,suse.de:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_002417_744774_DEE64AD4 
X-CRM114-Status: GOOD (  13.92  )
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

On 8/4/26 5:38 AM, Guixin Liu wrote:
> nvmet_execute_auth_send() allocates the DH-HMAC-CHAP message buffer with
> the host-supplied transfer length (tl) and hands it to
> nvmet_auth_negotiate() without passing tl along. nvmet_auth_negotiate()
> then reads the negotiate header and, for each of the halen hash
> identifiers and dhlen DH group identifiers, indexes into the fixed
> idlist[60] array (hashes at idlist[0..halen), groups at idlist[30..]).
> 
> Neither the transfer length nor halen/dhlen is validated. A malicious or
> non-conformant host can report a tl smaller than the negotiate structure,
> or a halen/dhlen larger than the array (both are u8, up to 255), making
> the loops read past the end of the allocated buffer (heap out-of-bounds
> read). The sibling nvmet_auth_reply() already validates tl against the
> structure size; the negotiate path did not.
> 
> Pass tl into nvmet_auth_negotiate(), reject a tl that does not cover the
> negotiate data plus one full protocol descriptor, and reject halen/dhlen
> larger than NVME_AUTH_DHCHAP_MAX_DH_IDS.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

