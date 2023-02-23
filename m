Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9CFC636D6
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Feb 2023 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6hXYN8j62FdMOuIHfGnONjGoCuAo9ox8KU2kT7xN5I=; b=12Rku79ttT3tz7WjEAPKS/yo6Y
	ENZ1lx+AXw0m/Bi/FQKkq9rutmZ6+36B3S3+y/ECYarKzRXYKRdV+qNH2wTeQRSd0pTAeW06Rf4Ca
	o18o3A71Xl7C2qko1YlQioGZi+c4M1C2Ur+K9bQ6NHsflUcLZ3uWUw3oyMHlu7Z3vTAAX+3M99ZQR
	6ocvKKmcHoGNnNLkKofTtW0Hajxs5Z1J0TwQd9kAkyZqE7Z6lTHi56e5cNfHCNcLGNHVsqStU924f
	Pdio2vHWK9dAn6FbYcQIiUxWdVv7gKMlA9GsJLma+s4U3Bdtp3lKMpKtX/k3+0lLE9wjBX3tS38Lz
	cMh6YUpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVDbW-00H3uQ-Ii; Thu, 23 Feb 2023 15:33:54 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVDbS-00H3qe-Hx
	for linux-nvme@lists.infradead.org; Thu, 23 Feb 2023 15:33:52 +0000
Received: by mail-wm1-f41.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so381511wms.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Feb 2023 07:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6hXYN8j62FdMOuIHfGnONjGoCuAo9ox8KU2kT7xN5I=;
        b=G95+5yc1bDrUExScWTxKOEK5miZ62qXU696hUgiv5KSIqUiSlINvI+StPBCvmSdMpG
         xw9nkZCLu7S5T5j+vJ0FQLU+u6Y5c/U1pNji6OdCKCDbVOLBpKFOhnaWwljgMoW7bOxn
         5YqCwUd7gNelqxvknQJ7uKDgFZoK8Ka/rchOsYzG0Q4dD/aotqcfbDqk7/Hh1jWpMeg1
         stqNe2Iheo63L7LuV19Vg0ak9IZSUPfaUT8Mmk1x3+JqgmY37NNVNLjuvOjAfLhE5kVP
         6VFxKAFAtzdj0nDOELG6CgGvM1vOADA5mgzo9HsT16UlxNKU3OZRuTOU6++3hhS9do/r
         5UwQ==
X-Gm-Message-State: AO0yUKXGEyOGSN4DfhSZVud1tDywnEwpgYuXlM10brXResFLqHhBbv9y
	6mQJVg6bNuYz28dJl0u41dc=
X-Google-Smtp-Source: AK7set8H9eIuX3XvQveK6S6sVV3dnOv6DtpjIG/yxFwYLXs40/SLN5hc0pHZXNkxrAzWCP4r/JWM1Q==
X-Received: by 2002:a05:600c:28e:b0:3db:2922:2b99 with SMTP id 14-20020a05600c028e00b003db29222b99mr9364819wmk.4.1677166423089;
        Thu, 23 Feb 2023 07:33:43 -0800 (PST)
Received: from [10.100.102.14] (85-250-17-149.bb.netvision.net.il. [85.250.17.149])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b003e209186c07sm11616530wml.19.2023.02.23.07.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:33:42 -0800 (PST)
Message-ID: <72746760-f045-d7bc-1557-255720d7638d@grimberg.me>
Date: Thu, 23 Feb 2023 17:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v11 00/25] nvme-tcp receive offloads
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com
References: <20230203132705.627232-1-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230203132705.627232-1-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230223_073350_614080_51CF0823 
X-CRM114-Status: GOOD (  25.02  )
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


> Hi,
> 
> Here is the next iteration of our nvme-tcp receive offload series.
> 
> The main changes are in patch 3 (netlink).
> 
> Rebased on top of today net-next
> 8065c0e13f98 ("Merge branch 'yt8531-support'")
> 
> The changes are also available through git:
> 
> Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v11
> Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v11
> 
> The NVMeTCP offload was presented in netdev 0x16 (video now available):
> - https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
> - https://youtu.be/W74TR-SNgi4
> 
> From: Aurelien Aptel <aaptel@nvidia.com>
> From: Shai Malin <smalin@nvidia.com>
> From: Ben Ben-Ishay <benishay@nvidia.com>
> From: Boris Pismenny <borisp@nvidia.com>
> From: Or Gerlitz <ogerlitz@nvidia.com>
> From: Yoray Zack <yorayz@nvidia.com>

Hey Aurelien and Co,

I've spent some time today looking at the last iteration of this,
What I cannot understand, is how will this ever be used outside
of the kernel nvme-tcp host driver?

It seems that the interface is diesigned to fit only a kernel
consumer, and a very specific one.

Have you considered using a more standard interfaces to use this
such that spdk or an io_uring based initiator can use it?

To me it appears that:
- ddp limits can be obtained via getsockopt
- sk_add/sk_del can be done via setsockopt
- offloaded DDGST crc can be obtained via something like
   msghdr.msg_control
- Perhaps for setting up the offload per IO, recvmsg would be the
   vehicle with a new msg flag MSG_RCV_DDP or something, that would hide
   all the details of what the HW needs (the command_id would be set
   somewhere in the msghdr).
- And all of the resync flow would be something that a separate
   ulp socket provider would take care of. Similar to how TLS presents
   itself to a tcp application. So the application does not need to be
   aware of it.

I'm not sure that such interface could cover everything that is needed, 
but what I'm trying to convey, is that the current interface limits the
usability for almost anything else. Please correct me if I'm wrong.
Is this designed to also cater anything else outside of the kernel
nvme-tcp host driver?

> Compatibility
> =============
> * The offload works with bare-metal or SRIOV.
> * The HW can support up to 64K connections per device (assuming no
>    other HW accelerations are used). In this series, we will introduce
>    the support for up to 4k connections, and we have plans to increase it.
> * SW TLS could not work together with the NVMeTCP offload as the HW
>    will need to track the NVMeTCP headers in the TCP stream.

Can't say I like that.

> * The ConnectX HW support HW TLS, but in ConnectX-7 those features
>    could not co-exists (and it is not part of this series).
> * The NVMeTCP offload ConnectX 7 HW can support tunneling, but we
>    don’t see the need for this feature yet.
> * NVMe poll queues are not in the scope of this series.

bonding/teaming?

> 
> Future Work
> ===========
> * NVMeTCP transmit offload.
> * NVMeTCP host offloads incremental features.
> * NVMeTCP target offload.

Which target? which host?

