Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E966C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 14:18:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D650D610A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 14:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D650D610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=r6qTQ6ZFZDR7jTSQkfVakEoO5jhVpZYoMNLGye1N9GA=; b=JPHkCsFxbsh+4MIEnw6rbOi1Bh
	xKP9/k5RCYh1bcX3v3CZ4udrreC9xXlZM61lEEFW9NlESf63eiABZaHE6sLXUNVuaJAOx1OVWFtLv
	EvmAyy5yvyUK+88jJymJKdU8/7HIYXakxdxlqyL+a2EH1jNpKPkbojFNi8fG4zuhGuGTTNMhcaV/Z
	fHFHE9ZGrxkbltvH/PRJ8HvhdBANmjTr12QHCeUcYnbMXw6S9myFJPIwxhxKViQ5fbDmHrSVQMB+U
	qCiKMcpfbP2N/EDu96cGq3ZbsRbXd09cFmVlXqSIs30bodTXcIKvQe+wPrahJpjVPXxwK0c7VZE0h
	qYjj0cgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEBWu-00AQkd-JK; Thu, 12 Aug 2021 14:17:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEBWs-00AQiz-39
 for linux-nvme@lists.infradead.org; Thu, 12 Aug 2021 14:17:55 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17CEGJnZ045815; Thu, 12 Aug 2021 10:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WpwNez1EYtY4fiOuV32GJxS7fXSgheIsQzSCXrQEqoA=;
 b=gByg492G4cjxRynUgjE/HbzZ5PXKx628QWaZlMLLg1yXgIupxseMHa5kz7WazJez5QIz
 9ffii0AhFC7/QI+L8/tnDvMM26SRti4inglvsB5x12GYUb+m7ZXJoNvW07Gdo0A0TL8Q
 sODoNbWIDFGsS0J/Q/CBCXI6PaYOtsFyZ5vKNtLdBzI+3+ZAUfecMGiFu74XjUrWhdAT
 ADk6r7q18mWlJBElhNIw+dMb5xTp/JmTuubvabtVRQkeUFZf7ZakW5KwUbLuESGCHGRW
 Qc35/r4xE+yND+0KZL0eT+Q34X7XrYoVtiPwNm9CJJsIIWHm8Evu0VGCfuymJsuM67nk jA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3ad4hxhh0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Aug 2021 10:17:40 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CE8PlT014290;
 Thu, 12 Aug 2021 14:17:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03fra.de.ibm.com with ESMTP id 3abs263uv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Aug 2021 14:17:38 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 17CEHab755247180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Aug 2021 14:17:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11CF652080;
 Thu, 12 Aug 2021 14:17:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.92.71])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A05C15207F;
 Thu, 12 Aug 2021 14:17:35 +0000 (GMT)
Subject: Re: [PATCH 6/8] block: remove the minors argument to __alloc_disk_node
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>, =?UTF-8?Q?Kai_M=c3=a4kisara?=
 <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20210812074642.18592-1-hch@lst.de>
 <20210812074642.18592-7-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <c0fd949f-45be-679d-6909-3d7df8a29748@linux.ibm.com>
Date: Thu, 12 Aug 2021 16:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812074642.18592-7-hch@lst.de>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XRkQKgieg7AXfxt8m4MZFVqyfgInQ54G
X-Proofpoint-GUID: XRkQKgieg7AXfxt8m4MZFVqyfgInQ54G
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-12_05:2021-08-12,
 2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210812_071754_292361_2309A2C4 
X-CRM114-Status: GOOD (  19.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Am 12.08.21 um 09:46 schrieb Christoph Hellwig:
> This was a leftover from the legacy alloc_disk interface.  Switch
> the scsi ULPs and dasd to set ->minors directly like all other
> drivers and remove the argument.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c                  | 2 +-
>  block/genhd.c                   | 6 ++----
>  drivers/s390/block/dasd_genhd.c | 4 ++--

for the DASD part:

Looks good.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
