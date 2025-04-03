Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A95C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bhVWt//b5MQhMSww4VsQj4VZ/Hr+hhUj7oNoEyoZMhY=; b=jjit0PVGshpek1G0PJK0Ax/Q+R
	h/yG7NhG+1O8J3wqayN2Ky0gK2l40QilTb7Kk/uO6nNe05E+UC7lpBOCF8Jlj68jr15eXM6ViwvOX
	BTN2VCVZJCwj6xXsZjg6GP6PfJKqmcxR7/MP51FtdxRSvB0t8kS2txaG56G3KlGkqdEywxImiMo1g
	xRZsKRoNXwJYfN8pv93XLqIlGD5AVh85afmuKFcr/HWVteClhMXwrkgDgqXv7e/UM5/+g6KqJ5nub
	oj/uubSvkvKpcWogxVeEEdYNdX1FuYIVDjV6nUX0TOQPhyD/FNTEbU9fLvnWIwZzyB+FPzKRh9iXx
	YkQQkNqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0EfD-000000082qM-0qGJ;
	Thu, 03 Apr 2025 07:06:59 +0000
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Ef9-000000082ol-3nmu
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:06:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743663940; bh=bhVWt//b5MQhMSww4VsQj4VZ/Hr+hhUj7oNoEyoZMhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GoTtDTcDAPDWHA7TbxhFgKccWxDHL5Gn3o4HV7+czHLkrsV60iMwnGdunFdoeuNqu
	 IltbHNQ6VJQHqIZaQDizp2VlwU5qQ9h1Q0sOvYY9ELkdsllQYTfd7lzYH28p7BpkQm
	 CdsQCf9wLhuy+7DZbOP7NKEAOWjut1fHJwv2qJH8=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 165AE892; Thu, 03 Apr 2025 15:05:37 +0800
X-QQ-mid: xmsmtpt1743663937twb6ozg5x
Message-ID: <tencent_D00C9DD2BF00258063B042172328396DB608@qq.com>
X-QQ-XMAILINFO: NUxwpkvPscRuoSR7hR69LKTJvUlW2/y5zdcPjjkuv7QVQ7Vuq1eguOMx2ABbgS
	 vXfD71YDHvZiUoo8293e1EHrdHZyUCnxcXqSidujhpbY6ogYhEVn/Isd1cgXGzMdTDGKHNDk+7ZR
	 GckBEgb9OGo01AdNhuxcColPDTkxyA1/H9CDrTs/kCa8L3/tqig9xKh84YcBjDIkwqF7CPsGO3v6
	 fdpM5T1niv7p3UEPG/tenB7sHvkslgHLtaOGgrRk9oQjOZGHgrrziMYJDwS2nu52I1tCBoRcltJL
	 +2txeS0B18HuPpfDGB7moMSuYZGaKo3jzF34WTq0an87X+YRFwaOsg4eg1A8oEsAiFO4+lUPpYx4
	 48L+CFod+bkAGdDQd73VdwMoc5lsKOTpjUb/tu0ETERqiwwKng9D9F6qJcQTJMSC88G7o92tVZn1
	 KK6ulDoAq0PB8bRq5T6mtm8C7FFCBaSlBRYpYnfeC9XaHTiF2IotulGTqWcd49wAN66MUVeplzkI
	 AkWk4FM7y6ewmzavrL67Ex0C2eo6W4exniOM9oQa6ARb0EEIV5HC9Abwf1cqd6yqmm/hGJcDdiIa
	 yOwxrA4NNFG3fPGlYZxif2iURtYcPV0crr9NUnaTVH1rfIPr5T8Nn9VUNjwj5ChN3yP2dnqML8QJ
	 ud6VIIppS4TQN43XRg2dIGHGCFFzC466xWAOBAT+KbITU6BnF4zirOKmQSldRvAZD2bzRIvmETo9
	 1V0Fxr32aq1wHXLx7m+3qk8qHVs7upHtZ3jM80x9BoSa9NdL2niGqpubWG2oPw8DozJZXc6WqjMg
	 CQseCddLuks/pF2pZbig3bGVXSAx/TBBEkICrjNPlI5aAsYm1gjEZiTrF3wCjoWrjUNPHjUs3O3e
	 2wTHZHJEMrX+Uwt3ehCHk3uq1irq3s9PYmEWGzXgZRs+UVyQK2bDxHRylIgiZIgZ0e0C1oO4C9H+
	 eqCStb7pEYOn+7d66Z8w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <2895d817-0316-4df3-9253-347e87bcb953@qq.com>
