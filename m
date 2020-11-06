Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D95C55178
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:02:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B6C20882
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oJzmQfW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B6C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jZJna5LKS0gGMsh+p4cRm2d14mVFKDQewYx7Q7jb+2w=; b=oJzmQfW2yxAab4j4Bp7PKvpIG
	iW+MtdRhmBOh7us/91O4hsQYo5r75Y3DA6cFiZVukTXNYLlTWgGOYFfMK8VCu0g9RQ48CVpqADmh8
	z/OrHmyAWE52/PQ4+EXJdu/TxjZ5NF6GBpUMo03GiXkexdXe5Mhe4eAw7h/84jj4ZdP4/ZG98xodt
	7bQxL4kGDgz43+J8DMAWdYdVxxpX1i0tcpziHmAloHeUneJjfg5P/5ExEJ1JPCo0vFzXd2PoKqAxD
	zKgpcA/p7+/qyMDjOy8whxAtUA9US+1tiN3aAHzCnpiQw05tXKwE3ixhdpMMV982XC8hdBCRHN1iy
	61MbUVuHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb70Q-0000rc-V6; Fri, 06 Nov 2020 19:02:39 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb70N-0000rD-27
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 19:02:36 +0000
Received: by mail-wr1-f65.google.com with SMTP id b8so2414425wrn.0
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 11:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2ys5NGzlUHToz4u+Vq58zO+k1Hn1ZuX2VsEmVSMtlhQ=;
 b=Q3oRswZbTrpsijvUm+PDtqb8uvyrJaTqOMswrl79BHlOhGoIJNNoPmcSbW9iWt/Vip
 yX9IeuqH6oeKXuk5UuGlraVYGJ0NRw3A/Wrq7pwHui7STzTV2FtK1aYCUxMrzot0fp32
 aoJFcxu+EA6U9xq7XRS8Q9nHYz4+ISX2r0dxYar9bevwYVnBSo0igUtETO4WyYpfyytz
 ElmVQXACmIVYFrSFImdpnXBqAqkNHfkqnR6unoXA3kHey370uQi6uleMREtNZV1GMuCD
 EidWWUVWiX+HXMvy6jpUd/kWaC57M1sF0QrASWOWqD6c90hJ4vLUd7jM2yAOJLHIctTX
 4HyA==
X-Gm-Message-State: AOAM531TJtwKzU21Pn5wzNp5GVOPW7xiluVPAsQqhozqDKeyi3GdoE81
 PLsHc7JLeZmdza/JrOkJxfs=
X-Google-Smtp-Source: ABdhPJyTMy5qTm2iyScmQqcjQssLO9RQfcvpxDRcgfdS47naCbOqFz84LulAmZ05cM9DZvRlAPyF2g==
X-Received: by 2002:adf:c101:: with SMTP id r1mr4020728wre.87.1604689353880;
 Fri, 06 Nov 2020 11:02:33 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5d93:b4fd:df52:2680?
 ([2601:647:4802:9070:5d93:b4fd:df52:2680])
 by smtp.gmail.com with ESMTPSA id b8sm3460129wmj.9.2020.11.06.11.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 11:02:32 -0800 (PST)
Subject: Re: [PATCH] nvme: revert commit 1293477f4f32 as it is breaking
 BLKROSET
To: Christoph Hellwig <hch@lst.de>
References: <20201106171835.38236-1-sagi@grimberg.me>
 <20201106175949.GA7529@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <443079c6-2dd0-f52d-4b2f-f7f9dec2792d@grimberg.me>
Date: Fri, 6 Nov 2020 11:02:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106175949.GA7529@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_140235_132524_3F4C0AEC 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> The offending commit breaks BLKROSET ioctl because a device
>> revalidation will blindly override BLKROSET setting.
>>
>> The author should resubmit this commit in a way that does
>> not break BLKROSET.
> 
> Let's fix this properly instead of a blind revert.

I've asked Chaitanya to address this, but I guess he didn't
get to it so at the very least lets not keep the breakage.

>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>> -		set_disk_ro(disk, true);
>> -	else
>> -		set_disk_ro(disk, false);
> 
> Just dropping the else part is probably enough for now, although
> as a follow on we should probably add a "hard read-only" state to
> the block layer.

Removing the else would have an incorrect behavior. I think its better
to not support it (until we support it correctly) than to support it
incorrectly.

Process-wise, I think we should revert this because it was added
incorrectly. Having a "hard-ro" in the block layer is unlikely to be
backported to stable. Hence I think we should revert it and re-add it
correctly this time.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
