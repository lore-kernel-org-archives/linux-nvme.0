Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDDEC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 07:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lATT1ajd7XImaMdz8eWwci/eTzolvtl0532pwY/I47s=; b=QCa+rZhIWtoadKj63P/aXqfAPQ
	6oqsNw/TVPwtYJH3gpufDVg9d8OZSGDOk16tHWH0wMEwZDibMAk/yg72oG2ST3IfCcKj0PHxt5tZf
	HEhm+FuLwVWhHUZpyh+0JubeqJ57Nl51rZvbcuOU6kHqjaZzi+I+zXXunWTg0YsCQQDHOwZWDQeoM
	9J/Rwnah9+kBIQmB9Ak2esPgn8L+SH36iW5IUJ5RPMcb9pRNB7hFhScu18tYLEWggXSuLp9qwLdV5
	+Zhk5AzAyT8BtH9J3MvPWn5b23ZOHMm02aTne3aSpjIm0B85upkqNjQlakAPzdBaJDkXObUr1Xs5j
	QapH371A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onE4F-0046bg-U6; Tue, 25 Oct 2022 07:09:43 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onE4C-0046bB-JM
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 07:09:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72C2122038;
	Tue, 25 Oct 2022 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666681778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lATT1ajd7XImaMdz8eWwci/eTzolvtl0532pwY/I47s=;
	b=NQ5ZmLpZtmwh9Cz+7k+LN2I0ugYeqms1o7nRVjI8631sW/S0lAxk1vHzfpRimlWZNuWger
	G7KtYS4BKtk+C+C34zCqYwkWwQtLbcHo8tvkBZUOMIY87vYARVVhrQhahBJDOfYxToESHN
	9XkyyadIhnicTO8vHjE5bYzYPcy3hyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666681778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lATT1ajd7XImaMdz8eWwci/eTzolvtl0532pwY/I47s=;
	b=u3JNn899mDqoo8a+MyY4kXbbPJszVVdYM4Xx5YYkunPG/FCQEKXFBnapzPLoJgA+/A+ID/
	up3PTqIl7IMNTaDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B169134CA;
	Tue, 25 Oct 2022 07:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id L6A2EbKLV2MVdQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Oct 2022 07:09:38 +0000
Message-ID: <fb22c7e1-3731-f997-1896-024745082ad7@suse.de>
Date: Tue, 25 Oct 2022 09:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20221024150334.29215-1-dwagner@suse.de>
 <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_000940_798175_8B0D821D 
X-CRM114-Status: GOOD (  18.55  )
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

On 10/25/22 02:54, Chaitanya Kulkarni wrote:
> On 10/24/22 08:03, Daniel Wagner wrote:
>> Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
>> large amounts of requests.
>>
>> Cc: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>> ---
>>
>> IMO, this patch might still be a good idea to add. At least in my test
>> setup where I only have one ethernet port it makes a big difference
>> when accessing the system via ssh. When nvme-tcp is pushing a lot of
>> data via the network, the ssh session is completely blocked by the
>> storage traffic. With it, the ssh session stays responsive. >
> 
> I'm not sure whether it is possible but is there a way to gather
> some form of quantitative data and present it here to we all know
> exactly which aspect is improving by this patch in context of
> "ssd session is completely blocked" ?
> 
Doubt that we can do it. Point is, the send code will run in a tight 
loop, making scheduling of other processes / packets really hard.
So if you have several processes on the same interface (as here with the 
ssh connection) nvme-tcp will eat up the entire bandwidth sending its 
data, and everyone else on the line will suffer.

I guess the same effect could be had by adding a 'schedule()' after each 
nvme_tcp_try_send() call.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


