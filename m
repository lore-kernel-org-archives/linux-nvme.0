Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2627EC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DyKgBzjK0XYaJtD5IfqS+l++41SHH7DN8qVbXN4va7w=; b=RzdTNIYlKmD/L2LbLrxASjWpQE
	W+MeNmqj49cGHTGp130cBkXgrM3jtGJL4bn7TWCOeO9zzXDSg0BqSAEzctJNpsSiTkYULsyNaXn4i
	CzrS0v/ll4NlHr8eCIAkzB5VCOazS8wbrTrVC+SryEexT8ZVayy10EDlI1W65B26DNceAody298ah
	tfKW8OoLDBsxfo7ArD0nX2bpW21hwdvjerkzLsCXOt0hn/A6ZF7uTGPO2CATrcHwT6qE9rVDXvd//
	oCCwVtGGh5nIYu0Xk9JYVm115xvMqZcq1ZnezYEhbqdK2z0N6jrdQcLZdqiFTfn+dH/fE8DT/5E90
	sd8LnihA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU6rt-0096hb-DZ; Tue, 15 Mar 2022 13:05:41 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU6rq-0096fp-5g
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 13:05:39 +0000
Received: by mail-wr1-x429.google.com with SMTP id x15so28804218wru.13
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=DyKgBzjK0XYaJtD5IfqS+l++41SHH7DN8qVbXN4va7w=;
 b=yq9CMIxJat4GRvE8HUc1kvjBNym+aJNh1/fvVt/r9Caz/e9ORsO+Wg6ipcxggxdxiG
 r7SzCpa+TP1ursPRlnDM6HDPR1vPWHF1157XnWf6WYE7UR7vULenKhloy4HNteeJ/7Xx
 tbUh/3RVOWKe1sJWMlMXbNmdZfymJ7hv5CeoO24hjOXxhzFfOk7/O+As15NCD8SgyXFm
 AqkbZX8UMhAQJbGJGvzfBEnQ3SvB12u9pPy8R6rZEjBMvrHWt1fAUEQ8dsTYpeB48ioP
 /GxEwUDuMekM8Q7wg6e5MN9JSwhja+talLUFw4UMK5xRIgIFK+wY6h+TfhUTjLTjhgdq
 Qgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DyKgBzjK0XYaJtD5IfqS+l++41SHH7DN8qVbXN4va7w=;
 b=68mfNk068iuNGGTEINIimq8gGchz8ENDUYE3wg7LNRWvfA7cB6Qf5O9NJK0/qIRBri
 dH6f/IYkNkHxgf2ZrqR4TaLqawCA/cSDPiLTiJ52kfotGIq6wobf3mJqW20pKOoi6gvC
 gCP5dV1ZwbNjPVd2tpgYi12fIwLT9luPOTFhUtDbNbgGJ2nRS5/1+pHmswiEbBTFgiiH
 GaPU7u6ZnLugnO+ptjUuj/XolcLL+bUblyfaBf5eMJD8egYJfKaPboVnjuIzk6MK+Fjz
 olVL+vwSjDOKsjg0K0QyHs68KWneVufXDHjfZh8f79WVohUJFSn32USfxbvSMA2tG7cN
 HLpQ==
X-Gm-Message-State: AOAM5309YdfGFjMD4R3uyHC6X2oW8YiugZZ8eSubteMfga6D0G8Yb8Ui
 0LMDyJBTSv/RAlEa34qd/7Q9LQ==
X-Google-Smtp-Source: ABdhPJyJ2NZCPafvDbyKnuO8tTOOdfz0MZUCrFh95IVkr7wyl5iRQgR3NicAOvGezNb83DaTqUFYJA==
X-Received: by 2002:a5d:648d:0:b0:203:d7aa:83d2 with SMTP id
 o13-20020a5d648d000000b00203d7aa83d2mr1670404wri.422.1647349535660; 
 Tue, 15 Mar 2022 06:05:35 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a05600c348e00b00389ab74c033sm2192839wmq.4.2022.03.15.06.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 06:05:34 -0700 (PDT)
Date: Tue, 15 Mar 2022 14:05:34 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
References: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_060538_292945_4EF53A97 
X-CRM114-Status: GOOD (  42.95  )
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

