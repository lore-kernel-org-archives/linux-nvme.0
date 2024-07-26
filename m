Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D804C3DA49
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jul 2024 19:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulGvpE1bZKva/26pu2jVedVOPwSiHWu7H4QsGqKQwlc=; b=NEjVNc9B8HiDJfjZuEbo+carAH
	p8KJEJcDUtVljn8OYHCm0CR/VgtpKrKDgG4YIBVKJ7nYQG5U1qtoStFEbSABLTIR8U+eK0pYcTq7k
	MEduzoq2fvXfyxdewajcCzR6XZDfgwtrIhjlcv32+quei4a0PLoWDihERe0ZJuTsV2JGYIP9fkHxD
	B43Do6VMXqtk+QdqzeBmXV42cbeCBLKz3x82S19MMS0u+HAgQVSx51L3gBtVd79c9ZiO/7pD0yYP5
	KaOVFfJUQTjb65w6hgJaIQG1i360h0lSJtInFyknzx0LS2U14XH/bvB6BlG1+JTogd+Gm5z6jj4AN
	DGp+dXBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXR4J-00000004pui-0rsc;
	Fri, 26 Jul 2024 19:57:35 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXR4F-00000004ptu-2yYH
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jul 2024 19:57:33 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so53178276.2
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jul 2024 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722023850; x=1722628650; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ulGvpE1bZKva/26pu2jVedVOPwSiHWu7H4QsGqKQwlc=;
        b=VpeHD4VnrjLcBLaDRnKEN9ZV2eh/facbRofXJgysOMxR5UDxu8ihq+tMX1rxwSkaNG
         4Onbo8IE2HOJZS1IyFzcSI9KpQnYdhi4CRZby1L8wXx4Meb281o615iZNMZW/Vm6v/24
         nPLlejwhhHQEkgZmXhc/VVfGtyf7GbpGEYUlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023850; x=1722628650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulGvpE1bZKva/26pu2jVedVOPwSiHWu7H4QsGqKQwlc=;
        b=VFlraEClgAdeFWhnTB6mqYckqa/7X54/M7EMJh6u9/yjUBbqJhB0WkbGCgedYOgK6T
         YNKVLkQMxncrTB/sYqdqjjV07j/yCjpbIkiiq2D3hyyVB3GgB0cSxpEZHy2Ipbn211aQ
         rQTXoCxf/kkYbTFrG5rNEp+1ZxZLsifDk0OQP/i+7FpkmP9H/pTWyK26GEsxL1PCDLN7
         0yjMmIuit5IluQQwkHRTe+6Z5oV1xrKyTQEwSXq51jmGzCA7qBG/pc+Hk91C01FADFlx
         Y7ZuW7VpiQKEQeW3wGJ3bHDsAuY7/Ujgxy/SOaVSNobUVVHP6YYCExTQLrtZkgpcC28N
         V97g==
X-Forwarded-Encrypted: i=1; AJvYcCVKNxidQ2pzLUeA1Mqhrrw1qb+RgD+ziQiVQr9ReJCx+pf4fLbQ8Z9RO0so9t8uzbKrvi6nOuor4XQLRFWzZYvoCCpBU0ZamhmRzvw3Cg8=
X-Gm-Message-State: AOJu0Yyt9NEfzSeeiug+8TwqsDg2on2sHBlvCuy6vmOq4wWXKuP6hNk9
	C/TFXuwsiTD2RApWFcCq9Y8dwh1hQWar+3iPEKpepc8FO/t/2B7YjrJnyw7NHwGSOQzXa3xOlYW
	ecErhsidYVSrG1Z0I3TlDcc/NFH//aJpgUNAgVqb7Yq/PncrmDD2QHIztOjxpoQoj9iRYF7XKBj
	rMwmcq5ekTNPmySIt3UVJrTPqREoE9781CQehCjtvjeF6n
