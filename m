Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB69C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:41:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE8D207BC
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 17:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XiOJrkZL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h3QqqzXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE8D207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NfVTJHB85nkVc1ItydIis9lce67u7NsWlbkY/ijmZNk=; b=XiOJrkZLzc6Rwsk1rBRZTWMyq
	7l8jcj6xUOsLbc3hqJaJyuwQk42Ray3uWiqfQ/NqTj7r8HeUXQQuBUOwmP4BCVnRpVmbBtEgzO11Z
	bTN4tNCL36slgub7PYCDZ9LKtauCAuUDv/S6sqPyo0WpbZ4XRU3NJ80LBmv9/XCCKKdEP3LqFgko8
	VlDM1qGtBvbUjaZcheqp3hNfvS5VoGy9uBMPy9dfTKRCik7lHcqNDewuSzpaN55OFZg6jDjC/+oFk
	TzDKyPdk2ilUUQk5nh6iDiup7GHA3lTXJ8xIqRqndhVt1J+bUWZ2FbMJ24Z65RDqnyB/dy55O4F3v
	hBPL5VAtQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPUUG-0001Ii-3r; Mon, 05 Oct 2020 17:41:24 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPUUC-0001G1-70
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 17:41:21 +0000
Received: by mail-pf1-x444.google.com with SMTP id k8so7428558pfk.2
 for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2020 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=s/bmuVe0x58wS6520Bg5Mb2dA7nfwhf1HB/ibGMhx/A=;
 b=h3QqqzXKzOlyH6GEL/P3C6YW9ye5lcx7tV54sdeWD6qsx3SeoLyoFo1CcZis0l3A0Q
 mIh8DGyAHIoUacrEpfe/iCdtqrcQHXukaHF1zQT1ZpA77vCdQLA//lkgrCWOAzT/r1i1
 rMmDJytlIhOf57I32FWMCJCS9sUJxpdsN0dtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=s/bmuVe0x58wS6520Bg5Mb2dA7nfwhf1HB/ibGMhx/A=;
 b=OJzH3heXNonXuTouru28IbnFCpOYRqabrPwD19UE0n/Bp3r8qGjJHTtpgO9uZmatI1
 XmgbH8oOe5bViIzXLt5eItLYYT9zmwfTiXGbZMj5T5Mxox7zKINjr7FbOGH/Xq2rWYml
 6IoodCcIcZ4uMdqbxudgrLWaHkKuSriwrJawBGtjLT7AVnvT2NN/avZJgWe03+theJHv
 Rh6KIGgXU25+jdc2GR1pfjnslrd9nEEj9ONfn1EsbBXUlqZ9JpLehm1XlVcTA6oQLWIs
 YzDrNFbeGOcch1uj/+G+s8CEn94d1yru/NEN7kHnhyuC+DKGWccxEE3n0SDgqKlez1TL
 YrIQ==
X-Gm-Message-State: AOAM531IAqQjYzEy08Wq0PEHBJRVYkQIZe/n8nyhupAeTKPCIeOcIvRq
 51sagzOLubtOCdpv0Gb17ZO9yi+WnRKqxRRddyanMJbhAu1Cwlou4Bvc06pC5cQZmwiz84VrozM
 KmCessi08gfTXpGAijNromdWCeU5gny9E2dncVMX84MUrIiPvH2Zchc0yx/ZwRO30NCmpUHz8lk
 NsUIsKjk0m
X-Google-Smtp-Source: ABdhPJyc8AbRJPw+JHcP1VNv10jKGmjGQTFIj0uyT0PE5nrlZLVOIDoMYMobUQuQRIyJflnqB3zyRA==
X-Received: by 2002:a63:c18:: with SMTP id b24mr619492pgl.208.1601919677380;
 Mon, 05 Oct 2020 10:41:17 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id o20sm249289pgh.63.2020.10.05.10.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:41:16 -0700 (PDT)
Subject: Re: [PATCH 6/7] nvme-fcloop: use a device for nport
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200922121501.32851-1-hare@suse.de>
 <20200922121501.32851-7-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <4ca1d58e-0831-6596-020f-311932b3c439@broadcom.com>
Date: Mon, 5 Oct 2020 10:41:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922121501.32851-7-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_134120_262628_D27E3921 
X-CRM114-Status: GOOD (  23.01  )
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
Content-Type: multipart/mixed; boundary="===============0687690968303265787=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============0687690968303265787==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005b994e05b0effdbe"

--0000000000005b994e05b0effdbe
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

