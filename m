Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AAAE7FDE0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 22:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tmgm4k0foKfOueLURlYSbEoh7mAqSgoBSR8h6fMJBd8=; b=tPZxzvMLlKyGK0JNMMHY58cSBH
	l2qd+JybObAKSUyr9UdhfFUkOzmaZoH1cGtRZ/ZY3Xkx+leS/6y4P+7lJbpu3nLPbSzPzWlo5Fk5m
	/Kb40AOcnHQZIcyUJnD3N0gJaNBk252dv48HvfowjkR6C5CWlWOUHc/zGZXs+C2OhL3f7lXweHdz5
	Qcxvb53HJZ3b84OrVcOZ9NKcpHY027W+fzWWSC9ExTu5ic6RmAKX66mNbK+W9Y4LILnN4SWSIWcdj
	W2vdtdMfm4yeK0MS2/5XYIQRixr0QuMeR1w+9GS7JMmR3AQO+POYzGy6rL5MXr1WsvxZlNy2qSTpD
	iEY5M+hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn2qT-00000005jYr-1v71;
	Mon, 02 Feb 2026 22:56:37 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn2qR-00000005jYR-1JVP
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 22:56:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C12123E6C6;
	Mon,  2 Feb 2026 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770072991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tmgm4k0foKfOueLURlYSbEoh7mAqSgoBSR8h6fMJBd8=;
	b=EjLVYhh6KHyvcfvvZp0gZg+u01+H7UGWUdls2C/4O3SzS3xWIuGgAJPtv+fHfDZtqVHmgn
	8TVl78R1fytjEQDf0OHh+hROIT4jWVqKh4R5AbNsF0LqdQLXbKutMvrPG9hTNhmmEtPw0r
	CN6NxO3j3EZhBrAEUntffHcTvxuteUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770072991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tmgm4k0foKfOueLURlYSbEoh7mAqSgoBSR8h6fMJBd8=;
	b=VYnj7ye4v2FoFkdbYtJwWNobJnTMpm9cuc4YS04ypUfl9fq8xDj1pbAo8xJ+UpP0/RzRrT
	A6JM6Gm0ozVsAaBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770072991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tmgm4k0foKfOueLURlYSbEoh7mAqSgoBSR8h6fMJBd8=;
	b=EjLVYhh6KHyvcfvvZp0gZg+u01+H7UGWUdls2C/4O3SzS3xWIuGgAJPtv+fHfDZtqVHmgn
	8TVl78R1fytjEQDf0OHh+hROIT4jWVqKh4R5AbNsF0LqdQLXbKutMvrPG9hTNhmmEtPw0r
	CN6NxO3j3EZhBrAEUntffHcTvxuteUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770072991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tmgm4k0foKfOueLURlYSbEoh7mAqSgoBSR8h6fMJBd8=;
	b=VYnj7ye4v2FoFkdbYtJwWNobJnTMpm9cuc4YS04ypUfl9fq8xDj1pbAo8xJ+UpP0/RzRrT
	A6JM6Gm0ozVsAaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 154273EA62;
	Mon,  2 Feb 2026 22:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E116MJwrgWlJVwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Feb 2026 22:56:28 +0000
Message-ID: <e55134c8-4429-477d-a2cd-290a2eb31d20@suse.de>
Date: Mon, 2 Feb 2026 23:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme: export additional diagnostic counters via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260130182028.885089-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_145635_510755_538DAF0F 
X-CRM114-Status: GOOD (  16.73  )
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

On 1/30/26 19:20, Nilay Shroff wrote:
> Hi,
> 
> The NVMe driver encounters various events and conditions during normal
> operation that are either not tracked today or not exposed to userspace
> via sysfs. Lack of visibility into these events can make it difficult to
> diagnose subtle issues related to controller behavior, multipath
> stability, and I/O reliability.
> 
> This patchset adds several diagnostic counters that provide improved
> observability into NVMe behavior. These counters are intended to help
> users understand events such as transient path unavailability,
> controller retries/reconnect/reset, failovers, and I/O failures. They
> can also be consumed by monitoring tools such as nvme-top.
> 
> Specifically, this series proposes to export the following counters via
> sysfs:
>    - Command retry count
>    - Multipath failover count
>    - Command error count
>    - I/O requeue count
>    - I/O failure count
>    - Controller reset event counts
>    - Controller reconnect counts
> 
> The patchset consists of seven patches:
>    Patch 1: Export command retry count
>    Patch 2: Export multipath failover count
>    Patch 3: Export command error count
>    Patch 4: Export I/O requeue count
>    Patch 5: Export I/O failure count
>    Patch 6: Export controller reset event counts
>    Patch 7: Export controller reconnect event count
> 
> Please note that this patchset doesn't make any functional change but
> rather export relevant counters to user space via sysfs.
> 
> As usual, feedback/comments/suggestions are welcome!
> 

While I do agree with the general idea, I do wonder whether debugfs
would not be a better suited place for all of this. Having all of
this information in sysfs will clutter is by quite a bit, plus we
do have the usual issues with ABI stability if we ever see the need
to change (or, heaven forbid, remove) any of these counters.

(And when doing so it might be an idea to add a 'version' entry
to debugfs such that we can manage userspace expectation).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

