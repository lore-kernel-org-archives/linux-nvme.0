Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F4C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 00:36:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E499E22D74
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 00:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E499E22D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+iTMkOLQ7S54bnSKRp+biZPv/+ZWv741EsNcjZR8Rj0=; b=rv9w5BQHLU0y1qZTpHmeQ/yXW
	etbA1XJUqx9tNIFtO+fJLQS09dmbw2qnDLZ+tgvnrvlxGAsPyjONpErMplsZjW5bHMxi4tVq0LZ4W
	xqN4vNvqXQ7qX5o2eNmFbDx5OfPJxfB9nqhLV/HFbtvTIxIYG8SyMC1JlPpxlm43vJeZ4qscDf1Kf
	/88PJLnPIQkOqzPAnivsLsSROUw1O/BwuORDy7GAfG/TeqN6Lm2WF6pLKXNMNbfs2rN15CCROB0fG
	wC+0IGG8oNz6IwlQf66ZgcLwvEEh+Q55nDPBt/2xVMd6inGZ1BeZ3NwTNzj+f+HhYWwPzmQ+/8yDK
	Y7eOxIQnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwwnk-0005J5-12; Wed, 06 Jan 2021 00:35:48 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwwnf-0005IB-0Q
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 00:35:46 +0000
Received: by mail-pf1-x433.google.com with SMTP id s21so697999pfu.13
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 16:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=fqgNz4cEm6vfdSRkeZ5JqxZfeXSp4rYPlWvaKQosGYg=;
 b=Iz923uXKMjMMaw+2sme2XEvMGo8hkDUeCGIwGh2suNBC2vPy1Q3y6AqiRdGK4ILGGC
 NIhBcO5hZGRzop2+fMwG0cfl412V88la7MDi0Gf9UK+FOco9xDEwyMDFniQEjF+cTyfy
 lXgexwvw3qGhRWx0Vi4Q5WHuuHWBCZ/I0XdoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=fqgNz4cEm6vfdSRkeZ5JqxZfeXSp4rYPlWvaKQosGYg=;
 b=X0LPEzykaq64FydVO1O7tYUawCByim15ad1h92NK3hIont6mzJBeOcqL2SgaOS3oso
 iBFuAw4JGouyY4ujGEaojjFxqIjroJHLrNcWrE2ktMLMYv3WzYmsG4RfUl+Iu2plOvgp
 /t9EfUzfpMhIuAFNhK2D5lxOz7pB89WCfyKPBFCowNb7vW8GkuRRd4BvW9NvJt9IMNjC
 bIKiqN2HfycQEDfDKJRPhV5Qy8w9jCfmACMMoy52VUuxG5+wRdXhrk3P0MzPp+Q5xY2J
 WxMQTEZtKpMVhUMigEPS17OyUSX789XMiVl8yLfwF0SqEvb0HCmc8GhrZNItbo4GOAf2
 yyYw==
X-Gm-Message-State: AOAM530zYVF4kQ8yz5RHrbRtvQmroAEdGvYhMAY3nH3/apm4TPfvnYY6
 hcvNhLJToNRga4VG+PKuq/i72nq8glBajSM6lAmDkE9ZX6lDhRHeNtl2ifdeBpC63Yc89SAgHOS
 cE/xItxB8i3SzE4aFnQ==
X-Google-Smtp-Source: ABdhPJxwMSPNWLuRnUWOhFf1qhRuYFuX2wpjIX4AWDDhEBEDpJjUuAEOynuSgwmT534+oaY3Uto4Jg==
X-Received: by 2002:a05:6a00:13a3:b029:18b:d5d2:196 with SMTP id
 t35-20020a056a0013a3b029018bd5d20196mr1389723pfg.62.1609893340308; 
 Tue, 05 Jan 2021 16:35:40 -0800 (PST)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id k21sm461351pfu.77.2021.01.05.16.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Jan 2021 16:35:39 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme: support fused nvme requests
To: klayph@gmail.com, linux-nvme@lists.infradead.org
References: <20210105224939.1336-1-clay.mayers@kioxia.com>
 <20210105224939.1336-2-clay.mayers@kioxia.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <fb7227df-6250-1198-57c3-d57bdcb60a79@broadcom.com>
