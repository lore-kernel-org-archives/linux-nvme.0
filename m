Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47353C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DGBOU35K+KpU1OIUsCpGC0zFYG1/rNmqHGx7R/WIKhk=; b=CZUuAjXEHecDHtnoDS0qT9h765
	0K2pa7Op+gLfFNqMD9AOtiAnxcn30MOMHHIh+CA6d8FmT17pxlmL0Js76Y6jKYPZLUIWwEJb65+UR
	dKyDYhGUG9huY0A9RiOwKmXkuSuLQoLXQxT2aXwSX6AhVmRwhfx3Puqwt3J3kuJNl90LWIByHMGaN
	jH82o9OluuvQnphnj+v88W992mZpRCIEvuNtS7HIDbr7AGnnb5g8899k3/JGgbSjqR7s8H7oeqvu9
	mflXpck7vj9capuLdo6CBewTvIPrBhuLptpEgprTgw2g4dfEeTsJkvy7xSO4u+uj+UJmePtSUrR4j
	XsA+LhKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiInT-005Jc8-PY; Tue, 11 Oct 2022 17:12:03 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiInQ-005JbF-HB
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 17:12:01 +0000
Received: by mail-pl1-f174.google.com with SMTP id z20so13793650plb.10
        for <linux-nvme@lists.infradead.org>; Tue, 11 Oct 2022 10:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGBOU35K+KpU1OIUsCpGC0zFYG1/rNmqHGx7R/WIKhk=;
        b=S2fWWB4Oo0FjVjhzmDj2baVwJKSxeoX5rFuBQcAv6TrjQRcfWbx3AP49UvEnfYTWzI
         L6NbOds+yJ2BhAL09WDbH9g4d22/ai846zVyC4xAnke6WRdGAN6xU/jqE6uM+gJhVPHL
         mgmb1Reos5a5091IdXt6Xa4nrhN/X0iGeR4p+OoGpelen1t09lUg8UcAcnG23YOmdQp4
         ZLvizKXO0WOUNoI54WR/hl4b9cUq/AeE+rPakkBizAYJ6Iy0p9H9A6XC1SXaS2+p8wmu
         wL3disCU+VP+9lp46EP6FzJ7DmK7cLFSZdWHS3+j0xtxOX2+oNs6pFqds1E/DOieFCN2
         vTWw==
X-Gm-Message-State: ACrzQf0U+8ngaMoMIrk/KKuCfjwiiMeWbDNCEtx4WsV0XyoGG818BnOe
	YSR7yMfhDo+6JujPMSzxlQs=
X-Google-Smtp-Source: AMsMyM4/i4Tq2e5dnGcCHubgr/jwsL0SEP1TPXXvOOMmOx8E+n4Q8HGaUcGsXsVndIXVwiifbhgAew==
X-Received: by 2002:a17:90b:4a50:b0:203:1204:5bc4 with SMTP id lb16-20020a17090b4a5000b0020312045bc4mr118096pjb.79.1665508317940;
        Tue, 11 Oct 2022 10:11:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9f77:abf2:346f:9b6e? ([2620:15c:211:201:9f77:abf2:346f:9b6e])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b00172e19c2fa9sm9031399plh.9.2022.10.11.10.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 10:11:57 -0700 (PDT)
Message-ID: <a9c60d24-7479-e32d-29a3-9f0dbcec767a@acm.org>
Date: Tue, 11 Oct 2022 10:11:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: lockdep WARNING at blktests block/011
Content-Language: en-US
To: Keith Busch <keith.busch@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Tejun Heo <tj@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <b6e9a4de-3200-f4c5-0665-8e919757035d@acm.org>
 <CAOSXXT7RVg8rNWP4cDwV6Ywtu1_DSZ=XhAyMkKrqS1uCi5UFKA@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAOSXXT7RVg8rNWP4cDwV6Ywtu1_DSZ=XhAyMkKrqS1uCi5UFKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_101200_599409_D68AB7FF 
X-CRM114-Status: GOOD (  20.32  )
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

On 10/10/22 06:31, Keith Busch wrote:
> On Fri, Oct 7, 2022 at 10:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 10/3/22 08:28, Keith Busch wrote:
>>> On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
>>>>
>>>> BTW, I came up to another question during code read. I found nvme_reset_work()
>>>> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
>>>> controller is already disabled when the reset work calls nvme_sync_queues().
>>>
>>> Right, everything previously outstanding has been reclaimed, and the queues are
>>> quiesced at this point. There's nothing for timeout work to wait for, and the
>>> sync is just ensuring every timeout work has returned.
>>>
>>> It looks like a timeout is required in order to hit this reported deadlock, but
>>> the driver ensures there's nothing to timeout prior to syncing the queues. I
>>> don't think lockdep could reasonably know that, though.
>>
>> Hi Keith,
>>
>> Commit b2a0eb1a0ac7 ("nvme-pci: Remove watchdog timer") introduced the
>> nvme_dev_disable() and nvme_reset_ctrl() calls in the nvme_timeout()
>> function. Has it been considered to invoke these two calls asynchronously
>> instead of synchronously from the NVMe timeout handler (queue_work())?
>> Although it may require some work to make sure that this approach does not
>> trigger any race conditions, do you agree that this should be sufficient to
>> make lockdep happy?
> 
> We still have to sync whatever work does the reset, so that would just
> shift which work the lockdep splat indicates.

Hi Keith,

It seems like my email was not clear enough? What I meant is to queue
asynchronous work from inside the timeout handler and to wait for the
completion of that work from *outside* the timeout handler. This is not a
new approach. As an example, the SCSI core queues abort work from inside the
timeout handler and only allows new SCSI commands to be queued after error
handling has finished. I'm not claiming that this approach should be followed
by the NVMe driver - I'm only mentioning this as an example.

Thanks,

Bart.

