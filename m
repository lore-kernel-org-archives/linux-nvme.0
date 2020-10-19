Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE1C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:49:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376292224D
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QZXuPyR7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QLltl798"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376292224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/32E86sg6iSIEWCwJYzzYq/4wIdZ0u0/PXc4Ttuy2e4=; b=QZXuPyR7b2Lg0zwaSjV2CE7XU
	ql9VN5fvM5AhX4xggb5DVVYMCKXhSVr9/SnqVmXwAQUERudmQYyVinh9oLgZo3hf14+xnqfXICyOY
	iePCNiCtpsKxnDy12O5LvQAF+9qXkjJ4PNZ+hwO71IASHOyzbuklnYwclxy7DPNPujFb0NCNP18UW
	h567d1neFvMBhVQplZ0S59BBpRRRw2FSN0/PBezkG0eqxcDuvEHOk1mRikdDOMjnovmy4AeC3Rrhb
	utD4youQ63ug0AzKFaNYmP7iKw8txP9417V7Fg2YNSzK8G9uYkq1q537T/VEaYbEv+trXTDSdu/VF
	x87qig3Rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWTf-0006HA-A4; Mon, 19 Oct 2020 14:49:35 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWTc-0006Fx-8K
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:49:33 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEmrSR104553;
 Mon, 19 Oct 2020 14:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=H00vra/Vj5LYieXeephoHotIWGFS8L+9Xl14g/bCxoY=;
 b=QLltl7985hSbO7w3+tjWlvDJdMJ3ExnL0Q18qJPNJQf47nAzItLOttF+DiddBVVYKB+i
 YrlLMQ0OQWgr2scELsJh+IK7Lf7+cvebt1qsK6G3KI9Xbxgb/llW4NUVOJb0Ek01/mp+
 UkSMygdnwrcQpPvN3Wd6BRT0J359ZdCOGmhn7gHQ0wj/B3qvCWDBZ7IwK0gSnOyzFrD/
 jb1Gund5hP72unTwmjmAyGRmXAuNMRLakWJbr5b102Mhgi5kJzmHQiFOAfIL9GWhE+t/
 oY0DnhCeT1q8eoUwvdppsPsXDsmOq9VxKrTnuvnHEbzwnh1946utDQkwbZPgip91i0bZ Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 347p4ap3dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Oct 2020 14:49:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEjwf0144225;
 Mon, 19 Oct 2020 14:49:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 348a6m059r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2020 14:49:29 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09JEnSwj010451;
 Mon, 19 Oct 2020 14:49:28 GMT
Received: from [192.168.1.25] (/70.114.128.235)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 19 Oct 2020 07:49:28 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/4] nvme-fc: eliminate terminate_io use by
 nvme_fc_error_recovery
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20201016212729.49138-3-james.smart@broadcom.com>
Date: Mon, 19 Oct 2020 09:49:27 -0500
Message-Id: <E68ABA84-3EEA-4F82-8C5C-4F2E93ADCA65@oracle.com>
References: <20201016212729.49138-1-james.smart@broadcom.com>
 <20201016212729.49138-3-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_104932_397041_8FCCB6D6 
X-CRM114-Status: GOOD (  50.36  )
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



