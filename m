Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4410BC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 05:58:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F393B60F41
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 05:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F393B60F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0lFrwjKgqG5G10eFsXHcATEsdqQJn7e0n6X346zxJg=; b=Sct0Kk2sZPjOntO1Rx9r2uWnun
	BIkL+W1p4BbNC9jX4a/QDVF22vtQy5uMneSMYDHPsc7vVZmNoI4DsP/8ka8ZAnmeWNRdwhVcrV6jU
	4+aW4q1Fmn3eD83gqr7GVjd4p5GBgYn7WtKjExzVNQlLHx8hQ0/HpP7iD9RoSda2TVXDEVQQnjhp4
	AyejCBymMOO6lbYtIpvW1Tx6wgvO8p3/KVNdNcnBeFAj9Wyd94glkUMfRore77k6HBUnhiV51Yvck
	0Cy2fUXeIOlV0b+aLSpwSTK8xdU9DCmI2CvqhgTa2HmPHULmwqDec9D+bbXHkkPbGc3yQCSnWpHF6
	NK7LkB2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDhFg-005fzh-5K; Wed, 11 Aug 2021 05:58:08 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDhFZ-005fyJ-Rn
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 05:58:06 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 s22-20020a17090a1c16b0290177caeba067so8014998pjs.0
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 22:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MwNzgkEdTWrhCVqzwhsRITEzyhDpcajlmLuENq9JbiQ=;
 b=GP5mXx/zk3nZvyaX2kkRk/mT/mkX0I0fdL1fnBZjyP42Iln4swZ8v7QVswfRx+BM+5
 Udav5+uUkonrXQ3YhxfVeEPiMk/BSqT61in307ERZExX2tsj6i+5vFnCSwEz99PhVPGS
 IO2sebzpkwt2JNI0wCSxAvdGzSCxcU2+KFReHavfQbVjskOSyTHkkOzolE+h324beyx6
 BQGvzUxG3QsYG+uwhDkSlHdROZqdrsXKH+4WKooGq5DHXUP+Hytm0YTcNhiOj5s2OW5Y
 c2Ukns7JnnYWSZvcfdmYAXIbQ31Iy5LM7Gy2+gQM/2UQ6N3UrV1qiqMOE6VFLVBhjcsj
 1PmQ==
X-Gm-Message-State: AOAM531YLsVBBhiSSO/64f6s9WruFmjqcC8pfB5c9FnSuo/SdDNlQeu/
 htb3VCEX8u+kmeVYvW/SpFs=
X-Google-Smtp-Source: ABdhPJy3CprzOEEONMGcGgHCw2bfPm+CGkOj6t9+C8N86i2AfY8AhzexTpeZ5DyXUHzzPIzQNHyPdg==
X-Received: by 2002:a17:90a:804a:: with SMTP id
 e10mr19156601pjw.12.1628661481165; 
 Tue, 10 Aug 2021 22:58:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987?
 ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
 by smtp.gmail.com with ESMTPSA id f4sm31685550pgi.68.2021.08.10.22.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 22:58:00 -0700 (PDT)
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
 <20210809085250.xguvx5qiv2gxcoqk@carbon>
 <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
 <20210811010718.GA3135947@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <079108ce-6ca0-800e-e3df-29d015a4530c@grimberg.me>
Date: Tue, 10 Aug 2021 22:57:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811010718.GA3135947@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_225801_994390_DDB75FB2 
X-CRM114-Status: GOOD (  19.05  )
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


>> On 8/9/21 1:52 AM, Daniel Wagner wrote:
>>> Hi Sagi,
>>>
>>> On Fri, Aug 06, 2021 at 12:57:17PM -0700, Sagi Grimberg wrote:
>>>>> -	ret = nvme_tcp_start_io_queues(ctrl);
>>>>> -	if (ret)
>>>>> -		goto out_cleanup_connect_q;
>>>>> -
>>>>> -	if (!new) {
>>>>> -		nvme_start_queues(ctrl);
>>>>> +	} else if (prior_q_cnt != ctrl->queue_count) {
>>>>
>>>> So if the queue count did not change we don't wait to make sure
>>>> the queue g_usage_counter ref made it to zero? What guarantees that it
>>>> did?
>>>
>>> Hmm, good point. we should always call nvme_wait_freeze_timeout()
>>> for !new queues. Is this what you are implying?
>>
>> I think we should always wait for the freeze to complete.
> 
> Don't the queues need to be started in order for the freeze to complete?
> Any enqueued requests on the quiesced queues will never complete this
> way, so the wait_freeze() will be stuck, right? If so, I think the
> nvme_start_queues() was in the correct place already.

Exactly what I was trying to point out (poorly though)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
