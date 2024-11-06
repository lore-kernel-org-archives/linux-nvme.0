Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BB5D44D55
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yOvDmzRVm17HSfUB7OCeIYPYOw1M1SKbg3z2X9WtJK0=; b=OSKtjuo3GYTMSRuWbfLgTcxNWU
	NjPjaYtCyTRFsP3UMJrZTX8t1C2olcnX2eqZFVq9o/inCzIIIEIS0QYaZIyyGyF86c+3QxLaHL6Pu
	JMLUMiWOjrQXnaBlozBa9EqPHux0MLFk0udUoNzy45kq6kNAtd6Y0b0hNgFpMP2BZxLxFp5gVadtH
	3LpbtuN3/npvVtelp+d6rGc6b2ubidFIwo3O92RoF335ByU1SgVU1PB1iXIOitm47TqPwgcm15Pce
	9wrpZS+GBlpUc2C4Gsiz0u00bYw711XXcnSVk9iTKUutuxa76gZ1tOBXYhP/gDahI9WPR0nC+Q2cf
	hmkLGWxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ePk-00000002xYh-24JY;
	Wed, 06 Nov 2024 11:41:32 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8dZl-00000002nlN-3nnJ
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 10:48:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730890067; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yOvDmzRVm17HSfUB7OCeIYPYOw1M1SKbg3z2X9WtJK0=;
	b=Bytt7aTokbKRYIVf++Q47/lK5UF5DceFXw4CgidXQyZMKlNvV0ShjNB/e2UjP+viGV4qfIIENoB+hxfoFvE33NRO6WwBVsLUFAQhHgNo3aoIqqQkIlHS7Bz+UevjnvuvuCSL289YpobRVp7G/q3BXmVtEf2xeQ9Ntq4QNTAQG4g=
Received: from 30.178.82.24(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIqyuuX_1730890064 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 18:47:45 +0800
Message-ID: <dd51a183-6313-454e-afeb-c00f0cb02f30@linux.alibaba.com>
Date: Wed, 6 Nov 2024 18:47:43 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] nvme: check at least one ns identification reported
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20241104031418.121235-1-kanie@linux.alibaba.com>
 <20241104131529.GA14373@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241104131529.GA14373@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_024750_149923_CA32E782 
X-CRM114-Status: UNSURE (   6.66  )
X-CRM114-Notice: Please train this message.
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


在 2024/11/4 21:15, Christoph Hellwig 写道:
> On Mon, Nov 04, 2024 at 11:14:18AM +0800, Guixin Liu wrote:
>> Per the NVMe spec after 1.3:
>>    At least one Namespace Identification Descriptor identifying the
>>    namespace (i.e., NIDT field set to 1h, 2h, or 3h).
>> Check there is at least one reported.
> What problem does this try to solve?

I assume that the dm-multipath will not recognize nvme device if nothing 
to return,

I was wrong, ignore this path plz.

Best Regards,

Guixin Liu


