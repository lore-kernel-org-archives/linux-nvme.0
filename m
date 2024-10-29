Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D168FD3A660
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkt0QJSu9FO5BuI9tT0BqaO/5tYZTAZ/s51qc0boQ00=; b=KpAAPlXJ9YsDq4wUoXxK9Zrama
	JQ22Sy9ClPeJkZLDW0i8RdZGKA7YdM/zRTvK0BaLJoq4qWKNkFolNfpR13ZTqWLBMlaoOrguRj+pn
	QINExwuuaxLDdUGMDsCqlvHpfpOTvhdPyLphelMGHVsc+/QUvxIXV0MDxI/Xatd/b7oz2A89gR8Fi
	qdHihw5ULt5S+IcnwWn9tp9NHVgncBAw1PE7Nv33HW7pv8foJeHOEQkb9yDpRTcSPsQf5/+X2/6Rl
	uljJjM8f21ES4t+EKVYOmCL3A/7QK+EDvXw9k4Ein0QcMU7mUCiaWG3xmk6EDSQ42Ag8u0XGI1pR7
	gFuBj2NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5n5Y-0000000EiRX-2OXK;
	Tue, 29 Oct 2024 14:20:52 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5n4w-0000000EiNR-31IK
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 14:20:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DD9B1FED9;
	Tue, 29 Oct 2024 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730211612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkt0QJSu9FO5BuI9tT0BqaO/5tYZTAZ/s51qc0boQ00=;
	b=WmaeORlkcqxhjc/9xpxSqhF2cNUCvkHHQ3mp7dzYu1Uy0FshLa9mg9NyINdSpv0R2BU4xN
	rlteHRfnYRY0Iloma/vJedzmIehg4oThFa+LtNox6/9ib+Pz+vOkMRv+YwjaQAZeZRGtCK
	FmbN2xWRbO9tJloEfPmMJcCdHDSQZEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730211612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkt0QJSu9FO5BuI9tT0BqaO/5tYZTAZ/s51qc0boQ00=;
	b=FwmrcJThhM2f5KfjKVLdSciGNMgR3sPNsCMQ0E1LnjGmxVyvqcp0Lxbxi7BKw7RYMCkLMX
	upDS9hF4TXit9LBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730211612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkt0QJSu9FO5BuI9tT0BqaO/5tYZTAZ/s51qc0boQ00=;
	b=WmaeORlkcqxhjc/9xpxSqhF2cNUCvkHHQ3mp7dzYu1Uy0FshLa9mg9NyINdSpv0R2BU4xN
	rlteHRfnYRY0Iloma/vJedzmIehg4oThFa+LtNox6/9ib+Pz+vOkMRv+YwjaQAZeZRGtCK
	FmbN2xWRbO9tJloEfPmMJcCdHDSQZEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730211612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkt0QJSu9FO5BuI9tT0BqaO/5tYZTAZ/s51qc0boQ00=;
	b=FwmrcJThhM2f5KfjKVLdSciGNMgR3sPNsCMQ0E1LnjGmxVyvqcp0Lxbxi7BKw7RYMCkLMX
	upDS9hF4TXit9LBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C031136A5;
	Tue, 29 Oct 2024 14:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2L2zIRzvIGczfAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Oct 2024 14:20:12 +0000
Message-ID: <fb8c72de-5ef8-499b-9fc7-d7bbe1714400@suse.de>
Date: Tue, 29 Oct 2024 15:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tls key lookup matches too eagerly?
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <065b92b0-e854-42f4-8f98-9ad89bf47295@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <065b92b0-e854-42f4-8f98-9ad89bf47295@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_072014_933876_727E5A7B 
X-CRM114-Status: GOOD (  14.68  )
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

On 10/24/24 10:20, Daniel Wagner wrote:
> Hi Hannes,
> 
> While testing my TLS handling changes in nvme-cli/libnvme, I found out
> that it is possible to insert a key with a identity of "NVMe1R01" only
> and the kernel was happy to use this key.
> 
> nvme_tls_psk_lookup
>    keyring_search
>    	struct keyring_search_context ctx = {
> 		.index_key.description	= description,
> 		.index_key.desc_len	= strlen(description),
>          	.match_data.cmp		= key_default_cmp,
>                  [...]
>          }
> 
> /*
>   * By default, we keys found by getting an exact match on their descriptions.
>   */
> bool key_default_cmp(const struct key *key,
> 		     const struct key_match_data *match_data)
> {
> 	return strcmp(key->description, match_data->raw_data) == 0;
> }
> 
> I think we should at least enforce that the identity set by user space
> fullfills the required format. Does this make sense?
> 
That is actually correct; we need to extend the match to ensure that
there is _something_ after the NVMe1R01 prefix.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

