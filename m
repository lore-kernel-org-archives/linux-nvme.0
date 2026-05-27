Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F23CD5BDE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 07:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=; b=p0hruYHbc3XcoX78iiVCnxcqTR
	qOC5NfAk0i3pAWeh2cH3c4EL06/5tgXnz8RL3Ko7/Ike4rF6mH/4md7IT/c8kDk0oFynLJKScS/JA
	kpyiXK0YV+GQ61m3GP6FWtC+LbeyuN177uSTCdc8lex9kfl5v2bXjthx06kSByC0oOfKXB36w5hjT
	1I8PBsxYWNSzxlUOOZwLfbLWU+amrrmgRFKeURy8tkrv5whq8R/F+ImL6AY22Mu52+T7D5vmxdDcZ
	jKeFkd4lTygnOuax0Wd8keDQPkBXHwtWhA1diJWFFRGSyeNoUCZuaLMoXEcOup+dYVOBVN/qPZhd8
	Hfdecd5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8T1-00000003RlE-0sIn;
	Wed, 27 May 2026 07:14:15 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8Sz-00000003Rk5-1i85
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 07:14:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16D0F6B2A5;
	Wed, 27 May 2026 07:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779866050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=;
	b=fmzXCo0Byt9IYnknQYcioyUGk1BXp2/s7S62MysYY8D6xo0ytDCeNhkL/81vPUgUas+XHh
	9oIN79KgO6h/Iw0mfeDcot4ZyS/8lSoXfHKkaB/OfMgzYtBBzAIs0BU4VHnHXxALyEz051
	C8LZEwoB/ZGF1urKBjaAyoXaJzU2kX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779866050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=;
	b=tG/GQzcfuWV0zmNUkGp3xBlUaosMjh/vMv+3eTJ/uOoPAsF70MwqmeHiSfgxtaZqdsFcFk
	ncHjipb0Tcxt2pCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779866050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=;
	b=fmzXCo0Byt9IYnknQYcioyUGk1BXp2/s7S62MysYY8D6xo0ytDCeNhkL/81vPUgUas+XHh
	9oIN79KgO6h/Iw0mfeDcot4ZyS/8lSoXfHKkaB/OfMgzYtBBzAIs0BU4VHnHXxALyEz051
	C8LZEwoB/ZGF1urKBjaAyoXaJzU2kX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779866050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=;
	b=tG/GQzcfuWV0zmNUkGp3xBlUaosMjh/vMv+3eTJ/uOoPAsF70MwqmeHiSfgxtaZqdsFcFk
	ncHjipb0Tcxt2pCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 939FA5A6E3;
	Wed, 27 May 2026 07:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I37bIsGZFmpVJwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 07:14:09 +0000
Message-ID: <7878d133-9324-452d-88f1-c9adaf9364b5@suse.de>
Date: Wed, 27 May 2026 09:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: scsi_transport_fc: widen FPIN pname walker
 counter to u32
To: Michael Bommarito <michael.bommarito@gmail.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Nilesh Javali <njavali@marvell.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Shyam Sundar <ssundar@marvell.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@kernel.org>, John Meneghini <jmeneghi@redhat.com>,
 Bryan Gurney <bgurney@redhat.com>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, David Laight <david.laight.linux@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260519190615.2761667-1-michael.bommarito@gmail.com>
 <20260520133015.1018937-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260520133015.1018937-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,HansenPartnership.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[marvell.com,oracle.com,broadcom.com,kernel.org,redhat.com,lst.de,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_001413_596102_118C65E3 
X-CRM114-Status: GOOD (  16.17  )
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

On 5/20/26 15:30, Michael Bommarito wrote:
> An adjacent Fibre Channel fabric actor that can deliver an FPIN ELS
> frame to an lpfc or qla2xxx Linux initiator can trigger a non-return
> in the generic FC transport. This is not a local userspace or IP
> network path; the attacker must be able to inject fabric traffic, for
> example as a compromised switch or fabric controller, or as a same-zone
> N_Port on a fabric that permits source spoofing.
> 
> The Link-Integrity and Peer-Congestion FPIN walkers used a u8 loop
> counter against the 32-bit on-wire pname_count field, and did not bound
> pname_count by the descriptor body already validated by the TLV walker.
> A pname_count of 256 therefore wraps the counter and keeps the loop
> condition true indefinitely.
> 
> Factor the shared pname_list[] walk into one helper, widen the counter
> to u32, and clamp pname_count against the entries that fit in the
> descriptor body before iterating.
> 
> Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Changes in v4:
> - Use min() rather than min_t(u32, ...) for the pname_count clamp and
>    fold away the temporary max_count variable, as David Laight suggested.
> 
> Changes in v3:
> - State the fabric-adjacent threat model explicitly in the commit
>    message and clarify that this is not local userspace or IP-network
>    reachable.
> - Use min_t(u32, ...) for the pname_count clamp, as Christoph suggested.
> - Use FC_TLV_DESC_LENGTH_FROM_SZ() instead of open-coding the descriptor
>    body length calculation.
> - Factor the duplicate LI and peer-congestion pname walker into a common
>    helper while preserving the LI-only host-stat update.
> 
> Changes in v2:
> - Drop the redundant cover letter shipped with v1.  A single-patch send
>    does not need one, and the v1 cover carried stale draft markers.
> 
>   drivers/scsi/scsi_transport_fc.c | 77 +++++++++++++++++---------------
>   1 file changed, 41 insertions(+), 36 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