On 9/22/2020 5:15 AM, Hannes Reinecke wrote:
> Add a 'struct device' to the nport such that the nport will show
> up in sysfs and we get a valid name in the logging output.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 7dab98545979..b84f8754b3a3 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -245,11 +245,11 @@ struct fcloop_tport {
>   };
>   
>   struct fcloop_nport {
> +	struct device dev;
>   	struct fcloop_rport *rport;
>   	struct fcloop_tport *tport;
>   	struct fcloop_lport *lport;
>   	struct list_head nport_list;
> -	struct kref ref;
>   	u64 node_name;
>   	u64 port_name;
>   	u32 port_role;
> @@ -949,10 +949,10 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
>   }
>   
>   static void
> -fcloop_nport_free(struct kref *ref)
> +fcloop_release_nport(struct device *dev)
>   {
>   	struct fcloop_nport *nport =
> -		container_of(ref, struct fcloop_nport, ref);
> +		container_of(dev, struct fcloop_nport, dev);
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&fcloop_lock, flags);
> @@ -967,13 +967,13 @@ fcloop_nport_free(struct kref *ref)
>   static void
>   fcloop_nport_put(struct fcloop_nport *nport)
>   {
> -	kref_put(&nport->ref, fcloop_nport_free);
> +	put_device(&nport->dev);
>   }
>   
> -static int
> +static void
>   fcloop_nport_get(struct fcloop_nport *nport)
>   {
> -	return kref_get_unless_zero(&nport->ref);
> +	get_device(&nport->dev);
>   }
>   
>   static void
> @@ -1007,6 +1007,8 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   #define	FCLOOP_SGL_SEGS			256
>   #define FCLOOP_DMABOUND_4G		0xFFFFFFFF
>   
> +static struct class *fcloop_class;
> +
>   static struct nvme_fc_port_template fctemplate = {
>   	.localport_delete	= fcloop_localport_delete,
>   	.remoteport_delete	= fcloop_remoteport_delete,
> @@ -1225,8 +1227,10 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
>   	newnport->port_id = port_id;
>   	if (opts->mask & NVMF_OPT_ROLES)
>   		newnport->port_role = opts->roles;
> -
> -	kref_init(&newnport->ref);
> +	newnport->dev.class = fcloop_class;
> +	newnport->dev.release = fcloop_release_nport;
> +	dev_set_name(&newnport->dev, "nport%d", newnport->port_id);
> +	device_initialize(&newnport->dev);
>   
>   	spin_lock_irqsave(&fcloop_lock, flags);
>   
> @@ -1267,6 +1271,10 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
>   		}
>   	}
>   
> +	ret = device_add(&newnport->dev);
> +	if (ret)
> +		goto out_invalid_opts;
> +
>   	list_add_tail(&newnport->nport_list, &fcloop_nports);
>   
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
> @@ -1339,6 +1347,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   	if (rport && nport->tport)
>   		nport->tport->remoteport = NULL;
>   	nport->rport = NULL;
> +	if (!nport->tport)
> +		device_del(&nport->dev);
>   
>   	return rport;
>   }
> @@ -1406,7 +1416,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
>   	tinfo.port_name = nport->port_name;
>   	tinfo.port_id = nport->port_id;
>   
> -	ret = nvmet_fc_register_targetport(&tinfo, &tgttemplate, NULL,
> +	ret = nvmet_fc_register_targetport(&tinfo, &tgttemplate, &nport->dev,
>   						&targetport);
>   	if (ret) {
>   		fcloop_nport_put(nport);
> @@ -1438,6 +1448,8 @@ __unlink_target_port(struct fcloop_nport *nport)
>   	if (tport && nport->rport)
>   		nport->rport->targetport = NULL;
>   	nport->tport = NULL;
> +	if (!nport->rport)
> +		device_del(&nport->dev);
>   
>   	return tport;
>   }
> @@ -1513,7 +1525,6 @@ static const struct attribute_group *fcloop_dev_attr_groups[] = {
>   	NULL,
>   };
>   
> -static struct class *fcloop_class;
>   static struct device *fcloop_device;
>   
>   

ok.

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

--0000000000005b994e05b0effdbe
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQPwYJKoZIhvcNAQcCoIIQMDCCECwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2UMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFQTCCBCmgAwIBAgIMfmKtsn6cI8G7HjzCMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTE3MDU0
NjI0WhcNMjIwOTE4MDU0NjI0WjCBjDELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMRQwEgYDVQQDEwtKYW1l
cyBTbWFydDEnMCUGCSqGSIb3DQEJARYYamFtZXMuc21hcnRAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0B4Ym0dby5rc/1eyTwvNzsepN0S9eBGyF45ltfEmEmoe
sY3NAmThxJaLBzoPYjCpfPWh65cxrVIOw9R3a9TrkDN+aISE1NPyyHOabU57I8bKvfS8WMpCQKSJ
pDWUbzanP3MMP4C2qbJgQW+xh9UDzBi8u69f40kP+cLEPNJWbz0KxNNp7H/4zWNyTouJRtO6QKVh
XqR+mg0QW4TJlH5sJ7NIbVGZKzs0PEbUJJJw0zJsp3m0iS6AzNFtTGHWVO1me58DIYR/VDSiY9Sh
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgCaoKm0zYnkB4oE2r
kbWwd2dx6vKJSIstAwwZbfnc2sUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDA1MTc0MTE3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJe2aSXPy78fd9DEL7kcCFiMkaBc3uahTcZ1
wjwZoBgRf1H+IgneXg5Bp9CUpF7HJTyKipuXqMqCZbFSGEutzCPZ0qGltUY1yc0XiXxza8Bs4DDc
6E1lGNis3VENdXgk6MeZtg0K+k0NuseX1oaryRtNOwI2nhZzPR3W6YHCb9Ng29jQ+8Aomxbq3UHq
HVxAcKggtrrShlBP24sdisOViSM9hG3VRdpvQI11/e3dieuLp3lN8r9tLAde6PHLbH8S1FmNiOZO
kKF8spWg8hKJhhIBqKVEoQy7JCNYPf2u1841vFxgPqGO1z120Yjon0mtxf2g0Hi/8PgLpnSk1n86
tGM=
--0000000000005b994e05b0effdbe--


--===============0687690968303265787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0687690968303265787==--

