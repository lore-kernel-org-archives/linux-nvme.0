Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B487FC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nE9ejF0uN7/UhQ5WhYz8z7DMRlddxoOcgzZ1ba4TBHc=; b=PCTukBxV5ofaIYKXo4EKrtr3wU
	QQ6GD6L4F3FAumnNObRPs6eNueMNzfQkNqeglFaJSj9o00YyklmtYrTCHhltkBbW4qMqg74Kj0Rzs
	yzTr+mciRAFEw9u6asvPTMl6NlSKvSsPC1ak7T3PZbsdI1GgwgZyl6jlZO3y1YC8hr+NQU9eqSHJf
	O+oKfrjoHcTQdXAPFYG4GPTgXbrE4qX/QXvJkN8jSsnGDt8thboZySXMqZw3HhrH/vhdXxJFgTV/Z
	BT7dsCIOfz7HyGO34zMpOG+m8nHX6VNL1gROm4VNn2dEN2+4wyuRtRtB3fWpJMyvdyX7tiz/J21ne
	lZ6hC5ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh7hL-008dTH-LB; Wed, 20 Apr 2022 10:36:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh7hG-008dPD-96
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 10:36:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A38571F750;
 Wed, 20 Apr 2022 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650450988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nE9ejF0uN7/UhQ5WhYz8z7DMRlddxoOcgzZ1ba4TBHc=;
 b=l4Pk9PhBAVoP94IAiFODngxmRqH6XDNodMvcNemAtCwR/95mbZCEDERlA91pzUZfqLK4wf
 h5ILrmHJKC9kT5DXQYCJMn6zzvo+hYFzTIm1e5DwGWX9J5M08WMioKABjF1FJcRXJ5fE+z
 AP/BU8qTlabqC6qvmYgPsNTpi0F2QRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650450988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nE9ejF0uN7/UhQ5WhYz8z7DMRlddxoOcgzZ1ba4TBHc=;
 b=BTA+ccQQu9Acf2tFnFgIJQGxRCHZjheuVAzKdsQxISRVhZh2bkuFQx6lNmxuBQDmX993fp
 1JIj12GLDnlYqcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D59313AD5;
 Wed, 20 Apr 2022 10:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2fqOHCziX2KYLwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 20 Apr 2022 10:36:28 +0000
Message-ID: <4454d299-1890-a60b-b931-0d33a007a1fe@suse.de>
Date: Wed, 20 Apr 2022 12:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
 <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
 <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: can't run nvme-mp blktests
In-Reply-To: <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_033630_547081_329514B8 
X-CRM114-Status: GOOD (  11.94  )
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

On 4/15/22 20:09, Bart Van Assche wrote:
> On 4/15/22 10:59, Luis Chamberlain wrote:
>> That's about 3 block folks not being sure whether or not it helps. And
>> the complexities of it, to test it, requiring a different kernel seems
>> just stupid. So I'm going to drop the tests from kdevops and not bother
>> with them.
> 
> How about modifying the nvmeof-mp tests such that these use NVMe
> multipathing instead of the dm-multipath driver?
> 
I'd rather enable the nvme tests to work with rdma_rxe / siw. It should 
already work with TCP, so hooking in rdma_rxe and/or siw would be the 
logical step.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

