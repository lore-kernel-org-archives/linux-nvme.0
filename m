Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B7606A335
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3EZwstKZ;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vd8vU0ky
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=d+qbwO8JLYBHznrwAFBQ6dgwqbKLakANhCihu2QkFtY=; b=3EZwstKZvUEz76
	R0ZgNG26UW3jWtDTiBP8xNBYWt658qzeIs4VHMSSWOtNinBHvqgq5mPOHDb/lv8B5D56dIDGUBvqa
	jbQHARujehHly6JlVtph7q39zZ/qGn4sg5RniOVRP1pYLJOHloPXW244qwwG7M+HKv6Izaxvjxqi4
	QpHgIr4TDAKDXHUNcLxWyty2U6JUKJD2TZqclqIju2t1QBCp7HPZu9B76XWw+pfmxqnNxokkOQ8dY
	qVPYW+s6WKOeoL7gzojGc+vmH6Y6pP+c5LfWaBGNUbP+0PRhXTVAabeD7oEDFZhZIA+KFZ3MoN0PM
	BizV5aWGctaAyw6bwy+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLx1L-00000006PAu-1da4;
	Wed, 28 Oct 2026 06:20:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLx1J-00000006PA5-0gvS
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 06:20:22 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4iQ5E227503;
	Wed, 28 Oct 2026 06:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d+qbwO
	8JLYBHznrwAFBQ6dgwqbKLakANhCihu2QkFtY=; b=Vd8vU0kyCEvzkWDfTyrJMq
	9Hx8hLbW2A1e9XbfGK6nwBr5+j+a0nLe4zJ4UHekM5gi9zfjS8SgevHgWoG0g+nY
	fod8iolC0DpyiGkVLwgiwaGeDivYfPMhjGdmzpiWHxhSQos4TWWMfUtpBQsifV9m
	ZwW+v8Mb2ll1Fe+9q+mkwbyPO567XeqxS4rROEdewbIkJhnXWw8cfVx0E9s34Tdr
	iCq4MEyTFiU0sBVJ8q4eqgRYbe9hZNCCiH94/5IwWK8oWkO5ndQY4unFK796pw6i
	rmSvWI7TJa41nq50APOyFxI/60/Tq4YReB0qnylB79tr3ERGpIuI2LHAZxbkJ/6w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mbd91-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 06:20:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4YxuX1030494;
	Wed, 28 Oct 2026 06:20:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7v1rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 06:20:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69S6JJvv38273412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 06:19:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F75158061;
	Wed, 28 Oct 2026 06:20:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3EF58043;
	Wed, 28 Oct 2026 06:20:04 +0000 (GMT)
Received: from [9.61.174.203] (unknown [9.61.174.203])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 06:20:03 +0000 (GMT)
Message-ID: <4bc48dd5-7de8-474b-8989-d4c62f4a212d@linux.ibm.com>
Date: Wed, 28 Oct 2026 11:50:02 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: fix NULL queue->ctrl dereference on
 reconnect
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
        linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@kernel.org, sgogte@purestorage.com, wagi@kernel.org,
        kanie@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20261028024309.1398623-1-christian.aurichzm@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261028024309.1398623-1-christian.aurichzm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyNCBTYWx0ZWRfXxZlAubVGBIOO
 U+t/dCoPSbB68IWq+DXRZ3Q/BkfteG+PMWpKuvk36kNWG6tfexfrNItLTOIIhHErU6wc6H+VkRT
 fWKusE6AWhhjtcExnHWYDF55KuD0NSc=
X-Proofpoint-ORIG-GUID: 70oOXcB3iPk79eBg4xEl6-53-Di7B6By
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyNCBTYWx0ZWRfXxZcdCgzununq
 Lc1EcBlDYVvlegXs0lHB/vYK74tYfOd7xiSvy/bJ12uC3KZ4+sqmmio4EY9MztXhb01XoXBsybi
 9xZZRcuOwjmeSqVHjqB9wVmunmznGmLprBy7g5/YIWnPVX6mgpi2EydN0tw1YFISL2kxNb5iqZQ
 kxVHy3JlWyNYTmnYkqOfbPTGMW/yCvLs8PjJ8YizCCxuXLEwh0DyQXSqx2EDN0Cj3Terhh+F11d
 GLtv1oc7gFKDTa/vX5uhDOMYaMUHQrOVQODFqfJeFnIeGRES2ZIWlqBF7Rqxh2b0Kr7HoR6tUj9
 MmpnwnCdq2GvHL+uaZo+XuHlJInjWM5gdJOlABA4kJft92l+bKCaYq6gFM6uP9Oe46Wc1dNPyTo
 VekXtwNTXIGbpDhfVAc+LTA5FF0a0r3DLTf7unNXJaETLw7dRtdDWjho6SOl8wvKY8gloHFjgD7
 yujL9f8lOa78Xq/e6iw==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae19419 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=sM3CkMq7cFP6RC6SvF8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ik8cs6YatEOKDCRi0KdHcbBtW19cdf4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_232021_333054_234E5CBF 
X-CRM114-Status: GOOD (  15.18  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 8:13 AM, Christian Aurich Zanettini Martins wrote:
> Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
> and startup"), a reconnect that gets more I/O queues than before grows
> the tag set before the new queues are allocated. queue->ctrl is only
> set by nvme_tcp_alloc_queue(), so I/O submitted in between reaches
> nvme_tcp_queue_rq() on a queue that was never allocated and
> dereferences a NULL queue->ctrl:
> 
>    BUG: kernel NULL pointer dereference, address: 00000000000002ac
>    RIP: 0010:nvme_tcp_queue_rq+0x33/0x3b0
> 
> Add nvme_tcp_init_queue() for the queue fields that do not depend on
> the connection and call it for every queue when allocating the
> controller. Such requests are then requeued like on any other queue
> that is not live. send_mutex and io_work move there as well, and the
> helper's mutexes are all destroyed when the controller is freed, like
> queue_lock already is.
> 
> Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
> Suggested-by: Keith Busch<kbusch@kernel.org>
> Signed-off-by: Christian Aurich Zanettini Martins<christian.aurichzm@gmail.com>

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

