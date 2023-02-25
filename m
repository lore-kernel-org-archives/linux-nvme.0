Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54ACC6FA8E
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Feb 2023 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMKWMVq/dQuRdLL3+gbPyFzQ+ELk73IK74JFcou7bs4=; b=0ysVFE+oMLZ7U+oH41hRdxLx43
	XF0/su2+OAT7cp1UV0iyPx00TIJDUi9CxK2sH6ofXiOOg8OG0o4w7XY2EebUTnaAmeqeUSJ5cL1z0
	qkwqY1FJqSjzMqEQSi2L0ofsYgNFVsM4TCSX5F0fg+xMdw/P3FlG3ceIRNCgbwK825SVAr7j22jN2
	x56zOc0KTyZ8YPHSErD8XtBjHIqQTrydwQGRd7rJgPDMvZQE5koUTsGvDoVo3xFj5Dm2ZZF6lJAuq
	aTxPipnB2RkqvhvS+cHrQyAFsx1GWo5mgqRnJuAfMojUQoArHxXxa3DhBJBWV2QJnXfJRlUq2wbOe
	XSyxCyZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVxCS-005zd0-Fw; Sat, 25 Feb 2023 16:15:04 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVxCK-005zcI-Rh
	for linux-nvme@lists.infradead.org; Sat, 25 Feb 2023 16:14:58 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id y3so1602856qvn.4
        for <linux-nvme@lists.infradead.org>; Sat, 25 Feb 2023 08:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMKWMVq/dQuRdLL3+gbPyFzQ+ELk73IK74JFcou7bs4=;
        b=P9w7/5dS+b1A3/eScpMyudk58XrvYwEdtWlyOTFz3Zgu/ZTGMUpL7/QAgtgDkviQdZ
         RbZiQqz1M4zBTeN6UfKL+v0WrtfTaB3TbOsHG374l7z2uhdjDfz21ZN/MGj5Ow7mT8dP
         E6BMKxWDZpxTQiy7l9pKwrqK/8yglzeFlTNFNHCdbfFxCxHTIZTrDf58nDguM8MkmF+b
         Soca7ZzWx1Bs43r+dJ2SCNiCDmkQvtv8dRd3rC6MRiefTZWMJGuhGoVev9ef+YT4ic2s
         4xuuf9uwt/0d97z3+hF5p8xWz+TClgjcVbRWHcuwKtuaK27IE33jecUMj6aVzffmXTyx
         nOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMKWMVq/dQuRdLL3+gbPyFzQ+ELk73IK74JFcou7bs4=;
        b=blaFFNRUfdzgsowC+S5CTzKRRoi/Tpv37Wnsy87GDFpnT19pWoCrj4VkE3xoJtKm+R
         eZbOLI00+bJsVy1NfV1UxcAaLm08VF1SaUmLQkwY6rqSSjZKQyrF1A6M7njqXmlGPEbX
         6DJslUcsKG5ny5jyUcSMEY5kvFqq9HNsfuTLGTJJd1H/TA+BULzGQ5eFt5swpAjqwcMs
         WRZXcddGBpqcTydtNvqtV/d6lVnfbi0c/FJMgT1Dxr9W0etqsHl7oCGa1k1I1FKU7iHV
         rkTEPLOSHcyeyPY5vIDPRuK2d9jLBadqyRAEQkuCnZjthNBwniZacPBoNc3i58+tt/BJ
         GHpQ==
X-Gm-Message-State: AO0yUKUSlI8RvI+DqqyfzYA2T8w4A7KmxC63qI6IgXmkD3qDOB4/PS29
	0fcD/4nxDSLdM6o8zBuK+d0=
X-Google-Smtp-Source: AK7set/nTWxpujPSYH7fTTZKt0JRfegbUHHhg7QdlhLCeslXD6jFEwqpJBNT81JQt9PPzQMHMkBG6w==
X-Received: by 2002:a05:6214:b6a:b0:570:bf43:491 with SMTP id ey10-20020a0562140b6a00b00570bf430491mr38090901qvb.5.1677341692608;
        Sat, 25 Feb 2023 08:14:52 -0800 (PST)
Received: from [192.168.50.208] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id bs17-20020a05620a471100b00706b09b16fasm1480789qkb.11.2023.02.25.08.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 08:14:52 -0800 (PST)
Message-ID: <4feead4e-2cb5-a6bd-0db8-a4fe08b8efc6@gmail.com>
Date: Sat, 25 Feb 2023 08:14:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "dgilbert@interlog.com" <dgilbert@interlog.com>,
 Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
 <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
 <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
 <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230225_081456_951306_439F2EEA 
X-CRM114-Status: GOOD (  21.41  )
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

On 2/24/2023 8:15 PM, Damien Le Moal wrote:
> On 2/25/23 10:51, Keith Busch wrote:
>> On Fri, Feb 24, 2023 at 11:54:39PM +0000, Chaitanya Kulkarni wrote:
>>> I do think that we should work on CDL for NVMe as it will solve some of
>>> the timeout related problems effectively than using aborts or any other
>>> mechanism.
>>
>> That proposal exists in NVMe TWG, but doesn't appear to have recent activity.
>> The last I heard, one point of contention was where the duration limit property
>> exists: within the command, or the queue. From my perspective, if it's not at
>> the queue level, the limit becomes meaningless, but hey, it's not up to me.
> 
> Limit attached to the command makes things more flexible and easier for the
> host, so personally, I prefer that. But this has an impact on the controller:
> the device needs to pull in *all* commands to be able to know the limits and do
> scheduling/aborts appropriately. That is not something that the device designers
> like, for obvious reasons (device internal resources...).
> 
> On the other hand, limits attached to queues could lead to either a serious
> increase in the number of queues (PCI space & number of IRQ vectors limits), or,
> loss of performance as a particular queue with the desired limit would be
> accessed from multiple CPUs on the host (lock contention). Tricky problem I
> think with lots of compromises.
> 

 From a fabrics perspective:

- at the command: is workable.  However, the times are distorted as it 
won't include fabric transmission time of the cmd or rsp, nor any 
retransission of cmd xmt or rsp xmt under the fabric protecting against 
loss.

- at the queue: is not workable. It effectively becomes a host transport 
timer as the cdl has to cover all fabric transmission times and the only 
entity that can time/enforce the timer is the host transport. Also, what 
does the host transport do when the timer expires ? there are only a 
couple of things it can do, all of them disruptive and at best delaying 
the response back to the caller.

- CDL can only be meaningful (ie completion times close to cdl) in the 
absence of transport errors. Cmd termination, perhaps tied with 
connection loss/failure detection as well as connection/queue 
termination or or association termination - can have timers that are 
well above the CDL value.  Any cmd completion guarantee within time-X 
can become meaningless.

-- james



