Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1E8C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 06:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ua9S9bU/3TptPR3lXDO7yStG0OHE6EAOXXuEol5OsOs=; b=Y7XuWcsYrs6HW/YgM3oJ6lQWg6
	1/lRk/v/yvpQ5Q9EaMaVldxTBatnekZk+wFuEfYYk0d8tw4oB+Y5UAeQDO0c4y6PxbqYSgBdVH9eT
	GD1hfw+erqvvSA26rnzg4Sn7ztslwG6YF1X/OGbJdXiQG12bH0FQkV7jkrjKwjgBmjFNnNKU6Xex5
	w8CvACMeHCr4hMsAaUfnBdyRw08mBrmk2DNcvQVpaj/Et3TPHnmfoxSgt9uIDs3QZjIkO2IZcI73/
	8YzMuWGnc3yt0cm46tn+zULrSfPKmi/khG8sNUk25p05A5fy5TZTc9vyVJIXxngbXkEgLM8FMVDZE
	FQdo0Mqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFs5O-003ZMe-V8; Fri, 04 Feb 2022 06:28:47 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFs5L-003ZL5-OF
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 06:28:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1643956122; x=1675492122;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XY7HM1Ns7hm2Ldhsemh6j5ncCcWBc54JkxLeU7W/o3w=;
 b=ZSqkZl7Q8HWgh3y0kfFFFaeg+SGyZmsZdjWatROsQO2INBGpH4GO2K+O
 VS9ll+ga+CFW006bGYzemxg8Inxa/SUSeiQdkF+ZSCdy5tujE9zEVU2pB
 oFsFixvuE/LxPo/cKBQ8W4nwjkYzAlKz/0lWfRg73mdV+Bq/PegkiJs6K
 +HENFys88/WZjwRiZpUrZiDOXm6RQVZ5CwFbOerGynoEnuUpq1Q8aCCDM
 ibhSgsv2fHr+DFPrYTYNKLA/6/F+swknL0digClZ/LFJ1SrXAwVKpN5JD
 c1u4dPdWZbFUulksqA7MJoPjkUFWW+9Xvji7HfZhLOgzGFSkTa5aD7PUY g==;
X-IronPort-AV: E=Sophos;i="5.88,341,1635177600"; d="scan'208";a="196957607"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 14:28:40 +0800
IronPort-SDR: T8Mp5X2EuQi+Gygnxrcig+47G3yGposTd8/3q4eAcTIIL7cu8XJTOJC0svmgBrkmyhraPZ8D6A
 QM59betgcPrlXRgmaynNVpFycPuVwNuRPDpkydQg5PVMXvW4JOzPkE7jqO/kp4ecznSHw04u9F
 63nEw1toezGyGIdjtxIeVDdTC4QOsQI6dc5m/fAJWYw/Tbs3hVuCK/Yb02/F4mmCRrU/IedzP5
 8StDNGfF+pHhjIVXRJOvyEUzUoVpcN3Fx1MZVl9t6ntHzl94dbxFeefc+mYg35kuZkIwa+suKa
 koWENh2nt3Dk91cICScuvDcv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2022 22:01:47 -0800
IronPort-SDR: dqLtQThXfA0+Dote9HMSPtr7AFpRGEwwkkn16Y08mBkeUTapBCbHhKv5DFy8PBmdxMp0n6wlUo
 psJiyMgXNGujBS+1MdJ1dy5F5YPg2a/rrBw+UbEHC3fpuakmR+8NlPmhb0FHcL6EohJxrCAJ1n
 XNaqn4OrTJ/vykkWFt97kIISXOnrruwNxccnnIyDFN9GmCM8huz721TvGQRp2eLLffkB9nsNeY
 1aKNafEzE/eyd4v67za5WLrCeYYuzM7AVBe+tFDed+0PpT3HjyQONDyFVSzjPTq8oHBySw5+99
 UWs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2022 22:28:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jqlwm4xLzz1VSjC
 for <linux-nvme@lists.infradead.org>; Thu,  3 Feb 2022 22:28:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1643956119; x=1646548120; bh=XY7HM1Ns7hm2Ldhsemh6j5ncCcWBc54JkxL
 eU7W/o3w=; b=Vy1JQI4M/p1RM6pYjkGTdHayEVDerzZzeQKwGTfze/XnWDZgKtC
 452KAtRCJmmt2/PoJYUSFE5uhvagAB3Aq1Fktw/41WmPj8t5pXf1u0eCtiVdkYqj
 101uSyKbmZmftoezDdZsx8NMUv2/vmFsInUBB/0WSQbmeVoYYQ5A4gIGMf0IckqC
 4kAcyV9l8+HvrKY/u5XCSrb2iOQhmd++vpkqueu5mnX/ad80yJuRsm3HZ3dA9vXV
 aH3mjv/PXZ2R3eiDFD/wY6bfvhEKTK1baWpKRVPShwdOOm725/z3JLVgHG4+2+Qw
 VDs6oFM1RR6Yb3d/5JyVazRxgVSzUUtx8QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 4ErRxGx3EHO6 for <linux-nvme@lists.infradead.org>;
 Thu,  3 Feb 2022 22:28:39 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jqlwf4v8pz1Rwrw;
 Thu,  3 Feb 2022 22:28:34 -0800 (PST)
Message-ID: <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
Date: Fri, 4 Feb 2022 15:28:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Adam Manzanares <a.manzanares@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, "roland@purestorage.com"
 <roland@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
 "dsterba@suse.com" <dsterba@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
 "jack@suse.com" <jack@suse.com>, Kanchan Joshi <joshi.k@samsung.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
 <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_222843_847664_5C706254 
X-CRM114-Status: GOOD (  20.97  )
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

On 2/4/22 12:12, Chaitanya Kulkarni wrote:
> 
>>>> One can instantiate scsi devices with qemu by using fake scsi devices,
>>>> but one can also just use scsi_debug to do the same. I see both efforts
>>>> as desirable, so long as someone mantains this.
>>>>
> 
> Why do you think both efforts are desirable ?

When testing code using the functionality, it is far easier to get said
functionality doing a simple "modprobe" rather than having to setup a
VM. C.f. running blktests or fstests.

So personally, I also think it would be great to have a kernel-based
emulation of copy offload. And that should be very easy to implement
with the fabric code. Then loopback onto a nullblk device and you get a
quick and easy to setup copy-offload device that can even be of the ZNS
variant if you want since nullblk supports zones.

> 
> NVMe ZNS QEMU implementation proved to be perfect and works just
> fine for testing, copy offload is not an exception.
> 
>>>> For instance, blktests uses scsi_debug for simplicity.
>>>>
>>>> In the end you decide what you want to use.
>>>
>>> Can we use the nvme-loop target instead?
>>
>> I am advocating for this approach as well. It presentas a virtual nvme
>> controller already.
>>
> 
> It does that assuming underlying block device such as null_blk or
> QEMU implementation supports required features not to bloat the the
> NVMeOF target.
> 
> -ck
> 
> 


-- 
Damien Le Moal
Western Digital Research

