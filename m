Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE7C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 15:03:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2719E2074B
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 15:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S02UgE2O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yyTNCUti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2719E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vbe4mq2F+vVwXbE0d7yN+2kh6JngFIOTuV/i+oYf8DY=; b=S02UgE2OHGh2VADhYDLx/iebO
	xyAtL8hBpR/aiv+uwKY/PlijDbhFSth8JmZyJi11GPuORsxqq5uVUHX3d0axQHOmaLys5vPSlbTNz
	KZ6rx3S6jikUzCk8LmlsKYclRYHyA7xwUgHKJtBBVPla0ex/r7+vKTHrT9x2vh/Za55SMPl/B8LBD
	eeKYlYY2bYCgtVf8OljDyTnab03bUeunDOE+Kk3d83g3tPDsldKCdqDp1hyJOh6onylJuFHKg3mHY
	I92k2a8q7Zw2xcDu8wItrzB9IL9DVNZk1s1qI+NmkU0vIEGNDjbbo/Gr8Ygi5pOcDQngtH4d7OPyi
	0+l8vFSzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg8Rv-0000o5-7X; Tue, 02 Jun 2020 15:03:31 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg8Rq-0000ne-Cf
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 15:03:29 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052F24d4052321;
 Tue, 2 Jun 2020 15:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=R/DYq5OZFkloIhAthTCk6nzCEvNol4ml8VsAGoJHE0c=;
 b=yyTNCUtiCszNMT1hPFFakFa5UkM8r4YZGjsMq/5/6ECW1hzG1fjr//u46sidDJPZ+h2m
 3q10P9ZoFpdbt/JrUW4gDVB4EDpOLpFUi6lZeGdOHi9wEYa+O9ZXWdTLrio9R6+Pj43w
 R8sA7DSQrcbk9CN+A135WH3cebUNlaYbknGCZZM5fSfhUuEdxEMa8sEmZ0/gzC3GDM6+
 QAzsqdO30L1J08+s/zn9kti4bLFDo1EpDco8Cg/IVHoK9IJrTGQesTNRmo7i31Ao6Y/I
 csc3YbWvGK7Sb9vC40uyV3v/hCczEQ5V91E87pSjW7CO+ccaXmc7redWdkP5U/irZs7I JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 31dkruhjud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 02 Jun 2020 15:03:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052ErxE4084492;
 Tue, 2 Jun 2020 15:03:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 31dju1mdh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jun 2020 15:03:09 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052F38tL007819;
 Tue, 2 Jun 2020 15:03:08 GMT
Received: from [10.154.114.83] (/10.154.114.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Jun 2020 08:03:08 -0700
Subject: Re: [PATCH 4/5] nvmet-tcp: remove has_keyed_sgls initialization
To: Max Gurtovoy <maxg@mellanox.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 james.smart@broadcom.com, chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-5-maxg@mellanox.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <20e844e9-6784-ca79-7a23-04baa2880c16@oracle.com>
Date: Tue, 2 Jun 2020 10:03:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602131546.51903-5-maxg@mellanox.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200602_080326_509183_42ADD796 
X-CRM114-Status: GOOD (  19.52  )
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/2/20 8:15 AM, Max Gurtovoy wrote:
> Since the nvmet_tcp_ops is static, there is no need to initialize values
> to zero.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Israel Rukshin <israelr@mellanox.com>
> ---
>   drivers/nvme/target/tcp.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 9e4cb90..3099237 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1751,7 +1751,6 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
>   	.owner			= THIS_MODULE,
>   	.type			= NVMF_TRTYPE_TCP,
>   	.msdbd			= 1,
> -	.has_keyed_sgls		= 0,
>   	.add_port		= nvmet_tcp_add_port,
>   	.remove_port		= nvmet_tcp_remove_port,
>   	.queue_response		= nvmet_tcp_queue_response,
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                     Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
