Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D29BD0E6C7
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2pxgtrDWmy7eTaSMnEPoviLmQdhhfwo9tIlruuWMXUA=; b=lEQhu8kfRziIAm+/IK4ErYA3V2
	g3ypZf69ZItcAGnbGZvT23Dx197tRL4HzJWT4UestVebGmMSq+vSVlv8OnPxoMuWNODEQ4PlwBR+0
	a/jPQmlTqoAKKtzxqxw5EPtIryNoM8OiKcjJ+rf6Utmj/5d4RyQEQe/94b2ku3SOmyVfAMOjaqD9k
	A8fmJaMcpR2GZSgsF34Xl9O24zQZ40TArwUjlbIdQgt3C1tlFWxUr74cfdU5sQbLw7hY//8sYfHZF
	rUL8xqk3s+5RmJDGayGwxCElFAmOh8cT8deoVpvjhrriHLkfC/H9WzFzIF8nNXFGjaG4uyyU0NnSw
	nU/8Dd/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNrdI-0000000DFXD-26ZU;
	Tue, 25 Nov 2025 11:54:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNrdF-0000000DFWp-3dXx
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 11:54:55 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP85Lru025998;
	Tue, 25 Nov 2025 11:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2pxgtr
	DWmy7eTaSMnEPoviLmQdhhfwo9tIlruuWMXUA=; b=cjbR12Vx6Z+pU+Tuhevt65
	c9dW2YL+cblYfTERImzQc7IIBb+WLVYoRIcoPe8kaXhIjjuEAfGGrXhy0ortbIVx
	jwlznSjOeHl01Sfw3sxxxoKMEfDTfEpmdjh71acpgh8A3fD9xfvcYENL3m1PvEsH
	os6Au+azMQfR6zwCr+CHDOTZomuY+UfLnOrYYJOeb/vS3TEZymGOl2EfYLyJLvUm
	tgERr178hDz8F+O6npcmXWuQlCHVR6EakSllxMjTStHVsa7x8x15dK1UCM+jlImm
	Cu6jo0141cyCLbWVwugAsjwNLPYbWz3J1+Lyaw0t62lC0lHtSAVdnySIYhBSP73Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4phwd40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:54:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5APBbCdH010950;
	Tue, 25 Nov 2025 11:54:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4phwd3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:54:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APBieds030755;
	Tue, 25 Nov 2025 11:54:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgsbuqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:54:39 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APBscio24838408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 11:54:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A7A58043;
	Tue, 25 Nov 2025 11:54:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C7F58059;
	Tue, 25 Nov 2025 11:54:30 +0000 (GMT)
Received: from [9.109.198.169] (unknown [9.109.198.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 11:54:30 +0000 (GMT)
Message-ID: <c6e88bc3-8cc9-4503-a472-7692468ac218@linux.ibm.com>
Date: Tue, 25 Nov 2025 17:24:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "wagi@kernel.org"
 <wagi@kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "xni@redhat.com"
 <xni@redhat.com>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "bmarzins@redhat.com" <bmarzins@redhat.com>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "kuniyu@google.com" <kuniyu@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org"
 <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
 <aSVMXYCiEGpETx-X@infradead.org>
 <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
 <0caa9d00-3f69-4ade-b93b-eea307fe6f72@linux.ibm.com>
 <20251125112111.GA22545@lst.de>
 <234bab6c-6d31-4c93-8a69-5b3687ba9b85@linux.ibm.com>
 <20251125113009.GA22874@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251125113009.GA22874@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX+gB8hFGESNa+
 rLSSySu64nxEfDrxZYQGlQRTgJYxxtncZQw0OF8Rlk0+ZjvrJJO4FsugSBSRvtSjZlOZLGxhvw/
 CLEQxhJSL1ura0xsKksySA0ttslXptDO0+EQbVyfOKVW6JZAwSvPv1eRhGcblGSfUiW20afdTQz
 wi/LRZw8gTtSz4pYNKvHCs3q1BcDYIZ0kFi7FPHuF3miOwrLrIDRKWfYmH4leQyQjgNJOG0AuFW
 HbBbtvXLeI4SeX6LqgKkrbZ6XjIkO/rkdBtW1WL6fD0rUUo2N17Asb+N17XToHQjEF52ne5hqka
 HkR8+X6IiIs4tCvJao7GBfkJ46lcyqfyb9gNjkNTw3bnhfmJ11x4mvxxVTpE9eqjV9hpLgyvpyK
 Ij9UiGqf4fxSrP5fMhQzsKuRQbSCUA==
X-Proofpoint-ORIG-GUID: AEQPSXV2ydGNTqwVbmTapqeQVKAF554X
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69259901 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Dx6jXT7FOQMUIc5gBgQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AyOLiBIDLwXvYgj-rDV-m897x1pRDSHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_035454_090723_E118FA38 
X-CRM114-Status: GOOD (  17.91  )
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



On 11/25/25 5:00 PM, Christoph Hellwig wrote:
> On Tue, Nov 25, 2025 at 04:58:32PM +0530, Nilay Shroff wrote:
>> >From git history, I see that was added to avoid memory reclaim  to avoid
>> possible circular locking dependency. This commit 83e1226b0ee2 ("nvme-tcp:
>> fix possible circular locking when deleting a controller under memory
>> pressure") adds it.
> 
> I suspect this was intended to be noio, and we should just switch to
> that.
> 
Yeah, I agree that this should be changed to noio. However, it seems that
this alone may not be sufficient to fix the lockdep splat reported here.
Since the real work of fput() might be deferred to another thread, using a noio
scope in this path may not have the intended effect and could end up being
redundant. 

That said, I noticed another fix from Chaitanya [1], where fput() is replaced
with __fput_sync(). With that change in place, combining the noio scope adjustment
with the switch to __fput_sync() should indeed address the lockdep issue. Given
that both problems have very similar lockdep signatures, it might make sense to
merge these two changes into a single fix.

[1] https://lore.kernel.org/all/20251125005950.41046-1-ckulkarnilinux@gmail.com/

Thanks,
--Nilay

