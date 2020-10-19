Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B04C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:56:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E9D222D9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gu6TV8yW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zxxEqYhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E9D222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lu8tFgR7nxLIu76yIr4+vrkEB574mG9YEY5dRAdox8s=; b=gu6TV8yWxPwFZ92z1F6rDBix/
	irN9QJlr3vbzPQQ+DI+pmcHPW59D7tzoSPTRCHdhyhB2lN6Cura7YvRjWFhnK96MzZOidkxA+l2U8
	PehPNS2dlXt84vAjUYiplDP6Oi2uyhCTm3W8mjwM1LjGbexGo6ivp3o+APBCXGV/k5uqdPltf1nhV
	hWaBICu8Q9Q2XjxVZoJ0Ab51+SZK6am+9cJVPJciCQXGybcik9v+i9WzBQ/8YtDBMOU272No8KOEP
	OEfNaAmSNgb9LhuxyRhyf8PPJhu0ETdSyqGPb8Ny4W8kUzo4y3WOu5Q3rBDhywYzQ2in3dZgYSFD6
	L0yhalaAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWZw-0007hj-1C; Mon, 19 Oct 2020 14:56:04 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWZs-0007h2-Gs
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:56:01 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEtOmP169370;
 Mon, 19 Oct 2020 14:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=GG/FlUtaGnvbiobzayrPTMBIWgk61GvM14D3AB4D38g=;
 b=zxxEqYhVCLzesBxjyiyeiR4V7d5ER94GYriD4Q7lvCmWcZboeA9dNt+Uv5DtP2w6tHY5
 o6lJ7+MwUyHTk4DT7PtAohNTaIjpBNugl8xJSDbgZukv/KXGPZS+lF7nD74yhJ8oTaym
 BC/HmZIM+Wf2mOClvvFvXNYQCPiPy6jwfWn9UHNzFTfPNwDB0BoaUdiqxzYfH1EOZrzg
 SjfOQ2j7uUoVYQEl17iASJq4fkBJkaxveWiFnhLjb1VRbgueqhftvAmtpeQ4DBDoGmst
 1YvcIwU19ivLY94X95P0I/TDjXHlFDc6PMtqezhZeHg+BmhYj+biz3bZXk+WwepEYCJx /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 347s8mnx6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Oct 2020 14:55:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEtpFH126989;
 Mon, 19 Oct 2020 14:55:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 348acpjrd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2020 14:55:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09JEtvo2014223;
 Mon, 19 Oct 2020 14:55:57 GMT
Received: from [192.168.1.25] (/70.114.128.235)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 19 Oct 2020 07:55:57 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nvme-fc: fix error loop in create_hw_io_queues
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20201016210604.48542-1-james.smart@broadcom.com>
Date: Mon, 19 Oct 2020 09:55:56 -0500
Message-Id: <CDFD0554-F758-4944-87C1-DA3154DC5065@oracle.com>
References: <20201016210604.48542-1-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_105600_703955_CBB34FE6 
X-CRM114-Status: GOOD (  25.59  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Oct 16, 2020, at 4:06 PM, James Smart <james.smart@broadcom.com> wrote:
> 
> The loop that backs out of hw io queue creation continues through index
> 0, which corresponds to the admin queue as well.
> 
> Fix the loop so it only proceeds through indexes 1..n which correspond to
> io queues.
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e2e09e25c056..f002522146e2 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2314,7 +2314,7 @@ nvme_fc_create_hw_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
> 	return 0;
> 
> delete_queues:
> -	for (; i >= 0; i--)
> +	for (; i > 0; i--)
> 		__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[i], i);
> 	return ret;
> }
> -- 
> 2.26.2
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme


Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
