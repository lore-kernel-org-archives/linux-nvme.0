Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C354C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 07:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4olBED4yunvZDSed+w4pK3AKyQoPBiiQA/F7RbLXoYU=; b=KpcGhMBKjQFWLHzV3Q2x3n6Irl
	uVdPHTB6HBCuHpfR34/DM730bJE7ZyjdhF93B0lgCyyk7qmsTJren2ao8yz+B4O50AuloAIvR3AlM
	i58IhdwudDGPDNFq0CoYbm9GgbpDVnaH5yWZ70AtTEMw8Blr4saftYL8IepEni8dkEmEk3SYmfwBR
	niiv3RbbtbCW9wMoe13Jgfj6a1VFOdIpmpod1fy+E2Jly7ndddG1WZ9m+YmpdXnOtcqyBBe4/E2Jh
	7/lJX3ySNgtk/rETqzNUnVLKs0etJz42NcTl6BYrYDx3K/6cMRiNlE9xtf81fZeXRmsvxjCk3002Z
	kji2C4OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp0xR-00000003OV7-3rW8;
	Tue, 26 Mar 2024 07:10:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp0xK-00000003OSu-1LtH
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 07:10:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99A3A5D233;
	Tue, 26 Mar 2024 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4olBED4yunvZDSed+w4pK3AKyQoPBiiQA/F7RbLXoYU=;
	b=Lw7U73ZqoJl/s0RyQws2bt9EWrMoCa3KbsuBMKRer4OC3PURtDpA3t1C5e4bOouyr7in2K
	SWZEH0S1jhNUcRsIrpb3ogH3DxdHY3EcOVXGiR0P3BB+tHpnFZ/Uf4lobRuEQkx3YYHRFL
	VxjMUv92cp0Nsbl47GC0Dki23xDj9zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4olBED4yunvZDSed+w4pK3AKyQoPBiiQA/F7RbLXoYU=;
	b=sI4CO2QM0eExzGd6+aBMrqmqmTE6zsQyVGxbs6iY6H8iLi8G0r+X0dNfcBfzMb4S0IT+MY
	TrT/j1CG8gh2vfBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4olBED4yunvZDSed+w4pK3AKyQoPBiiQA/F7RbLXoYU=;
	b=Lw7U73ZqoJl/s0RyQws2bt9EWrMoCa3KbsuBMKRer4OC3PURtDpA3t1C5e4bOouyr7in2K
	SWZEH0S1jhNUcRsIrpb3ogH3DxdHY3EcOVXGiR0P3BB+tHpnFZ/Uf4lobRuEQkx3YYHRFL
	VxjMUv92cp0Nsbl47GC0Dki23xDj9zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4olBED4yunvZDSed+w4pK3AKyQoPBiiQA/F7RbLXoYU=;
	b=sI4CO2QM0eExzGd6+aBMrqmqmTE6zsQyVGxbs6iY6H8iLi8G0r+X0dNfcBfzMb4S0IT+MY
	TrT/j1CG8gh2vfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D14F13306;
	Tue, 26 Mar 2024 07:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HKX2EPN0AmYfTQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 26 Mar 2024 07:10:43 +0000
Message-ID: <7bfe1296-3bd6-4c5e-a1a7-5fdb5c346404@suse.de>
Date: Tue, 26 Mar 2024 08:10:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tree: Add NVM subsystem controller identifier
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com
References: <20240326065752.164286-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240326065752.164286-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.64%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Lw7U73Zq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sI4CO2QM
X-Rspamd-Queue-Id: 99A3A5D233
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_001046_626889_16DE4DBC 
X-CRM114-Status: GOOD (  15.42  )
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

On 3/26/24 07:57, Nilay Shroff wrote:
> This commit introduces a field "cntlid" for controller,
> that contains the NVM subsystem unique identifier assigned
> to each controller device in an NVM subsystem.
> 
> While attaching a namespace, typically user needs to specify the
> controller identifier (cntlid). The cntlid could be referenced from
> sysfs (/sys/class/nvme/nvmeX/cntlid) but it would be nice to have
> a direct option.
>  > Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Hi all,
> 
> While attaching an NVMe namespace using nvme-cli command
> "nvme attach-ns", we need to specifiy controller identifier
> (cntlid) against which the namespace is being attached.
> 
> Not specifying cntlid while attaching namespace would result in
> no actual change in namespace attachment. For instance,
> 
> # nvme create-ns /dev/nvme0 --nsze=0x156d56 --ncap=0x156d56  --block-size=4096
> create-ns: Success, created nsid:1
> 
> # nvme attach-ns /dev/nvme0 -n 1
> warning: empty controller-id list will result in no actual change in namespace attachment
> attach-ns: Success, nsid:1
> 

Errm. How would that work? /dev/nvme0 _is_ a controller, and as such 
will have an assigned cntlid. And if one would issue an 'attach-ns'
command the only controller which it could address is that controller
to which the command is issued.
I'd be _very_ surprised if you could issue 'attach-ns' against _another_
controller. So why do we need this option?
Shouldn't we rather infer the cntlid from the existing controller?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


