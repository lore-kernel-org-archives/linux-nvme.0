Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54017C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 15:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xbs94pgAr6d26kh4ZkL/FOyE1X0en+94P1wF5dstScY=; b=39s41/gA2QXNc24EVmczkGm1N4
	pjYC+LkhU3fN2MMBciZ1bfwEd/GkG0sd7OHmIA0xfsaEX3FiAt6jG2upg8qiaTTaKYWm1QqmZux2/
	+4SECYBuX4T7K7RraFO7xWYTNWOzzFuTByiUwXUEq9zAla+1jme9vtnYhQgFl3+mWdww+pz2uYfFH
	AK4y1lZE7Y16EoGrsrQypIVo2uC7vjeLVTyCVxA+qmeTvVzReVc25D00lPDLGHwgkk/TLWqQ7d7e4
	Z1LBaZokRiBqpRLLJ9Pid4O3kXZyUNHbuoUijfiRtYZKKrv8+Gf288EmBPEksrcw/RMsseN8secwX
	ZrXd3W9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU8pU-009fRB-NH; Tue, 15 Mar 2022 15:11:20 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU8pQ-009fPA-G6
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 15:11:18 +0000
Received: by mail-ed1-x534.google.com with SMTP id g20so24607052edw.6
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Xbs94pgAr6d26kh4ZkL/FOyE1X0en+94P1wF5dstScY=;
 b=MPsGdg239VV6aADSuvc7wcuF4+xuED3y00LONqqUMOOqkG7hI9BNpNJ2tSdl65cD8s
 DOKAZQFI3Gc0D84JYPbRcFHyUySvh8RM5B0inkurWrFVfRtnUMfv40NiQX7/uBHqFLdx
 Xj9M+gnI0uTDazsGC/xjEP25ea5M1VfbWldJMY1gwbHQmub2TF3MLDnM7Y55s7ZqVXGT
 9vcHawkUBkHfH5JJgN0b1V0m9rrvfI3KsGpI41isX+QFe4R9Q4IaVJ4Xc3brvCMy4L8Q
 oE/mWEJMj4MloUNkIxKt0+AZBTRZDNOrVBJ1EY3GhFtw03p/KGHs+eDf8eML0K3rV6Y0
 n1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Xbs94pgAr6d26kh4ZkL/FOyE1X0en+94P1wF5dstScY=;
 b=cqQUHL/6mAGwrzJzZPmF1HJPIuMYJ9sSD6GQHmolennqKAO5zRkR+6wIRQDBFsDtbY
 epEy1iSQL95Off32uA9WCNwAfkLu/1v3/uS6BXBE7g4cv8rPrt1hrwPxvJvUw6OuyWsF
 1462zn8NeTcVzq1reLG3C8e+jkGTsBXAZTXH2mqitpuhGR7yg7U5+Zvn1FUpk8nt38ST
 QsRiulaqHl54A+rJD3BEjL3auMCoEwcjC0u6eZkSs+un5PogYsQ6sZYV+MgLaLho9f/n
 7q2tbJr4n603cAVUcWpOQuRjUzHwiqIUd74pOnuRelrZB94VYVZ49bNyo77vH2r8Phb2
 NRBQ==
X-Gm-Message-State: AOAM533fh/QzBjxO1a1UtDMrOQcknDZSq87forbt1pzmUbSbsUXBVt17
 vsuMpNMweukOq36yRYBkxV8UEQ==
X-Google-Smtp-Source: ABdhPJxWm4DexO8aldPYblCK2E4OP07WJOcqFYNyVLfZ67k2vZEOO+Q65ku6NMtFdvD0cJAhqb+yrA==
X-Received: by 2002:a50:d79d:0:b0:415:d5a1:2a13 with SMTP id
 w29-20020a50d79d000000b00415d5a12a13mr25897105edi.375.1647357074620; 
 Tue, 15 Mar 2022 08:11:14 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a170906289500b006d144662b24sm8142436ejd.152.2022.03.15.08.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 08:11:14 -0700 (PDT)
