Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA0AC83038
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5IiJ59cFW1XugK+Rygtua+lN1LTMZGjQZNa5Iwg2cYk=; b=l3/7hBeDzgs6nf/ft59IAmKpw1
	+Y7YDuobthu19X2y9PXrK//FKOcxkPqqk3lsL8bneXwpjGblu7FPnat++KLJZ6/U+9THteDqbU5l4
	ptBZLqnz2E30nPy3TY4/FxBzn/IG+eUOLnJHnZkWvy9g2D03cAYTmXpSnzjh7jU742kKvX2cVzOCG
	2gDHxqnBICQUQMaXBlQ14zSvC2a5lX1nBRZ95ndt9EhOUkx0fvqqArWI6Eo/5e8wFQRNgK6fuwUb1
	ScnZCHbky48q4mPwoB5ew6S+1KgWuZM18HGdFB+GhCMMRm4yFDGlkkUy1caGsFHTjXgDR93rAKia+
	MxtWBdsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpF3-00000007CFS-2Fl5;
	Wed, 02 Jul 2025 04:38:41 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWTQu-000000041wo-3Nf1
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 05:21:30 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b31e076f714so5825333a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 30 Jun 2025 22:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751347287; x=1751952087; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5IiJ59cFW1XugK+Rygtua+lN1LTMZGjQZNa5Iwg2cYk=;
        b=KrNvGCxSUteP+o/YN4qKQuydvxFfk4SlTpNS1BR81f0cRW0QZR4JqlFIWDwWGvK4mT
         +Rwq5Bu74QtN4BXX45EFT/Kybvq3Quq31v29t5VxtCrc+BnR9ojVwbZlLEXV8xFsfjAw
         QokmvPAqLXEpsR1kFjc2zFxF0TJ8nNMqtvotQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751347287; x=1751952087;
        h=cc:to:subject:message-id:date:thread-index:mime-version:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IiJ59cFW1XugK+Rygtua+lN1LTMZGjQZNa5Iwg2cYk=;
        b=W9d0SgGJgi2nZpuutCZbiFJcjZNetu5trvbQhQvsOPBLxBIm8nTPnQMGK85es5kQWJ
         ZwGcthwA7ad8zo6W4z6Fgz+uac9cIcxXHPbKmAhaUFgVTsNFD5sh/D7PKBGI4WUWkT8m
         Wca6mc9i5p9+LilFKKRc2cxFHYE0mjauBStZQSzKfwPOW3d9JPbW6t7NpRLnkJKuHLgw
         kGuNtkvTjV02h/7w3mg6uYd5rvUrPW1Bd+jnLusbFQqHjYxv3wETh3eDjsL8SLL0bQBO
         VqjU8zJV0jmA2TdCuBl1OKy7PFl/8Jqskv2Mb/HzES3ZlW30sYetEvX3czSdk+ExNiq8
         YtEA==
X-Forwarded-Encrypted: i=1; AJvYcCVX4E6F8Jn/HBb+SpkovcfIDnRm411Vg8y0J8WngkzlZev5BpDLfEo03AonNr7vgGyWLnkQTMER5N47@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0h1az6g1tkHk7m+9SydACj5ygmkIRRClNmoeK8wCqN0eww214
	aeuCT9tTwJD8qDbVMg+16O7VNd1P4sulQGYDqWpejFF1BZ8WzQO2JgRG6If8CGfbWQywK/HeP3w
	6hTd502b48p9PyblgeH5i+tk7m5FqRXOo8qbf8x4S+xAcINEaR4jixqAbBt1/FQLJckDK3DkJc0
	Bb6Cf+zo/mpEWwkw235HmT8Da957XS6TRO2oh+ca7IYV8=
X-Gm-Gg: ASbGncucBQyggHdV7a6903WB0owDHIMLIRxlnNVKQvmc19WMv74KjcSJjcemS2pKmCc
	VQpiWnuww4eXHCMJy7x2eDfNbF/3qWnsn6O17MUe3cZKhzb8RrOKKTU1nhQYNx4eWe99EjzkoU8
	yK32Xy0DiAO/XXqXgCJYzQkJmmk/NrxOus5YNSF77SCLA9
X-Google-Smtp-Source: AGHT+IGtN/eBSiHmlk1VHrA6BFfVbOM55Mx77QCsIHGzJ9AT/pxEfJobpXnNOJ43WU4Fyz40AScio6bXbhi+v3k9aSM=
X-Received: by 2002:a17:90a:1690:b0:30c:4bac:1da1 with SMTP id
 98e67ed59e1d1-31939b97128mr2247659a91.17.1751347287452; Mon, 30 Jun 2025
 22:21:27 -0700 (PDT)
From: Muneendra Kumar M <muneendra.kumar@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdvqR41OYyRP/AvQRMCrUJCubHLRGA==
Date: Tue, 1 Jul 2025 10:51:21 +0530
X-Gm-Features: Ac12FXwTdCZMX8hXcXUh9YvKo0jQ9l6u9NfJkR20cCsJwm7mcpUzV64XEHaGP_4
Message-ID: <cd70d8f7c7af3218e5f167a565290630@mail.gmail.com>
Subject: Re: [PATCHv4 0/5] nvme-fc: FPIN link integrity handling
To: hare@kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f995530638d7504d"
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_222128_899505_64AB7E01 
X-CRM114-Status: GOOD (  16.80  )
X-Mailman-Approved-At: Tue, 01 Jul 2025 21:38:40 -0700
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

--000000000000f995530638d7504d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hannes,
Thanks for the patch .
We have tested this patch and this is working as designed.
This functionality is a crucial=C2=A0enhancement for Fibre Channel solution=
s.
This feature=C2=A0perpetuates the capabilities available in dm for NVMe in
previous releases.
With this patch we have a solution for
https://lore.kernel.org/linux-nvme/20250506153507.83094-1-hare@kernel.org/
#r for both SCSI and NVMe.=E2=80=9D

