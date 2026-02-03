Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104DEE83057
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 05:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TO9cphZM6HUtakaOl7KufQdzK/6JR+1k6UmdS9U5Mpw=; b=QV4lsA51HsD1gciWHzZMRVjnXE
	VNgLUTsfoWV2Xv1NkB8SfrJb/G/gyQW2e087Y31gk/7ZTotoyouQVM6CAvZ+WJE5vxsDUFwVbwihz
	x8R1enHqfOdSJuT5pBfI72Z27X3BXZqPnx3Dqnr8LcjXJ04a8t14DXQ6fdViuINCkjJjovbAr8RJN
	yEr9Ds2VVORq+3Ee08gRKYgwUd1EoW2u/LwnJWYKqz3zq1aSM0IAM8N3wuizaPQ+6VTUYOa5CFcnh
	PqnuYhKBH546JH8/HP6ACKSJjztNTKnHr35rIssUdxdVSm5PIabTRKnOsygvRDLFY2Nzju8yJFWCE
	3SMMbi3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn9K6-000000068Ka-3Uhx;
	Tue, 03 Feb 2026 05:51:38 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn9K4-000000068KF-2Luv
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 05:51:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3D875BCC6;
	Tue,  3 Feb 2026 05:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770097894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO9cphZM6HUtakaOl7KufQdzK/6JR+1k6UmdS9U5Mpw=;
	b=F8TA5ftN961ht24Qe5S//0scOG8feoSk5KzNeydb4MpCG08KGAnfE8gQXCP0Dwp2p70dM0
	imWZhtoKxGT5vueWnuizVC4mPBsTQmjutGvr98LEI5Slwv9/zMHPTXcsoTR8WIhcbfumhY
	FFu0onn+RN9OUfQxukbfkTJIlnu0goE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770097894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO9cphZM6HUtakaOl7KufQdzK/6JR+1k6UmdS9U5Mpw=;
	b=f8KycVFo92yVikyhm75JPsNA8Unc0dHdi3T0TY1bgmIR63oz8QsBceGCJdvoWWZV586T/5
	YyDlBRM333gw6jAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770097893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO9cphZM6HUtakaOl7KufQdzK/6JR+1k6UmdS9U5Mpw=;
	b=D4oqzshaAriN5e6ud/6NuwdfAJg8jW7DluD21gblFQU91gRBCBVLsV8MEdDWifeB7Om15w
	MT11o2OnWAcHglnMMMmyjf5a7clPhutFkxpunJeZTTbRcq0xEtWr1OK9GHu5VgzDOCIAc+
	o+mEWn8V7iIu1veOiRlquShGD/GgjQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770097893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO9cphZM6HUtakaOl7KufQdzK/6JR+1k6UmdS9U5Mpw=;
	b=ZpRSdMHpJh1fJcsnuDKPTeS1GaLzEroAPznXj04onK9LpupOl5BcujxEHQ3l88x+bLsfKV
	F6o2XcUAbngC+4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D5253EA62;
	Tue,  3 Feb 2026 05:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +lwHAuSMgWlNBwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 05:51:32 +0000
Message-ID: <65937263-912c-4250-af26-054b2b6be72b@suse.de>
Date: Tue, 3 Feb 2026 06:51:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BFP TOPIC] Block-layer device resets
To: Ming Lei <ming.lei@redhat.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <aYFoBafih46bLK0T@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aYFoBafih46bLK0T@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_215136_758540_D7E83711 
X-CRM114-Status: GOOD (  17.23  )
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

On 2/3/26 04:14, Ming Lei wrote:
> Hi Hannes,
> 
> On Sun, Feb 01, 2026 at 06:06:52PM +0100, Hannes Reinecke wrote:
>> Hi all,
>>
>> We are currently working on implementing cross-controller resets for
>> NVMe, which requires to send a command to the target which then should
>> terminate all commands on a given controller.
> 
> Can you provide a little background why this reset is required? And for
> solve which problem?
> 
Sure. It got triggered by me wanting to use a ublk device as a backing
device for nvmet namespace.
During a nvme reconnect the target is supposed to abort/flush all
outstanding commands on the backing device. As this is a block device
we would need to have an interface into the block layer allowing us
to do so.

>> While we could easily terminate the controller, the specification
>> also requires us to terminate all outstanding commands.
>> Which then recurses into my all-time favourite topic on how to
>> abort outstanding commands from the fs/bio layer.
> 
> nvme_quiesce_io_queues() & nvme_cancel_tagset() may do it, or do you have
> other new requirement not covered by the two helpers?
> 
Possibly. But that would be an NVMe-specific way, and won't help us
for things like ublk.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

