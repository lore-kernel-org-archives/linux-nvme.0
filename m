Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F6CD116F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VdJrFte6sugcjCs88ZzSMsjRA0CJMm30fnCS8voTy+4=; b=c8SRYjRiKmhwPT0X3lz5NmLFC5
	w4EQm6MbMk5nEcxOXiQ19ewZz0oCwvaHrTOZi0kjwRW4CwijyU6sXibRYSvBZBuhWJvPUU4x6AYAQ
	7he9R7mO+FJuX8yTUCAr6RYGUhnTA4L8bD/6vN9YL4IX4UiVPA8PYTRrrLogb/wv3mam2tOmK2rGW
	Cw4hM8Wt1Vj+IHU2R/3XJzMiUiQLAZ0lYUIQUAXRkQQHRTyog3/WcOq6nwU3W0aafv4u8Jz8Rrphi
	1KPI+ARhEXe7uSpnVbCQ3mJLCkrxPpLVhpkBQbHbCS17dG9IBz5y5w6crcq3Y93TLyjEv987n5TLP
	QaQ4TVgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQSUM-00000005ZHT-35v7;
	Tue, 02 Dec 2025 15:40:26 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQSUK-00000005ZH3-0cuJ
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 15:40:25 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58EB4336A3;
	Tue,  2 Dec 2025 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764690022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdJrFte6sugcjCs88ZzSMsjRA0CJMm30fnCS8voTy+4=;
	b=H8+1gVffEfCo2NTqvBwiSbJdlCO9CZcWjC59dvy31Vjvr7wwr1e7EqxbPnRXi6WQOvvBzp
	9VxSHIkaMzUppbu7ez8HJNVyRcwYUBzHJO6+wgg6sBsiy1oeXe2JOtJwLpuuCrLIA/N+UR
	h42SIYWhtl4c/GeBiptNPl2UcoSCmRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764690022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdJrFte6sugcjCs88ZzSMsjRA0CJMm30fnCS8voTy+4=;
	b=IobqdJPGMeqolLVKsCdMm504yxmghHmD7da6LEIomG2bs/JbpSNiQ6zmCYsraOnKGSUmCy
	LE2okwBQ6fjPOdBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764690022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdJrFte6sugcjCs88ZzSMsjRA0CJMm30fnCS8voTy+4=;
	b=H8+1gVffEfCo2NTqvBwiSbJdlCO9CZcWjC59dvy31Vjvr7wwr1e7EqxbPnRXi6WQOvvBzp
	9VxSHIkaMzUppbu7ez8HJNVyRcwYUBzHJO6+wgg6sBsiy1oeXe2JOtJwLpuuCrLIA/N+UR
	h42SIYWhtl4c/GeBiptNPl2UcoSCmRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764690022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdJrFte6sugcjCs88ZzSMsjRA0CJMm30fnCS8voTy+4=;
	b=IobqdJPGMeqolLVKsCdMm504yxmghHmD7da6LEIomG2bs/JbpSNiQ6zmCYsraOnKGSUmCy
	LE2okwBQ6fjPOdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8CDE3EA63;
	Tue,  2 Dec 2025 15:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T/4sNmUIL2mpOAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Dec 2025 15:40:21 +0000
Message-ID: <b32a7120-d959-40ba-944f-ef9a758d2d7b@suse.de>
Date: Tue, 2 Dec 2025 16:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] scsi: sd: reject invalid pr_read_keys() num_keys
 values
To: Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Mike Christie
 <michael.christie@oracle.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20251201214329.933945-1-stefanha@redhat.com>
 <20251201214329.933945-2-stefanha@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251201214329.933945-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.834];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_074024_361454_AF336672 
X-CRM114-Status: GOOD (  11.74  )
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

On 12/1/25 22:43, Stefan Hajnoczi wrote:
> The pr_read_keys() interface has a u32 num_keys parameter. The SCSI
> PERSISTENT RESERVE IN command has a maximum READ KEYS service action
> size of 65536 bytes. Reject num_keys values that are too large to fit
> into the SCSI command.
> 
> This will become important when pr_read_keys() is exposed to untrusted
> userspace via an <linux/pr.h> ioctl.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   drivers/scsi/sd.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

