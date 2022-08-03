Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754FCC19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 04:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:In-Reply-To:References:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0GCMF8iPinSdO3cVjLSBkAkGsWiwQhjl1OUsKZkEIXk=; b=QyaDnPl9+WT0bRDpBJqGTxeaRB
	Ia0L8GsOd0H7pbQ5B2wknqMmWAk7Qbm2K8nwnJo1+fWPfyWEkyuP6VurUlyS2DsBaXAEhiG57q1Zz
	8iF6ey+FnXNYxwAGzNXFZuZDpt29FVZtarOT5sbofKKzBUnVEP9utOOqE/PHpxTxXlxWqIWCiwesK
	IGXlQbpSB916K0EdMdkhujo5wbuVorz7YP+APtZ2atvpCYKOzScGjANMya2V0pFnP3ggzm00WbF1i
	rB5kzIP0jy1nOBs6CX1A+SdX8V8k1ISr+VRrd53cIBNulkcQh+ovM2hbCOVcWwyyhYdNoEbw/4tUR
	1coPcKMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJ69u-002NsJ-Kt; Wed, 03 Aug 2022 04:39:02 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJ69q-002NpD-4b
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 04:38:59 +0000
Received: by mail-ed1-x52e.google.com with SMTP id z22so20008216edd.6
        for <linux-nvme@lists.infradead.org>; Tue, 02 Aug 2022 21:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=0GCMF8iPinSdO3cVjLSBkAkGsWiwQhjl1OUsKZkEIXk=;
        b=REaXUfBhLLFzVZbge7BMliHuM/8KVSzkd53bfn3eKDMSM8vzWWrqq+otyj9ibU+1hi
         qZpe6iXLMVaeiYf7bgBtl/Lx/XdMpFnvdLs8KmcJW3AgsGWBcs2yoWQU84idm06NPAoK
         eG9+JLg6aIVokOvTI5vAjA6x5MtjUYQ19mj2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=0GCMF8iPinSdO3cVjLSBkAkGsWiwQhjl1OUsKZkEIXk=;
        b=JalWwGuPq21y6oi81UEk0UL2mhXe2lThKudDntfvKtWQ8m9ZtXYL/pi/yuvcrW677v
         EgXYCcwa11UMHeQhaIgS/fKMtczgnUvnj5NMqMkIM6hQLr7rXreAXVIBruulj5V4lyVv
         u1widb3I0RpzOvqZ0qBd5+9j6Rw7HOakIowylHp5IDcVFekW4CBf4p6ullLg1MlNSk+g
         S5thoUn4AdVXXxMOQIrJG3IPCqtPT/JvMruigfeP1SnzP4uzW4oJH4YGAoZ7zT9lIWJV
         9BpEmGBS97hoaolC1ZxnQuWwsI6uD8dWcOzpZW5c9PnMXuznEPT0DBHKjaFET4q2F10b
         cK/A==
X-Gm-Message-State: ACgBeo38QRRpUzFOZB9GHEmDXmM09nf+NYceBmfRDx+twWXHQoYfNKkg
	nkp8fFBVeQsMKUO9dnJF4/lpAQ0a7864KJB7MZZXdyyhQBOn54MMXY91SjGGtzflk/rE9zhv4qH
	Q5LMpuYJLyYpowERNIqkC4LDrV/q6c6+oiw==
X-Google-Smtp-Source: AA6agR6c6Zp9CxwEtVP/1Fs7Q1nLs0Ta3/Cvzw2srNjiFh73fMovFGRX+FIg1crmwhQTJTWxbNTH86SEtcXn62eXlQc=
X-Received: by 2002:a05:6402:3482:b0:43e:dd2:52a3 with SMTP id
 v2-20020a056402348200b0043e0dd252a3mr4722636edc.386.1659501534293; Tue, 02
 Aug 2022 21:38:54 -0700 (PDT)
From: Muneendra Kumar M <muneendra.kumar@broadcom.com>
References: <20220801162713.17324-1-emilne@redhat.com> <20220801182714.GA17613@lst.de>
 <0b5001ed-050f-f5d0-72ee-3cc2ffc7f9b8@gmail.com>
In-Reply-To: <0b5001ed-050f-f5d0-72ee-3cc2ffc7f9b8@gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKTGqs69RcEgjtZquImtL2TObdjXwMZ4NEjAxYvvMir9i9VwA==
Date: Wed, 3 Aug 2022 10:08:48 +0530
Message-ID: <6c03a873a639253c8af685b0e4849fb5@mail.gmail.com>
Subject: RE: [PATCH] Revert "nvme-fc: fold t fc_update_appid into fc_appid_store"
To: James Smart <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	"Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>, 
	stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000077c51905e54ecf64"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_213858_297888_26B675F6 
X-CRM114-Status: GOOD (  27.47  )
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

--00000000000077c51905e54ecf64
Content-Type: text/plain; charset="UTF-8"

