Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E65C2D0E4
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 21:42:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAD320706
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 21:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oDtiMAEK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OUZy6L2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAD320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bhGQXkKZy/yg4W3j8Gdt42TksNLf/1FiLbmR+2FbnvE=; b=oDtiMAEK0dpvRpblkfWrkBCiO
	PG+WC0DTF1CkSiusI1lqkwvAElXBAV3iyp2ukaphsbobNjwxZ1OH6wAIga4nt1z9HzKz1oE9zAgK4
	BKu1zF90VSGnI2Hamz1AjbIDUoaxAzEMHe7nJQ61ddDDc6H/l/jw5qH6KMTGMbv+Ff9mYJ3QCN91M
	2nDqIyZAr+RZxh8CLsC2mtXCHNjwVXBnvcdnM21VfZnIbOy2kMWT0NF/9Ywu36GcI0jEy6kvem5Jd
	9wvPWjniLqW6NTm8U8PrQHtSmvPOGRqDwhkhujsxc/EEKEGlgal9fhgO99HLPljPUIVnG3q48eI3g
	T+geqlwZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khJb1-000543-UK; Mon, 23 Nov 2020 21:42:03 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khJay-000533-3d
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 21:42:02 +0000
Received: by mail-pf1-x441.google.com with SMTP id w202so428800pff.10
 for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2020 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=WW0rviMDqT0HgQEf2Y8ShmaXJK32zyckwDl5OzpdJO0=;
 b=OUZy6L2CONDqM6kgrlkRYK2ICYuOP76n9UvZKiNwL5H2hBa1sP3jIqqVj1RdZGhs+9
 tkbPX7YRfyUVz9b1oeEg20rFe19zRSQhfXtvkWomu3E5Kj3DULngd7NING36wvDYYajG
 bUCE/51fx/hCEXbw3oaR1gKUxYFgyiP1630mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=WW0rviMDqT0HgQEf2Y8ShmaXJK32zyckwDl5OzpdJO0=;
 b=qZi+J1N3gPZFiUZ9Z5NOooHht2Vn/6oxryE1AcBZPJuFHeGXTJuT8BuETwVjm+wTVY
 perJg0Mxcwep2az03htAr279l/MdeKe6Tk5I5p7Undavt6j1td/39J+EZnUi9LJSLmKO
 IMRca5i4srAi95dMqu+lLw8WJ++e59a0WakOhw3Bt3SzKgaVUIMg1MVrF673GXgj4Vzx
 OPh/EIrDqtNYnka8Ls7RKf3HxUSClJ9hHY3Fv2ZYcxKvDrs7G3Q24O9jh1zaZeIbsU3D
 MTNgYcvn4svmghdx9T16AyykSUkojeW8+OcyQzkst/ufaMZlsjfkaYbChKNkP5VoEo/K
 ZKpw==
X-Gm-Message-State: AOAM530kv3gIg5MhUDU+4V0aKlVI3pXllvTIp72z3eqaFuPuXpmMAuNJ
 6q8kwE7X6kkCBLgHx5o/Iy4AR5gIr6upHK1SRGavPTrUvuO+lXe33Uu35HMpxpZOzje8eC7OuSz
 qPpJGaSbFQtCI3Zv6QYp+9xwEQQLbwpLoXyzS/UlH3P5MCqpOfyJR0GLCG2LPG/pmtsZY8es3k/
 7Cun05UY/u
X-Google-Smtp-Source: ABdhPJx1g+85GuoLDuSp3OQvZ/mCUHzOyUpIRmyj/xS7awGXzNcCFjfG9WucJjbXGaOiE+Wqo2QL7Q==
X-Received: by 2002:a63:5609:: with SMTP id k9mr1237574pgb.42.1606167714651;
 Mon, 23 Nov 2020 13:41:54 -0800 (PST)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id e1sm12708929pfi.158.2020.11.23.13.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 13:41:53 -0800 (PST)
Subject: Re: [PATCH v2 2/3] nvme-fc: eliminate terminate_io use by
 nvme_fc_error_recovery
To: Daniel Wagner <dwagner@suse.de>
References: <20201023222752.90621-1-james.smart@broadcom.com>
 <20201023222752.90621-3-james.smart@broadcom.com>
 <20201119105105.czsz4tmjrizzqlex@beryllium.lan>
From: James Smart <james.smart@broadcom.com>
Message-ID: <5ac00957-7b26-e69b-ab9b-3f83bfcb1498@broadcom.com>
Date: Mon, 23 Nov 2020 13:44:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201119105105.czsz4tmjrizzqlex@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_164200_453297_1691D613 
X-CRM114-Status: GOOD (  14.18  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4669471318070105102=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============4669471318070105102==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002394d205b4cd1083"

--0000000000002394d205b4cd1083
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 11/19/2020 2:51 AM, Daniel Wagner wrote:
> Hi James,
>
> On Fri, Oct 23, 2020 at 03:27:51PM -0700, James Smart wrote:
>> nvme_fc_error_recovery() special cases handling when in CONNECTING sta=
te
>> and calls __nvme_fc_terminate_io(). __nvme_fc_terminate_io() itself
>> special cases CONNECTING state and calls the routine to abort outstand=
ing
>> ios.
>>
>> Simplify the sequence by putting the call to abort outstanding ios dir=
ectly
>> in nvme_fc_error_recovery.
>>
>> Move the location of __nvme_fc_abort_outstanding_ios(), and
>> nvme_fc_terminate_exchange() which is called by it, to avoid adding
>> function prototypes for nvme_fc_error_recovery().
> During local testing I run into this problem:
>
>   BUG: scheduling while atomic: swapper/37/0/0x00000100
>   Modules linked in: iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) intel_=
rapl_msr(E) intel_rapl_common(E) sb_edac(E) x86_pkg_temp_thermal(E) intel=
_powerclamp(E) ext4(E) nls_iso8859_1(E) coretemp(E) nls_cp437(E) crc16(E)=
 kvm_intel(E) mbcache(E) jbd2(E) kvm(E) vfat(E) irqbypass(E) crc32_pclmul=
