Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D56EC25B76
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M6QC2phMfU+oDfa8xsGcmSl929Pbx4+dKmxreipiw7E=; b=MJAf53/miQwitvzeMTBpbpyUJm
	Zwbt768qP93YiGckmurQxZdFSBP2J9AEBJaCjuq22AcogoWYF61DdHa3VYkEuTgD05RGz8su2EC7e
	MKCzW+M6Nj+XSjSgZKXvowfvd2elFKvDDr8lOucp4HgKVngH9R4i+wcAganYzo0IdKclcmq6pvuxp
	nqWibjFlrIC4R5fKMHXzlShFtRPnxOWAr7oMaNA3gK6yDfaK+TIR1PqOjWj0WYhT5PQBcr2ObuOKq
	1RM6TifTf6WIYvyquVukavhbAcH/C7owz3fPDkodD9eVt7S2tmVEnoM6XB0jvxi5TK0dWHoD4jmUc
	0vEN8aRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE49Z-0000000GGZu-3vph;
	Mon, 03 Jun 2024 09:38:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE49X-0000000GGYB-31Lj
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 09:38:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717407534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6QC2phMfU+oDfa8xsGcmSl929Pbx4+dKmxreipiw7E=;
	b=T23u3/u/EELHqD7Z27itJc94seHIfrCSBdW0PChMzpHCWb1iIyndlJe+GeslqYcD2hqnNv
	ApZyuJCeF2w4d8ikHIK+8ukhHM4+Ot1zTtxLhzgeCwUd7MSfyfUpkO1e0BsCoHTJHb4X5X
	Uq7TCVXXnYFT7QCZbkoNmt/EaisF8IM=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-d5bgOjwPMiWY2lcx_h5v8g-1; Mon, 03 Jun 2024 05:38:52 -0400
X-MC-Unique: d5bgOjwPMiWY2lcx_h5v8g-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4e4f02f0c5aso2502743e0c.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 02:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407532; x=1718012332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6QC2phMfU+oDfa8xsGcmSl929Pbx4+dKmxreipiw7E=;
        b=wQIVcwYTcTkNSY/qvkdGa10lz72flbLBDsbYJdXas7acNNBRvttvj9Pc/icJF3SFwj
         yCBBguzr5xZGY2IfBPDQpvsTLzkWH6wqzHRIE5ayDI3ySd92tJUzExlOPqicimYJIwg+
         d7YZvynewJz8l5wfcmjONUPu12FTUserOwsGB5j9qk3Fvs4Rgx+VW9iTKQELOlO1bPAs
         3qIPwcDP4U7eTOdgrv3nMUjmDpgo02znegAzg3OtDrTL3y2qjnv3tItW30qUAUrvTShf
         +g9reuZetqaJRxD3X32OVcdfJPwqzwrwQSiHFfav2bssjg5lXrt7WyQEBxFuXF0KO1t+
         7lUA==
X-Forwarded-Encrypted: i=1; AJvYcCUMWTl4a4cQhIqFiCrUG17CUJLQMU31nuqvjDds8Y/QiHkHdPRWzAM2vsKfn/ttV2z0tCK3Hk7v0ilAUeyyHVgoOiTvA0tpDFwTDO4TWns=
X-Gm-Message-State: AOJu0YxG+4keFTd0no0t//gBD+AaJpA2XxjOw0MiOsp/HOYTxDUPlw/U
	Golp7Lxlk4kqWa2hrHudz6H4JPtQL7bBNIGHdx9gHF4m2FaOE+98QKubh+MkxKnEohksel/JPlC
	FADoF64x2CSOUDvQ8sdfnRCbYGVY/8X3Zl8MVKGjpPo3ZaJN+MKWVZEfOBAH4THpFj1io38f7VE
	PevGCGwkP7uV4dNJnAHZydYYVE5Vvz3FY/8dHK+6Y=
X-Received: by 2002:a1f:ddc2:0:b0:4e4:ef76:3843 with SMTP id 71dfb90a1353d-4eb02d6d349mr7225569e0c.2.1717407532080;
        Mon, 03 Jun 2024 02:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8B9hztlV9mUGsAqOW7WdWUNX3DOPVw5hdWiFGPGzcoDnAJzGZUH/D/mUjM7ANvdkfJmeY2R+o3GP7iTp5VdM=
X-Received: by 2002:a1f:ddc2:0:b0:4e4:ef76:3843 with SMTP id
 71dfb90a1353d-4eb02d6d349mr7225547e0c.2.1717407531694; Mon, 03 Jun 2024
 02:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me> <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me> <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
 <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com> <CAFL455kq_prujkCbNUwJzpqhL1B_P_Yu+b83kBSc0FQRAhQs8w@mail.gmail.com>
 <CAFL455ndGuGRCv7X6S6qtiEi6KhBs_sxgeyfzoLCqu6i8TyNuQ@mail.gmail.com>
 <ZlngkgSTK6IPcVc9@kalibr> <8058afc6-8272-42fa-a024-e477a29148e1@suse.de>
 <CAFL455na13RH=6x5oFbFWUccAXenVUBM9QVzAe2A=4Q9e8MMMw@mail.gmail.com> <025702f4-5f3a-4fd1-897e-ac7b7d1ca8ec@suse.de>
In-Reply-To: <025702f4-5f3a-4fd1-897e-ac7b7d1ca8ec@suse.de>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 3 Jun 2024 11:38:39 +0200
Message-ID: <CAFL455kv7-VRxA-tAu5NB3ODD+G5nG5xxJHX0KiG8yxaeu-mOw@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Hannes Reinecke <hare@suse.de>
Cc: Maurizio Lombardi <m.lombardi85@mail.ru>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_023856_012096_1C32132E 
X-CRM114-Status: GOOD (  10.74  )
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

po 3. 6. 2024 v 11:33 odes=C3=ADlatel Hannes Reinecke <hare@suse.de> napsal=
:
> Like this?
>
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a264b3ae078b..668cc4d891d7 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -983,7 +983,8 @@ EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
>
>   void nvme_auth_stop(struct nvme_ctrl *ctrl)
>   {
> -       cancel_work_sync(&ctrl->dhchap_auth_work);
> +       if (ctrl->dhchap_ctxs)
> +               cancel_work_sync(&ctrl->dhchap_auth_work);
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_stop);
>

Yes, I was not sure if it was safe to use dhchap_ctxs because
nvme_auth_init_ctrl() could return
success while leaving a NULL dhchap_ctxs pointer.

Maurizio


