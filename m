Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E8AC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178722076A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ShkAyGHH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="goIU3+oJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178722076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q8vJXafVHUKN6wmxLyugHTZV+yLzbLDjkiMFTZyI4/8=; b=ShkAyGHHnvqqYs2GcZz76Bqv7
	XNnTHscw8QWLJ4AFnvFXmZqBIEZSvZ55qP1F0NQWKZokhP1My1cZl5hU0W2lBfW1MQHnPQxIUbc8f
	XcFUqM7EbaF+3DTFinosPYT/D269oTcWZhxc+GnFjAHYjMSCiYl88gzlwgN+gQ7LECJQ/GzRigouM
	C4YVIzgZOm9YRGuGzLv8sB8fKVaGaS/DWdK9LUVJauiOkQ7xdiweNAQNXvnfUAoyrKw0q7Vyr8OH7
	Ha5G4fMIkOiGnYQtIcYJCWfyuHjJn/jm3xUpAEKlyVrjP9e7iO2ui9dC2tuRqb/qOQSFTePHfm3YJ
	Qw/3DBeXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHV5D-0008SM-50; Thu, 26 Mar 2020 16:10:15 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHV5A-0008Pd-1n
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 16:10:13 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QG9MDj105225;
 Thu, 26 Mar 2020 16:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iuO1mn4gIxqF3TN04gXpMSdngDwoXww5axzZXKz9Hmw=;
 b=goIU3+oJ4inKVuAiQEgHmyiYPmTFMqEiz6eHRahkMf79Tl9En2Zd6sFtZjht46pmPUH+
 jL5zOLLSZEAtsZ7OgeBio9rYb/wXmsqsaoH1nfAKPmkeFkV2CqRE9FeJRrj+JoLftDNP
 L5vOU7Ypf5zJWkBj/nyEGWzseVUz/a92MmLAn/baQPD4aXhRjy91Fc26glIEG/f36N3a
 EvTbDKGb9ambWfZZVD7Xa9QnBs6bmlyA09i0tgBy8Tqj1Uc03tOwWBHNwgJnPdLH+EM0
 /MzWWJI1JLWbC3jhqROQHuW5S9lwWZmqQdE1/7GRqzoH4sBnVgcQYT23t0it5bZDmQ34 sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ywabrgsg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:10:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QG7oqR115284;
 Thu, 26 Mar 2020 16:10:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 3003gm4bas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:10:05 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QGA4l3016101;
 Thu, 26 Mar 2020 16:10:04 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 09:10:03 -0700
Subject: Re: [PATCH 01/29] nvme-fc: Sync header to FC-NVME-2 rev 1.08
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-2-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <30b367ca-8f9f-b800-5a3e-3e221eff1e43@oracle.com>
Date: Thu, 26 Mar 2020 11:10:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-2-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_091012_184117_09142509 
X-CRM114-Status: GOOD (  18.98  )
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
Cc: martin.petersen@oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/5/2020 12:37 PM, James Smart wrote:
> A couple of minor changes occurred between 1.06 and 1.08:
> - Addition of NVME_SR_RSP opcode
> - change of SR_RSP status code 1 to Reserved
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   include/linux/nvme-fc.h | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/nvme-fc.h b/include/linux/nvme-fc.h
> index e8c30b39bb27..840fa9ac733f 100644
> --- a/include/linux/nvme-fc.h
> +++ b/include/linux/nvme-fc.h
> @@ -4,8 +4,8 @@
>    */
>   
>   /*
> - * This file contains definitions relative to FC-NVME-2 r1.06
> - * (T11-2019-00210-v001).
> + * This file contains definitions relative to FC-NVME-2 r1.08
> + * (T11-2019-00210-v004).
>    */
>   
>   #ifndef _NVME_FC_H
> @@ -81,7 +81,8 @@ struct nvme_fc_ersp_iu {
>   };
>   
>   
> -#define FCNVME_NVME_SR_OPCODE	0x01
> +#define FCNVME_NVME_SR_OPCODE		0x01
> +#define FCNVME_NVME_SR_RSP_OPCODE	0x02
>   
>   struct nvme_fc_nvme_sr_iu {
>   	__u8			fc_id;
> @@ -94,7 +95,7 @@ struct nvme_fc_nvme_sr_iu {
>   
>   enum {
>   	FCNVME_SRSTAT_ACC		= 0x0,
> -	FCNVME_SRSTAT_INV_FCID		= 0x1,
> +	/* reserved			  0x1 */
>   	/* reserved			  0x2 */
>   	FCNVME_SRSTAT_LOGICAL_ERR	= 0x3,
>   	FCNVME_SRSTAT_INV_QUALIF	= 0x4,
> 
Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
