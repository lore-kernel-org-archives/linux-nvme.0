Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB0BECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dUT6fA9d8r820XadYjeIsKVsw5zT8dmP/mI6xQ6wTNo=; b=ixu92rpmAyT/0o/uA8asKBZOqc
	Jh94YS88awmSIna00Y8JsINXn9NipirmJd0BO553kgfItIgVTKevk7Xs6B6VFu0fqQd7G6Z9P7PzY
	UFCSy5enCPZZekDmTc26LTuU7W1mdDtBba4d9WzEJe78KxcfTl1Tev8s2cKYBvylGOAXNOjLXE4+Y
	Up/DkgE9tyskKtXGM2AwML1laL0jGcAB7arCLNBwQsP5DTpXBG5oEyNoaQ9hU4DaZWEsHmPdBbfX7
	QLkNjTL94CAw555moslj229QYnrE44N/U2vyd8Yk1neZgoiDM2847oGaEXl0cxpTTHoTlrfnZP56I
	WoTHrEDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaiy-006WTA-P8; Mon, 29 Aug 2022 09:06:29 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaip-006WM6-W0
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:06:23 +0000
Received: by mail-wr1-f54.google.com with SMTP id b5so9314742wrr.5
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 02:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dUT6fA9d8r820XadYjeIsKVsw5zT8dmP/mI6xQ6wTNo=;
        b=nPave39CnQOy56jR/yoehFMHdQUT/xm39HrE8d8LmJDUM7qyqz+tB+6t23cp/LzdyJ
         o+Xud7FyDBq+QdEaVV5mzwPSKbn2vEs0AvwB9lXU1R/Ezip21+eHa+n4OErhX2uYKZOj
         rw/BM0lTBCIIUnNtOPCXjlr4pZYdF5Ru255LoG4vjU6QRRWANl1ZSUH8CV/FJo8YPtOh
         ioXGTh/ThvMXfixPzSeVAOtbFG2t2ZhBRHJoMmY0XYC2nswk7UIT+xdLuX1NH7me3LCg
         Vow0PRlBJDIDBkEradgFHKLb1dbMDeMpHOkj+hEXSwZUyvn6bGiC94DiC4vzSKOyNzGQ
         dNMQ==
X-Gm-Message-State: ACgBeo2hP1cOWkr7UXbxnSpdLSQcVDiu0Jp0TZe2g+b+D2faKRrXan/W
	iQ4NuTTpgVDIkvCn2rQXCr4=
X-Google-Smtp-Source: AA6agR7iApFvdlU2T/4MzdkD9sp0Y5WMdA7CfNnyj94odG0IknFW271OkgTQw1WRGnBOjuZyyw0b3g==
X-Received: by 2002:a5d:6484:0:b0:226:dd0e:b09c with SMTP id o4-20020a5d6484000000b00226dd0eb09cmr1278618wri.388.1661763977162;
        Mon, 29 Aug 2022 02:06:17 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g13-20020adfe40d000000b002252751629dsm6393794wrm.24.2022.08.29.02.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:06:16 -0700 (PDT)
Message-ID: <3030fbb2-5c63-54ea-5be3-b88cf63c6b75@grimberg.me>
Date: Mon, 29 Aug 2022 12:06:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
 <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
 <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
 <fbee7c67-fd7b-12c8-5685-066b1974aadb@grimberg.me>
 <550d4612-0041-3d84-b1cb-786d0c8e0d11@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <550d4612-0041-3d84-b1cb-786d0c8e0d11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020621_093395_DF86AA79 
X-CRM114-Status: GOOD (  14.88  )
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


>>>> If so, which devices did you use ?
>>> The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
>>> The switch and storage are huawei equipments.
>>> In principle, switches and storage devices from other vendors
>>> have the same problem.
>>> If you think it is necessary, we can test the other vendor switchs
>>> and linux target.
>>
>> Why is the 2s default chosen, what is the downside for a 250ms seconds 
>> ack timeout? and why is nvme-rdma different than all other kernel rdma
> The downside is redundant retransmit if the packets delay more than
> 250ms in the networks and finally reaches the receiver.
> Only in extreme scenarios, the packet delay may exceed 250 ms.

Sounds like the default needs to be changed if it only addresses the
extreme scenarios...

>> consumers that it needs to set this explicitly?
> The real-time transaction services are sensitive to the delay.
> nvme-rdma will be used in real-time transactions.
> The real-time transaction services do not allow that the packets
> delay more than 250ms in the networks.
> So we need to set the ack timeout to 262ms.

While I don't disagree with the change itself, I do disagree why this
needs to be driven by nvme-rdma locally. If all kernel rdma consumers
need this (and if not, I'd like to understand why), this needs to be set 
in the rdma core.

