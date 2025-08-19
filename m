Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A9ECA0EE6
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 06:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uJVZQnJTtHM5WVqz1DzZjwvqTUK35wfa0B4arXkvsYY=; b=HRV8yfpORmnkNei1xIPqg6Hx9p
	Tb1ugPemt+1cGWbbkyYcHSWTJO073DijIfgiODj+rUpILiKi2p/0D/bYlNaYRfgzixzqrR+Sh11nu
	39CxtV69xOSBmEoKwlRRlHSpxQi2D+bgXK/uhAnl/8SdcRzGuY+hKXC/EVwbgSPBtsWkQiPKVsbJF
	4anYzAuaEjOqdi5XvqWpRQm+z5HCVlN4Tco/bxmQ+aYOeGiW7C94iwZCO12w7JndEWMu7MOHWiUh6
	oK2n/fYFEWGkWDdMMGLzX54ncI712Xp5SxgD82/JgnR+NU/MPoOUfbGd+3m6Ua5svUIOr4N+Kz+62
	Xmw/Ki7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoFZh-00000009V27-1li2;
	Tue, 19 Aug 2025 06:12:01 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoFZe-00000009V1g-3qSq
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 06:12:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3103E2124F;
	Tue, 19 Aug 2025 06:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755583917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJVZQnJTtHM5WVqz1DzZjwvqTUK35wfa0B4arXkvsYY=;
	b=P9PwTOtPvnY85qzuezF/qQQA4I7Rm/jq0UPjYivj91r1HySU5wFW67GqLvyOR8a1xGLEyx
	sdZ64mHVT5tOmq0PzNHThtoOiBxlI/B6zRauYIYeeySVga0owSzYeIkTFIZI1TgzhxUrnw
	l4JrhUPH38aoTtJi1ZdWS5VkOw6ZI7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755583917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJVZQnJTtHM5WVqz1DzZjwvqTUK35wfa0B4arXkvsYY=;
	b=08P1lI2LeV0qATJrrqVPkNKJ8c9EqihsQUK/tIOiWYiKNBGcjS11OElBxOsIgVmY3u0761
	Kav+BcTeiKNPrPCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P9PwTOtP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=08P1lI2L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755583917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJVZQnJTtHM5WVqz1DzZjwvqTUK35wfa0B4arXkvsYY=;
	b=P9PwTOtPvnY85qzuezF/qQQA4I7Rm/jq0UPjYivj91r1HySU5wFW67GqLvyOR8a1xGLEyx
	sdZ64mHVT5tOmq0PzNHThtoOiBxlI/B6zRauYIYeeySVga0owSzYeIkTFIZI1TgzhxUrnw
	l4JrhUPH38aoTtJi1ZdWS5VkOw6ZI7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755583917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJVZQnJTtHM5WVqz1DzZjwvqTUK35wfa0B4arXkvsYY=;
	b=08P1lI2LeV0qATJrrqVPkNKJ8c9EqihsQUK/tIOiWYiKNBGcjS11OElBxOsIgVmY3u0761
	Kav+BcTeiKNPrPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D72C6139B3;
	Tue, 19 Aug 2025 06:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q5D9MawVpGglDQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Aug 2025 06:11:56 +0000
Message-ID: <7d3afbe8-019d-44f4-b89b-38f4d2d1338d@suse.de>
Date: Tue, 19 Aug 2025 08:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] nvme: support <device> option in show-topology
 command
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-2-nilay@linux.ibm.com>
 <39506d0c-9205-4638-a516-0cfe0de9a8ff@suse.de>
 <742adb3b-6441-43f2-a1cd-c19b55d97ec4@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <742adb3b-6441-43f2-a1cd-c19b55d97ec4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3103E2124F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_231159_102128_0DDE9D47 
X-CRM114-Status: GOOD (  15.53  )
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

On 8/19/25 06:43, Nilay Shroff wrote:
> 
> 
> On 8/18/25 12:42 PM, Hannes Reinecke wrote:
>> On 8/12/25 14:56, Nilay Shroff wrote:
>>> Although the help text for the nvme show-topology command indicates
>>> support for a <device> option, this option has no effect in practice
>>> — specifying an NVMe device name does not filter the output.
>>>
>>> This commit adds proper support for the <device> option, enabling users
>>> to filter the topology output based on the specified NVMe device.
>>>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>>    nvme-print-stdout.c |  9 +++++++++
>>>    nvme.c              | 17 ++++++++++++++++-
>>>    2 files changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
>>> index c597b608..eb56349a 100644
>>> --- a/nvme-print-stdout.c
>>> +++ b/nvme-print-stdout.c
>>> @@ -5683,6 +5683,15 @@ static void stdout_simple_topology(nvme_root_t r,
>>>          nvme_for_each_host(r, h) {
>>>            nvme_for_each_subsystem(h, s) {
>>> +            bool no_ctrl = true;
>>> +            nvme_ctrl_t c;
>>> +
>>> +            nvme_subsystem_for_each_ctrl(s, c)
>>> +                no_ctrl = false;
>>> +
>>> +            if (no_ctrl)
>>> +                continue;
>>> +
>>>                if (!first)
>>>                    printf("\n");
>>>                first = false;
>>> diff --git a/nvme.c b/nvme.c
>>> index 27dac37b..c6779cf4 100644
>>> --- a/nvme.c
>>> +++ b/nvme.c
>>> @@ -10155,6 +10155,8 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
>>>        const char *ranking = "Ranking order: namespace|ctrl";
>>>        nvme_print_flags_t flags;
>>>        _cleanup_nvme_root_ nvme_root_t r = NULL;
>>> +    char *devname = NULL;
>>> +    nvme_scan_filter_t filter = NULL;
>>>        enum nvme_cli_topo_ranking rank;
>>>        int err;
>>>    @@ -10197,7 +10199,20 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
>>>            return -errno;
>>>        }
>>>    -    err = nvme_scan_topology(r, NULL, NULL);
>>> +    if (optind < argc)
>>> +        devname = basename(argv[optind++]);
>>> +
>>> +    if (devname) {
>>> +        int subsys_id, nsid;
>>> +
>>> +        if (sscanf(devname, "nvme%dn%d", &subsys_id, &nsid) != 2) {
>>> +            nvme_show_error("Invalid device name %s\n", devname);
>>> +            return -EINVAL;
>>> +        }
>>> +        filter = nvme_match_device_filter;
>>> +    }
>>> +
>>> +    err = nvme_scan_topology(r, filter, (void *)devname);
>>>        if (err < 0) {
>>>            nvme_show_error("Failed to scan topology: %s", nvme_strerror(errno));
>>>            return err;
>>
>> While I welcome this change, we've had discussions that
>> 'nvme show-topology <device>' really should _not_ print out
>> anything if the device does not exist.
>> Have you checked this for your patch?
>>
> Yes I checked that. If <device> doesn't exist then
> nvme show-topology would print nothing.
> 
Thanks.
So you can add:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

