Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55224C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 05:08:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50D66513B
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 05:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50D66513B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LZSSaOwU7+vhdFBU8ieqDPAQBhNyRL8lZr9dogazV30=; b=LRSG7JUHdd3lSEoL0ivk5elIk
	OOLmN2sDmMHscx0oFDC6dRxakfVxGFLsW5d9R65SoZjcVVFDXwCoWKMdnNR0psJSUG/Fjmmw8V48f
	F420umZIqBbzPnljKDNR+PePgdXTmhecqftTK/W9K99P12YlRtnRjYsNfI9y249iiOt30E52XV2MV
	ExCjvBcOk7TfAQJpiAulAo+AYlKI/PYTSSzHvrklIFPsT5FRrL4DlzvuSvw95hzcbMjzOPheXn1Ki
	7MhkukM/wqo4Hfh+qBkfrAYOl8xybFRA7CsNc2bc2mvFIErSHWVSWfsc3avPMcCnCtKWsLUWr5cXA
	WUUtYknrQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM1wC-00HREa-QM; Tue, 16 Mar 2021 05:08:13 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM1w8-00HRCP-Jf
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 05:08:10 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 q6-20020a17090a4306b02900c42a012202so783957pjg.5
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 22:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zbDk6kFPPW7F4HhKGph1YPBgJOhnoQN3sRp9ucsGjro=;
 b=d5wwx6QlTuPDKlm2s/PhweXGhjSb/XYbSvYfmYxYeKIsJcvEd8CxVB27HgQVDwpOpa
 paS9CXTZWsyKrVVNEZTmxe2xzvSoTwyLSdx84+Eaori6UUTfPPDjxHnIez3lJE2j/LhP
 cwDYNS3wTjV7Jz/QJJV7/QDB8ZUTmO1TJUK22cxt4E1z0yXvxQuP3bgAifu4j18VRkd2
 Uyo5bieadSpr4oPKx313DS0ByPX6DYNj52noVFIhv2HCW3rn3seGsC2SYYKbEVGDNKh4
 DHMQTaapm8kKwvFQJ3zgCqRu9oEH5u2clAdmxL8LDq+vgT6uREZRP1XdeebMfrF7/5BX
 KM8g==
X-Gm-Message-State: AOAM531FJepOFYtHiWbh8KxkgUrl0gLPNmkubpcvdctO654xLmFcE0HU
 wd3eb0eWtTJkSmdgc/dRG00=
X-Google-Smtp-Source: ABdhPJznZWqh8BfoaZH5nYcHUTJsBgXC5JprocfzP+P5e2A/bh2NdJRLB3WQ+SDVaObIcB2BNWdyUw==
X-Received: by 2002:a17:90b:fce:: with SMTP id
 gd14mr2805295pjb.64.1615871287326; 
 Mon, 15 Mar 2021 22:08:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id q25sm14969739pff.104.2021.03.15.22.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 22:08:06 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
To: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
 <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
 <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
 <aac125ec-561a-002d-7054-782ee450067e@huawei.com>
 <20210316020229.GA35099@C02WT3WMHTD6>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <21bc3b62-967c-6cb2-c9f3-7da479aef554@grimberg.me>
Date: Mon, 15 Mar 2021 22:08:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316020229.GA35099@C02WT3WMHTD6>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_050808_725330_DCE24E00 
X-CRM114-Status: GOOD (  21.08  )
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


>>>>>> A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
>>>>>> over rdma(roce) reconnection, the reason is use the queue which is not
>>>>>> alloced.
>>>>>>
>>>>>> If queue is not live, should not allow queue request.
>>>>>
>>>>> Can you describe exactly the scenario here? What is the state
>>>>> here? LIVE? or DELETING?
>>>> If seting feature(NVME_FEAT_NUM_QUEUES) failed due to time out or
>>>> the target return 0 io queues, nvme_set_queue_count will return 0,
>>>> and then reconnection will continue and success. The state of controller
>>>> is LIVE. The request will continue to deliver by call ->queue_rq(),
>>>> and then crash happens.
>>>
>>> Thinking about this again, we should absolutely fail the reconnection
>>> when we are unable to set any I/O queues, it is just wrong to
>>> keep this controller alive...
>> Keith think keeping the controller alive for diagnose is better.
>> This is the patch which failed the connection.
>> https://lore.kernel.org/linux-nvme/20210223072602.3196-1-lengchao@huawei.com/
>>
>> Now we have 2 choice:
>> 1.failed the connection when unable to set any I/O queues.
>> 2.do not allow queue request when queue is not live.
> 
> Okay, so there are different views on how to handles this. I personally find
> in-band administration for a misbehaving device is a good thing to have, but I
> won't 'nak' if the consensus from the people using this is for the other way.

While I understand that this can be useful, I've seen it do more harm
than good. It is really puzzling to people when the controller state
reflected is live (and even optimized) and no I/O is making progress for
unknown reason. And logs are rarely accessed in these cases.

I am also opting for failing it and rescheduling a reconnect.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
