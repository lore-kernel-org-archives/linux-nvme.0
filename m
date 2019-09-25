Return-Path: <SRS0=H4mI=XU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077FBC432C2
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2019 23:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9BB21971
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2019 23:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTZC6+Af";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UkT/9kxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9BB21971
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cFspgx3hGxjCgJkLUc/TcZuPfaUckFM7rzMki6wtWIw=; b=rTZC6+AfUmlA/EzYDJdd8ohhY
	S1yPIBTKLqdEuQcmDXqwQZx3nQsmM3zxbEnu4SfDd9XDsVO0RAAw7M15K7A/k93cTqqKJbMcSZm4y
	6eFvuzj1eDCiqCdw1qkTcwPkhoVbUtr1LGKlj5r0nWYyUg6FU+83EOgtg/GobWOV1gdr1v1yNH7cJ
	vRSch57AndVn1ulw07gfD0cllcGQLleZm6W2RF1B5HM4vbzf1K8bVxx2qlfwXFBvh40erT+uXHMSf
	cjWFj+MJRVlfnRQ+lESsWR9ZvsrZAzeeLDUmQk2EdDXSKWfzCPld/IIjdBcLiX/NKsczOb3u+HVZI
	CU8dboM9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDH37-0004ED-Cd; Wed, 25 Sep 2019 23:50:21 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDH34-0004Dq-HU
 for linux-nvme@lists.infradead.org; Wed, 25 Sep 2019 23:50:19 +0000
Received: by mail-pf1-x443.google.com with SMTP id y5so548980pfo.4
 for <linux-nvme@lists.infradead.org>; Wed, 25 Sep 2019 16:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3MtFbf6O4/OfO0mTGs6bgYOVdqryII4YgHiHgCTwtB8=;
 b=UkT/9kxStTMUyKg8Ygd663zU8R8oy6d9v8WlxSLKRBXcOi/woZ+ByVrq2LSe5HjaK0
 deb+qOxLLJnQir7jkSaYFlwJjaoHvf2IOpsRD5jVfl60yVudruG29VNqwOS0p1bZnCyO
 4XTr/7VOkzrJccjkAkywmHhjuzqFh/BIe7HmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3MtFbf6O4/OfO0mTGs6bgYOVdqryII4YgHiHgCTwtB8=;
 b=Fj90yrtl5caqC3ChjqjpF0FIoLsKEurNWlgnTOsc9VSSlJIoKUDSqWUB39uDL5g9k/
 caq1U11ffRF2KZfk2UrHhjLhU2MIvKHNWzl75PbIk6CRMZNBW3fS+6XhKUQtCOB6M3qK
 +gV9VAX8P84LnsiCbiqm99sjmandzdkmaHHv7q9u0MsAgb/H8aHfVEtMg5d7jULHcWqU
 rZ8n+OZw0CY73yommSAlHqjFo/EcY4nzXnaE1jQ8xiUGWoZYRO7sHZo1CXM7BwjHLAZr
 iyvxCYNJVyg15rpK3bgFRHBhokW7Ud0+S00Xydrp2bs19ACzlTpzMGz00EkXUvpIPn0b
 5zbQ==
X-Gm-Message-State: APjAAAV2CmnhdHfBUx3y3M4j/M6ophhpgYdy/XXzmkV1GunA9CDUlK1U
 ad2S01O4s8JcB5yxtUdtdAe8nk9dSeY4RwmWPol5c7NqZScu7+q1Tss5Oy/pDr7caLB8+coKSaG
 uiFuLSpnAWMNmS7fkLhCYnnFJF14eJ2xD+1TTN95t8+PP1Py1PSUzCpBb/oAuKxNUNK380OhM0x
 oK1+1CiQ==
X-Google-Smtp-Source: APXvYqznmi9yxeldgNFqaJVGKbdVJPtbjFRbpvrvjvjDAAUn3NmLI3CBb/mFfWWtPGf2qW47yNFT5g==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr351263pfn.1.1569455416945;
 Wed, 25 Sep 2019 16:50:16 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id u10sm135830pfh.61.2019.09.25.16.50.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 16:50:16 -0700 (PDT)
Subject: Re: [PATCH] nvme: Add ctrl attributes for queue_count and sqsize
To: Keith Busch <kbusch@kernel.org>, James Smart <jsmart2021@gmail.com>
References: <20190924212208.3637-1-jsmart2021@gmail.com>
 <20190925213624.GA11469@C02WT3WMHTD6>
From: James Smart <james.smart@broadcom.com>
Message-ID: <aaee9df2-62ee-d460-ee01-8db3ecb407ed@broadcom.com>
Date: Wed, 25 Sep 2019 16:50:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190925213624.GA11469@C02WT3WMHTD6>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190925_165018_582426_7B885A35 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/25/2019 2:36 PM, Keith Busch wrote:
> On Tue, Sep 24, 2019 at 02:22:08PM -0700, James Smart wrote:
>> Current controller interrogation requires a lot of guesswork
>> on how many io queues were created and what the io sq size is.
>> The numbers are dependent upon core/fabric defaults, connect
>> arguments, and target responses.
>>
>> Add sysfs attributes for queue_count and sqsize.
>>
>> Signed-off-by: James Smart <jsmart2021@gmail.com>
>> ---
>>   drivers/nvme/host/core.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index e0e2dcbfd05e..b1c24af284ca 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3040,6 +3040,8 @@ static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
>>   
>>   nvme_show_int_function(cntlid);
>>   nvme_show_int_function(numa_node);
>> +nvme_show_int_function(queue_count);
>> +nvme_show_int_function(sqsize);
> The sqsize is only valid for fabrics, so I think you need to update the
> 'is_visible' to suppress this attribute for pcie.

I would think knowing the SQ size or an I/O queue is still interesting 
although perhaps not as useful.

Looking in pci.c:
- dev->q_depth is the baseline, getting stamped into each of the queue 
structures
- nvme_pci_enable() is setting dev->ctrl.sqsize to dev->q_depth - 1;

Or are you asking not to display it as the implied model for how many 
outstanding ios is different ?
note: I wasn't trying to go there - only to say what the SQ size is for 
an I/O queue

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
