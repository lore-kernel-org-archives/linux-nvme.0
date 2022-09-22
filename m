Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFF3ECAAD8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=id9dL70ZCkVQ057m+ck3OKIjJfDv0obKsGMdgXEca18=; b=wvrcPHldt7RdJuURmYT2HqpmbR
	2QrnsDFeXTCjMKf3v+Dj9txRMEQGtLP/cmNOoh8gzkfSffst4mrKIdqboBK2fm93xKVDit6e6+oqR
	gqSZKaj43VfaJ/AGPIxbU9PtBE/ds+DVapsWs+2w5Y4TUkLtpFjTJ8HghVWIul1iaHHdmPx758dl+
	z4UjKfGYe+5/pIi/ZaabargtfxWRvn8ZI9ghFTtu4L0W7gutOA7zFNMBdRWQABI9g8Bu9ohO9f2Qr
	49f3g+vKWR7gIbt7bP/LmqapzNBRxeBFf54qljV7OCfQJqijWLYwB9q6BpdZuIwfYh2mDIGsugSTe
	SdTD9olg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obV7j-000X0G-GI; Thu, 22 Sep 2022 22:56:51 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obV7g-000WyT-Kz
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 22:56:49 +0000
Received: by mail-qt1-x829.google.com with SMTP id h21so7399137qta.3
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=id9dL70ZCkVQ057m+ck3OKIjJfDv0obKsGMdgXEca18=;
        b=Qh1EWEYm4TNkkBvym9/PBPh+Ab5JAr1J7aPeynDRFpP9Hspc0Y20DkVb8xSj9yyjsx
         yceEENxacZ5BcLkDlYIzoA4C2oqxFCo5fksQLJIo8Pf+04YbEVEfyUSy5n8E2TwIylZj
         t7dmtwHIjXqCQdBsMdrhgqlNGwddentHKeB/KPSd2xzej2TUxJarlOvHusm8Fr/TbJHc
         Ni3+KHggrVj/RElN/LB4Ptt4gAlbZcvAfrStkpYm6qx6So0GT/nFHS+T2wYDJXpc2ucq
         XYfhEVaTc4BLZ1cSYIxGY6vmAUEX1Dky980DC77yzqxFhVK0K+GKzG/F9fkhHFQyKEEX
         q4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=id9dL70ZCkVQ057m+ck3OKIjJfDv0obKsGMdgXEca18=;
        b=Djg0y/QahBOpw7XT+dvFyeWQ3pZOV/VAuSEhqLCfhxADKCQaJtSf4r6mZdRxqmK8Kp
         Y4He7lFIcPMr5O8fL+IDil4GvZCmBalGNu5wZYNGZRxWFqW6/oWHZpi8gz4mSXEIvwg1
         YzMi2HYY0cJznLE/736mt8n1X2nW/SE9otR9i8g7K441DpuOL227GPUl+iCvWXK7v455
         tZNueOX00hZSeWJPL5lDjIQxNda8bcRc6TuZG4zgiw509OkBT5hTgEypLBDEzvZrUz27
         N6eMqI/RdkGDV7QDhJ7hMzFj7+ivzO1DeIGqPyIHJy04C2mNxNQL6bvfjnU1e8rqv+vS
         4INg==
X-Gm-Message-State: ACrzQf0ToqyhrsyXNb+xmNkh4+MxqiPH7g01H9Py6hP3JNSUVENZbGQz
	bwDQOF+rSI1TUj3MdzvOw7Y=
X-Google-Smtp-Source: AMsMyM4DRIvPxvdpZ/3FWDBdNdLEGceBYk4hOAeR9XMA5Jlmmjca2vVvGpXUdsGsDZtMb3NYn2SSKg==
X-Received: by 2002:a05:622a:3c7:b0:35c:fc6d:7abb with SMTP id k7-20020a05622a03c700b0035cfc6d7abbmr4910198qtx.581.1663887407128;
        Thu, 22 Sep 2022 15:56:47 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s2-20020a05620a29c200b006ce40fbb8f6sm4508909qkp.21.2022.09.22.15.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:56:46 -0700 (PDT)
Message-ID: <6f70d222-52f4-2269-ce64-f2e58ff5c479@gmail.com>
Date: Thu, 22 Sep 2022 15:56:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 09/13] nvme-fc: use the tagset alloc/free helpers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-10-hch@lst.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220920171611.1289361-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_155648_735940_6E1CEB9E 
X-CRM114-Status: GOOD (  11.46  )
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

On 9/20/2022 10:16 AM, Christoph Hellwig wrote:
> Use the common helpers to allocate and free the tagsets.  To make this
> work the generic nvme_ctrl now needs to be stored in the hctx private
> data instead of the nvme_fc_ctrl.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/fc.c | 83 +++++++++---------------------------------
>   1 file changed, 17 insertions(+), 66 deletions(-)
> 

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


