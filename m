Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5C5C35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 22:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qvneRCcyEApkyUDFupFju/e7vL9gMt5adMnD3yGBImA=; b=UVE6JdQSBWkU0cc9Jfc8aNvQNx
	0aoRmyTl/SX/fMQfrN+WD9Pgd4DqJG4omSZV4TVIx30GPcU7qbJf28ULNcskvDgSsi/PhC5WnOs29
	3+t2i6hemwdxgxdJHd+KbVNHPqCb7lxURQNKW1OK8B6D5Hvdn076WGjEqwrjWsv5CU1/spR2Vonbj
	ItiV2V5iBoEYhL3wS4nsPYt8PgFh+3Ta9qW/gfkNjTq+iV3FnZN4hnVZg/hRacdlGPdtfcQGAR0nF
	pRFZJBDglPO0tEzkFs5qe72ESbxCZ8QYs/VUu4uej1EPVCLTPzplUAvMV/1j3EraDtbk/z76/1ObQ
	mDnmqPHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv2ES-0000000AKFx-2Xu8;
	Wed, 19 Mar 2025 22:49:52 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv2C3-0000000AJzK-3nCj
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 22:47:25 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3f417de5e25so81897b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 19 Mar 2025 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742424442; x=1743029242; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvneRCcyEApkyUDFupFju/e7vL9gMt5adMnD3yGBImA=;
        b=PzMi7sK6ot2bm4cJx5VQQjLT67EJRXaVfSv83jTfulcIky8evv3qmY85AOgc/DTLOD
         OAK8IqLwex+S4DBcArD3FQ6qTb3JYKCI9j2Ayj+x2yOPB+SHmuc9yPbdShF8Aa9W+ioJ
         XgJPz17WUnkWs+8j4CxFXCt14bw6j90nQB3wfPi2xl98hQbKI5Ws4swe9qCsjYJ+ydUw
         T5XK6cF2AANOS4NBI6KwKFLpvIOrjuz/umk9JYCHvJNDmp95riGonnjZi+LnHBr794Je
         /gMvPGx3ue7pVduMfbybzOboMl67TLF0uivgmfr7RIqKRXnyW/HHchc1OttcR+OXsrlw
         IoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424442; x=1743029242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvneRCcyEApkyUDFupFju/e7vL9gMt5adMnD3yGBImA=;
        b=ZbSJsujS3bBNdnZR5wY8xlZVME6N6sybaBfXNAumcOL5zaGi1C25tuh+PWbpQzo7LU
         Tyfi6nMkPR8MSRlR0nAhajY9681oUlqIX9ziWUSj2+szvoJaE+fDNG8pl3Pn703RME4z
         6oPyWWIRaUGt1p+CWmBw9BDN3VSmtQfkY5PfgHoQg/C9sbMWu24iyuLLTh8tv2Q6RUT3
         7xm//ontKIeq4WzPj1qjPGGmFak4DYypW9ogHJZQ85f8dK3Kq9BOhVA01fMcHSQU+/ld
         +1geUGl+r8oXf1NhTkxmMO3fJtC0BA6wUHkFxi9NfGFuoxr+bpA3j+PbKzsLa17lwHTT
         V93w==
X-Forwarded-Encrypted: i=1; AJvYcCUVUvd5b5hqE4Uf3wFDXaToCjTd5JLgPMesl0op0UkEAjCfHjwvxjNuI9kh8DX/t1Il9dJxHHrbXRAH@lists.infradead.org
X-Gm-Message-State: AOJu0YxiWbh4mdnn2fk8H+r2vYPmH72QMYU9Yo7ZTKJKBs7tx5ryI69C
	H5LQm5lhNMxX/QIClkFQ+LU/TX14vZ935WlEnmomUYMsg2SzjAga
