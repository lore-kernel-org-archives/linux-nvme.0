Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B93FC25B75
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8WfBxq8XLRTBZ5tQIhY0Q9aeK+UOqcJTpHkcaQ+TpQ=; b=OaDtPf8Tt9OXXn8MHpX+8YqbBL
	3qkAKglVGV6Q3bluFdamv/8cmeJNYZu5USva8m6k2Dw5xA7elqwFbwfcBjtBcjnUIKxf9t7As2PiY
	Sr6AJMUxouO8G2Tcya9mGrnsMecPn2DW4P1UGb9mUAisv5LqTNggS/x4b1ZF4tYXE1Iudr0iLN+/p
	EQMMxdnjdo9fybRKpDa43XgVpBsRQwRYzyJiIy+hfGz7VLVmn4Ap+Pf3Vd9Yy9F78EbNjQJ27KGvF
	wW0/6Okp5DsbLoYI8dZQX00R/GfNjT+8ny+82gLJnYe0wJJOS6PO3Fm53MugE1gonGTBm+cfW63xt
	0n2kndkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDDse-0000000BoI8-3uGC;
	Sat, 01 Jun 2024 01:50:00 +0000
Received: from out-179.mta0.migadu.com ([91.218.175.179])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDDsb-0000000BoGe-1Dvy
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 01:49:59 +0000
X-Envelope-To: bvanassche@acm.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717206585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8WfBxq8XLRTBZ5tQIhY0Q9aeK+UOqcJTpHkcaQ+TpQ=;
	b=h1JCQf3bfvXrbdLOdGdABlt8LfZALDMGbAVnfTqDUYOxSM3Tq18lpwx0IEIulB64lhNDA3
	hEnw9oEijJgYuLz0ms7jokSKK7Z/9F0rB7hrgOkVmnHSUmodBVnfAwpV9MjYzzJQb9nOBk
	94sVvCusQLEVWDHsZow2xEDcZ6Ha9cQ=
X-Envelope-To: zyjzyj2000@gmail.com
X-Envelope-To: shinichiro.kawasaki@wdc.com
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-nvme@lists.infradead.org
X-Envelope-To: linux-scsi@vger.kernel.org
X-Envelope-To: nbd@other.debian.org
X-Envelope-To: linux-rdma@vger.kernel.org
Message-ID: <53f5e515-bad2-4094-ab7a-64d807ce1223@linux.dev>
Date: Sat, 1 Jun 2024 03:49:39 +0200
MIME-Version: 1.0
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
 <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
 <b29f3a7a-3d58-44e1-b4ab-dbb4420c04a9@acm.org>
 <CAD=hENdBGcBSzcaniH+En6gecpay7S-fm1foEg5vmuXiVYxhpQ@mail.gmail.com>
 <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
 <CAD=hENdgS40CmZs2o5M_O71k07Q7txg9-2XnaHP97_+eC9xT3w@mail.gmail.com>
 <81a63f38-fab0-4536-bbc2-3f06752a7f9e@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <81a63f38-fab0-4536-bbc2-3f06752a7f9e@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_184957_490885_24E5F5AC 
X-CRM114-Status: GOOD (  12.92  )
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

在 2024/5/31 22:46, Bart Van Assche 写道:
> On 5/31/24 13:35, Zhu Yanjun wrote:
>> On Fri, May 31, 2024 at 10:08 PM Bart Van Assche <bvanassche@acm.org> 
>> wrote:
>>>
>>> On 5/31/24 13:06, Zhu Yanjun wrote:
>>>> On Fri, May 31, 2024 at 10:01 PM Bart Van Assche 
>>>> <bvanassche@acm.org> wrote:
>>>>>
>>>>> On 5/31/24 07:35, Zhu Yanjun wrote:
>>>>>> IIRC, the problem with srp/002, 011 also occurs with siw driver, 
>>>>>> do you make
>>>>>> tests with siw driver to verify whether the problem with srp/002, 
>>>>>> 011 is also > fixed or not?
>>>>>
>>>>> I have not yet seen any failures of any of the SRP tests when using 
>>>>> the siw driver.
>>>>> What am I missing?
>>>   >
>>>   > (left out a bunch of forwarded emails)
>>>
>>> Forwarding emails is not useful, especially if these emails do not 
>>> answer the question
>>> that I asked.
>>
>> Bob had made tests with siw. From his mail, it seems that the similar
>> problem also occurs with SIW.
> 
> I'm not aware of anyone other than Bob having reported failures of the 
> SRP tests
> in combination with the siw driver.

At that time, I had not reproduce this problem with SIW, either.

Zhu Yanjun

> 
> Thanks,
> 
> Bart.
> 


