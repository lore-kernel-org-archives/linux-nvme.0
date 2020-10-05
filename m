Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6437C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:33:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABBF207EA
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zUdLZtAm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hkdPSivl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABBF207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PdHofI/XHGgyCjv6jDbBcDpWcgOohF3fSH00/ZXeB7U=; b=zUdLZtAm92Dgt+Z5X1cAbtOe8
	WYVHDbSvogA2gIU9ouZxXip6I85A40NHw3U+PhNYO2YcEr8JWdLVdbdHCpIXBIa2fz8WNqg6XoEUq
	vKxW8h4l6y981qiVgYoiXhvU+5AnmethTR1wPlMmTpupGHa9XKzx2CJhPRqGOlrIgOBEmf5+tZ7/8
	B9ejQV+9pMXv7NJThnjW9O2ZG8Ez4FAQ4GSdRVb4AIdSLMFEf5ijLQZ8gzmZWN6X0OLbzJGn+M2Uo
	SiHP36ah56gmwUfewdEk84VyagiNGtRNPjfQl0QB1m3xthQv24KzZGmQZLuaRnLWXd5QkeN7keelB
	1RE/atl0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPUMe-00076b-GD; Mon, 05 Oct 2020 17:33:32 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPUMa-000762-Ej
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 17:33:30 +0000
Received: by mail-pj1-x1044.google.com with SMTP id i3so197059pjz.4
 for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2020 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=BMrgGezckis9j+jg4arIC7zpEuIE4+5mPC46vzWZ5Gg=;
 b=hkdPSivltA/TnPGhe+ct4flzKMxmwLljYOeydfH6j4pocfP5MpvEfDNq46IpuIyGp/
 Z94Vp6tS2prB+isA+6LDcmQ2KzvDs1WYC0zG+nuemBFy/kx4Nw0v/d6NZoLNb3gb5zBH
 Lla6SSmo4fAI2ZX3P6FXhG2uAYbDw9R5mZm6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=BMrgGezckis9j+jg4arIC7zpEuIE4+5mPC46vzWZ5Gg=;
 b=FHPTHj4u9xLH1qRkSbyF4kbG+cY2whN8g6Qc/CDxrxeAjidu+8w/75Tyi6dPEmA0z0
 3xLeft+hsWRUcS66hJfQbA6tL/abbGmsgWGewKZjHOI4Xkyhj9E2hvaoOMO6cGcfHAsm
 1df3vvZuHM5EzE3jeGs+Kw3XA9Nkmz1kbAZCMI5mzawEJvidUtAOvl0hxee3RPFjM4O2
 8QJXRuQ0200lQAAIGvKo8O0P8GYEq6GPLgXfzNCL67tUY/KkBreujap6p1+x6M1q/O4p
 XFvwMc94xwPXUsT4vgFlhlfoZN3f7fOk+mDbAv9AJdTlqgDJXflii36gHTrUYXGiurdn
 PryQ==
X-Gm-Message-State: AOAM530YM9b2C1M+eWx4dOKIF/6hDyVTQJtIMIgpnL4lxko5BrAuXqry
 oq9zB+uaZN8e7Yo67pcuUXZ9cddWEJsUGGCcgt+TSFKsQQ0U5puDEQj0PKPj8Mmvs98/4VL6ZuH
 SgtY8XiAUwR0bwPQ3a16/iS3WNTApz//vnKGRbi8NLo2KC97u9krbq92GY7kDr7leq2F37nX/yl
 Io7HIYAzEf
X-Google-Smtp-Source: ABdhPJy//w2skB/9jH8SpjJzWj6WMysqKb+wqhs8rBfPNpQtinUCvunuahuHzoFVyZ7rMkfDpa+oCQ==
X-Received: by 2002:a17:90a:17ad:: with SMTP id
 q42mr538453pja.36.1601919205416; 
 Mon, 05 Oct 2020 10:33:25 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id z4sm505605pfr.197.2020.10.05.10.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:33:24 -0700 (PDT)
Subject: Re: [PATCH 3/7] nvme-fcloop: use IDA for port ids
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200922121501.32851-1-hare@suse.de>
 <20200922121501.32851-4-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <d0a614ff-c8b5-22fd-07f9-712a0259d760@broadcom.com>
