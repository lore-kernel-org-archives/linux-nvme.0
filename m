Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F7C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:18:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E43A2078E
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="az+DQUbS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G/BQ9JB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E43A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1FOPxj5/qcRWQNLnH1xv+VXOa53kIylqXVNdVilfVHY=; b=az+DQUbSiSFlJMMJPAQu0AIFq
	Ny9FbvR6H0XMfFOG9gHG4FtMr8JHhsSiD3C/aO+OruC1nxjuPOyRwxg8+7U0zY/ECLcjdk0m9zvGi
	uoJmX81JBVGPCvIxEGqpaOxkCJYecRApVdm/Eu1GCPwJ7a+gZMhMV7MX7KNPiMqAocm7hGkR86JXK
	ZuL93wO1+1Pn6jfbxWnjcXVsK2btVMe+E2OAFonTN0rArOTSDsa8DkWy7ZKhPiMSP3FThomqq+OG8
	L/Kk+FT0fU6/OrFMV+uL6WE4iBj5eGIOJNfCJd2eht0J/kR7OXohgGpZmOF3kMvhHG0FSAM4pjrs7
	t+MA9QGfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPU7u-00057z-83; Mon, 05 Oct 2020 17:18:18 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPU7q-00056h-VX
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 17:18:16 +0000
Received: by mail-pf1-x443.google.com with SMTP id n136so1408048pfd.11
 for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2020 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=At2bvEe0nqTA7tj/1Dac1l7Vs2cIrS1hYO/+X6n1aWM=;
 b=G/BQ9JB9Iy5jUK96N2HkisAH54OEuJbNVjoGHtGIb2ajHL9DyrnEUbhSD+e6+vtwGH
 IAR73Qsj3esWGSLZ2ajMV0f/YF0e0WjjXJovHDBA1QB71YQ5CTnOh6okW/ZVYLLMrWIT
 U8yBzS0hZMh+hYsfLmOLtQxqvMEgrt04ooKZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=At2bvEe0nqTA7tj/1Dac1l7Vs2cIrS1hYO/+X6n1aWM=;
 b=U2gwTYZwr+dMxIau0VNRaKwTz5y64T6k5DzWrFDFgdVNQrH09VvJXClioObOIM9Gxz
 ZcKW1uHDhq18PVVTmNoNU0AsKzuZf4bKfXPGdTP67xbaBqymDmJDZvwKVf8rv7VDqmh6
 YN235A074E3dBbRLow4jJz6f73ZQe/jEbzZWOOlXroo24Uhv5QQT+4fmZlz6B8auvm5C
 RW2mhLAofX+GhCaiYr+rePyxwoiCilbYimWpzlyeTTs2kea1rByHI9edEMqCb8GmtlgA
 IiVcPW+1sO83RHSreNDQTIbgbwQevHTmJ0V7hdiqMB4TCtY/n1nxKQkmUyOnplgA8Inu
 gJcw==
X-Gm-Message-State: AOAM530gtSLswVDTYjyVlst3hSFA8DwgcSjNJio99xuafoJLGA6M/VGh
 DNOHdNuY4wWo0X5XwXRAwQRibcam9Ih653BoiWtPIhQKvjlI0ZZCJX+jIREE+01Ov5iRtuT97jw
 PN93jXLd02PAAHg1Z+sobLIZ62txIbiGN7dGh9HCWL6V9brA/Tu14/FpoXai42WNyg3rLCE0mue
 aSeE5kQSfk
X-Google-Smtp-Source: ABdhPJxq0njdEy4/nf0j48Cl+t1F3yzOVBJ28mKK1fcMxQG4wfTJZE+OuzrjfuNJFZaA3gl1ad8ptA==
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id
 s7-20020aa782870000b0290142250139ecmr481150pfm.59.1601918292083; 
 Mon, 05 Oct 2020 10:18:12 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id ep11sm130064pjb.55.2020.10.05.10.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:18:10 -0700 (PDT)
Subject: Re: [PATCH 2/7] nvmet-fc: use per-target workqueue when removing
 associations
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200922121501.32851-1-hare@suse.de>
 <20200922121501.32851-3-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <41ce327c-6b29-8835-9541-6ff41a0fb9c8@broadcom.com>
