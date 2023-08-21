Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E477DEE4996
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 07:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Z1Np6DQKQzUfvzJNDyKSyeshZG
	KirscXkj83BljXWXP8i+jIcEoP1J8vKn/65lM5mKdfcRb/FV/ktA81UUEtMr5xP1PHkjbAt/gxiyR
	XG6fj+crOqpTgVc67KuqVa1ilHTvWbCrkFGI9Cm2oSIRZQYGeg+Ndr4veQ66scfUPt+MpZUi6hGU1
	m9lpDN4RpJh7kz/Tqs+iNfAeFONU0QCBjtchuBGRli+V4pjGe1Ho7EGdmB2UU1wBZrN8j+kNr3yhw
	LBbR/Ua/UUQ6VvMnM/YGwhzQH07riePiI6SwViCBtlMVLuWHAhzURiP9JzcwuCLrBYzZtcgCJoycE
	ipFUjonw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXzYO-00DNVv-1Y;
	Mon, 21 Aug 2023 07:42:24 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXzYL-00DNVF-2Z
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 07:42:22 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3177675d6dfso466263f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Aug 2023 00:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603736; x=1693208536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AL+PxjjNP7Vs9FTADrPtBpYKr3Qha0NYz2RFfXDLX7tTOrR7kA+VUMUyP8UPJ9Pv11
         5LEdhDhXnb8mcAgUFyCsK2NVn9y1/zBpFFXS4/oFofd5FwPWzQPc1WJvobhPRQGoy8+c
         T29SH4iqUy0DFoszMLWLSTfhH/x/HYfCCWW2GwK8x44jskaZOOKVutU+TyEfo9kVDjwF
         aIYOc0kIFbExO/FXe0KsLdBR8f7DQFE5YtKf1CQBRzKiAuiCPqan1Si/QamBbfTD7i3k
         7Q2+Ju/hxgA4lwIFPK1C6lU5y477g1obKg8/de8ZnkAb7IvTADCgzZXU279u5cOQ9HH8
         pnLQ==
X-Gm-Message-State: AOJu0YwP5YAoWhvLyLbNXBRdRWXZM8IGRCOmt60k3pw96B73BGBPtJxX
	z4x79+AgByjKcx+FmAN7uwk=
X-Google-Smtp-Source: AGHT+IGs9G7ZbbGap2oNvrpZ1r4yLWv8R60En7f82Pqh6R0VxUXFXdjG5AT0T1bhvBv5heT45Nhniw==
X-Received: by 2002:a5d:60d2:0:b0:317:630d:1e8e with SMTP id x18-20020a5d60d2000000b00317630d1e8emr3536728wrt.2.1692603736380;
        Mon, 21 Aug 2023 00:42:16 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b003140f47224csm11484332wri.15.2023.08.21.00.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:42:15 -0700 (PDT)
Message-ID: <c4a23989-d349-b7ac-38ee-bf7365947e8e@grimberg.me>
Date: Mon, 21 Aug 2023 10:42:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme-rdma: do not try to stop unallocated queues
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org
References: <20230731103758.117533-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230731103758.117533-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230821_004221_841164_73DFD7C3 
X-CRM114-Status: UNSURE (   6.35  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

