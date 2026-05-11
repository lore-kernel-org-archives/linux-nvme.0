Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2DBCD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zv67Mso1pJu4W5W8lh+HDUmbeTPdePxYHh0WczxPFn4=; b=HVYCIwM9ukcGXWsBrLNtkOUlbm
	micx1iMRzQ9sfnkeyjOqhunakTIcKjA2qGkAv7/WzB13q57zl2FsKJOhxSVgFReK+y6kapwjtTLx8
	De3tsXRwkA5Iz76USnz49eL54sufkm+O+SfXBlgp9fUoKuLe6YbV/wzIBciKW6y6l4Sm8CXU4KEX3
	WAIssgV9zqPBzC9rGteDB2ydBDZVkFP0D8AL+0EBbnNx+tDC1cysDYHZDwhFVG8bJXCn74dmVs5JD
	eY3mYu1nH8upnJZdqfHwD2WlDpbTBymkrchN6gWR/KxEJoOh811rWKjibMxjC5ndjgBnLz9KK8n3x
	gNWMMc/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLa4-0000000Cgb6-35Ra;
	Mon, 11 May 2026 08:01:36 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLZs-0000000CgZZ-3uLo
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:01:26 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b93698bb57aso700243566b.0
        for <linux-nvme@lists.infradead.org>; Mon, 11 May 2026 01:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486483; x=1779091283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zv67Mso1pJu4W5W8lh+HDUmbeTPdePxYHh0WczxPFn4=;
        b=lkGNrD53zRDlO6Fii4Um/E639Tr2lOS1ti81i92UmFgSg9aqE311saCrLeqob9kluu
         DN96YOmwFu48YfApZTX7+CO0wsluwEBlwkR0NOboeamkITfyh7AcCmqE5hBrl1S9h+o5
         92cEE4Ar4PfiqMWzz/kUNpaMms/g7RTLs/fMzAWsNf6lw0JR6I/Aunqx/BqdM5ZVjEVq
         0LVx282VrnCsQ0bp6smafJpaiokopLCEws0xq8J3EVIj/6xe5ovRLBTnW5VrLuQulGlA
         Bjg4QgH2iZaAKJgdB3S6NLOgjJlzQbD7iNIfzDGDDZUWV5p4Npt0UTj/SNstBoxc9C3u
         ZEeg==
X-Forwarded-Encrypted: i=1; AFNElJ8RWuB2/yVdrStvQGJOffKkdcZsZzka5QpywaJupCMmOUy0o3WYIN3vVJxVRG38LFp9iRPn8GED8QGh@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1iAW0uHkua1wHmKJ4kl4plki9ZzEM+vlL7r2uWlBnb1hHn5VI
	l7rBQIPs+q3kA0GaO98kgwrJZFfS6rAnSNqHz19Y8vAeMFVbrDjUt6VE
X-Gm-Gg: Acq92OHQAjacetXZopbX6UJvsqyHuJSOE4CaDw8vuPMnx3HcwH/eGnkn9eY9s0DpE0K
	u5RiSE5rb+JDax0KXfWTcrcAbCbLjrwpYW3gz9ugq5pb8Qij4CKVFAvn8CmXdCzN1HFmELXSEI5
	o0RdQCknpkd1jB+vCwZ1XRZfkCK314Fe85opA2sNhG4XD5fb+bWa9KtBz0TjwgYYIo+d3UgbCTZ
	9ZA5RTGrBJNZEK2kWcxCMC4upYBYAdTNS8y+gviJzsuT6QaSuBOOAOkzk1RJO7OBoBAigev1lR2
	dpCeg6ut9PnznBmXDflzpYY/cCZCaXDHKZLs7aed+ZQjJSE2TWGE45CQUCJ5XmTX0gTIhPE+HWe
	ecFbEO9inMGapR+924e7wBcFJngGntlcylGv3XbnTQZG+2b+yRrfE5bG2Z4nRhrkqgyvKgXlE/t
	yOjq5BlDju8qwDgW3dkY7bkTt/ZDHkxbKKWelYVMoxJTylE3X+CyZ4dF+eymi/Eb85iV75ri+W1
	Ow=
X-Received: by 2002:a17:907:c247:b0:bc9:c7b9:9fd3 with SMTP id a640c23a62f3a-bc9c7b9a8c6mr762065266b.11.1778486481306;
        Mon, 11 May 2026 01:01:21 -0700 (PDT)
Received: from [10.50.4.100] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac3989fbesm450197666b.33.2026.05.11.01.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 01:01:20 -0700 (PDT)
Message-ID: <cadabbaa-0958-4bfe-9a62-e3f84c146bb6@grimberg.me>
Date: Mon, 11 May 2026 11:01:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet-tcp: set and enforce a default MDTS for TCP
 transport
To: Christoph Hellwig <hch@lst.de>
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>, mlombard@arkamax.eu,
 kch@nvidia.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 gregkh@linuxfoundation.org, security@kernel.org
References: <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu>
 <20260508203912.320938-1-kumar.shivam43666@gmail.com>
 <d06002f7-2da6-44bd-a0df-d9f2ef87a66c@grimberg.me>
 <20260511063603.GB26080@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260511063603.GB26080@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_010125_606811_CEB655E1 
X-CRM114-Status: GOOD (  11.59  )
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



On 11/05/2026 9:36, Christoph Hellwig wrote:
> On Sun, May 10, 2026 at 11:42:48PM +0300, Sagi Grimberg wrote:
>> I think what we want is to limit the tcp to a sane limit similar to the
>> nvmet-rdma driver.
> Agreed.
>
> We might still need the early enforcement in Shivam's patch, though.
>

Agreed, I think that rdma is susceptible here as well (perhaps also fc?).

Perhaps we can have a helper for nvmet_check_mdts() that would accept
the request after req->transfer_len was initialized.