X-Gm-Gg: ASbGncuIHjueiFRDyoNWqDH2Xc7P/FlCzneUjIcx4eLb6qvVFoz65z/0aDxqjB5D2xQ
	gH+Uwwyo2nGJE6OPRPm0cC/0v7KBX0dXeExWU1d4uwkFiIrcaAsfTShXhzSK8AgqWbSOD64+qZw
	nkfMOMPq4FB4HjvwnDjPpzUCL7G39lG+7GVGTERwM51qv1u49nmTrxFm5ef7LRVzAbiFf8Gt+kM
	/W3V5cmfK4PROocc/zL3ttAB5afHKoIolOPkSxDPuHg1rW9I3PXzAr5j8AZDk62ivBu9HcGkBca
	z62PnyLRLR266kMZySBpf4w16g/ckmKyK5p/pQCKuluxs8+SJZ/lQrLdQBwz
X-Google-Smtp-Source: AGHT+IG/enYdDnAVljshROZf5lLoBS7nS1WZ676mWNkuGpQyBGM02m9xUEYixJ8ySTbCtsEDWlwGmw==
X-Received: by 2002:a05:6808:2123:b0:3fb:3059:3789 with SMTP id 5614622812f47-3feb4b8ca75mr724787b6e.32.1742424442207;
        Wed, 19 Mar 2025 15:47:22 -0700 (PDT)
Received: from [10.69.34.111] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd45235f8sm2833602b6e.19.2025.03.19.15.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 15:47:21 -0700 (PDT)
Message-ID: <4937c9f8-fbc7-46d4-a14f-262a0244f1f0@gmail.com>
Date: Wed, 19 Mar 2025 15:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_154723_950101_E23CC707 
X-CRM114-Status: GOOD (  31.93  )
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

On 3/18/2025 3:40 AM, Daniel Wagner wrote:
> fcloop depends on the host or the target to allocate the fcloop_lsreq
> object. This means that the lifetime of the fcloop_lsreq is tied to
> either the host or the target. Consequently, the host or the target must
> cooperate during shutdown.
> 
> Unfortunately, this approach does not work well when the target forces a
> shutdown, as there are dependencies that are difficult to resolve in a
> clean way.

ok - although I'm guessing you'll trading one set of problems for another.

> 
> The simplest solution is to decouple the lifetime of the fcloop_lsreq
> object by managing them directly within fcloop. Since this is not a
> performance-critical path and only a small number of LS objects are used
> during setup and cleanup, it does not significantly impact performance
> to allocate them during normal operation.

ok

> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 53 +++++++++++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 06f42da6a0335c53ae319133119d057aab12e07e..537fc6533a4cf5d39855cf850b82af739eeb3056 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -342,6 +342,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
>   		 * callee may free memory containing tls_req.
>   		 * do not reference lsreq after this.
>   		 */
> +		kfree(tls_req);
>   
>   		spin_lock(&rport->lock);
>   	}
> @@ -353,10 +354,13 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
>   			struct nvme_fc_remote_port *remoteport,
>   			struct nvmefc_ls_req *lsreq)
>   {
> -	struct fcloop_lsreq *tls_req = lsreq->private;
>   	struct fcloop_rport *rport = remoteport->private;
> +	struct fcloop_lsreq *tls_req;
>   	int ret = 0;
>   
> +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> +	if (!tls_req)
> +		return -ENOMEM;
>   	tls_req->lsreq = lsreq;
>   	INIT_LIST_HEAD(&tls_req->ls_list);
>   
> @@ -387,19 +391,23 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
>   	struct nvme_fc_remote_port *remoteport = tport->remoteport;
>   	struct fcloop_rport *rport;
>   
> +
> +	if (!remoteport) {
> +		kfree(tls_req);
> +		return -ECONNREFUSED;
> +	}
> +

don't do this - this is not a path the lldd would generate.

>   	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
>   		((lsreq->rsplen < lsrsp->rsplen) ?
>   				lsreq->rsplen : lsrsp->rsplen));
>   
>   	lsrsp->done(lsrsp);

This done() call should always be made regardless of the remoteport 
presence.

