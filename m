Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7A6C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 19:03:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E56220719
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 19:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lgsfJJyw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cs8SvRtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E56220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I9D3OPu3fTaAHPa5BoxIn3y1BRfj0vmLifJsQsTLRxk=; b=lgsfJJywSP7qM0Mo6u92zoPwx
	TIG6BB7eSljlgGjPiuaixJHjs+q4wPppkd2yHpzefPg1BihRCs7DXHcav7h8egQFt509ZF86s5cZ1
	3UERhYbKeTheyUMe5Wt/jGxkG+mPME6qQZhWwHnXhCpemHYiTXCec7jrRfy8K5kxW5lpVCfOiTUfg
	Ba3lFUM5qtVSx1MrLgixi8k/wx69cM+MvIr+dN3U3GLPJT5YBNJPwCillI4BowXf19M4Ovqx+hl9e
	s+kdip17XnJRXmiUE/S57wzRkAiif7DPPuV8Ddv/zXaBh2RhVstKvD5kCWLcGgJkGUH8Fh/jtm1Wk
	RanfbIv+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHXmN-0003nW-Os; Thu, 26 Mar 2020 19:02:59 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHXmK-0003n9-TD
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 19:02:58 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QIxGGQ107135;
 Thu, 26 Mar 2020 19:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HnhgyfyTEYP+g67N7SKOyVgdInqQpj+G4OIIfUW8N9I=;
 b=cs8SvRtU8qsGLhnx/aYIxDJoFhNq5NjYJhgLV8bu9QBHiwcAvS6OrKK1GQKfVQNJmoQp
 t4TNYqiTDY9MwZnCedP43wFcxO6pZY+odJuAUwttgLfH2xlxo8raegeez67HrZ1MMidz
 laNJTgKbwvR4Eg9Vv5czgrGq3KlkdsoXY2iYFM8xNPl0DQmg1YmovhkK/PCYngdD0uQW
 KimzMV4P3+Jtmw+RCaTnzSTMbetSrXG7vQXcpms8CLcnY3OkWSgZgAMDDfX3kasqGhXV
 RGq4mzWPg1iG/lq8evGlOvErK7jNzqiNrKAUTHGYVjpFScBj5CKvOfIqypdralEyaiDc Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2ywabrhqgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 19:02:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QIucx2082982;
 Thu, 26 Mar 2020 19:00:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 30073e7mwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 19:00:51 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QJ0oFl006748;
 Thu, 26 Mar 2020 19:00:50 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 12:00:50 -0700
