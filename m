Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D75C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=46pUEY897g9yCdjF8arNRL+NL/
	mLpeotwlxhKe4REgihuLlGnROUUJcZ5TIY+3fD5Nt5ZC7IZiQACEbXAXdKf7GJ+vd9EKs8Iiwk9am
	OQd1xwvUHXHnXkUHrjL0yv4zbS8UEHdBGP0ksrrYSSggGwDCRzChmGTMMS+wnvYTqoz0Zh95A9stt
	/SX1j70k1yVnNI0FhckQYygeZ5UWstE3kRpXuCn51XO54AiGYX69WoE1vWxW57EhDEww2fpw9Fgik
	MjaFh6mvDVFsGd5Ce7tadUMNPDR1I4+HowRPcmGVm/O+/7doEHNF8MVnTgxp3xoISk6dU3mZg615V
	B5H5lXbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYLS-00GjRr-7p; Wed, 28 Sep 2022 14:47:30 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYLP-00GjOH-8O
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 14:47:28 +0000
Received: by mail-wm1-f42.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so1145417wms.3
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 07:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NreXukJz6GcERftfPlxJMTYjLRsmF6lT1m2x8J0+YCx1U44ReNXFITxdR6IrUZJS3q
         SWS+CLnv9bCJFPdm7UTixnmXqf9tXTJkUr+7isGiM7/h6f0ZICWUy1YrZ1jqXUKJqrlR
         7XPWiDZBF4NViHa+jX7gcBZ9d2odUYjJsyBmAm/2y3UMc8szYiUpZbEeq6uUGnwxzO2V
         aAtgqQWxsAWvKkPNkrxosACE7edEWneuewlC99sLdDwCPTtZ1V/F7MGvfm9gnHZsiKFl
         ZbK1NWbPdok9IOGCAUIgCg0kVjItN6mlnZY6cJWhXacNz6ETTEjcmD/9Qm2TIOFOzccn
         CjyQ==
X-Gm-Message-State: ACrzQf29AtZ5dPQcpncs2fUG4cIkmhodP+c2BDua2Wuf6ep3c+e7ibzm
	+hcu9hY1g0XQMcNWJH1/rZS2wSRJNbU=
X-Google-Smtp-Source: AMsMyM55+YmNsrKezLlhI5j71+PHFUAYKdM7/F043aKabt3sPZ1Gpwqb7PmV4sFgWNm2Gr1rpy1HIg==
X-Received: by 2002:a05:600c:348e:b0:3b4:a9f1:c240 with SMTP id a14-20020a05600c348e00b003b4a9f1c240mr7194314wmq.192.1664376446886;
        Wed, 28 Sep 2022 07:47:26 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4b04000000b0022c96d3b6f2sm5710388wrq.54.2022.09.28.07.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:47:26 -0700 (PDT)
Message-ID: <4f32387d-b162-e901-a681-387d24d62c96@grimberg.me>
Date: Wed, 28 Sep 2022 17:47:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] nvme: enable batched completions of passthrough IO
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stefan Roesch <shr@fb.com>
References: <20220927014420.71141-1-axboe@kernel.dk>
 <20220927014420.71141-6-axboe@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220927014420.71141-6-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_074727_325293_6436012E 
X-CRM114-Status: UNSURE (   6.22  )
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

