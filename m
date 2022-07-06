Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3CEC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4vMOS8tSKgl9SkajjuoWgOzSB3rEOa00bU5weYtSmo4=; b=u3nstmeZPjRuLYWSoTc2HXfBJm
	H0zQXYZu/44nX+Rxb6HAn5asScjuIqrW8Qw3wbIhxfqPyqIiLW8DcFIf0xKf0dwgHARjr6n52lQN9
	dmvKPy7iVB+VdBYp3qLaQEouXxmIesj8jATG82CtxWbvZ63sQXaM4KBzu22cT9MvpDP2ZrfqsOBGB
	FpJtAEw5Occ2VwemQv9f1MwWIZUHOiGIq1FCW7kUwHGDd7B4YjDZ0pqC90u+TdlYDdIl1g6xxRXyz
	OLv7HDEk+DAl8nVVPyTRMMWhUEtyMTWCG686PL6RMzVjCiIzyBAaJ+Y+CsEFcJ8rueoNdwXW3Z/XG
	rZyNqViQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o98Y9-00Bc4n-9I; Wed, 06 Jul 2022 17:10:53 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o98MZ-00BWyj-V8
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 16:58:58 +0000
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdQfb5Grpz67pCt;
	Thu,  7 Jul 2022 00:56:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 18:58:50 +0200
Received: from [10.126.171.66] (10.126.171.66) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 17:58:49 +0100
Message-ID: <db3958dc-d714-f361-f349-06317a0e0cec@huawei.com>
Date: Wed, 6 Jul 2022 17:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: <axboe@fb.com>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
 <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
 <20220706161825.GA1962@lst.de>
 <YsW3oXcCe6/y6iRb@kbusch-mbp.dhcp.thefacebook.com>
 <20220706163434.GA2222@lst.de>
 <YsW7+Lsy0ENSA/il@kbusch-mbp.dhcp.thefacebook.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <YsW7+Lsy0ENSA/il@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.66]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_095856_213665_97FE6DA4 
X-CRM114-Status: GOOD (  12.55  )
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

On 06/07/2022 17:44, Keith Busch wrote:
> On Wed, Jul 06, 2022 at 06:34:34PM +0200, Christoph Hellwig wrote:
>> On Wed, Jul 06, 2022 at 10:26:09AM -0600, Keith Busch wrote:
>>> On Wed, Jul 06, 2022 at 06:18:25PM +0200, Christoph Hellwig wrote:
>>>> On Wed, Jul 06, 2022 at 10:13:22AM -0600, Keith Busch wrote:
>>>>> Did you test what the trace looks like afte this? We're losing valuable trace
>>>>> data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes.

ok, I just thought it was a typo, but did not know why you were using an 
array macro.

> I
>>>>> don't know why it cares that the address of the field being read is only 4
>>>>> bytes; we want everything that comes after it too.
>>>>
>>>> Because accesses should not spawn boundaries of members in structs unless
>>>> copying the entire struct.  If we want to trace the various fields we
>>>> need to individually assign them.
>>>>
>>>> Anyway, I'm dropping this patch from nvme-5.19 for now to let the
>>>> discussion conclude.
>>>
>>> How about this instead?
>>
>> Maybe a better option would be to use struct_group().
> 
> Good call, I'd never used that macro before. The result produces anonymous
> unions like I just proposed, so yes, I like that option.
> .

The warning hints at using struct_group() also ...

Anyway, Keith, do you want to write a new patch or shall I?

Thanks,
John

