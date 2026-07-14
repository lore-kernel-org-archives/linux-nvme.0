Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BDAC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 07:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9KQkV8KmVAD5xMWM22jikF3Qh5z1qltcs/MEwrSEYEY=; b=XAgx52OgxaojgTQBCzc09gfpwX
	gLVAqM1oG5OZh0hQ1crmRdzEq8JZURUAXgyFXW869f3is1261sKxaIQXRMJUsq7LZKc0lM/PjetnC
	qVmmk2LAFLxUIP47hDuxn8vQLXenRyqwMl7IIw4QHjpC+93C7/TVG/FhFcIv51fZI/0Jk4yGKwl0A
	7hnVato7LH8blKB714U3RrV3oUyP4bi6MAg85J1bL/8+RkuYaumhiD/3fpd5SNobEWxMzMsezjTIC
	egikj/qzm3y4/+YrBomJe4lr7Ou2iaOT07dWhebFmz5tTPgDp9+rVeRgNaFc35xCD0T14yokcpejc
	yBD6erxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjX9v-0000000B79b-3E8s;
	Tue, 14 Jul 2026 07:02:27 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjX9t-0000000B78h-21dK
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 07:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784012542; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=9KQkV8KmVAD5xMWM22jikF3Qh5z1qltcs/MEwrSEYEY=;
	b=e9WH8hdG4XT8V0zn5mU6c92WXnCH1G8tN1l+kO9dm2WZvLRXA3HC2p32ed18N+22yyqDbLlqtzTnoJnjQGKNjRCAdJaJpznatW4FunNOPXHgDdBTduo8J751Ug5G/jUXzRf7aTiFZX/EgDpduTVfPQ9zFKs9ON6TZE1hjV4XyLo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X73Hb4q_1784012540;
Received: from 30.178.83.149(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X73Hb4q_1784012540 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 15:02:21 +0800
Message-ID: <f5e7ed68-7df0-4ae2-94f7-bde004f9b12f@linux.alibaba.com>
Date: Tue, 14 Jul 2026 15:02:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-multipath: expose path_state via sysfs
From: Guixin Liu <kanie@linux.alibaba.com>
To: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20260624054843.1132083-1-kanie@linux.alibaba.com>
 <01e1bdfa-2917-401e-9ffb-a2229798e542@oracle.com>
 <c9b1d8fd-7012-44a0-a975-947fc0e16fac@flourine.local>
 <315b3fcf-a4ba-4f81-aa16-0d2f61a47b5f@linux.alibaba.com>
 <7da38928-fcb6-4ae4-891a-a71516b2977c@linux.ibm.com>
 <f00962bb-630d-46d1-9dce-d09f1176111f@linux.alibaba.com>
In-Reply-To: <f00962bb-630d-46d1-9dce-d09f1176111f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_000225_663844_F135E813 
X-CRM114-Status: GOOD (  14.37  )
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

Hi Keith, gently ping.

Best Regards,
Guixin Liu

在 2026/7/7 09:47, Guixin Liu 写道:
>
>
> 在 2026/6/24 21:21, Nilay Shroff 写道:
>> On 6/24/26 5:22 PM, Guixin Liu wrote:
>>>
>>>
>>> 在 2026/6/24 17:55, Daniel Wagner 写道:
>>>> On Wed, Jun 24, 2026 at 08:36:44AM +0100, John Garry wrote:
>>>>> On 24/06/2026 06:48, Guixin Liu wrote:
>>>>>> Add a read-only "path_state" sysfs attribute to each NVMe path 
>>>>>> namespace
>>>>>> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
>>>>>> current path state, including whether the path is enabled or 
>>>>>> disabled
>>>>>> with a specific reason.
>>>>>>
>>>>>> Factor the path disable checks from nvme_path_is_disabled() into 
>>>>>> a new
>>>>>> nvme_path_get_state() helper that returns an enum 
>>>>>> nvme_path_state. This
>>>>>> keeps the path selection logic and sysfs reporting in sync, so 
>>>>>> any future
>>>>>> updates to the path disable criteria are automatically reflected 
>>>>>> in the
>>>>>> sysfs output.
>>>>>>
>>>>>> Possible values:
>>>>>>     - "enabled (optimized)"     : ANA state is optimized
>>>>>>     - "enabled (non-optimized)" : ANA state is not optimized
>>>>>>     - "disabled (ctrl_down)"    : controller is not live
>>>>>>     - "disabled (ana_pending)"  : ANA state change pending
>>>>>>     - "disabled (ns_not_ready)" : namespace is not ready
>>>> I'd prefer to have a single string here instead of something we 
>>>> might need
>>>> to parse again. The sysfs docs says
>>>>
>>>>    Mixing types, expressing multiple lines of data, and doing fancy
>>>>    formatting of data is heavily frowned upon. Doing these things 
>>>> may get
>>>>    you publicly humiliated and your code rewritten without notice.
>>>>
>>>> Something like
>>>>
>>>>    - optimized
>>>>    - non-optimized
>>>>    - ctrl-down
>>>>    - ana-pending
>>>>    - ns-no-ready
>>> Would this be redundant with ana_state?
>>>
>>> Is this OK?
>>>      - enabled
>>>      - ctrl-down
>>>      - ana-pending
>>>      - ns-not-ready
>>>
>>>
>>> CC Keith, John, Nilay, what do you think?
>>
>> I tend to agree with Daniel about both mixing types and
>> reporting ana state values here as ana state is also reported
>> separately.
>>
>> The purpose of path_state is really to expose whether the path
>> is currently eligible for path selection and, if not, why.
>>
>> IMO, a simpler set of values which you suggested above
>> should be sufficient. But lets wait if Keith has any
>> other suggestion.
>>
>> Thanks
>> --Nilay
>>
> Hi Keith, would you have any suggestions on this?
>
> Best Regards,
> Guixin Liu
>


