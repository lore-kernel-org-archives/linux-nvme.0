Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBAFE77183
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVmG5MyYdf3ILu7AGWa0nQR3zB0gut6OZjpcnC13n/Y=; b=UaYpJDN2QRxQ4nYIgNjojdOC+4
	eMElmeEIccAZ143Ju4CAbfcJiPQPX3EVcx53dPZFg2CwTLiCPn4hO9Pqjz/Drtxv7atqdsrGupWu5
	ntakyrK+nnxGyzoA5+FgVTmZLCd2FOu06mD1JYoztn2MqnkqagYHjPPwTmDWGBT0x6pfUkCPa/y0c
	CpvlC3I4K/L9d2r5mQruNAwr/qKADN3RtG1w9/RyKbhQJRfIueVmHptn/mvnAl5F4bi2Vf93Fh83N
	Tj5pP/V5SIJjqnHriSqhb+27VHhBhv8mxedBAxMVq7dblgtgSQmOsSNhFx/kEAzvdULf4Sxr4mCQD
	mx9qKFYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tND5y-0000000AQ6j-3hUI;
	Mon, 16 Dec 2024 15:33:18 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tND4t-0000000APy8-1uT8
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 15:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IVmG5MyYdf3ILu7AGWa0nQR3zB0gut6OZjpcnC13n/Y=;
  b=V93TAmhawi2MA4U2aqTySCVi9h+c3viWuO+m0SEZTjlUgmbpMXEo5Jfg
   BN5IosthvE61HV2lqSI9b0OSQB5+7WlWwQPxBCpY1a/yP5F3GPeemr8zo
   5B+1Spu6yOKWq8LVuX2/SQMMCea69DcoM2gJZJlw37QT+JM0fbvL7i3rO
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,238,1728943200"; 
   d="scan'208";a="104464928"
Received: from dt-aponte.paris.inria.fr (HELO [128.93.67.66]) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 16:32:10 +0100
Message-ID: <1db56eee-5d64-43f2-8595-4af98e54095a@inria.fr>
Date: Mon, 16 Dec 2024 16:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Add error path for xa_store in nvme_init_effects
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241202153921.55766-1-keisuke.nishimura@inria.fr>
 <20241212062852.GB5718@lst.de>
Content-Language: en-US
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
In-Reply-To: <20241212062852.GB5718@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_073211_787607_7D9699C4 
X-CRM114-Status: GOOD (  12.62  )
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



On 12/12/2024 07:28, Christoph Hellwig wrote:
> On Mon, Dec 02, 2024 at 04:39:22PM +0100, Keisuke Nishimura wrote:
>>   	if (!ctrl->effects) {
>> +		struct nvme_effects_log *effects, *old;
>> +
>> +		effects = kzalloc(sizeof(*effects), GFP_KERNEL);
>> +		if (effects)
>>   			return -ENOMEM;
>> +
>> +		old = xa_store(&ctrl->cels, NVME_CSI_NVM, effects, GFP_KERNEL);
>> +		if (xa_is_err(old)) {
>> +			kfree(effects);
>> +			return xa_err(old);
>> +		}
>> +		ctrl->effects = effects;
> 
> Please split this into a helper now that is becoming rather complex.
> 
> Otherwise this looks fine to me.

Thank you for the review. I will send the new version soon.

Keisuke

