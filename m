Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC5FC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 05:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mpNoMAFIZmhp+eZjKCfuadk0gU8IP/CoU4sOC6hYgrk=; b=iqGdrc9fCxnYBgXGucNz9nWIsy
	IEorX8GcXl9m2XM1MNLmOm2WVvEJJHNfxBeZWe9y2VF6E6gQlr1iN3BVTbfgE2xpkr9aFY5w8ovP0
	82Oq3AnuP/rumOtAb5wK2Y5oopve+GiMFby3jSAIs5U6dLm3Zmguf7vpWNhQhzBfwYp9IzVZGrpzg
	Sp2hj5Udhh5zrvQ0xR9d5RWojgftrh06X6O4iJ+mZyPX/peN3lL3xZofAKj+/LobXZsJdsadOZDIP
	TQ+3jePsXzwHMMbU272I7m5nq9NDnvCXqasDl6Hoq03WU/N1Qzkv+e57QMeDCEOLu94tvW+ZfeWqO
	GT+HnAVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onZMg-0084lM-G1; Wed, 26 Oct 2022 05:54:10 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onZMY-0084dR-9w
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 05:54:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 776D51FB9E;
	Wed, 26 Oct 2022 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666763637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpNoMAFIZmhp+eZjKCfuadk0gU8IP/CoU4sOC6hYgrk=;
	b=MWxm+Eki32mYqlUkklB2d4kZ9T//HwVq0AI0K74aZjaN8Ohm0lWCPtyzmFEmRVQDngqZ2Q
	Djb5ndROzgiCHTPUkgUF1tkfuxKBOPk1s9L8Hvg2HZG25DrxuKcDXxjXL5qA4J6sFJOelX
	PayKrEf3SEovNyeYxlJtPUOV3m9BqD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666763637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpNoMAFIZmhp+eZjKCfuadk0gU8IP/CoU4sOC6hYgrk=;
	b=rtY/FwHk2fGUQ9wYOdV+IWfUfVkUVCEiKfhbVPIk5QyYT0vaFMbk7DjzB20EgZulDKs470
	26nFOvWeCpsN77AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3818213A3B;
	Wed, 26 Oct 2022 05:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uLgzDHXLWGONcAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 26 Oct 2022 05:53:57 +0000
Message-ID: <5b15d323-bf99-6eab-12e8-251700faf8a0@suse.de>
Date: Wed, 26 Oct 2022 07:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20221025155008.30028-1-dwagner@suse.de>
 <3e102dd5-da6a-cdae-5bf7-6c3f635a9308@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3e102dd5-da6a-cdae-5bf7-6c3f635a9308@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_225402_509087_8AA7AA9C 
X-CRM114-Status: GOOD (  21.87  )
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

On 10/25/22 19:30, Chaitanya Kulkarni wrote:
> On 10/25/2022 8:50 AM, Daniel Wagner wrote:
>> In order to test queue number changes we need to make sure that the
>> host reconnects. Because only when the host disconnects from the
>> target the number of queues are allowed to change according the spec.
>>
>> The initial idea was to disable and re-enable the ports and have the
>> host wait until the KATO timer expires, triggering error
>> recovery. Though the host would see a DNR reply when trying to
>> reconnect. Because of the DNR bit the connection is dropped
>> completely. There is no point in trying to reconnect with the same
>> parameters according the spec.
>>
>> We can force to reconnect the host is by deleting all controllers. The
>> host will observe any newly posted request to fail and thus starts the
>> error recovery but this time without the DNR bit set.
>>
> 
> Without looking into the spec, isn't some sort of AEN should be used for
> this ? please correct me if I'm wrong but deleting all the controllers
> and relaying on reconnect maybe overkill ? if it doesn't exists in
> the NVMe spec then perhaps we should think/work on it to update the
> spec ? Is it worth it ?
> 
Problem is that changing the number of queues on the fly is really 
awkward, _and_ you have the problem that the number of queues is 
negotiated during the 'connect' call. So changing the number of queues 
from the controller side really requires us to reconnect to rectify the 
situation.

And no, I don't think it's overkill. It actually makes the situation 
easier as you start off from scratch with the correct number of queues.

Plus you have to quiesce all queues anyway when changing the number of 
queues; the tagset will be modified, requiring you to stop all I/O when 
doing so. So from the block layer side there isn't much of a difference 
here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


