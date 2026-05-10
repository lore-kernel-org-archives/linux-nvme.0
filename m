Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DABDCD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZKmIoRTQbXf9l//5+Xb2z7l0ctA1iIgLATiLskWI0Y=; b=q9cm6/bnnrZMAf+KVBmxutTeo3
	ORkEsQqrLLJyBYOPovLwyDtoK7Xyx3VRipZPi/CYbrsD363vPr2MxgYL6c1l+gY+z+46vRyeBRATk
	pfepCTpV6HMuOquZUNmDVLFApz1ZO5k8NHBQXx50D0bN05g5mqhYsLG7vxglmeR5vtIIDkmXnDzDI
	AVgktCnFGm0W9FT4v0UL5Y5l3wbQo5h4xX1TtNfAzai1vEl0tS7fNURt+LvaUewJGzBV8pxW0Ar3U
	hsW5PMo8pVjEIeyCMh9cm/epJgNiD71s6f6Yn2iJfdYQelzpdjlD+Ei3saZLdTNt9nc4dKq9+raDe
	QJmAsKGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMB9S-0000000Bbiy-0ieb;
	Sun, 10 May 2026 20:53:26 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMB9P-0000000BbiI-171T
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 20:53:24 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso43209255e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 13:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778446400; x=1779051200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZKmIoRTQbXf9l//5+Xb2z7l0ctA1iIgLATiLskWI0Y=;
        b=gGdQVK88clGzKCtzttR84TkQqEf44fGq1x0UtVISS4QNExEaxbuvVjCxd9uKazNL49
         nX9KDsJ2sXKa+tNBNtoAyIymw0f6jQwC/T82aSpp5t9QZ3iFiBSK2/U3jG4jyQz1nGYa
         67JLqVhLQnZzMGwy8XAp/WdUNYB3j6k99fPM/xIV6afueyb8tNT2CCkIvwcfHTWgxFFm
         o7uKYGcW0m80bUMVEI4IjG1X9KtFjQTWKeXkx5rPrVP73kWnztWULisbogNe401EJ4Iz
         1p7C1UuLpGrd8vTNZfDv9a73eSrwi3h3DKXjXsI6wGrAWE6hK5/Z+0xrndh9bOV0R4KD
         TlEA==
X-Forwarded-Encrypted: i=1; AFNElJ/CNRfY7xCP4Qjjw6dxAM6xDqkUtLlNkfp41eO30nKBwntVuqFJt/jN859L8COUNO1FFJlyyAzm0tC/@lists.infradead.org
X-Gm-Message-State: AOJu0YwQpCspVoMp4HrWEkb78ayHP84cHd+vRKa1EMU3PqUZFerU5IOa
	2ieFd1wHXFSLxPhpC2HonkRHvyeW2BzIXrh5nhuSyBPUBvHLhSrJ8Kcp
X-Gm-Gg: Acq92OFZ7qU7bJAdqTSxge6jhxrVmO/zZ+8r65hnYmwlMUxqq/OJNnbrbmNf7030l9o
	eH+KX6WYJkoFeHW4MR8nyfbMxwoHuV9c926d+c/4+xAq93PWy3Hjf/jt+YURpPbLSi0e4degJTL
	nEnFfTMyNapETo+WbsanoXJFbMoFSTltoSgxk7OEJ0w+qA9V/eMRScUXXhHRdi6k8lBRqdI5Pl0
	Epwc5EQYaiJHjHrytMHHv4mndESB93Ip1nSxuvzQHoHEeaIssq+QxhFkmboWRp34oka1o8OOpSE
	6iS0xIaJG/ucGDklnd/zk7CKxtEgdM6Ggkc76tVgix4yOi5yLYuRc6wv60NTpbj8jTqEJk8gXe6
	FMdm86dJ38lkJifvVCtkSHsskLJeoaxvIpm5mZ9Xb9XfEzDEAI02cyvU7emeLVvBYgWdo5zL1KG
	tdtH7v9yHEhY/AYoWUdPc=
X-Received: by 2002:a05:600c:4755:b0:48a:58ae:992f with SMTP id 5b1f17b1804b1-48e51f2e8cfmr338231335e9.16.1778446400368;
        Sun, 10 May 2026 13:53:20 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm24719725f8f.37.2026.05.10.13.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 13:53:19 -0700 (PDT)
Message-ID: <ec1d5711-7541-400e-9527-7d1428548e1b@grimberg.me>
Date: Sun, 10 May 2026 23:53:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>, Chao Shi <coshi036@gmail.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, linux-kernel@vger.kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
 Weidong Zhu <weizhu@fiu.edu>
References: <20260428022911.1288485-1-coshi036@gmail.com>
 <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
 <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu>
 <afBgs0f8Et3jqijM@kbusch-mbp.client.m3-hotspots.de>
 <20260508090427.GA20593@lst.de> <af2thHcqZ28pDF2w@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <af2thHcqZ28pDF2w@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_135323_339788_01FB2D66 
X-CRM114-Status: GOOD (  17.72  )
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



On 08/05/2026 12:31, Keith Busch wrote:
> On Fri, May 08, 2026 at 11:04:27AM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 28, 2026 at 08:24:35AM +0100, Keith Busch wrote:
>>>> This field specifies the timeout value for the Keep Alive feature in
>>>> milliseconds.  [...]
>>>> The default value for this field is 0h for NVMe transports that do not require use of the Keep Alive
>>>> feature (e.g., NVMe over PCIe). For NVMe transports that require use of the Keep Alive feature
>>>> (e.g., RDMA and TCP), the default value for this field is 1D4C0h "
>>>>
>>>> To me, it sounds like for nvme-pci, keep alive isn't required, but could
>>>> be activated.
>>> The spec says the support is subject to the Transport binding
>>> specification, which does not exist in the PCIe transport spec.
>> My memories from the fabrics working group back in the day is that we
>> explicitly intended to support it in PCIe.  The wording in the spec
>> referring to transport specs I can find is:
>>
>> The NVMe Transport binding specification for the associated NVMe Transport
>> defines:
>>
>>   o the minimum Keep Alive Timeout value, if any;
>>   o the maximum Keep Alive Timeout value, if any; and
>>   o if the Keep Alive Timer feature is required to be supported and enabled.
>>
>> which does not read to me like there is any required language in the
>> transport spec to require keep alive.
> So the absence of defining a minimum means it's simply optional? I
> suppose I can see it that way as the intended interpretation, but seems
> counter productive to do on PCIe when you can MMIO the controller status
> register to verify liveness. If the controller responds successfully to
> the feature, then I have to agree we need the host to do its part.

Perhaps under a quirk? Would be interesting to understand which
pci devices support this...

