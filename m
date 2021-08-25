Return-Path: <SRS0=n325=NQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6E8C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 16:04:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0604C611F0
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 16:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0604C611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1EzgZHmXGAtRU/SaAye6XOdd1c0pXME/JteAbvib70=; b=0xLhZiC4wIPiY0c5uwxt/nskvq
	ZmeNKTmgybYyu9m1cCuSehuAXPEmsYd1ePqJS7hrGb6PrmGoCHrmRQ1VuHf/adWQ4xNXcVEnoa5g1
	f6wsbvJMaPtiawK73/StvWbD5bi0melIp//F9+c3dApYSEkNpZjVLdDSGnxAysan8tSWHXXBE8vmX
	m8DGdW/2l2za/pphEafiuQL42KXtZCWyZOefIJCM8vvLmMZa+ZC4rqPqG6Fg2p1b6c2OYb1gv/xQL
	pB8ZsnNZ55vufbuIQkXSDHAtmEsTFC4XG8b9GLkqguwBD40mQMQyAbD8334/mud2KxPoZoXSaC9FP
	PPq8Q0Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIvNq-007dUP-R4; Wed, 25 Aug 2021 16:04:10 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIvNk-007dT0-Tq
 for linux-nvme@lists.infradead.org; Wed, 25 Aug 2021 16:04:08 +0000
Received: by mail-pl1-x62f.google.com with SMTP id b9so10233868plx.2
 for <linux-nvme@lists.infradead.org>; Wed, 25 Aug 2021 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=BvUOpaXFjhMvXLLgCAJmUbZq2M2QJsBTvZJHq/WNdTM=;
 b=D4Vdl7YO0sR7l6wIHllRqVmmOd6gY7K4V8phHWB5XKMEeq96R0zC226mmrKX6PLx+p
 Jb4NgHbnz+oidCxXJxl9afwe52Nx53lwzpMkEN2vAarRp1bJvrG3OPfF57736E6l3MkR
 An8DhOYMS9IO4GB0Fsh5EfZVLCX8Ur05LW51k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=BvUOpaXFjhMvXLLgCAJmUbZq2M2QJsBTvZJHq/WNdTM=;
 b=ixexVxFrJfz9Cy7cGP6+49d36X7xL9mIbPRcOZo9hLFXnIvsbikdo8B2T8XabKOSNe
 irrWinyNZZId0q2ER/oX3CvKJuLAR35Z+CXScx/vKb55muA554UEviAbprB08cIuLFEq
 ofA6k98iCIQT9kMLwJKltkdC/wZY10f2ubzjD9qC+NP88iPfVBQJ6L94TkAXxnzMCfnF
 qC3aN0CbPZ2lzorNh2TWLNXIzBZqyXIXF7hulQMBk0SUqIbZFhiMN/D81edsAVMZtIc7
 R/yvRtR1iv63Hm3U7aL4k61u5jww/e0/CRUP+UinpJB8TokGWcWrPCP3Kzu66nLhznmZ
 OTKw==
X-Gm-Message-State: AOAM530QSyCrhQl8lzysCvIrdIi43mfltmkQcgoZ93B2lKi2vVPKbmT8
 Ieu4w37Ai8J2+UATjaadM5uiwc5koyCeilViC9mUlcHavK98M8FBLOj59ScXucdKj2KrJJYloql
 AatF1hz8owZEsqt8Kqw==
X-Google-Smtp-Source: ABdhPJwfDUSwNZkf5iEcw+xuf8ehCie+1hewkDSgnH3gdymiouJLcQZ9U8zwhXQXwgU2hTVBCNWisA==
X-Received: by 2002:a17:902:a5c5:b029:12c:9108:d83 with SMTP id
 t5-20020a170902a5c5b029012c91080d83mr38918544plq.33.1629907442649; 
 Wed, 25 Aug 2021 09:04:02 -0700 (PDT)
