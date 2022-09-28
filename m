Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD38C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0aB3XUBF0iiCz0L2LgrIOU8xDBRONC/EC1wEU9japc=; b=A21YBL7uXZuRskg23eKHT5CQ1x
	NHEvLaH+VxRqRNMZZSbP2sGv4FS4rYlgC/5IzXbrLzWpVIN0lVr0UqfJDvUaHBElAeZ2QqaeXOQxo
	b50qg07fk7ehmFUcc0DxrvxPl547Bicbfq5MQiH9e6huF0MJAa+B4sFodWo7VugpO99HaEO97X5D/
	Ikt5qHDBgo5ifqPxaE+Brycb5rz331ByJY8gartAQs1GjHhE9VEaQpBkVIfnOuLRqo+1pqJga61L6
	cpP1Oj5Hym3gxfRdeKqP77KKsFSjbCurTfZjsQnelUSNXyPbI6+tN0GarcHWk8V5EAsugK1ybot2f
	B4mGi/+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQqa-00EJSi-42; Wed, 28 Sep 2022 06:47:08 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQqX-00EJQv-Uw
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:47:07 +0000
Received: by mail-wr1-f51.google.com with SMTP id m4so3878913wrr.5
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n0aB3XUBF0iiCz0L2LgrIOU8xDBRONC/EC1wEU9japc=;
        b=dElDqy8ADvFh/ASewDQ6EdEYj4OkmqX205XO2WAb8hahp52pf8tgXSsmFtCwFBII66
         3ZObSRmhNbD73F8vEBYbnT/0v2ZwHMYFqxuQYS6zUcrvfjbZvGE2lU61mBCF7c++Bz1T
         sKTbuipU/TC+5wTikSG0IWGX2QmlULhYCikiN/GhXrdTxiyLdcM7rCxoKSmS1+PBBdsY
         BnM+nBaQGcYAYQRJocfetkXN1fIfXQ+j71Xmu4XLx5XIiaatnUnA17ZVos396YCF7COD
         VYcKaN2mcWegcJ8CFlttJSVxvCBwyEUq8uLSBIeUrB/UcCQ/sfPAxGWTgz5+qmkgmfDp
         +Jew==
X-Gm-Message-State: ACrzQf1uKYyr9Bxa95ibs0yrmALeXpjWpU8F4348rvc6eo7CqkhlVXBU
	D1gIuR5i40MJyTXTUExsbDk=
X-Google-Smtp-Source: AMsMyM6z7prP3/QbAX4yYsqvDTD6kWquxape0FbmuNLRbADDOdx7jIz33W/TLzAHZQrHMyTxG/dYhA==
X-Received: by 2002:a5d:5846:0:b0:22a:f7d2:9045 with SMTP id i6-20020a5d5846000000b0022af7d29045mr20200004wrf.250.1664347623393;
        Tue, 27 Sep 2022 23:47:03 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f20-20020a1cc914000000b003b492338f45sm799581wmb.39.2022.09.27.23.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:47:02 -0700 (PDT)
Message-ID: <82f96fe7-a140-08d5-0109-c35ff2ea2d62@grimberg.me>
Date: Wed, 28 Sep 2022 09:47:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: consolidate tagset / misc request_queue allocation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220927072708.GA16710@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220927072708.GA16710@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_234706_022192_D4D60FC1 
X-CRM114-Status: UNSURE (   8.07  )
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


> I've pulled this series into nvme-6.1 with the additional F_FABRICS
> check pointed out by Sagi.

You can add my:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

