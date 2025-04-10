Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C592C3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 06:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KxM0vf9TGnF3rFfgsbUO4/ZY3QUP1HedEJ5lUENadDY=; b=VSOKDuC6/MTj0uBqyAaeoHJlYK
	X26Ak1fDkraTSFAbD8gUQj1YTxwcuSolx+vnU5vP6UOuMKjAK9ItyNX3HZs0WxpX7+007jnZ5Zt0P
	YD3DzTr7lSZC0lPHrWhAR23Mthn/y3XolzbqFrkj5bZP3BB+roRfTxyndiJGYw15/v+QgEz4YUQ2M
	CiOQr1m76PDrlpZWooI3MJFuOdScceGija9PWAW2RU4YrauF9afiqiE2FrFrhasnKAiSmNKTg8aB3
	97UkWMqsam7llq4M1F97mQttb9cBk9J5KBsZPH6bdbDw0U9ZgOF64Aaj/Tna5i0HFtYHS1+tVC4hn
	2EbyqUEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2l9Y-00000009L99-1yJ0;
	Thu, 10 Apr 2025 06:12:44 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2l9U-00000009L8H-0uc6
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 06:12:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84EAD2116E;
	Thu, 10 Apr 2025 06:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744265558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxM0vf9TGnF3rFfgsbUO4/ZY3QUP1HedEJ5lUENadDY=;
	b=zpb1dG/64gRcpJzAsE6A7LTbiWq1EZz81Gze/RWl3suvtyOS9OGnoZhrC9HDJg/HXW7DoG
	Je+nbJ55jMZ3BrWCtlMhY2/QGc3VWe4SwKSbTbiVF39v02qc2cxigqUnYSwLEBs9KV7lE0
	CbCglW6v2Jp9xcunSfIBdtUOQF4B7eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744265558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxM0vf9TGnF3rFfgsbUO4/ZY3QUP1HedEJ5lUENadDY=;
	b=mmerWcotLQYG7DHkZ471PI+H3eUHtOaEdjkSKlBuWfLceHERnLgErhlKnzCWonhYYp6xVR
	Z6FKcKjqak5Ra4Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744265558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxM0vf9TGnF3rFfgsbUO4/ZY3QUP1HedEJ5lUENadDY=;
	b=zpb1dG/64gRcpJzAsE6A7LTbiWq1EZz81Gze/RWl3suvtyOS9OGnoZhrC9HDJg/HXW7DoG
	Je+nbJ55jMZ3BrWCtlMhY2/QGc3VWe4SwKSbTbiVF39v02qc2cxigqUnYSwLEBs9KV7lE0
	CbCglW6v2Jp9xcunSfIBdtUOQF4B7eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744265558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxM0vf9TGnF3rFfgsbUO4/ZY3QUP1HedEJ5lUENadDY=;
	b=mmerWcotLQYG7DHkZ471PI+H3eUHtOaEdjkSKlBuWfLceHERnLgErhlKnzCWonhYYp6xVR
	Z6FKcKjqak5Ra4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37371132D8;
	Thu, 10 Apr 2025 06:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ytYFC1Zh92edZQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 10 Apr 2025 06:12:38 +0000
Message-ID: <3bdf1edb-a3de-408b-97ae-d995d1af77a5@suse.de>
Date: Thu, 10 Apr 2025 08:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvmetcli restore fails in add_subsystem
To: Daniel Wagner <dwagner@suse.de>, Anton Gavriliuk <antosha20xx@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <wagi@kernel.org>,
 linux-nvme@lists.infradead.org
References: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
 <Z_Y3AYFzE3L2ujBW@infradead.org>
 <527963f3-1b89-4604-bc76-b3a18bb330a6@flourine.local>
 <CAAiJnjoft3gSsg-TYgyiBVpWiTjWztF=3E-aJpuaeZLCNrT-hg@mail.gmail.com>
 <ab6c0856-8398-4bc2-881e-ebf1ff80934c@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ab6c0856-8398-4bc2-881e-ebf1ff80934c@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[suse.de,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_231240_414606_8222654D 
X-CRM114-Status: GOOD (  15.89  )
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

On 4/9/25 14:13, Daniel Wagner wrote:
> On Wed, Apr 09, 2025 at 02:58:17PM +0300, Anton Gavriliuk wrote:
>> The link - https://documentation.suse.com/sles/15-SP6/html/SLES-all/cha-nvmeof.html
>>
>> is quite confused me,
>>
>> 17.4.3 Marvell
>>
>> FC-NVMe is supported on QLE269x and QLE27xx adapters. FC-NVMe support
>> is enabled by default in the Marvell® QLogic® QLA2xxx Fibre Channel
>> driver.
> 
> I think this paragraph only talks about the host side support.
> 
>> So if "the qla2xxx driver or/and the HBA firmware do not support the
>> target mode anymore.", it is not clear, will NVMe/FC target work with
>> QLE269x and QLE27xx adapters or not.
> 
> Let me back paddle a bit. My failed attempt (or that one from my
> colleague) might just be a bad combination of driver/HBA. Without asking
> Marvell directly it's not clear what the status is.
> 
No need. I did, and the status is 'not supported'.
Driver support for nvmet on qla2xxx is missing, and
Marvell has no intention of bringing it back.

(Which really is a bit ironic, seeing that the _have_
target mode support for SCSI. But what do I know...)

I had some patches somewhere at some point; I can see
to dig them up if there is interest.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

