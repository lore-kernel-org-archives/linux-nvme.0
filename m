Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D9FE7716A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 10:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=; b=j5qKttWaDllt8TKKBKuJSSBaFs
	m9UQpwm5Iox+O8hhxNCVN/v9/R1svRwV3COng30Bh+u9uW8IB0w155Py0mXPWRdQSd0V4pxDjorbG
	vV1naiTtlpcFbHNH5xGSIBk1dpOwSG1TQgepuDRF/RVDwY3VRojob7ngepuL74CsvHSP2BaTGQhqJ
	2ZGIKzE55Q51cXuW7P/8U4HwksSbkDDn4dR7f1r9UH9CQgFxZFcW2ZNT7xaw6PGAkpPCRMcMciT2+
	38Kj6G1Bx611VzBtgerKNbhB4KCzg9tOR1pcaj0P/L/go/xT5fqLZHX+YwtbkYG3FuKbiq0cznL1g
	9vdf1VSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUSn-0000000D37i-0XtQ;
	Tue, 17 Dec 2024 10:06:01 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNU9F-0000000Cylt-0xG1
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 09:45:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3C4021119;
	Tue, 17 Dec 2024 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734428747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=;
	b=GYdwFu/vRbqfJstJpYntcMeS3LvCafiv9n8KzT7zqQWjLdwJVWVSTdS86GTiqjPgDf9hOy
	C3m1LomlgQgUfx8DL2DrGSQbfwXRgAfwKDJUAXkQeGkF+z3FckRQR5xN9zPxewUYaZlJEO
	blq+Wo8a/a197HXGVKZXCMCCEAE8tXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734428747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=;
	b=cxWWLnaIVUM3niRFPJbE9eSQklRf2MGmb/apv8apkslXLTfLPemWA3fJaVQjaxntKvyvXH
	GIlGqPZO/QFM7wAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xXYGIO+c;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4ZR1zEDf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734428746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=;
	b=xXYGIO+cL16axWwGtXLDXhdRRj3jp9wem/c1E/kqXwr7VsS2rltRKTq16cb2qYwONWoJrf
	lKxot/IUOxG2YlwcNIJEskSkkMXdyDwdjPD+nBQ0xTaWK1EG3hbL7QYpoVgsi2C0oD/5wp
	MOFbT0wivKI5hYISbUW9qkdypA2olOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734428746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=;
	b=4ZR1zEDfWuASP31naDlhQMiFocGJoULmGWSAKs56kONqhydXIsDfnPbmCyufM6H4WVrUJr
	MHYuUQ+sk+Y+s5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CC1713A3C;
	Tue, 17 Dec 2024 09:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vdAZFEpIYWc9NQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Dec 2024 09:45:46 +0000
Message-ID: <b8dad319-8e6e-40e7-ada3-f50863315614@suse.de>
Date: Tue, 17 Dec 2024 10:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
 <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3C4021119
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_014549_412370_D3908706 
X-CRM114-Status: GOOD (  12.66  )
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

On 12/17/24 09:35, Daniel Wagner wrote:
> On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
>>> +	/*
>>> +	 * It's either a kernel error or the host observed a connection
>>> +	 * lost. In either case it's not possible communicate with the
>>> +	 * controller and thus enter the error code path.
>>> +	 */
>>> +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
>>>    		return status;
>>>    	/*
>>>
>> Hmm. Maybe checking for NVME_SC_DNR, too?
> 
> if no one complains I'll update the check to:
> 
> 	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
> 	    status == NVME_SC_HOST_PATH_ERROR)
> 		return status;
> 
> okay?

Which really cries out for a helper. But otherwise okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