Received: from [192.168.1.40] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id m2sm448296pgu.15.2021.08.25.09.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Aug 2021 09:04:00 -0700 (PDT)
Subject: Re: [PATCH v6 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>
References: <20210823112351.82899-1-dwagner@suse.de>
 <20210823112351.82899-4-dwagner@suse.de>
 <025942a6-4f57-b005-eb77-e9eed143522c@grimberg.me>
 <20210825130423.7tpeysh4xtcy2ark@carbon.lan>
From: James Smart <james.smart@broadcom.com>
Message-ID: <a4d0220e-0b50-9204-2ce4-5c4a486c8ed0@broadcom.com>
Date: Wed, 25 Aug 2021 09:03:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210825130423.7tpeysh4xtcy2ark@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210825_090405_083342_FDB66152 
X-CRM114-Status: GOOD (  19.17  )
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
Content-Type: multipart/mixed; boundary="===============0942427664468797282=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============0942427664468797282==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000029fcdb05ca6466c3"

--00000000000029fcdb05ca6466c3
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 8/25/2021 6:04 AM, Daniel Wagner wrote:
> On Tue, Aug 24, 2021 at 01:38:20PM -0700, Sagi Grimberg wrote:
>>> freeze before calling update_hr_hw_queues". It's not an exact revert as
>>> it leaves the adjusting of hw queues only if the count changes.
>> I see that fc doesn't freeze the queues, so it obviously wrong to
>> unfreeze them. But is it correct to not freeze the queues?
> nvme-fc is draining the queues in the error recovery path
> (__nvme_fc_abort_outstanding_ios). There are no request in the queues
> hence we don't have to freeze.
>
> The only reason to keep the freeze/unfreeze in this path would be to
> make it look alike the other transport. But it would be a no-op.
Yep.

And updated commit is :=C2=A0 88e837ed0f1f

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

--00000000000029fcdb05ca6466c3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
PXdbw8NJD55W/TyL5SqwLhkniLbboSA3j8lnH2Irpzm5VWjULsVCgV6+584AQ7cIYxFuSU2iy9oC
VOMV1KZcfEMa2w69xAPeGaT4svn9q4PyT7nKiygbAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGphbWVzLnNtYXJ0QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU38f2heZreKHlV6siVOSG/emDAbMw
DQYJKoZIhvcNAQELBQADggEBAFxOL7NTWX6Z3GGXKqmCIS7A9MeBSusGyxInLdVymGQsxEItQhHo
JsU6Nck6c8X77/ebCikLmw87STnywRJNGxUVRhcN/1p7Qyf246oxhG31fcVeSx/fEWzAbSrNTkLf
eAGDDdAlZdLD7C1DWW8Z4wYkkoAlQ/HX7/pShjmuT6UK3gkc7SxbWT0w3vpBYP0sbj0I+pdeNFBm
9mc9+qMcR1bhq+sAyYmBebwsAuCKTT1oY7Pfq1981wGcENAbCE/M0QL+PJwLYcM4UONNVqIfX6VL
rosksbNQhwjUlEcPdVzlzWQjhia2Gl3yjSb8HBLcnu4rh0oVjIP3NfBsRUkBYCYxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwooxvJJXw5eyVAy38wDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAO7ugRANEiS1WVIM2EjwuQwqiq7n7ZytYab
zHlgWvAlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDgyNTE2
MDQwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQBuI1jzuHtJgU574b1a6a3NlyeE8tYTzmSDgxjbCTVRyN3Cxs7bZxpv
McwPfEFuFG/Ra3A2E92/N6puNyYZSrEyx/s5djCe7i53a8t5Z/l+eCx4I3Jx7frosfdNDxkXTiwB
w2eKYXsTGDzScU2V5AJKyTt+X/Zc24YGXP8gfxgZbpm4nP2gpalQO1NqnWVYNrQxQP0CkkWhrSLb
o5NmHAGd5Zh3KobuuItngLNWvMjzcDesiaqrTeWGmPyjoUuL3WVotI36u3EQwp7Z+OwOvAK3kTzj
tO5GY8IfglKFxpusdeJsB8KtyuV5hhSLghLWBefB+Dhg8+2BN6yPpyWtyWQz
--00000000000029fcdb05ca6466c3--


--===============0942427664468797282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0942427664468797282==--

