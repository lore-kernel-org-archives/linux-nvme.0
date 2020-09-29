Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8CC4727F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:10:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB1420897
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="enK1nMeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB1420897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/mzllenwBNSXrlczbOi1fRkYNfVuvcL4JvbpvwmUaxI=; b=enK1nMeqel3dwEBTCltwGAVXK
	DnEnPzI6gTJYtiKsBfVruqLDwMHaNbMOTcLY/aI5/xJH7V7Rbtby+jA98QzQ5Vq/4fEp/4pPKyUKi
	6DIZNdmvxsClt9K32ImOWNrQN5KHqT7HwQkp96WFPvArpgzBTEXvWuAfUUBhTyWTzCKoCI6hi3ZVW
	LG0x+TthX4c7BbmTL0JR8i16vTdMdrVVD25/CPz1c83mex9F7WGe0nYpPR3Alfaz0ujN4Kc354335
	hjvz1OOxNNYC1ft6xQFiykQEhKZNZW2XPIIK1o6LgThAEvS9e1uy3Om+oFvoCWss4BweFmopaVJJM
	k6iOOIUbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNAiL-0007ul-5A; Tue, 29 Sep 2020 08:10:21 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNAiI-0007u9-Ef
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:10:19 +0000
Received: by mail-pg1-f196.google.com with SMTP id s31so3216648pga.7
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K8WWim+vVbf/op7OmIC+8xoaRpsmC3FeaBj5Q7Ff/kM=;
 b=CQwfrK2/WM+up8Y6463uWIK82EoNBATSx1zsGH/b9m6Tyjvtx1N8iJElDUtOxXZlzw
 haEaFkm1sXriyqO6w3UQq6X3xtVvRnZwG6UasQG0yCChQyFzzhDIRo1NxWw5943jke3o
 d0+aTCvAEC5cxKyO/mChAXWexmcbtovxev1ksjYrfl7B6KrcYUPRbtAvUIWF0+SWQntJ
 QTwEhT2akyVuZcDJ0DWUJyCblNnhrTJfsrBGp4OUAcy1xTJUiBHUwQe81iJVuyClrR46
 h8kjm0YDC0w8+09oJoRyDfVRqJjlcS8kISWlducvEu64Pv6aL94fEz8LVPmo7th6DLZL
 WBeA==
X-Gm-Message-State: AOAM53326pNlvv8SbVKeaKd1HPIY+DTkUSwdYq1dfHOKi6g1mGi1w+md
 YtXVmX6iY1qXawNiVzIeNYU=
X-Google-Smtp-Source: ABdhPJy+lfj0cNRYMU2bYth6DPPLpF7KCyNdcRQEyJVLJDUB/3cmkpYl7BtBE2JOVsYA8KkoTIaMAg==
X-Received: by 2002:a62:d456:0:b029:13c:1611:66c2 with SMTP id
 u22-20020a62d4560000b029013c161166c2mr2917663pfl.13.1601367017346; 
 Tue, 29 Sep 2020 01:10:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id h8sm4490366pfk.19.2020.09.29.01.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:10:16 -0700 (PDT)
Subject: Re: [PATCH v8] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <0f73b032a39748c3beb8c1cb743f0783@kioxia.com>
 <52462339-084c-90ae-4ca7-62e2ae37dd7e@grimberg.me>
 <f9188630aec6471e8cf6ab9d3f1cf989@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <947945e1-6aee-231c-20c1-f0bb6b2d7195@grimberg.me>
Date: Tue, 29 Sep 2020 01:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f9188630aec6471e8cf6ab9d3f1cf989@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_041018_508563_72B44764 
X-CRM114-Status: GOOD (  21.34  )
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
Cc: James Smart <james.smart@broadcom.com>, "Ewan D. Milne" <emilne@redhat.com>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> diff --git a/drivers/nvme/host/multipath.c
>>> b/drivers/nvme/host/multipath.c index 54603bd..d8b7f45 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -278,9 +278,12 @@ static bool nvme_available_path(struct
>>> nvme_ns_head *head)
>>>
>>>    	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>>    		switch (ns->ctrl->state) {
>>> +		case NVME_CTRL_CONNECTING:
>>> +			if (test_bit(NVME_CTRL_FAILFAST_EXPIRED,
>>> +				     &ns->ctrl->flags))
>>> +				break;
>>>    		case NVME_CTRL_LIVE:
>>>    		case NVME_CTRL_RESETTING:
>>> -		case NVME_CTRL_CONNECTING:
>>>    			/* fallthru */
>>>    			return true;
>>>    		default:
>>
>> This is too subtle to not document.
>> The parameter is a controller property, but here it will affect the mpath device
>> node.
>>
>> This is changing the behavior of "queue as long as we have an available path"
>> to "queue until all our paths said to fail fast".
>>
>> I guess that by default we will have the same behavior, and the behavior will
>> change only if all the controller have failfast parameter tuned.
>>
>> At the very least it is an important undocumented change that needs to be
>> called in the change log.
> 
> The multipath may be stuck on reconnected controller even forever.
> Moreover, all commands will be returned with error status,
> but the path will not be switched.
> And in this case, the presence of the additional path looks pointless.

Its not pointless, currently while there is an available path that may
become active we queue it up. Your suggestion to fail multipath commands
when the last failfail timeout expires is OK, but must be documented.

> I suggest use the failfast parameter for each path separately.

It is already a controller attribute.

> It can also serve as the priority of each path.

Lets not do anything on that front, if someone wants fail certain
controllers faster than others, he can do it, but nothing should
be mandated from the driver for sure...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