instead, put the check here

         if (!remoteport) {
             kfree(tls_req);
             return 0;
         }

>   
> -	if (remoteport) {
> -		rport = remoteport->private;
> -		spin_lock(&rport->lock);
> -		list_add_tail(&tls_req->ls_list, &rport->ls_list);
> -		spin_unlock(&rport->lock);
> -		queue_work(nvmet_wq, &rport->ls_work);
> -	}
> +	rport = remoteport->private;
> +	spin_lock(&rport->lock);
> +	list_add_tail(&tls_req->ls_list, &rport->ls_list);
> +	spin_unlock(&rport->lock);
> +	queue_work(nvmet_wq, &rport->ls_work);

this is just an indentation style - whichever way works.

>   
>   	return 0;
>   }
> @@ -426,6 +434,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
>   		 * callee may free memory containing tls_req.
>   		 * do not reference lsreq after this.
>   		 */
> +		kfree(tls_req);
>   
>   		spin_lock(&tport->lock);
>   	}
> @@ -436,8 +445,8 @@ static int
>   fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
>   			struct nvmefc_ls_req *lsreq)
>   {
> -	struct fcloop_lsreq *tls_req = lsreq->private;
>   	struct fcloop_tport *tport = targetport->private;
> +	struct fcloop_lsreq *tls_req;
>   	int ret = 0;
>   
>   	/*
> @@ -445,6 +454,10 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
>   	 * hosthandle ignored as fcloop currently is
>   	 * 1:1 tgtport vs remoteport
>   	 */
> +
> +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> +	if (!tls_req)
> +		return -ENOMEM;
>   	tls_req->lsreq = lsreq;
>   	INIT_LIST_HEAD(&tls_req->ls_list);
>   
> @@ -461,6 +474,9 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
>   	ret = nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
>   				 lsreq->rqstaddr, lsreq->rqstlen);
>   
> +	if (ret)
> +		kfree(tls_req);
> +
>   	return ret;
>   }
>   
> @@ -475,18 +491,21 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
>   	struct nvmet_fc_target_port *targetport = rport->targetport;
>   	struct fcloop_tport *tport;
>   
> +	if (!targetport) {
> +		kfree(tls_req);
> +		return -ECONNREFUSED;
> +	}
> +

same here - don't do this - this is not a path the lldd would generate.

>   	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
>   		((lsreq->rsplen < lsrsp->rsplen) ?
>   				lsreq->rsplen : lsrsp->rsplen));
>   	lsrsp->done(lsrsp);
>   

Same for this done().

instead, put the check here

         if (!targetport) {
             kfree(tls_req);
             return 0;
         }

> -	if (targetport) {
> -		tport = targetport->private;
> -		spin_lock(&tport->lock);
> -		list_add_tail(&tport->ls_list, &tls_req->ls_list);
> -		spin_unlock(&tport->lock);
> -		queue_work(nvmet_wq, &tport->ls_work);
> -	}
> +	tport = targetport->private;
> +	spin_lock(&tport->lock);
> +	list_add_tail(&tport->ls_list, &tls_req->ls_list);
> +	spin_unlock(&tport->lock);
> +	queue_work(nvmet_wq, &tport->ls_work);
>   
>   	return 0;
>   }
> @@ -1129,7 +1148,6 @@ static struct nvme_fc_port_template fctemplate = {
>   	/* sizes of additional private data for data structures */
>   	.local_priv_sz		= sizeof(struct fcloop_lport_priv),
>   	.remote_priv_sz		= sizeof(struct fcloop_rport),
> -	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
>   	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
>   };
>   
> @@ -1152,7 +1170,6 @@ static struct nvmet_fc_target_template tgttemplate = {
>   	.target_features	= 0,
>   	/* sizes of additional private data for data structures */
>   	.target_priv_sz		= sizeof(struct fcloop_tport),
> -	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
>   };
>   
>   static ssize_t
> 

-- james


