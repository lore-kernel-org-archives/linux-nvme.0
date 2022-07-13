Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC72C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YNfmnBevLQmSX9o76Mh2mjvcTRQ7EQJDjtg54zLGl04=; b=Z6SiCa9Z4DFUOT68PHzzmdYGlQ
	v7wRb2Y4z59h+Qqv9q4wk02VDFpQBMHSLGlFqT9DkrMIm60debR8g5AXsxioi6qcrLIA82KdKhwPP
	G/Lu5KMtZXEQlYYOiZC33UoXIBqDWnOpHrOgyoUF6U+avmq+CxmMDrlwR+37AUd/Jj+7C2Je7faVR
	9grsfJWWMKeSl6ihxcVfaEDr4es/I7QdyDCV7T7o2Z20R9EH0z2CqS5Mpo/WmY8jXCBqz/MGv2vSC
	WHSmDGQkzO2R+Dr+l2gUzOLCZX+Kzs/3pybqFNofRU8G2Ddnse5fZ79ZSAos7PZfkBg0irAyFIWGv
	4IuAVvVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbiW-003csB-Pl; Wed, 13 Jul 2022 12:43:48 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbiU-003coY-QR
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 12:43:48 +0000
Received: by mail-wr1-f44.google.com with SMTP id d16so15315459wrv.10
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 05:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YNfmnBevLQmSX9o76Mh2mjvcTRQ7EQJDjtg54zLGl04=;
        b=LIlOqoOKcororOmdhvE/SivyGRkhYPUiMdXmzlwe7X6GhRDAyB+t/pqsz+WL/gkvf3
         mOC5YgOqQdCeZpZGdDEcjHaR0JBlM14IZFP4Fz50LZ53vT2AV6FI7vU3y6APCpZGUBUp
         FxzUNExGUzXb9BwPqJTNyvCV6UdCPBM0f0rjv9OZKJgPNzXCIfaffC4t7H52b0y1o+b7
         dhjZL51KTyIIItn2lUw2V8FlV6Why5oAv7Q6r7ceLbkxy/jW8JM9meuBPEUCGZ/yVEvr
         6Rc+ji2cJh3XYBOwWehZ1zA1X9KWwKKHIp5h5Hs8DljFB1vI5u+iBWY1iYqXG4yuCPfi
         OuTw==
X-Gm-Message-State: AJIora/poocWL7Wq3ze1P18npBX3QHXBK9Az7Q4ysLYPfWOw1fG6Fsr0
	3ynHuLik14az+SzuBPvQYl8=
X-Google-Smtp-Source: AGRyM1twAonTFmo1o0pkRBxXTqOM0VE5qj+d65TCkBzKOADontj9hlEjq4fJBLXpaLfXhOwP1f3IFA==
X-Received: by 2002:adf:ee8a:0:b0:21d:76f0:971e with SMTP id b10-20020adfee8a000000b0021d76f0971emr3238256wro.130.1657716222828;
        Wed, 13 Jul 2022 05:43:42 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b003a2e92edeccsm2058462wmq.46.2022.07.13.05.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 05:43:42 -0700 (PDT)
Message-ID: <7c7a093c-4103-b67d-c145-9d84aaae835e@grimberg.me>
Date: Wed, 13 Jul 2022 15:43:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de>
 <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
 <20220713053633.GA13135@lst.de>
 <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me>
 <20220713101235.GA27815@lst.de>
 <772b461a-bc43-c229-906d-0e280091e17f@grimberg.me>
 <96f47d9b-fbfc-80da-4c38-f46986f14a43@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <96f47d9b-fbfc-80da-4c38-f46986f14a43@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_054346_876751_FE6D0AA6 
X-CRM114-Status: GOOD (  20.11  )
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



On 7/13/22 14:49, Hannes Reinecke wrote:
> On 7/13/22 13:00, Sagi Grimberg wrote:
>>
>>>> Maybe the solution is to just not expose a /dev/ng for the mpath device
>>>> node, but only for bottom namespaces. Then it would be completely
>>>> equivalent to scsi-generic devices.
>>>>
>>>> It just creates an unexpected mix of semantics of best-effort
>>>> multipathing with just path selection, but no requeue/failover...
>>>
>>> Which is exactly the same semanics as SG_IO on the dm-mpath nodes.
>>
>> I view uring passthru somewhat as a different thing than sending SG_IO
>> ioctls to dm-mpath. But it can be argued otherwise.
>>
>> BTW, the only consumer of it that I'm aware of commented that he
>> expects dm-mpath to retry SG_IO when dm-mpath retry for SG_IO submission
>> was attempted (https://www.spinics.net/lists/dm-devel/msg46924.html).
>>
>>  From Paolo:
>> "The problem is that userspace does not have a way to direct the 
>> command to a different path in the resubmission. It may not even have 
>> permission to issue DM_TABLE_STATUS, or to access the /dev nodes for 
>> the underlying paths, so without Martin's patches SG_IO on dm-mpath is 
>> basically unreliable by design."
>>
>> I didn't manage to track down any followup after that email though...
>>
> I did; 'twas me who was involved in the initial customer issue leading 
> up to that.
> 
> Amongst all the other issue we've found the prime problem with SG_IO is 
> that it needs to be directed to the 'active' path.
> For the device-mapper has a distinct callout (dm_prepare_ioctl), which 
> essentially returns the current active path device. And then the 
> device-mapper core issues the command on that active path.
> 
> All nice and good, _unless_ that command triggers an error.
> Normally it'd be intercepted by the dm-multipath end_io handler, and 
> would set the path to offline.
> But as ioctls do not use the normal I/O path the end_io handler is never 
> called, and further SG_IO calls are happily routed down the failed path.
> 
> And the customer had to use SG_IO (or, in qemu-speak, LUN passthrough) 
> as his application/filesystem makes heavy use of persistent reservations.

How did this conclude Hannes?

