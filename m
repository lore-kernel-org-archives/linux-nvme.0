Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127E5C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 21 May 2022 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8mtK4M7YXh7zrZrlDX5Dshzfbk1E+acl5miPGK/wWpg=; b=PVcHZV6066eezdqZ4LKVDo4mOb
	YOGgvy/xr3tq1X78W676cVShCobExk8yp3gSrAfqWbXPupFxyACS98JoHrA7eQw299S6HKP5lmgqh
	KloVeWDa7ywGdE5GrD+2Ws06ApQEv2jbTzWvloIfLDO5tZfHq72s8gY1Zplgdsw1m1kieRF2ed7Cj
	0oyIK2Eob5V0thBkRsEbp/Evb5YCdmRyhyCzxgTzIwl1wDJsPnobhknTBDooEFVPwueRz0WStrYsP
	rqJ5n/CkO0Xn0P/OSzDbb4v08+MmhwapMmmcntyQN6rIlmfdhqMW2OMVgjiaP+rir13D/rXhN0oLn
	ns4mGk9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nsVJf-00HNch-8r; Sat, 21 May 2022 20:03:11 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nsVJb-00HNc1-Vr
 for linux-nvme@lists.infradead.org; Sat, 21 May 2022 20:03:09 +0000
Received: by mail-wr1-f48.google.com with SMTP id e2so4008101wrc.1
 for <linux-nvme@lists.infradead.org>; Sat, 21 May 2022 13:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8mtK4M7YXh7zrZrlDX5Dshzfbk1E+acl5miPGK/wWpg=;
 b=ixAJRNCRjPYp5okUB+z4hYvf+i20pkZVgz0lxE3lJU4EFkDGJi0bUkYUN3AsQZJNNp
 qqmGh39IZRvpc4F0gASgzAm8dUXsAzDmvjcJOsJsaBR0fJLT2buXwVcbWKEePXZaG3FN
 XI0Mxr2/pgg8RYGI/2JY/xqvzLcPttFXmLNv9rbHMHcf0E6/SqOwEk60yehGnz16KSmV
 +uN2wZ+S3HuD3BE59FFsCk9MmkfJ+nRMTb28iIKIta1N/1OqXjKdSdKmHJ87sgjvykzg
 trtAz1+juvBVU6QoZdHQx2zrGDlkYkGDy79MSDEa2J2z2psa20R1najqF7qdJVpSJh+u
 fNjA==
X-Gm-Message-State: AOAM532dhD3wPZGeUQZnDXJ7sKJ0d437VkGWqKwEgPk7qD2EJuo7w/7A
 mZum/+cJABZPAkagne/JV8A=
X-Google-Smtp-Source: ABdhPJyeNXsL09F8uJcNt+RmYY35LKXfN43schtUy5nGq04kJ4y5myxHjELicJR6rIX20CHLMjziUQ==
X-Received: by 2002:adf:fc45:0:b0:20d:9e:6622 with SMTP id
 e5-20020adffc45000000b0020d009e6622mr13210320wrs.198.1653163385993; 
 Sat, 21 May 2022 13:03:05 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il.
 [46.117.125.14]) by smtp.gmail.com with ESMTPSA id
 l6-20020adfa386000000b0020c6a524fd5sm6744909wrb.99.2022.05.21.13.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 May 2022 13:03:05 -0700 (PDT)
Message-ID: <85a65656-5b1f-d2d8-b075-11bccadc8508@grimberg.me>
Date: Sat, 21 May 2022 23:03:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] nvme-tcp: queue stalls under high load
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <64f57dcf-f3d2-d1db-782e-4f48c542754d@grimberg.me>
 <23ab4753-593f-e44a-b768-0c1d3682abb0@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <23ab4753-593f-e44a-b768-0c1d3682abb0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220521_130308_073260_4C9A681A 
X-CRM114-Status: GOOD (  12.93  )
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


>>> Hi all,
>>>
>>> one of our partners registered queue stalls and I/O timeouts under
>>> high load. Analysis revealed that we see an extremely 'choppy' I/O
>>> behaviour when running large transfers on systems on low-performance
>>> links (eg 1GigE networks).
>>> We had a system with 30 queues trying to transfer 128M requests; simple
>>> calculation shows that transferring a _single_ request on all queues
>>> will take up to 38 seconds, thereby timing out the last request before
>>> it got sent.
>>> As a solution I first fixed up the timeout handler to reset the timeout
>>> if the request is still queued or in the process of being send. The
>>> second path modifies the send path to only allow for new requests if we
>>> have enough space on the TX queue, and finally break up the send loop to
>>> avoid system stalls when sending large request.
>>
>> What is the average latency you are seeing with this test?
>> I'm guessing more than 30 seconds :)
> 
> Yes, of course. Simple maths, in the end.
> (Actually it's more as we're always triggering a reconnect cycle...)
> And telling the customer to change his testcase only helps _so_ much.

Not to change the test case, simply making the io_timeout substantially
larger.

