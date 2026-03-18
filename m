Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B972FCD0CE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 08:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2flKgAp8/mrqz1EOJgYHHYtPfc5Uvirh5aNRePiDrg0=; b=CBmsjcMyg1nCoHCAa/9R4qjUdg
	LBqf7avfBqOEpRpGoEJmgpdL+zI73jDyhbRjiu0LzHR8xKAoivuNnN/yg7xwP8R7HEkGw+vskQwFO
	/R87NmKFC8jIhZvTeymUwBBqyAuAHtMiBU3svcsjYZNqz/UljkgffR+HQbUwNSHInHbgunYDoliu7
	nfWD4cXutDSs8eVq0ZR9REQbmmtpEKF9O7uzrJs3jz0V+5mYSZi0nhjt5agEKFfN/Me+hWopXhSpP
	AUgSb6IIT9QA9h5cVRIcO5omQV3Xlq0ssncLrHrJ+1uvguiJwP14wKZEHdcPrqUIKdGu5gN6XoOJp
	Id39fpuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2lqZ-00000007ySd-1QpW;
	Wed, 18 Mar 2026 08:01:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2lqW-00000007yRm-0MNW
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 08:01:41 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HJdo4S1093922;
	Wed, 18 Mar 2026 08:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2flKgA
	p8/mrqz1EOJgYHHYtPfc5Uvirh5aNRePiDrg0=; b=T39ElYc2TNotNRVXL/q6c/
	XUZchR0NK2JPo0sRwkdP8ouPU61r/2nxr7AyzsdVZj+K7TinQEOqHu5z6rTRCJ8L
	1WkRYs2WWJC1LiPw6+3ArfjSi9G17bsJ4ycpNphEdtcQm5rGQMVIBq9eyvjK/Ia+
	jYAzw95D+oIoF8SKcuqFax1bCF6BNwplvFnMvJc9PuqDHhmBBxFqH8W7MMy4wdk6
	q5pKHLWHymmq1N2z2rsiKwHs/FhQEkrVlE8nm3RbPyDDlJC0MYpqOe1q/RvSswbF
	CIcqz43UGSZlMqV5LZLnGNU3nBz7AnjNPKwjUkOupnd3993UFo+iMJ28S7p3wNBw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64rxav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:01:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I5jZGd028459;
	Wed, 18 Mar 2026 08:01:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1ct6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:01:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I81QBr58392848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:01:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C31B58062;
	Wed, 18 Mar 2026 08:01:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 780CA5805D;
	Wed, 18 Mar 2026 08:01:22 +0000 (GMT)
Received: from [9.39.24.243] (unknown [9.39.24.243])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:01:21 +0000 (GMT)
Message-ID: <f1c18ac3-6c1a-44e5-907e-e2d804b0d0aa@linux.ibm.com>
Date: Wed, 18 Mar 2026 13:31:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: libnvme API review
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OnMZ373uYaNGkcYP89De78yE5zNHo-Df
X-Proofpoint-GUID: OnMZ373uYaNGkcYP89De78yE5zNHo-Df
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69ba5bd8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=m9LMewaczAMdgEZhSKoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX07P+6628B/Va
 Iw7Wk3k385FVuS01pQMot4lq4Qf55J+WWNYLrgAEgP7AYQevLeQZkvAPDG8Jg5CeG4tter0hMr6
 7BOXU4vHcBVgT7YypYrGgNdZsR33POo9ro4XomJPmmuyyzh8xjMYYjGKP7auiUb5zpJCtdkvbSn
 oGY5XGzegKNAa8R+CAGejk+0Qm1aYoglWFp73lAY+TIzVaVeYTSOWiN7tQO9vf1yaGbCdNjBi3N
 5lfvmGPoBYmHbT4w2wtjHA2Nj/SYxTLZROfEBfUrRJmz8mJ2Hzt4fcB/FnOD6ALr6nXqYz5eTFr
 3cSwGCYSHBNiDdWbwtPf0hLiK3vOfyoIqModGEpmB78XPUVJ8p0OyCOUVKTrT678V31qTVJ+SoS
 VAdWJYtA0pd6zjbOfh4MnDam25z0Tz4NhpJGOYntgPM2ELLilJjK8ZRjvBY+P84dEj6J6pWP969
 oKRIhRpynJAUxY3apjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_010140_464665_EBBC714D 
X-CRM114-Status: GOOD (  21.84  )
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

On 3/16/26 3:57 PM, Daniel Wagner wrote:
> Hi,
> 
> For the upcoming v3.0 release of nvme-cli and libnvme, I would like to
> get some feedback on the naming scheme used in the libnvme function API.
> 
> The goal is to improve consistency across the library. Below is a table
> comparing the current names with the suggested new names.
> 
> Functions are grouped by common prefixes:
> 
> - Generic top-level functions use the nvme_ prefix.
> - Object-specific functions use the object type as a
>    prefix (e.g., nvme_ns_).
> 
> The prefix is typically followed by a verb, such as nvme_create_ctrl.
> 
Following the verb after the prefix looks good to me, as it aligns well
with the kernel naming style. While aligning fully with the NVMe spec
API would likely require a significant amount of cleanup, improving
consistency within libnvme is definitely a step in the right direction.

Since we are already considering API changes for the 3.0 release, I’d
also like to raise another point regarding non-cached variants of some
APIs (perhaps only for a subset where it makes sense).

Currently, most libnvme APIs return cached values for attributes. While
this is efficient, there are cases where a real-time view (for instance,
nvme-top) is required. For example, retrieving the current ANA state or
I/O policy may not be accurate if we rely solely on cached data (e.g.,
nvme_path_get_ana_state() or nvme_subsystem_get_iopolicy()).

To address this, I’d like to propose introducing non-cached variants of
selected APIs, for example:

nvme_path_get_current_<attribute>
nvme_ctrl_get_current_<attribute>
nvme_ns_get_current_<attribute>
nvme_subsystem_get_current_<attibute>

where <attribute> could be path ana_state, iopolicy, or other
attributes where fetching the latest value from the device or kernel is
important.

Does this approach (naming) make sense?

One another approach would be to always return the current/non-cached
value using existing API and then we don't need new API. I think this
could be reasonable considering the existing nvme-cli commands are
typically oneshot, and so it doesn't matter whether we return cached
or non-cached value.

Alternatively, are there better naming or design approaches for
distinguishing cached vs real-time queries?

Thanks,
--Nilay

