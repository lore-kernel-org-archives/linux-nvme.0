Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E3BCCF2DB
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lRup/N8WUOJS+Q4ndfsk+LyKFMFPYIR3fn5J7Nr++qA=; b=Mjc4bZnEGLRWSeDZS4TTTaYmQo
	36DXl68vffPNpVvTLMCzRVLfw+5yC7rVeRsj/nWy6paUKMA+AenjNAJBRzZX8VDLT1VcwM5nYtXke
	fk5M7+HykmEMwvpz9R+9Vwo7rx+7goWHjsryR483JarBcEuS930DayM8rhKwG34bw07iVH+gUYKvk
	zk9fs9jMZeYL2/84OAwDHyVxPquY983W22Zm/uwvJ2jPn9xJU2eiW5AFB47ZYJ3Yt28IXtSC4uviV
	jqiLnFHOsM2rzCjbSbpJCGiQZqRtTgF0sSiADNzdsSblEXYbHvXfSup0FBYH+qvyt+VLW7AgqMzXJ
	EAHVXt/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xInIm-00000007UuH-48p2;
	Mon, 19 Oct 2026 13:21:20 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xInIh-00000007UsE-3YGF
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 13:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792416071; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lRup/N8WUOJS+Q4ndfsk+LyKFMFPYIR3fn5J7Nr++qA=;
	b=o3ato5u+7N7wHf8JyXNO/6f2SKoNK8WhmtvbjfoheR2K14zgSpqL0Ksm9t2UPtlh0RMTbbtrMkGbLxolNIhieWQ4HPKLwoFrdFN9ozhuisEH0o0YXrQXX0uSn2942QmNoN0pXVKeVhTjXk8j/0m7G4L+2QUc3vQhaY2JC+3WsEU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0XD7dxJk_1792416070;
Received: from 30.178.69.0(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD7dxJk_1792416070 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 21:21:11 +0800
Message-ID: <d9352031-1127-41ee-82a4-7af5bfbb1485@linux.alibaba.com>
Date: Mon, 19 Oct 2026 21:21:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme: document the service-time iopolicy sysfs
 attributes
To: Laurence Oberman <loberman@redhat.com>,
 Martin George <martinus.gpy@gmail.com>, sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
 <20261019075607.808947-4-kanie@linux.alibaba.com>
 <sashiko-outbox-176783@kernel.org>
 <acd6eee9-dadb-48e3-9a9d-232a268472d8@linux.alibaba.com>
 <c4b6b7cfd51a498df8aaa7f5bc5cef9a0605b733.camel@gmail.com>
 <1a84584bc9cf64fab6b4e17bdf2050f9b176ad6a.camel@redhat.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <1a84584bc9cf64fab6b4e17bdf2050f9b176ad6a.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_062116_645690_47E68A27 
X-CRM114-Status: GOOD (  10.16  )
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



在 2026/10/19 20:43, Laurence Oberman 写道:
> On Mon, 2026-10-19 at 17:43 +0530, Martin George wrote:
>> On Mon, 2026-10-19 at 19:13 +0800, Guixin Liu wrote:
>>>> Should "service-time" also be added to the accepted values for
>>>> /sys/class/nvme-subsystem/nvme-subsysX/iopolicy?
>>>>
>>>> هایی
>>> Sure, changed in v3.
>> Not just /sys/class/nvme-subsystem/nvme-subsysX/iopolicy, but this
>> should be added to the accepted values in /sys/class/nvme-
>> subsystem/nvme-subsysX/iopolicies as well.
>>
>> -Martin
> Hello
>
> There should be no changes needed for my original iopolicies patch 
>
> iopolicies_show() walks ARRAY_SIZE(nvme_iopolicy_names), so whoever
> adds a service-time policy adds its enum value and its string to
> nvme_iopolicy_names[] as part of that work. The new name then shows up
> in iopolicies automatically. The existing iopolicy store path already
> matches against the same array, so both attributes stay in sync without
> code changes
Yes, it is.

Best Regards,
Guixin Liu
>
> Thanks
> Laurence


