Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293F9D5A6FD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTZDgqhJEDsELC5PEkzItKaVjSud571jl2i7knKDnmA=; b=vkVhF/eGO6uxj+VgZwRAWHM5q4
	XVNUFUTRN3R6Rjn1pTDGkUY2IxBCAvSxP6F+qyab2fyNRm7h6TW7szhZX74NURcf7yal/wRU3mV3P
	Lsq8Mwkmf6Q4F9nMs+xNkE9wfxwnbFJF/RhL1aOOtnGVhqR7NsrTNsZ+IMXUbuFrAN/rslMUgr+WO
	e0axtQXIJE/Qe2tbhyuOGLubIFbfAgmyy9Oz0joiOwA53Dp7EXc6ty6vly4Zimg6CD3E6z/AH0WUE
	Tk+NRSA7nfdvpkmZK1WxWR/4Zm8PT5MBNvCZEIowIm7b6nj32VtwG9/s0LQGSZxFhyTI93niK7fTy
	p2vGURSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFrCC-00000009zf1-1QYE;
	Tue, 26 Nov 2024 08:45:20 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFrAz-00000009zNC-2YYQ
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 08:44:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732610639; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=LTZDgqhJEDsELC5PEkzItKaVjSud571jl2i7knKDnmA=;
	b=H1kuHlkDOBzkymbHW6lEQuX0iAAPUW11o4vl/Sf0X77rflOKJIartL9cIMk3ZwiNhtaExzwkUKJUD56XH3PMRxzchQfhNx8Fo1R8IzdlD4xOZMwWqBPM7i/IeJB+kgV0RdMFErWfpFHd4bbbnv6Rpd/kTX91iCEmIEiXuL3QZOg=
Received: from 30.178.82.26(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WKHe.U5_1732610636 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 16:43:57 +0800
Message-ID: <926a7a12-fbdf-471a-906e-5ef41fddccad@linux.alibaba.com>
Date: Tue, 26 Nov 2024 16:43:55 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmetcli: fix double ana groupid when save config
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20241029034312.15083-1-kanie@linux.alibaba.com>
 <7539e263-76ed-4c54-91ee-f6ff1a5304a3@linux.alibaba.com>
In-Reply-To: <7539e263-76ed-4c54-91ee-f6ff1a5304a3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_004406_339008_8E94E0FF 
X-CRM114-Status: UNSURE (   9.82  )
X-CRM114-Notice: Please train this message.
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

Hi Christoph,

   Could you please take a look on this patch? And also "[PATCH] 
nvmetcli: reservation

configuration support" which send in 2024/10/29, thanks.

Best Regards,

Guixin Liu

在 2024/10/31 10:37, Guixin Liu 写道:
> gentle ping...
>
> Best Regards,
>
> Guixin Liu
>
> 在 2024/10/29 11:43, Guixin Liu 写道:
>> There are two ana grpid in json file after save the config,
>> including ana group: "ana":{"grpid"}, and "ana_grpid", remove one,
>> still one can use both of them to set ana_grpid.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   nvmet/nvme.py | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
>> index 59efdb5..41b4845 100644
>> --- a/nvmet/nvme.py
>> +++ b/nvmet/nvme.py
>> @@ -626,7 +626,6 @@ class Namespace(CFSNode):
>>       def dump(self):
>>           d = super(Namespace, self).dump()
>>           d['nsid'] = self.nsid
>> -        d['ana_grpid'] = self.grpid
>>           return d

