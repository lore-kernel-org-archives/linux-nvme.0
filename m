Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0165C54E90
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=; b=z8O2TJz9/+1FKvRr+E059Z2SFu
	h1ci5EjVm4i6JjW9qfOIVmiFz1hwiX4zyb8PbX215WyeNtpeWFMmKB2HKNRSHzHheJeywb7Kkk2mh
	0SY8ha3UE8/VnV0eHQIRMqCnCtc57ik7PxaEdF6gqqxT8czETP0VhGA0eGjrHaVRZkZRw53qrVwni
	cmYaNk5QvmpO5BvVkKQxUjnsfLHW1ieGDt0VRVyMAddCx4xB0OkOmwDtccJOjyWyLz+o4AIlv/yTF
	oNGmSOVHEk99h03wWe6qsBzRX0CYezPl/dOtqbWB00cApGVWh6UbOFCokiot1O77vXDjWEiGpeCsB
	ueVv35rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgi8-0000000FTN6-06Ra;
	Wed, 21 May 2025 10:30:08 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgSm-0000000FQ8I-0N9y
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 10:14:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D6BC337CA;
	Wed, 21 May 2025 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=;
	b=zO5kmzAA4npNdFOn8h1xlOap/xBbEQ7usSNhVspHr6k3aQyGWUkFOpqpCUNJVuhsiWitq5
	16V0ixnjTN+zoQY8ldyGhFZi6nxZmqCG4Tw4V9OHlvdtsC+Hac2iaTzPm6SrHE9BhPTBfV
	jZq95B7+gl7FfkecEpGzLIa6RUdbgUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=;
	b=KO5Gk4LYCOziRirBR3yFIo1o6QJMsBbOGS29WJMlwbwXAJvF4epiDX1bpk9agR9a85Cz4t
	DawXOTzObN20bHAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=;
	b=zO5kmzAA4npNdFOn8h1xlOap/xBbEQ7usSNhVspHr6k3aQyGWUkFOpqpCUNJVuhsiWitq5
	16V0ixnjTN+zoQY8ldyGhFZi6nxZmqCG4Tw4V9OHlvdtsC+Hac2iaTzPm6SrHE9BhPTBfV
	jZq95B7+gl7FfkecEpGzLIa6RUdbgUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=;
	b=KO5Gk4LYCOziRirBR3yFIo1o6QJMsBbOGS29WJMlwbwXAJvF4epiDX1bpk9agR9a85Cz4t
	DawXOTzObN20bHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B09F13AA0;
	Wed, 21 May 2025 10:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id igNZFXanLWh8TAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:14:14 +0000
Message-ID: <faacdc3b-260a-46b5-b244-ff1575d5e6ef@suse.de>
Date: Wed, 21 May 2025 12:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] sctp: use skb_crc32c() instead of
 __skb_checksum()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-6-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-6-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_031416_270839_4867588C 
X-CRM114-Status: GOOD (  10.67  )
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

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make sctp_compute_cksum() just use the new function skb_crc32c(),
> instead of calling __skb_checksum() with a skb_checksum_ops struct that
> does CRC32C.  This is faster and simpler.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   include/net/sctp/checksum.h | 29 +++--------------------------
>   net/netfilter/Kconfig       |  4 ++--
>   net/netfilter/ipvs/Kconfig  |  2 +-
>   net/openvswitch/Kconfig     |  2 +-
>   net/sched/Kconfig           |  2 +-
>   net/sctp/Kconfig            |  1 -
>   net/sctp/offload.c          |  1 -
>   7 files changed, 8 insertions(+), 33 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

