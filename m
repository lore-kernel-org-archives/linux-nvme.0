Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9E5C43458
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kiQmnhROPKdcyxeb45I2DkytJG2s0wYktCvUihxigfc=; b=cUMxJJ5Pc9q4WY/RIVx17qc8rZ
	y0oKU5jmSepoJPyCziFOx/Wmgi4rsAPrrb6mFu/PHqh8/coPwZjXBP/N4e00LeQQpXskqV/28OTVv
	oxLbm1mR2zbB0hWwcfYglgjA5ee1YYom3SpRBVq9sMX/skfFvOJY8csDWasrkyeo/Z6+kf2O1hLv/
	JzTkgSKvNe+CvWrRvk3Gu7ufgw9YwMzymzXj7LQRMOXdGbrxIKUTGY5QugJe3qX59WuaZbHI5iVvK
	mZqPlwXz8rF4WctTu9QuLuG13BUbDD7BsAa2+6F7DenHf3iZktZKZ3kPrbqssl6S28hj8oCX5ryyq
	s4YEnxMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXU1-00000006B3n-2YUa;
	Fri, 03 Jul 2026 06:34:41 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXTz-00000006B3K-0n8Q
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 06:34:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4151774766;
	Fri,  3 Jul 2026 06:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783060477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiQmnhROPKdcyxeb45I2DkytJG2s0wYktCvUihxigfc=;
	b=SzorhEI5EHacKsx3N+VJnEXbM7cqPGSgLSuLH6DfanuLNsN9JeJhoxXehcfDzYdyuPYxt4
	THV9UVWjW/oOkgKqvqHHvO1Wxfb78PvIXwkEtjpPfZUY97jdm00XwmnXbuHlrs/JdWXxNB
	TYWNLtQPDVLa3XmlWKM4agMSIJ9ZkKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783060477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiQmnhROPKdcyxeb45I2DkytJG2s0wYktCvUihxigfc=;
	b=tmUoVtMoWEuHZ5ph8BebV/10io1zEYWHWxOrFeYKko6M5EM0liXSkXSLomB6gzjABrt2lV
	5hltcqiVtruClYBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783060476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiQmnhROPKdcyxeb45I2DkytJG2s0wYktCvUihxigfc=;
	b=MDSjPj+X9ubjEksASRC2CiKSxrL7y2ztxSNNMZhPmV4+yYbc0wowX8+Cb+rhnmTJG6Kmoy
	PsF54Zd6UIKaY4OpaIOLHAccvqJouH95DUGaab6RTG5D0Cvt+2se9tK4KJsmYDZ+p14+q8
	0rNUwmmRmuH7p8RZuPqvZlYzqI/BWZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783060476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiQmnhROPKdcyxeb45I2DkytJG2s0wYktCvUihxigfc=;
	b=JfVZJGTroLzJyWgktwCspZz7iMbokX06xrOo1TtY/IASSuUnG9JX70A2HsPL5v8/qKRngT
	RtRPdgO+nH/lGUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F178F779AA;
	Fri,  3 Jul 2026 06:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XbhrOftXR2qrRwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 03 Jul 2026 06:34:35 +0000
Message-ID: <7e397186-2a04-4c89-95e3-38caac320980@suse.de>
Date: Fri, 3 Jul 2026 08:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvmet: add ABI documentation for target configfs
 interfaces
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260702095541.1145128-1-kanie@linux.alibaba.com>
 <20260702095541.1145128-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702095541.1145128-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_233439_549233_4B277EC1 
X-CRM114-Status: GOOD (  10.52  )
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

On 7/2/26 11:55 AM, Guixin Liu wrote:
> Add Documentation/ABI/testing/configfs-nvmet documenting all NVMe
> target configfs attributes, covering port attributes, subsystem
> attributes, namespace attributes, host authentication, passthrough
> mode, and ANA configuration.
> 
> Each entry has been traced to its original introducing commit to
> provide accurate Date, KernelVersion, and Contact information.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> v1->v2:
>   - Group attributes by object type (ports, subsystems, hosts).
>   - Merge dhchap_dhgroup into the DH-HMAC-CHAP host authentication entry.
>   - Split the combined ANA and PI-enable entries into separate port and
>     subsystem entries.
> 
>   Documentation/ABI/testing/configfs-nvmet | 352 +++++++++++++++++++++++
>   1 file changed, 352 insertions(+)
>   create mode 100644 Documentation/ABI/testing/configfs-nvmet
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

