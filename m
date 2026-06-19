Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78698CD98F6
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 05:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+rmUdXpia5krblnPKRkGzb3Y0WMVphnSCgATKEz61No=; b=w0NnXX7xM5TaCjXTC7FT3GY8V/
	SvmflkZl7AMhQQ1+Q2P98J7iHar4GZUXG5mmUz6aDRabxoaUFkHC3lbQ2Yu+RsRXB0s1X7XflOezd
	iYgxo0XkR5JX52KqYmFf0JH1TczjMwUjb2ff957vP5DLiFXNCuQUQvXhZ6MqudBwi7mqZD9m+YAi3
	fH76cIKHnvN2y3w7ZXF6YnF/l+1OvI1EKZSyqy/jdZz2Zu9xfwOsFiAvYB30g/Yd6sh5iQjIkvYH9
	35Nv60M/JlX2oJPpWNpLwp08KO1V0zekgluCM48fYQTqGJaNVErlo6G/kE6dxn7Xfjt8XKLV6Ewxk
	gaeEHqwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waSGf-000000021yR-0JXl;
	Fri, 19 Jun 2026 05:59:53 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waSGa-000000021xh-2VIW
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 05:59:51 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF2AB6D895;
	Fri, 19 Jun 2026 05:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781848785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rmUdXpia5krblnPKRkGzb3Y0WMVphnSCgATKEz61No=;
	b=xSJHl58Rk2KMoLBiiQwr3Ex97CSNVbcJwZ10jpbuZ42x684krnjXu8qxqU5uDSEYk7DTMm
	9pDXZVlpS7ELLAR8g46Ps4Zbj3TjuOFc5j70tv3AH7rk1ZLQbYIsHhMjo5ocgrcoF1A3O8
	SCGAc2cHaDdmhQDxsc6B6Dmi40xQid8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781848785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rmUdXpia5krblnPKRkGzb3Y0WMVphnSCgATKEz61No=;
	b=PFU5+ibltGOFX0LDkIhNAY55C7uKwyo/9uN39a6tCqTCjS7x6swbPTNA0L1FRPT6ZNSsk2
	uNj9f3pfPrHKs6Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781848784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rmUdXpia5krblnPKRkGzb3Y0WMVphnSCgATKEz61No=;
	b=w919NYx1YEEpDOCmWvFt9EZrnk+moZscLHa44kg9lkF2Fo3D66r3yLjIDUuin8OXq0SPiM
	wik0zkKnniRfFoIPMSkIUDf9HocyOewEIrmH3de0bbSdx4exJSL4Lt2/hJfe78h9ueCTT2
	w3PTOr3eJtngQ/C5UAgreFTWcnYbL2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781848784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rmUdXpia5krblnPKRkGzb3Y0WMVphnSCgATKEz61No=;
	b=BKUPQOBU9bQUHs+wx+Ye1gqkDAVQ9DOFAwD3Zbu/lQUdPLw8ocXCJmge+4khQ6LbSsrnS3
	Ty3j5Yjy7Qq4VxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7147E779A8;
	Fri, 19 Jun 2026 05:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BCiUGdDaNGrKFQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jun 2026 05:59:44 +0000
Message-ID: <531aa19b-a9ae-44f7-82ce-3714621ceee8@suse.de>
Date: Fri, 19 Jun 2026 07:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during async
 scan
To: Keith Busch <kbusch@kernel.org>, Maurizio Lombardi <mlombard@arkamax.eu>
Cc: John Meneghini <jmeneghi@redhat.com>,
 Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de, chaitanyak@nvidia.com,
 bvanassche@acm.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, James.Bottomley@hansenpartnership.com,
 emilne@redhat.com, bgurney@redhat.com
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp> <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp> <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp> <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
 <ajRpWLqaEyA6cwkJ@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ajRpWLqaEyA6cwkJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_225949_230105_B8E84564 
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

On 6/18/26 23:55, Keith Busch wrote:
> On Wed, Jun 17, 2026 at 07:41:58PM +0200, Maurizio Lombardi wrote:
>> Did you manage to find a solution for this race?
>> I just wanted to check whether you had any patches ready for testing since
>> this discussion.
> 
> At last month's LSFMM, I heard concerns that this would break something.
> I don't remember the specifics as I wasn't trying to push the issue. I
> think this feedback was from the more fabrics focused folks, maybe Randy
> Jennings, Nilay Shroff or John Meneghini remembers?

The problem here is namespace lifetime. The ns_ida is only ever released
at the very last step, so the 'number' of the namespace will only be 
freed once all references to the namespace are dropped.
So if you were trying to keep the namespace number ordered you would
have to delay the creation of the namespace until that point, and you
would induce a serialization between deletion and creation.
Which will drastically prolong the rescan process.
And of course you need to hope that no-one triggers another rescan
process while the old one isn't finished, as that would need to wait
for the previous one to finish, too.
Or you need to introduce a mechanism to terminate an already running
rescan process.
So really, not a good idea.

I fail to see why one cannot use persistent names here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

