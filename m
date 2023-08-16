Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B37C001E0
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95HPwFgqaDXlLLkzpChDZIHs2R0I1EBhpERpAxW/ijY=; b=yNJXURmKxcEKdsxX+oH+H0vu7v
	5heJ0cIJ4CA9pcK9vEKF/h5vr7n5mfNXJ8KhOoRZjpypcSMy/Mp1SvJFChz0fFkaAL1IM4qsbvsAl
	wu+GnDTOiVmLCCAJk1uFZxh+/6/vIbGvPPlQyJ+/u16+ks9rdG5IGu6FXk7yD7xgxIUP5OSZ7rqx6
	z9jWznEzTi9EeOwgBVn/6HhX9ymcwaTofTREv1yF7rQ6WteFGoMmUU5DTj0JUD7kcaclKgW+0Ier8
	CKemGlw5J8oMoPXnPZTnoH3XLWxQvTzCUKvIliJKrsKieb5/ZZIe7VrSLjLNTqRhCd1COwzHC2eA/
	ZBqseVSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWHEZ-004KoM-2T;
	Wed, 16 Aug 2023 14:10:51 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWHEV-004KnM-07
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 14:10:48 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3197b9cb84eso493493f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 16 Aug 2023 07:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195044; x=1692799844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95HPwFgqaDXlLLkzpChDZIHs2R0I1EBhpERpAxW/ijY=;
        b=VvZmeRqKv+LrcQojYMDH6/bWXeiaiYsYZOLP3PBHviUjO+nTY+NVR+QdHyxn4rzntS
         fAI5rlftieTVes6UTOsOu3mTDzqvMrzRZpi6bem/TpH2ZqdHg8q4CQWN+5eoZYt1gA+Y
         KBfS6bl11hyr+oYQMv6cNFysxXTqTfiTBpwXsrLIqqzYVSb5O+Ib4ium1vVKLSDXw+f1
         RnaGQrXKaj/tXrXy6uyQbL4Ld603kTvW2g1B/NpYfkcwK0/APV+oZ0CNVdbjcFIeIItw
         10C3n8qsbLXO2XgwzyzrXmFSy8iBG2SVlTwYFJmbI++0QRnuUSr6BuJevLnP88BSD0zD
         Rvbg==
X-Gm-Message-State: AOJu0YzIvdxLjvQSJkzPxolDfPs5lUfUESD1+Qi80Fr1mpKaL9JIf41b
	t9V9Vd7tic4l27RMtrPMakc=
X-Google-Smtp-Source: AGHT+IFAdE+gPg7IcxZmulI51PLKclkD6DyWh+geDi49pMSfDRXQdy9EFgoumun16fMKn/34l3Q+WQ==
X-Received: by 2002:adf:f0c9:0:b0:316:ef5f:7d8f with SMTP id x9-20020adff0c9000000b00316ef5f7d8fmr1652244wro.3.1692195043533;
        Wed, 16 Aug 2023 07:10:43 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q10-20020adfcd8a000000b0031753073abcsm21417662wrj.36.2023.08.16.07.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 07:10:42 -0700 (PDT)
Message-ID: <186675e2-464f-bec4-1a26-5a516ef11540@grimberg.me>
Date: Wed, 16 Aug 2023 17:10:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-11-aaptel@nvidia.com>
 <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
 <253pm3nuojy.fsf@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253pm3nuojy.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_071047_073030_3CF05064 
X-CRM114-Status: GOOD (  11.09  )
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


>>> +     switch (event) {
>>> +     case NETDEV_GOING_DOWN:
>>> +             mutex_lock(&nvme_tcp_ctrl_mutex);
>>> +             list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
>>> +                     if (ndev == ctrl->offloading_netdev)
>>> +                             nvme_tcp_error_recovery(&ctrl->ctrl);
>>> +             }
>>> +             mutex_unlock(&nvme_tcp_ctrl_mutex);
>>> +             flush_workqueue(nvme_reset_wq);
>>
>> In what context is this called? because every time we flush a workqueue,
>> lockdep finds another reason to complain about something...
> 
> Thanks for highlighting this, we re-checked it and we found that we are
> covered by nvme_tcp_error_recovery(), we can remove the
> flush_workqueue() call above.

Don't you need to flush at least err_work? How do you know that it
completed and put all the references?

