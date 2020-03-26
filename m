Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B653C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:16:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4923020737
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lmzo8yeZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RX+YAvXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4923020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9xtGO7K6vXi4kv1B9IxvDkv28bX7NCrayFsK2cb5CJc=; b=Lmzo8yeZlsbIjBegzeF2k5Zqi
	fX/XUDh3owvaB19E49wN5FOfGuP8M9vFjOFuTa9K8PErFlF9V4GyZsmVhjuAbXGL5Tb1gV9OPytIY
	Fymn4G3kTodrGBeRBg6rN1DU99qoBpAv3j66KighjNVwAir4V3atmPPqz9EXoIOGeHUbvX0tP9+Uk
	TGHvZwj2e5F2Aqthg2u9tBkMtPFfWZ+UArd6Y8AO7DtANii0oOPHLeczcZkmMstmdGY07HWiljhkw
	NevtsE9AzdpEAqYoc9Cir7QWUzfSS9a113lJ7MdRWjRBzdezdhry5xh9GyDFkBAJ/zRK4lgmpucp+
	0Ux0xysAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHVB6-0002p3-37; Thu, 26 Mar 2020 16:16:20 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHVB1-0002og-U9
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 16:16:18 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGDHoh109540;
 Thu, 26 Mar 2020 16:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/tswsifxQtDdR8RwFshJnd72/xDXzc0rm5LVjkJyYYw=;
 b=RX+YAvXvhzBPMUHP+zD9fRMM6LpfwNR006QsrAip6yP2OGVDDr5+BCkoJspNPW6QCSOq
 XNGBQFflTndJqpiZ35ip92Q4XXy78A4gOFd5K1PIFFkgXrJkJ6y6m29xCLQuOJEATbdO
 plVljLCpdfeLrZJKp3cyo4BlO/1BswSD/z9Idcrf9ZgDkGecToy//jPdIjev839piQ/X
 EDwKi9ckDYQI6iPf+gRqIaNTYtrIeasp2c2newdh5xzNmcWT3EjAAxe0QzzDfJtpYEVE
 xorDyYoonhrxdXIXIO6i+DychTZ9NFiA0/Ofv43lSNBE7SuegGVxxyxgjq/sN0itELi7 0Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ywabrgtp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:16:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QG7orP115284;
 Thu, 26 Mar 2020 16:16:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 3003gm4k46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:16:13 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QGGCd0026265;
 Thu, 26 Mar 2020 16:16:12 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 09:16:12 -0700
