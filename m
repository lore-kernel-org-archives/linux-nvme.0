Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A43C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQHOR2T/KjHc9JhS1u+F07RUESGQ3M1PfLBeUgSV2gk=; b=tWjSu/rffH7Mc4ZSao9G5zKFFq
	Lz5dbbi8DeEIShG7IPfgW7s6w788bOV38sXVWSHO/WKbY/Iz4TM9w/wMbvROzN73wL84vAXofhl5A
	g3n9mHOkzAhevNdUYZTi1lyIxeDse961WoJeD15XEGDGRg/4m6eDO6b4HAUk/RpXHykR1DGDhN3CC
	Z2ppU0hEuaP26J2EPZl8oqUUFwHZis6i0bN2DpGJJ3K1rdApZNLayyr2jYU6KoVZqat0wjnGAFOZ1
	TVjffxapuQYL131VDy8PFeqr02T26WRoIgLnTQBRGHFvb8ZldYh+yWL7NRTkdkpTHbdZvaWJp4jxz
	sWHok+iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77AM-00000005xwp-4A22;
	Tue, 22 Apr 2025 06:31:34 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7765-00000005x3E-3fPl
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:27:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42EA11F7C1;
	Tue, 22 Apr 2025 06:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQHOR2T/KjHc9JhS1u+F07RUESGQ3M1PfLBeUgSV2gk=;
	b=W5azrC7qLwvYSHzwMxj0i8iLs/jKTu+Juh9g5TWocMq/A+fL8u1s1JYuXknkfJW0e6ufZL
	4tmH1RUNJgn98bY0LeMztvVVXBsD/7igjJmBNIw7iLl0Mz3x4SnKbk7LD9USKHgMlrXVFU
	1SlVjo/JWY9pc40JY/c+Q5FFDBbZ2LA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQHOR2T/KjHc9JhS1u+F07RUESGQ3M1PfLBeUgSV2gk=;
	b=gFTVNeEaq0boohitY7iwPSCUbw53Mmha+KTsM2kD1W8W+bmZs0Sgs/HU/aRfxHGRN8/TtQ
	RaZmwGdbALcjMwDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lbfbx5dx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9n4S+tr9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQHOR2T/KjHc9JhS1u+F07RUESGQ3M1PfLBeUgSV2gk=;
	b=lbfbx5dxVmrXLq06MslJMEbTbIYXpO72Bv5BsLFOmOMXBJ9lP5rJfFqHHiytZ84E3DJfpw
	bgtBviDW5GiehkNXbNk+9uZp54hj21InG4/la7Mc407QddSXhuTN6W2gIHXcQPvPUyrW22
	47IEHLLjvcP5Ifb83JU4UW1bLgxgCoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQHOR2T/KjHc9JhS1u+F07RUESGQ3M1PfLBeUgSV2gk=;
	b=9n4S+tr9iw8zU/RxGo25dAN4fmPt9YyYZQSbfnPk7Eo/kxWjnP3Zz6C1W0UpdrBIWb1Oi1
	UUAYa6u/Jn/njoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04741137CF;
	Tue, 22 Apr 2025 06:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AQK7Oro2B2hiKAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:27:06 +0000
Message-ID: <18afd11f-efcf-487b-93ab-086b26e9844d@suse.de>
Date: Tue, 22 Apr 2025 08:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/4] tree: add attribute numa_nodes for NVMe path object
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250417135951.239447-1-nilay@linux.ibm.com>
 <20250417135951.239447-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250417135951.239447-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 42EA11F7C1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,libnvme.map:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_232710_065485_6990FE6D 
X-CRM114-Status: GOOD (  13.07  )
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

On 4/17/25 15:59, Nilay Shroff wrote:
> Add a new attribute named "numa_nodes" under the NVMe path object. This
> attribute is used by the iopolicy "numa". The numa_nodes value is stored
> for each NVMe path and represents the NUMA node(s) associated with it.
> When the iopolicy is set to "numa", I/O traffic originating from a given
> NUMA node will be forwarded through the corresponding NVMe path.
> 
> The numa_nodes attribute is useful for observing which NVMe path the
> kernel would choose for I/O forwarding based on NUMA affinity. To support
> this, export the attribute in libnvme.map so it can be accessed via
> nvme-cli.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   src/libnvme.map    |  1 +
>   src/nvme/private.h |  1 +
>   src/nvme/tree.c    | 10 ++++++++++
>   src/nvme/tree.h    |  8 ++++++++
>   4 files changed, 20 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

