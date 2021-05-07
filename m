Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE39AC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 20:26:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44ED56105A
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 20:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ED56105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/wxWANhSZ/i+hd57vFwhR16NngkFaWhywW/pBt0SkRg=; b=nex3hm3g8HXLqIy/WLPvw/c1A
	YqW20jkRBC687Mbjip4pd/OD5jfkDKbQ/sx7d6tWaiEzAB1eKWsm/8JbbV04arB0Z2t+HcnvYiWj6
	vsyuNvMJ4rLnMTEhiB2C8Zj+uEqF8McwBSQNF0TQwLV0hjUPe7cNDM/6XvoMUiYgjWXtyaDzt6Ct2
	OdG6eoadXHAzitnHGeC+o1BB/CkM1XcqRZkwMmBxXRWXhACTyadyJ3p9GFzlFHTfWnpe3y6o4VLpI
	WwFHA8jovklz8g4SAqNHl4nSrHkLWVe4tU6+haENfittQvDqm4yhkhO3vnEB8gim22kMc0efSEljH
	vzMd1kgjg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf73G-007yod-VJ; Fri, 07 May 2021 20:26:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf73E-007ynU-Ov
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 20:26:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=G5Dj7xf+sVdRQrmQbHMKvBQI4KOrg3DBvLtqt8G7Bcg=; b=mmUxvGKt3+mxuhnZ4qBx4yVzu5
 SNl4/dEq3C02ExFL193I/Alnhb2FYtxTgFwcsMZ7MBP+X2JozE67LI3AfU9FLxgXUpvWtxl0jw5jm
 k7ZL0xyy5p5A51x9uVUEJ/qiqX8OA1o+D0HbxwCh8kjdNp8jERaSko/NKkbotmz0HgKVHC+YTfYvs
 cANWB0lQzC716fnI7m3G5SZGIF7e47JNmkFoEqbXbr2GIcbbhXHRTqqjk0ui4mVVeTfjSJpYWfcl+
 lKiZNRPqYPdtls37sdxUcG7cqsa8yv6R5SpfoGcB6sfpwJyM5QZxwAPTpNweSJ5ptemR2BWjTndT5
 NX4EKbRQ==;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf73C-007AGz-7Y
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 20:26:19 +0000
Received: by mail-wr1-f42.google.com with SMTP id l2so10459716wrm.9
 for <linux-nvme@lists.infradead.org>; Fri, 07 May 2021 13:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G5Dj7xf+sVdRQrmQbHMKvBQI4KOrg3DBvLtqt8G7Bcg=;
 b=TuFvWnJ3F5zrXQGSxM1fGHIxkzPsENnZoZz+T312udwTAnsKnVUSGA9S2X1k5DGDc9
 fSRkNn+hDH+NNUAt6wxs8NtL1D8CWe4hj/g+MlyZii0cexcrjTf8qDw4ai/Z67qE5KDI
 I4ObCUgCN5PxlDZKY+j7HjurNFxZo9qhFSJPtn/r7yEyO+y/WzXaKuZgCgw2O2bBXqBt
 H+9xTODwxrdnHc+T6RuG3V5vJb7Clp+3rbUr7ezYVGv0eqslxZ5jJLPj5TngFCRw/YyK
 GjeTu3I23Y3Mbxx5UmEwD4/01smsT8v+hmSJ+Px8wbus0ghXQi4mI2fFtaVZL7vWaulm
 I8bQ==
X-Gm-Message-State: AOAM5320k9/Bxq/mIKdDyAiHqyXSe95JIx24LRgq2qcMcqufAilRUgr2
 +P7gPEhmFoXgY9sAiVjL+nfTpRhhM1A=
X-Google-Smtp-Source: ABdhPJznuHeBi55SYkOi3MFFtmtgE1bb7MfHWenG7VSp9fbCcsC5Rx9QONWy7uDJoihJXl7tzacGFQ==
X-Received: by 2002:adf:f1cf:: with SMTP id z15mr14977362wro.97.1620419176461; 
 Fri, 07 May 2021 13:26:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d07b:68ce:2d70:258f?
 ([2601:647:4802:9070:d07b:68ce:2d70:258f])
 by smtp.gmail.com with ESMTPSA id y21sm14193258wmc.46.2021.05.07.13.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 May 2021 13:26:15 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
Date: Fri, 7 May 2021 13:26:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_132618_304159_40FDD22E 
X-CRM114-Status: GOOD (  18.51  )
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


>>>> I would also mention, that a crash is not even the scariest issue that
>>>> we can see here, because if the request happened to be reused we are
>>>> in the silent data corruption realm...
>>>
>>> If this does happen, I think we have to come up with some way to
>>> mitigate it. We're not utilizing the full 16 bits of the command_id, so
>>> maybe we can append something like a generation sequence number that can
>>> be checked for validity.
>>
>> That's actually a great idea. scsi needs unique tags so it encodes the
>> hwq in the upper 16 bits giving the actual tag the lower 16 bits which
>> is more than enough for a single queue. We can do the same with
>> a gencnt that will increment in both submission and completion and we
>> can validate against it.
>>
>> This will be useful for all transports, so maintaining it in
>> nvme_req(rq)->genctr and introducing a helper like:
>> rq = nvme_find_tag(tagset, cqe->command_id)
>> That will filter genctr, locate the request.
>>
>> Also:
>> nvme_validate_request_gen(rq, cqe->command_id) that would
>> compare against it.
>>
>>
>> And then a helper to set the command_id like:
>> cmd->common.command_id = nvme_request_command_id(rq)
>> that will both increment the genctr and build a command_id
>> from it.
>>
>> Thoughts?
>>
> 
> Well, that would require a modification to the CQE specification, no?
> fmds was not amused when I proposed that :-(

Why would that require a modification to the CQE? it's just using say
4 msbits of the command_id to a running sequence...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
