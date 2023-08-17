Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE58EC27C7A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wcvGdeOK4qprK01doj43YPo0bgWBfSQIPMHcoclwkIg=; b=hhMdTudc11eh3/c2DBK8sJPWHO
	HU7ZvBCHpfkRDX9mIHvAswVp3Q3RebZuuVS3lkJqTANuT4uuje9/2NVudgZVL7w4HtHZf0E33ZKl8
	Y8c0ypSq1g7eug7OisnsVsKeKvsB6XQmIYIUCNAUbHtBtVe/hM5itzxnsZw5usGM4dOdmwVXv5cLC
	jZFQicRP4jbjyqK5iiqwg0bssCGCXYGJqBLWcSOlvcaWLIPXzGwKrndwGakPSNs4NrtUUpiKwf+Wu
	qcTIKyEy8YLk1OfuybLGhFWytkhhpQf0JiccQvUdSZMFwM5Xx+KwELXHt7yW5O5Y5KFq6qGaJoLeg
	kXW/oCAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWZVm-005xRw-1w;
	Thu, 17 Aug 2023 09:41:50 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWZVk-005xRV-1J
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 09:41:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1E6C1F385;
	Thu, 17 Aug 2023 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692265304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcvGdeOK4qprK01doj43YPo0bgWBfSQIPMHcoclwkIg=;
	b=vybMPC2KWZH9f/CD9rCGBPyiEqBTNzeKwr4+LNqjwxryXI7zsvbJO8noQBrmY/kG5vuTM4
	uzKCSYL+oi0DoysRFZtdcfh9p3QTd1ac39NE3lYlPiWpWWX9aW0Lu927oDbzQPaQV6t/97
	wH8KsGT7dYrxpkBiMoESZLvjrjftzdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692265304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcvGdeOK4qprK01doj43YPo0bgWBfSQIPMHcoclwkIg=;
	b=fd535DlcEhccUaRBkZgl4T9XnUD21eBNQ01gBYwbVDm7u223Yne7Tb83c2GWDP9Tej/Qga
	c5ql67pK5vl4q+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 723E81358B;
	Thu, 17 Aug 2023 09:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nOlfGljr3WSTfwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 17 Aug 2023 09:41:44 +0000
Message-ID: <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
Date: Thu, 17 Aug 2023 11:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
 <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_024148_613202_5F548ED0 
X-CRM114-Status: GOOD (  13.08  )
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

On 8/17/23 11:11, Sagi Grimberg wrote:
> 
> 
> On 8/13/23 16:07, Sagi Grimberg wrote:
>>
[ .. ]
>> So I figured that the current approach would be preferable if
>> we accept how to expose that for a given kernel/driver, we can
>> accept dns names, or we cannot.
>>
>> What do others think? Christoph? Keith? Chaitanya?
> 
> Anyone has feedback here?
> 
> Seems that we want this, but the question is how to expose
> a new format of traddr (now can be a dns name) to userspace?

Or have a new token 'traddr_dns' (instaed of 'traddr'), which would
hold the dnsname instead of the ip address.
And reject inputs where both are set.
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


