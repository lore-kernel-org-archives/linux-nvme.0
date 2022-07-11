Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF28C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Naj6BUtr8ste6nBzx0twd/v5FNkX9Aa81PUcC0ewQoU=; b=Nrfk0FXPuYL8fMxeY/NDMaAGXs
	I/SYoWr1aA69Uf15DnlxU8l5Nf+T7U+Ts20txwcOAZ64b4eiONrt5z2Nis5J2GbySlgL1eOQ7kBPP
	HgSqqKBpFO9t7wmRGr8bSSTMDv3I1uAMJlnm/MouLpD2k6q1qbuGaY5zyXUbqYp1wd7mCZn9esUfO
	2dnQE2z6kNrJPo63ivcQDj4uTBdjTHrXJirpWmunxW/EOZjYotAfPGpALzYoDFpZlHFPAeNMhcPeD
	sTb28dqA3+wXWWFS0rQFmrnnhbxBPvRTikK/o18hfI0MO+QgFMWLncWZQNM2rolHnsgd0hmhanu5R
	bckA2d3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAogk-00HBBq-4F; Mon, 11 Jul 2022 08:22:42 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAogb-00HB8j-A8
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 08:22:34 +0000
Received: by mail-wr1-f51.google.com with SMTP id o4so5982874wrh.3
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 01:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Naj6BUtr8ste6nBzx0twd/v5FNkX9Aa81PUcC0ewQoU=;
        b=KfRFQEN5VaFj8jXjlJVo5JvRii+QhBt2i2JXR5hmm27V8FEan9rg0PxUYTCgWWo09e
         JVGSwSobNzt+YB6PssYozcsFjN1cLaWvRvrn1xaojMVjnapQY+wD6EBkeBggzmxu2cr4
         /p5BhSqy78i4BBYf+gHSmSj69eiZV+fECtctNPR55qFWjmNT+RFSy5Ny5tsXCVyHCXdl
         tRQdzDmGWj9BSoSsD7BBJH91j74YDIbxiNl5EUe4OCnIR9srGp9NxFqLPlcDaIqThATY
         Hl5pIL1hoHZaOMmsMyo3VL1c5QKA0B1OU7tuegcbAPMetgrF83SxSpwc88QwG03llX9G
         qzBA==
X-Gm-Message-State: AJIora/brTicSvF8/fZ8pvsa6CbU9/QlzS1gLoa04/2Y5bT2TRvJWWwl
	hGM/E1RR6Voz/g7jkjT7dB8=
X-Google-Smtp-Source: AGRyM1vWoDfHDxlWe66H9Iik5kCJ87qfWxuQYwKQRJdedpZhu6UHYDHnEWCH8yyo3EoO1yhBM4rsHA==
X-Received: by 2002:a05:6000:1a8e:b0:21d:a7a8:54f4 with SMTP id f14-20020a0560001a8e00b0021da7a854f4mr3015712wry.654.1657527749266;
        Mon, 11 Jul 2022 01:22:29 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a0502c620dsm9300467wmq.44.2022.07.11.01.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 01:22:28 -0700 (PDT)
Message-ID: <7f9de1b6-f3bb-1c94-7a57-65e77254db0c@grimberg.me>
Date: Mon, 11 Jul 2022 11:22:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>
References: <20220630154444.475600-1-sagi@grimberg.me>
 <dbb827f5-6202-eb09-dc32-d49d00d59cd1@nvidia.com>
 <20220711004124.ujr2r23zef7gp2ic@shindev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220711004124.ujr2r23zef7gp2ic@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_012233_378187_A3034F70 
X-CRM114-Status: GOOD (  15.11  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> O
>>> +
>>> +	# do reset/remove operation
>>> +	echo "resetting controller"
>>> +	_nvme_reset_ctrl ${nvmedev}
>>> +	sleep 1
>>> +	echo "deleting controller"
>>> +	_nvme_delete_ctrl ${nvmedev}
>>> +
>>> +	echo "stopping background fio"
>>> +	{ kill $!; wait; } &> /dev/null
>>
>> do we really need to kill the fio process explicitly ?
>> I think graceful termination of the traffic application should be
>> a part of this test without explicitly killing the process.
>>
>> I ran the test with commenting above line it runs fine :-
>>
>> blktests (master) # git diff
>> diff --git a/tests/nvme/040 b/tests/nvme/040
>> index d259784..0dce128 100755
>> --- a/tests/nvme/040
>> +++ b/tests/nvme/040
>> @@ -49,7 +49,7 @@ test() {
>>           _nvme_delete_ctrl ${nvmedev}
>>
>>           echo "stopping background fio"
>> -       { kill $!; wait; } &> /dev/null
>> +#{ kill $!; wait; } &> /dev/null
>>
>>           _remove_nvmet_subsystem_from_port "${port}" "${subsys}"
>>           _remove_nvmet_subsystem "${subsys}"
>> blktests (master) # ./check nvme/040
>> nvme/040 (test nvme fabrics controller reset/disconnect operation during
>> I/O) [passed]
>>       runtime  8.119s  ...  8.084s
>> blktests (master) #
>>
>> -ck
> 
> Sagi, what do you think on this comment?
> 
> To keep this test case consistent with nvme/032, it would be the better to keep
> the kill and wait. But we may not need to stick to it if it does better testing
> without the kill and wait.

I don't particularly care. Can you remove it when applying?

