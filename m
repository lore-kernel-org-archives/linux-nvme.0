Return-Path: <SRS0=/gup=YB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76449C47404
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 00:33:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F4420835
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 00:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UXZ0Ah+K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RpWdPRnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F4420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HlDIvfVRMHCPyfDRjg30Dx22D2XJIVNyVLsxP0/oITI=; b=UXZ0Ah+KnBu8OM1ggLYddwmP3
	cHj+Jn4Z6XS+VfGH0GlReOjzEY4xlbujMw0ZUNwqzemq1bJtKgrqlIDF/e8YcFxyhH8ylEghwvbac
	g4pysCnhFTWyj7Xqc3VaG9EWZkJonpwGlWi7CY9o8/ylcuTCDlKN01qMUfWy9y9SiCygqlmCxIGfA
	RG7WOEnX3t//qfUKnMxKn9vmWI5qobm056peO8L4u/kEkQRLSIpSgWuXeDYM7Lcj/rNsl8sXXE7Vi
	I6ZW7I3lqWwRA5nzpZikr8QhQarFKJK8NZqo+jFXPpx4s6YmVmcSsBohMHcPotlQMa1noc1JWnXZL
	Sjpllc6gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHdRS-0003Oa-P6; Tue, 08 Oct 2019 00:33:30 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHdRP-0003MG-J8
 for linux-nvme@lists.infradead.org; Tue, 08 Oct 2019 00:33:29 +0000
Received: by mail-qk1-x72b.google.com with SMTP id y189so14680170qkc.3
 for <linux-nvme@lists.infradead.org>; Mon, 07 Oct 2019 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GMzdei+fQJCa+4A6T+gj2nvyQ6mgO9vcRMTwdGQwfiA=;
 b=RpWdPRnUMR6X0tWVVhScA20A7A6jA1XXjkRU1LHxCognkenkzkhg2CnMX78FLpF+RG
 lYYqjREDCBdJfRuOSDKkzUW4OxsXX8lFr5EfuUfL+qY8Ckfh5CiiOiv6FziJjr88gZpp
 8gcPM4jYJABKDeJ+PDEvaqxW0YA83irHsNwMnMvCuau3m2nY8Jjoi1ToMceOg5JF/EAz
 1gRQymGEJZVSWWLHdq1MWvRZDe0iwb2wDILuyDmYPzgykOIEFkzcIgKRRvPKzlCgVJqL
 89iox0IOSpFFH+gUTIaqzRTSVFh2ETHNoS914/EzKvRiBrtJv5qWu+38YVri2MxzDWA5
 tHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GMzdei+fQJCa+4A6T+gj2nvyQ6mgO9vcRMTwdGQwfiA=;
 b=hNTuF7V1BMUSfPBkKM7+zGsED+x0ZXJGcFa5Qta56Udi4Qp5AFrCTLaJl3pTDtVwRb
 0LEXdWA28XlhDad/cJsIyT6jFHAYqRGSEQYjT5dfql7yc4o/5qyxAkI3XruJ6wbg7VyR
 JzrUw5fa0FrABoAX1RLSjGX8eN3D4vqhP4OBSs1Srmt81Npe0f7dfga66TVY9hmDHlkv
 AjlwH/TPymCr9wd9amKvmu/QEHWlA2MRpbLbQpD24rhlQPXzFtXr6IC3rDrnn7oOYlgq
 GNrMoRDiXfkSU4GbH/aAMXAzN+hweK47njCGPyoj55yuX5zur92R0xf2g+HadrZg/4yH
 /AjA==
X-Gm-Message-State: APjAAAUryvMZ+Ul1g6B8qHArfhOJorD21ajstUnr+MPRxMyb2EZasgvW
 Z4hh8H+te5SJMeFzO/Z/BouqsMaY+cDSRLhI5QE5wQ==