> On Oct 16, 2020, at 4:27 PM, James Smart <james.smart@broadcom.com> wrote:
> 
> nvme_fc_error_recovery() special cases handling when in CONNECTING state
> and calls __nvme_fc_terminate_io(). __nvme_fc_terminate_io() itself
> special cases CONNECTING state and calls the routine to abort outstanding
> ios.
> 
> Simplify the sequence by putting the call to abort outstanding ios directly
> in nvme_fc_error_recovery.
> 
> Move the location of __nvme_fc_abort_outstanding_ios(), and
> nvme_fc_terminate_exchange() which is called by it, to avoid adding
> function prototypes for nvme_fc_error_recovery().
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 185 ++++++++++++++++++-----------------------
> 1 file changed, 83 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 06fb208ab350..d65a4a9f4808 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2408,27 +2408,96 @@ nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
> 	nvme_fc_ctrl_put(ctrl);
> }
> 
> -static void __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl);
> +/*
> + * This routine is used by the transport when it needs to find active
> + * io on a queue that is to be terminated. The transport uses
> + * blk_mq_tagset_busy_itr() to find the busy requests, which then invoke
> + * this routine to kill them on a 1 by 1 basis.
> + *
> + * As FC allocates FC exchange for each io, the transport must contact
> + * the LLDD to terminate the exchange, thus releasing the FC exchange.
> + * After terminating the exchange the LLDD will call the transport's
> + * normal io done path for the request, but it will have an aborted
> + * status. The done path will return the io request back to the block
> + * layer with an error status.
> + */
> +static bool
> +nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
> +{
> +	struct nvme_ctrl *nctrl = data;
> +	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
> +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
> +
> +	__nvme_fc_abort_op(ctrl, op);
> +	return true;
> +}
> +
> +/*
> + * This routine runs through all outstanding commands on the association
> + * and aborts them.  This routine is typically be called by the
> + * delete_association routine. It is also called due to an error during
> + * reconnect. In that scenario, it is most likely a command that initializes
> + * the controller, including fabric Connect commands on io queues, that
> + * may have timed out or failed thus the io must be killed for the connect
> + * thread to see the error.
> + */
> +static void
> +__nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
> +{
> +	/*
> +	 * If io queues are present, stop them and terminate all outstanding
> +	 * ios on them. As FC allocates FC exchange for each io, the
> +	 * transport must contact the LLDD to terminate the exchange,
> +	 * thus releasing the FC exchange. We use blk_mq_tagset_busy_itr()
> +	 * to tell us what io's are busy and invoke a transport routine
> +	 * to kill them with the LLDD.  After terminating the exchange
> +	 * the LLDD will call the transport's normal io done path, but it
> +	 * will have an aborted status. The done path will return the
> +	 * io requests back to the block layer as part of normal completions
> +	 * (but with error status).
> +	 */
> +	if (ctrl->ctrl.queue_count > 1) {
> +		nvme_stop_queues(&ctrl->ctrl);
> +		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> +				nvme_fc_terminate_exchange, &ctrl->ctrl);
> +		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
> +		if (start_queues)
> +			nvme_start_queues(&ctrl->ctrl);
> +	}
> +
> +	/*
> +	 * Other transports, which don't have link-level contexts bound
> +	 * to sqe's, would try to gracefully shutdown the controller by
> +	 * writing the registers for shutdown and polling (call
> +	 * nvme_shutdown_ctrl()). Given a bunch of i/o was potentially
> +	 * just aborted and we will wait on those contexts, and given
> +	 * there was no indication of how live the controlelr is on the
> +	 * link, don't send more io to create more contexts for the
> +	 * shutdown. Let the controller fail via keepalive failure if
> +	 * its still present.
> +	 */
> +
> +	/*
> +	 * clean up the admin queue. Same thing as above.
> +	 */
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> +	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
> +				nvme_fc_terminate_exchange, &ctrl->ctrl);
> +	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
> +}
> 
> static void
> nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> {
> 	/*
> -	 * if an error (io timeout, etc) while (re)connecting,
> -	 * it's an error on creating the new association.
> -	 * Start the error recovery thread if it hasn't already
> -	 * been started. It is expected there could be multiple
> -	 * ios hitting this path before things are cleaned up.
> +	 * if an error (io timeout, etc) while (re)connecting, the remote
> +	 * port requested terminating of the association (disconnect_ls)
> +	 * or an error (timeout or abort) occurred on an io while creating
> +	 * the controller.  Abort any ios on the association and let the
> +	 * create_association error path resolve things.
> 	 */
> 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
> -		__nvme_fc_terminate_io(ctrl);
> -
> -		/*
> -		 * Rescheduling the connection after recovering
> -		 * from the io error is left to the reconnect work
> -		 * item, which is what should have stalled waiting on
> -		 * the io that had the error that scheduled this work.
> -		 */
> +		__nvme_fc_abort_outstanding_ios(ctrl, true);
> 		return;
> 	}
> 
> @@ -2742,30 +2811,6 @@ nvme_fc_complete_rq(struct request *rq)
> 	nvme_fc_ctrl_put(ctrl);
> }
> 
> -/*
> - * This routine is used by the transport when it needs to find active
> - * io on a queue that is to be terminated. The transport uses
> - * blk_mq_tagset_busy_itr() to find the busy requests, which then invoke
> - * this routine to kill them on a 1 by 1 basis.
> - *
> - * As FC allocates FC exchange for each io, the transport must contact
> - * the LLDD to terminate the exchange, thus releasing the FC exchange.
> - * After terminating the exchange the LLDD will call the transport's
> - * normal io done path for the request, but it will have an aborted
> - * status. The done path will return the io request back to the block
> - * layer with an error status.
> - */
> -static bool
> -nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
> -{
> -	struct nvme_ctrl *nctrl = data;
> -	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
> -	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
> -
> -	__nvme_fc_abort_op(ctrl, op);
> -	return true;
> -}
> -
> 
> static const struct blk_mq_ops nvme_fc_mq_ops = {
> 	.queue_rq	= nvme_fc_queue_rq,
> @@ -3104,60 +3149,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> }
> 
> 
> -/*
> - * This routine runs through all outstanding commands on the association
> - * and aborts them.  This routine is typically be called by the
> - * delete_association routine. It is also called due to an error during
> - * reconnect. In that scenario, it is most likely a command that initializes
> - * the controller, including fabric Connect commands on io queues, that
> - * may have timed out or failed thus the io must be killed for the connect
> - * thread to see the error.
> - */
> -static void
> -__nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
> -{
> -	/*
> -	 * If io queues are present, stop them and terminate all outstanding
> -	 * ios on them. As FC allocates FC exchange for each io, the
> -	 * transport must contact the LLDD to terminate the exchange,
> -	 * thus releasing the FC exchange. We use blk_mq_tagset_busy_itr()
> -	 * to tell us what io's are busy and invoke a transport routine
> -	 * to kill them with the LLDD.  After terminating the exchange
> -	 * the LLDD will call the transport's normal io done path, but it
> -	 * will have an aborted status. The done path will return the
> -	 * io requests back to the block layer as part of normal completions
> -	 * (but with error status).
> -	 */
> -	if (ctrl->ctrl.queue_count > 1) {
> -		nvme_stop_queues(&ctrl->ctrl);
> -		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> -				nvme_fc_terminate_exchange, &ctrl->ctrl);
> -		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
> -		if (start_queues)
> -			nvme_start_queues(&ctrl->ctrl);
> -	}
> -
> -	/*
> -	 * Other transports, which don't have link-level contexts bound
> -	 * to sqe's, would try to gracefully shutdown the controller by
> -	 * writing the registers for shutdown and polling (call
> -	 * nvme_shutdown_ctrl()). Given a bunch of i/o was potentially
> -	 * just aborted and we will wait on those contexts, and given
> -	 * there was no indication of how live the controlelr is on the
> -	 * link, don't send more io to create more contexts for the
> -	 * shutdown. Let the controller fail via keepalive failure if
> -	 * its still present.
> -	 */
> -
> -	/*
> -	 * clean up the admin queue. Same thing as above.
> -	 */
> -	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> -	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
> -				nvme_fc_terminate_exchange, &ctrl->ctrl);
> -	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
> -}
> -
> /*
>  * This routine stops operation of the controller on the host side.
>  * On the host os stack side: Admin and IO queues are stopped,
> @@ -3290,16 +3281,6 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
> static void
> __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
> {
> -	/*
> -	 * if state is CONNECTING - the error occurred as part of a
> -	 * reconnect attempt. Abort any ios on the association and
> -	 * let the create_association error paths resolve things.
> -	 */
> -	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
> -		__nvme_fc_abort_outstanding_ios(ctrl, true);
> -		return;
> -	}
> -
> 	/*
> 	 * For any other state, kill the association. As this routine
> 	 * is a common io abort routine for resetting and such, after
> -- 
> 2.26.2
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Okay. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
