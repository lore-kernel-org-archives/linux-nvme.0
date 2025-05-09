Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF65C3ABC3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 11:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmHabweNHOq4Q440GkJ89iI6ajF8QS7PW41+GMp/Vk4=; b=kY9EqMsJ9Tl7lDtT5+4CYGfYHg
	IAlwAOI2n6xbQFrOJGbHY+KMC5V2F6eX8Fzl0Nd8bEfUVgdc/WKLGEanXTPNrFKYJ4e5l1Kbl+f7u
	ojsK9bp5N1UjeoZuIdE9FU0PLMv+v9hjAArLVcvyYRjSRgaAM54vEZoUhM0oxkohl3FMVVljWPqf7
	pQhWpRLZ8aj7P3VUQCytLimkJQRVZhuDNVMs/z4kg7xlepVaXdk7iE4j8gL+KqgNppqGnpa3VHYOX
	KejpsaHxCQUzUSfluuz5i4zu3luHAmSi4Wv2SHG2p69f1AVVagqdhqNle6iBXdzvpKbcOAWoQjD9p
	4jSX0a/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDLkk-00000003Pb3-21de;
	Fri, 09 May 2025 11:18:54 +0000
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDKqs-00000003FhS-2clN
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 10:21:12 +0000
Message-ID: <f3ebdaad-9911-4533-ac4c-35aa9e7184f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746786067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmHabweNHOq4Q440GkJ89iI6ajF8QS7PW41+GMp/Vk4=;
	b=O0OyTsqH8fMh/6BMCIftlSKNZV0VYa/FLZ/uBjvwsxKlWAnZrzFr3H0TGw+KFmc386J5iK
	VVJ8HmSTw2BoOkh9qoTUCvYNqDUpMJ0FUpw5NmpvkmheEr0y7LEm99snZGNeTH1mfp+wUZ
	BqR3GU0Q3iwUpL1sCIyJvD3sVb6qp60=
Date: Fri, 9 May 2025 12:21:03 +0200
MIME-Version: 1.0
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Bernard Metzler <BMT@zurich.ibm.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Daniel Wagner <wagi@kernel.org>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_032111_012738_F2C662B6 
X-CRM114-Status: GOOD (  29.82  )
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

On 08.05.25 09:03, Shinichiro Kawasaki wrote:
> On Apr 16, 2025 / 12:42, Shin'ichiro Kawasaki wrote:
>> On Apr 15, 2025 / 15:18, Bernard Metzler wrote:
> [...]
>>> At first glance, to me it looks like a problem in the iwcm code,
>>> where a cmid's work queue handling might be broken.
> 
> I agree. The BUG slab-use-after-free happened for a work object. The call
> trace indicates that happened for the work handled by iw_cm_wq, not
> siw_cm_wq.
> 
> I took a close looks, and I think the work objects allocated for each cm_id
> is freed too early. The work objects are freed in dealloc_work_entries() when
> all references to the cm_id are removed. IIUC, when the last reference to the
> cm_id is removed in the work, the work object for the work itself gets removed.
> Hence the use-after-free.
> 
> Based on this guess, I created a fix trial patch below. It delays the reference
> removal in the cm_id destroy context, to ensure that the reference count becomes
> zeor not in the work contexts but in the cm_id destroy context. It moves
> iwcm_deref_id() call from destroy_cm_id() to its callers. Also call
> iwcm_deref_id() after flushing the pending works. With this patch, I observed
> use-after-free goes away. Comments on the fix trial patch will be welcomed.

It seems that this problem is related with the following commit.

commit aee2424246f9f1dadc33faa78990c1e2eb7826e4
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Wed Jun 5 08:51:01 2024 -0600

     RDMA/iwcm: Fix a use-after-free related to destroying CM IDs

     iw_conn_req_handler() associates a new struct rdma_id_private 
(conn_id) with
     an existing struct iw_cm_id (cm_id) as follows:

             conn_id->cm_id.iw = cm_id;
             cm_id->context = conn_id;
             cm_id->cm_handler = cma_iw_handler;

     rdma_destroy_id() frees both the cm_id and the struct 
rdma_id_private. Make
     sure that cm_work_handler() does not trigger a use-after-free by only
     freeing of the struct rdma_id_private after all pending work has 
finished.

     Cc: stable@vger.kernel.org
     Fixes: 59c68ac31e15 ("iw_cm: free cm_id resources on the last deref")
     Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
     Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
     Signed-off-by: Bart Van Assche <bvanassche@acm.org>
     Link: 
https://lore.kernel.org/r/20240605145117.397751-6-bvanassche@acm.org
     Signed-off-by: Leon Romanovsky <leon@kernel.org>


Zhu Yanjun

> 
> One left question is why the failure was not observed with rxe driver, but with
> siw driver. My mere guess is that is because siw driver calls id->add_ref() and
> cm_id->rem_ref().
> 
> 
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index f4486cbd8f45..600cf8ea6a39 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -368,12 +368,9 @@ EXPORT_SYMBOL(iw_cm_disconnect);
>   /*
>    * CM_ID <-- DESTROYING
>    *
> - * Clean up all resources associated with the connection and release
> - * the initial reference taken by iw_create_cm_id.
> - *
> - * Returns true if and only if the last cm_id_priv reference has been dropped.
> + * Clean up all resources associated with the connection.
>    */
> -static bool destroy_cm_id(struct iw_cm_id *cm_id)
> +static void destroy_cm_id(struct iw_cm_id *cm_id)
>   {
>   	struct iwcm_id_private *cm_id_priv;
>   	struct ib_qp *qp;
> @@ -442,20 +439,22 @@ static bool destroy_cm_id(struct iw_cm_id *cm_id)
>   		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
>   		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
>   	}
> -
> -	return iwcm_deref_id(cm_id_priv);
>   }
>   
>   /*
>    * This function is only called by the application thread and cannot
>    * be called by the event thread. The function will wait for all
> - * references to be released on the cm_id and then kfree the cm_id
> - * object.
> + * references to be released on the cm_id and then release the initial
> + * reference taken by iw_create_cm_id.
>    */
>   void iw_destroy_cm_id(struct iw_cm_id *cm_id)
>   {
> -	if (!destroy_cm_id(cm_id))
> -		flush_workqueue(iwcm_wq);
> +	struct iwcm_id_private *cm_id_priv;
> +
> +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> +	destroy_cm_id(cm_id);
> +	flush_workqueue(iwcm_wq);
> +	iwcm_deref_id(cm_id_priv);
>   }
>   EXPORT_SYMBOL(iw_destroy_cm_id);
>   
> @@ -1035,8 +1034,10 @@ static void cm_work_handler(struct work_struct *_work)
>   
>   		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
>   			ret = process_event(cm_id_priv, &levent);
> -			if (ret)
> -				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
> +			if (ret) {
> +				destroy_cm_id(&cm_id_priv->id);
> +				WARN_ON_ONCE(iwcm_deref_id(cm_id_priv));
> +			}
>   		} else
>   			pr_debug("dropping event %d\n", levent.event);
>   		if (iwcm_deref_id(cm_id_priv))


