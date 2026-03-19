Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8281090223
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iJ67ZEcQlfHCV6n4G8T+L/tnVcxOhUiK60LDZquNYo=; b=hhkk/AXwXPb7UEbqcDPwA+1ScY
	eS2+c7k8c8iLZwWPiehWzlhb12wM5yu0oFLLT/mP3uNU6MjG19mus55Wd+ZA/vzzkxgsUtj4cc84b
	sl81MnivmhpFqRY9B/B7vR7OD6VZse2STG/6i2eD4psQvyKFpRk8rDdZjrjYWQksrOIlK4o0bSZH9
	4509NT/TPspmKxHMq0N/FMq20ptXGY30G4OuDNyh1Io+lQcBDffbGI2QXIgapqFnzEy64GvFEF4zT
	/KqX0wpmg3Nlb/vHKNb0hwJsOuTD5UjI/BUsOyZpjo8ZhZdMuCpjpdeRclslt+9/DckNoUcTfWPIR
	2Fo//rHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3D6j-0000000Aery-3CvA;
	Thu, 19 Mar 2026 13:08:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3D6a-0000000Aerb-1HGc
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 13:08:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FF604D1F7;
	Thu, 19 Mar 2026 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773925680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iJ67ZEcQlfHCV6n4G8T+L/tnVcxOhUiK60LDZquNYo=;
	b=EtNH8yvOD/DxqRmAELhOC3cneJYlQax8yVjSVDLVxdrIJ6HkQ4kZxV8g0eZcWsj255Kg/N
	laoU3cdGAlURwL+CypVcKJk6WWhmgw0Zs2xHNp+oBRIWKty74qjc1BV87aAEoKRa6H/th6
	NSM/vWoHpk7JCAWHO9KqnpsQMZ0GpHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773925680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iJ67ZEcQlfHCV6n4G8T+L/tnVcxOhUiK60LDZquNYo=;
	b=DZMYkjaZoPSl8ctiyUv7ARwjBl3FqNigbZAHlkA8gHvAXdFQ9hMqLEHcb3H+jEiIxyZ7PU
	FqPhlfYFJ73IKNBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773925680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iJ67ZEcQlfHCV6n4G8T+L/tnVcxOhUiK60LDZquNYo=;
	b=EtNH8yvOD/DxqRmAELhOC3cneJYlQax8yVjSVDLVxdrIJ6HkQ4kZxV8g0eZcWsj255Kg/N
	laoU3cdGAlURwL+CypVcKJk6WWhmgw0Zs2xHNp+oBRIWKty74qjc1BV87aAEoKRa6H/th6
	NSM/vWoHpk7JCAWHO9KqnpsQMZ0GpHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773925680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iJ67ZEcQlfHCV6n4G8T+L/tnVcxOhUiK60LDZquNYo=;
	b=DZMYkjaZoPSl8ctiyUv7ARwjBl3FqNigbZAHlkA8gHvAXdFQ9hMqLEHcb3H+jEiIxyZ7PU
	FqPhlfYFJ73IKNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62A1E4273B;
	Thu, 19 Mar 2026 13:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xG+aFzD1u2nXIQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 19 Mar 2026 13:08:00 +0000
Message-ID: <9d6bda08-8eaf-430b-8cd9-2bd16c5f96cc@suse.de>
Date: Thu, 19 Mar 2026 14:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] demo Linux nvme initiator driver stretched and
 dispersed subsystems
To: Randy Jennings <randyj@purestorage.com>,
 lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
References: <CAPpK+O3zB4Y7L6u0jmVkM2eQs2D1DEJJMG_AXgM+HBs4wkLStg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAPpK+O3zB4Y7L6u0jmVkM2eQs2D1DEJJMG_AXgM+HBs4wkLStg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_060804_559206_0CD2798A 
X-CRM114-Status: UNSURE (   8.37  )
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

On 2/14/26 02:16, Randy Jennings wrote:
> I'd like to demonstrate the Linux nvme initiator driver interacting
> with a stretched and a dispersed subsystem, run through some workflows
> and illustrate usecases that are possible with one and not the other.
> No, this is not necessarily production code.
> 
Hey, cool, then I can run my sheepdog nvme cluster alongside with that.
Will be fun.

So naturally I'd be interested here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