Date: Mon, 5 Oct 2020 10:33:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922121501.32851-4-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_133328_693918_FA1B7567 
X-CRM114-Status: GOOD (  22.13  )
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
Content-Type: multipart/mixed; boundary="===============6300374916965969519=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============6300374916965969519==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003d304b05b0efe18c"

--0000000000003d304b05b0efe18c
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US

On 9/22/2020 5:14 AM, Hannes Reinecke wrote:
> Use an IDA to register port IDs to avoid duplicate port IDs. It
> also will generate a unique port ID if none is specified.

I'd prefer a little more description as I didn't pick up what this 
actually did from the comment.  Meaning: Add auto-address assignment if 
one isn't specified. Use an ida for allocation for uniqueness. Use 
user-supplied addresses as long as not in use and within range supported 
for ida.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 51 +++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 082aa4dee406..e56f323fa7d4 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -12,6 +12,7 @@
>   #include <linux/nvme-fc-driver.h>
>   #include <linux/nvme-fc.h>
>   
> +#define FCLOOP_MAX_AL_PA 0xEF

This is odd - no reason to bring in ALPA's and arb loop.   Please rename 
it to state it's the max address value allowed.  I'd prefer if this was 
a 24 bit value, but that won't matter much and 255 is fine.

>   
>   enum {
>   	NVMF_OPT_ERR		= 0,
> @@ -63,6 +64,9 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
>   	int token, ret = 0;
>   	u64 token64;
>   
> +	/* Default setting */
> +	opts->fcaddr = 1;
> +
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
>   		return -ENOMEM;
> @@ -102,6 +106,10 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
>   				ret = -EINVAL;
>   				goto out_free_options;
>   			}
> +			if (!token || token > FCLOOP_MAX_AL_PA) {
> +				ret = -EINVAL;
> +				goto out_free_options;
> +			}
>   			opts->fcaddr = token;
>   			break;
>   		case NVMF_OPT_LPWWNN:
> @@ -203,11 +211,13 @@ fcloop_parse_nm_options(struct device *dev, u64 *nname, u64 *pname,
>   static DEFINE_SPINLOCK(fcloop_lock);
>   static LIST_HEAD(fcloop_lports);
>   static LIST_HEAD(fcloop_nports);
> +static DEFINE_IDA(fcloop_portid_ida);
>   
>   struct fcloop_lport {
>   	struct nvme_fc_local_port *localport;
>   	struct list_head lport_list;
>   	struct completion unreg_done;
> +	u32 port_id;
>   };
>   
>   struct fcloop_lport_priv {
> @@ -949,6 +959,8 @@ fcloop_nport_free(struct kref *ref)
>   	list_del(&nport->nport_list);
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> +	ida_free(&fcloop_portid_ida, nport->port_id);
> +
>   	kfree(nport);
>   }
>   
> @@ -1047,7 +1059,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
>   	struct fcloop_lport *lport;
>   	struct fcloop_lport_priv *lport_priv;
>   	unsigned long flags;
> -	int ret = -ENOMEM;
> +	int ret = -ENOMEM, port_id;
>   
>   	lport = kzalloc(sizeof(*lport), GFP_KERNEL);
>   	if (!lport)
> @@ -1067,11 +1079,22 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
>   		goto out_free_opts;
>   	}
>   
> +	port_id = ida_alloc_range(&fcloop_portid_ida,
> +				  opts->fcaddr, FCLOOP_MAX_AL_PA, GFP_KERNEL);
> +	if (port_id < 0) {
> +		ret = port_id;
> +		goto out_free_opts;
> +	}
> +	if ((opts->mask & NVMF_OPT_FCADDR) && opts->fcaddr != port_id) {
> +		ret = -EINVAL;
> +		goto out_free_ida;
> +	}
> +
>   	memset(&pinfo, 0, sizeof(pinfo));
>   	pinfo.node_name = opts->wwnn;
>   	pinfo.port_name = opts->wwpn;
>   	pinfo.port_role = opts->roles;
> -	pinfo.port_id = opts->fcaddr;
> +	pinfo.port_id = port_id;
>   
>   	ret = nvme_fc_register_localport(&pinfo, &fctemplate, NULL, &localport);
>   	if (!ret) {
> @@ -1086,7 +1109,9 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
>   		list_add_tail(&lport->lport_list, &fcloop_lports);
>   		spin_unlock_irqrestore(&fcloop_lock, flags);
>   	}
> -
> +out_free_ida:
> +	if (ret)
> +		ida_free(&fcloop_portid_ida, port_id);
>   out_free_opts:
>   	kfree(opts);
>   out_free_lport:
> @@ -1115,6 +1140,8 @@ __wait_localport_unreg(struct fcloop_lport *lport)
>   
>   	wait_for_completion(&lport->unreg_done);
>   
> +	ida_free(&fcloop_portid_ida, lport->port_id);
> +
>   	kfree(lport);
>   
>   	return ret;
> @@ -1162,7 +1189,7 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
>   	struct fcloop_ctrl_options *opts;
>   	unsigned long flags;
>   	u32 opts_mask = (remoteport) ? RPORT_OPTS : TGTPORT_OPTS;
> -	int ret;
> +	int ret, port_id;
>   
>   	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
>   	if (!opts)
> @@ -1182,13 +1209,21 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
>   	if (!newnport)
>   		goto out_free_opts;
>   
> +	port_id = ida_alloc_range(&fcloop_portid_ida,
> +				  opts->fcaddr, FCLOOP_MAX_AL_PA, GFP_KERNEL);
> +	if (port_id < 0)
> +		goto out_free_newnport;
> +
> +	if ((opts->mask & NVMF_OPT_FCADDR) && opts->fcaddr != port_id)
> +		goto out_free_ida;
> +
>   	INIT_LIST_HEAD(&newnport->nport_list);
>   	newnport->node_name = opts->wwnn;
>   	newnport->port_name = opts->wwpn;
> +	newnport->port_id = port_id;
>   	if (opts->mask & NVMF_OPT_ROLES)
>   		newnport->port_role = opts->roles;
> -	if (opts->mask & NVMF_OPT_FCADDR)
> -		newnport->port_id = opts->fcaddr;
> +
>   	kref_init(&newnport->ref);
>   
>   	spin_lock_irqsave(&fcloop_lock, flags);
> @@ -1226,8 +1261,6 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
>   				nport->lport = lport;
>   			if (opts->mask & NVMF_OPT_ROLES)
>   				nport->port_role = opts->roles;
> -			if (opts->mask & NVMF_OPT_FCADDR)
> -				nport->port_id = opts->fcaddr;
>   			goto out_free_newnport;
>   		}
>   	}
> @@ -1241,6 +1274,8 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
>   
>   out_invalid_opts:
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
> +out_free_ida:
> +	ida_free(&fcloop_portid_ida, port_id);
>   out_free_newnport:
>   	kfree(newnport);
>   out_free_opts:

These are minor nits - I'm good with the patch

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

--0000000000003d304b05b0efe18c
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgWaYtVF6lKmmLVEp8
uLkcQO7u4huyRLzKOASZ6ZQQW8EwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDA1MTczMzI2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAuMdKXutRCxxETZ58MDKYUFT1Ok6r5Yw7bi
zAyNg3z8wioeC7xLU4toTFkjppt8NRY2raocpatxxkHCvuZg6V1S7wtUt3PYKXCiWc3s1aWeysWl
bg6Q9jR1SfvBCmut1rgvgFhYPWGPp3sP6c5Vq3PqZ9219pj238JQn2WVvdBg2z2cerpmx7oxd75q
eLFE+ANp2Aj/FwAQiDIrwV4dhnzHXdkMxsqmK2FXFWMH7Qd72atPqB4i5Kp1NIRb3ABUvwy5Vdbv
CHgqqo0XdvEESQ7/NDz33grM/g17u3JQRZiS1yjZYqj+/h/A25P6kC6UewkMhnjARqg4I3sZsADL
8Ys=
--0000000000003d304b05b0efe18c--


--===============6300374916965969519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============6300374916965969519==--