Subject: Re: [PATCH 03/29] nvme-fc and nvmet-fc: revise LLDD api for LS
 reception and LS request
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-4-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <7fc5d470-d68d-24fc-0a75-8fb34d978731@oracle.com>
Date: Thu, 26 Mar 2020 11:16:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-4-jsmart2021@gmail.com>
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
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_091616_068455_BC2C87A4 
X-CRM114-Status: GOOD (  38.59  )
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
> The current LLDD api has:
>    nvme-fc: contains api for transport to do LS requests (and aborts of
>      them). However, there is no interface for reception of LS's and sending
>      responses for them.
>    nvmet-fc: contains api for transport to do reception of LS's and sending
>      of responses for them. However, there is no interface for doing LS
>      requests.
> 
> Revise the api's so that both nvme-fc and nvmet-fc can send LS's, as well
> as receiving LS's and sending their responses.
> 
> Change name of the rcv_ls_req struct to better reflect generic use as
> a context to used to send an ls rsp.
> 
> Change nvmet_fc_rcv_ls_req() calling sequence to provide handle that
> can be used by transport in later LS request sequences for an association.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   include/linux/nvme-fc-driver.h | 368 ++++++++++++++++++++++++++++++-----------
>   1 file changed, 270 insertions(+), 98 deletions(-)
> 
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 6d0d70f3219c..8b97c899517d 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -10,47 +10,26 @@
>   
>   
>   /*
> - * **********************  LLDD FC-NVME Host API ********************
> + * **********************  FC-NVME LS API ********************
>    *
> - *  For FC LLDD's that are the NVME Host role.
> + *  Data structures used by both FC-NVME hosts and FC-NVME
> + *  targets to perform FC-NVME LS requests or transmit
> + *  responses.
>    *
> - * ******************************************************************
> + * ***********************************************************
>    */
>   
> -
> -
>   /**
> - * struct nvme_fc_port_info - port-specific ids and FC connection-specific
> - *                            data element used during NVME Host role
> - *                            registrations
> - *
> - * Static fields describing the port being registered:
> - * @node_name: FC WWNN for the port
> - * @port_name: FC WWPN for the port
> - * @port_role: What NVME roles are supported (see FC_PORT_ROLE_xxx)
> - * @dev_loss_tmo: maximum delay for reconnects to an association on
> - *             this device. Used only on a remoteport.
> + * struct nvmefc_ls_req - Request structure passed from the transport
> + *            to the LLDD to perform a NVME-FC LS request and obtain
> + *            a response.
> + *            Used by nvme-fc transport (host) to send LS's such as
> + *              Create Association, Create Connection and Disconnect
> + *              Association.
> + *            Used by the nvmet-fc transport (controller) to send
> + *              LS's such as Disconnect Association.
>    *
> - * Initialization values for dynamic port fields:
> - * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
> - *                be set to 0.
> - */
> -struct nvme_fc_port_info {
> -	u64			node_name;
> -	u64			port_name;
> -	u32			port_role;
> -	u32			port_id;
> -	u32			dev_loss_tmo;
> -};
> -
> -
> -/**
> - * struct nvmefc_ls_req - Request structure passed from NVME-FC transport
> - *                        to LLDD in order to perform a NVME FC-4 LS
> - *                        request and obtain a response.
> - *
> - * Values set by the NVME-FC layer prior to calling the LLDD ls_req
> - * entrypoint.
> + * Values set by the requestor prior to calling the LLDD ls_req entrypoint:
>    * @rqstaddr: pointer to request buffer
>    * @rqstdma:  PCI DMA address of request buffer
>    * @rqstlen:  Length, in bytes, of request buffer
> @@ -63,8 +42,8 @@ struct nvme_fc_port_info {
>    * @private:  pointer to memory allocated alongside the ls request structure
>    *            that is specifically for the LLDD to use while processing the
>    *            request. The length of the buffer corresponds to the
> - *            lsrqst_priv_sz value specified in the nvme_fc_port_template
> - *            supplied by the LLDD.
> + *            lsrqst_priv_sz value specified in the xxx_template supplied
> + *            by the LLDD.
>    * @done:     The callback routine the LLDD is to invoke upon completion of
>    *            the LS request. req argument is the pointer to the original LS
>    *            request structure. Status argument must be 0 upon success, a
> @@ -86,6 +65,101 @@ struct nvmefc_ls_req {
>   } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
>   
>   
> +/**
> + * struct nvmefc_ls_rsp - Structure passed from the transport to the LLDD
> + *            to request the transmit the NVME-FC LS response to a
> + *            NVME-FC LS request.   The structure originates in the LLDD
> + *            and is given to the transport via the xxx_rcv_ls_req()
> + *            transport routine. As such, the structure represents the
> + *            FC exchange context for the NVME-FC LS request that was
> + *            received and which the response is to be sent for.
> + *            Used by the LLDD to pass the nvmet-fc transport (controller)
> + *              received LS's such as Create Association, Create Connection
> + *              and Disconnect Association.
> + *            Used by the LLDD to pass the nvme-fc transport (host)
> + *              received LS's such as Disconnect Association or Disconnect
> + *              Connection.
> + *
> + * The structure is allocated by the LLDD whenever a LS Request is received
> + * from the FC link. The address of the structure is passed to the nvmet-fc
> + * or nvme-fc layer via the xxx_rcv_ls_req() transport routines.
> + *
> + * The address of the structure is to be passed back to the LLDD
> + * when the response is to be transmit. The LLDD will use the address to
> + * map back to the LLDD exchange structure which maintains information such
> + * the remote N_Port that sent the LS as well as any FC exchange context.
> + * Upon completion of the LS response transmit, the LLDD will pass the
> + * address of the structure back to the transport LS rsp done() routine,
> + * allowing the transport release dma resources. Upon completion of
> + * the done() routine, no further access to the structure will be made by
> + * the transport and the LLDD can de-allocate the structure.
> + *
> + * Field initialization:
> + *   At the time of the xxx_rcv_ls_req() call, there is no content that
> + *     is valid in the structure.
> + *
> + *   When the structure is used for the LLDD->xmt_ls_rsp() call, the
> + *     transport layer will fully set the fields in order to specify the
> + *     response payload buffer and its length as well as the done routine
> + *     to be called upon completion of the transmit.  The transport layer
> + *     will also set a private pointer for its own use in the done routine.
> + *
> + * Values set by the transport layer prior to calling the LLDD xmt_ls_rsp
> + * entrypoint:
> + * @rspbuf:   pointer to the LS response buffer
> + * @rspdma:   PCI DMA address of the LS response buffer
> + * @rsplen:   Length, in bytes, of the LS response buffer
> + * @done:     The callback routine the LLDD is to invoke upon completion of
> + *            transmitting the LS response. req argument is the pointer to
> + *            the original ls request.
> + * @nvme_fc_private:  pointer to an internal transport-specific structure
> + *            used as part of the transport done() processing. The LLDD is
> + *            not to access this pointer.
> + */
> +struct nvmefc_ls_rsp {
> +	void		*rspbuf;
> +	dma_addr_t	rspdma;
> +	u16		rsplen;
> +
> +	void (*done)(struct nvmefc_ls_rsp *rsp);
> +	void		*nvme_fc_private;	/* LLDD is not to access !! */
> +};
> +
> +
> +
> +/*
> + * **********************  LLDD FC-NVME Host API ********************
> + *
> + *  For FC LLDD's that are the NVME Host role.
> + *
> + * ******************************************************************
> + */
> +
> +
> +/**
> + * struct nvme_fc_port_info - port-specific ids and FC connection-specific
> + *                            data element used during NVME Host role
> + *                            registrations
> + *
> + * Static fields describing the port being registered:
> + * @node_name: FC WWNN for the port
> + * @port_name: FC WWPN for the port
> + * @port_role: What NVME roles are supported (see FC_PORT_ROLE_xxx)
> + * @dev_loss_tmo: maximum delay for reconnects to an association on
> + *             this device. Used only on a remoteport.
> + *
> + * Initialization values for dynamic port fields:
> + * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
> + *                be set to 0.
> + */
> +struct nvme_fc_port_info {
> +	u64			node_name;
> +	u64			port_name;
> +	u32			port_role;
> +	u32			port_id;
> +	u32			dev_loss_tmo;
> +};
> +
>   enum nvmefc_fcp_datadir {
>   	NVMEFC_FCP_NODATA,	/* payload_length and sg_cnt will be zero */
>   	NVMEFC_FCP_WRITE,
> @@ -339,6 +413,21 @@ struct nvme_fc_remote_port {
>    *       indicating an FC transport Aborted status.
>    *       Entrypoint is Mandatory.
>    *
> + * @xmt_ls_rsp:  Called to transmit the response to a FC-NVME FC-4 LS service.
> + *       The nvmefc_ls_rsp structure is the same LLDD-supplied exchange
> + *       structure specified in the nvme_fc_rcv_ls_req() call made when
> + *       the LS request was received. The structure will fully describe
> + *       the buffers for the response payload and the dma address of the
> + *       payload. The LLDD is to transmit the response (or return a
> + *       non-zero errno status), and upon completion of the transmit, call
> + *       the "done" routine specified in the nvmefc_ls_rsp structure
> + *       (argument to done is the address of the nvmefc_ls_rsp structure
> + *       itself). Upon the completion of the done routine, the LLDD shall
> + *       consider the LS handling complete and the nvmefc_ls_rsp structure
> + *       may be freed/released.
> + *       Entrypoint is mandatory if the LLDD calls the nvme_fc_rcv_ls_req()
> + *       entrypoint.
> + *
>    * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
>    *       supports for cpu affinitization.
>    *       Value is Mandatory. Must be at least 1.
> @@ -373,7 +462,7 @@ struct nvme_fc_remote_port {
>    * @lsrqst_priv_sz: The LLDD sets this field to the amount of additional
>    *       memory that it would like fc nvme layer to allocate on the LLDD's
>    *       behalf whenever a ls request structure is allocated. The additional
> - *       memory area solely for the of the LLDD and its location is
> + *       memory area is solely for use by the LLDD and its location is
>    *       specified by the ls_request->private pointer.
>    *       Value is Mandatory. Allowed to be zero.
>    *
> @@ -409,6 +498,9 @@ struct nvme_fc_port_template {
>   				struct nvme_fc_remote_port *,
>   				void *hw_queue_handle,
>   				struct nvmefc_fcp_req *);
> +	int	(*xmt_ls_rsp)(struct nvme_fc_local_port *localport,
> +				struct nvme_fc_remote_port *rport,
> +				struct nvmefc_ls_rsp *ls_rsp);
>   
>   	u32	max_hw_queues;
>   	u16	max_sgl_segments;
> @@ -445,6 +537,34 @@ void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
>   int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
>   			u32 dev_loss_tmo);
>   
> +/*
> + * Routine called to pass a NVME-FC LS request, received by the lldd,
> + * to the nvme-fc transport.
> + *
> + * If the return value is zero: the LS was successfully accepted by the
> + *   transport.
> + * If the return value is non-zero: the transport has not accepted the
> + *   LS. The lldd should ABTS-LS the LS.
> + *
> + * Note: if the LLDD receives and ABTS for the LS prior to the transport
> + * calling the ops->xmt_ls_rsp() routine to transmit a response, the LLDD
> + * shall mark the LS as aborted, and when the xmt_ls_rsp() is called: the
> + * response shall not be transmit and the struct nvmefc_ls_rsp() done
> + * routine shall be called.  The LLDD may transmit the ABTS response as
> + * soon as the LS was marked or can delay until the xmt_ls_rsp() call is
> + * made.
> + * Note: if an RCV LS was successfully posted to the transport and the
> + * remoteport is then unregistered before xmt_ls_rsp() was called for
> + * the lsrsp structure, the transport will still call xmt_ls_rsp()
> + * afterward to cleanup the outstanding lsrsp structure. The LLDD should
> + * noop the transmission of the rsp and call the lsrsp->done() routine
> + * to allow the lsrsp structure to be released.
> + */
> +int nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *remoteport,
> +			struct nvmefc_ls_rsp *lsrsp,
> +			void *lsreqbuf, u32 lsreqbuf_len);
> +
> +
>   
>   /*
>    * ***************  LLDD FC-NVME Target/Subsystem API ***************
> @@ -474,55 +594,6 @@ struct nvmet_fc_port_info {
>   };
>   
>   
> -/**
> - * struct nvmefc_tgt_ls_req - Structure used between LLDD and NVMET-FC
> - *                            layer to represent the exchange context for
> - *                            a FC-NVME Link Service (LS).
> - *
> - * The structure is allocated by the LLDD whenever a LS Request is received
> - * from the FC link. The address of the structure is passed to the nvmet-fc
> - * layer via the nvmet_fc_rcv_ls_req() call. The address of the structure
> - * will be passed back to the LLDD when the response is to be transmit.
> - * The LLDD is to use the address to map back to the LLDD exchange structure
> - * which maintains information such as the targetport the LS was received
> - * on, the remote FC NVME initiator that sent the LS, and any FC exchange
> - * context.  Upon completion of the LS response transmit, the address of the
> - * structure will be passed back to the LS rsp done() routine, allowing the
> - * nvmet-fc layer to release dma resources. Upon completion of the done()
> - * routine, no further access will be made by the nvmet-fc layer and the
> - * LLDD can de-allocate the structure.
> - *
> - * Field initialization:
> - *   At the time of the nvmet_fc_rcv_ls_req() call, there is no content that
> - *     is valid in the structure.
> - *
> - *   When the structure is used for the LLDD->xmt_ls_rsp() call, the nvmet-fc
> - *     layer will fully set the fields in order to specify the response
> - *     payload buffer and its length as well as the done routine to be called
> - *     upon compeletion of the transmit.  The nvmet-fc layer will also set a
> - *     private pointer for its own use in the done routine.
> - *
> - * Values set by the NVMET-FC layer prior to calling the LLDD xmt_ls_rsp
> - * entrypoint.
> - * @rspbuf:   pointer to the LS response buffer
> - * @rspdma:   PCI DMA address of the LS response buffer
> - * @rsplen:   Length, in bytes, of the LS response buffer
> - * @done:     The callback routine the LLDD is to invoke upon completion of
> - *            transmitting the LS response. req argument is the pointer to
> - *            the original ls request.
> - * @nvmet_fc_private:  pointer to an internal NVMET-FC layer structure used
> - *            as part of the NVMET-FC processing. The LLDD is not to access
> - *            this pointer.
> - */
> -struct nvmefc_tgt_ls_req {
> -	void		*rspbuf;
> -	dma_addr_t	rspdma;
> -	u16		rsplen;
> -
> -	void (*done)(struct nvmefc_tgt_ls_req *req);
> -	void *nvmet_fc_private;		/* LLDD is not to access !! */
> -};
> -
>   /* Operations that NVME-FC layer may request the LLDD to perform for FCP */
>   enum {
>   	NVMET_FCOP_READDATA	= 1,	/* xmt data to initiator */
> @@ -697,17 +768,19 @@ struct nvmet_fc_target_port {
>    *       Entrypoint is Mandatory.
>    *
>    * @xmt_ls_rsp:  Called to transmit the response to a FC-NVME FC-4 LS service.
> - *       The nvmefc_tgt_ls_req structure is the same LLDD-supplied exchange
> + *       The nvmefc_ls_rsp structure is the same LLDD-supplied exchange
>    *       structure specified in the nvmet_fc_rcv_ls_req() call made when
> - *       the LS request was received.  The structure will fully describe
> + *       the LS request was received. The structure will fully describe
>    *       the buffers for the response payload and the dma address of the
> - *       payload. The LLDD is to transmit the response (or return a non-zero
> - *       errno status), and upon completion of the transmit, call the
> - *       "done" routine specified in the nvmefc_tgt_ls_req structure
> - *       (argument to done is the ls reqwuest structure itself).
> - *       After calling the done routine, the LLDD shall consider the
> - *       LS handling complete and the nvmefc_tgt_ls_req structure may
> - *       be freed/released.
> + *       payload. The LLDD is to transmit the response (or return a
> + *       non-zero errno status), and upon completion of the transmit, call
> + *       the "done" routine specified in the nvmefc_ls_rsp structure
> + *       (argument to done is the address of the nvmefc_ls_rsp structure
> + *       itself). Upon the completion of the done() routine, the LLDD shall
> + *       consider the LS handling complete and the nvmefc_ls_rsp structure
> + *       may be freed/released.
> + *       The transport will always call the xmt_ls_rsp() routine for any
> + *       LS received.
>    *       Entrypoint is Mandatory.
>    *
>    * @fcp_op:  Called to perform a data transfer or transmit a response.
> @@ -802,6 +875,39 @@ struct nvmet_fc_target_port {
>    *       should cause the initiator to rescan the discovery controller
>    *       on the targetport.
>    *
> + * @ls_req:  Called to issue a FC-NVME FC-4 LS service request.
> + *       The nvme_fc_ls_req structure will fully describe the buffers for
> + *       the request payload and where to place the response payload.
> + *       The targetport that is to issue the LS request is identified by
> + *       the targetport argument.  The remote port that is to receive the
> + *       LS request is identified by the hosthandle argument. The nvmet-fc
> + *       transport is only allowed to issue FC-NVME LS's on behalf of an
> + *       association that was created prior by a Create Association LS.
> + *       The hosthandle will originate from the LLDD in the struct
> + *       nvmefc_ls_rsp structure for the Create Association LS that
> + *       was delivered to the transport. The transport will save the
> + *       hosthandle as an attribute of the association.  If the LLDD
> + *       loses connectivity with the remote port, it must call the
> + *       nvmet_fc_invalidate_host() routine to remove any references to
> + *       the remote port in the transport.
> + *       The LLDD is to allocate an exchange, issue the LS request, obtain
> + *       the LS response, and call the "done" routine specified in the
> + *       request structure (argument to done is the ls request structure
> + *       itself).
> + *       Entrypoint is Optional - but highly recommended.
> + *
> + * @ls_abort: called to request the LLDD to abort the indicated ls request.
> + *       The call may return before the abort has completed. After aborting
> + *       the request, the LLDD must still call the ls request done routine
> + *       indicating an FC transport Aborted status.
> + *       Entrypoint is Mandatory if the ls_req entry point is specified.
> + *
> + * @host_release: called to inform the LLDD that the request to invalidate
> + *       the host port indicated by the hosthandle has been fully completed.
> + *       No associations exist with the host port and there will be no
> + *       further references to hosthandle.
> + *       Entrypoint is Mandatory if the lldd calls nvmet_fc_invalidate_host().
> + *
>    * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
>    *       supports for cpu affinitization.
>    *       Value is Mandatory. Must be at least 1.
> @@ -830,11 +936,19 @@ struct nvmet_fc_target_port {
>    *       area solely for the of the LLDD and its location is specified by
>    *       the targetport->private pointer.
>    *       Value is Mandatory. Allowed to be zero.
> + *
> + * @lsrqst_priv_sz: The LLDD sets this field to the amount of additional
> + *       memory that it would like nvmet-fc layer to allocate on the LLDD's
> + *       behalf whenever a ls request structure is allocated. The additional
> + *       memory area is solely for use by the LLDD and its location is
> + *       specified by the ls_request->private pointer.
> + *       Value is Mandatory. Allowed to be zero.
> + *
>    */
>   struct nvmet_fc_target_template {
>   	void (*targetport_delete)(struct nvmet_fc_target_port *tgtport);
>   	int (*xmt_ls_rsp)(struct nvmet_fc_target_port *tgtport,
> -				struct nvmefc_tgt_ls_req *tls_req);
> +				struct nvmefc_ls_rsp *ls_rsp);
>   	int (*fcp_op)(struct nvmet_fc_target_port *tgtport,
>   				struct nvmefc_tgt_fcp_req *fcpreq);
>   	void (*fcp_abort)(struct nvmet_fc_target_port *tgtport,
> @@ -844,6 +958,11 @@ struct nvmet_fc_target_template {
>   	void (*defer_rcv)(struct nvmet_fc_target_port *tgtport,
>   				struct nvmefc_tgt_fcp_req *fcpreq);
>   	void (*discovery_event)(struct nvmet_fc_target_port *tgtport);
> +	int  (*ls_req)(struct nvmet_fc_target_port *targetport,
> +				void *hosthandle, struct nvmefc_ls_req *lsreq);
> +	void (*ls_abort)(struct nvmet_fc_target_port *targetport,
> +				void *hosthandle, struct nvmefc_ls_req *lsreq);
> +	void (*host_release)(void *hosthandle);
>   
>   	u32	max_hw_queues;
>   	u16	max_sgl_segments;
> @@ -852,7 +971,9 @@ struct nvmet_fc_target_template {
>   
>   	u32	target_features;
>   
> +	/* sizes of additional private data for data structures */
>   	u32	target_priv_sz;
> +	u32	lsrqst_priv_sz;
>   };
>   
>   
> @@ -863,10 +984,61 @@ int nvmet_fc_register_targetport(struct nvmet_fc_port_info *portinfo,
>   
>   int nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *tgtport);
>   
> +/*
> + * Routine called to pass a NVME-FC LS request, received by the lldd,
> + * to the nvmet-fc transport.
> + *
> + * If the return value is zero: the LS was successfully accepted by the
> + *   transport.
> + * If the return value is non-zero: the transport has not accepted the
> + *   LS. The lldd should ABTS-LS the LS.
> + *
> + * Note: if the LLDD receives and ABTS for the LS prior to the transport
> + * calling the ops->xmt_ls_rsp() routine to transmit a response, the LLDD
> + * shall mark the LS as aborted, and when the xmt_ls_rsp() is called: the
> + * response shall not be transmit and the struct nvmefc_ls_rsp() done
> + * routine shall be called.  The LLDD may transmit the ABTS response as
> + * soon as the LS was marked or can delay until the xmt_ls_rsp() call is
> + * made.
> + * Note: if an RCV LS was successfully posted to the transport and the
> + * targetport is then unregistered before xmt_ls_rsp() was called for
> + * the lsrsp structure, the transport will still call xmt_ls_rsp()
> + * afterward to cleanup the outstanding lsrsp structure. The LLDD should
> + * noop the transmission of the rsp and call the lsrsp->done() routine
> + * to allow the lsrsp structure to be released.
> + */
>   int nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *tgtport,
> -			struct nvmefc_tgt_ls_req *lsreq,
> +			void *hosthandle,
> +			struct nvmefc_ls_rsp *rsp,
>   			void *lsreqbuf, u32 lsreqbuf_len);
>   
> +/*
> + * Routine called by the LLDD whenever it has a logout or loss of
> + * connectivity to a NVME-FC host port which there had been active
> + * NVMe controllers for.  The host port is indicated by the
> + * hosthandle. The hosthandle is given to the nvmet-fc transport
> + * when a NVME LS was received, typically to create a new association.
> + * The nvmet-fc transport will cache the hostport value with the
> + * association for use in LS requests for the association.
> + * When the LLDD calls this routine, the nvmet-fc transport will
> + * immediately terminate all associations that were created with
> + * the hosthandle host port.
> + * The LLDD, after calling this routine and having control returned,
> + * must assume the transport may subsequently utilize hosthandle as
> + * part of sending LS's to terminate the association.  The LLDD
> + * should reject the LS's if they are attempted.
> + * Once the last association has terminated for the hosthandle host
> + * port, the nvmet-fc transport will call the ops->host_release()
> + * callback. As of the callback, the nvmet-fc transport will no
> + * longer reference hosthandle.
> + */
> +void nvmet_fc_invalidate_host(struct nvmet_fc_target_port *tgtport,
> +			void *hosthandle);
> +
> +/*
> + * If nvmet_fc_rcv_fcp_req returns non-zero, the transport has not accepted
> + * the FCP cmd. The lldd should ABTS-LS the cmd.
> + */
>   int nvmet_fc_rcv_fcp_req(struct nvmet_fc_target_port *tgtport,
>   			struct nvmefc_tgt_fcp_req *fcpreq,
>   			void *cmdiubuf, u32 cmdiubuf_len);
> 

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
