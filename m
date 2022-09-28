Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E00BC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwyYcyRWyD6T3/+cAdbuRNZHC4lkTBZ9XduTwv83xqk=; b=SpgOyL0dxeJ/eoa8/TDys0sPG4
	WpoVeMwBHuL2qHUKcYxPY9mTx0/4JhCh5wqIel4B/llqH4zFLJk6AjQkl34h5dDwxKOCrFa4CiM0u
	EJI0BLtXMcCtMywmiHsC2HJ1eDWpUstYHc+15PFfdOSNBumN3EZG/52LvH4vjAU+WLlseDYCtZPEj
	rsbE05285FeTnITLquCIhCpjUmd0OXHBX2YbfV+rTXUw/dNLJUNtDPD4ztDjA0iNNjfE9cpHlp4gQ
	n3A9dwi77kFeuXBlm4NRCYG2bctBxgwX6MG5fB37kmAe3+rpBlekNyactUOQeKBaoUhS3gqvhCrIT
	ZqlftI5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYYe-00GlzE-Gm; Wed, 28 Sep 2022 15:01:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYYb-00Glxi-FV
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 15:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664377262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwyYcyRWyD6T3/+cAdbuRNZHC4lkTBZ9XduTwv83xqk=;
	b=Thh3yUXoqJ7ro5eumx8IZjaEisxD0L5aVc2MEYQpfPH1AAUs+i7A002GdksSAGUF7y8g77
	O9Qp8o0wx3wL3pr1IbbWY0pUgsh2h6mDX0dWbiaaXojMZIBRcp1FhDDLHwkqezllebTQw9
	BUOq0Y0OtG2joTlreEbuM7kKg1ftXNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-L5jGKAfOPHSSf0shPoebMA-1; Wed, 28 Sep 2022 11:01:01 -0400
X-MC-Unique: L5jGKAfOPHSSf0shPoebMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE8BD857D12;
	Wed, 28 Sep 2022 15:01:00 +0000 (UTC)
