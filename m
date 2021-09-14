Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE32C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:10:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0765261163
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0765261163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mencxkm5Bzu49k/WPyog6s5/dEfkTqcxv2DNZDBhO1c=; b=xbQaBvnNKl3sy2V1mOdWQ0Uo1d
	YW6kjT5/027Hq6NrnnJNbEMqxNeO1DDMmtK8fWj0ZN9/UcLcq6nwCbKhwezUK2oe8iKXeB2ni3i2r
	WvVl9wMgVFHEIlLRr7jxA3ewMSEKzmxnyy8bpIQmawQW5XZRMy2BieonHbXYlHqlXZjFyJQ02YN0W
	wWnWTS/8OwkJn2ftC4POvJTuJe9UvIDF7NUdvCXt1f4cu5l4m9hjTUKkkvJSiFxIXfpm6L7vI/8Dj
	1GvZbQbdFRhLFfwHJx36/IXnv3Q0QLjNkPHGjUUpwROUqurZTVCXaq2fLwF3lQbOeFNrZz9hHGaWG
	w00sB0Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2Zi-004OKQ-JE; Tue, 14 Sep 2021 07:09:50 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2Zf-004OJL-7h
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 07:09:48 +0000
Received: by mail-wr1-f43.google.com with SMTP id t18so18534168wrb.0
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 00:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OVpNUnz5IL6IbNtR62Bx3mU9twmv3LPTasr1xHfpM8w=;
 b=d3uyl9J45hSUjaFcVYJFbuN4OHoU8aiYdLCUuNFXPC8G/6zeCYD2o/vQhdBTzvtMtW
 3e2unbaMJJqhzIhanQxzO3H6A0U1oYgBApP5uX7acY2heomV1VCUIZKAYBHqzsumIjdP
 2GvqRz7/4EV40dVRsjGH4xfaNm/zgQPRNfobTcAf19irWFd9rNkYueTL33QE/311pUGw
 lL4ZeH7lyouQDoQ8nM3H/+okeYyciWG1rD35MivFOceVrANp4e4++85lnVZhft+wTuIC
 Yfm82lLsHe/YzCIoeWbhj9DQiOln8jOD4lkQgSGh1wpTkScpfwXBuExTmRhtJqOF8YdI
 Pf6A==
X-Gm-Message-State: AOAM530h7MBOwzGlpf+c8bX62nlZEmXA3FPAMJxjcRBdYQWpc5wUi8sT
 PdrgiRD6gJuk/zsbiOtaSOI=
X-Google-Smtp-Source: ABdhPJwccfKYcx3dCiNn8hphlBLZcKTSniapCwO9Ph560AuZbmiyg2mFT8fAyQ/teoZnMkahFt+4SQ==
X-Received: by 2002:adf:ef07:: with SMTP id e7mr12431711wro.56.1631603385275; 
 Tue, 14 Sep 2021 00:09:45 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j98sm9791741wrj.88.2021.09.14.00.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 00:09:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for namespaces
 just added by scan work
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman
 <anton.eidelman@gmail.com>, linux-nvme@lists.infradead.org, axboe@fb.com,
 Anton Eidelman <anton@lightbitslabs.com>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
 <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
 <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
 <20210914063052.GA27942@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e65e9c83-33ed-df58-0eed-4ecf9cb4485f@grimberg.me>
Date: Tue, 14 Sep 2021 10:09:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914063052.GA27942@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_000947_334026_AE98728E 
X-CRM114-Status: GOOD (  16.78  )
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


>> I agree it should not happen with xarray as inserts preserve sorting,
>> but that patch has the non-trivial removal of the namespaces_rwsem which
>> synchronizes in a lot in a lot of error recovery flows. It's very
>> possible that xarray will introduce regressions.
> 
> I've actually started looking over the series earlier today, and staring
> it I'm pretty sure the namespaces_rwsem is completely broken.  There
> is nothing preventing the namespaces from going away in these loops.

Where? the ns itself? the ns is removed from ctrl->namespaces list under
this rwsem (nvme_ns_remove).

> But I can't see why we don't just always do a sorted insertation into
> the ->namespaces list.  Just trying to figure out the history of the
> delayed sort ATM.

Don't know the history.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
