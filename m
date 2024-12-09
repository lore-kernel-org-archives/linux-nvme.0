Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72155E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 01:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6H8UYBpi3RLqB/YI5BIcxsaeHvSJOKb+bemUYC8zXQ=; b=axRrNKboRZvRSe6tfE0aqMbird
	J4m1crn+MPFqBDA9awDLzQIVJmLlx6uMV5Ur+uNLlEGICJBJl00n1ssTNu0hVhqUWOQKLGIXgJmHL
	ag2qu+kzHAov7xDiHB8JATBb3cIywF3Vf9HoSoQqKPDE0LluGdAnZg8j5smrXN8/sCxXkdR16jgd1
	l4ba85CISSThk9G6GWTZru8fhjFIsO2Rk4ltLuWr85O2NIm80YCJVGzV0iKq+Q4Gc6T3G9i6kazPs
	6/zLEMYTGc1rK9IH/s3ufo0tu7n3/KLMqS9RZGHDSgg9VlR3yy0LItJa6XX6UAHbKtNVRsg1eQRJ/
	V539S/BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKSfJ-000000068lK-39Dx;
	Mon, 09 Dec 2024 01:34:25 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKSfG-000000068ko-2be1
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 01:34:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733708057; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/6H8UYBpi3RLqB/YI5BIcxsaeHvSJOKb+bemUYC8zXQ=;
	b=meuCik77WbZkFn0OASy3PDMO3WxOz/Qw8oV/B7MsMCXfkua6Q9niLSqhgr4Jcm6zSb0AZGY9vWw0rPUH/7gwzwefqp/DvoFhSBi0Hqq5y1/LA7eLQ7W6PyRAPqBiV2OQTjBFXg3QCQwx/PGy+a0YPs0sV/lBChOI9bqZHcRz5r4=
Received: from 30.178.82.25(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WL1R4D7_1733708054 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 09:34:15 +0800
Message-ID: <72dc2f3a-3c90-44f1-b497-2f60bde06f96@linux.alibaba.com>
Date: Mon, 9 Dec 2024 09:34:13 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH separete v2] docs, nvme: introduce nvme-multipath document
To: Jonathan Corbet <corbet@lwn.net>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org
References: <20241206072507.37818-1-kanie@linux.alibaba.com>
 <87frn0vpn1.fsf@trenco.lwn.net>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <87frn0vpn1.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_173423_155504_7AD38BE9 
X-CRM114-Status: GOOD (  14.29  )
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


在 2024/12/6 22:42, Jonathan Corbet 写道:
> Guixin Liu <kanie@linux.alibaba.com> writes:
>
>> This adds a document about nvme-multipath and policies supported
>> by the Linux NVMe host driver, and also each policy's best scenario.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>> Hi,
>>    We found that we should take care of the throughput of each path in
>> service-time policy, so separate the doc patch. And continue working
>> on service-time policy patch.
>>
>> Changes from v1 to v2:
>> - Remove service-tome policy.
>>
>>   Documentation/nvme/nvme-multipath.rst | 72 +++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>   create mode 100644 Documentation/nvme/nvme-multipath.rst
> Thanks for working to improve our documentation.
>
> When you add a new file, you need to add it to the relevant index.rst
> file as well; if you had run a docs build, you would have seen a warning
> about this.
>
> I would also suggest that this material perhaps belongs in the admin
> guide rather than in its own directory?
>
> Thanks,
>
> jon

Thanks, I dont know how documentation works, my bad, changed in v3.

Best Regards,

Guixin Liu


