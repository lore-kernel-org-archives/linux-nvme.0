Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CAEC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7dIs3wIU/eOuY42tjUqQIb5hvTxPnOyZmdhm58qw250=; b=o/2OV8uDGsoeZ2r7OWE/URpoVY
	Y49g7HNOe7ltyKQhV4xmzlGYcZPdwYH/bsLzlyBIkxPr9xWlhmaw1kpj8I3/8aFBPbY0Vt8bkV11W
	hSardhFK6xoHqW6J6W0l9lYNYjTvNI1FpSM5ECzD/t+UYZabPrOlcpLPdpG7UT0+YfhOVXv9pL32m
	bfyWQ+e9h0p+hc+oB+GIzP0nOuCAQhf/JzY2K5ecnuCDp6Jc7xnWX1zAVBfcq4z/7HsTQFrft/0gx
	9CFfpTDOG7xplp+XMpjjtnOVCxvjekKBj6AJKwb4y4YmdU8aItW9S2bX96DaH/ol73qUImHJCVSuC
	uzqu4r1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWKGu-005hpV-VV; Thu, 08 Sep 2022 16:20:57 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWKGr-005hn3-IX
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 16:20:55 +0000
Received: by mail-io1-xd29.google.com with SMTP id p126so995772iod.4
        for <linux-nvme@lists.infradead.org>; Thu, 08 Sep 2022 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7dIs3wIU/eOuY42tjUqQIb5hvTxPnOyZmdhm58qw250=;
        b=g+GRDZEFcMsYo9rekqdIoa5Hg2iXa3uKfZ46Kt+XF33CAkT5r2PuNlezw6p7CqOkRJ
         ZTzhch5ZNm2rCTZ//ncC0HGQjZH+z4M9RE3ouRfslW3H/boUfvJjXWL2bok/ySkIqn+y
         lkKrbLWSUCuXZtKTy0jWIKcU28JZRDDtWckN1msYo3e/WWZ4W3b2RdHYB14Z4aGMaMbR
         sqr09sIBnlUQRR1wWiPp1FwvqVY4zFWiHaUgyMQbubzILOJqviZw3xDrqFhsOwjkOauv
         wBR+1Yw3bSzkUEMwA6p/HuwYNEMzHU2qvnoWs9oKVOvX5Xy5i28WQkBOHo3VKtRFU1Dx
         mCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7dIs3wIU/eOuY42tjUqQIb5hvTxPnOyZmdhm58qw250=;
        b=bqSt27fctRPhJQdw0zDHhSxgd9KeUNcjwxKZ67JadvQfaSJo5/ZvK8b8JsveKP5jvK
         JBq5bTCfPacFj7Ex/L5xJY+rjkyK88SoRT40ELw8uKkoZ8UQwzh2Kgi0OFPWcioNT9vD
         /4mzr0VPzxheIwhprteW9fB5n0LnsDFRv/C5GAYYNXTsaYIGBfeLT36IC4170RpH/yd+
         HxYhg6Ljc8SD5Yau9JXY0UqQvXYIPzhtO2JQwbYatKI5XiyigJRoev58EAfOklDSLNLR
         cmMq5i67rdztLEXzeVaUQfxjC6pRMjMJePNGb24w/DKq68hdICAXEtU+tJsWSYF8QG08
         beoQ==
X-Gm-Message-State: ACgBeo0aG8G0HVkmXFS1nfIY/Efy/4GXPBi1U74WEwZtsygtVoYZkbDu
	svcUc0r44tncrcq4wh7fzmb41I67wSnY2w==
X-Google-Smtp-Source: AA6agR7VJ8j0hKXexix+zZNZGjqFwxTKwdptIZ3mwCSF5QurOjI2nsEuLfEZ2lkPEf15lqjmVu4xMg==
X-Received: by 2002:a05:6638:3e0a:b0:34c:ff3:57ff with SMTP id co10-20020a0566383e0a00b0034c0ff357ffmr5342528jab.105.1662654051747;
        Thu, 08 Sep 2022 09:20:51 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d91-20020a0285e4000000b003584d00a0b9sm205077jai.20.2022.09.08.09.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:20:51 -0700 (PDT)
Message-ID: <a2db93db-4cca-5a72-62c9-75f76f19221d@kernel.dk>
Date: Thu, 8 Sep 2022 10:20:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.0
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YxoLsUEjritZcoK9@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YxoLsUEjritZcoK9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_092053_870936_4B9EC2B4 
X-CRM114-Status: UNSURE (   9.89  )
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

On 9/8/22 9:35 AM, Christoph Hellwig wrote:
> The following changes since commit 748008e1da926a814cc0a054c81ca614408b1b0c:
> 
>   block: don't add partitions if GD_SUPPRESS_PART_SCAN is set (2022-09-03 11:29:03 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-08

Pulled, thanks.

-- 
Jens Axboe