On 15.03.2022 12:32, Matias Bjørling wrote:
>> >Given the above, applications have to be conscious of zones in general and
>> work within their boundaries. I don't understand how applications can work
>> without having per-zone knowledge. An application would have to know about
>> zones and their writeable capacity. To decide where and how data is written,
>> an application must manage writing across zones, specific offline zones, and
>> (currently) its writeable capacity. I.e., knowledge about zones and holes is
>> required for writing to zoned devices and isn't eliminated by removing the PO2
>> zone size requirement.
>>
>> Supporting offlines zones is optional in the ZNS spec? We are not considering
>> supporting this in the host. This will be handled by the device for exactly
>> maintaining the SW stack simpler.
>
>It isn't optional. The spec allows any zones to go to Read Only or Offline state at any point in time. A specific implementation might give some guarantees to when such transitions happens, but it must nevertheless must be managed by the host software.
>
>Given that, and the need to not issue writes that spans zones, an application would have to aware of such behaviors. The information to make those decisions are in a zone's attributes, and thus applications would pull those, it would also know the writeable capability of a zone. So, all in all, creating support for NPO2 is something that takes a lot of work, but might have little to no impact on the overall software design.

Thanks for the clarification. I can attest that we are giving the
guarantee to simplify the host stack. I believe we are making many
assumptions in Linux too to simplify ZNS support.

This said, I understand your point. I am not developing application
support. I will refer again to Bo's response on the use case on where
holes are problematic.


>
>> >
>> >For years, the PO2 requirement has been known in the Linux community and
>> by the ZNS SSD vendors. Some SSD implementors have chosen not to support
>> PO2 zone sizes, which is a perfectly valid decision. But its implementors
>> knowingly did that while knowing that the Linux kernel didn't support it.
>> >
>> >I want to turn the argument around to see it from the kernel developer's point
>> of view. They have communicated the PO2 requirement clearly, there's good
>> precedence working with PO2 zone sizes, and at last, holes can't be avoided
>> and are part of the overall design of zoned storage devices. So why should the
>> kernel developer's take on the long-term maintenance burden of NPO2 zone
>> sizes?
>>
>> You have a good point, and that is the question we need to help answer.
>> As I see it, requirements evolve and the kernel changes with it as long as there
>> are active upstream users for it.
>
>True. There's also active users for SSDs which are custom (e.g., larger than 4KiB writes required) - but they aren't supported by the Linux kernel and isn't actively being worked on to my knowledge. Which is fine, as the customers anyway uses this in their own way, and don't need the Linux kernel support.

Ask things become stable some might choose to push support for certain
features in the Kernel. In this case, the changes are not big in the
block layer. I believe it is a process and the features should be chosen
to maximize benefit and minimize maintenance cost.

>
>>
>> The main constraint for (1) PO2 is removed in the block layer, we have (2) Linux hosts
>> stating that unmapped LBAs are a problem, and we have (3) HW supporting
>> size=capacity.
>>
>> I would be happy to hear what else you would like to see for this to be of use to
>> the kernel community.
>
>(Added numbers to your paragraph above)
>
>1. The sysfs chunksize attribute was "misused" to also represent zone size. What has changed is that RAID controllers now can use a NPO2 chunk size. This wasn't meant to naturally extend to zones, which as shown in the current posted patchset, is a lot more work.

True. But this was the main constraint for PO2.

>2. Bo mentioned that the software already manages holes. It took a bit of time to get right, but now it works. Thus, the software in question is already capable of working with holes. Thus, fixing this, would present itself as a minor optimization overall. I'm not convinced the work to do this in the kernel is proportional to the change it'll make to the applications.

I will let Bo response himself to this.

>3. I'm happy to hear that. However, I'll like to reiterate the point that the PO2 requirement have been known for years. That there's a drive doing NPO2 zones is great, but a decision was made by the SSD implementors to not support the Linux kernel given its current implementation.

Zone devices has been supported for years in SMR, and I this is a strong
argument. However, ZNS is still very new and customers have several
requirements. I do not believe that a HDD stack should have such an
impact in NVMe.

Also, we will see new interfaces adding support for zoned devices in the
future.

We should think about the future and not the past.


>
>All that said - if there are people willing to do the work and it doesn't have a negative impact on performance, code quality, maintenance complexity, etc. then there isn't anything saying support can't be added - but it does seem like it’s a lot of work, for little overall benefits to applications and the host users.

Exactly.

Patches in the block layer are trivial. This is running in production
loads without issues. I have tried to highlight the benefits in previous
benefits and I believe you understand them.

Support for ZoneFS seems easy too. We have an early POC for btrfs and it
seems it can be done. We sign up for these 2.

As for F2FS and dm-zoned, I do not think these are targets at the
moment. If this is the path we follow, these will bail out at mkfs time.

If we can agree on the above, I believe we can start with the code that
enables the existing customers and build support for butrfs and ZoneFS
in the next few months.

What do you think?


