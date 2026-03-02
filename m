Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD54D58E6F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AfYSDuCA2CAmpRBvPIVlJRBA8l2SvAi2++c+EQu0aU4=; b=FaoiwEqpU1nb2MJxmUh0yi284u
	F3bGFiC6EN0VpnrFaI7GiTgGQLi22t60XKBq0AAIE0dBJlcsxTTJ1w5wyZfDyTQex6454X2Mc9mFy
	jzhUldiaWVco2iPB4PVW9SdnyMs+Au2ZmZ3exjoFJr+Bmz3JJYgr7eL4EyCua/01u2mu2Q10YpVRL
	XCyMzA2nkC6feBQJ/E3xcppttSjzsFeXST7NH8UIWoL35CMXinr1aeYSllgvcSfa8+oZfj0WTYOMD
	Xef5ni2GM/tAR6h5QtTePJhNwWczGXN5BfCZte9BecQH0C5cxwK8DxWNI/OBhtxBahlwGMa+W4mHN
	77gEWGog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwxVx-0000000COay-1ahA;
	Mon, 02 Mar 2026 07:16:25 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwxVu-0000000COaJ-1bmy
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 07:16:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E98F5BD15;
	Mon,  2 Mar 2026 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772435780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfYSDuCA2CAmpRBvPIVlJRBA8l2SvAi2++c+EQu0aU4=;
	b=BjRPlgtS7UEePYDpEfGgxj64kF0Mgw5h74XpDh3+xNOryG6FV6xYQwyAxWtFO08a6/hVuJ
	7WUZ6NqVcoHuFvu1mdHhSIZ8jhA1QEe9jnlMc/R2/iuSQQCVf/knbI/3QSmX29ea/ll6tt
	xCC8ExW7UiiZDj2usAjNftRZ4QZt4rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772435780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfYSDuCA2CAmpRBvPIVlJRBA8l2SvAi2++c+EQu0aU4=;
	b=q0TaBDcOUUYZUlXMbznEjIV4WvqHz1e5AjxQiuBxqTI+q/cECHfXNhlmz5bmxGK4GYsksa
	N07pYCHOEuwe61Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772435780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfYSDuCA2CAmpRBvPIVlJRBA8l2SvAi2++c+EQu0aU4=;
	b=BjRPlgtS7UEePYDpEfGgxj64kF0Mgw5h74XpDh3+xNOryG6FV6xYQwyAxWtFO08a6/hVuJ
	7WUZ6NqVcoHuFvu1mdHhSIZ8jhA1QEe9jnlMc/R2/iuSQQCVf/knbI/3QSmX29ea/ll6tt
	xCC8ExW7UiiZDj2usAjNftRZ4QZt4rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772435780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfYSDuCA2CAmpRBvPIVlJRBA8l2SvAi2++c+EQu0aU4=;
	b=q0TaBDcOUUYZUlXMbznEjIV4WvqHz1e5AjxQiuBxqTI+q/cECHfXNhlmz5bmxGK4GYsksa
	N07pYCHOEuwe61Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BA6D3EA69;
	Mon,  2 Mar 2026 07:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WsoZCUQ5pWnhZgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 07:16:20 +0000
Message-ID: <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
Date: Mon, 2 Mar 2026 08:16:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during async
 scan
To: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
 Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de, chaitanyak@nvidia.com,
 bvanassche@acm.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, James.Bottomley@hansenpartnership.com,
 emilne@redhat.com, bgurney@redhat.com
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp> <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aaCNtpPzP9TIDNjE@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_231622_580887_F579B229 
X-CRM114-Status: GOOD (  16.39  )
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

On 2/26/26 19:15, Keith Busch wrote:
> On Thu, Feb 26, 2026 at 11:35:15AM -0500, John Meneghini wrote:
>> It's worse than this.  Yes, in RHEL we carry out of tree patches to tun off the async scanning with SCSI,
>> and we reverted this async namespace scanning patch in NVMe.
>>
>> We had to do this because, as soon as we turned these async scanning mechanisms on, we immediately
>> received customer escalations. Customer were not able to upgrade their systems. We have customer issues
>> and complaints open about this and we see this async namespace scanning as a barrier to adoption with NVMEe -
>> especially with NVME-OF which tends to have many more Namespaces than PCIe.
> 
> Sounds like some people just don't know how to use labels or persistent
> names. Relying on /dev/nvmeXnY or /dev/sdX to always be a handle to the
> same device is a fragile solution.
>   
Yeah. We have undergone this (admittedly, rather painful) process quite 
some time back for SLES (with the switch from SLES12 to SLES15 if memory
serves correctly). Since then our customer seem to be happy with using
persistent device links.

>> And yes, the PCIe async discovery stuff does cause some problems.  The difference is: the PCIe bus configuration does
>> not change nearly as often as, e.g., the nvme namespace configuration in a fabric, so customers don't notice the changing pci ids.
>> Unless some one is going lots of hot unplugging and plugging with their PCI bus, the PCI ids typically don't change at all.
> 
> It's not about the PCI topology changing. The async probe makes it
> non-deterministic as to which PCI device is going to claim which
> instance out of the nvme ida since they all try to run concurrently.

I really would like to go with the nsid based solution from Keith.
That would avoid quite some cumbersome code here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