X-Google-Smtp-Source: AGHT+IE0wqpICbqF//5sSOY+P6uHVxWF1v9WeY40L1UeBgNI+a3NXYUbxp21Qm7jeSmQvGV5z9ZN1Gvuc8jsDLBWCjM=
X-Received: by 2002:a05:6902:90f:b0:e0b:4883:f7ab with SMTP id
 3f1490d57ef6-e0b54628a93mr843482276.47.1722023848373; Fri, 26 Jul 2024
 12:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240611190647.11856-1-dwagner@suse.de> <20240611190647.11856-3-dwagner@suse.de>
 <CABPRKS_rC3eXiDGTORhRVUpFLXZWPrmd8kRwVL8FdAvX3aVu-A@mail.gmail.com>
In-Reply-To: <CABPRKS_rC3eXiDGTORhRVUpFLXZWPrmd8kRwVL8FdAvX3aVu-A@mail.gmail.com>
From: Paul Ely <paul.ely@broadcom.com>
Date: Fri, 26 Jul 2024 15:57:17 -0400
Message-ID: <CAEQnVQmhMadZwEt8-cac3jpbSanXTxxvwOK+FOCJdDDvKwhQEg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] nvme-fc: fix race with connectivity loss with nvme_fc_create_association
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Hannes Reinecke <hare@suse.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ecc80f061e2beb62"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240726_125731_782125_3D176EC1 
X-CRM114-Status: GOOD (  34.97  )
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

--000000000000ecc80f061e2beb62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> From: Daniel Wagner <dwagner@suse.de>
> Date: Tue, Jun 11, 2024 at 12:15=E2=80=AFPM
> Subject: [PATCH v1 2/2] nvme-fc: fix race with connectivity loss with
> nvme_fc_create_association
> To: James Smart <james.smart@broadcom.com>
> Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
> Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
> Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
>
>
> We are racing with nvme_fc_create_association here. We wouldn't have to
> do anything in nvme_fc_ctrl_connectivity_loss IF
> nvme_fc_create_association would reliable detect that the setup failed.
> In reality, nvme_fc_create_association is able to return success even
> though some of the operation fail during the setup (and this is even on
> purpose):
>
>  nvme nvme10: NVME-FC{10}: create association : ...
>  nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconne=
ct
>  nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
>  nvme nvme10: Could not set queue count (880)
>  nvme nvme10: Failed to configure AEN (cfg 900)
>  nvme nvme10: NVME-FC{10}: controller connect complete
>
> Thus we transition to the CONNECTED state and don't start the reconnect
> loop. Thus we should unconditionally schedule a reset.
>
> If a reset has already been schedule it's either a no-op or we observe
> back to back reset. But we can't really distinguish between host side
> double scheduled reset work or a connectivity loss event right after a
> reset. Thus we have to live with this corner case. The system will enter
> the correct state eventually.
>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6ff28d59b169..10dc456928a2 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -169,6 +169,7 @@ struct nvme_fc_ctrl {
>
>         struct work_struct      ioerr_work;
>         struct delayed_work     connect_work;
> +       struct work_struct      fc_reset_work;
>
>         struct kref             ref;
>         unsigned long           flags;
> @@ -779,6 +780,14 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
>         return 0;
>  }
>
> +static void nvme_fc_defer_reset_work(struct work_struct *work)
> +{
> +       struct nvme_fc_ctrl *ctrl =3D
> +               container_of(work, struct nvme_fc_ctrl, fc_reset_work);
> +
> +       nvme_reset_ctrl(&ctrl->ctrl);
> +}
> +
>  static void
>  nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>  {
> @@ -806,12 +815,20 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl =
*ctrl)
>
>         case NVME_CTRL_CONNECTING:
>                 /*
> -                * The association has already been terminated and the
> -                * controller is attempting reconnects.  No need to do an=
ything
> -                * futher.  Reconnects will be attempted until either the
> +                * We are racing with nvme_fc_create_association here. En=
sure we
> +                * never lose the connectivity loss event and uncondition=
ally
> +                * schedule a reset.
> +                *
> +                * The reconnects will be attempted until either the
>                  * ctlr_loss_tmo (max_retries * connect_delay) expires or=
 the
>                  * remoteport's dev_loss_tmo expires.
> +                *
> +                * We can't sleep in this context (e.g flush_delayed_work=
) but
> +                * we should execute reset after the connect work item ha=
s
> +                * finished. Thus defer the reset trigger to the nvme_wq =
where
> +                * the connect is executed.
>                  */
> +               queue_work(nvme_wq, &ctrl->fc_reset_work);
>                 break;
>
>         case NVME_CTRL_RESETTING:
> @@ -3505,6 +3522,7 @@ nvme_fc_init_ctrl(struct device *dev, struct
> nvmf_ctrl_options *opts,
>         INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
>         INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work)=
;
>         INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
> +       INIT_WORK(&ctrl->fc_reset_work, nvme_fc_defer_reset_work);
>         spin_lock_init(&ctrl->lock);
>
>         /* io queue count */
> --
> 2.45.2
I tested this change with multiple NVME target vendors, multiple
subsystems and namespaces
and fault injection with IO running.  This test reproduced the
controllers stuck in "Connecting"
state 100% of the time and now run clean for the test duration.

