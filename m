Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179B7C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 21:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lqj2Sj1WD3h8qcIPIllngdavlJ72krfa06L6nQEYsm8=; b=a7rgdGCEZwlaDMlB62cBzJojVz
	do6CvS99dce/1cmXypfpVRd+xikeD4Inx+CSEju2e5hrBGQB7MsW4Pi/gmVC5S47NrR8ytGV01O3w
	RwGBs1F5FnEbnmvxFIMHgBSQcaBX1AVnZhTgm9RfMZkMcdzYfaLaqw8OxMBBsHyBk5O+PrEq9tr4w
	WPmUWedLbE8JCxvi3MR9Ut4LUgi6Guis95A2Sde8VlzcNq+cExy1PDm3GlFDWxqpMFQEwDsZq3wfI
	+7fGgCpngPN6AEgG26P7vod8w2C+D4ih2W4EJbR4NIpPPyXJ3NnZAzLS4mn/gq9jm0QSV8vo6fNOc
	lEpO3oPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntcKR-009GKu-Ej; Tue, 24 May 2022 21:44:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntcKO-009GKY-3j
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 21:44:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653428671; x=1684964671;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Vqym54IY1iBLpuhwhOacIZfHKu1+sZTGVW4+x6PjMJQ=;
 b=KxA1S/tVHFuBMxEqG+j8BaIODAwLePOA6xKgVv0U5rVJkUEGATWQmBrL
 sBraiuGmZAkdAu2xl5EjLLPQ9/oFsywNIL5xYaPT9C0o6I+IpBRu9LMZD
 4+Tepu9rMLf4R0bg9WFy5HPe/ebFyquWjGa2RR9nELzDa+9fh3+v5gTTv
 jRB7w6GWdYGtxI27EO07b+IsF20vn6oQ+Q2ajINBrMYkVTJtpKuL0nLwc
 hOOMncgsGIVkkhYtfTQXRfSvaQxBn6CiXCofMQ39Vdg1tJfl6hMr9WMvA
 gOr0BsNMau62WbivHQXYueHQRWmILlAehSOnqRngdwuV2jnFytVKUYg8H A==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; d="scan'208";a="305563277"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 May 2022 05:44:28 +0800
IronPort-SDR: VHEiVCQHUmDun3Gv+PIZ44gfAvQmLS4i5x/ZrAPAQtyKtPIRGnhujGU/FOXqkywZaXmQ+fv9h2
 tUPZ4qrXVDaj8EW82sF3b55c4RxpV2udjeReqVgwBEmIV4fy7AtpVmmge9YtV/XKsbVHOem7tA
 Hag2oYk2GRAwyrsuGEdDDMu9QwmGdJXMYJkAT9AfLV7S7MWFZ5cK1wVHqmsTsrkcBUfiJo/YOz
 XXN7rkKzClL/ybr00+qeV7WiAPZgeKmF0ABh3cxD9sz2mUyWmF8Ob2qNaMrELgCyVtx+cLFCcx
 wLYWWvdT2/VKkqCxQqMEoJ4m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 May 2022 14:04:00 -0700
IronPort-SDR: bgqVhFNcGpK2LGzCFIcVpLHgszI2wM///BE/965DAz/MmaGcwEwmiKxsIx7FrfjuYGwnuYEfXC
 srZH754Gl0RexZSeNfRtUt34OaufaGI5VRlyBJUniwKRiVGV4daQ4JepWY7qOQ/xSLsqXFX43L
 yYVCqqMkAZ78Of8nTno3ncu5WwPVEmq74lIhJeWb67hFGnbRsSg7XfPXy8ODbZ1jR7ncIRkooB
 P8ZOv1X8QkZ8CUop591oxZ8f4aR0RlqHNcdGdRvOTjew1tqjLZhiKA5JsGWw3DXONkqJV78zqe
 g20=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 May 2022 14:44:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L77582VWFz1SHwl
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 14:44:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653428667; x=1656020668; bh=Vqym54IY1iBLpuhwhOacIZfHKu1+sZTGVW4
 +x6PjMJQ=; b=l++8cHIspYbzjgj1G2iYWDiGSr8SzXH1hu/9xGxKCBLg6LXZafM
 LMcq5r29bhT9MtLTtvR40pnHtS2lMVYo/dKOBQgi7euiWOlCKXPciolZnJmGLw1o
 i9IuT714VCA7FWaEy23awzR26du7lIo511cWc4eVg/znPrDsdriyWJqvFZnJ5a/+
 lWpd/5IWN74N6d6UlPyYeMPPdNXoNtXuhFBu4SNlaXw9qugVny0wSy92X2U//L6z
 8/3VBP0nJw7mc4q+CmJ8J5IgQ6qrW1gknUUky2bKUh/rUr9VwGnz0PNBnAn+iWpz
 byvLZaq2uNf4XAYsGV5xlho4RpgCM+R2pSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id It8igfXcZ9R7 for <linux-nvme@lists.infradead.org>;
 Tue, 24 May 2022 14:44:27 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L77571wBKz1Rvlc;
 Tue, 24 May 2022 14:44:27 -0700 (PDT)
Message-ID: <4c78726a-5c37-f1f6-014d-259bb9bdf252@opensource.wdc.com>
Date: Wed, 25 May 2022 06:44:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: nvme: split bios issued in reverse order
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
 <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
 <Yo0xE5g3bowmF3H0@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0cpUNdb3mu+9pHG2oDfBmgmmCMQAo13axqO=jL5fwr_QJA@mail.gmail.com>
 <Yo1AOXKXkmrnnvou@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0coj1vAKRgf5BHAvjWeNgwj0JXyfDm6kFN48ZMpfdoHA7g@mail.gmail.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHex0coj1vAKRgf5BHAvjWeNgwj0JXyfDm6kFN48ZMpfdoHA7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_144432_347012_CB5CCEC0 
X-CRM114-Status: GOOD (  18.53  )
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

On 5/25/22 05:32, Jonathan Nicklin wrote:
> On Tue, May 24, 2022 at 4:29 PM Keith Busch <kbusch@kernel.org> wrote:
>>
>> On Tue, May 24, 2022 at 03:37:56PM -0400, Jonathan Nicklin wrote:
>>> On Tue, May 24, 2022 at 3:25 PM Keith Busch <kbusch@kernel.org> wrote:
>>>>
>>>> On Tue, May 24, 2022 at 12:12:29PM -0400, Jonathan Nicklin wrote:
>>>>>
>>>>> The command lines you have are for read operations. The behavior seems
>>>>> only to appear with writes.
>>>>
>>>> Huh, I'll be darn...
>>>>
>>>> I think it's because the writes are plugged and the reads are not. The plug
>>>> appends requests to the head of the plug list, and unplugging will dispatch the
>>>> requests in the reverse order.
>>>
>>> Thanks for confirming! That's about where I got to. Do you have any
>>> ideas on what might explain the difference in behavior between
>>> fio/pvsync and fio/libaio? And, why does this not seem to occur when
>>> only one nvme queue is present? Perhaps the in-order cases are an
>>> indication of not being plugged?
>>
>> I actually didn't see a difference between libaio or psync, and also io_uring.
>> They all plugged and reversed the dispatch order. Do you have a scheduler
>> enabled?
> 
> Nope, there's no scheduler in the way.

If the drive is exercised at QD=1, e.g. psync() and libaio with iodepth=1,
then plugging does not matter as there will be no merge (so no at-head
insertion in the plug). Commands will be executed in the user submission
order. At higher qd, if merge happen while plugged, then order will be
reversed (libaio with iodepth > 1 only).

> 


-- 
Damien Le Moal
Western Digital Research

