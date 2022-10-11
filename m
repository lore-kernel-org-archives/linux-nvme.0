Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ABDC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:MIME-Version:Date:Message-ID:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+UDoqY8SAjjQoyPGhCWbqLhxgeVvuWrW3n0iwV8+4c=; b=M0wzvq6dKP4v4gyLWYwKRfVnOg
	JIk0HfqHNKDc4iQJM3qhGYMJN/e9elz1b3tjx2FXVFH2FmQ5PKBkvZto5+cPgEDoq2BfGhRhgiNyF
	Sdyjq1K8J7FX4lh7zQcICkMxe4p7KAr9ITIR7qnQ0TcgXXnFNfGDeTRBCkSs6zWhoBMZbGvg4Tnuz
	M8vZflIZZkfeTUmWi1Z96arX+/On3NUIbsfdWIG2B7L4OTA2GfOGpbiBrkHMxMKtrppiObPNZjbHK
	xi59OD6IqrsDpNuzFxBsbF9ps7xx4pnmJkUekW5mc4QrqbIUg5zFFeAS2qQoXi/O3P0hAOOZ7XNhB
	pVGCvnxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiLyG-005nkE-1V; Tue, 11 Oct 2022 20:35:24 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiLy8-005nhc-Bc
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 20:35:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1665520517; x=1697056517;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=l+UDoqY8SAjjQoyPGhCWbqLhxgeVvuWrW3n0iwV8+4c=;
  b=WfFdDNFVLMfxxXy8J/3zGv0wU/Mlq4CcIM6QWflFxImYubCTEGpG0ndv
   r5VTollZzYEXm2KyX4grX4EneEVgFbv+Yv4jO6QccYN5Vy8AlhD3lAKFa
   OCA0W/2bMcqPGVJZnBjq+/gQicoejk/2Bb+AzL6/lxocziUXo525nooAL
   A=;
X-IronPort-AV: E=Sophos;i="5.95,177,1661817600"; 
   d="scan'208";a="232474151"
Subject: Re: [PATCH v2] nvme-pci: Set min align mask before calculating max_hw_sectors
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 20:35:15 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com (Postfix) with ESMTPS id 19E9045542;
	Tue, 11 Oct 2022 20:35:13 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 11 Oct 2022 20:35:12 +0000
Received: from [192.168.21.170] (10.43.162.208) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 11 Oct 2022 20:35:12 +0000
Message-ID: <bc7b08f4-673d-538f-e053-4edf899b9d60@amazon.com>
Date: Tue, 11 Oct 2022 13:35:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"Bacco, Mike" <mbacco@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Park, SeongJae" <sjpark@amazon.com>
References: <20220929182259.22523-1-risbhat@amazon.com>
 <EB43F4D1-BFD0-408B-93E7-10643B59F766@amazon.com>
 <b73250f3-2dd6-36da-4d69-3149959f2e67@amazon.com>
 <20221011060829.GA3172@lst.de>
 <8f451a9e-3324-c7d4-cf61-a105fd087192@amazon.com>
 <Y0W09tcGK/1ZAhQh@kroah.com>
From: "Bhatnagar, Rishabh" <risbhat@amazon.com>
In-Reply-To: <Y0W09tcGK/1ZAhQh@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.208]
X-ClientProxiedBy: EX13D36UWA002.ant.amazon.com (10.43.160.24) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_133516_540101_5CC0B2F6 
X-CRM114-Status: GOOD (  17.45  )
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


On 10/11/22 11:24 AM, Greg KH wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue, Oct 11, 2022 at 10:05:38AM -0700, Bhatnagar, Rishabh wrote:
>> On 10/10/22 11:08 PM, hch@lst.de wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> The patch already made it to Linux 6.0, so I'm not sure what we need
>>> to review again.
>> Oh, I never got any email that this was being picked up so sent it again.
>> Anyways thanks for taking it.
>> We need this patch for 5.10/5.15 stable kernels as well. I can send backport
>> patches to stable tree
>> maintainers unless there is a way for you to mark it so that its
>> automatically picked for stable trees.
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Since the original patch doesn't contain the CC:stable@vger.kernel.org, 
using option 2
makes sense as there is no special handling required to apply this for 
5.10/5.15.


