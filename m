Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29CCC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 23:35:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617B020866
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 23:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XBUdUPF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617B020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9b4DyYMVkK+7kKrIM/Udh5mSUsiopET5HqmgWa3/02A=; b=XBUdUPF75Z6IAiZh1OjVdcot7
	vPU0GcsMGYwb6uzxT7TegqaZ+flZY1I0ndSgJ+D0/PuOerB1W/OWeNQlrdPUgXnyxW96DzHXAHA6J
	ThAupRXmwi9ciEH2e3zsD6lEfFtfcsPkrufZG/TiJ6q11re6umqIzIqUbCuuSyNknVc23T/l7FF3i
	BDOFl0IXD/15+REUQBBu8NVyuQqzdw7Z7gB9TYrI5YCoSenWh8gEUdUNa+7xllQv0KO5/2TmnVGKP
	56MINIkaxdTVgUgFpewRhx5El/ikddfZkCJn4RpnXaxPNyv8UrzDiIcDXP+byk1rTSY3S0eDP3UDC
	CxwmnXz/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4Btt-00047v-Id; Fri, 07 Aug 2020 23:35:49 +0000
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4Btq-00047B-TN
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 23:35:47 +0000
Received: by mail-pg1-f178.google.com with SMTP id h12so1770860pgm.7
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 16:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Z6xg4us9klyutIW9aIQn+0iIZLh+9gAn5/KpmgqWu8=;
 b=JUoRSAChaerzpqQWMot8GNbZC9vKiEcbJYolBJ4ITqg7YkJ18FCPJgQMflKaUIuJNV
 dvCdcH5VsBBGY4c5hPcE14r76ry0KNLThDDPNMpgY6N5nHYQxndnO5dvHIh7P+Ck31Jh
 LimnyeupUKz3NMhaexBl+hDkF5Vhc7TCt+GiDPVsRPsuqeqsXto8Ht+xtw1w2RSZMzqe
 XKuNuOWe2vBCROpVcWmdNtsV5sDwcbENwULpS5w4aLSRwN46lOzmSzCF3piiWY4cBic9
 1Y4FlOgNd7TGBM2sBn0uReyqAdIDP56kRB+JCCxXe91UfbKrEUqDkGAhNw9NMg+RPdbY
 kMgw==
X-Gm-Message-State: AOAM531kC2N7ih2KnYOuwQgROzaMapgC0GWl69xjj3t1jjKj+SeEwkOD
 4Ja0NK7DuBj6KWYw4/6a0qA=
X-Google-Smtp-Source: ABdhPJwBSnLehAvPI+JwFLD7el9EmA7Uj4d8XdvGO1Nk7UUtPu75h3OvaCh4yfpw7fWEfYLo+tNb/Q==
X-Received: by 2002:a63:8943:: with SMTP id v64mr13138426pgd.261.1596843344523; 
 Fri, 07 Aug 2020 16:35:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id z15sm9090661pjz.12.2020.08.07.16.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 16:35:43 -0700 (PDT)
Subject: Re: nvme: restore use of blk_path_error() in nvme_complete_rq()
To: Mike Snitzer <snitzer@redhat.com>
References: <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
Date: Fri, 7 Aug 2020 16:35:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807045015.GA29737@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_193546_982661_91638AB9 
X-CRM114-Status: GOOD (  42.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Ewan Milne <emilne@redhat.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hey Mike,
>>
>>>> The point is: blk_path_error() has nothing to do with NVMe errors.
>>>> This is dm-multipath logic stuck in the middle of the NVMe error
>>>> handling code.
>>>
>>> No, it is a means to have multiple subsystems (to this point both SCSI
>>> and NVMe) doing the correct thing when translating subsystem specific
>>> error codes to BLK_STS codes.
>>
>> Not exactly, don't find any use of this in scsi. The purpose is to make
>> sure that nvme and dm speak the same language.
> 
> SCSI doesn't need to do additional work to train a multipath layer
> because dm-multipath _is_ SCSI's multipathing in Linux.

Agree.

> So ensuring SCSI properly classifies its error codes happens as a
> side-effect of ensuring continued multipath functionality.
> 
> Hannes introduced all these differentiated error codes in block core
> because of SCSI.  NVMe is meant to build on the infrastructure that was
> established.

Yes, exactly my point. blk_path_error is designed to make nvme and 
dm-multipath speak the same language.

>>> If you, or others you name drop below, understood the point we wouldn't
>>> be having this conversation.  You'd accept the point of blk_path_error()
>>> to be valid and required codification of what constitutes a retryable
>>> path error for the Linux block layer.
>>
>> This incident is a case where the specific nvme status was designed
>> to retry on the same path respecting the controller retry delay.
>> And because nvme used blk_path_error at the time it caused us to use a
>> non-retryable status to get around that. Granted, no one had
>> dm-multipath in mind.
>>
>> So in a sense, there is consensus on changing patch 35038bffa87da
>> _because_ nvme no longer uses blk_path_error. Otherwise it would break.
> 
> "break" meaning it would do failover instead of the more optimal local
> retry to the same controller.
> 
> I see.  Wish the header for commit 35038bffa87da touched on this even a
> little bit ;)

