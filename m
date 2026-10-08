Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B25BCA6007
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 07:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GwjPw1mZUywYnKuWFhbnJ8X46JLzymUOdUflsOOTtw4=; b=1ZDiCc4ZQS29Wo9EhShowJPI63
	JYStiezHe7Pi5IDRCBvxLmPl8w56vROqqQo7WMeGaZl2H7su7fNqpFJU/RM+Suoq9lStQV1eCXNZ8
	1f8e2/M/aE1bFRpudsQdooyPrHsjsfQFS/LWPKMlfiltzvd57pttEL89etFk6XNbgZF9nxYV0Jo4h
	Xawa8VrHEuQXjQhw0yXASjwywjQn9GuUKFri3p9y4AyHMiXZTlG2kyXn6D6CNPZPqCaE6PPSbZzNv
	2n67CEOEsKclBwN/TRghRr5u/6WkiOih0IQUjB92q7d8JSS+pS+74nSRvn0LMC2FiokmWDYLchheU
	0p5ywYuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEiDr-00000003hcI-35pt;
	Thu, 08 Oct 2026 07:07:23 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEiDp-00000003hbE-28Xd
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 07:07:22 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BBDC1F786;
	Thu,  8 Oct 2026 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791443238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwjPw1mZUywYnKuWFhbnJ8X46JLzymUOdUflsOOTtw4=;
	b=pttfKnLCpk8vXshpeOFF21/8arvxxZE+LBWUTfS0mYL07v3Zx//9YMCP58V/CI2J+AiPlY
	iki1O4AVlMAHlmPyQDf7lAwKh5plPax8W9e7oPnSFCNw6QbLonW6SXXsxJFZy1yXnrhO+3
	SNH3Zf16Gkp5PhgkEt67c9/+il5/4zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791443238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwjPw1mZUywYnKuWFhbnJ8X46JLzymUOdUflsOOTtw4=;
	b=GQkTiTsS+E456gCn6w3l9jIdqyxk5qAGvskqcWRcv3iXKLFz8aIO/mfEdaDKzSX3Fb3U22
	Y79oTlqmHoJ8KEDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pttfKnLC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GQkTiTsS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791443238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwjPw1mZUywYnKuWFhbnJ8X46JLzymUOdUflsOOTtw4=;
	b=pttfKnLCpk8vXshpeOFF21/8arvxxZE+LBWUTfS0mYL07v3Zx//9YMCP58V/CI2J+AiPlY
	iki1O4AVlMAHlmPyQDf7lAwKh5plPax8W9e7oPnSFCNw6QbLonW6SXXsxJFZy1yXnrhO+3
	SNH3Zf16Gkp5PhgkEt67c9/+il5/4zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791443238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwjPw1mZUywYnKuWFhbnJ8X46JLzymUOdUflsOOTtw4=;
	b=GQkTiTsS+E456gCn6w3l9jIdqyxk5qAGvskqcWRcv3iXKLFz8aIO/mfEdaDKzSX3Fb3U22
	Y79oTlqmHoJ8KEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E8713354;
	Thu,  8 Oct 2026 07:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cx66JCVBx2qjZAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 08 Oct 2026 07:07:17 +0000
Message-ID: <0632ec1e-dcd3-42f9-bd0c-a809a6f6db09@suse.de>
Date: Thu, 8 Oct 2026 09:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: auth: validate DHCHAP secret before stopping
 authentication
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
References: <0602191a-81ce-4f8a-90d0-b47ba2bc36ac@suse.de>
 <20261003125115.2523-1-sreekuttan2156239@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261003125115.2523-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1BBDC1F786
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_000721_841504_1FA205A0 
X-CRM114-Status: GOOD (  18.30  )
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

On 10/3/26 2:51 PM, Sreeraj S Kurup wrote:
> Hi Hannes,
> 
> Yes, I agree that stopping the currently running authentication when the admin
> requests a new one is intentional.
> 
> The issue I was pointing out is slightly different: if the new key is invalid,
 > we never actually get to the point where the new authentication can be
 > started again. "nvme_auth_stop()" has already stopped the existing
 > authentication, and the parser returns an error before the restart
 > path is reached.>
> So the question is whether writing an invalid replacement key should
 > leave the previous authentication stopped, or whether the key should
 > first be parsed/validated and only then replace the existing
 > authentication state.>
> If the intended semantics are that an invalid key write should not
 > disturb an already running authentication, then moving the validation
 > before "nvme_auth_stop()" would make the operation effectively
 > transactional:>
> validate new key
>      -> error: leave existing authentication unchanged
>      -> success: stop old authentication and start with new key
> 
> If, however, the intended semantics are that any attempted replacement
 > stops the existing authentication even when the replacement is
 > invalid, then I agree that the current behaviour is intentional and
 > the patch doesn't fix a bug.>
Hmm. Actually, I'm not sure. Both sides have something going for it.
Stopping the transaction first follows the perceived will of the admin
to start a new authentication. And that will is arguably independent
on the question as to whether the new key is valid.
But at the same time one cannot start a new authentication if the key
is invalid.

So I don't know. Let me think.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

