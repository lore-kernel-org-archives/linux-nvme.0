Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E40C35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 08:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ouYW+CIgGdjdUKauvwOMcTBkUsQSp3FM4D5l0MqV2Ms=; b=rreW5TRL88Ku17rrPj5zs7i5C8
	fNv4e/1IZNfVf1PJRbgukpXOebLbIAw3KswqEZEsq4Z5pdfth321SJ43mBF/KM6oRNiQcB5QLGKem
	PJg0xIOKSsDQ/oj/TstcwfoTHfCJYMGkXA/8WI74IMxELnDLy61jWwO5wJSaDPLf1FhBs+oAFTWad
	h9RqJ2n+hQlLNxlNGbbEwMy+6z85+3wMUAgcMZkHsf9fiosVPK5Gd5p0UcJJsDcOqFmmLthz0nkmh
	1ZRmOY8F6GW2a1WXzg5NEcU+8+BwUVMNPB8vx0rFoaSnoc0l7gztnIYZpj9DFxjbl3nUiUt8I8PjD
	nmL5qF9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvXPr-0000000ECXu-2DuQ;
	Fri, 21 Mar 2025 08:07:43 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvX2J-0000000E8Uv-0919
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 07:43:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 524A021C03;
	Fri, 21 Mar 2025 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742543001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ouYW+CIgGdjdUKauvwOMcTBkUsQSp3FM4D5l0MqV2Ms=;
	b=dxouX6ZZYxzCbWExAT/dg+Q/6MLjo5sV7Oee0agwPZYe1zwJQjna4coR7IKD5nkoPynASF
	O46g03Lgu7V+IxMDtiDeC44DhP0YAzadNIY4SvjcJtP1OoCBM6/m5ZM2mdHeIOVkJB5KVk
	E2ofzLEr2Cpck0F5KerqCgQ6zv3sThU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742543001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ouYW+CIgGdjdUKauvwOMcTBkUsQSp3FM4D5l0MqV2Ms=;
	b=S9BSftVsmw6qoc4yBXxpb3FkEdHR2aaRTTBBXarKQ0xurxYv3OAVNLeEguakbKElG2Tb8g
	rdJsyNypd83KyrBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742543001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ouYW+CIgGdjdUKauvwOMcTBkUsQSp3FM4D5l0MqV2Ms=;
	b=dxouX6ZZYxzCbWExAT/dg+Q/6MLjo5sV7Oee0agwPZYe1zwJQjna4coR7IKD5nkoPynASF
	O46g03Lgu7V+IxMDtiDeC44DhP0YAzadNIY4SvjcJtP1OoCBM6/m5ZM2mdHeIOVkJB5KVk
	E2ofzLEr2Cpck0F5KerqCgQ6zv3sThU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742543001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ouYW+CIgGdjdUKauvwOMcTBkUsQSp3FM4D5l0MqV2Ms=;
	b=S9BSftVsmw6qoc4yBXxpb3FkEdHR2aaRTTBBXarKQ0xurxYv3OAVNLeEguakbKElG2Tb8g
	rdJsyNypd83KyrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37714139AA;
	Fri, 21 Mar 2025 07:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0m8ADJkY3Wc4dgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Mar 2025 07:43:21 +0000
Message-ID: <ddd0d3f9-5667-477a-86ad-122ef4b1b374@suse.de>
Date: Fri, 21 Mar 2025 08:43:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] Enhancing NVMe target
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_004323_220368_28D4C372 
X-CRM114-Status: UNSURE (   5.37  )
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

There are quite some features in the NVMe spec which are geared up for 
distributed environments (eg the entire CDC mechanism, exported 
subsystems in NVMe 2.1), which require quite some logic in the discvoery
and NVM target subsystem.
While this can (and arguably should) be implemented in userspace
(cf my 'nofuse' project [1]), I really would want to continue using the 
existing nvme target infrastructure for handling the actual I/O.
But currently the nvme target infrastructure is pretty much stand-alone,
and provides as the only 'hook' to integrate with other systems the
'referral' configuration for the discovery log page.
I would like to discuss how an integration with user-space tools could
work; offloading the entire admin queue handling via eg io_uring?
eBPF struct ops hooks to modify response data?
Others?

Not forgetting the initial goal of nvme target as the minimal viable 
implementation, so of course we might decide to not modify the target at 
all. Which naturally I would find disappointing :-)

[1] https://github.com/hreinecke/nofuse

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


