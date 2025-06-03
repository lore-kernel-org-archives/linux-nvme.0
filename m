Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17B6C5AD49
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 06:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sNiUWbpBKLVPSuRvpXsHLgmz/EnmxqeBRCbUvrobvRw=; b=5D/NqOeAMh42WkmltM7paZgaeL
	y8sPh+RNWW4bIpAnmbKm6prLgbNDBimMn5zmTiGNwuXBZf7Jlb5tbbWDmDkoFVTe4pb2IsCUTVSk1
	pT6HyPJASy+WBI4L38kZOlCafvJRKlzzP0TuxY0dYz2V7us0neLt3ep7ifwTmBR2FNs2yVJD8qQOI
	xOAJ/AG0UwLt2wjkSS9sY4f2yAIfDj6vrr19WEag4/X5Guf7Zfph7uf89pdgW1XRjg782gVAOd6nS
	iyeeGYQ1AivivNvCI9pIkIiulv1h01uIzac9cqTskVxRisC2wNqvIFKvn9bK/NcXAyUSM+mzlk8Ef
	Xp4glTNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMKrh-00000009utd-177U;
	Tue, 03 Jun 2025 06:11:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMKre-00000009ut3-3d6l
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 06:11:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3259A218A3;
	Tue,  3 Jun 2025 06:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748931069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNiUWbpBKLVPSuRvpXsHLgmz/EnmxqeBRCbUvrobvRw=;
	b=g/ZwLY+sxMFhrMNxudmLo24cP5TOSUUcCfUjrKD62HrpO6sc34e+YnHi76D5KsYEHc3L5k
	VNBIrH/X6FOoDV08bv0Rhqq5FCA2AQdTbe+yuYEeeiHEovl0s4FY23jeAom8kMwV+hxjIf
	rcrzlfh5DNrxIxG+PM71WtH9p2NoEPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748931069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNiUWbpBKLVPSuRvpXsHLgmz/EnmxqeBRCbUvrobvRw=;
	b=gQfyHZi7cFbMuD/3Lv0MwI9VP9JN/0vvtzKY4VnfbYY5eq3+OLI1apRW7VUWDYG2ObRv1X
	qGv9+G0jDNCttPCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GrWEMj1G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+Oz3SobK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748931068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNiUWbpBKLVPSuRvpXsHLgmz/EnmxqeBRCbUvrobvRw=;
	b=GrWEMj1G2VCMOt28u388pOaI9W0zv+FMnqIQRaIgURrJ5LO10uQkeaXDKSjuY3y6qAMo/v
	XqixC+/aSPAdDzGxP4G/tiKzGHM2c/Bj0qhsEd0WX46AXtfa8PDu/cN0BiLz1+HwSgGWN3
	wPVKLybA4jq98j2Wouk85Z4NZpsod1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748931068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNiUWbpBKLVPSuRvpXsHLgmz/EnmxqeBRCbUvrobvRw=;
	b=+Oz3SobKXBALWTWytDixqmFT3mqAoQNX7uyXo+2ex6K29ZqnWRT70qFOKQ6U5JU5AfKbjy
	q6SR7CiZrUYWmOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E917213A92;
	Tue,  3 Jun 2025 06:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oc7vNvuRPmjndQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Jun 2025 06:11:07 +0000
Message-ID: <746083d5-d8c0-417d-b9ce-de636b7a676d@suse.de>
Date: Tue, 3 Jun 2025 08:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] nvme-keyring: add 'dhchap' key type
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@kernel.org>
Cc: hch <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-3-hare@kernel.org>
 <2hmqk26l6nsbgpwjgumec7burdg6vmujq2tbo45d3zcdehhowh@fpni4uyjrnzl>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2hmqk26l6nsbgpwjgumec7burdg6vmujq2tbo45d3zcdehhowh@fpni4uyjrnzl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3259A218A3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_231111_052996_8CAF6FA2 
X-CRM114-Status: GOOD (  18.42  )
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

On 6/3/25 02:32, Shinichiro Kawasaki wrote:
> On May 28, 2025 / 16:05, Hannes Reinecke wrote:
>> Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
>> Keys are stored with a 'user-type' compatible payload, such
>> that one can use 'user_read()' to access the raw contents
>> and the 'read()' callback to get the base64-encoded key
>> data in the DH-HMAC-CHAP secret representation.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/common/keyring.c | 266 ++++++++++++++++++++++++++++++++++
>>   include/linux/nvme-keyring.h  |  22 ++-
>>   2 files changed, 287 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
>> index 32d16c53133b..a58c93c6d495 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
> [...]
>> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
>> +{
>> +	struct user_key_payload *upayload;
>> +	size_t datalen = prep->datalen, keylen;
>> +	int ret;
>> +	u32 crc;
>> +	u8 version, hmac;
>> +
>> +	if (!prep->data) {
>> +		pr_debug("%s: Empty data", __func__);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s", &version, &hmac) != 2) {
> 
> I built the kernel at nvme-6.16 branch at git hash bf4d87cba2d7 applying
> this series. Then I ran the blktests test case corresponding to this series,
> and observed the BUG KASAN slab-out-of-bounds below [1].
> 
> The sscanf() above has three "%"s in the conversion format string, while it has
> two following pointer arguments. I think this gap between the numbers of "%"s
> and the pointer arguments causes the BUG. I removed "%*s" from the format
> string, then the BUG looks disappearing.
> 
Well ... '%*s' translates as 'ignore following string argument'.
So there _might_ be an issue if there is no following string argument.
And actually this was meant to be a 'cheap' way of stripping and pending
newlines after the key.
Guess I'll rewrite that to actually strip the newline.
Thanks for testing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

