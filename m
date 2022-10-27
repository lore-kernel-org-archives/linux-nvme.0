Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F33C38A2D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=olcqBqp20ijqPE54YEtnv810clQFjmIdUzlbWquxgtg=; b=JwdAaapH7bD672k3UhkIuWJbz1
	kzHaRSfsuVTt2Dt4Go9jaS45riok+cEnwEBcz4XfjDW5bVEICX4eu2BCtIZR8dS6s/FNylo3XNJMs
	tWxFRTIRpQtwbljEhS0KRhVZIe7vp8V2Y0nqKaHTOOPHWWGJF0Gc+kjQ8TgydPcJQglQEaUgUwGLu
	hudV1IkBUkWbrcrovso4xXn4nHHIrai56Sdv4sLx9VT0j5m7NO2FjvKP3vLtICLfd3q82SLvcTbJY
	tUWaHPth7nZNg1yirhjV95vM4OIutQMbA0Dpw/4sVJVEhncLg6sw3QfxETYwVRx+o3Bug6Gw+vAFY
	01kqEYGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo0Ew-00CsvN-0H; Thu, 27 Oct 2022 10:35:58 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo0Et-00Css1-Ab
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 10:35:56 +0000
Received: by mail-ej1-f47.google.com with SMTP id ud5so3271266ejc.4
        for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 03:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olcqBqp20ijqPE54YEtnv810clQFjmIdUzlbWquxgtg=;
        b=fV1aPvHDaHY+GWEEtsvjV0ev4bSPCixupj3hc8KOiUdcIHAEvqrz2MpUmdB0eR7to0
         TkjtlxgjNbL3udvhQY7FVYJZg3eAidtIyBObOwWPy8OrFZ7iSHb4vtlhwGaMv62bJHZh
         T/RO54ryNX6INWLAq7KYFgSgChUZAZAbjlDdH+KYqf1J9DY1ub/zvW/1pzcbsRzBZm3A
         8ZNJf8iit+XogzRB+A6Tr6rMsxmFSoR4msRzvscYWFSJhDlPU9x3WR/rPlthAbx2EmM9
         cJAgaP8Sb3NQGvUxlEN9ZXyVCbptOPkHJQWrZovpScq+hFEv+KyWVQQD1lIKcl9huytx
         7Chw==
X-Gm-Message-State: ACrzQf0wQzjpfa+zUiYCpzuz72+EooHHDvvaOCR1unviQQpEt548z9eV
	E9884TEU/GxavKRxygla27I=
X-Google-Smtp-Source: AMsMyM4rYnExz0aFrBW9qQ4H4xsy4bm36lWxnSlbkJykRkR4bYDUrHr86IpEEGRGUwvvmAWw/TKtYA==
X-Received: by 2002:a17:907:75d4:b0:7ad:92da:379a with SMTP id jl20-20020a17090775d400b007ad92da379amr1162099ejc.681.1666866951100;
        Thu, 27 Oct 2022 03:35:51 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056402228d00b0045bccd8ab83sm791888edb.1.2022.10.27.03.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 03:35:50 -0700 (PDT)
Message-ID: <f62c517e-e25e-ad2f-cf31-cba6639735ad@grimberg.me>
Date: Thu, 27 Oct 2022 13:35:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 00/23] nvme-tcp receive offloads
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com
Cc: smalin@nvidia.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 borisp@nvidia.com, aurelien.aptel@gmail.com, malin1024@gmail.com
References: <20221025135958.6242-1-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025135958.6242-1-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_033555_414424_82F7A64E 
X-CRM114-Status: GOOD (  13.34  )
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
> The nvme-tcp receive offloads series v7 was sent to both net-next and
> nvme.  It is the continuation of v5 which was sent on July 2021
> https://lore.kernel.org/netdev/20210722110325.371-1-borisp@nvidia.com/ .
> V7 is now working on a real HW.
> 
> The feature will also be presented in netdev this week
> https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
> 
> Currently the series is aligned to net-next, please update us if you will prefer otherwise.
> 
> Thanks,
> Shai, Aurelien

Hey Shai & Aurelien

Can you please add in the next time documentation of the limitations
that this offload has in terms of compatibility? i.e. for example (from
my own imagination):
1. bonding/teaming/other-stacking?
2. TLS (sw/hw)?
3. any sort of tunneling/overlay?
4. VF/PF?
5. any nvme features?
6. ...

And what are your plans to address each if at all.

Also, does this have a path to userspace? for example almost all
of the nvme-tcp targets live in userspace.

I don't think I see in the code any limits like the maximum
connections that can be offloaded on a single device/port. Can
you share some details on this?

Thanks.

