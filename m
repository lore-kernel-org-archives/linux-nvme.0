Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA09C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9KHPusLkeeSZaKzrjxL0S9fErLApUHFSosdaAVdonY=; b=419wcWjR+siZl/DkvI6lwpnVo5
	h9W6f3/VRwSln/5oaHTYUeP9pLEYky08mnqpGt53921iDc5Flcgyp8s5rnyOuTjTvN9vnSUhF532a
	7i/sdU7hoR1iXCSF7dMxK/t4L/7fmrh845wm4anWS9ISErYehkk21Y9lMJUMf+07jIew05TmH8WrW
	2QbzBIq8bw4DieRVYPISRbI4R2AFNFHCMPsUvn5cwXfedMNQ24f5KKH542uDfkJdKhTpKSQvlFQhG
	SDcCl4mUA/tveUCSo/ekyHxp0zC25wg3xSXsGVibXl//BRBP5iNZuduyEZ6WYTiWjz27TDmmAewDZ
	W53d5Rgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT3Mo-000000017Lt-1a0R;
	Thu, 25 Jan 2024 17:18:18 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT3Ml-000000017KG-03Ei
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 17:18:16 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so94423139f.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jan 2024 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706203092; x=1706807892; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9KHPusLkeeSZaKzrjxL0S9fErLApUHFSosdaAVdonY=;
        b=U+zDjsGQ5ekCAOMzM8S2edH6ap/IY5lEax3t+FvLBqK1aqzBFtZFquMJXqT6iJ1A2w
         WTA+hGl7UKSwWKHEw1ueeR3ydN/AdXY/2gNwQpRCzZkDdBaPwjqHTtANCYuG/iFxucJL
         iIti4rOyj6WjpRsrEDJnhIlFV30WPyOIdi4sAcjNOZDv7K3SQG8n+XCuJiN/Ppv0TpNV
         eqWTuRL4nA5OZhqrcFhgJYuqQQ/uPsNBu0Y8fvfAzvRpMVf3IRyh6akxr7KBR1MKyZaF
         MgV9K/HXZJEDU/oYrBrO9WG4JdzcC/mqUlxbTudf/9XShVrsNgkQ4P236lh8tie1uSQr
         CG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706203092; x=1706807892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9KHPusLkeeSZaKzrjxL0S9fErLApUHFSosdaAVdonY=;
        b=tfn+6WGUtyrYMIsr16wIgW1/H/uNG8hZtf1SeF4SQNaUA8j1fZzTSrwqTsFy8hWPPH
         +dIbIUESReQEy23kSftZb4CsnD2mYLAqKlyy1USTTgbQYnRV+ci9pYl+2Q6G3N9jRFwC
         tz8bLyFkvvIRVrCqArx2yPxRVbVRvaZpzGu+juSfEi8ryGI+SyBuWzrCXNqOP//C1YiI
         E+dpWUF64IZFLdyyInGCxtQ5nWAm0jguRFAbovOj9i9t/aqeDjzD4h21d4WMF4a4nNNx
         AXkdav3qm7vz1SJx4oKjNLpyly7YLs/x8480KKpvuogF/Nea0Ikb27lL7bgMIs7mkGOo
         E2KA==
X-Gm-Message-State: AOJu0Yw/7cWz4A62kyfooErqCD4s3v2uD1RCP0BI4hDH8p/N+U0Q1623
	heZoHFgmE1FcmXKDAopXiMc6ZNK+kvYgj3MJYfmdqsBlq1US1em4e/d8ImhaETc=
X-Google-Smtp-Source: AGHT+IGa5TY6l3IqwQ0KME1s66hmaoprNLTeupS99w4phA9YQky5FZ1dAsRV4XHOSmAWx+Mk5mbNdQ==
X-Received: by 2002:a05:6e02:1d8d:b0:35f:bc09:c56b with SMTP id h13-20020a056e021d8d00b0035fbc09c56bmr67427ila.2.1706203092099;
        Thu, 25 Jan 2024 09:18:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cr4-20020a056e023a8400b003627dd3822bsm2961611ilb.77.2024.01.25.09.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 09:18:11 -0800 (PST)
Message-ID: <53d98444-16b1-48bb-a3f2-ecd897a29299@kernel.dk>
Date: Thu, 25 Jan 2024 10:18:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: enable retries for authentication commands
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: hare@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Martin George <marting@netapp.com>
References: <20240125130906.94874-1-hare@kernel.org>
 <13922738-7cdb-457d-9ba6-4a3a9a064a8b@kernel.dk>
 <20240125154814.GA23800@lst.de>
 <b3e68e05-f698-4fbc-87a7-99f7461d88be@suse.de>
 <aa4a3561-2ecc-4e64-895f-356405dc14c3@kernel.dk>
 <d4a814f5-0dc9-46d9-8c5c-eaa31cd889f4@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d4a814f5-0dc9-46d9-8c5c-eaa31cd889f4@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_091815_124635_6C78069B 
X-CRM114-Status: GOOD (  18.85  )
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

On 1/25/24 10:09 AM, Hannes Reinecke wrote:
> On 1/25/24 17:50, Jens Axboe wrote:
>> On 1/25/24 9:20 AM, Hannes Reinecke wrote:
>>> On 1/25/24 16:48, Christoph Hellwig wrote:
>>>> On Thu, Jan 25, 2024 at 08:42:10AM -0700, Jens Axboe wrote:
>>>>> On 1/25/24 6:09 AM, hare@kernel.org wrote:
>>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>>
>>>>>> Authentication commands are normal NVMe commands, and as such
>>>>>> can return a status where NVME_SC_DNR is not set, indicating
>>>>>> that the command should be retried.
>>>>>> Rather than checking NVME_SC_DNR manually for each command completion
>>>>>> this patch adds a flag 'retry' to __nvme_submit_sync_cmd(), causing
>>>>>> the REQ_FAILFAST_DRIVER option to be cleared and the command to
>>>>>> be retried via the normal mechanism.
>>>>>
>>>>> Can we please do this without adding Yet Another parameter to that
>>>>> function?
>>>>
>>>> Heh, I wrote about the same reply a few minutes ago.  I'll try to think
>>>> what we can do instead.
>>>
>>> We could do something like this:
>>
>> That won't really do much, and yeah wouldn't be the way even if
>> complete. How about just not setting the flag in the first place?
>> nvme_init_request() defaults to doing it, so either pass in the init
>> flags to that, or just clear it in there and have the callers decide if
>> they want to set it.
>>
> But that's the thing; the request is never visible to the caller.
> So moving things out of the nvme_init_request() doesn't really help.
> 
> And open-coding __nvme_submit_sync_cmd() also doesn't look very
> appealing.

__nvme_submit_sync_cmd() already takes another bool (at_head) and blk-mq
flags. You could have it take some nvme specific flags instead, and fold
those two parameters into a single flags. Once that is done, adding the
retry flag on top would be trivial.

And as a side benefit, it gets RID of a bool flag rather than add
another random one.

-- 
Jens Axboe


