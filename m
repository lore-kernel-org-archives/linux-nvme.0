Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B507C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cMM0idsEJr83/PrPivmFAzRkmCb1VrP5L69aJgBqP8=; b=oNM3h+Dg5EXzIHEvkvN4iS/5J2
	Vf/qzZvcDx99DTt8qqYnMmeW9Gfnpj0UrFVaiP/DMW7MuuUfZ5U9Deu9andOp/ECIHLvMAbNvlwDu
	r/cS6Can2QkBa8ML8XA7eCQHZlE9Jjr1XmsPh3vyKzgK3N/KV3LRohtI4PkSffokrC51OIhauYoHr
	pn+jsJrxp9d83D13gcE3loIIQq5TZNJ4oTVMpU5eLxPXdadopvQmwzhR3X7U4NCY6yaqdOEFvx9CH
	TyQ3FrxVjO4QSQJSwvGWTKnSveQxxHUOUSqG+2WD8pAgFU4RUF7Tyn7+SAd3ERxrPPZ533G0qanaz
	CTkydeSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZKW-00000001L1q-1VKH;
	Mon, 21 Sep 2026 08:24:52 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZKT-00000001L1F-2R3j
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:24:50 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZdKm863256;
	Mon, 21 Sep 2026 08:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4cMM0i
	dsEJr83/PrPivmFAzRkmCb1VrP5L69aJgBqP8=; b=GsWQClP/HJsG3xFa6YbX0Z
	p4+Sr8YEPyhDOvvBwzpkdcTr9t9vv6ul0P0uXF0s2llWKe5cwn3iLRTOhYRBNlOH
	sokd3LbxXRu2E8LW7FlvaCH97IiPOZBV4BX8r+Y/HhJnGLgBqKy33Nq1ldZywKq8
	fJRpLEj3TjLEQAZTu8ZQT+cBrXIW6GA8l+fCoeJUx+3Yzb8dkjcqg73eSXUvlQaI
	fWTu2VIeeZgQsBUu/AtsQhxzJB8H5k1keYP5sdb4xJLrDAIAj102RBFij3P3zrRQ
	jLQzdcEOIRIgFC3DmR5kajYs+yZoIxC+OD/LvuS8s9/wY+yob1elNp8kQS1wxz/w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduyc76-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:24:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HlQE867898;
	Mon, 21 Sep 2026 08:24:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vcj8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 08:24:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L8OhGb29426404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 08:24:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70DBA58063;
	Mon, 21 Sep 2026 08:24:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0C5F58059;
	Mon, 21 Sep 2026 08:24:40 +0000 (GMT)
Received: from [9.61.138.180] (unknown [9.61.138.180])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 08:24:40 +0000 (GMT)
Message-ID: <0834a7d2-dfcf-4c3b-8588-f46dcd42319f@linux.ibm.com>
Date: Mon, 21 Sep 2026 13:54:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmet: return Invalid Field for invalid NSIDs in
 Set Features 82h
To: Christoph Hellwig <hch@lst.de>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>, John Garry <john.g.garry@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <20260920033500.3209138-1-kanie@linux.alibaba.com>
 <20260920033500.3209138-2-kanie@linux.alibaba.com>
 <baef058e-a502-4263-8d3d-1ad0a9550826@linux.ibm.com>
 <20260921065311.GC13667@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260921065311.GC13667@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: eQy7-6a4sA7kR_BX6Cy1yrPO4qvfd5sh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX1gGimVyy9Z+J
 i8Uo3BmINdolUEZ8ipGoSY6VRa0HnxS7sjp9zHzIp4LIQMhkowzYcld3anx1/Q1Sp3F+W5bc7dC
 1S8d+aAzYaQL7/pojkiarPzAv3LX+j8=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0e9cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=5iMLY1haVbahYNI8RJwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: M92QKZHFBjIBs-SxiIcIIFVEInmP7lLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX8dQWJ9TIJv2S
 T7hWyUArsmtHaUNTYlFWAA/UbMr++HgilKV9KP9cG0GROE/xozDN7KwrSyBpyEaiCLg0mqar8xv
 Ss4/qbVQvUxqYtkltTTQyDLWEE2oQalqtezYknayFlaZhwwBxKN1ZnTOURt5fOWibljAAeM3lkD
 7rEwAtQCrDm6ni4PIMeImtVVl7QRLcQ4P5TFpC1FG76er40SBYEwTt2uQbOS+olugygmey8UfGe
 R6i6rNN3IbRNGdxMbaZ1ZJlDYa2IJt+XCR/Lht4HBxTv7FFFd9MrCZFPvEfAo+xkjMd3UYFCyqm
 D+1RcbsohGZ2xvKrk+3a7Y6TvJKpsyJT7uRL5RSM9TTOE/dvb8gfPJ6lyfayZ+Prt1lIIF7hbkv
 BfbSHtFgm3rLq6HJ9mG5IihJI7KhhjKyeEgkYPS6LkzDraBZY2/si72ZnejtrfdTVMUuNkMznk2
 ytOhmfbWoLxKkhq6New==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_012449_743656_A878428A 
X-CRM114-Status: GOOD (  25.27  )
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

On 9/21/26 12:23 PM, Christoph Hellwig wrote:
> On Sun, Sep 20, 2026 at 04:37:08PM +0530, Nilay Shroff wrote:
>> On 9/20/26 9:04 AM, Guixin Liu wrote:
>>> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
>>> index 0948a690a1c0..a36c732883d4 100644
>>> --- a/drivers/nvme/target/pr.c
>>> +++ b/drivers/nvme/target/pr.c
>>> @@ -51,6 +51,8 @@ u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
>>>      	if (nsid != U32_MAX) {
>>>    		status = nvmet_req_find_ns(req);
>>> +		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
>>> +			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>>>    		if (status)
>>>    			return status;
>>>    		if (!req->ns->pr.enable)
>>> -- 
>>
>> This looks good to me. However, to avoid hand-coding the same error
>> return code multiple times in the function and to make it a bit more
>> readable, how about modifying it as follows?
> 
> I don't understand how that helps.  If we really want to refactor,
> we could add a version of nvmet_req_find_ns that does it, but
> that feels like a bit of overkill.
> 
I agree that adding a separate helper just for this would be unnecessary.

My suggestion was mainly for readability and to avoid repeating the same
NVME_SC_INVALID_FIELD | NVME_STATUS_DNR error code and keep the error
handling in one place. I also found the two status checks a little
less straightforward to read. When applying the proposed patch, the
resulting code looks like below:

u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req)
{
	u16 status;

	status = nvmet_req_find_ns(req);
	if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
	if (status)
		return status;

	if (!req->ns->pr.enable)
		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;

	nvmet_set_result(req, READ_ONCE(req->ns->pr.notify_mask));
	return status;
}

That said, this is mostly a matter of personal preference rather than
a functional concern, so I'm fine with keeping the current version if
everyone agrees.

>> 		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
> 
> Still no need for the inner braces here in all versions.
> 
I think Guixin has already replied to this comment in another
email. The inner braces are required here otherwise compiler
would complain:

drivers/nvme/target/pr.c:80:35: error: | has lower precedence than ==; == will be evaluated first [-Werror,-Wparentheses]
    80 |         if (status == NVME_SC_INVALID_NS | NVME_STATUS_DNR)
       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^


Thanks,
--Nilay


