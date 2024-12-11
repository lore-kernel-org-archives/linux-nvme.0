Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABBEE7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 04:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=apWkkDdKfPTNERp/IzyceYZNcr2rb3k3LuEKeoFu58E=; b=rhCOlMIfxpEf7f7e/e/DdOEvrb
	+9ZG6S28001AKOElY1wV5SWT3XiCpkLMW/xPKoC1kPpTrkIdAmHSIuEfIiUqAf+fYMslyT8fX3LuD
	uQgKfkl/NJT4oPFjD/0g48pDzIxraM1sPE7D5PCgHNZrFZ0DsPqjBWe5Uv1syvB9x3O0n/agPmOLQ
	CBU1ip+AFAsfLMy03LG+V6L8oW/sCoNronBKu4kSmQAvuoEi1qb1LgEvrDM/DqvO5scJRLgFZ43un
	qVoyTOscHzEYhTZHc+2jRztp8yG9eIAFsU8mOX8DPyplW0OTUzq5OpzEtI+p2JcSvrTXKRTVygzXs
	p0L8v3sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLE1B-0000000Dj5V-1EVV;
	Wed, 11 Dec 2024 04:08:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLE19-0000000Dj4l-14oM
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 04:08:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2F2DA5C2762;
	Wed, 11 Dec 2024 04:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A1C4CED2;
	Wed, 11 Dec 2024 04:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733890086;
	bh=7/3hmNoQ4LWXf/liq0trPhtYhdVp9Bh0JJE/pGvZqI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m/UfDmLE/Egvp+aU2S6OtaAiPyALgOouiw8E+uIWgCmIcPR4C2wjS73sbWaCLIIRt
	 gWn+RRFTfqC4ombZ1LaTAOmlr/qYUJepIDpqF1zfy3lkHpnd0LFqNKnpsIdlwoNV1q
	 torokdsotdOIaYmZoXSRFVu40kfdYFGDnY4JzzhDcn517OIX8RyHltAn5FUn2dgJh0
	 90Ev9VNXFa6tQ/jVAAgQ42wn9SV0Bz8UhMHM51OIXl55ihfMyWYmRPVVpfr5MsQpQp
	 XtdWAqu4dNI6qKMz3dGzSWvaISGjEYAGwulQJRy4k64T+fzqLVloAEjgQP4OdvMwNj
	 KSOqYl/OYF4LQ==
Message-ID: <6ff84297-d133-48d4-b847-807a75cab0f6@kernel.org>
Date: Wed, 11 Dec 2024 13:07:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Bart Van Assche <bvanassche@acm.org>, hch <hch@lst.de>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com> <20241210071253.GA19956@lst.de>
 <2a272dbe-a90a-4531-b6a2-ee7c4c536233@wdc.com> <20241210105822.GA3123@lst.de>
 <a10da3f8-9a71-4794-9473-95385ac4e59f@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <a10da3f8-9a71-4794-9473-95385ac4e59f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_200807_342765_CB915CD8 
X-CRM114-Status: GOOD (  12.64  )
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

On 12/11/24 4:21 AM, Bart Van Assche wrote:
> On 12/10/24 2:58 AM, hch wrote:
>> On Tue, Dec 10, 2024 at 08:05:31AM +0000, Johannes Thumshirn wrote:
>>>> Generally agreeing with all you said, but do we actually have any
>>>> serious use case for cross-LU copies?  They just seem incredibly
>>>> complex any not all that useful.
>>>
>>> One use case I can think of is (again) btrfs balance (GC, convert, etc)
>>> on a multi drive filesystem. BUT this use case is something that can
>>> just use the fallback read-write path as it is doing now.
>>
>> Who uses multi-device file systems on multiple LUs of the same SCSI
>> target ơr multiple namespaces on the same nvme subsystem?
> 
> On Android systems F2FS combines a small conventional logical unit and a
> large zoned logical unit into a single filesystem. This use case will
> benefit from copy offloading between different logical units on the same
> SCSI device. While there may be disagreement about how desirable this
> setup is from a technical point of view, there is a real use case today
> for offloading data copying between different logical units.

But for F2FS, the conventional unit is used for metadata and the other zoned LU
for data. How come copying from one to the other can be useful ?

> 
> Bart.
> 


-- 
Damien Le Moal
Western Digital Research