Tested-by: Muneendra Kumar <muneendra.kumar@broadcom.com>


Regards,
Muneendra.



>>From: Hannes Reinecke <hare@kernel.org>
>>To: Christoph Hellwig <hch@lst.de>
>>Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
>>	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
>>Subject: [PATCHv4 0/5] nvme-fc: FPIN link integrity handling
>>Date: Tue,  6 May 2025 17:35:02 +0200	[thread overview]
>>Message-ID: <20250506153507.83094-1-hare@kernel.org> (raw)
>>
>>FPIN LI (link integrity) messages are received when the attached
>>fabric detects hardware errors. In response to these messages I/O
>>should be directed away from the affected ports, and only used
>>if the 'optimized' paths are unavailable.
>>Upon port reset the paths should be put back in service as the
>>affected hardware might have been replaced.
>>This patch adds a new controller flag 'NVME_CTRL_MARGINAL'
>>which will be checked during multipath path selection, causing the
>>path to be skipped when checking for 'optimized' paths. If no
>>optimized paths are available the 'marginal' paths are considered
>>for path selection alongside the 'non-optimized' paths.
>>It also introduces a new nvme-fc callback 'nvme_fc_fpin_rcv()' to
>>evaluate the FPIN LI TLV payload and set the 'marginal' state on
>>all affected rports.
>>
>>Changes to the original submission:
>>- Changed flag name to 'marginal'
>>- Do not block marginal path; influence path selection instead
>>  to de-prioritize marginal paths
>>
>>Changes to v2:
>>- Split off driver-specific modifications
>>- Introduce 'union fc_tlv_desc' to avoid casts
>>
>>Changes to v3:
>>- Include reviews from Justin Tee
>>- Split marginal path handling patch
>>
>>Hannes Reinecke (5):
>>  fc_els: use 'union fc_tlv_desc'
>>  nvme-fc: marginal path handling
>>  nvme-fc: nvme_fc_fpin_rcv() callback
>>  lpfc: enable FPIN notification for NVMe
>>  qla2xxx: enable FPIN notification for NVMe
>>
>> drivers/nvme/host/core.c         |   1 +
>> drivers/nvme/host/fc.c           |  99 +++++++++++++++++++
>> drivers/nvme/host/multipath.c    |  17 ++--
>> drivers/nvme/host/nvme.h         |   6 ++
>> drivers/scsi/lpfc/lpfc_els.c     |  84 ++++++++--------
>> drivers/scsi/qla2xxx/qla_isr.c   |   3 +
>> drivers/scsi/scsi_transport_fc.c |  27 +++--
>> include/linux/nvme-fc-driver.h   |   3 +
>> include/uapi/scsi/fc/fc_els.h    | 165 +++++++++++++++++--------------
>> 9 files changed, 266 insertions(+), 139 deletions(-)
>>
>>--
>>2.35.3

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

--000000000000f995530638d7504d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ys9fYL+GlV3PS9wS3h0MI90cAfs5ZQjER5eWqMBARhfrW70fFVMSdZzBpXljqRjD+GOJm711FgvN
RsH9iq2Ndn7XY7jpnxND6cwSKympBXWuvQ54YyFDLr0m9eC6BNU5bQIDAQABo4IB3TCCAdkwDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsG
AQUFBwMEMB8GA1UdIwQYMBaAFJYz0eZYF1s0dYqBVmTVvkjeoY/PMB0GA1UdDgQWBBTJvvnIS4Qf
Z+gEeC51xAB2l3lqOzANBgkqhkiG9w0BAQsFAAOCAQEAE6G8pLIpwrdO0Dmi603StqsNLN3t3i5m
SU/J+ZHnSeVNQFmfJjYSlZHSeAYrw+nsLEw08xiT4N2dPLbnowDKw0cVDRV5hL6+Uis2nqNkp9Kk
dXMVNlGeqGqBo98QRdRdzLgc/3FBQp3XIGUo2VDOMYW/RPbI1muHQOBKaVx4q8jqitNbqThvZkt/
t8KBiojEq4d7/scDRRtEsaL6Hl7cAYNMrS5EpijZrYjNYercaQNHcHP38l/XM9n36jllylt12koc
Dfj3D142STRRnexoNURmkc9EAKyZPRv/JRGz6YP0i2y1JqgpjF8CggD2osV3pA9e8ecXWQ7/ZJly
zHlFgjGCAmAwggJcAgEBMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAyIENBIDIwMjACDEnR
Sel9Ku9INR0BhDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgwyhTVrvj/S9aNkqS
F9/i/3SBlk2JNQzurtxh/s3EFQMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjUwNzAxMDUyMTI3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEARVlqKG7EOaVnosLV4Te13sSWGtOXEkX+A09jpIDPkKAnbfvOWR/7
1Ud75qHLA32bucv0AIz9myH3GzgAteUEuy4WxK3LfbNJvigGCsVED1AHcVX/HZMOUQNXaLkuaArf
R0EMAlB7wcI11FLRcYz+wY//na+Y8jlNIRFcVdyr0Jdv8EuwbPRE6ZPzOuo07pNhbRk/PcKDnIBm
y+ZpfE+neiET2YgPeHYTMwBgSjWNkoXJVHKND5cw576iPzJcyne7M5hwMcxyjLTTHWUD1qPrEsp1
BeVKcmmNm4urwc8aVRtGj16CvntWF1JXymLEP2Z/6efIjEFJ0/uA8IJ7tnUruw==
--000000000000f995530638d7504d--

