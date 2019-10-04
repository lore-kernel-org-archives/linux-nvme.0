Return-Path: <SRS0=SS5y=X5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EEEC4360C
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2019 18:28:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60392084D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2019 18:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Va2Kq5L3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SIv5Zdyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60392084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:
	Subject:Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SGtcq3TO87mBo3gPKPlUr6jH8fO0NDUGuvpIVbADNZQ=; b=Va2Kq5L37ONPTdtT6mGe1Y/lYS
	puBYOKurgDVFdSpH/t5VBX0XEensQ/YicK35/NQcTr5nHW9YXDd5OHQaXipKKz7cV/9xqqYJDamES
	w/UKs9h83uQHq6x/nGwiqcqD0x2nI+cHN6JyET15Fwd54JuEwpACHXy0XpWYzcfCcKsoHOnjgwed9
	P5Cbj2afKwXYx/4wTKfrPSrYrWDXgihl5QyZGUxmeALvMTYqvo8NU1mCIZqXhAdJMJXA+sbtstKKj
	hmwS6kyGkNDnkpvuWG8UXC86vdEp0X9swYPcQ8gcvo6zJmb5zyioPUYJ2uZe5AJLTSWUyczxtS5Rt
	DDgGvzOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGSJ9-0001gc-DK; Fri, 04 Oct 2019 18:28:03 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGSJ7-0001gI-8A
 for linux-nvme@lists.infradead.org; Fri, 04 Oct 2019 18:28:02 +0000
Received: by mail-qt1-x834.google.com with SMTP id o12so9869956qtf.3
 for <linux-nvme@lists.infradead.org>; Fri, 04 Oct 2019 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=pLqg6FbeATgkNC4jqwZbCTQMRoEGR8TpFufYKkHgI3A=;
 b=SIv5ZdyoI4S1IISMrUCree6mbGMdUxbQfy0mr+437NGoAxNNmfaUsNpkJriTUX6Tw8
 EPPUmDzGuoJOIWF9eYhnatuwDvK05r7oaBk3DWXEeJyB9pJq/LbWzt553IYj4tVv9ULE
 GENjqOWE8OyzIhnN+V7oWiI/UWyGWiriMDrfdQ7Ua8HeSZgOqACwSNcwztky31yVEuFa
 akDT0BosekYROKq9vd0CaQzeJXTDXmh9uqlEfMJ8drrd+v1z2HWdI0Oym0g94jcAttgp
 9AP4mmfMF89LQuA3+c9sryB6bZ46glK4KNhVThXWCGsE5u98EjZYcu4bdoWcqWfsxLjj
 3ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=pLqg6FbeATgkNC4jqwZbCTQMRoEGR8TpFufYKkHgI3A=;
 b=PmSU+ES65l97qQG8Zmiu1v+Jnzgsoq/qIKCl044loD3ExtVWwsLUFEryzJiMAhw9A9
 nyUWYtZuptUuz7VFO3vJ5QZrOVAVRZPPVErbO7NRNAc9vOd1tYzZuMCDmS/LSxg8RFJv
 8dCl6HLH0wsRMDCFKh7KmYnjK2SwE58fyVmHh8MvxmG5GfIFvcoMeotgjsMUNwic0oT/
 ZyUYH3+M1Fpfz8arBni6Kibi8U6knf8MaDATh832xqEE0P9lPsOfYJMV6R/9WQBEWGIP
 lUVQg5rSJxQ+k8bRZm7uEOl1iHjhUAI1KV9YW4zQDPD+XhwayhfrXvhD21EgXKebIpnh
 3/ZQ==
X-Gm-Message-State: APjAAAWq5k2ZgdfilMrGuOGGY8I/iQOnkmGHpJ9YEK3tvGC5S/B91vId
 M6ouT/UyBQMTow/7F5WBBFPJwLfJDvyHicmOz3l4hw==
X-Google-Smtp-Source: APXvYqwdrWd3BEkuqMwlSIge8KZV2chXBB2+vNSOGYGdqUQ5w6mO9gVt+aK7BhR9MH+aNF0uYrgJa6y00Jx8EJ3e94w=
X-Received: by 2002:ac8:e8d:: with SMTP id v13mr16413363qti.96.1570213676916; 
 Fri, 04 Oct 2019 11:27:56 -0700 (PDT)
