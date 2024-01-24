Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F9DC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V+JwYTjxATQ5OBi+Czc78pc4x6TUxpcGx/KYBJrZPTw=; b=ZD3g3mDVMnjEf+dUbTW2pvbEki
	1YKQpklCnOJzdjx4hLl2IHGTqeCN+PhwO2SUs2MQjvLkdfeRvsLF/RqXkHXohPyGVrJmWgnK6krC6
	CtBGrzVcXgwjLQ0iUEeC+rKPueCbTza9+en3yVl3437NqmIWckkZJa2ti7QbvHQm5UO42eBkPEcOT
	TUvayrhVx01FkeM2tpF5PrsvnijA+JTJDfB1keaXAEL3aaUosmRm6LXOhWFrRB7xrec8CBspctGhS
	J2U5fU9IwFRTXs0HF+U7l3T8VLDVFW+2jh1pKCf/dA7yGF8/DTW9grsR04kduCntm5Jfypot0x4ih
	GQuDy6qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfSz-0041wb-0Y;
	Wed, 24 Jan 2024 15:47:05 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfSv-0041um-2H
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 15:47:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 128B521F7C
	for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706111219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+JwYTjxATQ5OBi+Czc78pc4x6TUxpcGx/KYBJrZPTw=;
	b=NEkoz9Jo5FE8ILN1J6gdoaEwA0GBNJ71yDpNdFUpjCh2yQI89TW33FFFfplsdgru2z2n0u
	qBabZg+9dNWxcX/QgyMTlR8g+7IBrbKDlVqNCXLWeBJXl5UDJ+pOCQP59f6D+rhJjEysbq
	C5jmeYgPDqakmAfHTA4ds7sXA2XVgKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706111219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+JwYTjxATQ5OBi+Czc78pc4x6TUxpcGx/KYBJrZPTw=;
	b=rDH5vfh5sBMtevxynh4sb1L8uoIOYX3pCzXWo1MUIgV+Uu6bkhVhBabBXhDJPp0bUwab2Q
	t9N0U1/b36dg6ODw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706111219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+JwYTjxATQ5OBi+Czc78pc4x6TUxpcGx/KYBJrZPTw=;
	b=NEkoz9Jo5FE8ILN1J6gdoaEwA0GBNJ71yDpNdFUpjCh2yQI89TW33FFFfplsdgru2z2n0u
	qBabZg+9dNWxcX/QgyMTlR8g+7IBrbKDlVqNCXLWeBJXl5UDJ+pOCQP59f6D+rhJjEysbq
	C5jmeYgPDqakmAfHTA4ds7sXA2XVgKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706111219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+JwYTjxATQ5OBi+Czc78pc4x6TUxpcGx/KYBJrZPTw=;
	b=rDH5vfh5sBMtevxynh4sb1L8uoIOYX3pCzXWo1MUIgV+Uu6bkhVhBabBXhDJPp0bUwab2Q
	t9N0U1/b36dg6ODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF52C13786
	for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 15:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zch4OPIwsWU/FgAAD6G6ig
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 15:46:58 +0000
Message-ID: <fe3c18bb-36c1-4f5b-874d-1e30af6714fa@suse.de>
Date: Wed, 24 Jan 2024 16:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-tcp: question on poll return value
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <gcy35jsyvwmw37tlqpanvavqpxqmt3qylam7mtbkefolj737ef@vfswvevmfxku>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <gcy35jsyvwmw37tlqpanvavqpxqmt3qylam7mtbkefolj737ef@vfswvevmfxku>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NEkoz9Jo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rDH5vfh5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.56 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.06)[60.94%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 128B521F7C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_074701_915932_D350EB34 
X-CRM114-Status: GOOD (  16.00  )
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

On 1/24/24 16:31, Daniel Wagner wrote:
> Hi Sagi,
> 
> I am stubled across nr_cqe while debugging something else and I am not
> sure if the poll function is doing the right thing with it. IIUC, the
> blk_mq_ops poll callback is supposed to return > 0 value when it
> processed at least one element. If this is the case, than I think we
> would need to first copy the current value in nr_cqe before calling
> nvme_tcp_try_recv. The function will reset queue->nr_cqe to 0, thus
> nvme_tcp_poll will always return 0.
> 
> Does this make any sense?
> 
Sadly, not.
nr_cqe is set to zero at the start in nvme_tcp_try_recv(), and
incremented for every request received.
So we need to use the _current_ value of nr_cqe after calling
nvme_tcp_try_recv() to figure out how many requests have been
received, not the saved one (which will actually be the value
of the _previous_ iteration of nvme_trp_try_recv()...).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


