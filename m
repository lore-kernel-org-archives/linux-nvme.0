Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2189C00528
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rejor5VrfY+TIm/rzrbpvQERzndRIFFXyoXL00ztDUM=; b=HmJjraymZWLfWTcfxc6PNcbDnT
	0kJGk95PauGIorSuajgATpoJhnp5V5aFHGFLoXN53ELsz4Y/8IVotp5WVTgL6phCzq/oFAweDqeXM
	hofmGhf/TgCcgy9fQcJZlTBPUNo917IDQb9zwM5sCwCVhtvxQN+CAu+zg8tMjr7twhGgGIvi45gPh
	G7AgBnfWfVHG2ITUB+qSDINmRHOKJMQ2/aGocTqpZe/ba40pu8nVqaHRF2jgkON4lxElfTdFQjKln
	+61k2zajJWp9uPaS+AH6Zpesgshpvg7eyfgXrKUayFUJ4j6aa/htYj/NP/vCsoPASFe8G4D2AHmh6
	ljCCT8sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJxot-003eV8-0f;
	Thu, 13 Jul 2023 15:01:27 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJxoq-003eUU-0N
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 15:01:26 +0000
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77dcff76e35so7985839f.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689260480; x=1691852480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rejor5VrfY+TIm/rzrbpvQERzndRIFFXyoXL00ztDUM=;
        b=pUaPzIrGY5YSCuztIITQ/6DoTPvKJKzV2/wKoWTJD7dCsARyGcfMrJHq2fcZWRlSgU
         XqnHq2s1yO64sq92I5sGrY9WacbZY9wzTThR2PMvsVDxDHcMphrwe2dnvaGSwEToylWv
         kFE9QJC928oBibLzayLMov6+xPY/WzSewhBSrGQiGY4f3W/iNPPjHQsQw3Kko33+nxS/
         /c5aWNNGxhimwxds3NBZshmdFK3Pcoaz8BGx1xtdDmapxv0R4UxdZkl4VBpuMXXCtvV7
         2jeTnA1neyHGsi4lUr8ElCU0gm93lje7HLtgs+qfGbIJtO6qoJ0v0NfUoqkCpgMKAxEo
         af7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260480; x=1691852480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rejor5VrfY+TIm/rzrbpvQERzndRIFFXyoXL00ztDUM=;
        b=SZ+XbZCNpa05MU3gwKI5Y0wRrwrizifzmIl1HqGcBkrwXbAv8HqkPiMvMoifg10PON
         Hu77OAlJ1f1d41S0CWISmyQOlP3TITZd1pUmics5khpwgf1Jr0FROwoi8FKT2YemOW+U
         LmZPnkUvw5VUH4fg8+AIGFeRTT716h2EBzLhSskQy8APMWZg+FE0wfXiuFIq+wXo8Sh1
         EnN8Q7mFUAexdc1AFmRPYI3m/PtS3kb6u/aDRTclFuc7TF3+yIo+DbsSUqcIQle4cZkG
         HNXQEtto+zNY/RL5nxZ0UCL4oaFPrml/iVya7kYDpMHrkc6uja6LqjxiUh6CNW02yXvu
         vRyA==
X-Gm-Message-State: ABy/qLYKktO4RCNkTA8DBx50yUkGUNtodw+w39p2C9owxPGIlwzDZK58
	jGVPey/9TxZk4DPVCLEehoDkPQ==
X-Google-Smtp-Source: APBJJlEiWy0hjZCyy5Zgpp/8s/O4ckH6afs3CBnXiA5pR/HCLioAk5Nl/fpqb9cOKRt9Ip4/3GcJGQ==
X-Received: by 2002:a05:6602:5c7:b0:787:1926:54ed with SMTP id w7-20020a05660205c700b00787192654edmr1781121iox.1.1689260480547;
        Thu, 13 Jul 2023 08:01:20 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a05660220d900b00783581fd200sm2013101ioz.20.2023.07.13.08.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:01:19 -0700 (PDT)
Message-ID: <aa5270de-3286-c3f3-75fe-f1b5ba1dfde4@kernel.dk>
Date: Thu, 13 Jul 2023 09:01:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme: don't reject probe due to duplicate IDs for
 single-ported PCIe devices
To: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <CGME20230713133859epcas5p2b0de1a117d69f54f2d1dcf027f73afef@epcas5p2.samsung.com>
 <20230713133042.3981-1-hch@lst.de> <20230713140156.GA2143@green245>
 <ZLAQPKOApKCg1LDu@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZLAQPKOApKCg1LDu@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_080124_351073_31E1855B 
X-CRM114-Status: GOOD (  12.90  )
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

On 7/13/23 8:54 AM, Keith Busch wrote:
> On Thu, Jul 13, 2023 at 07:32:06PM +0530, Kanchan Joshi wrote:
>> On Thu, Jul 13, 2023 at 03:30:42PM +0200, Christoph Hellwig wrote:
>>> While duplicate IDs are still very harmful, including the potential to easily
>>> see changing devices in /dev/disk/by-id, it turn out they are extremely
>>> common for cheap end user NVMe devices.
>>>
>>> Relax our check for them for so that it doesn't reject the probe on
>>> single-ported PCIe devices, but prints a big warning instead.  In doubt
>>> we'd still like to see quirk entries to disable the potential for
>>> changing supposed stable device identifier links, but this will at least
>>> allow users how have two (or more) of these devices to use them without
>>> having to manually add a new PCI ID entry with the quirk through sysfs or
>>> by patching the kernel.
>>
>> Should this go for backport? For the commit 2079f41ec6ffa.
> 
> Is it sufficient if I just append "Cc: stable..." to the commit message?

You probably want:

Fixes: 2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique")
Cc: stable@vger.kernel.org

and that should do the trick.

-- 
Jens Axboe



