Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4539C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 20:23:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F1A20735
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 20:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GaTXsi7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F1A20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mj3UDsDI1PCgSLz2KsADGTE/4hfhZU6UAgkk0vl8MgU=; b=GaTXsi7Wt1TfDJCBA9FauO6MI
	yhJoSFnAstSW9pXyMxB5k+DQDxuTMEMl9rpE6QOoXqSI/qIotMqcIGREIW2RpxtwJgPTzYDsNAdPC
	kzyLEFXECuyiTCeHtF+J330apDNs36bfTWCK6fi+pEduCOpFt3dBVsU2BkxZv4L2I4raV3ibckKCa
	C5UI57mKYwIazSrw5xBMrnwhgSs5+rkShPpAQ6FZn8DLvQxyrBwdaX1FH6IK8bcWn12vZ4TXQugda
	C4XUsnfkjm9YyKk42ZHcNXnaMti0qsD93ZcTUVVaINcZswRQv1mcYaHCvvJ29FQfvbLLECuBf8Bvu
	EjmFL4/mQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9DZV-0001ww-Mc; Fri, 21 Aug 2020 20:23:33 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9DZT-0001wM-6j
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 20:23:32 +0000
Received: by mail-pl1-f193.google.com with SMTP id k13so1370099plk.13
 for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2020 13:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2gfWQvCm4JA4u/Phnm0jHU35F/XAL1Zg/HIvrShCJXg=;
 b=noTW7ih1RkirrYXGauxVEOY9IDJsCM/1zjW5Fk31bSteA47n2kB67S/lF9wHjQD75S
 XnkXb+UdgIzS0n1tjORD1fZD8qoKCmbzFn4G3K5BBWWs8I2HwuGFlMTIL6Yi5JJ6TMDb
 ppwKnM3SUgoIVXltkVuSvrF3vV93Sx18Rgh5hMAHdbKiMPBvdv3G1kQ1TpSMLr48PanV
 X/irP17O11EapcPXe70Z6RFSZDFy2oSj8J8Rnhu4hMwqo9WDvPd6jkhMQy9u107vmNcd
 nOMqBJ8klCcGN+/551lmXNypiPqv+MBTWlpWUxNCVnvV2wo3VqTS6FZyKoSXj0cvB5Bb
 fTMQ==
X-Gm-Message-State: AOAM530zULFjxxJGLsvSvpREMJzzmwg7s9EvRu/NNWQqnH/U2ojSz6Zd
 LkHQhSRvRxxy4C5r/KFgYl4=
X-Google-Smtp-Source: ABdhPJyINuNiQe0BP36p529nR8soirHltcatsfn2ZNpAGrkwXR7VyCszxt64JLsmkDSTDtnIPLOIvQ==
X-Received: by 2002:a17:902:8ec8:: with SMTP id
 x8mr3701224plo.217.1598041410258; 
 Fri, 21 Aug 2020 13:23:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712?
 ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
 by smtp.gmail.com with ESMTPSA id b22sm3418646pfb.52.2020.08.21.13.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 13:23:29 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To: Christoph Hellwig <hch@lst.de>
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
 <20200820082918.GA12926@lst.de>
 <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
 <20200821062538.GD28559@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <75b49877-7740-3bd7-2ae9-385c310d7498@grimberg.me>
Date: Fri, 21 Aug 2020 13:23:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821062538.GD28559@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_162331_273038_B2E4A5A9 
X-CRM114-Status: GOOD (  21.67  )
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
Cc: axboe@fb.com, linux-block@vger.kernel.org, kbusch@kernel.org,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> So the one thing I'm not even sure about is if just ignoring the
>>> errors was a good idea to start with.  They obviously are if we just
>>> did a rescan and did run into an error while rescanning a namespace
>>> that didn't change.  But what if it actually did change?
>>
>> Right, we don't know, so if we failed without DNR, we assume that
>> we will retry again and ignore the error. The assumption is that
>> we will retry when we will reconnect as we don't have a retry mechanism
>> for these requests.
> 
> Yes.  And I think for anything related to namespace (re-)scanning
> we can actually trivially build a sane retry mechanism.  That is give
> up on the current scan_work, and just rescan one after a short wait.

There is no point in doing that if we are disconnected and will in
the future reconnect, which will trigger a scan that can actually
work.

>>> So I think a logic like in this patch kinda makes sense, but I think
>>> we also need to retry and scan again on these kinds of errors.
>>
>> So you are OK with keeping nvme_submit_sync_cmd returning -ENODEV for
>> cancelled requests and have the scan flow assume that these are
>> cancelled requests?
> 
> How does nvme_submit_sync_cmd return -ENODEV?  As far as I can tell
> -ENODEV is our special escape for expected-ish errors in namespace
> scanning.

One of these escapes I guess :)

>> At the very least we need a good comment to say what is going on there.
> 
> Absolutely.
> 
>>
>>    Btw,
>>> did you ever actually see -ENOMEM in practice?  With the small
>>> allocations that we do it really should not happen normally, so
>>> special casing for it always felt a little strange.
>>
>> Never seen it, it's there just because we have allocations in the path.
>>
>>> FYI, I've started rebasing various bits of work I've done to start
>>> untangling the mess.  Here is my current WIP, which in this form
>>> is completely untested:
>>>
>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup
>>
>> This does not yet contain sorting out what is discussed here correct?
> 
> No, but all the infrastructure needed to implement my above idead.  Most
> importanty the crazy revalidate callchains are pretty much gone and we're
> down to just a few functions with reasonable call chains.

OK, that makes sense. I'm still not convinced the retry makes sense
though...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
