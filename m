Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B8EC7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 08:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2GiHUcSnMSP1Hvh+56AcVC729SXkx17RkcpbunNrDak=; b=WUuteLZfYzrzAMmR1HOn2uKshn
	L0TVm5wKSrsG3joOxPHpivqHRLaoSJ+xpL5J1uxA7Abk/jKjsY9YErgTdOP65/HF9GVPbLLLRwKJQ
	e4BBIherTYZHw4ckbdnfFIgC/MmKW7l8y7lt/fhS6yOtXM9tp54dVdgW76egS7E6pYxNknkWdzlcH
	wjHL0xh0XNXkgfOTdNFAb653BcR6QuqTkUk6KVUPxIvGi41mo8AIvH4ElFsYDgI6YeFwMbHn1iqHp
	KO8sKwSxIt2TSNue+df1VKPtcj72rgtIveyKMBSYhmXjUs6YHJDPuAI4be0gpXqflxFa2bWjePsHk
	fefzrSIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqrxQ-00Fj49-0i;
	Mon, 24 Apr 2023 08:54:00 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqrxM-00Fj2n-1Q
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 08:53:58 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f17b5552e9so10707335e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 01:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682326428; x=1684918428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GiHUcSnMSP1Hvh+56AcVC729SXkx17RkcpbunNrDak=;
        b=hLe2MHrw/8u8Px7Szh6IwjgWLIg6lLSqNPAgah2qZ6Qpj35tn0afK4oHBnzzglr8FP
         mzYXmIK041UaiJQBhz0oM5Vwj/Gw5cHlTcd54SUFjSmOJ14iNSGhkkKKlVPfF7Mqalf6
         +VdKiDve+G3oJslZSIAtzJek2gk3FUeVG+WwVAOChl1eMfFOu01o5GFVhb5PyDsvy9AR
         nOvl9FbHqfyZg6B0Y4XCGf/JIXihrJWD4wrv/Xv5chh9+F2Gx7YycN68Aes3mOvll8P+
         aAe7MxFV+sJt/FbVrVKo4jMhgUCv1g9xOfL4/3tpVf/73ctj6SthdPDY7wytr6Z6BvAH
         T3TQ==
X-Gm-Message-State: AAQBX9fRpzwSpG1dJBND8k06uIoMs/40XlH0XLbJhjVAe42sPC0vEj++
	2uLs6XiVSX1JQFs1EdVVjeg=
X-Google-Smtp-Source: AKy350akP3bYDfe+vbBKt69VIsKGEZTVjxqhatKenixSFNbBXRYARwbMSEYZ1XiaqIZzjp4k27n4hA==
X-Received: by 2002:a05:600c:3baa:b0:3f1:960d:68ce with SMTP id n42-20020a05600c3baa00b003f1960d68cemr6052169wms.3.1682326428292;
        Mon, 24 Apr 2023 01:53:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm10329789wrp.20.2023.04.24.01.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 01:53:47 -0700 (PDT)
Message-ID: <9b3da2c2-b158-ff4a-e7e3-62e49f366ac2@grimberg.me>
Date: Mon, 24 Apr 2023 11:53:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 0/2] Fix failover to non integrity NVMe path
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, martin.petersen@oracle.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
 israelr@nvidia.com
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
 <20230424051144.GA9288@lst.de> <5b7ca121-2b85-ddd0-d94b-1739cc5dcbec@suse.de>
 <20230424062040.GA10281@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230424062040.GA10281@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_015356_484180_9FE48EBE 
X-CRM114-Status: GOOD (  15.41  )
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


>> Yeah, I'm slightly unhappy with this whole setup.
>> If we were just doing DIF I guess the setup could work, but then we have to
>> disable DIX (as we cannot support integrity data on the non-PI path).
>> But we would need an additional patch to disable DIX functionality in those
>> cases.
> 
> NVMeoF only supports inline integrity data, the remapping from out of
> line integrity data is always done by the HCA for NVMe over RDMA,
> and integrity data is not supported without that.
> 
> Because of that I can't see how we could sensibly support one path with
> integrity offload and one without.  And yes, it might make sense to
> offer a way to explicitly disable integrity support to allow forming such
> a multipath setup.

I agree. I didn't read through the change log well enough, I thought
that one path is DIF and the other is DIX.

I agree that we should not permit such a configuration.

