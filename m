Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6C6C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 07:09:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA35C207DD
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 07:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uAoEbxGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA35C207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IqsSWLwuUZYS0V88yXr8Nx6oIlGd8pGdWrZ9JvIAprQ=; b=uAoEbxGjMPNyWxhTc4z6WUB44
	6CRKb8QtIYm0WbYP4zDKptzsYMdJqpxdQdM85GzW8I8MftZAQLYlYXxiw0jDtc9rm3+Rf/+lOy8tk
	oDxJTBuhWrOcxE4g9woB6uX9dVyWbVvke1cI5ve/wXx8VB/a71QJkWhb/FOnHrWSt5qLlAF86gVpZ
	fswg4IhsPpdITs7IUBQ4ygFRfiS0zNL7n8nsHFCUnNVKFrhJKx+K4NcLjjbs4aKR1T3ixllJPWSY9
	LvzDgTHGdtnkZ/gcUEEyIkTopgg0VB2z1VmymA1bInTq5fR6DnE7aBhRVT9ywsJlaDqdeX6YDf215
	E33gj+8kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzXd-0006u6-07; Wed, 24 Jun 2020 07:09:53 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzXG-0006t7-CA
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 07:09:31 +0000
Received: by mail-pj1-f65.google.com with SMTP id ev7so284392pjb.2
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 00:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vmT3nSGFXyFanmZ0ybAr+zzVTMsg51EvHhCXPYKETRY=;
 b=KsA9Xb1Rdb6iqou5zcr8+c//ATnRnl8FX5KbqERZLql/K5btXHkJFSitC0qeOGdP5e
 eyCb8pND8Ny28/S46wHEgjDXaJPPLUxI/aGCmBr04L/+7or+hZYXp0KtNmwnpqKoOH6h
 byiyPK2ACoaIOa0LIFOZ7NhtBoGfkH4Mor8x9NtgmE2RxmQ68LhpeDiku/St7ZGHQ05E
 IoKDJxBht762KNUzH8pfE3HOZCXZtLwLzW2tZS0i/ZJ3Tvz6cHXoFDdQbRKw2Xa8FIXW
 7xEqRtwU9BLHcCcpgO4ZUVxuvgmvVLEo8uzQ9RTuKjx3UCvKIcCsXfY6x3BfIGM9FbIO
 qXfA==
X-Gm-Message-State: AOAM532HIrTWhKnkwSsnxYSSkLOFc9kGeF8qOfOchmxhAzeUCqlY9f7s
 ml1YAR9w+ShiRTSxabZ5raMUpK/6
X-Google-Smtp-Source: ABdhPJwTgkD7PeIBAbYFDeYS/sgvbyKMSuxR3DcnQrMIjWJlCUuwiAVbD7DtE2obmp+Nq8RWbdZ22Q==
X-Received: by 2002:a17:90b:3105:: with SMTP id
 gc5mr26752922pjb.36.1592982569129; 
 Wed, 24 Jun 2020 00:09:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9915:87a9:9728:63e?
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id z1sm4307662pjz.10.2020.06.24.00.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 00:09:28 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.8-rc 1/6] nvme: fix possible deadlock when I/O is
 blocked
To: Christoph Hellwig <hch@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-2-sagi@grimberg.me> <20200624062902.GA17594@lst.de>
 <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
 <20200624065745.GA18207@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bd52aca5-6f66-5b7a-1276-91b9e7fa3f24@grimberg.me>
Date: Wed, 24 Jun 2020 00:09:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624065745.GA18207@lst.de>
Content-Language: en-US
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Revert fab7772bfbcf ("nvme-multipath: revalidate nvme_ns_head gendisk
>>>> in nvme_validate_ns")
>>>>
>>>> When adding a new namespace to the head disk (via nvme_mpath_set_live)
>>>> we will see partition scan which triggers I/O on the mpath device node.
>>>> This process will usually be triggered from the scan_work which holds
>>>> the scan_lock. If I/O blocks (if we got ana change currently have only
>>>> available paths but none are accessible) this can deadlock on the head
>>>> disk bd_mutex as both partition scan I/O takes it, and head disk revalidation
>>>> takes it to check for resize (also triggered from scan_work on a different
>>>> path). See trace [1].
>>>>
>>>> This is no longer needed since commit cb224c3af4df ("nvme: Convert to
>>>> use set_capacity_revalidate_and_notify") which already updates resize
>>>> info without unnecessarily revalidating the disk.
>>>
>>> Did you look if any other revalidation gets skipped this way? E.g.
>>> LBA size change?
>>>
>>>   From purely the size POV this looks good, though.
>>
>> The only reason the revalidate was added was to update on a size change,
>> which is redundant.
>>
>> And if you look at revalidate, it only calls fops->revalidate_disk
>> (which is a noop in the mpath device) and checks the size change.
> 
> Please add this blurb to the changelog for the next version.

Will do. thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
