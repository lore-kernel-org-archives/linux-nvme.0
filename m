Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5997CFC60F
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RuwI853r3GqsvDtGgymK1qT9vPk0IMt6qhNVie6Ea+4=; b=2O54vRge9zzDrLstAdWgiZ3CKJ
	2MHowmF+ml7IA1AIi1aP88eZ/5BxthZ1u1DpTfKtmTewgHvuI0FT11knr+QpINDdkamIPMYfL+2r6
	5NTg5yqK6V31ZeFobMzuTtko7pL/w6os/3BPrc0zkqATivlnTDRk+Ve7+Ows85pWqNmzudAVsr+Qu
	sd+JP4fH7V7I+wde4Ma7t7Z3J4pZSIKDaykBUlHu9mAAN8r69SYaDHfyh3T2YTPpZcxQF/WbYbpDo
	rf8Nsa2G/zKyEk8apDmjxFAP0a3ThlzCjLmqHyltD/DMooQ1ajFh+rohqQZn0YD7M21vGxmMxz8Sd
	KgDiE7Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAPS-0000000Fbqm-3qzm;
	Fri, 11 Oct 2024 07:50:02 +0000
Received: from mta-03.yadro.com ([89.207.88.253])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAOA-0000000FbZN-2hdi
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 07:48:44 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 6B99EE000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1728632917; bh=RuwI853r3GqsvDtGgymK1qT9vPk0IMt6qhNVie6Ea+4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=d/RwcqseDofZdjTQL6+D6cwh5xfy5PerBK2wfp0OlTSakD9U23hka2GrVYg/+PPz8
	 gnAC276Z4R9R5memuHicfUc2n+qMY5Ir5/Q6khGPunKyoX0r6DXiz85CbMm3P9uDrV
	 KO8fLMxaiDS8oQC6Kq7QUivUlhaJGHqpKT0WXrNm974WH0WgHiPg7/WbUCdxt5xrYo
	 h9yhYWLDDjV0c54K4laEAejbQrLPrDHNO7jXXZuJGq7hiJpmpEaG0b2YLdKvT3eX3M
	 qLoFNWbviLO7od/9T8Op3+6S8gwfXEgqSj9/sy+B4GqUBWGnJbvxcxHwz2cOzZt/QW
	 VSgTbgVqU54xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1728632917; bh=RuwI853r3GqsvDtGgymK1qT9vPk0IMt6qhNVie6Ea+4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=zO6PPeeay2EGAWdktO7sQv6db28anqkJJCBPZ1naKMzM6p0pLo4I8xZot1RRRNqM9
	 bcRg/+4HROKscm3E4DbG66hA5YRgB66n/yY0qf6HoP5FWjwbIXE+LzLAoR60/k6LKQ
	 KhAyoZ+QnFL0k4G77z7m1gn+eDD6TG7olqyS1S2QjHyIe3iM6uStTXs8QGkkQd6XA1
	 UiQPPpqpltzs3vEgBV4pNbYkM72cFXmS8zyWiZ/b16KtaZ/3NuvB/CT4IZ/Rdwdmoy
	 hpyQ7dkGUUxU9xgAKQA7hf+fbhTtcq4Qejxm81syRNUGa+H3AsA/stzTsGeg2Izsy1
	 RKSoqUGz4LE/g==
Date: Fri, 11 Oct 2024 10:48:37 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v14 2/2] nvmet: support reservation feature
Message-ID: <20241011074837.GM22571@yadro.com>
References: <20241011022612.50303-1-kanie@linux.alibaba.com>
 <20241011022612.50303-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011022612.50303-3-kanie@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_004843_405936_3FA35D62 
X-CRM114-Status: GOOD (  11.63  )
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

On Fri, Oct 11, 2024 at 10:26:12AM +0800, Guixin Liu wrote:
> 
> This patch implements the reservation feature, including:
>   1. reservation register(register, unregister and replace).
>   2. reservation acquire(acquire, preempt, preempt and abort).
>   3. reservation release(release and clear).
>   4. reservation report.
>   5. set feature and get feature of reservation notify mask.
>   6. get log page of reservation event.
> 
> Not supported:
>   1. persistent reservation through power loss.
> 
> Test cases:
>   Use nvme-cli and fio to test all implemented sub features:
>   1. use nvme resv-register to register host a registrant or
>      unregister or replace a new key.
>   2. use nvme resv-acquire to set host to the holder, and use fio
>      to send read and write io in all reservation type. And also
>      test preempt and "preempt and abort".
>   3. use nvme resv-report to show all registrants and reservation
>      status.
>   4. use nvme resv-release to release all registrants.
>   5. use nvme get-log to get events generated by the preceding
>      operations.
> 
> In addition, make reservation configurable, one can set ns to
> support reservation before enable ns. The default of resv_enable
> is false.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Once got, you may(should for reviewers) add Revived-by tag for the
patches. So, please do not forget:

Reviwed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

