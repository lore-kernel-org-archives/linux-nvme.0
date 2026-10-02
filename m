Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8552CCA5FC4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YV8UCPbm76hlqNKr81ZILfnsAPwDNuMHQXEfnCg2yZw=; b=sx1Zc9WOUqAFFOmjcJrvLRcmmE
	h+3Vq7++ixAHpQhIpAMJDzFwTlQz+tFGDBw7fcipDGTFHTi7CyB99JAC8fkhClu/LdnOeAAccWG26
	IM/oLdO8TLIh19eyiFRi5rp4Gfs5aYlf14yBuvU3zxO8zZWEjlGQEmuYjETyvTdS5ZNM0alzktPYx
	l6H6aXc5VuIUWrFvjq7DdYeQUmBfylzuU4G8bZgGWmfIpST/nTHXqCOwLreDfvUUwO6wycF9zPnPf
	Y3pc3E41QL0wYNAnfkp1vgn7Xo8m+NWFWP7gm7s9b/EPFTfVaNGQsECNBqqA1ZAuMVXg491nczjNL
	tS4l5snQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCboy-0000000BWDS-3WWb;
	Fri, 02 Oct 2026 11:53:00 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCbov-0000000BWCx-3pQ4
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 11:52:58 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692A5RZO243084;
	Fri, 2 Oct 2026 11:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YV8UCP
	bm76hlqNKr81ZILfnsAPwDNuMHQXEfnCg2yZw=; b=cbmjnbPUGLTOjIByjegIJ1
	H3lYVEDr0A6jre8ff0OjQmZieWkbL9IZ7qpnJHWt0SRtSOclX/5PMrjnw8jhhRGm
	V3bptlO52aCpigW5YdbnQ2sEuhbBBmcroWhgin22ivdY0D8bEyUsx8O68VtSbRjp
	y+hjUbmYOmTuWcasci9fVkywYcu4EMRfKCG8eCIO3P8Ex7FCjn6zz+IyEFv2S5cI
	LDIS7jsizMPRJwImqPYpL8zl7SkrVCqyf2gn/Qe7W8MxJg02NN+LG8N6KwomlVtp
	aM06YJCefmSYdlvkaAH3/x9IICEki7eFI9NmEXRVGp0LpHE/rXoNFVzA6i0d+GzA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5s5yr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 11:52:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6929lbeJ2312715;
	Fri, 2 Oct 2026 11:52:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2djjns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 11:52:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692BqkQT33227472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 11:52:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB4DF58058;
	Fri,  2 Oct 2026 11:52:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C791958057;
	Fri,  2 Oct 2026 11:52:43 +0000 (GMT)
Received: from [9.61.28.159] (unknown [9.61.28.159])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 11:52:43 +0000 (GMT)
Message-ID: <573b1136-7fb1-4457-b5a9-9ee07e0c07ce@linux.ibm.com>
Date: Fri, 2 Oct 2026 17:22:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] nvme-multipath: add fail_if_no_path sysfs
 attribute
To: Krishna Iyer <kiyer@crusoe.ai>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        saravanand@crusoe.ai, sjpark@crusoe.ai
References: <20261001094857.74567-1-kiyer@crusoe.ai>
 <20261001094857.74567-3-kiyer@crusoe.ai>
 <4a4e228f-7143-4d5a-b773-2c6238852503@suse.de>
 <20261002105612.25298-1-kiyer@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261002105612.25298-1-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0NiBTYWx0ZWRfX0Cv7lmH5ABdC
 XMGDFqIChG9ty6CiRIJEOzlw21UpkKz14egmYEOO6AThUVMlA+m+mIF8l4P38rCgJN40Xu4BVbH
 mgg5U0MS7YcFE8QE2Y5m9ibmdrw230A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0NiBTYWx0ZWRfX+q5xhCOUv0O7
 V7wZgisEZoY3EJhnoumb8SmM8raQPfEFa6M3evCEYiJF2kxf+BbT/qV0URCUXzJCNreeYtv79b0
 Ehes1eL821wai+8l+t8NEs+NOVBC69RqI3i1cT8+4be9iCvbZe9EYnsDmYxbzm6OaT3D+IbkxQM
 hPkv38mSTCZFlvCc79SuOr64yLV+iYyXyc+UcGQOul11UXuybol95n71JmUPNkWSErzG8EkXhDD
 i6Dhi/PbT/lsVN9Sm3rde21gdYSxb07SIhltJlvcPPO3VBK1F0FrQlF22EAyUUZ2R/flOelV20Q
 boVUDlN+f4cisMyejBhwTFUyoz/DvR7d0JECtWr8JSZVciitm4I++Wk110ksRupA18mHb4FDUHR
 m8jOB9RVS8S16TRpxjDHG0K/6ArGoLycVYY+w0Ko++G/8dANLY0YJ1RqSrnUuGXcP50ZCsi5SON
 0TRLwcEuf/8vWmnBSsQ==
X-Proofpoint-GUID: mAPZQsDCx287cqa2V_-IhvhI110W83eQ
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abf9b10 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=0gLi0y45t31yEeiaKmAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mAPZQsDCx287cqa2V_-IhvhI110W83eQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_045257_965211_F96074D7 
X-CRM114-Status: GOOD (  22.08  )
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

On 10/2/26 4:26 PM, Krishna Iyer wrote:
> On 10/2/26 11:39 AM, Hannes Reinecke wrote:
>> I do get the problem, but I think that 'fail_if_no_path' is a misnomer.
>> Problem is that we already have a 'QUEUE_IF_NO_PATH' setting, so
>> 'FAIL_IF_NO_PATH' really sounds like the inverstion of that.
>> Only that it isn't.
>> Maybe rename to 'FAIL_ON_CTRL_LOSS' to make it clear that the two
>> settings really describe different use-cases?
> 
> Agreed, and thanks. You are right that fail_if_no_path reads as the
> inverse of queue_if_no_path when it is not, and the v4 split makes that
> clearer. Patch 1 now fails the cases where a path exists but cannot
> serve I/O, so the only thing this attribute still does is stop waiting
> for a controller that is gone or reconnecting. I am happy to rename it,
> and fail_on_ctrl_loss describes that well.
> 
> One piece of history worth surfacing first. The fail_if_no_path name was
> Nilay's suggestion in v2, so I would request we settle on one name you
> both agree on rather than change it twice. Nilay, does fail_on_ctrl_loss
> work for you?
> Yes, I also like fail_on_ctrl_loss as Hannes suggested.

The earlier fail_if_no_path name came from the dm-multipath policy, which
uses the same name for a similar use case. However, I agree that fail_if_no_path
could be misleading here since it sounds like the inverse of QUEUE_IF_NO_PATH.

So I'd vote for fail_on_ctrl_loss for this change.

Thanks,
--Nilay


