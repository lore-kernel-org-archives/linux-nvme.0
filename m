Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B59C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:37:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698E361008
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698E361008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LkGIT4Gl9YAD2nYarxJ1DcBjxxOs58mjVQiTchVR36I=; b=InGIkMF4OCytThQogopHDvT9A
	a5rbWf7qiJPsNeq06FHy7J57/kWtPANoesefJ+Jt0sexydGKm7LW8ZjU8l0hTCsCc71vM48kSIYoO
	dCE5rv02DetNrLdA04W+QrkY9F6f3fTPQbwvG3XLHW9MEWY/31zNcMSKmeMDFh+t8pVLC0a3A7+76
	iGbROGPJs17UXP7H7XlMrLUKeHEVvznhh4vRktyHoZlYaqnTZcveT9GIVJa5GM3qfA6z/9v/XY4pp
	we6afKKgymj+ismogFHLWJgojEuEUKg+KO974iknu9ZvtVDuUINpavrmYd2ifFgRCXe83k0V2m0OB
	aS1tSvkTw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRjSs-007s5u-Ju; Wed, 31 Mar 2021 22:37:30 +0000
Received: from mail-qk1-f176.google.com ([209.85.222.176])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRjSo-007s55-S8
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 22:37:28 +0000
Received: by mail-qk1-f176.google.com with SMTP id i9so448350qka.2
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 15:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+C5LPs0kaCkAOGtyUr9wjTwxTgqJsfzOVQYj3EvBqCI=;
 b=R6QRUW4IsX6+Ic63CoDXDfX3jliwVJPM/7ElTHjyI4c4uWtnYSKrl7KbCJvP15ksqN
 VVMzkhIkmaNJSKG2NkjvyhmX1JQ5uLe38HVH08VrOQUFPoiSjQVaSlR0o2tbSJ3bPdGH
 wToVCMzNJJ/iVcVjiqI/6dsAnDY8ZN8mg7N1xqunSmz1rLuTCPo7ks8YoF0pfKxp8gsp
 WJM7GwXH4+qQy+WKJrOAC0f9lmSmkV5PhpVVY3U8UUzL90RQDYag337cBa6NBa9MMLpE
 cfMNhKNZ882MBOhpeHanzyYnA8O2pES0CvVS/Oy/MKwrf7QiwlinBV1LNE0dORp+j2o+
 Ea2Q==
X-Gm-Message-State: AOAM5326fnK/kVbHrxwWx7cGGmC78FlERQQbl+t4iYuwr8rV1uY2L5Fj
 o41HL21MpgGHdxt2TDxMiIU=
X-Google-Smtp-Source: ABdhPJwnyEfjA2R/2V/L5FusNudKlixHn/eMgkOOFBgpwD1Qrw1jiioFMoTF3opfrajqk0ksYE1MFg==
X-Received: by 2002:a37:bc45:: with SMTP id m66mr5692073qkf.82.1617230244711; 
 Wed, 31 Mar 2021 15:37:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id j18sm2387930qtl.83.2021.03.31.15.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 15:37:24 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: Keith Busch <kbusch@kernel.org>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
Date: Wed, 31 Mar 2021 15:37:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_233727_015263_109AF9E4 
X-CRM114-Status: GOOD (  23.94  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> It is, but in this situation, the controller is sending a second
>>>> completion that results in a use-after-free, which makes the
>>>> transport irrelevant. Unless there is some other flow (which is
>>>> unclear
>>>> to me) that causes this which is a bug that needs to be fixed rather
>>>> than hidden with a safeguard.
>>>>
>>>
>>> The kernel should not crash regardless of any network traffic that is
>>> sent to the system.  It should not be possible to either intentionally
>>> of mistakenly contruct packets that will deny service in this way.
>>
>> This is not specific to nvme-tcp. I can build an rdma or pci controller
>> that can trigger the same crash... I saw a similar patch from Hannes
>> implemented in the scsi level, and not the individual scsi transports..
> 
> If scsi wants this too, this could be made generic at the blk-mq level.
> We just need to make something like blk_mq_tag_to_rq(), but return NULL
> if the request isn't started.

Makes sense...

>> I would also mention, that a crash is not even the scariest issue that
>> we can see here, because if the request happened to be reused we are
>> in the silent data corruption realm...
> 
> If this does happen, I think we have to come up with some way to
> mitigate it. We're not utilizing the full 16 bits of the command_id, so
> maybe we can append something like a generation sequence number that can
> be checked for validity.

That's actually a great idea. scsi needs unique tags so it encodes the
hwq in the upper 16 bits giving the actual tag the lower 16 bits which
is more than enough for a single queue. We can do the same with
a gencnt that will increment in both submission and completion and we
can validate against it.

This will be useful for all transports, so maintaining it in
nvme_req(rq)->genctr and introducing a helper like:
rq = nvme_find_tag(tagset, cqe->command_id)
That will filter genctr, locate the request.

Also:
nvme_validate_request_gen(rq, cqe->command_id) that would
compare against it.


And then a helper to set the command_id like:
cmd->common.command_id = nvme_request_command_id(rq)
that will both increment the genctr and build a command_id
from it.

Thoughts?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
