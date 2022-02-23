Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC48C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 06:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87ryo7JLjizcW0zybbVFlBgWJfD0yUeeeEO37E3kODE=; b=awRIKNDFo2EU3omlnMAdmfSS3G
	brnrPzpkBIHsXiFk5gkcbViMtos4A63uXk1DqrlIWSn8hhBkM9BmTUowUA6263lfwEoRPfQbQX7W3
	7xFrME1PvChly3dMQGhBPblLf3mV09pPJVmTVV0zjG9Xy6cIm4DBlLo170wxTDgDSmhoef+5i89nw
	WxEKexzrX/ZuMr6v4nTpFkurWpSE5iioBgpWydwdpj0M5CmJrnB+pGs8Q8oKbROXjwKcuMeNQv/0n
	arGfNc8ggj8MhhUtsNhR62NdCqCANx44donYGmwJ6fh0Tmcpja4oQ36n1tC959aB78f+CV/TJzn84
	kkcVz9HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMkzm-00Cwe8-RZ; Wed, 23 Feb 2022 06:19:26 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMgTC-00C7YJ-3c
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 01:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1645579768; x=1677115768;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nSHdp0a4GmD+jXxAqqT79DZ6hE1s0OTI3GXP9NWFpG4=;
 b=eDx+t2AUvcdkAe5Wf0gZZqthI+aECloXIe5sYUnFa0VSnoDZhM6N/05P
 80XhNaJdtkVHZ7GfNzGwZumvG1Dr2WmD7BtH8hJ7l3vCeKRIMXK4X1WYG
 OMeAlBuvBIA3NMMPFWE827JclA2nphxsur4YE5N06NkF1wwnnUWmagJDC
 ipVqENI+82VcNwtYkHu7h/s4YKZ9Ruh5X3WeQQqAKsO90PGiTcrSlUvmN
 cm7lFuR63ILUsPOh54Pt3ZIrUS818sfBmoLAN5SC42dv0W0Zprl7KfqrE
 B7fhDLVMF9sIMaH2V+gkw5Mqz/MiDmHAYk7IoDOoqwdk8oQAQFYfh56BA g==;
X-IronPort-AV: E=Sophos;i="5.88,389,1635177600"; d="scan'208";a="193718555"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2022 09:29:26 +0800
IronPort-SDR: InrBc7G+NPV209Zwb9M63/eTUEonjRQ47FqsZi4g09dDWauH5ySvBkHJSqlFGZdVhXVO2GGXdv
 9sc92jB0iCZ1N+jIf4NqBBoTMKDaSDSYtTCraOTyWG58d3/UV9P3k0r6Lsr7sXxa0Lg75QDNnp
 0Ir6DSuOs4zvd1EaUlqDbxj7tuD+aMT04I3aRU+cWJHJvdbhebWvAkE442lI+W3/eYnD6pO5lE
 30zTO2nT5cZpwgnxyGp/4mR2oiihy97eUsdLfwnX9w1w/dFkvGMI9xyW/DlC3ahzDLR6K4isPG
 snX3cUoJvI9elkj1YG6oylth
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 17:01:00 -0800
IronPort-SDR: wTm9FdAuxXdy8QhW/STLnRVJYJxYFiWMf+fvBEQRaZ8I4Ymabifi5CtAiFIOB8suXSNTDLllPS
 5reJPPr7+3HIqUAzb1XaFbBvobWB4QsatrbbT/np0NgRnnwP68wEc2xmEYy4h6xnRD34JX0LsZ
 j15Q24v5GGlSMcHdYsNNIW1KZXA8DrYFYTZfkcIBfe2irNbuD3iN+HmxXfbPrkkqox3i/OLHWn
 UIjXsVdbgc66oNxwsYw5X404aVG8O8sLOHQ/MkX6Dqnams6tsroqokDCc5s1RRClg+L2Kal251
 SU8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 17:29:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K3JNm0f9Gz1SHwl
 for <linux-nvme@lists.infradead.org>; Tue, 22 Feb 2022 17:29:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1645579767; x=1648171768; bh=nSHdp0a4GmD+jXxAqqT79DZ6hE1s0OTI3GX
 P9NWFpG4=; b=tgLEPYuyXZXRGvNOOG0AU08Z9R+kfrkhAKO6Ur2hzAs+FkASkJP
 z8hjDUmw5aATjKHYbAmCy1tooA5FPl2UemUv7LWO0gYWQI9rPl+nL7R3yt6HwWL7
 XIokX4REnfywmdO+deB4i1pTq3OpozsEUedlpoJYAMhsU/qagNA7G+TGxAqj9UsE
 yeDuP0I1rT6nYGrhTST6QvrEyMUflMb0DtzWYSZHaqs+JGEhW931v34YGXuQw/Dp
 sSu3ni/IagbKftoaR41595VQMeIFsANsTF5oQ7FUGNjWZEUnyGbvzxrhgNeqYKRr
 E6p/akWoCdnm45kXYOJ5mECX9KQ/Q5KlV+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id MiH1fKOIvTal for <linux-nvme@lists.infradead.org>;
 Tue, 22 Feb 2022 17:29:27 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K3JNb3h1Dz1Rvlx;
 Tue, 22 Feb 2022 17:29:19 -0800 (PST)
