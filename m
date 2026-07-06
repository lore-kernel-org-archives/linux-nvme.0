Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64A5C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BJdVkdLEOV/bPk9H6jHawThDq8htbHuNwzFUUFSYBIY=; b=dT87wCpiY48lLloaui/8FWg/zJ
	8OYak5KWXOh/WGIDSvggGttGmQfwiv+XB7cf78Pjc0YKBunO+5aIpRx8RySeJbY1GQonwD/E/6H/y
	dUO4iiAz2X4Za0x4HM4KGoCIwe+TPq9K4BFVPGj4o7EKqBpQP4FFPznbzRtHV0THyOa+CyuwGeOx8
	iu3Zd2abG/8agMNQ9Mohd6/CIA6D0MgW3mQCykPZq8X5i4e3DWSrncADIw2kzp0vhlxSn7qb4FEgs
	XEqhavpK46SikfXglzAe7rMo0xUi/mHfahp7RnKSFwhxNuc0tKCx+3p/lD2SF9pvkM/mx2v6aExTw
	NNSoYrPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgeEy-0000000Bllo-2AKA;
	Mon, 06 Jul 2026 07:59:44 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgeEw-0000000BllS-1cRI
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 07:59:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3504D756D7;
	Mon,  6 Jul 2026 07:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783324780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJdVkdLEOV/bPk9H6jHawThDq8htbHuNwzFUUFSYBIY=;
	b=BzTiFUwcZXwxDlpGBZBe57gMcDZmTMOqi5aUWpKNNSH1AiM9RXsoOfeqghz+uQj2B7pbUW
	j5YgushuKYZTtjovZjlrqasNNqB0xciuGkS62uSRA9tA3hDoGK9INcolIP3/FlITAYIUEK
	zviWmKIz/irenrIXM92Jgxx+WCmu4V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783324780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJdVkdLEOV/bPk9H6jHawThDq8htbHuNwzFUUFSYBIY=;
	b=ziMHU/1KpacU/Juy4WQKilhqgeh+EIFRFYoXJhtJwm2brERgJuJ/ZEaHlFv1tWMjciJg/O
	8w1UmmwDaHQ4SiAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783324780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJdVkdLEOV/bPk9H6jHawThDq8htbHuNwzFUUFSYBIY=;
	b=BzTiFUwcZXwxDlpGBZBe57gMcDZmTMOqi5aUWpKNNSH1AiM9RXsoOfeqghz+uQj2B7pbUW
	j5YgushuKYZTtjovZjlrqasNNqB0xciuGkS62uSRA9tA3hDoGK9INcolIP3/FlITAYIUEK
	zviWmKIz/irenrIXM92Jgxx+WCmu4V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783324780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJdVkdLEOV/bPk9H6jHawThDq8htbHuNwzFUUFSYBIY=;
	b=ziMHU/1KpacU/Juy4WQKilhqgeh+EIFRFYoXJhtJwm2brERgJuJ/ZEaHlFv1tWMjciJg/O
	8w1UmmwDaHQ4SiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20A18779AA;
	Mon,  6 Jul 2026 07:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g0ZtBmxgS2rVEAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 Jul 2026 07:59:40 +0000
Date: Mon, 6 Jul 2026 09:59:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvmet: add namespace-level debugfs for reservation
 state
Message-ID: <78c97eb1-a69e-4f14-977d-f3950db1a0e2@flourine.local>
References: <20260622104418.2070277-1-kanie@linux.alibaba.com>
 <5b2a11e8-bb66-4111-9090-bcdbb0458fcf@flourine.local>
 <f0c00d47-0f33-4c9a-84ea-2fb82cd4d102@linux.alibaba.com>
 <1b56186c-9e5b-4e9a-813e-74e4d1511738@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b56186c-9e5b-4e9a-813e-74e4d1511738@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_005942_603083_0837977F 
X-CRM114-Status: GOOD (  17.38  )
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

On Mon, Jul 06, 2026 at 11:10:41AM +0800, Guixin Liu wrote:
> > > > Example output with two registered hosts and an active holder:
> > > > 
> > > >    $ cat /sys/kernel/debug/nvmet/testnqn/ns1/reservation
> > > >    enable : 1
> > > >    generation : 2
> > > >    notify_mask : 0x0
> > > >    rtype : write_exclusive
> > > >    holder : hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
> > > >    registrants:
> > > >      hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
> > > >      hostid=22222222-2222-2222-2222-222222222222, rkey=0x2222
> > > I expect blktests will make use of this interface eventually. The parser
> > > for this wont be dead simple, sure doable but not simple. If you see a
> > > way to make a bit simpler I wouldn't mind.
> > How about this:
> > 
> > 1. One holer, multi registrants:
> >   enable=1
> >   generation=2
> >   notify_mask=0x0
> >   rtype=write_exclusive
> >   holder=11111111-1111-1111-1111-111111111111,0x1111
> >   reg=11111111-1111-1111-1111-111111111111,0x1111
> >   reg=22222222-2222-2222-2222-222222222222,0x2222
> > 
> > 2. No holder, multi registrants:
> >   enable=1
> >   generation=1
> >   notify_mask=0x0
> >   rtype=none
> >   holder=none
> >   reg=11111111-1111-1111-1111-111111111111,0x1111
> >   reg=22222222-2222-2222-2222-222222222222,0x2222
> > 
> > 3. No registrant:
> >   enable=1
> >   generation=0
> >   notify_mask=0x0
> >   rtype=none
> >   holder=none
> > 
> > 4. Reservation not enabled:
> >   enable=0
> > 
> > Otherwise, the notify_mask can be stringization:
> > 
> >   notify_mask=reg_preempted,resv_released,resv_preempted

