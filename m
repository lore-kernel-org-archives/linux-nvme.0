Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B39FC48BC1
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CnFd8ajdxH/cc7VfH42WSgZbWCF+UOq3S7aRofknueM=; b=pzqm6VdXa9oVYXl7S7zj1y+SfI
	tpxuTvJGvjft/DNUvsG/BEkIRUakhxkwQHMh+dzajPB7sfb7shbx6xO483z+u+nF7fh8LwyoZlOaM
	montvFJiZBvWIEtYbQVE8dRygQAM0mk4JKlUqEcNo3m4bMvleUOa/AtKfIO0jO8+g9Uey4Bsw804p
	GFS9j4cl4nyrIt0SmfoELDCQH4GQET1IIf+VNYILfPXzy9so2UkpvQYH1iY48iH9qCbFLXH3usGLu
	NfxAca24jwum7qZz/BWewr0uAMzA+TWUiCYHE9TFYS5ku29IZ4b84qN75BIn6kCc6AA/C2LxsBuxr
	af+lnYgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raIOy-0000000DaY6-0Ep4;
	Wed, 14 Feb 2024 16:46:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raIOu-0000000DaWf-3klt
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 16:46:26 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGHqX8020289;
	Wed, 14 Feb 2024 16:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CnFd8ajdxH/cc7VfH42WSgZbWCF+UOq3S7aRofknueM=;
 b=PgkUDikRjBI7x1XiMVyE0fJUYWDpQqAWw6+G4Pyiqbl2T2I1RZ86XjhckO6udra17/M/
 xO6IN7AaFdVFfYDaD3qsrszVlpVR/aziLc5CaLvEERwTPALyRVkd9nVcorjDUXbt8hic
 7mpJuJLmIXxNZfDufey4LX1BFiPGUpQ85e4c+oQUr257ca3vtBjXxjNZ7bzDOPneA7Vc
 GJS8TwZ/4AxlNh+LWmx2BgZSXyiv9+HVpQ0Q+MY8moz6+xX7KENbXsR252mx9jP33rh8
 BqACwl6rJ1QuUcogFxmLXF7onc+wibvex1Zq1CvzKCWTn7P+iNymsZbuB2qFLibyMzsa eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w90wp0t8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:46:05 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EGJgtK025776;
	Wed, 14 Feb 2024 16:46:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w90wp0t7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:46:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EFVq07032572;
	Wed, 14 Feb 2024 16:46:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kftq9yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:46:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EGk0Oh5047142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 16:46:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 568CF58068;
	Wed, 14 Feb 2024 16:46:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8692558059;
	Wed, 14 Feb 2024 16:45:52 +0000 (GMT)
Received: from [9.171.46.73] (unknown [9.171.46.73])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 16:45:52 +0000 (GMT)
Message-ID: <1b4d5860-8044-4a1f-a801-1c69327076c1@linux.ibm.com>
Date: Wed, 14 Feb 2024 22:15:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>
Cc: alan.adamson@oracle.com, axboe@kernel.dk, brauner@kernel.org,
        bvanassche@acm.org, dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        jack@suse.cz, jbongio@google.com, jejb@linux.ibm.com,
        kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, ojaswin@linux.ibm.com, sagi@grimberg.me,
        tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-15-john.g.garry@oracle.com>
 <20240214122719.184946-1-nilay@linux.ibm.com>
 <8332ea29-ac17-4b1a-8ed9-e566d03fd220@oracle.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8332ea29-ac17-4b1a-8ed9-e566d03fd220@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xU5wfFpy2PP06fiDP3H7bm7SCO6PKL-V
X-Proofpoint-ORIG-GUID: BUhw35l4XwdwCK0voJZlxVR65GvJzXIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_084625_074409_CFC7D83D 
X-CRM114-Status: GOOD (  23.00  )
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



On 2/14/24 18:32, John Garry wrote:
> On 14/02/2024 12:27, Nilay Shroff wrote:
>>
>>
>>
>>> Use following method to calculate limits:
>>
>>> atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
>>
> 
> You still need to fix that mail client to not add extra blank lines.
Yes, I am working on it. I hope it's solved now. 
> 
>>> atomic_write_unit_min = logical_block_size
>>
>>> atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
>>
>>> atomic_write_boundary = NABSPF
>>
>>
>>
>> In case the device doesn't support namespace atomic boundary size (i.e. NABSPF
>>
>> is zero) then while merging atomic block-IO we should allow merge.
>>
>>  
>> For example, while front/back merging the atomic block IO, we check whether
>>
>> boundary is defined or not. In case if boundary is not-defined (i.e. it's zero)
>>
>> then we simply reject merging ateempt (as implemented in
>>
>> rq_straddles_atomic_write_boundary()).
> 
> Are you sure about that? In rq_straddles_atomic_write_boundary(), if boundary == 0, then we return false, i.e. there is no boundary, so we can never be crossing it.
> 
> static bool rq_straddles_atomic_write_boundary(struct request *rq,
> unsigned int front,
> unsigned int back)
> {
>     unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
>     unsigned int mask, imask;
>     loff_t start, end;
> 
>     if (!boundary)
>         return false;
> 
>     ...
> }
> 
> And then will not reject a merge for that reason, like:
> 
> int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
> {
>     ...
> 
>     if (req->cmd_flags & REQ_ATOMIC) {
>         if (rq_straddles_atomic_write_boundary(req,
>             0, bio->bi_iter.bi_size)) {
>             return 0;
>         }
>     }
> 
>     return ll_new_hw_segment(req, bio, nr_segs);
> }
> 
> 
Aargh, you are right. I see that if rq_straddles_atomic_write_boundary() returns true then we avoid merge otherwise the merge is attempted. My bad...

Thanks,
--Nilay

