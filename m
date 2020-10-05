Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD65C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:45:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6EA207BC
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hni0Ga0j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SWNbSvv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6EA207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Hd8cukqKITqO7981LC1liK6CbbljtI0Uuxmj6v75MU4=; b=hni0Ga0jwwDCRVATsptVLNzQp
	Ofo4Fm/ZbeERONzSsw6s5Gs5qgB1Dfgq/5pOrqHn3BI7EXiAnzU+NRyO9CRxzqcbfPf4qsMQRVix6
	s3uggM6eOTlDZTCY/n3f5sU47PfFLVO1dRGpoVqceKbK9u7fRQlFzXxxUzUPT3MDkYKUdrDnpcRSj
	oJ5L15xSP1DtBM3grPtb/SJDVmmaZ1ph3pfTRJ+ThTY4/bT5s4BT8fGv8G2yqw0txvYSnBIYSJq18
	R3nT4NjodZlXLDjXE86tNrHE/GssU/s0ZmEUNm9dQgH29q4k7F0kt2Spcs7pj0fwWKlR4RGaB/Ql9
	Hx2kMBbdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPUYD-0003IZ-00; Mon, 05 Oct 2020 17:45:29 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPUY7-0003GG-MC
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 17:45:26 +0000
Received: by mail-pg1-x542.google.com with SMTP id 34so6436163pgo.13
 for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2020 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=oSpnfjbWCH68Kl1ZVKcn5ISPA6tROXa/zUq1dHxh5gs=;
 b=SWNbSvv3CHQbgSfPyH2hU2s8mcVB/VBAe4NMzBu9PsO1wuf9qdGEh4hSJTxomr2pnx
 4o2lPJIz/mVi9w2UlsE3crOKU7ih4QKcjhrhy4ACcjbDAbQTLxKd/xnqBr4EoJtbcl1n
 2My8fT4ccA8OCD1OTu7oh4Ay1s72q3zRDxG3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=oSpnfjbWCH68Kl1ZVKcn5ISPA6tROXa/zUq1dHxh5gs=;
 b=QieQxXuW/vBoaKjwOxb/ubQZM/RIW1CJUvFeK2v17tAahNoFzlE86SUTliPGupdiNW
 Fq8VImR4uCYNIGZAYP6PRCXSJn91bSzbmCupmdysKFRYDM7ugYUx1ERon4kJfRFSJIjg
 vI89BPsHMdzskzdgOkgPX4LI7PeH8LtS0HCmB+TAAdOwXgpfw6sVgZmtWM3GaZO7Tvym
 5O0sdvSDWP98JdsGpAYnKNvrX2rqfonsDUQzczWL79kBtCM2aAPVoiTXc3j+360V80F0
 lJ88i8P+eI6lKpC5yk20R/H491MyxVkMuJIIXeoVKOK1hqMApxPM2rtX/3wozRWdegXn
 B0kQ==
X-Gm-Message-State: AOAM530+rCgPkCOGWF8VA+yInOJvtC3MpBCpHal53FcmoxUZ3BjdyvWL
 8J6rJL8CwCfjf5tBgQqNRjblqsOz9QQyHN58Ibx/W+vLb8ikFKaevusBQ7RhFFhsm6Y8iXPF8qF
 SU7bdNXt6b0cDW5Zj+ZntLgndiNhaFkySkck8kri7Zx1Q7mMAnHEcyte9HXa5gsAJOi5QsJ7hos
 0mBSd2oHwq
X-Google-Smtp-Source: ABdhPJzTCXRzKLwXnii5dXmy/hLQEgOzNHopYq1i1ZJoVdt/+s8x63pWtksbM64w5/NTD2USIRlkpw==
X-Received: by 2002:a63:778f:: with SMTP id s137mr579983pgc.7.1601919920887;
 Mon, 05 Oct 2020 10:45:20 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s16sm242239pgl.78.2020.10.05.10.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:45:19 -0700 (PDT)
Subject: Re: [PATCH 7/7] nvme-fcloop: use a device for lport
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200922121501.32851-1-hare@suse.de>
 <20200922121501.32851-8-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <18cf0738-2643-d59a-d634-aebc85eb6ba5@broadcom.com>
Date: Mon, 5 Oct 2020 10:45:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922121501.32851-8-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_134523_775625_63CC47C2 
X-CRM114-Status: GOOD (  22.51  )
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
Content-Type: multipart/mixed; boundary="===============3573482379092186216=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============3573482379092186216==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e1852905b0f00b42"

--000000000000e1852905b0f00b42
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

