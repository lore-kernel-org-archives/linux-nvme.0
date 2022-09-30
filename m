Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F4EC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3piMJgMuCHvsR8IpEv+GYPy6kVTtF3MBR9aVipOlheQ=; b=I5JNOTYbop5fzfr3cACuZfTn1q
	twCFdLHuyGb0DptVt+j53a8qBOIzSm84C1Wp79+JVrZ6ietSCsZU7tQe2zPJDHT0EzZ7bsPdV+kIe
	eOHlz8naYDGoFGa05vEVJL7Izrms+x2TBb0oE3dE70lekiCfAs/JPk9Aj/BUGKYp688rrH/rJZIqZ
	V3+bllxFeo5BsvHylaLEb5cgf9zF3XiwemzNr4JLeXy9vVxRJoaL0OVJpy4dZk7NvWNycKU4eu9r5
	hoW3HJiCWoH5RILtuv3Fm4GLKFbIexStBb0XXdigsTB3nEMWX+qmwfzATs6B8hUMWpwHCIk/Uy1id
	EPVHWz9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9Zx-007X9t-W5; Fri, 30 Sep 2022 06:32:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9Zs-007X8S-B7
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 06:32:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49F2E21886;
	Fri, 30 Sep 2022 06:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664519570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3piMJgMuCHvsR8IpEv+GYPy6kVTtF3MBR9aVipOlheQ=;
	b=Y04Naebv6+Go0ZhyFkjXmxUC1bZFv3jRp46CPSD0F+22jkntiTKSYXyYjRDoWzrdGPyV7+
	J2s6oY+u0c3GMrS6gnKT2nMdFSHLi8p0RvpVo85wGlsarIBxiuIZwydzfcdspB6cTOIgob
	rtcnHoN8GPIcR6Lzs2uYGxY5T4AkjkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664519570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3piMJgMuCHvsR8IpEv+GYPy6kVTtF3MBR9aVipOlheQ=;
	b=iTv0vmsN199Zz/1zFwnu6rr2pXdMt8GPqowneUXM+OU4BNfRA3DPSz3GUzrCUf4AB2Z9OC
	1f0cpT7vjsNbUkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27AAD13776;
	Fri, 30 Sep 2022 06:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +Ja0BpKNNmOlFAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 30 Sep 2022 06:32:50 +0000
Message-ID: <5506f1d3-3f46-9be4-ae22-66bbc4f053bd@suse.de>
Date: Fri, 30 Sep 2022 08:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 Daniel Wagner <dwagner@suse.de>, John Meneghini <jmeneghi@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <6e172046-53e7-d2cb-38b8-e87d725046de@redhat.com>
 <20220928152616.inzetc3fsvnhb3o5@carbon.lan>
 <DM8PR06MB7704CA28602F1367574EB23CF1549@DM8PR06MB7704.namprd06.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DM8PR06MB7704CA28602F1367574EB23CF1549@DM8PR06MB7704.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_233252_546400_9586F508 
X-CRM114-Status: GOOD (  16.10  )
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

On 9/28/22 20:02, Knight, Frederick wrote:
> Reset and Disconnect are different.
> 
> Reset uses registers (and therefore Get Property and Set Property commands) over a valid connection.
> 
> Disconnect causes a reset (you have to reconnect to the reset controller)
> Reset does not cause an immediate disconnect.
> 
This probably is a confusion with how the linux implementation works.
For linux NVMe-oF a reset is equivalent to a reconnect (ie disconnect 
followed by a reconnect), as for linux _any_ error will be escalated to 
be equivalent to a connection error.
Hence a pure 'reset' using Get/Set Property is never attempted.

Cheers,

Hannes

>> -----Original Message-----
>> From: Daniel Wagner <dwagner@suse.de>
>> Sent: Wednesday, September 28, 2022 11:26 AM
>> To: John Meneghini <jmeneghi@redhat.com>
>> Cc: Knight, Frederick <Frederick.Knight@netapp.com>; Sagi Grimberg
>> <sagi@grimberg.me>; linux-nvme@lists.infradead.org; Shinichiro Kawasaki
>> <shinichiro.kawasaki@wdc.com>; hare@suse.de
>> Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue
>> changes
>>
>> NetApp Security WARNING: This is an external email. Do not click links or
>> open attachments unless you recognize the sender and know the content is
>> safe.
>>
>>
>>
>>
>> On Wed, Sep 28, 2022 at 11:01:00AM -0400, John Meneghini wrote:
>>> So this is one place where I think we conflate NVMe-oF with NVMe in
>>> the specification.  If "reset" == "disconnect", then Daniel's patches
>>> just implemented support for something which is forbidden by the spec
>>> - a controller that changes the number of IOQs between resets.
>>
>> FWIW, the scenario I described is from a real world experience. So even if it
>> is forbidden by the spec, it exists.

-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