Sorry, missed your previous post. This looks easier to parser (*), but I
think it's up to Shiinchiro to make the call.

Thanks,
Daniel

(*) I asked a LLM to generate one and it looks straight forward.

#!/bin/bash

# Clean plaintext data with email/quote formatting completely removed
DATA=$(cat << 'EOF'
  19   enable=1
  20   generation=2
  21   notify_mask=0x0
  22   rtype=write_exclusive
  23   holder=11111111-1111-1111-1111-111111111111,0x1111
  24   reg=11111111-1111-1111-1111-111111111111,0x1111
  25   reg=22222222-2222-2222-2222-222222222222,0x2222
  26 
  27 2. No holder, multi registrants:
  28   enable=1
  29   generation=1
  30   notify_mask=0x0
  31   rtype=none
  32   holder=none
  33   reg=11111111-1111-1111-1111-111111111111,0x1111
  34   reg=22222222-2222-2222-2222-222222222222,0x2222
  35 
  36 3. No registrant:
  37   enable=1
  38   generation=0
  39   notify_mask=0x0
  40   rtype=none
  41   holder=none
  42 
  43 4. Reservation not enabled:
  44   enable=0
EOF
)

# Declare an associative array to store parsed data
declare -A INI_DATA

# Tracks the active section namespace
current_section="1. Default"

# Read line-by-line
while IFS= read -r raw_line; do
    # Strip leading line numbers (e.g., "  19 ") and trim surrounding spaces
    line=$(echo "$raw_line" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//; s/^[[:space:]]+//; s/[[:space:]]+$//')

    # Skip empty lines
    [[ -z "$line" ]] && continue

    # Check if the line is a section header (e.g., "2. No holder, multi registrants:")
    if [[ "$line" =~ ^[0-9]+\. ]]; then
        current_section="$line"
        continue
    fi

    # Parse Key=Value configurations
    if [[ "$line" == *"="* ]]; then
        key="${line%%=*}"
        val="${line#*=}"
        
        # Build a compound key: "SectionName|||KeyName"
        map_key="${current_section}|||${key}"

        # If key already exists in this section, append value using a pipe '|' delimiter
        if [[ -n "${INI_DATA[$map_key]}" ]]; then
            INI_DATA[$map_key]+="|$val"
        else
            INI_DATA[$map_key]="$val"
        fi
    fi
done <<< "$DATA"

# --- Demonstrate Accessing the Generated Arrays ---
echo "=== PARSED DATA STRUCTURE ==="

for compound_key in "${!INI_DATA[@]}"; do
    section="${compound_key%%|||*}"
    key="${compound_key##*|||}"
    raw_value="${INI_DATA[$compound_key]}"

    echo "[$section]"
    
    # If the value contains our delimiter '|', turn it into a real Bash array
    if [[ "$raw_value" == *"|"* ]]; then
        IFS='|' read -r -a val_array <<< "$raw_value"
        echo "  Key '$key' is an ARRAY (${#val_array[@]} elements):"
        for i in "${!val_array[@]}"; do
            echo "    -> index [$i]: ${val_array[$i]}"
        done
    else
        echo "  Key '$key' is a STRING:"
        echo "    -> value: $raw_value"
    fi
    echo "----------------------------------------"
done


=== PARSED DATA STRUCTURE ===
[3. No registrant:]
  Key 'rtype' is a STRING:
    -> value: none
----------------------------------------
[3. No registrant:]
  Key 'generation' is a STRING:
    -> value: 0
----------------------------------------
[1. Default]
  Key 'generation' is a STRING:
    -> value: 2
----------------------------------------
[2. No holder, multi registrants:]
  Key 'holder' is a STRING:
    -> value: none
----------------------------------------
[2. No holder, multi registrants:]
  Key 'reg' is an ARRAY (2 elements):
    -> index [0]: 11111111-1111-1111-1111-111111111111,0x1111
    -> index [1]: 22222222-2222-2222-2222-222222222222,0x2222
----------------------------------------
[2. No holder, multi registrants:]
  Key 'enable' is a STRING:
    -> value: 1
----------------------------------------
[1. Default]
  Key 'enable' is a STRING:
    -> value: 1
----------------------------------------
[1. Default]
  Key 'notify_mask' is a STRING:
    -> value: 0x0
----------------------------------------
[2. No holder, multi registrants:]
  Key 'generation' is a STRING:
    -> value: 1
----------------------------------------
[3. No registrant:]
  Key 'notify_mask' is a STRING:
    -> value: 0x0
----------------------------------------
[1. Default]
  Key 'holder' is a STRING:
    -> value: 11111111-1111-1111-1111-111111111111,0x1111
----------------------------------------
[3. No registrant:]
  Key 'holder' is a STRING:
    -> value: none
----------------------------------------
[2. No holder, multi registrants:]
  Key 'rtype' is a STRING:
    -> value: none
----------------------------------------
[3. No registrant:]
  Key 'enable' is a STRING:
    -> value: 1
----------------------------------------
[4. Reservation not enabled:]
  Key 'enable' is a STRING:
    -> value: 0
----------------------------------------
[1. Default]
  Key 'rtype' is a STRING:
    -> value: write_exclusive
----------------------------------------
[2. No holder, multi registrants:]
  Key 'notify_mask' is a STRING:
    -> value: 0x0
----------------------------------------
[1. Default]
  Key 'reg' is an ARRAY (2 elements):
    -> index [0]: 11111111-1111-1111-1111-111111111111,0x1111
    -> index [1]: 22222222-2222-2222-2222-222222222222,0x2222
----------------------------------------

