Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23030D597C4
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eUbKdg4w2cwS0tlTzGGEyGXCLCd29hfIkKQHGGvh/0I=; b=A8nO+7WX7fPyZGlKVI8IKCb7n5
	hTwaxUKEz0zth+zDV3NbFOKvQgXhMjf4LtzC2jEwX5poBxXopdwTZfot1eZ3nLFnIVlCEPVTgcvLf
	CABdiqdlzqtX4AKgtdNHzL0v9nHT1YX3NiCPPBuejZFshMtJENj798M0Hhkag+JNWCBcfluCTuTJI
	UyM9RXBMR8pIOsx3qmP/Qw+5GImN8Gj+PHdbYR/ZvXxNm7tEsC9VmUAeE7Wphk/bGOmULpZyNF4kF
	ojwzZpwX6Wje7EmWkQetECFmr1Qt0DQlB0Vq7toTaTfd4VHByeFWvFg2wDm0E2AZkAAJsAtvBgw8F
	fWCkdkTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB2XM-00000005XxC-2I05;
	Wed, 13 Nov 2024 01:51:16 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB2XJ-00000005XwK-16yr
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 01:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731462667; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eUbKdg4w2cwS0tlTzGGEyGXCLCd29hfIkKQHGGvh/0I=;
	b=AvFMDEl+kaGFiHgwIJFKyOeeGnCwt33K7ahj9alvGr0iLgDA0u+Hn3a3Xh4Al8hs4u0LviPAIjDejVFjoLdPZwPN3utkoNIMV1mMrWJt7S/WCtXm0ZLlINwjAQ+h9qGR3iW7JTePXDRELujlH3rfSzw5Z2zrc/A4ypq3Kan+NdE=
Received: from 30.178.82.28(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJJC5oO_1731462663 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 09:51:05 +0800
Message-ID: <70260e97-ef2b-4a22-9a89-cbf2b6028acd@linux.alibaba.com>
Date: Wed, 13 Nov 2024 09:51:01 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCHv4 13/13] nvmet: report ns's vwc not present
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 linux-nvme@lists.infradead.org, m@bjorling.me, matias.bjorling@wdc.com,
 kch@nvidia.com
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-14-kbusch@meta.com> <20241108142743.GG6694@lst.de>
 <Zy45M1HRz8cKLPxf@kbusch-mbp>
 <005617fc-656d-4180-87b8-c9ebc8bff48d@linux.alibaba.com>
 <aa121956-a050-4c47-be44-2d3afe6c6610@linux.alibaba.com>
 <ZzPbi6s3tmrepPyN@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ZzPbi6s3tmrepPyN@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_175113_467293_4E695BAC 
X-CRM114-Status: UNSURE (   4.02  )
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


在 2024/11/13 06:49, Keith Busch 写道:
> On Sat, Nov 09, 2024 at 11:00:32PM +0800, Guixin Liu wrote:
>> 在 2024/11/9 22:59, Guixin Liu 写道:
>>> Or just remove !req->ns->buffered_io check? All file backend return
>>>
>>> support vwc.
>> Sorry, remove "req->ns->file && !req->ns->buffered_io".
> Do you want to send an update the with the updated check?

Sure, I will send an update one.

Best Regards,

Guixin Liu


