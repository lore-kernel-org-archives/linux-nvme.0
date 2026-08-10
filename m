Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E249C5AD4E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QU6jIejtqezyI3wpm/RPw3gvYofkHVxOVo6zjhvG6Sk=; b=A7MxCOpiHFLlxN45ECobgYcsrp
	KhddfZHTQcb+l3aUuQkVwk7UaWoFC/9eTLS5W5946zV9/S6Ns79rzE4JXfbB3mmhYYMPgELHvFDlU
	2/2kygIv7a6nHY72Wwp4uMRcYH0Gi5FxnNaZAFT/VlcDrf43t9iuyOvIE1hbRGaTActHwojcfEdgd
	Z7SweSzKDIFPWrieJSQD1mNr19VTH4j1EUZkum6wPK6DtLG3alPT4c4Sf+7jEquxatmgbQW6gS3uQ
	P0ihn7Kps3cVOWMQa+JYAE1Oq67Jqr8dNFPa7NRdN2fdzg4H0QIkGsJpaBC8OZbaajtXL245L7BiY
	oQkM2WRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtJlC-0000000B8u3-30PE;
	Mon, 10 Aug 2026 06:45:22 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtJl9-0000000B8tI-2vrK
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 06:45:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A91384459;
	Mon, 10 Aug 2026 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786344313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU6jIejtqezyI3wpm/RPw3gvYofkHVxOVo6zjhvG6Sk=;
	b=JNOkErPs1Ie3jsb+hQy8btqp+bE7wWr0E1MnKmqsOOCF7eQawwSReCn3PNJjXxrB/Vq3HY
	HBRB69WNQ3WT0qhQec+tgQneU8yOwXS7cS2pMIbmSHB7SusbGlYPowfUvzFhk9Qc7qPyFE
	4TZLYfBAoqn183z4EwrFbnRMPuzm5Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786344313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU6jIejtqezyI3wpm/RPw3gvYofkHVxOVo6zjhvG6Sk=;
	b=xMsFrJxx0rMojGPiz1X5XJINYI6C2XRZ5/923xAXiyya+5XUeK1NGZ8ACLMqKxur3r1yIM
	qGbImqDyKD7c+6CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786344309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU6jIejtqezyI3wpm/RPw3gvYofkHVxOVo6zjhvG6Sk=;
	b=kJkalOy4GvWKqYGFY5Em1nHtns/QsAbxXa7Fnqk1fGd0GLUTzQ1otYmCfelZ23/oapOxSo
	JQTWOLd1t17Ygud0L4hM+arFh0d+EVaoRByVM76shO15P9owSkm5Gn2n+2WWTv6Uze5qh3
	NIShVvG8MeLkwt2u8fXDgVIfjtaT/sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786344309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU6jIejtqezyI3wpm/RPw3gvYofkHVxOVo6zjhvG6Sk=;
	b=8K+TIEhW0dxVSMDxUNk+8srZ3T1HmSEBz0NKENDglkUITOXSl0cDlZsL1GNV+SFfPqvqEz
	C3GQJ/NmHZyP8wAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61A3F779B2;
	Mon, 10 Aug 2026 06:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xprAFnVzeWqvEQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 10 Aug 2026 06:45:09 +0000
Message-ID: <e03c40b5-175b-4fef-8dd2-ba5bfec87e75@suse.de>
Date: Mon, 10 Aug 2026 08:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] nvme-multipath: add documentation for latency I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
 kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-10-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260809100825.2014133-10-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_234519_888302_262F469E 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
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

On 8/9/26 12:08 PM, Nilay Shroff wrote:
> Update the nvme-multipath documentation to describe the latency I/O
> policy, its behavior, and when it is suitable for use.
> 
> Suggested-by: Guixin Liu <kanie@linux.alibaba.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   Documentation/admin-guide/nvme-multipath.rst | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