Date: Thu, 3 Apr 2025 15:05:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nvme: Add sysfs interface for APST configuration
 management
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 chaitanyak@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>,
 alexey.bogoslavsky@wdc.com
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
 <20250403042504.GB22360@lst.de>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <20250403042504.GB22360@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_000656_516892_133AA368 
X-CRM114-Status: GOOD (  15.64  )
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



在 2025/4/3 12:25, Christoph Hellwig 写道:
> On Tue, Apr 01, 2025 at 05:22:06PM +0800, Yaxiong Tian wrote:
>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>
>> This series enhances NVMe APST (Autonomous Power State Transition) support by:
>> 1. Adding warnings for PST table allocation failures
> 
> That looks fine.
> 
>> 2. Exposing APST tables via sysfs for runtime inspection
>> 3. Providing per-controller sysfs interface for APST configuration
> 
> Who is going to use this and how?  We'll need proper tools for that,
> and in general I'd prefer to have a common set of policies for APST
> configurations and not random people coming up with lots of random
> policies.

These two patches don't fundamentally change the APST configuration 
policy, but rather enable users to configure various APST parameters in 
real-time across different devices. As mentioned in commit 
<ebd8a93aa4f5> ("nvme: extend and modify the APST configuration algorithm"):

1）This patch only introduces partial functionality from the Windows 
driver - it doesn't enable dynamic regeneration of the APST table when 
switching between AC power and battery power.

2) Additionally, using default configurations on certain brand SSDs has 
been observed to increase power consumption.

Therefore, when a system contains multiple drives and users require 
different configurations for AC vs battery power scenarios, real-time 
APST configuration updates across different devices become necessary.It 
must be said that configuring these parameters is difficult for average 
users, but they can still use the original default settings. However, 
for advanced users looking to optimize their devices, this provides them 
with the necessary interface.

As for providing suitable tools for users, I suppose every advanced user 
has their own preferences and approaches. For example, one could trace 
device idle time statistics through trace events (e.g., nvme_complete_rq 
→ nvme_setup_cmd) and use that data as a reference to configure 
apst_primary_timeout_ms.

For example，The device idle time distribution under specific operating
conditions is shown below (unit: nanoseconds):
We can set apst_primary_timeout_ms to 32ms, which ensures that over 99% 
of NVMe commands remain unaffected by APST.

@intervals:
[512, 1K)            749 |@@@@@@@@ 
    |
[1K, 2K)            4856 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2K, 4K)            1002 |@@@@@@@@@@ 
      |
[4K, 8K)             756 |@@@@@@@@ 
      |
[8K, 16K)            413 |@@@@ 
      |
[16K, 32K)            36 | 
      |
[32K, 64K)            14 | 
      |
[64K, 128K)            9 | 
      |
[128K, 256K)          13 | 
      |
[256K, 512K)           8 | 
      |
[512K, 1M)             4 | 
      |
[1M, 2M)               4 | 
      |
[2M, 4M)               3 | 
      |
[4M, 8M)               4 | 
      |
[8M, 16M)              3 | 
      |
[16M, 32M)             0 | 
      |
[32M, 64M)             6 | 
      |
[64M, 128M)            5 | 
      |
[128M, 256M)           5 | 
      |
[256M, 512M)          15 | 
      |
[512M, 1G)             7 | 
      |