I have tested the below changes suggested by Christoph and it is working as
expected.


Tested-by: <muneendra.kumar@broadcom.com>



-----Original Message-----
From: James Smart [mailto:jsmart2021@gmail.com]
Sent: Tuesday, August 2, 2022 2:33 AM
To: Christoph Hellwig <hch@lst.de>; Ewan D. Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org; muneendra.kumar@broadcom.com;
james.smart@broadcom.com; stable@vger.kernel.org
Subject: Re: [PATCH] Revert "nvme-fc: fold t fc_update_appid into
fc_appid_store"

On 8/1/2022 11:27 AM, Christoph Hellwig wrote:
> On Mon, Aug 01, 2022 at 12:27:13PM -0400, Ewan D. Milne wrote:
>> This reverts commit c814153c83a892dfd42026eaa661ae2c1f298792.
>>
>> The commit c814153c83a8 "nvme-fc: fold t fc_update_appid into
>> fc_appid_store"
>> changed the userspace interface, because the code that decrements "count"
>> to remove a trailing '\n' in the parsing results in the decremented
>> value being incorrectly be returned from the sysfs write.  Fix this by
>> revering the commit.
>
> Wouldn't something like the patch below be much simpler and cleaner:
>
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c index
> 9987797620b6d..e24ab688f00d5 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3878,6 +3878,7 @@ static int fc_parse_cgrpid(const char *buf, u64 *id)
>   static ssize_t fc_appid_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> +	size_t orig_count = count;
>   	u64 cgrp_id;
>   	int appid_len = 0;
>   	int cgrpid_len = 0;
> @@ -3902,7 +3903,7 @@ static ssize_t fc_appid_store(struct device *dev,
>   	ret = blkcg_set_fc_appid(app_id, cgrp_id, sizeof(app_id));
>   	if (ret < 0)
>   		return ret;
> -	return count;
> +	return orig_count;
>   }
>   static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
>   #endif /* CONFIG_BLK_CGROUP_FC_APPID */
>

Reviewed-by: James Smart <jsmart2021@gmail.com>

looks good on my end.

-- james

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--00000000000077c51905e54ecf64
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6dyIRB5g0cWmkcO89O0W56d+wWwa7GeeTIJHMzJ0rco8nzcXkz/oeEmXSjZU3erpKBaLCQBkZud1
iNM/8mFL1vZxCwUACcMw+a8FhrHJq29QwrBHqDJ1ocrJlDaZcn1UDQIDAQABo4IB3TCCAdkwDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsG
AQUFBwMEMB8GA1UdIwQYMBaAFJYz0eZYF1s0dYqBVmTVvkjeoY/PMB0GA1UdDgQWBBTMJfPJzmVP
1lwJptwb21ozx4G7wzANBgkqhkiG9w0BAQsFAAOCAQEAmz4/3oyLhfXMYVZWtDEKcP5Bk/6JAhfa
9q4eZDy1W/1FSuRfEWMq7xi9T3DvxUQqJtpJ8bM6SU37fZAvvMdRF23qdKRy6gBZ9NkYOCP7Tr2u
wNYznMfaHEGY/aa65EiywAsbVn1X7vKMKqSj3cmpEUO2I+FcRtPdyicqyU2E3856b5d+fMc01FRg
pQQRz3kWlIpG/CJ2SiOg0gpkZIkUde0r4e6ipDi+xVSoBdOOJzirs8IkwOeJ4w9GPS9uOkB1bRvJ
RU+Nz1h4p9eH2nsPAq7S5l6y/n3+g/olazbUoiEx8GRFqzoHLudsqmnzISDPoe+rczkpYreF/mEU
Y6pL2DGCAm0wggJpAgEBMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAyIENBIDIwMjACDHE+
9dgalq0zfRWBQDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgRIzOgVlhBHGkgYs6
7RQObVoxGd4tnnMrmk+cdgFGwXUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjIwODAzMDQzODU0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAI4wOVjhU5MapD38Yd8gpJAFzxXwKrwWr7O/
4zBmeaTWatmSDAEnBQXexKnwMHIC0EGVF/FpMiZTRwVKWTBf4Uh8510GOenDotba2DQ45Nrq8NBi
RGMapR4SYCw3AkaEOp7aweUZHFnyZju4PlXaJ0coJXT+6EYsMSM0G7YlTzvm8tIScUaocFdq7HtI
mkAwmeguUV/Oqgs4Amr0ZDYwpb4qPQDA3gBSbnYtKRNyslQ45lbPNDqmTtxgTCwtNmhDeRY8US0u
VVEuRnCsNNNfya+WQWxWrdbmCZYQzd8IhxRT6S/aZ5JBlNOWvW+1NP2YBBIqEyl5+DmtYVAhBJoI
HDg=
--00000000000077c51905e54ecf64--

