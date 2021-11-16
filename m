Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB78C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 06:59:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE44461B2A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 06:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE44461B2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDi2oLQN37KSpFnEau2UHutm0p9f3irDDFOCLAkeUAU=; b=Erlmb7JLqE3silIpTzCTvOClzw
	bnyLU+lKvxc0Q3OukmzJAzCMKEfGJMKZkqNM7Y/iMMXM37GMrkPVgl1lE3P+j+OQc5skt6oCleGub
	IP/vqoI9W2qAvdfIpv7BSGjijAHv2i5pcTZz9JztFr3lAxy2/0IwkuYNRGOPxucyMtagBmykmP8Ui
	ylAbQKv/bz3sb+MwxmyK9BXD4N/OqAiG1faAJdJfJivBDF46L/cxQ+5PoEQD78ven3CRM1zCpnUZA
	Z8JzrSLMTRwCXV56Zpcy2yk5WTLBFJ2FJAQCV4ZwrjbjmIaj7ky3GRvMFeAhd8bnAIEzBVUgq+u0d
	v6TrOYVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmsRW-000XC8-QS; Tue, 16 Nov 2021 06:59:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmsKY-000UpE-V0
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 06:52:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E62D1FCA1;
 Tue, 16 Nov 2021 06:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637045551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDi2oLQN37KSpFnEau2UHutm0p9f3irDDFOCLAkeUAU=;
 b=sDs0QdTYFLpPUFgWXCvSYxx8kMIIwbmJyfU/BHKHZ94dS6OCwDlW0i/0c24+tDhaEKOyoa
 DsE07AOyEdMcpFAYy/NERyknQORWnRR3ZOVc8Z9s9TjAvPimBurZn0azcSoZOS/s7DzP+3
 9HqNtlC2WkI98EI9RmgMwH7DgwBjekM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637045551;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDi2oLQN37KSpFnEau2UHutm0p9f3irDDFOCLAkeUAU=;
 b=MkaWwX+Ku+zYiyYjMpubpvYcSvVyc1dKapD5bRrogCfWnJ7fnUHTyN/OH6yxzG9MN1lBe6
 Y6t12pLJxMqg5nBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73E0B13B65;
 Tue, 16 Nov 2021 06:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bGkIGy5Vk2GzSgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 16 Nov 2021 06:52:30 +0000
Subject: Re: [PATCH] nvme: honour O_NONBLOCK during resetting
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211111105953.63072-1-hare@suse.de>
 <9c8da771-c5f9-923c-4c03-5d5ac8392ef8@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b1c012d9-475a-8c71-cb00-4b5dfedd0a33@suse.de>
Date: Tue, 16 Nov 2021 07:52:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9c8da771-c5f9-923c-4c03-5d5ac8392ef8@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_225235_189339_D666E767 
X-CRM114-Status: GOOD (  20.21  )
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

On 11/16/21 2:40 AM, Chaitanya Kulkarni wrote:
> On 11/11/2021 2:59 AM, Hannes Reinecke wrote:
>> When opening a controller device node we should honour the O_NONBLOCK
>> flag to allow the device to be openend even if it's in state 'resetting'
>> or 'connecting'. This allows user-space applications to use a call to 'open'
>> to figure out if the controller is present, even if it's currently
>> undergoing a reset.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> Will resetting and connecting ever result is deleting the controller due
> to error cases present in that path ?
> 
Yes, of course this might happen.

> If yes then application will have handle for something that might
> go away in the future, should allow such a semantic ?
> I am not sure I follow.
Even today an application can open the device, and even now error 
recovery can result in the device now going away.
And even today it'll be possible that error recovery sets the device
to 'RESETTING' after the open call.

So I don't think that we need to treat things special because of this patch.

Whether or not the call to nvme_dev_ioctl() should be protected by an 
explicit state check is a different point, though; that does have some 
benefits seeing that the timing between open() and ioctl() is pretty 
much up to the application, and hence we shouldn't assume that the state 
doesn't change in between.
But really it should be done in a different patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