Message-ID: <98ddab1b-6702-f121-9fef-0ce185888a1a@opensource.wdc.com>
Date: Wed, 23 Feb 2022 10:29:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>
Cc: hch@lst.de, javier@javigon.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com,
 bvanassche@acm.org, martin.petersen@oracle.com, hare@suse.de,
 kbusch@kernel.org, Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org, josef@toxicpanda.com,
 clm@fb.com, dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 joshi.k@samsung.com, arnav.dawn@samsung.com, nitheshshetty@gmail.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
 <20220214080002.18381-3-nj.shetty@samsung.com>
 <20220217090700.b7n33vbkx5s4qbfq@garbanzo> <20220217125901.GA3781@test-zns>
 <YhWGDUyQkUcE6itt@bombadil.infradead.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YhWGDUyQkUcE6itt@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_172930_248684_537690E8 
X-CRM114-Status: GOOD (  26.55  )
X-Mailman-Approved-At: Tue, 22 Feb 2022 22:19:06 -0800
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

On 2/23/22 09:55, Luis Chamberlain wrote:
> On Thu, Feb 17, 2022 at 06:29:01PM +0530, Nitesh Shetty wrote:
>>  Thu, Feb 17, 2022 at 01:07:00AM -0800, Luis Chamberlain wrote:
>>> The subject says limits for copy-offload...
>>>
>>> On Mon, Feb 14, 2022 at 01:29:52PM +0530, Nitesh Shetty wrote:
>>>> Add device limits as sysfs entries,
>>>>         - copy_offload (RW)
>>>>         - copy_max_bytes (RW)
>>>>         - copy_max_hw_bytes (RO)
>>>>         - copy_max_range_bytes (RW)
>>>>         - copy_max_range_hw_bytes (RO)
>>>>         - copy_max_nr_ranges (RW)
>>>>         - copy_max_nr_ranges_hw (RO)
>>>
>>> Some of these seem like generic... and also I see a few more max_hw ones
>>> not listed above...
>>>
>> queue_limits and sysfs entries are differently named.
>> All sysfs entries start with copy_* prefix. Also it makes easy to lookup
>> all copy sysfs.
>> For queue limits naming, I tried to following existing queue limit
>> convention (like discard).
> 
> My point was that your subject seems to indicate the changes are just
> for copy-offload, but you seem to be adding generic queue limits as
> well. Is that correct? If so then perhaps the subject should be changed
> or the patch split up.
> 
>>>> +static ssize_t queue_copy_offload_store(struct request_queue *q,
>>>> +				       const char *page, size_t count)
>>>> +{
>>>> +	unsigned long copy_offload;
>>>> +	ssize_t ret = queue_var_store(&copy_offload, page, count);
>>>> +
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	if (copy_offload && !q->limits.max_hw_copy_sectors)
>>>> +		return -EINVAL;
>>>
>>>
>>> If the kernel schedules, copy_offload may still be true and
>>> max_hw_copy_sectors may be set to 0. Is that an issue?
>>>
>>
>> This check ensures that, we dont enable offload if device doesnt support
>> offload. I feel it shouldn't be an issue.
> 
> My point was this:
> 
> CPU1                                       CPU2
> Time
> 1) if (copy_offload 
> 2)    ---> preemption so it schedules      
> 3)    ---> some other high priority task  Sets q->limits.max_hw_copy_sectors to 0
> 4) && !q->limits.max_hw_copy_sectors)
> 
> Can something bad happen if we allow for this?

max_hw_copy_sectors describes the device capability to offload copy. So
this is read-only and "max_hw_copy_sectors != 0" means that the device
supports copy offload (this attribute should really be named
max_hw_copy_offload_sectors).

The actual loop to issue copy offload BIOs, however, must use the soft
version of the attribute: max_copy_sectors, which defaults to
max_hw_copy_sectors if copy offload is truned on and I guess to
max_sectors for the emulation case.

Now, with this in mind, I do not see how allowing max_copy_sectors to be
0 makes sense. I fail to see why that should be allowed since:
1) If copy_offload is true, we will rely on the device and chunk copy
offload BIOs up to max_copy_sectors
2) If copy_offload is false (or device does not support it), emulation
will be used by issuing read/write BIOs of up to max_copy_sectors.

Thus max_copy_sectors must always be at least equal to the device
minimum IO size, that is, the logical block size.


-- 
Damien Le Moal
Western Digital Research