Date: Tue, 15 Mar 2022 16:11:13 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315151113.6xvepugdoes7l23a@unifi>
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <20220315135245.eqf4tqngxxb7ymqa@unifi>
 <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_081116_652558_0ADF53AA 
X-CRM114-Status: GOOD (  29.10  )
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

On 15.03.2022 14:14, Johannes Thumshirn wrote:
>On 15/03/2022 14:52, Javier González wrote:
>> On 15.03.2022 14:30, Christoph Hellwig wrote:
>>> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
>>>> but we do not see a usage for ZNS in F2FS, as it is a mobile
>>>> file-system. As other interfaces arrive, this work will become natural.
>>>>
>>>> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
>>>> still do the work in phases to make sure we have enough early feedback
>>>> from the community.
>>>>
>>>> Since this thread has been very active, I will wait some time for
>>>> Christoph and others to catch up before we start sending code.
>>>
>>> Can someone summarize where we stand?  Between the lack of quoting
>>>from hell and overly long lines from corporate mail clients I've
>>> mostly stopped reading this thread because it takes too much effort
>>> actually extract the information.
>>
>> Let me give it a try:
>>
>>   - PO2 emulation in NVMe is a no-go. Drop this.
>>
>>   - The arguments against supporting PO2 are:
>>       - It makes ZNS depart from a SMR assumption of PO2 zone sizes. This
>>         can create confusion for users of both SMR and ZNS
>>
>>       - Existing applications assume PO2 zone sizes, and probably do
>>         optimizations for these. These applications, if wanting to use
>>         ZNS will have to change the calculations
>>
>>       - There is a fear for performance regressions.
>>
>>       - It adds more work to you and other maintainers
>>
>>   - The arguments in favour of PO2 are:
>>       - Unmapped LBAs create holes that applications need to deal with.
>>         This affects mapping and performance due to splits. Bo explained
>>         this in a thread from Bytedance's perspective.  I explained in an
>>         answer to Matias how we are not letting zones transition to
>>         offline in order to simplify the host stack. Not sure if this is
>>         something we want to bring to NVMe.
>>
>>       - As ZNS adds more features and other protocols add support for
>>         zoned devices we will have more use-cases for the zoned block
>>         device. We will have to deal with these fragmentation at some
>>         point.
>>
>>       - This is used in production workloads in Linux hosts. I would
>>         advocate for this not being off-tree as it will be a headache for
>>         all in the future.
>>
>>   - If you agree that removing PO2 is an option, we can do the following:
>>       - Remove the constraint in the block layer and add ZoneFS support
>>         in a first patch.
>>
>>       - Add btrfs support in a later patch
>
>(+ linux-btrfs )
>
>Please also make sure to support btrfs and not only throw some patches
>over the fence. Zoned device support in btrfs is complex enough and has
>quite some special casing vs regular btrfs, which we're working on getting
>rid of. So having non-power-of-2 zone size, would also mean having NPO2
>block-groups (and thus block-groups not aligned to the stripe size).

Thanks for mentioning this Johannes. If we say we will work with you in
supporting btrfs properly, we will.

I believe you have seen already a couple of patches fixing things for
zone support in btrfs in the last weeks.

>
>Just thinking of this and knowing I need to support it gives me a
>headache.

I hope we have help you with that. butrfs has no alignment to PO2
natively, so I am confident we can find a good solution.

>
>Also please consult the rest of the btrfs developers for thoughts on this.
>After all btrfs has full zoned support (including ZNS, not saying it's
>perfect) and is also the default FS for at least two Linux distributions.

Of course. We will work with you and other btrfs developers. Luis is
helping making sure that we have good tests for linux-next. This is in
part how we have found the problems with Append, which should be fixed
now.

>
>Thanks a lot,
>	Johannes


