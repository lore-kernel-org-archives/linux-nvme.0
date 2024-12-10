Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C09E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kGRxI4MvkczRgURGuKE/NkzSkR8ERW6zUvwscihee5Y=; b=qzX/OQbuWROdnS3i7uRMJ3t1N1
	7jNOsvlvnIEEGzNpuqj0QKzEWRiXifIy6TmZg8eOk7thTp9wKA2wi9WuP1zOY/xa2mo3nKu18nfNN
	Bcbs/W16LBDt2B24xAJhTKyVM4WjTDFsd90QJvfyclltBIvsosQ6txARL77DKcHuZEImya0fpaiCX
	FDOAQtUkxMCrqGmb4bgRuIzPJJtytqjeGHrCZtjR3x06O3ezqGeYEUStXDMijAF3yY3MmUorK/mNz
	cDNhPFlG3l4H+VNuw8SYxxA7saOpGc9+BlGbtVHMUFDeNqYN+wHg0/DMRtHtZuY3fhsHUCWdnH9yL
	a5+PFbNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL5nY-0000000CVyw-3LAg;
	Tue, 10 Dec 2024 19:21:32 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL5nW-0000000CVyG-01Qj
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 19:21:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y77rT0hT9zlfl5W;
	Tue, 10 Dec 2024 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733858483; x=1736450484; bh=kGRxI4MvkczRgURGuKE/NkzS
	kR8ERW6zUvwscihee5Y=; b=H8w++JttLWyRmupBTpStBzQYxt04HXVU8MKEQp/A
	QDh5jwvvB7s/UP9el/mzXENVIjN+SNQL050OLkUB5F4NIzwf7R6EUjlXHqRPlKov
	1u51rm2LezO45wdEDr6Uid0qCWKiscKLy5sfj5krUU0B9bTVdq9P6jO0WzAjshJ8
	0vnnMakugglrPj/CaTcLAVyWNSFkva6ccpFCmNr+hFUfHByiRhjCwfWjBss37wjc
	+Qb2yUvJDvJvNGJsIGh/Avom64luqQdXa/qRFoRiehYjX0xMZaZfTmgJFP16eCI+
	93n+QYDTSoYErgf2t0pn9JC36n/iVCi5CnmzCkklf/KarA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id v14CjmZSqQuW; Tue, 10 Dec 2024 19:21:23 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y77rJ3qwkzlgd6J;
	Tue, 10 Dec 2024 19:21:20 +0000 (UTC)
Message-ID: <a10da3f8-9a71-4794-9473-95385ac4e59f@acm.org>
Date: Tue, 10 Dec 2024 11:21:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: hch <hch@lst.de>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241210105822.GA3123@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_112130_058037_00664D28 
X-CRM114-Status: UNSURE (   9.30  )
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

On 12/10/24 2:58 AM, hch wrote:
> On Tue, Dec 10, 2024 at 08:05:31AM +0000, Johannes Thumshirn wrote:
>>> Generally agreeing with all you said, but do we actually have any
>>> serious use case for cross-LU copies?  They just seem incredibly
>>> complex any not all that useful.
>>
>> One use case I can think of is (again) btrfs balance (GC, convert, etc=
)
>> on a multi drive filesystem. BUT this use case is something that can
>> just use the fallback read-write path as it is doing now.
>=20
> Who uses multi-device file systems on multiple LUs of the same SCSI
> target =C6=A1r multiple namespaces on the same nvme subsystem?

On Android systems F2FS combines a small conventional logical unit and a
large zoned logical unit into a single filesystem. This use case will
benefit from copy offloading between different logical units on the same
SCSI device. While there may be disagreement about how desirable this
setup is from a technical point of view, there is a real use case today
for offloading data copying between different logical units.

Bart.

