Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8E4CE7B1D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GyxUOYRk77DlFPakFZdQBB8IksHfOA+7wF/s9YT50NI=; b=m464AcxfyJRjdR/JVI0a1rHaLg
	NfQmqXaZBNNbAL6sIQG4uP79OnX4YQXHnK6NV8b6/rGX01GWrW98CoJDQAYeQeXxxiyvoqkp4fp9D
	haVeUTesVv5ELHI4+H6Aw0YfwrWqYLx3yDpgrB0Pf/zJNUWSruFz2Yp0rXpasY1U+twIvKKhV3lHm
	K2sTldBy2x4nYfOXwtn4rP6j2XCEcKK0TlByqpdr3x9tMCDggqTfMd4NbpQ/u2ubTG+lO4s9dkNNB
	N6gRWoeKI+ngLuWF8R//U4KucYqBldE9jWuHTk/EAg0NzBpunRjkh5AqOeFhpsYUaVVFZdJlGOpfR
	1f+e+RQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smaCt-0000000Cau9-0gem;
	Fri, 06 Sep 2024 14:45:03 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smaCp-0000000Cat1-2Imt
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 14:45:01 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-710a73518d9so1116171a34.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2024 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633898; x=1726238698; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GyxUOYRk77DlFPakFZdQBB8IksHfOA+7wF/s9YT50NI=;
        b=B6RkzXDA97Ni2Ytn7ScaH6tYpFWxIkok0HkvJtfLzyjazYiJRCzH2nPkWAqWs8LtHo
         OZX7H/z6r+LvnNR9wkKTmjlE6h+c9dEbyalQuOJ72XzI5LF7tqKqMO1WX22UQDfNe65D
         AEbeSSzhzDZnxxWDth3N0uihFqOEaI6jd+jJlmpkzGyHCtRsYGe0xNY/ehHzaNSNqH5V
         /AKO1boJnTkYWaF4z+phIe9nCAcqlS0y+TrsllNW0jk0+siivbeyHXulowNjR6794LCb
         o82WlwDZ3nOvWsM9Y/UmFd8NVQYtQ6Ki9bisFMhj93wfp2GJb2wdv5mMUCZB6BW7nZHS
         RKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633898; x=1726238698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyxUOYRk77DlFPakFZdQBB8IksHfOA+7wF/s9YT50NI=;
        b=lSqFX69XMAqK9iWbxLHaN4WqYKqstOcx742XO5Pq0Mz37xmVgCSLUpL3I+ACF9zPdX
         AxMWoreWNK0iOSBR6XwTMJA4NaI/xbn7LcpcA09TUHSyHX3Y6URcEM66YIu4BFLALxG8
         P+LfeBRVUlhJu9yPf/ZYafetNT4/KggxQ0koqNtIaGjSF94Ls7Zyv2pYIkbaIKLb0l8h
         krpeIw2BYeqeD7Ah0GzPwPTxo8XDDBplUEPBLr5OYuzxHjFWPfhKon98/foyzEjLXyLl
         h9mVguIKOIw7WzxFxAuRHh5zmvEXPwGFljkO7L5H9JlA3GcyMXCHlEO9deGxkYVlBlOp
         FN9w==
X-Forwarded-Encrypted: i=1; AJvYcCVUBL08vAMyQQK6aGDE3qbMjhBVGweXHSem5Ms/7zEA79H+y+7vEep00BcLg6arFoklFaodbXt/SyuM@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8jVhErmKvi4Dc8TCJG/C8EUCYyN5YyA6/lmD6rV7pSimFXhoR
	wtRDbsKdwYuv4w+wqrOwGvAgV1O2yDjx8bThygKBoT+3ZeQJkYjB
X-Google-Smtp-Source: AGHT+IHMQDqhtdJGb9vyXpHdHFvZFVG4lkfcKhyySIkCk4aZ5q39igSbjuHhU/CwGK2TOnT9q/pDDw==
X-Received: by 2002:a05:6830:6c87:b0:710:cce7:5bb8 with SMTP id 46e09a7af769-710cce75effmr723161a34.15.1725633897836;
        Fri, 06 Sep 2024 07:44:57 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f7642579fsm2894273a34.66.2024.09.06.07.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:44:57 -0700 (PDT)
Message-ID: <d4d3ef1f-3f34-40c5-88d5-ed1f35123705@gmail.com>
Date: Fri, 6 Sep 2024 09:44:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <20240905221340.GA2732347@thelio-3990X>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240905221340.GA2732347@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_074459_627448_22C6751B 
X-CRM114-Status: GOOD (  20.13  )
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



On 9/5/2024 5:13 PM, Nathan Chancellor wrote:
> Hi Stuart,
> 
> On Thu, Aug 22, 2024 at 03:28:04PM -0500, Stuart Hayes wrote:
>> Add code to allow asynchronous shutdown of devices, ensuring that each
>> device is shut down before its parents & suppliers.
>>
>> Only devices with drivers that have async_shutdown_enable enabled will be
>> shut down asynchronously.
>>
>> This can dramatically reduce system shutdown/reboot time on systems that
>> have multiple devices that take many seconds to shut down (like certain
>> NVMe drives). On one system tested, the shutdown time went from 11 minutes
>> without this patch to 55 seconds with the patch.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> Signed-off-by: David Jeffery <djeffery@redhat.com>
> 
> I am noticing several QEMU machines hang while shutting down after this
> change as commit 8064952c6504 ("driver core: shut down devices
> asynchronously") in -next. An easy test case due to the size of the
> configuration:
> 
>    $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- mrproper virtconfig Image.gz
> 
>    $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/arm64-rootfs.cpio.zst | zstd -d >rootfs.cpio
> 
>    $ timeout --foreground 3m \
>      qemu-system-aarch64 \
>        -display none \
>        -nodefaults \
>        -cpu max,pauth-impdef=true \
>        -machine virt,gic-version=max,virtualization=true \
>        -append 'console=ttyAMA0 earlycon' \
>        -kernel arch/arm64/boot/Image.gz \
>        -initrd rootfs.cpio \
>        -m 512m \
>        -serial mon:stdio
>    [    0.000000] Linux version 6.11.0-rc4-00022-g8064952c6504 (nathan@thelio-3990X) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT Thu Sep  5 15:02:42 MST 2024
>    ...
>    The system is going down NOW!
>    Sent SIGTERM to all processes
>    Sent SIGKILL to all processes
>    Requesting system poweroff
>    qemu-system-aarch64: terminating on signal 15 from pid 2753792 (timeout)
> 
> At the parent commit, there are the following two prints after
> "Requesting system poweroff" then the machine properly shuts down:
> 
>    [    3.411387] kvm: exiting hardware virtualization
>    [    3.411741] reboot: Power down
> 
> If there is any other information I can provide or patches that I can
> test, I am more than happy to do so.
> 
> Cheers,
> Nathan


Thanks, I'll take a look.

