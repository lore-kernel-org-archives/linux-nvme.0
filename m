Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0D7C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 18:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=igIhAnLuqwcmuVrPHapkJy8cRfInAKYz33ejImzHvHE=; b=4nuAfwy6DlBv60km3H3QFIufQH
	2J0vMcGNBK6WluXz/ri7b7WRCw5/IQl/FAPD8wuuNSrDYHfGSQKKMxj0LiPeyT/WJW2p4hwpZVNLr
	1cJIgGcF9dB2Os9ozGyghUMLZDTIDAYmnd2FW+w9c4z0ovTXuwykRaMj+SCpVGnCCpvOyii0A+0Zk
	Ja4PxBUpoytOFSTyPfj95YbsZZE0lrc4+PwlBv2sjtAFet26eqDNmwxtLmDHj5g6zQTwC7WPTVWa6
	xBp87AW9qHAlJOoopKbw9USnCuzgABElYUL5tp4VwzquDkHrBTiYhJSyqhzMBYEOcrIY0W/hVs7mx
	OwbIC0Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKluh-00BntJ-8Y; Thu, 17 Feb 2022 18:53:59 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKlue-00Bnsk-Gx
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 18:53:58 +0000
Received: by mail-io1-xd2f.google.com with SMTP id c14so1074382ioa.12
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=igIhAnLuqwcmuVrPHapkJy8cRfInAKYz33ejImzHvHE=;
 b=R5yS4mnGDKgJQYAwq1qxDA3GG7bcVzQnA86w5LmRd/ZQJx2DUgADDgBBw6N0TfSWcV
 mo4NxBbtqJXCcu7NmR0Z/4G9fii0pCPplY3XaCb0jwfVViKjTf3hr/fzBhKKLnJYS3qk
 Jx4CVP9DmBHLTG50YjWb4eL29dAn2a4+vx4F+JlNh3dEERdop2zS7EMR5tmRjTkRWvul
 S0CWGGHpHYOdXUSyQUgcSjAATnznSG8F/twkDmNhTCmYOYy7IqDhtK9quA3Wa4vipUWD
 whQo9e/dh1ot8RIVkoKT18tYqhm2dBS75j3MHOq247Bgpu2rLMxFdokZRmsbbbPza8hq
 ffJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=igIhAnLuqwcmuVrPHapkJy8cRfInAKYz33ejImzHvHE=;
 b=sYi7+yvHWn9Og/s+CDsvlcF48wVpAvX+Bb+IvA1e7sFiQddmP24R6awDkG+h21M5r6
 uR5ot2uCddkiSsm/1LwtTOPEGLi2KGL/Ub58QUIg7X96bw4hHN0J2qAv1tz1zDBX/1bc
 ZcPG974O9xJIf5g2GN1QKXd1/sCrhsVzss5bgslWipEdf56AfMxB3bQZCwN29zIvNqZK
 XlYQ0vc1VTlOpXUX7qDQ+qdKzB+lLow2wRFHH/FEgk9L6m7ekTSA9750zncww04WEMVH
 Jipw3lilNNUWeq9vAr/SAbQfbSTOLdJOZJtQq3+KZuf5dFur5SItd9WxzzFSZMn1CFZ3
 Rj1Q==
X-Gm-Message-State: AOAM530HPoBCHHEEyQD8deGzDMB3c3CNmzBpP36oIjjdGdnJvuR8eOrG
 ao+vi4niR9ULoftOQjkw/Mvvng==
X-Google-Smtp-Source: ABdhPJzbmFjshDUPU1NlYMfxuZYLi7frKRzdgseDRd9TGF6m8/xH1rLsYTb0rmUZ09NgpuEhnQxhUA==
X-Received: by 2002:a05:6638:191d:b0:313:f3bf:cfdc with SMTP id
 p29-20020a056638191d00b00313f3bfcfdcmr2810208jal.211.1645124034793; 
 Thu, 17 Feb 2022 10:53:54 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id d9sm1410014ioy.27.2022.02.17.10.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Feb 2022 10:53:54 -0800 (PST)
Message-ID: <12907bf2-6928-38a2-5edf-2d4889a3b033@kernel.dk>
Date: Thu, 17 Feb 2022 11:53:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC 01/13] io_uring: add infra for uring_cmd completion in
 submitter-task
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Pankaj Raghav <pankydev8@gmail.com>
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142228epcas5p2978d92d38f2015148d5f72913d6dbc3e@epcas5p2.samsung.com>
 <20211220141734.12206-2-joshi.k@samsung.com>
 <Yg2vP7lo3hGLGakx@bombadil.infradead.org>
 <CA+1E3rLpKp0h2x7CoFPXwsYOc4ZYg_sqQQ+ed8cJhq77ESOAjg@mail.gmail.com>
 <b11ede2b-b737-f99a-7b31-20d6b4eccb42@kernel.dk>
 <Yg6YDJHcSh1WPh2+@bombadil.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yg6YDJHcSh1WPh2+@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_105356_648228_68286E61 
X-CRM114-Status: GOOD (  16.27  )
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

On 2/17/22 11:46 AM, Luis Chamberlain wrote:
> On Thu, Feb 17, 2022 at 08:50:59AM -0700, Jens Axboe wrote:
>> On 2/17/22 8:39 AM, Kanchan Joshi wrote:
>>> On Thu, Feb 17, 2022 at 7:43 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>>
>>>> On Mon, Dec 20, 2021 at 07:47:22PM +0530, Kanchan Joshi wrote:
>>>>> Completion of a uring_cmd ioctl may involve referencing certain
>>>>> ioctl-specific fields, requiring original submitter context.
>>>>> Export an API that driver can use for this purpose.
>>>>> The API facilitates reusing task-work infra of io_uring, while driver
>>>>> gets to implement cmd-specific handling in a callback.
>>>>>
>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>>>>> ---
>>>>>  fs/io_uring.c            | 16 ++++++++++++++++
>>>>>  include/linux/io_uring.h |  8 ++++++++
>>>>>  2 files changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>> index e96ed3d0385e..246f1085404d 100644
>>>>> --- a/fs/io_uring.c
>>>>> +++ b/fs/io_uring.c
>>>>> @@ -2450,6 +2450,22 @@ static void io_req_task_submit(struct io_kiocb *req, bool *locked)
>>>>>               io_req_complete_failed(req, -EFAULT);
>>>>>  }
>>>>>
>>>>> +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
>>>>> +{
>>>>> +     req->uring_cmd.driver_cb(&req->uring_cmd);
>>>>
>>>> If the callback memory area is gone, boom.
>>>
>>> Why will the memory area be gone?
>>> Module removal is protected because try_module_get is done anyway when
>>> the namespace was opened.
>>
>> And the req isn't going away before it's completed.
> 
> Just to be clear, I was thinking outside of the block layer context too.
> Does this still hold true?

It has nothing to do with the block layer, the req belongs to io_uring
context. io_uring has ownership of it.

-- 
Jens Axboe


