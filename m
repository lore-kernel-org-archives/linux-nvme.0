Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18812E8B386
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 01:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=; b=0uQ/Sd2iON/udlzJBEHlhRG4vo
	CYiuC6k/5e1au0uCHCspTNow5ebVwEktcqxrscDUkZoyAnB5zlBL3MA+J6cvUFCRMpXftg8p2laM0
	uWx647bGoDxMI/X6WJ49+uRyM3E2Zl9rPwW/AtiYq/8kvrGgz/X+iIzbFBtmWBlOQQU4Fs2LDYhkb
	6UYe7bDLaN9o9lr5Nu8tczeaMAxhkP+m0mTqzOYXnlHZzMuergD9AcSpNA//pbUBxv/4n936xGDJs
	k4tV71b0MAgUDqrvM/KVdTOEmBz/S91X+bmDzDkjb6Z5atVXPUCUR62Q+O/I/EGt/KWfn1oy/mfs8
	rw7GMUWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnRvX-00000007i9K-3khe;
	Wed, 04 Feb 2026 01:43:31 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnRvS-00000007i7j-47Do
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 01:43:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B85805BCC7;
	Wed,  4 Feb 2026 01:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770169404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=;
	b=CoVB90Rnw/UeTEsXuazminkvefpv8IW8b2UIRzDmVvkvA5tCWwpXsto8XCt8hIDBHB5Qph
	z9pc66fd3K3HBHc2YvB56E6ym+E1B3CBN4Lf8ho7+BDnkTqAsijdabuK/7XO12tUWvvHiI
	deMTWkFQDejbadJCA5s5ZloKEDBSSg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770169404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=;
	b=7xbMd4i8db2dRRQZIJFz53tUm9O5D51KgULxSCU2Q6Y2FUtf9EZcSAHc4pZdx5eBPbQflf
	2Yl7mdiqVvoqr0Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770169404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=;
	b=CoVB90Rnw/UeTEsXuazminkvefpv8IW8b2UIRzDmVvkvA5tCWwpXsto8XCt8hIDBHB5Qph
	z9pc66fd3K3HBHc2YvB56E6ym+E1B3CBN4Lf8ho7+BDnkTqAsijdabuK/7XO12tUWvvHiI
	deMTWkFQDejbadJCA5s5ZloKEDBSSg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770169404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=;
	b=7xbMd4i8db2dRRQZIJFz53tUm9O5D51KgULxSCU2Q6Y2FUtf9EZcSAHc4pZdx5eBPbQflf
	2Yl7mdiqVvoqr0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA5BD3EA63;
	Wed,  4 Feb 2026 01:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZOEDITqkgmm+egAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 01:43:22 +0000
Message-ID: <a14c022e-84c4-477e-998b-aab79e2cea6d@suse.de>
Date: Wed, 4 Feb 2026 02:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Nilay Shroff <nilay@linux.ibm.com>, Damien Le Moal <dlemoal@kernel.org>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <7ec5f552-197f-48be-9898-9cc4233783fc@kernel.org>
 <2594023b-b1a5-4752-bb4b-73a4fce4ef5d@suse.de>
 <10428c95-2023-466b-ad1a-4b190bc402a1@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <10428c95-2023-466b-ad1a-4b190bc402a1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.927];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	SUBJECT_HAS_QUESTION(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_174327_315688_1D70C446 
X-CRM114-Status: GOOD (  24.95  )
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

On 2/3/26 13:19, Nilay Shroff wrote:
> 
> 
> On 2/3/26 4:34 AM, Hannes Reinecke wrote:
>> On 2/2/26 02:46, Damien Le Moal wrote:
>>> On 2/2/26 02:06, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> We are currently working on implementing cross-controller resets for
>>>> NVMe, which requires to send a command to the target which then should
>>>> terminate all commands on a given controller.
>>>> While we could easily terminate the controller, the specification
>>>> also requires us to terminate all outstanding commands.
>>>> Which then recurses into my all-time favourite topic on how to
>>>> abort outstanding commands from the fs/bio layer.
>>>>
>>>> However, here we don't have to dissect/match to individual commands,
>>>> but rather have to abort everything, which seems rather easier.s
>>>>
>>>> So I would like to fathom whether such a thing is feasible/reasonable
>>>> (I think so, obviously, and can think of several other use-cases, too,
>>>> qemu springs to mind here ...) and discuss possible implementations
>>>> (set 'req->deadline' to zero for all pending commands?).
>>>> Or maybe we can do such a thing already and I'm just not aware of it...
>>>
>>> Hmmm... Command timeouts ? E.g. if a controller is slow to respond (send
>>> completions), the block layer timeout timer may trigger, which will call into
>>> the low level device driver to force a reset. But before the reset actually
>>> happens, completions may actually come back, and we do handle that race
>>> correctly, well at least for scsi/ata.
>>>
>>> Your scenario sound very similar to this: once you reset the controller,
>>> whatever was pending will be silent and can be aborted or retried. So it does
>>> sound like that should not be too difficult, no ? Generalize the timeout
>>> processing or do something similar ?
>>>
>> The good thing is we don't even need to generalize anything. It should
>> should be sufficient to walk the inflight requests and set
>> 'rq->deadline' to 'jiffies'. General idea here is to just _initiate_
>> command termination with this, one then still has to wait for all
>> commands to complete, but at least now there is a reasonable chance
>> that this will happen quickly.
> Well if the request which is being terminated this way happens to be admin
> command then it may cause the controller reset. The issue with this approach
> is that we're artificially inducing the timeout (instead of actually issuing
> abort) and NVMe driver timeout handler assumes the admin command timeout is
> fatal and it resets the controller.>
Well, yes, and no.
Command timeouts _are_ artificial; none of the command specifications
mention any timeout, so anything we do here is actually guesswork.
So the controller _must_ be able to abort commands.
I am fully aware that the NVMe driver does _not_ abort commands on 
timeout (but rather resets the controller), but that is an 
implementation detail of NVMe.
(And arguably something which we should fix. Time for another LSF
session, maybe).
Main point is that the block layer already has driver callbacks for
timeout, so one does not need to implement yet another callback.

> IMO, conceptually, the goal here is not to force a timeout but to explicitly
> abort all outstanding commands as required by the NVMe cross-controller reset
> semantics. So combining these two (timeout and abort) mechanisms makes the intent
> unclear and coupling abort semantics to timeout handling makes it fragile.
> 
> So from this perspective, it would be cleaner to have an explicit blk-mq callback
> for aborting all outstanding requests. The block layer would invoke this callback,
> and each driver could implement the abort logic according to its own requirements
> and specification constraints. For NVMe, this shall allow us to abort in-flight
> commands without overloading the timeout path or triggering unintended controller
> resets, any thoughts?
> 
Which is basically the direction I had been thinking about, having a
generic (block-layer) function to invoke device resets.
_How_ this function will be implemented is open for debate.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

