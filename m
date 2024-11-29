Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C78AD70E1F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 06:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sLvD9Peerd2b44Kp+zCsRqrqiBgsjydgIow6s/y/jjk=; b=ND54f5jlqGH8KFH9x4UluzpUFI
	cSxO8bv0hyzkComhi4LKOZEQXD0cMieYSYl8NAzM27+IIZpcuxDY47YP156JuRvbSIFjy1D1V1C6I
	xjiEGWtqHgYnISknSy/PavUH8jVqqXGgLm441PbEeGApkBlVfKlQ9sxg63HyCJYZMQm1ZkHHWN7ey
	Rqf79gvdNWPmunysuaIJyksFo1IdFoJiwUSW9PE2MCnwFwpb8UMh1uaSYwo0rPo8eaWSsI0wHBxnP
	Dz09OhNHyUwvV3HyrZhO6o/cWF/g2lsOCdgxiG8xT9fuOKQSIKDIfLYJ7pu1vjXVOAeMSQhpg6FUc
	i1x8BzUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGuQ2-0000000H00q-1Mjx;
	Fri, 29 Nov 2024 06:23:58 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGuPz-0000000Gzzv-1eAN
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 06:23:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 457D3A41B14;
	Fri, 29 Nov 2024 06:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BADC4CECF;
	Fri, 29 Nov 2024 06:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732861433;
	bh=WmYOGV7eRRjGkSe/aBe/GEkoJ5Km7HN7iZg6KEnDfzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qz5iEpZNXkFhwZjMRhPi7DcRLoutFcyNz/qjrjMC2vseJRbH8d6OHCKGmVmKb3aZy
	 mHyNtYmrHB4k+w/BSsBSwrJpy3V3oEDfw3I220Pow7lLNipl/sSaSy463JThA2irQc
	 ofof19ssKDakuESSyOKDtKLixQiXT4a23SvGb7oaQgaOwaUHIbHCjkayusyiLfi2vU
	 MqOggfrIeD6MD/+NThWFOoO1zmUTMMQ2DFFcmuzWmWUC11ATrC7o6ReTseqxtfoTj1
	 PW446eKbhD2NYyDtEtcRqgaHl3dLWp2KaEx2A7Otxpg/2So1pLJLMZA/XRHBuLRAGu
	 wWFU53NdI7x4g==
Message-ID: <f029f618-7ca1-4f97-8f05-675709312785@kernel.org>
Date: Fri, 29 Nov 2024 15:23:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bart Van Assche <bvanassche@acm.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Keith Busch <kbusch@meta.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>
References: <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org>
 <20241112135233.2iwgwe443rnuivyb@ubuntu>
 <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com>
 <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org>
 <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com>
 <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org>
 <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <7835e7e2-2209-4727-ad74-57db09e4530f@acm.org>
 <yq1ed2wupli.fsf@ca-mkp.ca.oracle.com>
 <9e9ca761-6356-4a97-a314-d08bd5ea0916@kernel.org>
 <20241129061941.GA2545@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241129061941.GA2545@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_222355_487756_7D144007 
X-CRM114-Status: GOOD (  13.44  )
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

On 11/29/24 15:19, Christoph Hellwig wrote:
> On Thu, Nov 28, 2024 at 05:51:52PM +0900, Damien Le Moal wrote:
>>> Maybe. But you'll have a hard time convincing me to add any kind of
>>> state machine or bio matching magic to the SCSI stack when the simplest
>>> solution is to treat copying like a read followed by a write. There is
>>> no concurrency, no kernel state, no dependency between two commands, nor
>>> two scsi_disk/scsi_device object lifetimes to manage.
>>
>> And that also would allow supporting a fake copy offload with regular
>> read/write BIOs very easily, I think. So all block devices can be
>> presented as supporting "copy offload". That is nice for FSes.
> 
> Just as when that showed up in one of the last copy offload series
> I'm still very critical of a stateless copy offload emulation.  The
> reason for that is that a host based copy helper needs scratch space
> to read into, and doing these large allocation on every copy puts a
> lot of pressure onto the allocator.  Allocating the buffer once at
> mount time and the just cycling through it is generally a lot more
> efficient.

Sure, that sounds good. My point was that it seems that a token based copy
offload design makes it relatively easy to emulate copy in software for devices
that do not support copy offload in hardware. That emulation can certainly be
implemented using a single buffer like you suggest.

-- 
Damien Le Moal
Western Digital Research