Received: from [10.22.8.53] (unknown [10.22.8.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E96240C95A0;
	Wed, 28 Sep 2022 15:01:00 +0000 (UTC)
Message-ID: <6e172046-53e7-d2cb-38b8-e87d725046de@redhat.com>
Date: Wed, 28 Sep 2022 11:01:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
To: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "hare@suse.de" <hare@suse.de>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_080105_639072_F9959167 
X-CRM114-Status: GOOD (  40.90  )
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

Fred, what's the difference between a "reset" and a "connection loss".

As Daniel explained, the problem case in question involves a controller that "disconnects" from the network, and then reconnects 
after a HA takeover/giveback event. And the fact is, this controller is changing the number of IOQs after the 
"disconnect/reconnect".

So this is one place where I think we conflate NVMe-oF with NVMe in the specification.  If "reset" == "disconnect", then 
Daniel's patches just implemented support for something which is forbidden by the spec - a controller that changes the number of 
IOQs between resets.

/John

5.27.1.5 Number of Queues (Feature Identifier 07h)

This Feature indicates the number of queues that the host requests for the controller processing the
command. This feature shall only be issued during initialization prior to creation of any I/O Submission
and/or Completion Queues. If a Set Features command is issued for this feature after creation of any I/O
Submission and/or I/O Completion Queues, then the Set Features command shall abort with status code
of Command Sequence Error. The controller shall not change the value allocated between resets. For a
Set Features command, the attributes are specified in Command Dword 11 (refer to Figure 322). For a Get
Features command, Dword 11 is ignored.


On 9/28/22 08:39, Knight, Frederick wrote:
> Would this be a case for a new AEN - controller configuration changed?  I'm also wondering exactly what changed in the controller?  It can't be the "Number of Queues" feature (that can't change - The controller shall not change the value allocated between resets.).  Is it the MQES field in the CAP property that changes (queue size)?
> 
> We already have change reporting for: Namespace attribute, Predictable Latency, LBA status, EG aggregate, Zone descriptor, Discovery Log, Reservations. We've questioned whether we need a Controller Attribute Changed.
> 
> Would this be a case for an exception?  Does the DNR bit apply only to commands sent on queues that already exist (i.e., NOT the connect command since that command is actually creating the queue)?  FWIW - I don't like exceptions.
> 
> Can you elaborate on exactly what is changing?
> 
> 	Fred
> 
>> -----Original Message-----
>> From: Daniel Wagner <dwagner@suse.de>
>> Sent: Wednesday, September 28, 2022 5:03 AM
>> To: Sagi Grimberg <sagi@grimberg.me>
>> Cc: linux-nvme@lists.infradead.org; Shinichiro Kawasaki
>> <shinichiro.kawasaki@wdc.com>; hare@suse.de; Knight, Frederick
>> <Frederick.Knight@netapp.com>
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
>> On Wed, Sep 28, 2022 at 11:31:43AM +0300, Sagi Grimberg wrote:
>>>
>>>>>> In order to be able to test queue number changes we need to make
>>>>>> sure that the host reconnects.
>>>>>>
>>>>>> The initial idea was to disable and re-enable the ports and have
>>>>>> the host to wait until the KATO timer expires and enter error
>>>>>> recovery. But in this scenario the host could see DNR for a
>>>>>> connection attempt which results in the host dropping the connection
>> completely.
>>>>>>
>>>>>> We can force to reconnect the host by deleting all controllers
>>>>>> connected to subsystem, which results the host observing a
>>>>>> failing command and tries to reconnect.
>>>>>
>>>>> This looks like a change that attempts to fix a host issue from
>>>>> the target side... Why do we want to do that?
>>>>
>>>> It's not a host issue at all. The scenario I'd like to test a when
>>>> target changes this property while the host is connected (e.g.
>>>> software updated -> new configuration). I haven't found a way to
>>>> signal the host to reset/reconnect from the target. Hannes suggested
>>>> to delete all controllers from the given subsystem which will
>>>> trigger the recovery process on the host on the next request. This makes
>> this test work.
>>>
>>> But that is exactly like doing:
>>> - remove subsystem from port
>>> - apply q count change
>>> - link subsystem to port
>>>
>>> Your problem is that the target returns an error code that makes the
>>> host to never reconnect. That is a host behavior, and that behavior is
>>> different from each transport used.
>>
>> Yes, I try to avoid to trigger the DNR.
>>
>>> This is why I'm not clear on weather this is the right place to
>>> address this issue.
>>>
>>> I personally do not understand why a DNR completion makes the host
>>> choose to not reconnect. DNR means "do not retry" for the command
>>> itself (which the host adheres to), and it does not have any meaning
>>> to a reset/reconnect logic.
>>
>> I am just the messenger: Besides Hannes' objection in the last mail thread, I
>> got this private reply from Fred Knight:
>>
>>     Do Not Retry (DNR): If set to ‘1’, indicates that if the same command is
>>     re-submitted to any controller in the NVM subsystem, then that
>>     re-submitted command is expected to fail. If cleared to ‘0’, indicates
>>     that the same command may succeed if retried. If a command is aborted
>>     due to time limited error recovery (refer to the Error Recovery section
>>     in the NVM Command Set Specification), this bit should be cleared to
>>     ‘0’. If the SCT and SC fields are cleared to 0h, then this bit should be
>>     cleared to ‘0’.a
>>
>>     It simply makes NO SENSE to retry that command. If the device wants the
>>     host to retry, then it will clear DNR=0.
>>
>>> In my mind, a possible use-case is that a subsystem can be un-exported
>>> from a port for maintenance reasons, and rely on the host to
>>> periodically attempt to reconnect, and this is exactly what your test
>>> is doing.
>>
>> Yes and that's the indented test case. The number of queue change is on top
>> of this scenario. It's a combined test case.
>>
>>>> Though if you have a better idea how to signal the host to
>>>> reconfigure itself, I am glad to work on it.
>>>
>>> I think we should first agree on what the host should/shoudn't do and
>>> make the logic consistent between all transports. Then we can talk
>>> about how to write a test for your test case.
>>
>> Fair enough. This here was just my cheesy attempt to get things moving.


