Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EABC28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwVUhdlYTIPsRFnJXKzm8rQ2XZbwVn7BV/kDQ+KUUbo=; b=Mq5ecTN6zMXjMng8t1RWhUocOt
	AILSwh7lM4jqffbKWHasiUhwrPHwX98CrlIOSCUCJ6BqsMz/IkNL2VzfKV+j/x/fRpyK5/fMvoBeD
	pMgKpv4CpALL+fPTUgNbyY5TbqtENjfueoQT3ODUMGdz43Q9/duiOChMdJ7kV1A9vMDQTAAoetGGc
	E8kTWfdP68QRaFVsZ71IyyCK2VSLFWo2D4OUv6Spaq1u+NoSeG/nh05uzAoBU6A8fmuH9KCaTEqSg
	HfvGbJgAEVAlsSRki9ygIclwuL8LWLF89KW9W9httOTbYp+AuVYRvVlkR/3YNQC8Dq0tYAJ42u2c3
	muN+padQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzyjY-00000006LQN-3F22;
	Wed, 02 Apr 2025 14:06:24 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzyjW-00000006LPA-1kHG
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 14:06:23 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D35F2119A;
	Wed,  2 Apr 2025 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743602779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwVUhdlYTIPsRFnJXKzm8rQ2XZbwVn7BV/kDQ+KUUbo=;
	b=uHAvHlMUBgfdKyqrmmNu2h6hAMmo3ltSJEoBpUuO6eGtJWDcRRBDPAwY11LomrU4a41Mms
	rDzqUTErNFWrlbhb7MllFi7JnfQDh6AYFINnfr0Y2MeC1gM0GuKrHyldyZY7rcBJBkcGxD
	3ZV0TEH2k0oM3zPuhcbXYRbtwLzBIMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743602779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwVUhdlYTIPsRFnJXKzm8rQ2XZbwVn7BV/kDQ+KUUbo=;
	b=uRGyNfEKoEM4z2TsLayc+dXXpeN9+o5Jv+yitLjxsBMLFDEethf498MJsijJzM4yMZxpew
	dzqQnHN4NalSrVDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uHAvHlMU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uRGyNfEK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743602779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwVUhdlYTIPsRFnJXKzm8rQ2XZbwVn7BV/kDQ+KUUbo=;
	b=uHAvHlMUBgfdKyqrmmNu2h6hAMmo3ltSJEoBpUuO6eGtJWDcRRBDPAwY11LomrU4a41Mms
	rDzqUTErNFWrlbhb7MllFi7JnfQDh6AYFINnfr0Y2MeC1gM0GuKrHyldyZY7rcBJBkcGxD
	3ZV0TEH2k0oM3zPuhcbXYRbtwLzBIMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743602779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwVUhdlYTIPsRFnJXKzm8rQ2XZbwVn7BV/kDQ+KUUbo=;
	b=uRGyNfEKoEM4z2TsLayc+dXXpeN9+o5Jv+yitLjxsBMLFDEethf498MJsijJzM4yMZxpew
	dzqQnHN4NalSrVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C5D13A4B;
	Wed,  2 Apr 2025 14:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9uMeBVtE7WebIwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Apr 2025 14:06:19 +0000
Message-ID: <d4014616-88ad-4963-8385-e38fc9437fc0@suse.de>
Date: Wed, 2 Apr 2025 16:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/18] nvmet-fcloop: replace kref with refcount
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-2-05fec0fc02f6@kernel.org>
 <e94a7fab-3811-449b-9999-7641b9274b07@suse.de>
 <709b524c-7191-451f-81ea-8bad8f1c6a16@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <709b524c-7191-451f-81ea-8bad8f1c6a16@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D35F2119A
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_070622_596688_B2EDC414 
X-CRM114-Status: GOOD (  11.58  )
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

On 4/2/25 16:03, Daniel Wagner wrote:
> On Tue, Mar 18, 2025 at 11:56:50AM +0100, Hannes Reinecke wrote:
>> On 3/18/25 11:39, Daniel Wagner wrote:
>>> The kref wrapper is not really adding any value ontop of refcount. Thus
>>> replace the kref API with the refcount API.
>>>
>>> Signed-off-by: Daniel Wagner <wagi@kernel.org>
>>> ---
>>>    drivers/nvme/target/fcloop.c | 37 +++++++++++++------------------------
>>>    1 file changed, 13 insertions(+), 24 deletions(-)
>>>
>> Can you split this in two, one for the nport and one for fcpreq?
>> That way it's easier to follow what has been modified.
> 
> Do you still want me to split the patch? You and Christoph have sent the
> Reviewed-by tag after this review.

Ah, no, Don't bother.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

