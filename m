Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47727C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZXpcopgfjV4IQOkDA8ZDLPpADRvWAQ28wmPHFKfWvk8=; b=VqFPZnztuEHJYYUXRB+a8nN+uS
	Y99cAXvVacXWnlsFyHOjO79w7iXi8ZUbf/aitIakPIBbNY7Gs5WdCsWmhIBvL3JZfZFAex0HFMCiN
	fwzbA2qvY8ogeU1Dk/inZlDc8PJ1vO54kg2AkTMm8BgmEbGsap2/Tt+4dJiTWMArMqfojkqm+/n8m
	+ZvL/hF/D60mKiE028PLlSwvVuZTbbXZCAzpScULj56vEA6L7eK69OW5kwd/T/e2Ugoj+qWcSIkE0
	rkh6sj7kdLH887fLVNAsAeyjCoLzV0CXXbXIJTUAoLbp1c4r9JxcNrxeecosr8JdM4H79jJI3p0Kk
	T0mX11vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z3V-0000000EaVR-2As8;
	Thu, 24 Apr 2025 16:04:05 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vPK-0000000DyTh-0AQx
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 12:10:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 899A61F44E;
	Thu, 24 Apr 2025 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745496620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXpcopgfjV4IQOkDA8ZDLPpADRvWAQ28wmPHFKfWvk8=;
	b=Z+TnmlSJq0Hp3Ydhacir7K5kAMJdOB/XjX+bHym09XC/hlAnacLbbFfCHm+Jq/0iq65zlS
	EkVOTU6JtlR/5qc1rtbB25lfk3sR9tyOOBL1V/TknfyGDPPsTrAE9o5sTnRzidsMUy6AQy
	eTPe7E7AAsFHWKlvdCkQ4cl0g3kDDNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745496620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXpcopgfjV4IQOkDA8ZDLPpADRvWAQ28wmPHFKfWvk8=;
	b=SLD6AS08fiPrQmjCgEy/XDOSMdL0PqLGI12aMpBLkIxiUJhD1fTPiywX1sTluGvK1V/vnL
	R8bwurOKjzaUfXAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745496620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXpcopgfjV4IQOkDA8ZDLPpADRvWAQ28wmPHFKfWvk8=;
	b=Z+TnmlSJq0Hp3Ydhacir7K5kAMJdOB/XjX+bHym09XC/hlAnacLbbFfCHm+Jq/0iq65zlS
	EkVOTU6JtlR/5qc1rtbB25lfk3sR9tyOOBL1V/TknfyGDPPsTrAE9o5sTnRzidsMUy6AQy
	eTPe7E7AAsFHWKlvdCkQ4cl0g3kDDNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745496620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXpcopgfjV4IQOkDA8ZDLPpADRvWAQ28wmPHFKfWvk8=;
	b=SLD6AS08fiPrQmjCgEy/XDOSMdL0PqLGI12aMpBLkIxiUJhD1fTPiywX1sTluGvK1V/vnL
	R8bwurOKjzaUfXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EBAE1393C;
	Thu, 24 Apr 2025 12:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gMHoGSwqCmhbSAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 12:10:20 +0000
Message-ID: <8a3093b6-d5b2-496d-828a-0667abbf1670@suse.de>
Date: Thu, 24 Apr 2025 14:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] nvmet-fcloop: don't wait for lport cleanup
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-10-3d7f968728a5@kernel.org>
 <05ac9a81-66a9-4bbc-92e0-6ff47a6dc7ad@suse.de>
 <c1f207f3-6657-4803-90df-a059353ba6da@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c1f207f3-6657-4803-90df-a059353ba6da@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_051022_230295_0F595273 
X-CRM114-Status: GOOD (  17.70  )
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

On 4/24/25 13:48, Daniel Wagner wrote:
> On Thu, Apr 24, 2025 at 12:21:09PM +0200, Hannes Reinecke wrote:
>>> @@ -1776,7 +1763,7 @@ static void __exit fcloop_exit(void)
>>>    		spin_unlock_irqrestore(&fcloop_lock, flags);
>>> -		ret = __wait_localport_unreg(lport);
>>> +		ret = __localport_unreg(lport);
>>>    		if (ret)
>>>    			pr_warn("%s: Failed deleting local port\n", __func__);
>>>
>> And who is freeing the allocated fcloop_lsreq structures?
> 
> After a fcloop_lsreq is allocated it is put on either rport->ls_list or
> tport->ls_list and later freed in fcloop_tport_lsrqst_work, resp.
> fcloop_rport_lsrqst_work for the non-error case (or in the callbacks).
> 
> That means when the localport is unregistered successfully there are no
> fcloop_lsreq around. The issue is what to do when __localport_unreq
> returns an error.
> 
> This code could loop forever when the port_state is not in
> FC_OBJSTATE_ONLINE when calling nvme_fc_unregister_localport(). This
> should not happen (it did before this series) but now it shouldn't be
> the case anymore. I suppose a pr_warn_once() and a sleep might be a good
> idea to avoid a busy loop?

My point was more: you call kmem_cache_destroy() unconditionally upon
exit. But the boilerplate says that you have to free all allocations
from the kmem_cache before that call.
Yet the exit function doesn't do that.
Question is: what are the guarantees that the cache is empty upon exit?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

