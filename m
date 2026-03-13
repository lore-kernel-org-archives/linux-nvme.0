Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABB3106FD9A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ur9KPppSH99JWOr2TCVonshLhePjqeHeFY3fQeLO7iw=; b=LV5h34B4jC2boTPf83BApiD/Ey
	S1WuZWscS1WR+zMLANIMOYVjXbHUsmlvXVUmpMkoNhkXbJWO40Z3CMzfNmDgYFIU+WA00KLhChqOF
	b6829Ly+eM9JvabOBrqh3co9pOJSs3TfkZl0UrSkzQusEg5BaCxNy5xq9Aco14Zfey6hS0Wohz1V/
	ieJr+AzRhCZgZgBsMjERoXgudJpT008tyY4/2d7RTVTKsY542BEPhAGQaNXyXMri5wLR/0jRbixgw
	XPn2fNfpCbYYtARMs0nlPbnPgnuNMcIU3nazN4ArE5m2fxep2EBKv3pqIZeR+7Dh5CPSovFDp7QS+
	r630uSdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0xIr-0000000H7QY-1Bhx;
	Fri, 13 Mar 2026 07:51:25 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0xIo-0000000H7Pg-2WJL
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 07:51:23 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id b785566a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 08:51:20 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 08:51:20 +0100
Message-Id: <DH1HOH95UR5I.3VIFUN1OMD5TE@arkamax.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
Cc: <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <yjshin0438@gmail.com>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH V2 2/2] nvmet-tcp: remove redundant calls to
 nvmet_tcp_fatal_error()
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <20260312134057.110274-1-mlombard@redhat.com>
 <20260312134057.110274-3-mlombard@redhat.com>
 <5accbc4b-42c3-4d47-a8c5-51b0a7180f11@suse.de>
In-Reply-To: <5accbc4b-42c3-4d47-a8c5-51b0a7180f11@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_005122_985591_F269BBD4 
X-CRM114-Status: GOOD (  14.17  )
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

On Fri Mar 13, 2026 at 8:20 AM CET, Hannes Reinecke wrote:
> On 3/12/26 14:40, Maurizio Lombardi wrote:
>> Executing nvmet_tcp_fatal_error() is generally the responsibility
>> of the caller (nvmet_tcp_try_recv); all other functions should
>> just return the error code.
>>=20
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>   drivers/nvme/target/tcp.c | 22 +++++-----------------
>>   1 file changed, 5 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 1fbf12df1183..b250b13854b4 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -885,7 +885,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_q=
ueue *queue)
>>   	if (le32_to_cpu(icreq->hdr.plen) !=3D sizeof(struct nvme_tcp_icreq_pd=
u)) {
>>   		pr_err("bad nvme-tcp pdu length (%d)\n",
>>   			le32_to_cpu(icreq->hdr.plen));
>> -		nvmet_tcp_fatal_error(queue);
>>   		return -EPROTO;
>>   	}
>>  =20
>> @@ -951,7 +950,6 @@ static int nvmet_tcp_handle_req_failure(struct nvmet=
_tcp_queue *queue,
>>   	ret =3D nvmet_tcp_map_data(cmd);
>>   	if (unlikely(ret)) {
>>   		pr_err("queue %d: failed to map data\n", queue->idx);
>> -		nvmet_tcp_fatal_error(queue);
>>   		return -EPROTO;
>>   	}
>>  =20
>> @@ -1024,7 +1022,6 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nv=
met_tcp_queue *queue)
>>  =20
>>   err_proto:
>>   	/* FIXME: use proper transport errors */
>> -	nvmet_tcp_fatal_error(queue);
>>   	return -EPROTO;
>>   }
>>  =20
>> @@ -1039,7 +1036,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tc=
p_queue *queue)
>>   		if (hdr->type !=3D nvme_tcp_icreq) {
>>   			pr_err("unexpected pdu type (%d) before icreq\n",
>>   				hdr->type);
>> -			nvmet_tcp_fatal_error(queue);
>>   			return -EPROTO;
>>   		}
>>   		return nvmet_tcp_handle_icreq(queue);
>> @@ -1048,7 +1044,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tc=
p_queue *queue)
>>   	if (unlikely(hdr->type =3D=3D nvme_tcp_icreq)) {
>>   		pr_err("queue %d: received icreq pdu in state %d\n",
>>   			queue->idx, queue->state);
>> -		nvmet_tcp_fatal_error(queue);
>>   		return -EPROTO;
>>   	}
>>  =20
>> @@ -1065,7 +1060,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tc=
p_queue *queue)
>>   		pr_err("queue %d: out of commands (%d) send_list_len: %d, opcode: %d=
",
>>   			queue->idx, queue->nr_cmds, queue->send_list_len,
>>   			nvme_cmd->common.opcode);
>> -		nvmet_tcp_fatal_error(queue);
>>   		return -ENOMEM;
>>   	}
>>  =20
>> @@ -1086,9 +1080,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tc=
p_queue *queue)
>>   	if (unlikely(ret)) {
>>   		pr_err("queue %d: failed to map data\n", queue->idx);
>>   		if (nvmet_tcp_has_inline_data(queue->cmd))
>> -			nvmet_tcp_fatal_error(queue);
>> -		else
>> -			nvmet_req_complete(req, ret);
>> +			return -EPROTO;
>> +
>> +		nvmet_req_complete(req, ret);
>>   		ret =3D -EAGAIN;
>>   		goto out;
>>   	}
>> @@ -1211,7 +1205,6 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp=
_queue *queue)
>>  =20
>>   		if (unlikely(!nvmet_tcp_pdu_valid(hdr->type))) {
>>   			pr_err("unexpected pdu type %d\n", hdr->type);
>> -			nvmet_tcp_fatal_error(queue);
>>   			return -EIO;
>>   		}
>>  =20
>> @@ -1225,16 +1218,12 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_t=
cp_queue *queue)
>>   	}
>>  =20
>>   	if (queue->hdr_digest &&
>> -	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen)) {
>> -		nvmet_tcp_fatal_error(queue); /* fatal */
>> +	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen))
>>   		return -EPROTO;
>> -	}
>>  =20
>>   	if (queue->data_digest &&
>> -	    nvmet_tcp_check_ddgst(queue, &queue->pdu)) {
>> -		nvmet_tcp_fatal_error(queue); /* fatal */
>> +	    nvmet_tcp_check_ddgst(queue, &queue->pdu))
>>   		return -EPROTO;
>> -	}
>>  =20
>>   	return nvmet_tcp_done_recv_pdu(queue);
>>   }
>> @@ -1319,7 +1308,6 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_t=
cp_queue *queue)
>>   			le32_to_cpu(cmd->exp_ddgst));
>>   		nvmet_req_uninit(&cmd->req);
>>   		nvmet_tcp_free_cmd_buffers(cmd);
>> -		nvmet_tcp_fatal_error(queue);
>>   		ret =3D -EPROTO;
>>   		goto out;
>>   	}
>
> I seem to be missing something crucial here. But after applying this
> patch _all_ invocations to nvmet_tcp_fatal_error() are gone.
> (Applying the patches on top of linus tree with topmost commit=20
> 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a)
>
> I must be missing something crucial here ...

I've just rebased my branch on top of master and I can still
see nvmet_tcp_socket_error() calling nvmet_tcp_fatal_error()

nvmet_tcp_socket_error() is called by both nvmet_tcp_try_send()
and nvmet_tcp_try_recv() in case of errors, so it's still here.
with us.

Maurizio