X-Google-Smtp-Source: APXvYqwTB7YEfacRUsgMZNr/yS3BPeOCojFxhIvw2sSlJ1DaL4obrnldSq74Q7df76CcyGJHBNSSwZp2HjK4+HiNA8Y=
X-Received: by 2002:a37:e58:: with SMTP id 85mr26370177qko.403.1570494802268; 
 Mon, 07 Oct 2019 17:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAL26m8+WdjrKvnXDZdP4d2ekznfORDUV2Td6U6-DY9gcOqoOUA@mail.gmail.com>
 <20191005142722.GA30437@keith-busch>
In-Reply-To: <20191005142722.GA30437@keith-busch>
From: Vaibhav Nagarnaik <vnagarnaik@google.com>
Date: Mon, 7 Oct 2019 17:32:55 -0700
Message-ID: <CAL26m8+gM6KdrqpDTTQ_Tj7FGSd-qbcU78O0Ok3EaQ_B9rgHkw@mail.gmail.com>
Subject: Re: NVMe PCI driver ignores SQHD from completion entries
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_173327_659941_3A651232 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: Abbas Companywala <acompany@google.com>,
 Bart Van Assche <bvanassche@google.com>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Eric Gouriou <egouriou@google.com>,
 Christoph Hellwig <hch@lst.de>, "Mihai R." <dizzy@google.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: multipart/mixed; boundary="===============1727073544973286284=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============1727073544973286284==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000db4b8105945b5049"

--000000000000db4b8105945b5049
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 5, 2019 at 7:27 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Oct 04, 2019 at 11:27:30AM -0700, Vaibhav Nagarnaik wrote:
> > According to NVMe spec:
> > A Submission Queue entry has been consumed by the controller when a
> > Completion Queue entry is posted that indicates that the Submission
> > Queue Head Pointer has moved past the slot in which that Submission
> > Queue entry was placed.
> >
> > Which means, the driver needs to verify SQ Head Pointer value reported
> > in the completion entries before considering a particular SQ entry
> > reusable. Otherwise it's undefined behavior.
>
> The spec allows the controller to process and complete commands out of
> order, but the controller must fetch those commands in order. It's in the
> "Theory of Operation" section 1.4.

Thanks for clarifying. That makes sense.

It would be nice to have the spec clarify other sections that makes
the host check the SQ Head Pointer value.

> Checking SQ head is required only if the host might submit more commands
> than there are entries. The Linux nvme driver allocates enough tags
> for the depth of the queue, leaving one entry empty, so having a tag
> available means the next sq entry must be available.

But the driver does overwrite submission queue entries under process
(which are already fetched by the controller). Are there guarantees
from controllers out there that once fetched, the SQ entries will not
be fetched again for any reason? The spec doesn't prohibit that.



Vaibhav

--000000000000db4b8105945b5049
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
AgwjSKzmYcXpdXyI2KswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAmx+tGUc+p6
hLdCIQYYIkan668cHgWzKek1fBT3E604MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTE5MTAwODAwMzMyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAyo+RWq3i+zKTcZrRT81e32f4FHy7l
/X6XnpJ8z73xdVG6M3cCBBl5cVZ0D9sowOM8DpH+p7bSA43827/+Ro9cqAgJcteqAUHu0iZmGcMt
cC+pUnZIQZ+MuJXyiAX2Uh5Q4d7zU8zSTZsCvIwiCzW2u4azFnKusTTQfU0ICUEEjHWpp6CciCnK
ahDWbkkf+JLTzqAi+uaCk7xScbagAQguTNfhcuiqG6S3eN62ABu1RkZNKLbZBWyw7YYL8HICDbh6
0t4stgJrxKSgM2bx/0BSm63u/YjOv+RHs3KnRLmokDPVMAP57ZneiqiDz2wi2/HN4tNKjxkWMYnc
XAv5lvLa
--000000000000db4b8105945b5049--


--===============1727073544973286284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1727073544973286284==--

