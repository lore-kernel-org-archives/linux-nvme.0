Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C106C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 05:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JIubfwrceQcv8oTjm12olDHY+Ob8MNaMCr62aIwPn1c=; b=kBGbTe8yZjBXz0FzqoaTj8vg/K
	JD7jotvJly1PPxVbYVHQwdOZ/0v4f6d8YeONDzPSDPcWVnoZ38jLXBOLd0MKeCFVNdPtTQ/krQdZ8
	15yvwk3uMLyQEp5esh4rzP004cjM2eN28K6hYuWv6UJBKBeEJv25mAp+V83eKwgqiBVrVEP8C6q9X
	VlbpwIVXrW7Rz2k8Z9BSTh45yoRPosymxiGBJ3Eej0RkcNjh48NaH8LBkcrBY19pndZlQ6+hsl3tA
	c9r0sYE496UFWKKiNMugcijEQGXtQCkV4zbe4Te6kjWw5t56j3V2xwzOjYctQ1yl1awMenW/vrx38
	8a4Kp9HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbc1h-00HCHK-7L; Tue, 05 Apr 2022 05:46:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbc1e-00HCFA-OJ
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:46:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B39A1F37E;
 Tue,  5 Apr 2022 05:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649137601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIubfwrceQcv8oTjm12olDHY+Ob8MNaMCr62aIwPn1c=;
 b=1ypckcO5XwZwZcrx3+OZOgUW8jDu4UZPQYM3JmL99BwQtbGv9fD1zRKMU4aYV7DCjB5Imn
 DwCTZLM6VIngdmgz2FxjCoKMYlLqlJI8200e3UzQW/jgZnsqQoYNA9yPpOwbBvYaaKJixM
 gZ3zJosh83qrk15tJoxgwEoYGkcAqIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649137601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIubfwrceQcv8oTjm12olDHY+Ob8MNaMCr62aIwPn1c=;
 b=2G/os9q+3cSWHM3wMLRzxs1TQwiDxX9XrhZuZ4VkK18OlICBt4HK5nm78tFQjIv+J+Weop
 QU5+Z2n4tFi3mgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1456E13216;
 Tue,  5 Apr 2022 05:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jiMgA8HXS2IdSAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 05:46:41 +0000
Message-ID: <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
Date: Tue, 5 Apr 2022 07:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, util-linux@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220405054205.GA23466@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_224646_979294_4E40F81D 
X-CRM114-Status: GOOD (  15.95  )
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

On 4/5/22 07:42, Christoph Hellwig wrote:
> On Fri, Apr 01, 2022 at 11:28:55AM +0200, Hannes Reinecke wrote:
>> It is really annoying to always have to loop through the entire
>> /sys/block directory just to find the namespace path links for
>> a single namespace in libnvme/nvme-cli.
>> So provide links to the namespace paths for efficient lookup.
> 
> I think having some form of links would be useful.  Quite a while ago
> Thadeu looked into adding some form of relationship for lsblk and
> friends.  Maybe it would be good to sync up and make sure whatever
> links we are adding would be useful for all users?
> 
Care to elaborate?
Using the block device name is the most straightforward way here; we 
don't have a good enumeration to leverage as the paths are essentially 
just a linked list.

We sure can have a subdirectory 'paths', and stick the links in there.
If that helps with lsblk ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

