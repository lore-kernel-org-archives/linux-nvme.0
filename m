Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8A8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 18:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SDUgzwF1MYpOKAYuMJLg2sJ5DHjLA2zzshxQ2LBlaw=; b=21nDewBAShvr0cVGQqP97CXQoi
	MTa4aiSTJDz9k/l6itsyEm4Avxi8Pw5Px7naZGfe9qDoDvO0+/nK3YES1/vubaHtVzAUUczlBzGG1
	ZFCWLqIc+rYJoMcxjuXsTb/1xq3tT5zFdBISg/svHSaPFdhfNc0v28MdY//xnvIwaiTrZY7uOtGvi
	tS+PjASJvusCNyP0cg9Y599xpmRpExhi+dRANRccamWV3GmwCJZ+ZggyUc/EcfCg+m1ydCR2mycP0
	nwolE7hVSw2aH9MbwBKP5qea1hYxWtELiOPd1rgnkNLvItydhBZowlTj9oy0foSzUcsC89NFuZF1u
	J7LbtJwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIEal-004gOr-7P; Thu, 10 Feb 2022 18:54:55 +0000
Received: from out1.migadu.com ([91.121.223.63])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIEah-004gMq-IK
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 18:54:53 +0000
Message-ID: <79b15466-4fe5-ec2b-5530-e5dbfff52f2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1644519286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SDUgzwF1MYpOKAYuMJLg2sJ5DHjLA2zzshxQ2LBlaw=;
 b=Cj6V3g1z+c2zakSOio6cOl9mjXUOx55J/eskpWaPON1f+kCnQUJ4TikXzusV2+6+4bdYHt
 zahBT+9pgJB1KUxxtP5MN3hiEBPQW6CsWnXTYzhtHayO2s5TefJbmtLEfWxovFotY+2mt2
 L4Tt2eq96r26NOtyCuoePRIBRxCgccA=
Date: Thu, 10 Feb 2022 11:54:24 -0700
MIME-Version: 1.0
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>, Len Brown <lenb@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 m.heingbecker@googlemail.com, linux-nvme <linux-nvme@lists.infradead.org>,
 Nirmal Patel <nirmal.patel@linux.intel.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
 <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
 <20220210182423.GB16171@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220210182423.GB16171@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_105451_965080_D9743FF7 
X-CRM114-Status: GOOD (  14.67  )
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



On 2/10/2022 11:24 AM, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 06:56:35AM -0800, Keith Busch wrote:
>> Apparently it works fine when you disable VMD, so sounds like the
>> acpi_storage_d3 is set, but we fail to find the correct acpi companion
>> device when it's in a VMD domain.
> 
> I guess the acpi_storage_d3 is set on the VMD device and we need
> to propagate that down the entire bus hanging off it.
This is all you needed to say

> 
> Which kinda makes sense in the twisted world where vmd was invented,
> given that vmd is Intel's evil plot so that only their Windows driver
> can bind to these devices, 
Is this relevant or necessary?


so the property also needs to be set on
> the vmd device.
> 
> Nirmal and Jonathan, can you help to sort this mess out?

