Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E187BC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 14:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EA7206F8
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 14:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T07HYB9w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWL1A4Ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EA7206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g2vMPnPXRg1IF2hvcevwc8z3RP9qqRELxhfVKuL2MBk=; b=T07HYB9wgq6wNqfYxgwj3olLf
	XteehnHgjdOFA1TRBLQVxPVaKQ8zugCjQxY6yRU17H7x8XzDnbmB8nHQgafuTFB137YuFigYcQm0f
	kV9Xuq196RxXZQLjuOjj84orkqfJ9Lfv2OViP49rPhhP358NIikZIx0B2GM8tqmrB57Q1kwonBuyI
	UC26r+fEdaGzla05qaNtKsW/aHIcm/XvOABwoMaG9tR+QDSJKB93aAH4UB5aIaXov0GfFbMcsDGkK
	KnGOIiZzRkVsB8bO83QyU1Z1UFHMIH3vnQphSKzMr3MdpThxcjBypCg3mTF9+PIkZ7hUGACwfIAB/
	TWTfSu3GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHTC8-0003IO-1z; Thu, 26 Mar 2020 14:09:16 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHTC5-0003Hv-9D
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 14:09:15 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QE3FFc136961;
 Thu, 26 Mar 2020 14:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=o1XZHcB7pSZL7/vmkWnbLLK2uOf0YT25UGbFFXjerEg=;
 b=HWL1A4Ik7cv5uEFYCmvepDQY3GFDucqRSw/FxxV6rtyVKuUrurxX3IkjYmnSEfq4j5tY
 rE+AdY2mKuSzdlNAKt398x3Pl3VKih7HeSn3hFaPJ12D+iiG+qm2Z9943sI0esToZAHH
 c/roWi8buTRCmGGmnFSyzGzOact/NC7abcJbg5nQ2E1SqZWoZE9HAUiIGa3nD4FPn+QX
 st2N8ggmfDLXhxYZe4hkTv8vNS11p5SIIBgicvY11iFURNGQVWt5bi+/BqjxYccjy2lm
 fwjkx8E+4b070qwC4pRCjlg5qKA+NgFwFV7gx3cmsatZwEmXvqsXRWmOqzXfl4dGWlyj ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2ywabrg10u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 14:08:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QE6W9u164877;
 Thu, 26 Mar 2020 14:08:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2yxw4tqqqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 14:08:56 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QE8sev027968;
 Thu, 26 Mar 2020 14:08:54 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 07:08:54 -0700
Subject: Re: [PATCH] nvme/fc: use real sqsize as argument when connecting
 queues
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20200313124808.39320-1-hare@suse.de>
 <20200316174819.GB1069991@dhcp-10-100-145-180.wdl.wdc.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <8a7d1fcf-7e72-d41d-141d-f05d330b76f8@oracle.com>
Date: Thu, 26 Mar 2020 09:08:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200316174819.GB1069991@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_070913_408687_A0DF5B23 
X-CRM114-Status: GOOD (  22.25  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/16/2020 12:48 PM, Keith Busch wrote:
> On Fri, Mar 13, 2020 at 01:48:08PM +0100, Hannes Reinecke wrote:
>> When creating queues we should be passing in the real sqsize number,
>> and not increasing it by one just so that the function has to
>> substract it again.
> 
> Kind of makes me wonder: why are we even passing the sq size as a
> parameter at all? The 'ctrl' parameter provides the same thing.
> 
> Anyway, this looks correct to me.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/fc.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 0cbc4a703359..f76325a47578 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -1211,7 +1211,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
>>   				sizeof(struct fcnvme_lsdesc_cr_assoc_cmd));
>>   
>>   	assoc_rqst->assoc_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
>> -	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize - 1);
>> +	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize);
>>   	/* Linux supports only Dynamic controllers */
>>   	assoc_rqst->assoc_cmd.cntlid = cpu_to_be16(0xffff);
>>   	uuid_copy(&assoc_rqst->assoc_cmd.hostid, &ctrl->ctrl.opts->host->id);
>> @@ -1326,7 +1326,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>>   				sizeof(struct fcnvme_lsdesc_cr_conn_cmd));
>>   	conn_rqst->connect_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
>>   	conn_rqst->connect_cmd.qid  = cpu_to_be16(queue->qnum);
>> -	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize - 1);
>> +	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize);
>>   
>>   	lsop->queue = queue;
>>   	lsreq->rqstaddr = conn_rqst;
>> @@ -2484,11 +2484,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>>   		goto out_free_tag_set;
>>   	}
>>   
>> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
>> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
>>   	if (ret)
>>   		goto out_cleanup_blk_queue;
>>   
>> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
>> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
>>   	if (ret)
>>   		goto out_delete_hw_queues;
>>   
>> @@ -2539,11 +2539,11 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>>   	if (ctrl->ctrl.queue_count == 1)
>>   		return 0;
>>   
>> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
>> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
>>   	if (ret)
>>   		goto out_free_io_queues;
>>   
>> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
>> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
>>   	if (ret)
>>   		goto out_delete_hw_queues;
>>   
>> -- 
>> 2.16.4
> 
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-nvme__;!!GqivPVa7Brio!Nq4LNDhkMZWjyk8xoSpCsvNM0d4IkwCW8FvAYtlC0EdnTSGaTFWKMr5Bo6B9vK2VAUxX$
> 

I lost track of original patch email. if its not too late.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