(E) fat(E) ghash_clmulni_intel(E) iTCO_wdt(E) lpfc(E) iTCO_vendor_support=
(E) aesni_intel(E) nvmet_fc(E) aes_x86_64(E) ipmi_ssif(E) crypto_simd(E) =
nvmet(E) bnx2x(E) cryptd(E) glue_helper(E) pcspkr(E) lpc_ich(E) ipmi_si(E=
) tg3(E) mdio(E) ioatdma(E) hpilo(E) mfd_core(E) hpwdt(E) ipmi_devintf(E)=
 configfs(E) libphy(E) dca(E) ipmi_msghandler(E) button(E) btrfs(E) libcr=
c32c(E) xor(E) raid6_pq(E) mgag200(E) drm_vram_helper(E) sd_mod(E) ttm(E)=
 i2c_algo_bit(E) qla2xxx(E) drm_kms_helper(E) syscopyarea(E) nvme_fc(E) s=
ysfillrect(E) sysimgblt(E) nvme_fabrics(E) uhci_hcd(E) fb_sys_fops(E) ehc=
i_pci(E) ehci_hcd(E) nvme_core(E) crc32c_intel(E) scsi_transport_fc(E) dr=
m(E) usbcore(E) hpsa(E) scsi_transport_sas(E)
>    wmi(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E=
) scsi_dh_alua(E) scsi_mod(E) efivarfs(E)
>   Supported: No, Unreleased kernel
>   CPU: 37 PID: 0 Comm: swapper/37 Tainted: G            EL      5.3.18-=
0.g7362c5c-default #1 SLE15-SP2 (unreleased)
>   Hardware name: HP ProLiant DL580 Gen9/ProLiant DL580 Gen9, BIOS U17 1=
0/21/2019
>   Call Trace:
>    <IRQ>
>    dump_stack+0x66/0x8b
>    __schedule_bug+0x51/0x70
>    __schedule+0x697/0x750
>    schedule+0x2f/0xa0
>    schedule_timeout+0x1dd/0x300
>    ? lpfc_sli4_fp_handle_fcp_wcqe.isra.31+0x146/0x390 [lpfc]
>    ? update_group_capacity+0x25/0x1b0
>    wait_for_completion+0xba/0x140
>    ? wake_up_q+0xa0/0xa0
>    __wait_rcu_gp+0x110/0x130
>    synchronize_rcu+0x55/0x80
>    ? __call_rcu+0x4e0/0x4e0
>    ? __bpf_trace_rcu_invoke_callback+0x10/0x10
>    __nvme_fc_abort_outstanding_ios+0x5f/0x90 [nvme_fc]
>    nvme_fc_error_recovery+0x25/0x70 [nvme_fc]
>    nvme_fc_fcpio_done+0x243/0x400 [nvme_fc]
>    lpfc_sli4_nvme_xri_aborted+0x62/0x100 [lpfc]
>    lpfc_sli4_sp_handle_abort_xri_wcqe.isra.56+0x4c/0x170 [lpfc]
>    ? lpfc_sli4_fp_handle_cqe+0x8b/0x490 [lpfc]
>    lpfc_sli4_fp_handle_cqe+0x8b/0x490 [lpfc]
>    __lpfc_sli4_process_cq+0xfd/0x270 [lpfc]
>    ? lpfc_sli4_sp_handle_abort_xri_wcqe.isra.56+0x170/0x170 [lpfc]
>    __lpfc_sli4_hba_process_cq+0x3c/0x110 [lpfc]
>    lpfc_cq_poll_hdler+0x16/0x20 [lpfc]
>    irq_poll_softirq+0x88/0x110
>    __do_softirq+0xe3/0x2dc
>    irq_exit+0xd5/0xe0
>    do_IRQ+0x7f/0xd0
>    common_interrupt+0xf/0xf
>    </IRQ>
>
>
> I think we can't move the __nvme_fc_abort_outstanding_ios() into this
> path as we are still running in IRQ context.
>
> Thanks,
> Daniel
>

Daniel,

I agree with you. This was brought about by lpfc converting to use to=20
blk_irq poll.=C2=A0=C2=A0 I'll put something together for the transport, =
as it is=20
likely reasonable to expect use of blk_irq

-- james



--0000000000002394d205b4cd1083
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg9ZzQrX8unIcwJhPS
pzU8bvF+qC1sl+OOBgUNAQoPgP8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMTIzMjE0MTU1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAE3oBjuYRMR8bgrP3dRHMDKSjU60W6Rp2tPM
fY/j5jkLH1QQWzHJJGIdc5jPaJOWgrMUOCB887xxtXynCxXFIfmArWKRZDosMKhu1a3VxEmzaBey
XEAysWI83ZFZWrAbtImCaYQsJStnMz96Zs15P9y2a/Z4L/y2L270VWGRAxdMjuagoTi2kUv7tg0v
UyUZD7sVdbBjLYk9ZAIWh1C0nQDCBXv6cM6aIDYcWwqM7eHkbiZ8eTEm+sSm2Rm80OR0j4Xcsmof
TMTuSSNKO62IC1uFxa1Yy1/UW9rHDpzWGwKhhz89EaaLUo/3zmxbJnVgLfliu8OPD7N2M1h+vEDc
GRg=
--0000000000002394d205b4cd1083--


--===============4669471318070105102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============4669471318070105102==--

