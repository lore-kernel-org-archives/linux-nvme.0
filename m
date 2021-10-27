Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C63C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 07:11:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C95B6103B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 07:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C95B6103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctsmAdxfendUTB+Ri/vefO7AiZmxEcOs6UicWUl5I98=; b=hA4FnPRshLrBqLx70whi57J4Ta
	so4SJQXSJSwny9Ah2mi3X6t6IdDxySCF5MFjX2A/PaVCArVfxo9AmVxywGLsO4CEyKTip8+GzDPIZ
	QNgFfLCEYqB0xaCrB3wZTgZT+rBPGeMoaz8Gw3SsQYaZIr45BMd6Y7aqWfxrycbxijEH3nd401jm9
	FwLGPiSMXPznZT1Z0q8OlUFvQWWbuwlK7mqCASIufS5hDraWKyI1uJDWLeXk9nVdHnupB6jrO8t4a
	glMqw8YUMSzDEtn5Ps1GeXaa5RF4uI5UZTeoQ6Pw1X1PYBrt1N9tCaGjsoyVBzYNc1SnaEpMI6b26
	lGRclGhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfd5W-00475m-KR; Wed, 27 Oct 2021 07:11:06 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfd5T-00475N-Vw
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 07:11:05 +0000
Received: by mail-wr1-f45.google.com with SMTP id p14so2311929wrd.10
 for <linux-nvme@lists.infradead.org>; Wed, 27 Oct 2021 00:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ctsmAdxfendUTB+Ri/vefO7AiZmxEcOs6UicWUl5I98=;
 b=HlhRd+r05bB49mpKiIE4b1tzz6ONGIkfEPOiPf3sL2l4QmYQe10ZV/CoF9UmO1NVab
 LnHClbBLXEwJTDGfbF0komEvP2vpWYaQLQ4Oqc/wll7qrlWLejaV0Dh8uPEwB86B9jMr
 Vlt1ykIMijz1Lz62ZAzUS8Yk2vidXTBDREUPdlgAYrg9GDABemviRlaKZRQNpt7VrXbp
 tO0vbpVeFM4isECFIy4der9iU5tLBcR/zXrJ8d2KdnRz7eJYDGnvBjEEcqq2+heKI8mj
 JFZYSf05F0vj+XgUe5NbCtEINO1vrOBklRMyTNAEmIY09kATNDs2vZuWH+lE46EYxX6Q
 j6fg==
X-Gm-Message-State: AOAM531DGQbwUgr0NHNUaCp3v+DJ26PfRcBpKJrarzDwfPFUb3edVlmy
 HCuHF/tFuDIEhxG8FN73V+XEblt8noM=
X-Google-Smtp-Source: ABdhPJx6A7XF9SmIQxa1DYpSCTcGUIz/LewH3219jCXJi8Ft0xLbX/KyeOTetgPulFtRe+R2KE5l/g==
X-Received: by 2002:a5d:5287:: with SMTP id c7mr39616340wrv.236.1635318662447; 
 Wed, 27 Oct 2021 00:11:02 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o10sm2568935wmr.31.2021.10.27.00.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 00:11:02 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
To: Christoph Hellwig <hch@lst.de>, Varun Prakash <varun@chelsio.com>
Cc: linux-nvme@lists.infradead.org
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
 <20211027055725.GA9635@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
Date: Wed, 27 Oct 2021 10:11:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027055725.GA9635@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_001104_065987_94ED81F6 
X-CRM114-Status: GOOD (  17.95  )
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


>> exp_ddgst is of type __le32, &cmd->exp_ddgst + cmd->offset
>> increases &cmd->exp_ddgst by 4 * cmd->offset, fix this by
>> type casting &cmd->exp_ddgst to u8 *.
>>
>> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
>> Signed-off-by: Varun Prakash <varun@chelsio.com>
>> ---
>>   drivers/nvme/target/tcp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 07ee347..d641bfa 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>>   	struct nvmet_tcp_queue *queue = cmd->queue;
>>   	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>>   	struct kvec iov = {
>> -		.iov_base = &cmd->exp_ddgst + cmd->offset,
>> +		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,
> 
> Wouldn't be the better fix to divide cmd->offset by 4 instead of the
> casts?  I can fix this up inline if that is ok.

Don't really mind, what makes it a better fix?

