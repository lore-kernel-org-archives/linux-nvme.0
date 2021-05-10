Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE4C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 09:39:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12B06008E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 09:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12B06008E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UpWd8Um6gLo959E72TRwsMGr0SVoIukP/NMQA71mBlA=; b=Vcd41VMyP1GIL/rJF/hVKse15
	AWJK/djSepBsYh4xJ8rsB/5/JXEIOoRkS38Z4MS+DwywHdQ0jnBgwfkRA4JH5WrwBpnwN3bjocgZ3
	ef9yVlYMzTqCIJ4qA87Xvb6betFPn2at8Yh3yNHS/byaM8Gey4zfm4GItKx3sTWHKuanwIf5i4Yf6
	+c1YEyjj1cx6M4EOyjVBABHQ+9J9O/l3pww1gm/hDi3Eft8bhJ7JITSTZgjNwxwvIjUSLKX0kt+9p
	FuZ88HomTIhGXU08fV00BLMpn06eTCWwTfQM4EYQgZY8YVkMH/z4gtP+Wq/Zw7lq+KnUh8PL5Zb/M
	N1hx0Ft1A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgOrF-00GjID-7D; Tue, 11 May 2021 09:39:17 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgEKu-00Fp4x-Fw
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 22:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=wkxtwExi+YhGmS34E1y+JlVNEpKJykap4Jt20LQrnC4=; b=SoKVA77xvhK9DMctUPoQHS04fg
 b65rxdJ175rUH47jAAAFEAYZF98Y4bS4fgB3mebuB/dSH/Tw2TluSNOK7TueDlGxKtUHuGHgy2vcb
 zEmBEtQ8TiB8ebZpceGWkhr+PS+2iHWPfJaX1I2+5IaOKI6w3EURCravfEC5hqmgRyXTKJOj0g1/b
 w6jPngbXHryvHFIi1YmUCtxN9nvCDdvSh9QvNr+f/EFx59VSw6KO5fFosP6M43Fqf1IDHzkQnemsq
 SMMbfEr/wbVVbPq23ZLfK64pkSgDAL8YZH1yUFJm0gnxUITOk3zuGoyFcIO2gff7iZq7Aqsp7ICQm
 lI9X1tUA==;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgEKr-0099m9-ID
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 22:25:10 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so209040pjv.1
 for <linux-nvme@lists.infradead.org>; Mon, 10 May 2021 15:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wkxtwExi+YhGmS34E1y+JlVNEpKJykap4Jt20LQrnC4=;
 b=H03nRZ4zss2BcTqFz+QYiU2I8p3nwL+Z/HTv9FnalhVYLuFJoOWmFN51lTHnCspy/S
 DLV+JOGI853BUlzf50ZabrvJVWvIJBkYwvO4ZsVozYaTXl32jyeTgMafhGr//ZSvR3cE
 /AxbaLm+gJ3M5rg13yIFwuCg2XBWCjU5huJQYfduG8aNF6R6b26MzAdefrIX3iojsIaH
 W26QXVgvt92r/s6QYLSFPH4dPV2nlTK+vRjjgNHk4EYwX2CyRtOJ3gvZOIWrh8sszi+Y
 z2eC6AW8utQbpufgSucWgnrzKCQSRH6II9Vy+/gDOzAP9ezYHJLSEk5N5MG4qmWnNsMo
 eyKA==
X-Gm-Message-State: AOAM530UKFYaxMMIGrrVkP0shdAhGVduNDyy5qlzzZfp1/FJTB1Phz/D
 sn++CDsKkz4n3ytgWxRpCPbUq298mg4=
X-Google-Smtp-Source: ABdhPJw2RvoJOfugyeRuYkLvaW9VDX0SVGf/XhMm1eRdQ4+eFV2eAUBVAMy01wORJX7NGJXj33Qhrg==
X-Received: by 2002:a17:902:ee94:b029:ed:7e2c:7e61 with SMTP id
 a20-20020a170902ee94b02900ed7e2c7e61mr26544107pld.22.1620685506369; 
 Mon, 10 May 2021 15:25:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1522:1d2e:7c9d:185c?
 ([2601:647:4802:9070:1522:1d2e:7c9d:185c])
 by smtp.gmail.com with ESMTPSA id j23sm12365749pfh.179.2021.05.10.15.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 15:25:05 -0700 (PDT)
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210510144906.8305-1-hare@suse.de>
 <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
Date: Mon, 10 May 2021 15:25:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_152509_637677_13AECA64 
X-CRM114-Status: GOOD (  25.20  )
/bin/ln: failed to access
 'reaver_cache/texts/20210510_152509_637677_13AECA64': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_152509_637677_13AECA64 
X-CRM114-Status: GOOD (  20.57  )
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


>> @@ -3605,16 +3608,26 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>>   		head->shared = is_shared;
>>   	} else {
>>   		ret = -EINVAL;
>> -		if (!is_shared || !head->shared) {
>> -			dev_err(ctrl->device,
>> -				"Duplicate unshared namespace %d\n", nsid);
>> -			goto out_put_ns_head;
>> -		}
>> -		if (!nvme_ns_ids_equal(&head->ids, ids)) {
>> -			dev_err(ctrl->device,
>> -				"IDs don't match for shared namespace %d\n",
>> +		/*
>> +		 * If multipath is enabled we might hit an ns head with no
>> +		 * paths, but that doesn't indicate it's a shared namespace.
>> +		 */
>> +		if (!nvme_ns_head_multipath(head) ||
>> +		    !list_empty(&head->list)) {
>> +			if (!is_shared || !head->shared) {
>> +				dev_err(ctrl->device,
>> +					"Duplicate unshared namespace %d\n", nsid);
>> +				goto out_put_ns_head;
>> +			}
> 
> If not multipath, then it is not shared. The above will fail attaching
> single-path namespaces to a known head.
> 
> The rest is similar to something I was working on too, though, so I
> think it's the right direction.
> 
> 
>> +			if (!nvme_ns_ids_equal(&head->ids, ids)) {
>> +				dev_err(ctrl->device,
>> +					"IDs don't match for shared namespace %d\n",
>>   					nsid);
>> -			goto out_put_ns_head;
>> +				goto out_put_ns_head;
>> +			}
>> +		} else {
>> +			/* But the ids might have changed, so reset them */
>> +			head->ids = *ids;
>>   		}
>>   	}
>>   
>> @@ -3764,8 +3777,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>   
>>   	mutex_lock(&ns->ctrl->subsys->lock);
>>   	list_del_rcu(&ns->siblings);
>> -	if (list_empty(&ns->head->list))
>> -		list_del_init(&ns->head->entry);

Hannes, you sent a patch like this before, my comment was that a nshead
should be removed before the final reference (which who knows when it
will ever arrive) as if a nsid were to be reused by the controller for
a different namespace then we'd reject it so I'm not sure how this helps?

I think that for the raid issue we should solve that one directly, this
patch may have other implications in my mind...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