I think it did, but maybe didn't put too much emphasis on it.

> But AFAICT the patch I provided doesn't compromise proper local retry --
> as long as we first fix nvme_error_status() to return a retryable
> BLK_STS for NVME_SC_CMD_INTERRUPTED -- which I assumed as a prereq.
> 
> Think of blk_path_error() as a more coarse-grained "is this retryable or
> a hard failure?" check.  So for NVME_SC_CMD_INTERRUPTED,
> nvme_error_status() _should_ respond with something retryable (I'd
> prefer BLK_STS_RESOURCE to be honest).

But blk_path_error semantically mean "is this a pathing error", or at
least that what its name suggest.

> And then nvme_failover_req() is finer-grained; by returning false it now
> allows short-circuiting failover and reverting back to NVMe's normal
> controller based error recovery -- which it does for
> NVME_SC_CMD_INTERRUPTED due to "default" case in nvme_failover_req().
> 
> And then the previous nvme_error_status() classification of retryable
> BLK_STS obviously never gets returned up the IO stack; it gets thrown
> away.

I see what you are saying. The issue is that the code becomes
convoluted (it's a pathing error, oh wait, no its not a pathing error).

>>> Any BLK_STS mapping of NVMe specific error codes would need to not screw
>>> up by categorizing a retryable error as non-retryable (and vice-versa).
>>
>> But it is a special type of retryable. There is nothing that fits the
>> semantics of the current behavior.
> 
> I agree.  But that's fine actually.
> 
> And this issue is the poster-child for why properly supporting a duality
> of driver-level vs upper level multipathing capabilities is pretty much
> impossible unless a clean design factors out the different error classes
> -- and local error retry is handled before punting to higher level
> failover retry.  Think if NVMe were to adopt a bit more disciplined
> "local then failover" error handling it all gets easier.

I don't think punting before is easier, because we do a local retry if:
- no multipathing sw on top
- request needs retry (e.g. no DNR, notretry is off etc..)
- nvme error is not pathing related (nvme_failover_req returned false)

> This local retry _is_ NVMe specific.  NVMe should just own retrying on
> the same controller no matter what (I'll hope that such retry has
> awareness to not retry indefinitely though!).

it will retry until the retry limit.

>  And this has nothing to
> do with multipathing, so the logic to handle it shouldn't be trapped in
> nvme_failover_req().

Well given that nvme_failover_req already may not actually failover this
makes some sense to me (although I did have some resistance to make it
that way in the first place, but was convinced otherwise).

> I think NVMe can easily fix this by having an earlier stage of checking,
> e.g. nvme_local_retry_req(), that shortcircuits ever getting to
> higher-level multipathing consideration (be it native NVMe or DM
> multipathing) for cases like NVME_SC_CMD_INTERRUPTED.
> To be clear: the "default" case of nvme_failover_req() that returns
> false to fallback to NVMe's "local" normal NVMe error handling -- that
> can stay.. but a more explicit handling of cases like
> NVME_SC_CMD_INTERRUPTED should be added to a nvme_local_retry_req()
> check that happens before nvme_failover_req() in nvme_complete_rq().

I don't necessarily agree with having a dedicated nvme_local_retry_req().
a request that isn't failed over, goes to local error handling (retry or
not). I actually think that just adding the condition to
nvme_complete_req and having nvme_failover_req reject it would work.

Keith?

>>> Anyway, no new BLK_STS is needed at this point.  More discipline with
>>> how NVMe's error handling is changed is.
>>
>> Please read the above.
> 
> I agree we'd need a new BLK_STS only if NVMe cannot be made to trap
> NVME_SC_CMD_INTERRUPTED for local retry _before_ considering path
> failover.

Not sure that is better, but we can see a patch first to determine.

>>> If NVMe wants to ensure its
>>> interface isn't broken regularly it _should_ use blk_path_error() to
>>> validate future nvme_error_status() changes.  Miscategorizing NVMe
>>> errors to upper layers is a bug -- not open for debate.
>>
>> Again, don't agree is a Miscategorization nor a bug, its just something
>> that is NVMe specific.
> 
> Right I understand.
> 
> Think it safe to assume these types of details are why Christoph wanted
> to avoid the notion of native NVMe and DM multipathing having
> compatible error handling.  There was some wisdom with that position
> (especially with native NVMe goals in mind).  But if things are tweaked
> slightly then both camps _can_ be made happy.
> 
> There just needs to be a willingness to work through the details,
> defensiveness needs to be shed on both sides, so constructive
> review/consideration of problems can happen.

Agreed.

> Think that has already
> happened here with our exchange.  I'm open to investing effort here if
> others are up for humoring my attempt to explore fixing the issues in a
> mutually beneficial way.  What's the worst that can happen?  My simple
> patches might continue to be ignored? ;)

I won't ignore it, and I apologize of ignoring the original patch 
posted, I guess it flew under the radar...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
