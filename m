Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EF8C0218C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 07:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OwdWKS0EDGZiF3o0iauIuORGxoty85s1iEMxd3L2BKo=; b=41LJMVzGG0ohfF9WA8RrrU24zp
	yRfRFVBM1rHVa3ZsuwgyYh9s94pz/xI+PsUE5Xjmd8sCJiNQ7eEfNwCAiYKmtQZAqrRCxmWDooCif
	7Mtoq55kqL2R7eFl+yjg24zxEf3B5h4H75OpZ02GvbW6jrWbHyKbd40pEUrFxQxyXe+ZizjcAStn0
	nxQWMiY4LzcLEAOqUGowQm3kE3AlX+NeL6MmAdumr5+Zi0qcL8Q1YXojUTQ2PeexewcEP5WNdZROP
	4LzsqHjd2w/ldq1VmIGZ26JUznbUuQsHlR2aBHeyN/RIsW+3p9tZ/i2FpElapXscBjnQLwCEK1+FU
	7IaHptvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcJ84-00000001lQK-0jiL;
	Mon, 27 Jan 2025 07:01:52 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcJ7y-00000001lPs-0SUv
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 07:01:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8B261F38F;
	Mon, 27 Jan 2025 07:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737961303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwdWKS0EDGZiF3o0iauIuORGxoty85s1iEMxd3L2BKo=;
	b=WVyQtFTxRqTXTyT0ukNrykxCsOclgCPoFc6mqoYFVdBKpJxmg7EaBtZScEd71Ry1/Go+qV
	HXroXbCGIADBdhliHNWUc2yZ6cl/eOeCNZvg7N7zz4+9SkQdRoo/PAjxmKH3JDlormDdus
	U6HgJEoRWEVLvMRQNO6zjVFreDg9BFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737961303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwdWKS0EDGZiF3o0iauIuORGxoty85s1iEMxd3L2BKo=;
	b=X24dcUwkl0MGtwSMQYAEyhZbKZM+7NCIFnYPXyAEfW5fn7LGagCBl4OI9P+JawH03lmQ42
	OWnYBlMVAVv+DbDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737961302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwdWKS0EDGZiF3o0iauIuORGxoty85s1iEMxd3L2BKo=;
	b=XBCsjcjP6b/hQrQtpT7JZHTzdloQb8VDxroIdrSMKyYUsnWLT3HPLlPnz7GAEsSjBrq3xb
	X/uSN8wIKxlasT2bF5/iF2KfujhANut/W5TC/qNdXHcCsb+VU/RPVbO987KYBrH6b2SbHD
	nOGCA4pnd9b+Bw5agYJ7FGtOwHwChrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737961302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwdWKS0EDGZiF3o0iauIuORGxoty85s1iEMxd3L2BKo=;
	b=VG+f8ua85nyxa7XXNGEl0JEr1nR9OC4ywX2dIQIafQld33nxNq9I7SRs2rCLkoPowa3EG0
	pW+lL17oDLtgvJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7F7413715;
	Mon, 27 Jan 2025 07:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r8E+J1Yvl2cDAwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Jan 2025 07:01:42 +0000
Message-ID: <38336b38-8d48-4672-b6b2-6e289a4d8dc4@suse.de>
Date: Mon, 27 Jan 2025 08:01:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests] nvme/058: detach loop device after test finish
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250124074753.9802-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250124074753.9802-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_230146_304083_BBEB6625 
X-CRM114-Status: GOOD (  13.51  )
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

On 1/24/25 08:47, Nilay Shroff wrote:
> The nvme/058 creates three (temp file backed) namespaces and
> attach each namespace to a loop device while starting the test.
> However it never detach those namespaces from the loop device
> once test finishes. Ideally, we should detach loop device from
> namespace so that the associated loop device is later destroyed
> and its resources are released. This patch helps detach each
> namespace from its associated loop device after test finishes.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>      - keep blkdevs, which are used for setting up ns, in an array
>        and then later access the array to free/detach each blkdev
>        (Shinichiro Kawasaki)
>      - use longer option name instead of short name for readability
>        (Shinichiro Kawasaki)
> ---
>   tests/nvme/058 | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

