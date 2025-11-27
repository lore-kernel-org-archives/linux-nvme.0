Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123E9CFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zxdx9wJwv+VCFqevEE+EFN2rYqr2cIqWtX6a3mFRqwM=; b=1/5b7j4+ToH9aYZKrNj8sLtkUT
	u9vJwsXaK2K1GZINYHfPmdut6AJddMAszntVaBah3wcNffGht87mSrW3yDr3bVu3E7DK3kNIctFz5
	M12tJDkgGrVVOr/7oNsiG85qijN9Z9W+8u2vIX9AoIf2ocN0FUI8IG40t73JeQ1exgrKdcocxSwYt
	vr+j8yYXksOUwoIU0IVb+QgUSK/wyGxpPGG1KXmd7ul0UG38WWkVlxeZQNinQQRdiHj/DO68Mjhbc
	X2TUhQQK9BUptLFi08uyulf05h2TJZYZ3Bk/eYEAD+h3BkiZ/U4tQrXwBGBWjg7By2PNPBHjcmW05
	4WdgNwhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWwd-0000000GAjG-34mY;
	Thu, 27 Nov 2025 08:01:39 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWwb-0000000GAii-3RjL
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 08:01:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F03655BCC4;
	Thu, 27 Nov 2025 08:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764230496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxdx9wJwv+VCFqevEE+EFN2rYqr2cIqWtX6a3mFRqwM=;
	b=dWf0o7xn0pXpkSS5R3L+Gt09MXXmHDukf1Zcz6IOyKA56v2WCPsM9Zd43w0cT9VQTCjVT6
	bk5c4VqWrc+UAR9lNsh53M1iu1hJnIS4nymc0DCEkcYR2/5EaBneDVfk1e7GTc7PNnCPKh
	sfZuPZPijrOhHMmYs6MRlQNYtQ0/Zyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764230496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxdx9wJwv+VCFqevEE+EFN2rYqr2cIqWtX6a3mFRqwM=;
	b=YL4OWdCc3H95xpLDCo8/sd7Brrj+h3UtjNCzZksmAevU5OJOG3S4jQeI+ZjvC4MaO+hF8/
	MGVkM5iZFfkOGXAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764230495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxdx9wJwv+VCFqevEE+EFN2rYqr2cIqWtX6a3mFRqwM=;
	b=lGwyLJRf1m9248nTuwqS8kadtzSGduT8h9TK2qKJKSdi0LlQOriIwuFv+A/h5lxHRzl4ZO
	Se5NCmN9WBdBiQJQH2mYBzWJ0dTnFzsTrK0OyNGZUFfBfEGVERd30/6AcmthMc49ptyvY8
	qmWTRAEBLzsYbbRXUR0uZhTU32Bj2iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764230495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxdx9wJwv+VCFqevEE+EFN2rYqr2cIqWtX6a3mFRqwM=;
	b=a5wfVoKM6M7hOVdmQXIiETTm0kim72825Fv+u/+wAKYhI9ZxUibWr7prgXWGsaBsnZlxdt
	e7HyWm6i9ORC5JBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC1313EA63;
	Thu, 27 Nov 2025 08:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IkBXLF8FKGkWDwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 08:01:35 +0000
Message-ID: <55a3dfe4-3c7d-4b05-9131-a7077b1b3437@suse.de>
Date: Thu, 27 Nov 2025 09:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] nvme-auth: modify nvme_auth_transform_key() to return
 status
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-2-hare@kernel.org>
 <c01b35d7-d1a6-467e-b3e8-a1aa3d613f2d@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c01b35d7-d1a6-467e-b3e8-a1aa3d613f2d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_000138_009079_AC25E7B2 
X-CRM114-Status: GOOD (  12.93  )
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

On 11/26/25 08:39, Sagi Grimberg wrote:
> Patch title is misleading. The addition is the transformed secret output...
> 
> On 28/05/2025 17:05, Hannes Reinecke wrote:
>> Modify nvme_auth_transform_key() to return a status and provide
>> the transformed data as argument on the command line as raw data.
> 
> The patch is missing the why explanation. I mean it looks fine, its unclear
> why we need this change.
> 
To keep the knowledge of key contents inside the kernel keyring only, 
and avoid having to specify the key contents on the commandline (where
it's prone to show up in audit logs).
Also it allows for exteral provisioning of the keys; some other
application can provision the keys in the kernel keyring, and
nvme-cli can pick it up from there.

But I can put that in the patch description.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

