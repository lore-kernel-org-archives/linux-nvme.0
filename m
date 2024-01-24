Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8013DC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 22:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0kEVxDIuSfTm3y50SgE0ZGrGcNJpgFJmGTIE3QmN7t0=; b=YMERJL2CE2uXHaOOQwzLT7i6p8
	7vOGQxELFSLXPIi4STnFWhZd8G6c2I+3+MuL5K0ELfJQrrykDWQzejUxDMhmLg1oh/Z1Fmc7jn4fx
	OiAzTsE+NkPEv/m9yNZuma2evrTCR8SJbK0DA+zP9zmrg88QagljRbwMf3YTH4mLAlRib1fBiwsKg
	3POvIPEPySyUT+IoTz9WkA1OfiInryQcLbs7Nz84IbeFB0/dTRllmS5o36mBY40QG96mgw2KDDAE9
	b/RqhW+QznzBwo+anJjX5ejZWqYj2sxS/hbEZ0IM3vSEK+YeUvTyp88O7laKVCjBqg8rg1oP/ReOq
	oFgOrgPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSlnX-005L4h-1d;
	Wed, 24 Jan 2024 22:32:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSlnU-005L44-2s
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 22:32:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 303ED6207F;
	Wed, 24 Jan 2024 22:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFC3C433F1;
	Wed, 24 Jan 2024 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706135559;
	bh=Cf4TbRtQv66gVbraB6zo3Kn5eL2uP+kvPg2Y6ryomGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZnqHXwFEiVLW4jWqt58ZaF74SzDxTykXns8nk+eMGq1EnT9FOH1k4OMPx/jhBENKG
	 TmCvdHBww1FGR4ZBEN5zAca0im5ViClRyIPu3dL+O54quHJte5CmXZqNMi50vB8P5g
	 MsImFMW31OqYt73wEei/A+oGnd91NTrIFR5l/dEmL0ppPq8BFDnD3hA5mwbuBuqO5B
	 SOmaHj9UilolP1bDX0/a15N7zRK3zx+J15jeN/EUrcGRKRY0PEwC+yvACRmTkG+sGT
	 xyE3EAIsK38jfTaV4aZtDrS0FkRVkcBPCOxvgAc+RTg0RrGyjXPPIHgOulL0ft9UsU
	 +GXtuj7ll5aHg==
Message-ID: <772618f3-f4d3-470e-bf06-70d8ee66d7b0@kernel.org>
Date: Thu, 25 Jan 2024 07:32:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <ZbD7ups50ryrlJ/G@fedora>
 <ZbEvstiLSMwtFb8m@kbusch-mbp.dhcp.thefacebook.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZbEvstiLSMwtFb8m@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_143240_993355_91209CDF 
X-CRM114-Status: GOOD (  11.73  )
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

On 1/25/24 00:41, Keith Busch wrote:
> On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
>> Requests are added to plug list in reverse order, and both virtio-blk
>> and nvme retrieves request from plug list in order, so finally requests
>> are submitted to hardware in reverse order via nvme_queue_rqs() or
>> virtio_queue_rqs, see:
>>
>> 	io_uring       submit_bio  vdb      6302096     4096
>> 	io_uring       submit_bio  vdb     12235072     4096
>> 	io_uring       submit_bio  vdb      7682280     4096
>> 	io_uring       submit_bio  vdb     11912464     4096
>> 	io_uring virtio_queue_rqs  vdb     11912464     4096
>> 	io_uring virtio_queue_rqs  vdb      7682280     4096
>> 	io_uring virtio_queue_rqs  vdb     12235072     4096
>> 	io_uring virtio_queue_rqs  vdb      6302096     4096
>>
>>
>> May this reorder be one problem for virtio-blk and nvme-pci?
> 
> For nvme, it depends. Usually it's probably not a problem, though some
> pci ssd's have optimizations for sequential IO that might not work if
> these get reordered.

ZNS and zoned virtio-blk drives... Cannot use io_uring at the moment. But I do
not thing we reliably can anyway, unless the issuer is CPU/ring aware and always
issue writes to a zone using the same ring.

-- 
Damien Le Moal
Western Digital Research