Subject: Re: [PATCH] nvme-fcloop: Fix deallocation of working context
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200318214112.18317-1-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <be54696d-bda7-097a-a69d-119d86309529@oracle.com>
Date: Thu, 26 Mar 2020 14:00:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318214112.18317-1-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=2 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=2
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_120257_079657_7D6FB819 
X-CRM114-Status: GOOD (  24.97  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/18/2020 4:41 PM, James Smart wrote:
> There's been a longstanding bug of LS completions which freed ls
> op's, particularly the disconnect LS, while executing on a work
> context that is in the memory being free. Not a good thing to do.
> 
> Rework LS handling to make callbacks in the rport context
> rather than the ls_request context.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 76 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 52 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 1c50af6219f3..9861fcea39f6 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -198,10 +198,13 @@ struct fcloop_lport_priv {
>   };
>   
>   struct fcloop_rport {
> -	struct nvme_fc_remote_port *remoteport;
> -	struct nvmet_fc_target_port *targetport;
> -	struct fcloop_nport *nport;
> -	struct fcloop_lport *lport;
> +	struct nvme_fc_remote_port	*remoteport;
> +	struct nvmet_fc_target_port	*targetport;
> +	struct fcloop_nport		*nport;
> +	struct fcloop_lport		*lport;
> +	spinlock_t			lock;
> +	struct list_head		ls_list;
> +	struct work_struct		ls_work;
>   };
>   
>   struct fcloop_tport {
> @@ -224,11 +227,10 @@ struct fcloop_nport {
>   };
>   
>   struct fcloop_lsreq {
> -	struct fcloop_tport		*tport;
>   	struct nvmefc_ls_req		*lsreq;
> -	struct work_struct		work;
>   	struct nvmefc_tgt_ls_req	tgt_ls_req;
>   	int				status;
> +	struct list_head		ls_list; /* fcloop_rport->ls_list */
>   };
>   
>   struct fcloop_rscn {
> @@ -292,21 +294,32 @@ fcloop_delete_queue(struct nvme_fc_local_port *localport,
>   {
>   }
>   
> -
> -/*
> - * Transmit of LS RSP done (e.g. buffers all set). call back up
> - * initiator "done" flows.
> - */
>   static void
> -fcloop_tgt_lsrqst_done_work(struct work_struct *work)
> +fcloop_rport_lsrqst_work(struct work_struct *work)
>   {
> -	struct fcloop_lsreq *tls_req =
> -		container_of(work, struct fcloop_lsreq, work);
> -	struct fcloop_tport *tport = tls_req->tport;
> -	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
> +	struct fcloop_rport *rport =
> +		container_of(work, struct fcloop_rport, ls_work);
> +	struct fcloop_lsreq *tls_req;
>   
> -	if (!tport || tport->remoteport)
> -		lsreq->done(lsreq, tls_req->status);
> +	spin_lock(&rport->lock);
> +	for (;;) {
> +		tls_req = list_first_entry_or_null(&rport->ls_list,
> +				struct fcloop_lsreq, ls_list);
> +		if (!tls_req)
> +			break;
> +
> +		list_del(&tls_req->ls_list);
> +		spin_unlock(&rport->lock);
> +
> +		tls_req->lsreq->done(tls_req->lsreq, tls_req->status);
> +		/*
> +		 * callee may free memory containing tls_req.
> +		 * do not reference lsreq after this.
> +		 */
> +
> +		spin_lock(&rport->lock);
> +	}
> +	spin_unlock(&rport->lock);
>   }
>   
>   static int
> @@ -319,17 +332,18 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
>   	int ret = 0;
>   
>   	tls_req->lsreq = lsreq;
> -	INIT_WORK(&tls_req->work, fcloop_tgt_lsrqst_done_work);
> +	INIT_LIST_HEAD(&tls_req->ls_list);
>   
>   	if (!rport->targetport) {
>   		tls_req->status = -ECONNREFUSED;
> -		tls_req->tport = NULL;
> -		schedule_work(&tls_req->work);
> +		spin_lock(&rport->lock);
> +		list_add_tail(&rport->ls_list, &tls_req->ls_list);
> +		spin_unlock(&rport->lock);
> +		schedule_work(&rport->ls_work);
>   		return ret;
>   	}
>   
>   	tls_req->status = 0;
> -	tls_req->tport = rport->targetport->private;
>   	ret = nvmet_fc_rcv_ls_req(rport->targetport, &tls_req->tgt_ls_req,
>   				 lsreq->rqstaddr, lsreq->rqstlen);
>   
> @@ -337,18 +351,28 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
>   }
>   
>   static int
> -fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *tport,
> +fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
>   			struct nvmefc_tgt_ls_req *tgt_lsreq)
>   {
>   	struct fcloop_lsreq *tls_req = tgt_ls_req_to_lsreq(tgt_lsreq);
>   	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
> +	struct fcloop_tport *tport = targetport->private;
> +	struct nvme_fc_remote_port *remoteport = tport->remoteport;
> +	struct fcloop_rport *rport;
>   
>   	memcpy(lsreq->rspaddr, tgt_lsreq->rspbuf,
>   		((lsreq->rsplen < tgt_lsreq->rsplen) ?
>   				lsreq->rsplen : tgt_lsreq->rsplen));
> +
>   	tgt_lsreq->done(tgt_lsreq);
>   
> -	schedule_work(&tls_req->work);
> +	if (remoteport) {
> +		rport = remoteport->private;
> +		spin_lock(&rport->lock);
> +		list_add_tail(&rport->ls_list, &tls_req->ls_list);
> +		spin_unlock(&rport->lock);
> +		schedule_work(&rport->ls_work);
> +	}
>   
>   	return 0;
>   }
> @@ -834,6 +858,7 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
>   	struct fcloop_rport *rport = remoteport->private;
>   
> +	flush_work(&rport->ls_work);
>   	fcloop_nport_put(rport->nport);
>   }
>   
> @@ -1136,6 +1161,9 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
>   	rport->nport = nport;
>   	rport->lport = nport->lport;
>   	nport->rport = rport;
> +	spin_lock_init(&rport->lock);
> +	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
> +	INIT_LIST_HEAD(&rport->ls_list);
>   
>   	return count;
>   }
> 

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
