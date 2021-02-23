Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CDC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 14:36:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2026564DD3
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 14:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2026564DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IVHTWTUHp1rSrwY0UHEHD6DIrs2wd7oPZ6+OakAAls0=; b=P1iC+DUsifvDwv2tfPEL5NsqX
	zjayKbrSqQpIXwwmKyjVHmEiZ0faWYrJETjQVIw0iXYwNKjCgOy/8rkKJUMk1mfR0MNAKvoSCOOmT
	Ch3o1jEv2W80UGjBlXBtPhuZ85IfLWYRKKmTKfd4EE3vnxlo7gZFiGBkbYYASzoGrVIbhGKR1vVHX
	rHt4C4sFAmlbANOHZzds0HFl7ez61gUKuzcSvhowaKR/xrAsGJBir1kel+LvcRR8CjIW4WOOwxRnr
	TxtWP4SCjDUkS5aZqZmb78SGSLlmTyGzRE8WjsSQ4/+RRdsQNZKaxYC1ILOjh5AC+RzXG5y77eEEw
	oou+NyiGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEYni-0004Qq-Es; Tue, 23 Feb 2021 14:36:34 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEYng-0004QA-6O
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 14:36:32 +0000
Received: by mail-ej1-x62f.google.com with SMTP id n20so8923512ejb.5
 for <linux-nvme@lists.infradead.org>; Tue, 23 Feb 2021 06:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:references:from:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3vlg+HYSB0G3JjaliNWg45EhEAsYZxyZW5PwGPBXj3U=;
 b=V5QnbmThskut+D/RjsgEI8AcX5A4Q7zU5G4TFIFy7wr8frWtiF1sjiGgfaPY/OlbD8
 OZ1EiD2olXTNX/vXVMjflqfn7n47dV3k2mgQ/PzHzSS3XA13WEtnRZzPU5tP0DKw3fBs
 PQ09bfaoRD6SVGEr1FR/Aay9+2ZjEVaKujiJUC9vIqv3WdWixwZCQlHNeyu1ak3h0fr0
 l/WU4i498bFE3JrpDdVfF654ulNMecJH0D8pcXVQQfzIDo4l46yew+KAOwRbT95ZA/3j
 +zXB0S4PCotkPhC3F9+DiR8IPDCQ6Ug8cuoK8nXmmyjO6dEeC6v/3ktDdJHBxtGtrzRe
 ezDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3vlg+HYSB0G3JjaliNWg45EhEAsYZxyZW5PwGPBXj3U=;
 b=Xdn40zZYQz+wcKtDFZNGk5V0hQclrzsl/I7pjGzR67vPWZyILre20QWoyVI0SvxH9t
 R64IoRzAobv8a0rVyFP/3HYXMYMbiYvNg6eD0KIg0xHnyGk+/w+DWGMo5OHACNZRLWrj
 SSsU6tB9622Yup3M5z6iyh8HUEZ1zu3WHfMtInwITdYM/ujhFE7dQicVKvHsdldXfJOD
 u5V5ZS1fQcVESi9iahFsECKB1pYcQ9PLUcloqp9/gHe6c+9lfiKe7FOxYawR8RyR3Eju
 ff5B3Fk00OD8PkDOV/X2cCt3x4WrYxV+kfPid5wRlRGgfcd9f7UR4szZWbDfHUEWVw4C
 ry3A==
X-Gm-Message-State: AOAM532CndDidkrNvAFmSfY6AL/8ERRsIJFQ9gWfdQlJNQ+YvKwjMd+x
 ORlgxqFNtsVXVh+JkAXq9YA=
X-Google-Smtp-Source: ABdhPJxO/Ea6DLcEef6MhrIUVvwlG0gBRYilxkoBNTZ0LClhtnjxHK9+X6SKEQL025iDOpTFyeLv1A==
X-Received: by 2002:a17:907:c27:: with SMTP id
 ga39mr27055688ejc.68.1614090989031; 
 Tue, 23 Feb 2021 06:36:29 -0800 (PST)
Received: from ?IPv6:2003:ea:8f39:5b00:c6c:1f6:5faf:985f?
 (p200300ea8f395b000c6c01f65faf985f.dip0.t-ipconnect.de.
 [2003:ea:8f39:5b00:c6c:1f6:5faf:985f])
 by smtp.googlemail.com with ESMTPSA id n5sm14724232edw.7.2021.02.23.06.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Feb 2021 06:36:28 -0800 (PST)
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210219063726.63728-1-chaitanya.kulkarni@wdc.com>
 <80fc53d2-4f35-7c72-5cc5-3ec13c5ee51a@kernel.dk>
 <BYAPR04MB496513669571FA6541E58B8686809@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] nvme-pci; remove the barriers nvme_irq()
Message-ID: <f2d9cd44-8f24-a4ee-ca26-a1d2b8c74c3d@gmail.com>
Date: Tue, 23 Feb 2021 15:36:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496513669571FA6541E58B8686809@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_093632_278613_244E7F6C 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: Jens Axboe <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 23.02.2021 07:54, Chaitanya Kulkarni wrote:
> (+Heiner)
> 
> On 2/19/21 05:40, Jens Axboe wrote:
>> On 2/18/21 11:37 PM, Chaitanya Kulkarni wrote:
>>> The barriers were added to the nvme_irq() in the
>>> commit 3a7afd8ee42a ("nvme-pci: remove the CQ lock for interrupt driven queues")
>>> to prevent compiler from doing memory optimization for the variabes that
>>> were protected previously by spinlock in nvme_irq() at completion queue
>>> processing and with queue head check condition..
>>>
>>> The variable nvmeq->last_cq_head from those checks was removed in the
>>> commit f6c4d97b0d82 ("nvme/pci: Remove last_cq_head")") that was
>>> preventing  poll queues from mistakenly triggering the spurious
>>> interrupt detection.
>>>
>>> Remove the barriers which were protecting the updates to the variables.
>> Would seem prudent to just ask the original submitter to send a v2
>> of his patch, as that's where it came from.
>>
> Please let me know if you want to send V2 otherwise please ack this series.
> 

Fine with me if you send the patch. You could just add a Reported-by

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
