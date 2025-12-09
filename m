Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D892D3B983
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCzFtkG3lOL8hHwPACdkZ1ExCfN+JZeKct/e0R4FgRo=; b=Ivg4VhAnQ1InVzEtksYDxyNeHG
	7wNmIkn9fvBkV4ql/6dVQIlD85kzzdAuIWx35zjmjim2FcRuSTjjOJmUDLl9ka5JiJQAGxmQmbyS1
	woHnc81SFopGWmlZykReowuL2O7YsuXlCrfFvEI0b/lznQImnoNo2nZsdZj9oiSz4DAF0GZyzV3cw
	xTS/LIPjiQF3HXRloLwF4FGLrtAImzkMZjKNpS6sUcYSt4022uqJoBkGONd9Z3SlA23xYEd1Q/VOH
	782/qyZRPaHIV9+VGwdAxKW7dI32W5IroPeetN0nIi+z+wDYy/kEYB97sKG84H7clz0LqTv+2VdXY
	vtyEfuHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT15M-0000000EZEf-2lw5;
	Tue, 09 Dec 2025 17:01:12 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT15G-0000000EZEF-1khb
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 17:01:10 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dQlVT6sRtzlkSBM;
	Tue,  9 Dec 2025 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1765299662; x=1767891663; bh=CCzFtkG3lOL8hHwPACdkZ1Ex
	CfN+JZeKct/e0R4FgRo=; b=hMxte85suXmmIIbBBERNcsjA0H/pK8sZWaZSPO0X
	sMFhy7Ng+bSYhWaJvxy+WdIeZ07CCOBE1LhjNxhHQd6Py9gVZkJjkDB30L913GfI
	6zJfYEbwlco8qOC3ogpPH60xKKkcw31XEvDmTcePxh34JsyN3H00YkRMK+tq0xU3
	w8jRKVfvlWo5IVi+4xh11Gp7Ji1kpyxApf2h8xdRuBWBJVqz6pH8RsooO+7WfGtA
	5AxQXt8n/8O6cA4ENbaCu4IzEeKjZGdv6RzA/q2pOn/mZNrORVNDkZ+nxLZdYBSk
	hOSd80T40PgCSfxluFSzXOiqmE4QfsSpAR3k8TuJjZi6bw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eMD8o5F3SxOF; Tue,  9 Dec 2025 17:01:02 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dQlVH4S9JzlgyGt;
	Tue,  9 Dec 2025 17:00:55 +0000 (UTC)
Message-ID: <1e4c4cb6-e787-4078-b7b0-787bd45ebd78@acm.org>
Date: Tue, 9 Dec 2025 09:00:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
To: Hannes Reinecke <hare@suse.de>,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
 <20251205211738.1872244-2-mkhalfella@purestorage.com>
 <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_090106_504608_7BB68851 
X-CRM114-Status: GOOD (  13.04  )
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

On 12/8/25 11:30 PM, Hannes Reinecke wrote:
>> @@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct=20
>> request_queue *q)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct blk_mq_tag_set *set =3D q->tag_s=
et;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&set->tag_list_lock);
>> -=C2=A0=C2=A0=C2=A0 list_del(&q->tag_set_list);
>> +=C2=A0=C2=A0=C2=A0 list_del_rcu(&q->tag_set_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list_is_singular(&set->tag_list)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* just transit=
ioned to unshared */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set->flags &=3D=
 ~BLK_MQ_F_TAG_QUEUE_SHARED;
>> @@ -4302,7 +4302,6 @@ static void blk_mq_del_queue_tag_set(struct=20
>> request_queue *q)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_update_t=
ag_set_shared(set, false);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&set->tag_list_lock);
>> -=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&q->tag_set_list);
>> =C2=A0 }
> I'm ever so sceptical whether we can remove the INIT_LIST_HEAD() here.
> If we can it was pointless to begin with, but I somehow doubt that.
> Do you have a rationale for that (except from the fact that you
> are moving to RCU, and hence the 'q' pointer might not be valid then).

My understanding is that calling INIT_LIST_HEAD() after list_del_rcu()
without letting a grace period expire first is not allowed because it
introduces a race condition. From the block layer git history:

commit a347c7ad8edf4c5685154f3fdc3c12fc1db800ba
Author: Roman Pen <roman.penyaev@profitbricks.com>
Date:   Sun Jun 10 22:38:24 2018 +0200

     blk-mq: reinit q->tag_set_list entry only after grace period

     It is not allowed to reinit q->tag_set_list list entry while RCU gra=
ce
     period has not completed yet, otherwise the following soft lockup in
     blk_mq_sched_restart() happens: [ ... ]

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d2de0a719ab8..2be78cc30ec5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2349,7 +2349,6 @@ static void blk_mq_del_queue_tag_set(struct=20
request_queue *q)

         mutex_lock(&set->tag_list_lock);
         list_del_rcu(&q->tag_set_list);
-       INIT_LIST_HEAD(&q->tag_set_list);
         if (list_is_singular(&set->tag_list)) {
                 /* just transitioned to unshared */
                 set->flags &=3D ~BLK_MQ_F_TAG_SHARED;
@@ -2357,8 +2356,8 @@ static void blk_mq_del_queue_tag_set(struct=20
request_queue *q)
                 blk_mq_update_tag_set_depth(set, false);
         }
         mutex_unlock(&set->tag_list_lock);
-
         synchronize_rcu();
+       INIT_LIST_HEAD(&q->tag_set_list);
  }

Thanks,

Bart.

