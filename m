Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCD7106FD9A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7IGvIVWZ3NThc97EBPnBhQNWsi3kLaOPQbogBRh+5oM=; b=EeckOX9VokOyQKoRqec8ge431a
	q0+lwrOobnqOV/CW9R9luUNIDN8OH4BoONpTsqBB5ARbdzVPSdBOiSaNFdVL5uDhtNS5iqIjZZUB7
	f2KX6SQDgI6/rNVIjy9ODGlvgX25waDo1wyiHizXz9CgLfsntgknLcsmcOimSHogFgcqNcARGfl9t
	I1CiS2TxqOfKB6y0ALmSU3NdX5oTZx39lNahgwAJR1E0+GU1OjnM82SIRZcv7NjwrRZ/sjPDgVzym
	GKpIwI7Xlq6LNxMKvbqxkuyUqbiyQMGnv5bcg2WQAqW5NP7y+C9oCC5ImQda8eo0BkYTLJyNFqwBA
	ddt6bzdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0xD3-0000000H68w-2Qrn;
	Fri, 13 Mar 2026 07:45:25 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0xCw-0000000H65Q-0R9P
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 07:45:24 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 866fab50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 08:45:11 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 08:45:11 +0100
Message-Id: <DH1HJRJZYUED.31HB51Z4P4V5N@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
Cc: <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <yjshin0438@gmail.com>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH V2 1/2] nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec()
 errors to its callers
X-Mailer: aerc 0.21.0
References: <20260312134057.110274-1-mlombard@redhat.com>
 <20260312134057.110274-2-mlombard@redhat.com>
 <67675bf0-dfe4-4ed5-bf4f-dddac48b1c96@suse.de>
In-Reply-To: <67675bf0-dfe4-4ed5-bf4f-dddac48b1c96@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_004518_485244_B33D753F 
X-CRM114-Status: GOOD (  13.95  )
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

On Fri Mar 13, 2026 at 8:10 AM CET, Hannes Reinecke wrote:
> On 3/12/26 14:40, Maurizio Lombardi wrote:
>> Currently, when nvmet_tcp_build_pdu_iovec() detects an out-of-bounds
>> PDU length or offset, it triggers nvmet_tcp_fatal_error(cmd->queue)
>> and returns early. However, because the function returns void, the
>> callers are entirely unaware that a fatal error has occurred and
>> that the cmd->recv_msg.msg_iter was left uninitialized.
>>=20
>> Callers such as nvmet_tcp_handle_h2c_data_pdu() proceed to blindly
>> overwrite the queue state with queue->rcv_state =3D NVMET_TCP_RECV_DATA
>> Consequently, the socket receiving loop may attempt to read incoming
>> network data into the uninitialized iterator.
>>=20
>> Fix this by shifting the error handling responsibility to the callers.
>>=20
>> Fixes: 52a0a9854934 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pd=
u_iovec")
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>   drivers/nvme/target/tcp.c | 51 ++++++++++++++++++++++-----------------
>>   1 file changed, 29 insertions(+), 22 deletions(-)
>>=20
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index acc71a26733f..1fbf12df1183 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -351,7 +351,7 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_=
tcp_cmd *cmd)
>>  =20
>>   static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
>>  =20
>> -static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>> +static int nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>>   {
>>   	struct bio_vec *iov =3D cmd->iov;
>>   	struct scatterlist *sg;
>> @@ -364,22 +364,19 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet=
_tcp_cmd *cmd)
>>   	offset =3D cmd->rbytes_done;
>>   	cmd->sg_idx =3D offset / PAGE_SIZE;
>>   	sg_offset =3D offset % PAGE_SIZE;
>> -	if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt) {
>> -		nvmet_tcp_fatal_error(cmd->queue);
>> -		return;
>> -	}
>> +	if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt)
>> +		return -EPROTO;
>> +
>>   	sg =3D &cmd->req.sg[cmd->sg_idx];
>>   	sg_remaining =3D cmd->req.sg_cnt - cmd->sg_idx;
>>  =20
>>   	while (length) {
>> -		if (!sg_remaining) {
>> -			nvmet_tcp_fatal_error(cmd->queue);
>> -			return;
>> -		}
>> -		if (!sg->length || sg->length <=3D sg_offset) {
>> -			nvmet_tcp_fatal_error(cmd->queue);
>> -			return;
>> -		}
>> +		if (!sg_remaining)
>> +			return -EPROTO;
>> +
>> +		if (!sg->length || sg->length <=3D sg_offset)
>> +			return -EPROTO;
>> +
>>   		u32 iov_len =3D min_t(u32, length, sg->length - sg_offset);
>>  =20
>>   		bvec_set_page(iov, sg_page(sg), iov_len,
>> @@ -394,6 +391,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_t=
cp_cmd *cmd)
>>  =20
>>   	iov_iter_bvec(&cmd->recv_msg.msg_iter, ITER_DEST, cmd->iov,
>>   		      nr_pages, cmd->pdu_len);
>> +	return 0;
>>   }
>>  =20
>>   static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
>> @@ -931,7 +929,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_q=
ueue *queue)
>>   	return 0;
>>   }
>>  =20
>> -static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
>> +static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
>>   		struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
>>   {
>>   	size_t data_len =3D le32_to_cpu(req->cmd->common.dptr.sgl.length);
>> @@ -947,19 +945,23 @@ static void nvmet_tcp_handle_req_failure(struct nv=
met_tcp_queue *queue,
>>   	if (!nvme_is_write(cmd->req.cmd) || !data_len ||
>>   	    data_len > cmd->req.port->inline_data_size) {
>>   		nvmet_prepare_receive_pdu(queue);
>> -		return;
>> +		return 0;
>>   	}
>>  =20
>>   	ret =3D nvmet_tcp_map_data(cmd);
>>   	if (unlikely(ret)) {
>>   		pr_err("queue %d: failed to map data\n", queue->idx);
>>   		nvmet_tcp_fatal_error(queue);
>> -		return;
>> +		return -EPROTO;
>>   	}
>>  =20
>>   	queue->rcv_state =3D NVMET_TCP_RECV_DATA;
>> -	nvmet_tcp_build_pdu_iovec(cmd);
>>   	cmd->flags |=3D NVMET_TCP_F_INIT_FAILED;
>> +	ret =3D nvmet_tcp_build_pdu_iovec(cmd);
>> +	if (unlikely(ret))
>> +		pr_err("queue %d: failed to build PDU iovec\n", queue->idx);
>
> Why don't we call 'nvmet_tcp_fatal_error()' here?
> The original code did ...

We don't need too, the error code is propagated up to
nvmet_tcp_done_recv_pdu, then up to nvmet_tcp_try_recv_pdu()
and then up to nvmet_tcp_try_recv_one(). Finally, it reaches
nvmet_tcp_try_recv() that checks the error code and calls
nvmet_tcp_socket_error(), because the error code is -EPROTO
nvmet_tcp_fatal_error() will be called.


Maurizio


