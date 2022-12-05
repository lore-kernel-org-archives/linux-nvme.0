Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902A2C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 18:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ImidpIQm24xC230ns//vzB+kQ7xYkel7WPj+tXR6tek=; b=eWt913gGTzXchvIxk8HQpQPbL+
	lXLkODX3rxQTktPQsldx597UZgTKKDU+xGSYny95sDkKAPi9P4lTql8ia2n3An8K2MKJP1WZu5M/g
	cUXYOEoADWwIyPfVnqzcTEPg83A+FL72x5KcfO1HQOkuX5I1OUb1JAM56Nl4l37EEMCQWlcxK3l8V
	hb/E4IWCjk4/tkud0ALUfA/pfNgDfdX/fPiq2Qk6E3kg286WREDNja9wVRgfpJxkgZCdzBB7zFUDO
	UCxlY4zKBauYusFQ8iRG6x90R/uCtFvJOfV/PINN9RT2WWZYlFAtum804kfGSKF7fKivMNsj88dSP
	mXK1KEbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2G9O-008MDD-9x; Mon, 05 Dec 2022 18:25:10 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2G9L-008MC4-KI
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 18:25:08 +0000
Received: by mail-pg1-x535.google.com with SMTP id q71so11211878pgq.8
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 10:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImidpIQm24xC230ns//vzB+kQ7xYkel7WPj+tXR6tek=;
        b=8GuqePATHeBdjIjB00TbgRxhjgSPMawtU2wrtMW9YV2SFZq8p01ldTEAEDJdXmVdMQ
         aKPQa9ow3SZfxPLVddZSdd1Vmiivd8Xsns2MQXSSv+HZEwMB1AkPzU6/prRYqgG7kBx1
         pFwb6vkT/NsseKhCFBT2+xNiqVxZUMuF074XfMTL9Gx4DluIfSQ7QPpppgw373tGuZ5f
         xVs1yKe34IQP9m0MTefim8eR8AQhvmWGrY892kFb9Pe9xk1DbtOZd1fthb/96tnSraR5
         hLHHIQR60waW9xkALD7Ke5rkzmfw0e/dorvR7w9+noJkFwmrrhy7A1sDDF8SwAYzoYsH
         S2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImidpIQm24xC230ns//vzB+kQ7xYkel7WPj+tXR6tek=;
        b=tK/0p3dLp7gngGcp1upg0jkeqiRWVA5vuS5m4kYpD+SnhyxpROX+CMICYbs61HR7d6
         sY/t+TMonVqddzlflf3O1Y+2UfP5jqYH9nfgeXUUQMr6NVIPUJ7X5RIY8dnDGEJmUw2Y
         wZ8djuL6OZiK0TXb0+TBXTvfHVQl85k50AdvvVO97ZjGHdq7nPKp1cqIhMd1J9duUB8E
         2RBvp3fXAjMYrpzovVNI90dZA/iUWceFedPcgXPn3rPMIelh+IkKESi/5MH7Xta7xAHD
         Vlf1oYpmr3x/a7UrSGz0nEMnWloQzNX5gwmh/RVNPdsQkFsmiHzrQk1Jwy6RyYV6Y7mD
         GQLg==
X-Gm-Message-State: ANoB5pmgPfitCVso3Ovo8dxzSIEwWYcCidcV4bR19KJIWsU6tACcoulR
	ZG6Ml9cRZSJJNgJx8tsGC5EH9g==
X-Google-Smtp-Source: AA0mqf6LXB3TBL6QfztXAdNGDz+SFYGDjGPt38SvDGSzimZxm0Mc+GjiJQds8/JFTJ/UbjqS/ZkzWQ==
X-Received: by 2002:a63:ce43:0:b0:476:fdde:9ac8 with SMTP id r3-20020a63ce43000000b00476fdde9ac8mr57775329pgi.164.1670264704207;
        Mon, 05 Dec 2022 10:25:04 -0800 (PST)
Received: from ?IPV6:2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a? ([2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b00189529ed580sm10917190plb.60.2022.12.05.10.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:25:03 -0800 (PST)
Message-ID: <759f50d0-75c4-7970-b145-469e87f6acc5@kernel.dk>
Date: Mon, 5 Dec 2022 11:25:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_102507_692990_1DC250C1 
X-CRM114-Status: UNSURE (   8.75  )
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

On 12/5/22 9:20 AM, Alvaro Karsz wrote:
> Implement the VIRTIO_BLK_F_LIFETIME feature for VirtIO block devices.
> 
> This commit introduces a new ioctl command, VBLK_LIFETIME.
> 
> VBLK_LIFETIME ioctl asks for the block device to provide lifetime
> information by sending a VIRTIO_BLK_T_GET_LIFETIME command to the device.

s/VBLK_LIFETIME/VBLK_GET_LIFETIME

for the above.

-- 
Jens Axboe



