Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D9DC35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=02/ICYHRj8fVPs3KdOzjuptNnM+qOGHxOj7m9BlCvME=; b=dn0dVy/QDrtalphu6BsmVSCtg4
	nmxFOuLZbf+vkDRdxZ+WxEV+x5ohoa69ir4VnPcCyirKK0myA0DVoXItpba34YiXmoA+C0SjPC7zk
	Kdkm53Cz0RFOxNuBwnj5pjMv8VfhFbxvIo5mWb7t6hSBANjT7ofcZpt+Z+COdkH8GwX/P0+1lQQhi
	O+RrBmcX8jzWrLAxHGkDg8s1t2j2axoqVbbMZmiWlYQ4NAbRdUVQp0oTlBFWYo36qZvKfEpuMZjOn
	6Vo06zCZgkXoeLBY4NGKi03IoCkxcxtunstGZ9PvC+7ghSdEPxqW/mN9urRy5KMh4DF7i9G7qyKdW
	Bfg4NSpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvX64-0000000E9Hz-3n1p;
	Fri, 21 Mar 2025 07:47:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvWq6-0000000E6Lx-1zUG
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 07:30:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E1BC1F7D0;
	Fri, 21 Mar 2025 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742542243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=02/ICYHRj8fVPs3KdOzjuptNnM+qOGHxOj7m9BlCvME=;
	b=kP7pybP8WkVkZIm0SBWd2ga9g0x6qcKMIeCbmJ6nis7E2LfqQJVlThAKCNMD3adUD864CB
	eGeQ9UwzF68+3Xb4vwaVAUl+GAjlWh6oqE+uFkQn35oiWuFidX4f88k2oL+cyFk4z9fOgR
	YOo+W/DDys7ugIoSO2XK6KRSaJHRn9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742542243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=02/ICYHRj8fVPs3KdOzjuptNnM+qOGHxOj7m9BlCvME=;
	b=qIpZDbmr/Dv70/z/RaI2Oc4fdCHe+pFp/++uoZvwrOU22pvVJd9kQA/P3EsNs4lgOrzT/0
	h2yMI/ztPdCa8sBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742542242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=02/ICYHRj8fVPs3KdOzjuptNnM+qOGHxOj7m9BlCvME=;
	b=aLwQjYFVhw8o76p+1w2KNpJ/lawQA1FeruFRCGiBbrheM48Ot5TMMIbzXHDo7zuZZ3uX9T
	u2Fc95gDpMxBhq3JQcrL1UsB2xOfWKQAZM6NvqidlaBGkOwQz7vES622SvzncNRJ2sr10o
	QjBCxaHw9rgX2IhUJ4Wle2pskY5hAoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742542242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=02/ICYHRj8fVPs3KdOzjuptNnM+qOGHxOj7m9BlCvME=;
	b=NVcxxamlo61xheDRTJl3A14au43yduAfhVBluKLoCJ8tZeYZqZOLiPH0pIc4vGiWc1Yrl6
	k27BG8P2qfV/gpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3143F139AA;
	Fri, 21 Mar 2025 07:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uk6ACqIV3WeCcgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Mar 2025 07:30:42 +0000
Message-ID: <73a24cb2-0adf-4685-8202-27210aa014cc@suse.de>
Date: Fri, 21 Mar 2025 08:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] NVMe-TCP performance improvements
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_003046_660504_611C5A2E 
X-CRM114-Status: UNSURE (   7.37  )
X-CRM114-Notice: Please train this message.
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

Hi all,

a partner of ours reported a severe performance and scalability issue 
with TLS on NVMe-TCP, where spurious I/O timeouts have been occurring 
once the system scales up to more controllers. With enough controllers
he even ran into timeouts during the initial connect command, rendering
the system unusable.
There have been several attempts to fix this (my attempts [1], spreading
load to CPUs by Sagi [2]), but they didn't really fix the issue.
I have since then done quite some performance analysis, but found that
'classical' statistical methods can't easily used as we have a really
high divergence in performance; the standard deviation vastly exceeds
the mean value, rendering the calculation meaningless.
Eventually I nailed down the problem with [3], but the performance 
analysis problem remains.
In the discussion I would like to present the performance analysis,
and discuss ways on how the analyze the performance in the light of
high noise in the measurements.


[1] 
https://lore.kernel.org/linux-nvme/20240618120345.64761-1-hare@kernel.org/#r
[2] 
https://lore.kernel.org/linux-nvme/20241224120457.576100-1-sagi@grimberg.me/
[3] 
https://lore.kernel.org/linux-nvme/20250307132802.111513-1-hare@kernel.org/

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


