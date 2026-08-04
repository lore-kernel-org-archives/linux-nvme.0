Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263BFC55184
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 02:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZhiPf9cJ1HH2CxIeFyPuCfERr+Au7kx4Q9+p5aYigs=; b=Z/I6OCpv6K54C2MwcJ8jsmdnlZ
	ba/pZK1p3uPmBfYsxrb2zzp7PvOuIURmxm78XjJ6HZvBd4eTWktSW7huM9YtiVmDFxomMWigUCH1A
	xiQSB0HJPjYJdg6cbQ/eswcA1n5EPpdd+6zfkKdS/YlMQlTAorjPg9VE+FOHC0vfqZ7adQXbMkojV
	TueWcM7TG9YW8vzvGBqag+3x07yR0VQxghOTfidBbkxCTLhVeTuuzljPi4nJ2nz8oV90tDUPuVVjD
	0aKB5DNg8ZgtKRcbXa6fzgQEpm8M1XxrUbxptVZehvNlZxeTLcgcN5UfHIkkuWWHPmT1LnKw8P3+z
	krK93umg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr51t-00000000r2I-3uV0;
	Tue, 04 Aug 2026 02:37:21 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr51r-00000000r1h-0TGk
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 02:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785811037; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KZhiPf9cJ1HH2CxIeFyPuCfERr+Au7kx4Q9+p5aYigs=;
	b=AIeHtUYiaxMX91OrU8yv7MCM1W47fexAaIzoaYo+Bg+2LiIt2loCgG/IoLBgL+fCCYPFDETLNc3w3VeTWgLLSX8IaYqD/zEdQCOBP0YtkfQEDtNmBdlJx1y+4Zj1KhNrIwjH75KhA/R2EuMsu2kjbUtORuYodv8oa+Oc7Jj05vc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8ME9I8_1785811035;
Received: from 30.178.84.68(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8ME9I8_1785811035 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 10:37:16 +0800
Message-ID: <b1fd3b10-11ec-4861-806d-b5951e1e7d94@linux.alibaba.com>
Date: Tue, 4 Aug 2026 10:37:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/070: add a test for Identify CNS 07h NULL
 pointer dereference
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20260731032601.1100664-1-kanie@linux.alibaba.com>
 <6f4a1b76-50f4-45f8-9a56-e6f66637d7e7@linux.ibm.com>
 <anAUf3S78MSSr-LJ@shinmob>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <anAUf3S78MSSr-LJ@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_193719_351754_B2C64C70 
X-CRM114-Status: GOOD (  11.01  )
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



在 2026/8/3 12:14, Shin'ichiro Kawasaki 写道:
> On Aug 01, 2026 / 19:31, Nilay Shroff wrote:
>> On 7/31/26 8:56 AM, Guixin Liu wrote:
>>> +test() {
>>> +	echo "Running ${TEST_NAME}"
>>> +
>>> +	_setup_nvmet
>>> +
>>> +	_nvmet_target_setup
>>> +
>>> +	_nvme_connect_subsys
>>> +
>>> +	local nvmedev
>>> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
>>> +
>>> +	# CNS 07h == Active Namespace ID list for the specified I/O Command Set.
>>> +	# CDW10 bits[7:0] hold the CNS; CDW11 bits[31:24] hold the CSI (0 == NVM).
>>> +	# Request from NSID 0 so the enabled namespace (NSID 1) is listed, which
>>> +	# is exactly the condition that used to dereference the NULL req->ns.
>>> +	if ! nvme admin-passthru "/dev/${nvmedev}" --opcode=0x06 \
>>> +		--namespace-id=0 --cdw10=0x07 --cdw11=0 --data-len=4096 -r \
>>> +		>> "${FULL}" 2>&1; then
>>> +		echo "Error: Identify CNS 07h failed"
>>> +	fi
>> The nvme admin-passthru ... works but why instead not use the existing
>> "nvme list-ns /dev/<nvmedev> --csi=0 ?
> The patch looks good to me. I also confirmed that the test case recreates the
> NULL pointer dereference that the kernel patch "nvmet: fix NULL pointer
> dereference in nvmet_execute_identify_nslist()" fixes. Good.
>
> I also confirmed that "nvme list-ns /dev/<nvmedev> --csi=0" can recreate the
> NULL pointer dereference. I'm okay either way admin-passthru or list-ns. I
> would like to know Guixin's view about it.

I think nvme list-ns /dev/<nvmedev> --csi=0 is better, I will change this in v2, thanks.

Best Regards,
Guixin Liu



