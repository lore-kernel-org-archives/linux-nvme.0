Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C30C5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1GRrOlyN9nkOUdimeoCQpzY7og1lchpuM501N4iN80=; b=p9o2YWp4RiKxM4vC0oDMSZZEjc
	WHXJcWXbeZ8ZvSyC4x4e1UCx7mqAhfkUVBa/pi8VRk5NYsxi5vG7rJvS3+pmJ+hTniecjfNmVIn3E
	ecjr8Db8DOqJewRIkN2PLWKTCEFWedK2P8nkyC/WbQodmff3ALH3TBI4n6qIm+E6cR1111NVOQTM3
	KTXPJOFugI6Qkm22nmuo15UYj5eoE2am2a/zeo9Q/JNe1fJ5JIDBlK955Ue3KNpiKYVVPXMTzBfYe
	GWrCcSC42CEWYXenPr2C7pGPB+6bTCjVtXVc5lmN2kPa4GzDIFZqp4akDR3S2w6r8orYPB1jesBgf
	mEWEsaCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wutYE-00000002q24-1I3y;
	Fri, 14 Aug 2026 15:10:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wutYA-00000002q1U-2gnF
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 15:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786720223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1GRrOlyN9nkOUdimeoCQpzY7og1lchpuM501N4iN80=;
	b=dl5j2vv9lxWTF6inBkZ4uVnCyxEtioBojZRH7jmCCOrmmf3n1PtbgetjBPLLtfPzArBu6k
	7hR2h7mqztcdPgKhhCsfBDvo8Msxu/3mlS2ttVSYBtgxrgCwXbMHLhWsyM2amXPsst4rZg
	EZvY7Qf3aG34b8HeyzzzHDLWJuIOvo8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-DvatqclWMhiECNPA0A51Jg-1; Fri,
 14 Aug 2026 11:10:13 -0400
X-MC-Unique: DvatqclWMhiECNPA0A51Jg-1
X-Mimecast-MFC-AGG-ID: DvatqclWMhiECNPA0A51Jg_1786720212
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 969F8195608D;
	Fri, 14 Aug 2026 15:10:11 +0000 (UTC)
Received: from [10.22.64.139] (unknown [10.22.64.139])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62CE830001A2;
	Fri, 14 Aug 2026 15:10:09 +0000 (UTC)
Message-ID: <3ca229d2-aaa3-46e0-8714-21cd67810153@redhat.com>
Date: Fri, 14 Aug 2026 11:10:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] nvme/070: Test multipath and marginal ports
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
 <20260812174503.3705830-3-jtaubepe@redhat.com> <an78AkXI1SUHXBwg@shinmob>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <an78AkXI1SUHXBwg@shinmob>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: sM1vgA72TqH67nLXXsn70GzMP5gjfoBqj0nIy7mxgDk_1786720212
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_081026_806116_06D30F3D 
X-CRM114-Status: GOOD (  18.08  )
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

On 8/14/26 07:47, Shin'ichiro Kawasaki wrote:
> On Aug 12, 2026 / 13:45, Jesse Taube wrote:
>> Add tests/nvme/070 to test various multipath and marginal port
>> scenarios, while confirming the port useage and state. This test is
>> intended to emulate receiving an FPIN event in a multipath environment.
> 
> The test contents are comprehensive, which looks good to me. 
>>
>> Suggested-by: John Meneghini <jmeneghi@redhat.com>

Please remove the above line.

>> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>

Co-authored-by: John Menehgini <jmeneghi@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>

I've tested these patches and they work.

Tested-by: John Meneghini <jmeneghi@redhat.com>

Note: These patches require the kernel changes introduced by the "FPIN Link integrity handling" patches[1],
and they should not be merged until the kernel patches are merged.

[1] https://lore.kernel.org/linux-scsi/20260814063616.GA9231@lst.de/T/#m1e8c728cf2dcdfd70d1b50a2fc2f278ea0832c36


>> diff --git a/tests/nvme/070 b/tests/nvme/070
>> new file mode 100755
>> index 0000000..a8002f8
>> --- /dev/null
>> +++ b/tests/nvme/070
>> @@ -0,0 +1,521 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 John Meneghini <jmeneghi@redhat.com>
> 
> This patch's author is Jesse, which looks inconstent with the copyright above.
> Also, please reconfirm the copyright year 2024. Should it be "2026" or

Yes, this is because the original version of this script was authored by me.

Jesse took my first version and greatly improved it.  She got it working.
> 
> When I ran this test case on the kernel without the patch series
> "nvme-fc: FPIN link integrity handling", this test case just failed.
> I think it should be skipped if the kernel does not have set_marginal_rport
> sysfs attribute. I suggest to add the check below:

Good suggestion.

>         if [[ ! -w /sys/class/fcloop/ctl/set_marginal_rport ]]; then
>                 SKIP_REASONS+=("fcloop does not support set_marginal_rport")
>                 return 1
>         fi
> 

/John



