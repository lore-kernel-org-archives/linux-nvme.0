Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A65CFC504
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pk/cIx4lL+V3Pcxsjkos1iArKVqfXGKQPEaz9DMkrCQ=; b=HcoH5lph7QgZYeYHc65JUfGwIe
	dYsHpUT/JbKA2RPKzmTZSPTlePfTizATCjUXj7uvA/3FUQDlc1/2OcjWGsYmulndQZyB++aMJwrPu
	NIKCcStjKp45XsBfgz96BqhNgY5U2K3Ggy4HFNO4BbUGqJFht8MmSOgx1o/VKkM2JJwDteEyio3a4
	eZYEjPS0KZjbXs3y5eEJ9pHBm4sf9D2SviWpYLwbQ/4HnWrboI4TnHVFqnZhm0D6Chkx1YyHTz1gk
	fK+r9dgnYBKB88JMgJcrW0whPBD+LusjHjlpGy9chijZoFwUrjNC+ywnBbEepXeVhFReDrxcJoUFu
	9tcoXNIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Gpx-00000004N4E-1Jn5;
	Mon, 14 Oct 2024 08:53:57 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Gfq-00000004KSk-2HR1
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 08:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728895408; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pk/cIx4lL+V3Pcxsjkos1iArKVqfXGKQPEaz9DMkrCQ=;
	b=GsI0YeLwswjcyKmKIxyy05XxfD+nXVJqxAyR04CNt98MXL+t93cnf+ireR9rRwwFaKpOMBM80j7hLGdTtZGNKafGQkDlNPSezstSOvV7ym/dek6Oeh0oKfIQyjAiRs3pvrJNSIrgKF8xFNhUaKHMrBkWrZOtMsX0NclwpwTzmck=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH3kfbt_1728895405 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 16:43:26 +0800
Message-ID: <d70e2172-6305-4ec9-ab09-f2421e536cbd@linux.alibaba.com>
Date: Mon, 14 Oct 2024 16:43:24 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-3-kanie@linux.alibaba.com>
 <4f6fac7b-2ef7-4255-94d1-9387f4110765@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <4f6fac7b-2ef7-4255-94d1-9387f4110765@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_014330_754612_B7F14E1B 
X-CRM114-Status: GOOD (  10.11  )
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


在 2024/10/14 15:23, Daniel Wagner 写道:
> On Sat, Oct 12, 2024 at 07:11:57PM GMT, Guixin Liu wrote:
>> +requires() {
>> +	_nvme_requires
>> +}
> It's probably a good idea to test if the reservation feature is
> available, otherwise this test just fails on older kernels.

I checked the exists of resv_enable,

"if [[ -f "${ns_path}/resv_enable" ]] ; then", if not exist, skip this

test case.

>> +Running nvme/054
>> +Register
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 0
>> +rtype     : 0
>> +regctl    : 0
>> +ptpls     : 0
>> +
>> +NVME Reservation  success
> I think this is a bit fragile, because the output of the nvme command
> might be extended or reformatted (obviously not on purpose but happens).
> I'd recommend to explicitly check for the expected values in the test.

OK, I will add a "grep -E "xxx|xxx|xxx" " to filter the result we cared now.

Best Regards,

Guixin Liu


