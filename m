Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B20E8B383
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XETh7uCfctdGb2OZaPCWSvV9qkq65+YtZRyPRLnjLfk=; b=TccADd8FbbkT01bTOfdQxu1K06
	xvw7dz+Y/lQZAQlLLDX8MOImpYraIdtVEj5ozjHyIOzo/2YgVs6yqu8h3a+ZNmv/sn7wsluoSJO+L
	WxsdhQze7ySuD3XfczNM/gNdCzorD93RznyfWA6YAqiszJ0mC+tzEC4ca2u8RQYi1l/a9BhYMcXNE
	Op25shz+GNXRYFgMtbkxQfxyxoo3ZLxUrKX8jxFO/K1kgrFZmUUliqhJh5lIWU/KEkjneRa0XijIS
	GK1SOuQOUFIVy3Mcxcf/iCC7iObC10Y5wK3b7BwcgerRwH+A7Y/W1DfP+IcC3B9o1yYxHX3PSlOAw
	pqHXiwtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnS27-00000007irR-05Jv;
	Wed, 04 Feb 2026 01:50:19 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnS23-00000007ir7-3HSg
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 01:50:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B93253E6D0;
	Wed,  4 Feb 2026 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770169813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XETh7uCfctdGb2OZaPCWSvV9qkq65+YtZRyPRLnjLfk=;
	b=vU9zoOyp349s/aG2IT6k/xJnwMCRRDxxoTK+LtqrIwCALmDFWPTGtc1h9IY9JywsIQ+Mlw
	4CYPG00fF9OQox4O65gncw7mkBk95Z5RptgkXOW7/PoexZMgpx0Rb/+FiY2DbgNWbqOVgv
	+ZBBz+T6p5B5EkqaSCpoN2Q1A+mZMf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770169813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XETh7uCfctdGb2OZaPCWSvV9qkq65+YtZRyPRLnjLfk=;
	b=LMXLdI7dvfSqtNnieS2F+jjWzWT9qQIx/s56aDg9lyX1BaNNrf+gFk5rI1qKR4zt/5ag51
	WDm+wJi7YYEI55AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vU9zoOyp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LMXLdI7d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770169813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XETh7uCfctdGb2OZaPCWSvV9qkq65+YtZRyPRLnjLfk=;
	b=vU9zoOyp349s/aG2IT6k/xJnwMCRRDxxoTK+LtqrIwCALmDFWPTGtc1h9IY9JywsIQ+Mlw
	4CYPG00fF9OQox4O65gncw7mkBk95Z5RptgkXOW7/PoexZMgpx0Rb/+FiY2DbgNWbqOVgv
	+ZBBz+T6p5B5EkqaSCpoN2Q1A+mZMf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770169813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XETh7uCfctdGb2OZaPCWSvV9qkq65+YtZRyPRLnjLfk=;
	b=LMXLdI7dvfSqtNnieS2F+jjWzWT9qQIx/s56aDg9lyX1BaNNrf+gFk5rI1qKR4zt/5ag51
	WDm+wJi7YYEI55AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 055D93EA63;
	Wed,  4 Feb 2026 01:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YXvBKtOlgmltaQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 01:50:11 +0000
Message-ID: <940f623e-face-4eff-829e-bd1e449ecb62@suse.de>
Date: Wed, 4 Feb 2026 02:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BFP TOPIC] Block-layer device resets
To: Ming Lei <ming.lei@redhat.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <aYFoBafih46bLK0T@fedora> <65937263-912c-4250-af26-054b2b6be72b@suse.de>
 <aYKdWsdnSVrZ3UC7@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aYKdWsdnSVrZ3UC7@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B93253E6D0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_175015_972997_48F2B9BB 
X-CRM114-Status: GOOD (  20.16  )
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

On 2/4/26 02:14, Ming Lei wrote:
> On Tue, Feb 03, 2026 at 06:51:25AM +0100, Hannes Reinecke wrote:
>> On 2/3/26 04:14, Ming Lei wrote:
>>> Hi Hannes,
>>>
>>> On Sun, Feb 01, 2026 at 06:06:52PM +0100, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> We are currently working on implementing cross-controller resets for
>>>> NVMe, which requires to send a command to the target which then should
>>>> terminate all commands on a given controller.
>>>
>>> Can you provide a little background why this reset is required? And for
>>> solve which problem?
>>>
>> Sure. It got triggered by me wanting to use a ublk device as a backing
>> device for nvmet namespace.
> 
> ublk supports it, either delete & re-add the disk or use UBLK_F_USER_RECOVERY &
> UBLK_F_QUIESCE for keeping disk node.
> 
>> During a nvme reconnect the target is supposed to abort/flush all
>> outstanding commands on the backing device. As this is a block device
>> we would need to have an interface into the block layer allowing us
>> to do so.
> 
> It could be hard to provide such generic(ioctl) block interface:
> 
> 1) use queue freeze
> 
> - hang risk, because some or many block devices don't implement timeout or
> error handling
> 
> 2) use queue quiesce
> 
> - still need driver cooperation for draining the inflight IOs
> 
> Basically the hard part is in driver side.
> 
Exactly. If there are drivers which do not implement a timeout handler
we're kinda screwed. But for those we should not implement a device 
reset function, or rather return an error when that function is called.
For all others invoking the timeout handler on all outstanding commands
(and waiting for completions) would be equivalent to a device reset;
for some implementations (like NVMe) is _is_ equivalent to a device reset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