Date: Mon, 5 Oct 2020 10:18:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922121501.32851-3-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_131815_035594_8CBFE477 
X-CRM114-Status: GOOD (  24.81  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Type: multipart/mixed; boundary="===============5753203026459765316=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============5753203026459765316==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000caf17c05b0efaa26"

--000000000000caf17c05b0efaa26
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

On 9/22/2020 5:14 AM, Hannes Reinecke wrote:
> When removing target ports all outstanding associations need to be
> terminated / cleaned up. As this involves several exchanges on the
> wire a synchronization point is required to establish when these
> exchanges have ran their course and it's safe to delete the association.
> So add a per-target workqueue and flush this workqueue to ensure
> the association can really be deleted.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/fc.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 04ec0076ae59..63f5deb3b68a 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -99,6 +99,7 @@ struct nvmet_fc_tgtport {
>   	struct list_head		tgt_list; /* nvmet_fc_target_list */
>   	struct device			*dev;	/* dev for dma mapping */
>   	struct nvmet_fc_target_template	*ops;
> +	struct workqueue_struct		*work_q;
>   
>   	struct nvmet_fc_ls_iod		*iod;
>   	spinlock_t			lock;
> @@ -1403,10 +1404,17 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
>   	ida_init(&newrec->assoc_cnt);
>   	newrec->max_sg_cnt = template->max_sgl_segments;
>   
> +	newrec->work_q = alloc_workqueue("ntfc%d", 0, 0,
> +					 newrec->fc_target_port.port_num);
> +	if (!newrec->work_q) {
> +		ret = -ENOMEM;
> +		goto out_free_newrec;
> +	}
> +
>   	ret = nvmet_fc_alloc_ls_iodlist(newrec);
>   	if (ret) {
>   		ret = -ENOMEM;
> -		goto out_free_newrec;
> +		goto out_free_workq;
>   	}
>   
>   	nvmet_fc_portentry_rebind_tgt(newrec);
> @@ -1418,6 +1426,8 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
>   	*portptr = &newrec->fc_target_port;
>   	return 0;
>   
> +out_free_workq:
> +	destroy_workqueue(newrec->work_q);
>   out_free_newrec:
>   	put_device(dev);
>   out_ida_put:
> @@ -1443,6 +1453,8 @@ nvmet_fc_free_tgtport(struct kref *ref)
>   	list_del(&tgtport->tgt_list);
>   	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
>   
> +	destroy_workqueue(tgtport->work_q);
> +
>   	nvmet_fc_free_ls_iodlist(tgtport);
>   
>   	/* let the LLDD know we've finished tearing it down */
> @@ -1481,11 +1493,13 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
>   				&tgtport->assoc_list, a_list) {
>   		if (!nvmet_fc_tgt_a_get(assoc))
>   			continue;
> -		if (!schedule_work(&assoc->del_work))
> +		if (!queue_work(tgtport->work_q, &assoc->del_work))
>   			/* already deleting - release local reference */
>   			nvmet_fc_tgt_a_put(assoc);
>   	}
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
> +
> +	flush_workqueue(tgtport->work_q);
>   }
>   
>   /**
> @@ -1536,12 +1550,14 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
>   			continue;
>   		assoc->hostport->invalid = 1;
>   		noassoc = false;
> -		if (!schedule_work(&assoc->del_work))
> +		if (!queue_work(tgtport->work_q, &assoc->del_work))
>   			/* already deleting - release local reference */
>   			nvmet_fc_tgt_a_put(assoc);
>   	}
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   
> +	flush_workqueue(tgtport->work_q);
> +
>   	/* if there's nothing to wait for - call the callback */
>   	if (noassoc && tgtport->ops->host_release)
>   		tgtport->ops->host_release(hosthandle);
> @@ -1579,14 +1595,15 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
>   		}
>   		spin_unlock_irqrestore(&tgtport->lock, flags);
>   
> -		nvmet_fc_tgtport_put(tgtport);
> -
>   		if (found_ctrl) {
> -			if (!schedule_work(&assoc->del_work))
> +			if (!queue_work(tgtport->work_q, &assoc->del_work))
>   				/* already deleting - release local reference */
>   				nvmet_fc_tgt_a_put(assoc);
> +			flush_workqueue(tgtport->work_q);
> +			nvmet_fc_tgtport_put(tgtport);
>   			return;
>   		}
> +		nvmet_fc_tgtport_put(tgtport);
>   
>   		spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
>   	}

Looks reasonable.

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

--000000000000caf17c05b0efaa26
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AanDaJF6fE9TEzbfn5AWgVgHkbqS3VY3Gq05xkLhRugDQ60IGwT29K1B+wGfcujKSaalhQIDAQAB
o4IBzzCCAcswDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZB
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmcz
b2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNv
bmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0w
OzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMu
Y3JsMCMGA1UdEQQcMBqBGGphbWVzLnNtYXJ0QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUUXCHNA1n5KXj
CXL1nHkJ8oKX5wYwDQYJKoZIhvcNAQELBQADggEBAGQDKmIdULu06w+bE15XZJOwlarihiP2PHos
/4bNU3NRgy/tCQbTpJJr3L7LU9ldcPam9qQsErGZKmb5ypUjVdmS5n5M7KN42mnfLs/p7+lOOY5q
ZwPZfsjYiUuaCWDGMvVpuBgJtdADOE1v24vgyyLZjtCbvSUzsgKKda3/Z/iwLFCRrIogixS1L6Vg
2JU2wwirL0Sy5S1DREQmTMAuHL+M9Qwbl+uh/AprkVqaSYuvUzWFwBVgafOl2XgGdn8r6ubxSZhX
9SybOi1fAXGcISX8GzOd85ygu/3dFqvMyCBpNke4vdweIll52KZIMyWji3y2PKJYfgqO+bxo7BAa
ROYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDH5i
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg0bhi1lRZs42hhF3Y
wj8CTkzsay8OWdR7tMS6daRe/t0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDA1MTcxODEyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAA6oNeqtJE7t8Ajo3b6WZwMCrrArMCrrvqm5
TwQskEZFh5H+SGUFCxzpKYaVaEeEUxFH46rfs4WvD6NJOue9d27pLD/mzGnKmVhhMsooXImRok51
d6QMtFTdB6dDPVKGaEBii0m29jAOAqj/KV46xi5N64ALnvrtZSBI2L8K9qAOz5D7uCmR4pZuoxFb
g1pnOkSsfw18M35v8E2RO3OzRCUPV80PEqVZeYYDbsIMl+fuz4T7QPSyy+M2/UyMeme6xJ30TPpW
6udfKLWZJiMhNR9RuLtQmLoOGVZ/Mr1ixcNlnQQJ85or4TLceEc/BJRV4ofKdUJWJGVoCqNNaDvU
Ns0=
--000000000000caf17c05b0efaa26--


--===============5753203026459765316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============5753203026459765316==--

