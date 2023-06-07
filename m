Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB30DC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=0nzucR0v1iJcC5lVBLq6UspOXP
	745rH+yV4lBoj9xwvQUGINPzebYnFpDVzWOAGu+JL1XUghZPDUyayRKedHq92YbtsQGQEP+M035eF
	DbE/8xD851rnHYurRh2AbnsCm1Yo+5G+fXzJJMaM5nKkNMDTjNrB1DlV22lebgRlvr1crlHrWGPsK
	uLmVDu+cpo3ScPLtADuMo/m+38Ab1z/OlS4UbsELRl8o6MaXcFMcknKFXHbZlNwkokr662sE52nYG
	Tlu4jvIRIVAdllcGBI0ECevxAHdRL87h7at+LqmmRd/VdhjF8EvRkwY2MNptR8PwW29FEk4gjVAn6
	kJskpdLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ums-006Miz-2j;
	Wed, 07 Jun 2023 15:09:26 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ump-006MgK-10
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 15:09:24 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f7364c2ed8so9081755e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jun 2023 08:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150559; x=1688742559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WEqfXtNeKNSDsq6MB324grWI6sKwSVjSqJKFc2lhELHSwkIPAMtoLUEC+UmqFzCKai
         FpJMP1pQ+/TrN6CgSToFgQvphH0D0h9cgkqQ/ggee1xVJeh6P/YBO7XNuyO8k4N1SaYO
         b5FqQ3V2cTsKrIhNWlqM0qYtEddF/8J43WfcdtBNDrGNS09dfTEg6DLtQ2FFDaYYG+Zq
         qyanTFmwPzIjMfmYmQUAnLURfa9IZESNZo+E4l0VBEC7qf+kyvXlRg819etnrdODIxwB
         POAgIFFIuC39oA9hN98sJPZndKTZFfoBRCtu5xAWSk3nixMWlkSqFTNMLzVEoZSgJoeZ
         Ax5Q==
X-Gm-Message-State: AC+VfDwMnwlN7nagHX1W5k2/vlOEmJaQDv0RgIsCAcF1GwF/3C0hB7YU
	v87B5vj/eahCYc9F7vxV/CE=
X-Google-Smtp-Source: ACHHUZ5/26BTbJMRoP8XTsZlcyMHQa/LbgWoM3h1E/Xrk8NzT0bt7lrE4blBBatA5XZZ3SEl7N51ig==
X-Received: by 2002:a05:600c:3d94:b0:3f7:3579:2843 with SMTP id bi20-20020a05600c3d9400b003f735792843mr2141492wmb.4.1686150559063;
        Wed, 07 Jun 2023 08:09:19 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n25-20020a7bc5d9000000b003f7e4639aabsm2448473wmk.10.2023.06.07.08.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:09:18 -0700 (PDT)
Message-ID: <718fa1d1-2c1c-a373-e96f-2aac9017c280@grimberg.me>
Date: Wed, 7 Jun 2023 18:09:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] nvmet-fcloop: Do not wait on completion when
 unregister fails
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Hannes Reinecke <hare@suse.de>
References: <20230606122411.7972-1-dwagner@suse.de>
 <20230606122411.7972-2-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230606122411.7972-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_080923_368405_AA260CEF 
X-CRM114-Status: UNSURE (   6.62  )
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

