Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22054C8302D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:MIME-Version:From:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V2TKnbxpYR6MKUjUraiBG2qlnyPoxaZjQVwhEL7YdiU=; b=Y52px2o2YYQFs6igphQfXvF+gu
	6cJSs6mOuuHCv9mxtuvfn1T2F1I8labeJewS+dO+wZMrfMCXl+EeXXmQ9utZ+8GhOtO6nnSIw2vnU
	/JXkiNizk0ems0Ksgy5Zfe23g3KlkwYMV93Fsc+1epBg5Q2fzsa8JJhPw/DgFwRbaXi9wUB1Iekrm
	SuqUApEf3Gz1FVAoFGLmX7MqQrMyaRSMnlqf2hJ1LaWJuSteifpF2AeyF9Pids7SSShqAacN/PF4H
	IKsMZbkZAuo8ssTwUL+iZF84T4lOYx9eh9iDLlDBkYmjgAdwzfpy2WX1SsbQOzpURuKmniqxmuiiD
	ztMPG3oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWB87-00000001nEw-2OPh;
	Mon, 30 Jun 2025 09:48:51 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWB4a-00000001mZP-2ec5
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 09:45:14 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-311a6236effso1103442a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 30 Jun 2025 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751276711; x=1751881511; darn=lists.infradead.org;
        h=to:subject:message-id:date:thread-index:mime-version:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V2TKnbxpYR6MKUjUraiBG2qlnyPoxaZjQVwhEL7YdiU=;
        b=Z7B7wywvPy74IwSaJhN06ez2vGnqeV5wEFUGTng54jVJ8ipHGdllzsg8jJEjRtrQoA
         Ij8ZUnZ3ZF+6jNhhMMoHt/k1wDxvlJxwgl5ghI2syUPjnCSeTQDe4KfjNs3e3+sqx+b4
         vqR30rixKUQWWsyp2IMsGwWBhcX1ybCiuMX3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751276711; x=1751881511;
        h=to:subject:message-id:date:thread-index:mime-version:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2TKnbxpYR6MKUjUraiBG2qlnyPoxaZjQVwhEL7YdiU=;
        b=KoaM3F3Vjk/raDfu+uB3YjwfQ/d2kOD6hNO7zUPIgkjPhtJrx7bXO0qwiGbcCiTddT
         CzMgh+QVsY+0qYKMjUGc8v9B99Zt1N08Fy9pJfz/Mc4RbRaQ73sg6HuWSCtgY3zG7Dt5
         ug9q3FpaqoffmSMy7auvZKSisF1vcb09ZZ5KgxvN9lGtJFsPs0l3y0JTJQIhITn4UnRg
         +x08kwdY8I3YTnUmJj7Jg71OBiWGNxNg2GxRd2ropZ2t5XaRRwJvomBELWDF7K1s+6xZ
         39jJzHWZ0HQObt+A0PuXd3MT/gyygcCpGkP8FoX8HirCZw+kQ0rVqYJ7TWBSw9CP4mRH
         pKbw==
X-Gm-Message-State: AOJu0YwyFaCnaNVj5li8aXBBydzAuI8M+u7n8RgvHdPd4Jtna6qjXjV8
	2mwsGQMts5G2S+2iGUiB50b6dkkTxwZjXcHhLrAu/lw9iLMnKFsOa5ah9SWZ6o+NxKAWRe8BPfm
	F3uDzfXbKdB6AGshw1OiaC2pUtaN/HuZoq8ihwuHY9KCSHrH4CY2VfTKbEmL24JmCTtp8OcqWds
	QnS2zTbzw1OWQe+/Veg189irHKHcWTXdhZgkn9NmMFv2I=
X-Gm-Gg: ASbGncsTH15uYrCcFnmmxu6xoy1NGKUtygaVzaD5NDQ3od1oCBUMslNzkvXzp2txcYk
	HaZliZhsy7RXmOQBDrcnULYELA+a//ZKbMOdq4XfRbLrZMF1MoZqbMYlxvS+rJlWcYZwpRkYe22
	K0bxf3bCKMcDX9Ks6E1/tg6ynqnx9i+h/drmjyQY4m2oKz2kYBIxtps8U=
X-Google-Smtp-Source: AGHT+IFsafDyhbSfSHvMgVZkLP65oJBezPjrFOibEI1TCiKiMau7+hOGNzkLgHAcJgGfp7Fzwre6iEHBg5vjpJtjxZk=
X-Received: by 2002:a17:90b:390f:b0:315:fefe:bebf with SMTP id
 98e67ed59e1d1-318c923eaedmr18801266a91.13.1751276710841; Mon, 30 Jun 2025
 02:45:10 -0700 (PDT)
From: Muneendra Kumar M <muneendra.kumar@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Advpo6LRUhcPH82kSbqIFn+RVe93qw==
Date: Mon, 30 Jun 2025 15:15:06 +0530
X-Gm-Features: Ac12FXzaOuYyqShpXgANo6Q47pK7-dHQ-I00IHL5dDduVX2IH5CRiwRit0jeL3w
Message-ID: <a12bc73c1bcd34ccc2dde2ccf5d3b3d1@mail.gmail.com>
Subject: subscribe
To: linux-nvme@lists.infradead.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000046df040638c6e243"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_024512_672661_B346D5ED 
X-CRM114-Status: UNSURE (   7.12  )
X-CRM114-Notice: Please train this message.
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

--00000000000046df040638c6e243
Content-Type: text/plain; charset="UTF-8"

subscribe

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

--00000000000046df040638c6e243
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
Sel9Ku9INR0BhDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg9BL+c3DepzCbpJDc
yrrPwM92PvAnV6+t1g9q1Pe0SE8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjUwNjMwMDk0NTExWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAZqP9yx+lgkrF+3GxAYy+duZ4Zl1vH3bWi05zM7GDPEH0+784UaFc
rDqAPnyqd0Y9XH8d50UVzA+QY0iQhmSvL/mWbj1FLk6oRJDRNH9LrODCE5H99PfTFKEjiqHu/qI0
8WwLbfZWofRmE4bVWsVP7ZCB7RsZdihbx6CYDnU0+mq/JYSVd4jL8A6qgHhUiuRj0LLj7MprFSbn
C2XAFp2zJt3sRjOJdt9ED6lNVOEYZ5ffJt/Tu6aenSoVSSDJSPIUQg+NWNmJQKS2J9oQTW9wL4nh
aDLpWjIgbeFgEbCBQM9bxRHHLLKrrAUMQSssCvlwNro/6XtxYF6QcMsJd9pdYg==
--00000000000046df040638c6e243--

