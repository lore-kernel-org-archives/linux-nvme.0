Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF765C624DB
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2026 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=47kDnBPsAVOPUrwjdBqcnGeJpYWqPauda86jUBJNxXQ=; b=Fv0hPkGxwhkaDgzF+TT6xptHLT
	okcL2o7V90Bs2mz1YERp4f5ug5/gnHMReriQWLlMU83rz1b98rz/04KW+zxZhP4KpEGSGiY9z3UJx
	L2q+0TSihwsAQeL7svhwOfC1lPB8ozGwHZQPJr0cFrvPGhEix4wJoE1/T0g3s6LmymL8onf2/k4gC
	YBQ0XEoYTcami5/+QPTB3TLI4Qw7M/cngEtbDI6Ex81HFKRG2tdRicxToq41qo5OFV4adW/GzCNSp
	uTLUDmPfNQYA7qA12R/2Vv4aNLCi0JniP3UhmyJhsTjFYtEVtXqcSvBDvVSbFPCf9UfWy1gPe3Qjs
	UrdDsrAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2z0I-00000004SQd-1RPI;
	Sat, 05 Sep 2026 22:36:54 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2z0F-00000004SQF-3I3e
	for linux-nvme@lists.infradead.org;
	Sat, 05 Sep 2026 22:36:52 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48589798dbbso1792287f8f.3
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 15:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788647810; x=1789252610;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47kDnBPsAVOPUrwjdBqcnGeJpYWqPauda86jUBJNxXQ=;
        b=Plqq/qddPqBTEiKQCs95kL9I3LYGuXm/b+FRpWX9u6jsBy9NCdEdrmyJ/2bTcNtYoE
         dbz3A6z/BAcLiZTdRKgB1aQPxjrTnE4H8niT6bOJ/PCxu06VQkgusUuxNHt4GK2nwAX7
         wfwGAJn8tV/mLYk9QVjvKQHCfs09x3SiZTKImDzOL0aXdSNw+3V7XXCxknOVhgPtsyI7
         k0RwjnThdIxSvezrnAKuIDXZwo/bgqcQ4AKGtds0tcRbG1NhJ0KxAg+h/LZ0fjjtxFZT
         MJ/zj1E4dHYAvXbEO5M/CiHpOu0zC6z6d4sj4JDdeEFocFXzNVcVWipnSmAP6+YX1bZn
         ZRPQ==
X-Gm-Message-State: AFuF++l9whJalp2yv2W63kZFHO4wqmKY4pfd7BxbEf9vsDq/voRPEO8p
	HDXj0J5qYbyLr6C49JGUquy1Mrr52hVlxkebaUp6v+S/VyWn4SKDr9hp
X-Gm-Gg: AYBFou3ZtMx3lNYVkI6InfONobCrjBCLiRoEKwKu4oW792Gdum/VfuNKpwxzayPVgBD
	RH+RSAowcrYfXT/zt9EGmFAMuOQrpiPFzr0EHui230IR4SALhoCNCQKvbp8d//qO1/WS4CocMHC
	104hfyQ72C8Lp0sMxOXCVGFV65lzdEnbs1+NmXmFe/sP/pyacWnnFAm4S1b/SJQxoCfDUT8Qnmq
	UFkN+xA/S1z3iCGaiDC9XqzjTgi4ydvHP8jIwSsK66ZmUGpR3msi7GB3j9UdtDXHFUBbDgZ04JZ
	uwoJNP8MWTfXlIUOQ+aN+6ufj5bvf3jKub8PBRwMysgTJTT+StTxqGXOTMz2GbbkCXvCMwZAUMr
	rTHBtQy5xfH08m1U/gMyyI0UW4KaT1t/mRGaZMhcwxuFor5bmv4u2aXMJc1B6QNPpUQ07DKo0Y+
	03q3eN5SbiIFRDhuWoOFc/OCmyJthc5DU5igNbHelyQOBueHMZ44WPYtgECv7LAElqQI8KGZHxI
	+E8W4mbfNBBX80/yE3wW1IdK27SkVdK
X-Received: by 2002:a05:6000:4a0a:b0:485:8a46:704d with SMTP id ffacd0b85a97d-4858a46713emr13097166f8f.31.1788647809722;
        Sat, 05 Sep 2026 15:36:49 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm16289835f8f.23.2026.09.05.15.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 15:36:49 -0700 (PDT)
Message-ID: <6b8ff0b7-c606-471d-b3be-12df3dac350b@grimberg.me>
Date: Sun, 6 Sep 2026 01:36:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] nvme-multipath: add fail_io_now sysfs attribute to fail
 queued I/O
To: Krishna Iyer <kiyer@crusoe.ai>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 sj@kernel.org, saravanand@crusoe.ai
References: <20260904032605.65758-1-kiyer@crusoe.ai>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260904032605.65758-1-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_153651_835576_26D83663 
X-CRM114-Status: GOOD (  13.33  )
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



On 04/09/2026 6:26, Krishna Iyer wrote:
> When all paths to a multipath namespace are down, I/O is held on the
> head requeue list until a path returns. With ctrl_loss_tmo=-1 the
> controllers reconnect forever, so during a long fabric outage the I/O
> is held indefinitely and any process waiting on it sleeps in D state
> until the fabric heals or the host is rebooted. We hit this on
> virtualization hosts, where a SIGKILLed VM process cannot exit because
> it is still draining I/O to an unreachable NVMe/TCP target.
>
> There is currently no way to fail this I/O without tearing something
> down. Deleting the controller (or letting ctrl_loss_tmo expire) works
> but takes every namespace on the controller with it and requires a
> manual reconnect afterwards. fast_io_fail_tmo only arms on the
> RESETTING -> CONNECTING transition, so it cannot be set once the
> outage has started. delayed_removal_secs only matters after all
> controllers are gone, which never happens with ctrl_loss_tmo=-1.
> dm-multipath has had "dmsetup message <dev> 0 fail_if_no_path" for
> this for decades; nvme multipath has no equivalent.

I don't understand what is not sufficient with fast_io_fail_tmo? It would
determine the time that IO will fail when all paths are down.

