Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E027FC7618E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KbZzYtgch/j/JowiijonddcrISQhU6+U83on77P+9Vs=; b=DBBnxiy1O7T6zXJDoYjAnZAWqT
	tPTZqoYATYscqiyZg6sXIfXzJMj8I07EigLkihtF0J6Nobn3chCqjmdSvP0yORuR+aks0A23gEwQX
	NyBlQCAdrH+0EeGyvKTepudXn1/9HPAcRUy86QgHm+EN3DsSv0F/dxEoANBiHfbOG/f5XrrbLMON1
	gFPTB3PyyC55xA/SoGLFStk/lPzfgJ/tqZW3647pfRxVzXi1OQHiao/iF355YybjVWCB+kge1JouE
	14EENAU9WbWWiwGwjR+lC5JfHzDm3dS/JRuAfL68GYI6zYnn6WfE6IM+M34Pd0JcorW8sPPXIvDAK
	Hz1fIxWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prdMi-003lhw-38;
	Wed, 26 Apr 2023 11:31:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prdMg-003lhG-2T
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 11:31:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3F5D1FDCD;
	Wed, 26 Apr 2023 11:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682508672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbZzYtgch/j/JowiijonddcrISQhU6+U83on77P+9Vs=;
	b=e223qV3eaqv1CfLvOnL8hdGW1IcmkXNpddoJbpP+m+HEPtbyX4DaE+rHPqaDQpgxi4vCc+
	A/pPb+JKvFW3znfGfhS/oZ2KtE76nPqpxkPZJC06MjKQ3+wxEv/xvKdocDMUjajNrSdQxl
	4EYVad4J6qHJaPhnmOeAcNLY0YYcayg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682508672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbZzYtgch/j/JowiijonddcrISQhU6+U83on77P+9Vs=;
	b=D3fSclO8lqECKuooIPrzkJubR8Jf81E2inM9H9YkL45SBMcR3vdq08Qw2NzDv7P2ArRwdh
	2UdyVzkbfiq445Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FFB9138F0;
	Wed, 26 Apr 2023 11:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0W78GoALSWTsfAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 26 Apr 2023 11:31:12 +0000
Message-ID: <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
Date: Wed, 26 Apr 2023 13:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Content-Language: en-US
To: Li Feng <fengli@smartx.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
 <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
 <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_043114_945827_9E291FD7 
X-CRM114-Status: GOOD (  27.75  )
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

On 4/25/23 10:32, Li Feng wrote:
> Hi Sagi,
> 
> On Wed, Apr 19, 2023 at 5:32 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>>> Hey Li,
>>>>
>>>>> The default worker affinity policy is using all online cpus, e.g. from 0
>>>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
>>>>> have a bad performance.
>>>>> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
>>>>> socket worker threads.  The parameter is a comma separated list of CPU
>>>>> numbers.  The list is parsed and the resulting cpumask is used to set the
>>>>> affinity of the socket worker threads.  If the list is empty or the
>>>>> parsing fails, the default affinity is used.
>>>>
>>>> I can see how this may benefit a specific set of workloads, but I have a
>>>> few issues with this.
>>>>
>>>> - This is exposing a user interface for something that is really
>>>> internal to the driver.
>>>>
>>>> - This is something that can be misleading and could be tricky to get
>>>> right, my concern is that this would only benefit a very niche case.
>>> Our storage products needs this feature~
>>> If the user doesn’t know what this is, they can keep it default, so I thinks this is
>>> not unacceptable.
>>
>> It doesn't work like that. A user interface is not something exposed to
>> a specific consumer.
>>
>>>> - If the setting should exist, it should not be global.
>>> V2 has fixed it.
>>>>
>>>> - I prefer not to introduce new modparams.
>>>>
>>>> - I'd prefer to find a way to support your use-case without introducing
>>>> a config knob for it.
>>>>
>>> I’m looking forward to it.
>>
>> If you change queue_work_on to queue_work, ignoring the io_cpu, does it
>> address your problem?
> Sorry for the late response, I just got my machine back.
> Replace the queue_work_on to queue_work, looks like it has a little
> good performance.
> The  busy worker is `kworker/56:1H+nvme_tcp_wq`, and fio binds to
> 90('cpus_allowed=90'),
> I don't know why the worker 56 is selected.
> The performance of 256k read up from 1.15GB/s to 1.35GB/s.
> 
>>
>> Not saying that this should be a solution though.
>>
>> How many queues does your controller support that you happen to use
>> queue 0 ?
> Our controller only support one io queue currently.

Ouch.
Remember, NVMe gets most of the performance improvements by using 
several queues, and be able to bind the queues to cpu sets.
Exposing just one queue will be invalidating any assumptions we do,
and trying to improve interrupt steering won't work anyway.

I sincerely doubt we should try to 'optimize' for this rather peculiar 
setup.

Cheers,

Hannes


