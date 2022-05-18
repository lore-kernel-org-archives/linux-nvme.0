Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01B1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 07:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5i67IRZUWh6H4k0Lxd0QpcjTTp3wGYXXb5+WyloeGIA=; b=Ie+2gdKEoY2PS2PeW9sGp6Casr
	dQ87XNm+d6i50pMMSlXrLNLS9p/T0+3WYIstrkOuNBWzfAK+aH+ZFpy6NdhPS7QHZhKHt5cO+kA2b
	VRirqOHwaa69fzRj3Q4BfM+ci7IKy82LJe3HoZqc7xkMKxgsZQHvTUHn9LVzCVNeQS/f56FSw10SL
	EerEBWRsAUnzcbnoABDhgMocEgNaGw2Qqgp26KsifT5VdbxWSFrd+bvL26ldjUQ5NKrEJ3eYEnwED
	+jixf4FTqELA1SU4uttUHqwLyn0p7TORWeNQFwRhr3YAZaGXVnnq4gSrU3JMPe6+Ca+n5nzdF1MnJ
	2klTT6sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrEBr-0006TP-I2; Wed, 18 May 2022 07:33:51 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrEBp-0006SX-1i
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 07:33:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 974471F9A5;
 Wed, 18 May 2022 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652859227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5i67IRZUWh6H4k0Lxd0QpcjTTp3wGYXXb5+WyloeGIA=;
 b=rs4YE8r81XygKk2RtwejdGcaj/+mXr+oykE8VQupYIpVIceyO0hlNhSfC7HI9gq4mc+IFO
 PCPivhzuA+VK4+zqxc+wdpNsXovbDNzcuOq1WtPWvZ5M7gBy4+U/zDYPO+vEO4MUivTLIf
 cZOQIMx0hDOPDzpwO4+pG583WTKGuzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652859227;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5i67IRZUWh6H4k0Lxd0QpcjTTp3wGYXXb5+WyloeGIA=;
 b=iJA93DJSCiaqjkuLAOEdGiXyOrAvScXoQI9Eb14jN52+xSIj45MSqycTDe2r/2H08U++wd
 DgeBI4NWp35bOpAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 871C4133F5;
 Wed, 18 May 2022 07:33:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LlavIFuhhGLtUQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 18 May 2022 07:33:47 +0000
Message-ID: <5ed3aa33-7188-4d84-218a-ae1a50af0ebf@suse.de>
Date: Wed, 18 May 2022 09:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL] nvme updates for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <YoSWZoB1/38DdP4S@infradead.org>
 <8ff06ce2-0aa7-5999-8987-1f9d9935e4e5@suse.de>
 <YoSf2UvYcW9fHebf@infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <YoSf2UvYcW9fHebf@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_003349_297122_40A6FF5E 
X-CRM114-Status: GOOD (  15.83  )
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

On 5/18/22 09:27, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 09:23:45AM +0200, Hannes Reinecke wrote:
>> On 5/18/22 08:47, Christoph Hellwig wrote:
>>> The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:
>>>
>>>     loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)
>>>
>> Hmm. So how do we progress with the authentication patches?
>> Shall I resubmit them?
>> Will you be picking them up?
>> Is there anything I need to fix up?
> 
> I'm a little worried adding it this late in the cycle, especially with
> the (although rather trivial) crypto patches not having any reviews from
> the crypto maintainers.  If you can get those we should be ready early
> for the next merge window which is going to start in just a few days.

Right. Will see what I can do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