Reviewed-by: Paul Ely <paul.ely@broadcom.com>

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

--000000000000ecc80f061e2beb62
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Gt9/zf/pyLFzN9x0teHeYGDE3BvutFNP73yZ4+gD3hvECPjhNOTckfW5UDb62CAoANfyK1rRrGgB
jcI2/qtL2ssd//Bdpl/amFr4E+mO5NDdAgMBAAGjggHWMIIB0jAOBgNVHQ8BAf8EBAMCBaAwgaMG
CCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6
Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARG
MEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xv
YmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCAGA1UdEQQZMBeBFXBh
dWwuZWx5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9Hm
WBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUJ1y3eGRqMhIJ29gUwfLNWR9UiMcwDQYJKoZIhvcN
AQELBQADggEBAHktydAxB4VxuU2v6Ib1nocnCcVTSWsNrkafgytWvuwDIDJ5feKnedobosi2uzZ4
fu4NmuOJ41mQZl9EvP37bpLAwNM2ly/NNhKkwC59KDM6rHHdR5lhhB2EWFkZZr7Iyl8TZqqhKrsc
E82lhzTfWc+3tNJhxOGFDbcIp1dZyqgQH4JUVIANCO2Lf9uLqWO3IVkfLr/V0r+LRphXqameciPN
o/onEVuRSDwwLwwMfTwH/dk8p8bY3AiBMEDyY8lgq6pIvk+6bGNMniFFJ8YBUrZVbcwXXZ+atBj7
PBB5NBKTmW70SM+it2U3l+8in5Iix8GwNACoo3sw5FBVgvpapgcxggJtMIICaQIBATBrMFsxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWdu
IEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwz2zf1m8MIJZQDXqcwDQYJYIZIAWUDBAIB
BQCggdQwLwYJKoZIhvcNAQkEMSIEIDlnXblScytC/XDOTVBgaKf6tALYmQQ5Rrx1F4XavPIgMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcyNjE5NTczMFowaQYJ
KoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQDF0v8W0xEBJw36Vzk/K7ynCEUl7dFPodZY5MDeRJwgtBV7I28kz7qxQkS0sRbMqo8I
YnjHLNH0r1U7v9gPNSE/4iwb+bma/XUOsXJ85LuBnVKkde+MXT33Fmz+AKPg3Ji1f1tOe4UGEGM7
16hLu0IVBDIgHBCICkeE4uMgGFmGsSCftSMl0kIRTzPZnelhIqd2k0chTNriFX185nY4zT7/iNSE
vMwBEnB3YkNYfMvjMiKxNI5xTCvwYkKHbb+yFTLKCX5xzPKCTPc8rKGZyMXps/0FCGn+Z2gN6VxI
D1pNwr6pdhDD7rV7dWDpGNUVWMmkohDfRAsFSthy4BuV8qQ0
--000000000000ecc80f061e2beb62--