Date: Tue, 5 Jan 2021 16:35:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105224939.1336-2-clay.mayers@kioxia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_193544_936747_92E08691 
X-CRM114-Status: GOOD (  20.04  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: multipart/mixed; boundary="===============7735353418968851755=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============7735353418968851755==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b52fd605b8308036"

--000000000000b52fd605b8308036
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 1/5/2021 2:49 PM, klayph@gmail.com wrote:
> From

>  =20
>   /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3be352403839..c24729e100bc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -491,6 +491,30 @@ static inline void nvme_write_sq_db(struct nvme_queu=
e *nvmeq, bool write_sq)
>   	nvmeq->last_sq_tail =3D nvmeq->sq_tail;
>   }
>  =20
> +/**
> + * nvme_submit_cmd2() - Copy fused commands into a queue and ring the do=
orbell
> + * @nvmeq: The queue to use
> + * @cmd: The first command to send
> + * @cmd2: the second command to send
> + * @write_sq: whether to write to the SQ doorbell
> + */
> +static void nvme_submit_cmd2(struct nvme_queue *nvmeq, struct nvme_comma=
nd *cmd,
> +			     struct nvme_command *cmd2, bool write_sq)
> +{
> +	spin_lock(&nvmeq->sq_lock);
> +	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
> +		cmd, sizeof(*cmd));
> +	if (++nvmeq->sq_tail =3D=3D nvmeq->q_depth)
> +		nvmeq->sq_tail =3D 0;
> +	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
> +		cmd2, sizeof(*cmd2));
> +	if (++nvmeq->sq_tail =3D=3D nvmeq->q_depth)
> +		nvmeq->sq_tail =3D 0;
> +	nvme_write_sq_db(nvmeq, write_sq);
> +	spin_unlock(&nvmeq->sq_lock);
> +}
> +
> +
>   /**
>    * nvme_submit_cmd() - Copy a command into a queue and ring the doorbel=
l
>    * @nvmeq: The queue to use
> @@ -918,7 +942,13 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_c=
tx *hctx,
>   	}
>  =20
>   	blk_mq_start_request(req);
> -	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
> +
> +	if (cmnd.common.flags & NVME_CMD_FUSE_FIRST)
> +		memcpy(&nvme_req(req)->nrq2->cmnd, &cmnd, sizeof(cmnd));
> +	else if (cmnd.common.flags & NVME_CMD_FUSE_SECOND)
> +		nvme_submit_cmd2(nvmeq, &nvme_req(req)->cmnd, &cmnd, bd->last);
> +	else
> +		nvme_submit_cmd(nvmeq, &cmnd, bd->last);
>   	return BLK_STS_OK;
>   out_unmap_data:
>   	nvme_unmap_data(dev, req);

I think Keith caught the most concerning issue. I've been thinking of=20
others but they mostly seem to work.=C2=A0 I assume recopies of the first=
=20
fused cmd to the data structure don't hurt.=C2=A0 I would expect there to b=
e=20
a couple of other odd issues if the two requests start working=20
independently.

This is the pci transport only. You should either put something in to=20
not allow the ioctl on a non-pci transport, or add the support (or=20
rejection) to the fabric transports as well.

-- james




--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000b52fd605b8308036
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgYGmlla0whqJi2hTF
0xwDRTme/zm4s5bxLkBCh0qhiYkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjEwMTA2MDAzNTQwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKuAK1gFrb16n0F16dTR9XeyXSE2oXom/kw0
g122zVbUgigxvAnInlEKc06Sy6rHgp7TZ1g8U8SupjMZZzynPcbdrXiZAZE2euhOkkHJGAYZQHpX
5W0L5fQgVyqzEheIeT2eV4WYjwBUbw3jT5zsxRedvuHL6vHwTTrDC9LcnhG3GvCzBCROOIYyh0co
9l0URJYi/6DA8dLK2EZvpbw6kz//8o4CSx+kkznc4XvgIVOg5kN94tBtZekOKnYWQBTHW9KS+V3X
ohk2nIO3CuMs8CKqMJVVBV3O3RukJ5xgg/29165hF9i8mzwkLJzTXvm5mWTNJBeKj0PHGIXFsH2V
47M=
--000000000000b52fd605b8308036--


--===============7735353418968851755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7735353418968851755==--

