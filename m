Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC800C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Mar 2024 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sx17lZIMCraE45nXiEmhT2jDd25XhigJ6TIBTa2XD5M=; b=gmPd0+JIsHhdZyCxxJQUxpdmgC
	R5JK2x04KR4DriDo2iOrimUfhs+mgiWsdVQqWuKWVPoMqeJKYHapyJ5sMNuWdR+tX22AwQRO6+RYb
	yCF4oglWWVLXibjtJQZCon84/IjZLFjG8Buuhnxp3C0EUqKTFehDT9JNUqOgH+eczDEHSelk49hRr
	nlIKuL399GWouyQoo4vjskXymOcTA/XjYHR4E73QE0tP6B48ayJzZEuIH2bhQ18Aym2lCr+9jLOu6
	rqXO/q19sYoJIvApPzl5hSBN91FP9ZyQM/69Qe7pcivZFwmEODAKOp3QJ8l4UrRt5IXdUP29FO/Hp
	cxfeufvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roeiv-0000000Fu4l-2svT;
	Mon, 25 Mar 2024 07:26:26 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roeia-0000000Ftuh-2xkI
	for linux-nvme@lists.infradead.org;
	Mon, 25 Mar 2024 07:26:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2784A20956;
	Mon, 25 Mar 2024 07:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711351552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx17lZIMCraE45nXiEmhT2jDd25XhigJ6TIBTa2XD5M=;
	b=0XeiKG78hO1FPX2ETvi6NWLhlVo9+rlT5QiAdeVkyaKU+PhQWeqK9ZzOUaYJSbor9Gxhrd
	RzFG1aAUbXbQvt120eKxyIz4g1Yieef09C1KQ70ribfXZbG6QpQIDwVS8M/NG0brm353C6
	co4Nm5BSpzAVRjBuSmhyvZCnTwq1arQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711351552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx17lZIMCraE45nXiEmhT2jDd25XhigJ6TIBTa2XD5M=;
	b=YNAj0AMB2FgVAfz8uZ/hNCEh+MbBOXViXQYxzZZSYNel/CsiOma0pI6/7BSkH9+NHGWH1r
	VK3C+nYfS+J7VWAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711351552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx17lZIMCraE45nXiEmhT2jDd25XhigJ6TIBTa2XD5M=;
	b=0XeiKG78hO1FPX2ETvi6NWLhlVo9+rlT5QiAdeVkyaKU+PhQWeqK9ZzOUaYJSbor9Gxhrd
	RzFG1aAUbXbQvt120eKxyIz4g1Yieef09C1KQ70ribfXZbG6QpQIDwVS8M/NG0brm353C6
	co4Nm5BSpzAVRjBuSmhyvZCnTwq1arQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711351552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx17lZIMCraE45nXiEmhT2jDd25XhigJ6TIBTa2XD5M=;
	b=YNAj0AMB2FgVAfz8uZ/hNCEh+MbBOXViXQYxzZZSYNel/CsiOma0pI6/7BSkH9+NHGWH1r
	VK3C+nYfS+J7VWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD82C137C4;
	Mon, 25 Mar 2024 07:25:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kk1+M/8mAWbNEQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 25 Mar 2024 07:25:51 +0000
Message-ID: <ce6cfd9c-10cb-4690-999b-f738cd376fc3@suse.de>
Date: Mon, 25 Mar 2024 08:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] nvmet: add debugfs support for queues
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-9-hare@kernel.org>
 <efd797cc-2c6a-4d08-9100-762052a9c788@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <efd797cc-2c6a-4d08-9100-762052a9c788@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.76 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.26)[73.61%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0XeiKG78;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YNAj0AMB
X-Rspamd-Queue-Id: 2784A20956
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_002604_979935_77E21C5A 
X-CRM114-Status: GOOD (  11.37  )
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

On 3/23/24 21:31, Sagi Grimberg wrote:
> 
> 
> On 22/03/2024 9:03, Hannes Reinecke wrote:
>> Add debugfs entries to display the status of the controller
>> queues.
> 
> I'm questioning the value of this. We can possibly see lots and lots of
> queues and I wonder how a queue entry will this actually help.

One can inspect I/O progress via the sqhead attribute; also one would
want to know the number of queues created.
But we can leave it for now; main part of this patchset is the 
controller entries and the possibility to trigger a controller reset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


