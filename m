Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B74C43470
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:16:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0887610CC
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0887610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n8Su/aTnZsKQPNZCrWMs2uSJ5v4Bc0UmK4hesstY7WI=; b=iwaiw3lJVaNeXS60ql4wC5zrB
	ZC2pXY7h4gpHXUOyboZAwBrcrMxcAcWO1XW8f6G0RRxEFUgHOl3ed28QtQ6azJL/cMnO2tV1BULOX
	8xp6Tq8wSgw/vdduBAhIdgJuuEC1gdg+e+qSu3vx5ycLHj/XK+0apq3A8GGXud6FjnlbneUEu+091
	4Q2HDTU+EC+vu9DGN7dXqxJFjxCU9x1NwDweccLDxB3U8x1CwbsUmhxYBIfTe3KIbq5R+LT5i4fa6
	br3GRCUMjYjnC7mDYnyKlsM3BEPCC6V92k4GuJ3DviTRnbt/DBhJQTnlkQNd0Sb3BxxaCaTGgpzd6
	7rUFrEIhA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRj8W-007pgW-06; Wed, 31 Mar 2021 22:16:28 +0000
Received: from mail-oi1-f181.google.com ([209.85.167.181])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRj8R-007pg9-Ct
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 22:16:25 +0000
Received: by mail-oi1-f181.google.com with SMTP id i3so21518767oik.7
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 15:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=85xu7ZwAOj+SdsGjse6eiaJmiUonQljW9WVlUSB6CGU=;
 b=mOYZ4aBnrdL+cnTP8u5W+g0NKss5SI4t09tjIIW9RB67oW5izEpARb8XkaaSn8JAZu
 qZ8duw6rVv+r9LbpZPmh39WP9vwowuZMcunjW6f7bH+/7k0XwGZzZW0vI5JTlav74rJN
 +dGmIGGlv/3MkzPE2H9Tga4+EOHQt3+Fl/yUpBmtm30JI364dh+rlqs7SPOihIrrTzN0
 cwVYBi1Nv1Vbmf6xQ5aDhCiCAPKYnOW9oy/If52Iu9ybZhHb8lCPR9vjsvniQBYIPxel
 jypQgq/IU3r0/kcdS7R+tBFvaUi1XeR++v3+wDDs3d/SxvgJMNcY17040mQAIc48f58X
 EYFA==
X-Gm-Message-State: AOAM532cEng9IJRJL9LMgC3EXLdse+cy5lAVvcK37ZOtmb9Ni8V5EC1X
 Dl7h0kgkib3RJ+d3N2hxHW3xFMfCmfE=
X-Google-Smtp-Source: ABdhPJxm/+gwNbdyIenVSWEoST22v+5KMRVWbfxpoAnmMShRFfFWZ+G2prLbWvsqyVAwsClpI6bH5Q==
X-Received: by 2002:a54:4703:: with SMTP id k3mr3730994oik.26.1617228982325;
 Wed, 31 Mar 2021 15:16:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id f197sm763763oob.38.2021.03.31.15.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 15:16:21 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <027410bf-1563-47ce-1f69-73071df81ae3@grimberg.me>
Date: Wed, 31 Mar 2021 15:16:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_231623_591995_6B6F297C 
X-CRM114-Status: GOOD (  22.52  )
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


>> Hey Keith,
>>
>>> While running a read-write mixed workload, we are observing errors like:
>>>
>>>     nvme nvme4: queue 2 no space in request 0x1
>>
>> This means that we get a data payload from a read request and
>> we don't have a bio/bvec space to store it, which means we
>> are probably not tracking the request iterator correctly if
>> tcpdump shows that we are getting the right data length.
>>
>>> Based on tcpdump, all data for this queue is expected to satisfy the
>>> command request. I'm not familiar enough with the tcp interfaces, so
>>> could anyone provide pointers on how to debug this further?
>>
>> What was the size of the I/O that you were using? Is this easily
>> reproducible?
>>
>> Do you have the below applied:
>> ca1ff67d0fb1 ("nvme-tcp: fix possible data corruption with bio merges")
>> 0dc9edaf80ea ("nvme-tcp: pass multipage bvec to request iov_iter")
>>
>> I'm assuming yes if you are using the latest nvme tree...
>>
>> Does the issue still happens when you revert 0dc9edaf80ea?
> 
> Thanks for the reply.
> 
> This was observed on the recent 5.12-rc4, so it has all the latest tcp
> fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
> difference. It is currently reproducible, though it can take over an
> hour right now.

What is the workload you are running? have an fio job file?
Is this I/O to a raw block device? or with fs or iosched?

Also, I'm assuming that you are using Linux nvmet as the target
device?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