On 9/22/2020 5:15 AM, Hannes Reinecke wrote:
> Add a 'struct device' to the lport such that the lport will show
> up in sysfs and we get a valid name in the logging output.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 53 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index b84f8754b3a3..1af1917ddf4c 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -214,6 +214,7 @@ static LIST_HEAD(fcloop_nports);
>   static DEFINE_IDA(fcloop_portid_ida);
>   
>   struct fcloop_lport {
> +	struct device dev;
>   	struct nvme_fc_local_port *localport;
>   	struct list_head lport_list;
>   	struct completion unreg_done;
> @@ -1053,6 +1054,16 @@ static struct nvmet_fc_target_template tgttemplate = {
>   	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
>   };
>   
> +static void fcloop_release_lport(struct device *dev)
> +{
> +	struct fcloop_lport *lport =
> +		container_of(dev, struct fcloop_lport, dev);
> +
> +	ida_free(&fcloop_portid_ida, lport->port_id);
> +
> +	kfree(lport);
> +}
> +
>   static ssize_t
>   fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
>   		const char *buf, size_t count)
> @@ -1063,7 +1074,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
>   	struct fcloop_lport *lport;
>   	struct fcloop_lport_priv *lport_priv;
>   	unsigned long flags;
> -	int ret = -ENOMEM, port_id;
> +	int ret = -ENOMEM, port_id, port_num;
>   
>   	lport = kzalloc(sizeof(*lport), GFP_KERNEL);
>   	if (!lport)
> @@ -1094,25 +1105,39 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
>   		goto out_free_ida;
>   	}
>   
> +	lport->port_id = port_id;
> +	lport->dev.class = fcloop_class;
> +	lport->dev.release = fcloop_release_lport;
> +	dev_set_name(&lport->dev, "lport%d", lport->port_id);
> +	device_initialize(&lport->dev);
> +
>   	memset(&pinfo, 0, sizeof(pinfo));
>   	pinfo.node_name = opts->wwnn;
>   	pinfo.port_name = opts->wwpn;
>   	pinfo.port_role = opts->roles;
>   	pinfo.port_id = port_id;
>   
> -	ret = nvme_fc_register_localport(&pinfo, &fctemplate, NULL, &localport);
> -	if (!ret) {
> -		/* success */
> -		lport_priv = localport->private;
> -		lport_priv->lport = lport;
> +	ret = nvme_fc_register_localport(&pinfo, &fctemplate,
> +					 &lport->dev, &localport);
> +	if (ret)
> +		goto out_free_ida;
>   
> -		lport->localport = localport;
> -		INIT_LIST_HEAD(&lport->lport_list);
> +	/* success */
> +	lport_priv = localport->private;
> +	lport_priv->lport = lport;
>   
> -		spin_lock_irqsave(&fcloop_lock, flags);
> -		list_add_tail(&lport->lport_list, &fcloop_lports);
> -		spin_unlock_irqrestore(&fcloop_lock, flags);
> +	lport->localport = localport;
> +	INIT_LIST_HEAD(&lport->lport_list);
> +
> +	ret = device_add(&lport->dev);
> +	if (ret) {
> +		nvme_fc_unregister_localport(lport->localport);
> +		goto out_free_ida;
>   	}
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	list_add_tail(&lport->lport_list, &fcloop_lports);
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
>   out_free_ida:
>   	if (ret)
>   		ida_free(&fcloop_portid_ida, port_id);
> @@ -1138,15 +1163,15 @@ __wait_localport_unreg(struct fcloop_lport *lport)
>   {
>   	int ret;
>   
> +	device_del(&lport->dev);
> +
>   	init_completion(&lport->unreg_done);
>   
>   	ret = nvme_fc_unregister_localport(lport->localport);
>   
>   	wait_for_completion(&lport->unreg_done);
>   
> -	ida_free(&fcloop_portid_ida, lport->port_id);
> -
> -	kfree(lport);
> +	put_device(&lport->dev);
>   
>   	return ret;
>   }
ok.

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

--000000000000e1852905b0f00b42
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgdVTiMDt16JQnYGS2
qHomerrtoGSCQuo2Xgq1B4Vpzy4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDA1MTc0NTIxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFgiH2Bm038smuAN0MaQc+7wF+72fB9E3csO
GspMvRvKIQwiSpsb88avLljhMBhpt24QJq8mr1949LXAPWNOx8+JLE0nUnKw54NSnSF8o+33ytDp
GWCWVJm7YD2ZBZSfRAEl3Ww9aW35mx8srDd+xBfoyNirFc1MKQvNJRXQXGC9Afqmbfqu501eaojM
WNxtDx7lZgKIEn5uHHr8CIXP+vaOgp9+uAZcmR0d3UmX8NJRzN4zgKPUtyUf13e256qlwC8O+Fp8
8M7nFB7Q6l4cUevQr03rbcf6Lut8x2i7e4CglaP+RzCmi+0tX1MDC1R+MC/7nDYqK+JtYg/9oUBM
dmE=
--000000000000e1852905b0f00b42--


--===============3573482379092186216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============3573482379092186216==--

