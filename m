Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A871C369CA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3Cf4+5znQawmv06mXcSZw7fd4AQqZlTEDiNv9WvQ7E=; b=syWCi8MqXDbmMjPQPSIVBsRtoi
	t7/9F55GnXkC9KCm0BaK5uDXdbtKGONBrycx57uKWp1w5c+5Dyh7zIyySOicIwNMzrZPguQGavvYH
	BYVQ/EaYXodVNGhAkruRVrG7yqh7sgMOVutbYdYZfovPlr4poAFWCW4kVpkTFT+fKRSOy1jw14VQb
	QWTD5tUPNGqjw5aNDhIqEKPlS/1/FLg8dp6o7iTkUySILFy6nXiTHGZ640Lg+bhRf5jIIEzegyXdN
	wMW8Pe8asfIessODmiIXHy8omnZLWIWow9nxLw5bq4luleptvytzK/Iyw0RPIeo77QWttGqCXKcAa
	T7B1vBvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5mbu-0000000GPLa-0BLT;
	Fri, 18 Apr 2025 14:22:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5mbs-0000000GPKJ-1n5E
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 14:22:29 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IBTCqK019255;
	Fri, 18 Apr 2025 14:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a3Cf4+
	5znQawmv06mXcSZw7fd4AQqZlTEDiNv9WvQ7E=; b=AWGHqNabuZ2brhDVBwuPJW
	+PhC3/amIm23nDWsrhFUxEyCmrkxfsH41xqYfF/lOGd/w0HY5qxrLCbQAOFN+Az1
	8+Xpl37jwElZ16lBVbPS6t7Dm98vddYqvXMn99VrtH7NY+ZLFbxvdwmn1Jm+hdNQ
	wUa9dTwTfM8aZeAmzMTGWgum0C3pOn6FiANFHwkq5jdsNRhluZCG2oHP/If65Kr6
	Pe5QailIcwyPuZWHGyYCKPIkIWSfC4LSTUxB7mdJWC/ZxfgLgbELXMguHyQukGC2
	iUz6GMRgecss1VmUwe7ArsSi8xxM0sv1Vyfh88ayjzTjbfc0R96ixZBxzO8Dc57g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 463bm12vk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 14:22:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53IDCkot016722;
	Fri, 18 Apr 2025 14:22:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460572jput-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 14:22:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53IEMAFt26018494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 14:22:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05D8858052;
	Fri, 18 Apr 2025 14:22:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654BB58056;
	Fri, 18 Apr 2025 14:22:07 +0000 (GMT)
Received: from [9.111.33.1] (unknown [9.111.33.1])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Apr 2025 14:22:07 +0000 (GMT)
Message-ID: <e50e568c-9a9b-4306-a2f4-e108791e83d2@linux.ibm.com>
Date: Fri, 18 Apr 2025 19:52:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-3-nilay@linux.ibm.com> <20250407144555.GB12216@lst.de>
 <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com>
 <20250409104515.GB5359@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250409104515.GB5359@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WaUMa1hX c=1 sm=1 tr=0 ts=68026014 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=_EqFHIO4WOhHW-ejzvAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZPMG74TzNc1ujRm5jyNMKy-f8Dmr2jay
X-Proofpoint-ORIG-GUID: ZPMG74TzNc1ujRm5jyNMKy-f8Dmr2jay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=716 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_072228_597798_BAE3E512 
X-CRM114-Status: GOOD (  18.47  )
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



On 4/9/25 4:15 PM, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 08:05:20PM +0530, Nilay Shroff wrote:
>> Okay, we can add an option to avoid making this behavior "the default".
>> So do you recommend adding a module option for opting in this behavior 
>> change or something else?
> 
> I guess a module option as default makes sense.  I'd still love to figure
> out a way to have per-controller options of some kind as e.g. this
> option make very little sense for thunderbolt-attached external devices.
> 
> But unfortunately I'm a bit lost what a good interface for that would be.
> 
> 
I don't know how to make this option per-controller as you know the 
head node, typically, refers to namespace paths and each path then 
refers to different controller. So if we were to make this option
per controller then how could we handle it in case one controller has
this option set but then the another controller doesn't set this 
option. It could be confusing. 
 
How about module option "nvme_core.multipath_head_always"? The default is
set to false. So now it becomes two step process:
1. modprobe nvme_core multipath_head_always=Y && modprobe nvme
2. echo "<val>" > /sys/block/nvme0XnY/delayed_shutdown_sec     

Thanks,
--Nilay