MIME-Version: 1.0
From: Vaibhav Nagarnaik <vnagarnaik@google.com>
Date: Fri, 4 Oct 2019 11:27:30 -0700
Message-ID: <CAL26m8+WdjrKvnXDZdP4d2ekznfORDUV2Td6U6-DY9gcOqoOUA@mail.gmail.com>
Subject: NVMe PCI driver ignores SQHD from completion entries
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191004_112801_315978_D73AEEAC 
X-CRM114-Status: UNSURE (   7.16  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-nvme@lists.infradead.org, Bart Van Assche <bvanassche@google.com>,
 Eric Gouriou <egouriou@google.com>, Abbas Companywala <acompany@google.com>,
 "Mihai R." <dizzy@google.com>
Content-Type: multipart/mixed; boundary="===============6542663813996026570=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============6542663813996026570==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000077e3d4059419dc87"

--00000000000077e3d4059419dc87
Content-Type: text/plain; charset="UTF-8"

Hello

According to NVMe spec:
A Submission Queue entry has been consumed by the controller when a
Completion Queue entry is posted that indicates that the Submission
Queue Head Pointer has moved past the slot in which that Submission
Queue entry was placed.

Which means, the driver needs to verify SQ Head Pointer value reported
in the completion entries before considering a particular SQ entry
reusable. Otherwise it's undefined behavior.

However, the NVMe PCI driver (up to and including v5.3.2) does not
respect this value. Abbas (cc'd here) verified that entries that are
pending on the controller will be overwritten by the driver if there
are enough block requests.

Practically speaking, this is probably not an issue for most
controllers since they would start processing the NVMe command as soon
as possible. And then never look at the entry again.

Is this considered spec violation? And if so, is it worth providing a
fix for it?

Keeping in mind, that a particularly long running NVMe command will
not allow some controllers to move SQ Head value. Even though the
subsequent NVMe commands have received completions earlier. This will
cause new block requests from being submitted until the long running
command is completed.


Vaibhav

--00000000000077e3d4059419dc87
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7wYJKoZIhvcNAQcCoIIS4DCCEtwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBVMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
QjBABggrBgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNt
aW1lY2ExLmNydDAdBgNVHQ4EFgQUcbWyKlL407TAYL2PNNx1IyjvzB0wHwYDVR0jBBgwFoAUyzgS
sMeZwHiSjLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYq
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIF
oDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBABdjPeHo
1ZnH4fC9VfDrkn1MS0FrGNG1yuIZ8TiJGP12TMruuGIfl+cosFzurxkMEcyc5jO8qS7aDMOTmwM/
R8y4Ee/wQXPm8nMUb+ll2M9Ox5eSVp4ZwbghMV8NLT92ECXTIkmq4MNu4Fl1hfHCLchcLuiP2Cdx
oYGwv1SiAM8xm5N1pofvM19Xl3c0OUtY5Z+dQsHXWLKTZzWGV/pVUcaT/HQvXvN0bBKH6vZa3feO
6zzNXU23v54+PIS9QsB84EWaFV0FG2l1tq4uXCMIzivcgjhjo1/EZLrre1l0nXS0a4IQET4suojm
+RRGgzBkIexsGGeHGlN9SRH2B65/QHExggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAx
AgwjSKzmYcXpdXyI2KswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMYgtnqYJ32j
x9VaQ3vxmIgzCq7ELewI9khARvRqdU0bMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTE5MTAwNDE4Mjc1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB9GzP3ctdvrCuwnp2J4OZxipgz4hrb
TG8E+0bFRknil0ZMJAe7VPOJOn1Mbn5FjvlPyBjh02aNxQjifcFVhTX9QwoPdC6aCvSY3wjQcyBc
XIAa3M8OME+d3zydobYUaX3gNgAC7MdQQor3OLT7RQ4/Rxvt6tnbe4XQdxQu8/2gN6QePPGe19C9
j1a74SXh4OdC/wOdVEeCAzizrayl0F2WkEWI8z5PcXasSCe23QTWPYmBJ0NtZaN1S97X5A1Od4MV
ry6UunyvhWX/O0XBtC2DIU8T92zOUQxPY1UumpMwGIWW/DBVIl5VnNyH7sd1HpM60DTQn6ja2Mhr
bKk/7We1
--00000000000077e3d4059419dc87--


--===============6542663813996026570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============6542663813996026570==--

