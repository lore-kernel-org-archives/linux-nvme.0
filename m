Return-Path: <SRS0=D3NM=F2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800E9C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 07:05:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE7C23130
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 07:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE7C23130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:Date:Subject:To:From:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=o0/5w+xcllVjlct3sRkLS5vGY00seuPrkOcN4bGxoik=; b=Il6
	C6CqK2qg2CEhwONIuNyBX0tbNCFYqaAbu9U5/z7HfnlQwu8EalDYS6v7RD9QQe6cccxdv1mrBDrxL
	a6UXgKb+k791jhlGkyFMK/FodzsmPUiHVxA1D1nAPvNB0KofiCVU7eht54jSa8xtKI13zT6i1hdvI
	zXAhB8l251KGD0oI+Yeo+mHgLWngGI+uKe/vGlUyokbt1hdA3TxlRbmT49P2B+C3j7PXtNth9bgCt
	tCwdHv8WksyRu47A7VPgjI1VED30CEjsb4g/QPzi/FHruBHvdD3qSRmqsCEGHoStndNoeujdBZKr/
	jUR3jX/pGSTZ8yNK/AATXQOBWqvTPqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krbjE-0007A6-N8; Tue, 22 Dec 2020 07:05:04 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krbj9-00078m-QE
 for linux-nvme@lists.infradead.org; Tue, 22 Dec 2020 07:05:03 +0000
Received: by mail-pj1-x102b.google.com with SMTP id v1so828173pjr.2
 for <linux-nvme@lists.infradead.org>; Mon, 21 Dec 2020 23:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:from:to:cc:subject:date:message-id;
 bh=dbbRfc8wF3POU+bYPdy3yPrioeEd1DYCr29By69dhk0=;
 b=bGSxkMN/QI2F/k9SPJExlIDFgWWndrooC2q3Yh9A4qCNTc02p2E9wVVenhCr/uW17B
 SOFrMQRqtwlMusOFaxqihlxDgXsjVdiOPbhy6HdrbLA0APko1ggxtyQ8QalFu1qK60zm
 uWDDqBakY98obVSWnQlDYBSJuA/cB4n/mBn8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dbbRfc8wF3POU+bYPdy3yPrioeEd1DYCr29By69dhk0=;
 b=rkdewmF7FVkMHWaCQCV/rislobuZSHO1hrLLmmjWl8O2eNwUb/PLBZSY6LyZ6SnNHb
 czD9grzZaHvw/Dh2gzpikBDNQyZslxxE1hDME/o9jvvHV1UHqExMJV5G3sV4iirZZafL
 Kmzti1XnKjDB06kvdXAyeAZ97PBkbjZ8M6simcJUDAtu2VjivqF50HzQZWysaVE7B1rF
 Z5Wiz3O6UW/BwZslGXUO7KCPHXOwgBTskw6qoni6LK3snHQTMam0OVl9aOU+oM6jzWuu
 UMWMDNRUlsYJ57fxcDs9VxUbmte3sku4fwlAvd2EM9HDIcypz80G7CAoaES9S9J5XWLA
 B1Zg==
MIME-Version: 1.0
X-Gm-Message-State: AOAM532uxWjBpMD4ectBppz2lXowaM5gd22jFA8aOaB4a60hobDLmIdK
 ZjfBILGV3qth77YhMrvpBISfokyfPFJ+QSQRXSqVYHFK17leW8xs4CEaI8g60Lin7zMxqrXrRiX
 YMEzQJ71/gzfugJ6S7Q==
X-Google-Smtp-Source: ABdhPJyanWLOOdhhnY5O1ccm5BlWK9VIlWn9Ytnqse2oy64sNwi5TuhXVlYpQHrSg4g2JHu1WHUVMw==
X-Received: by 2002:a17:90a:6401:: with SMTP id
 g1mr20404658pjj.165.1608620692782; 
 Mon, 21 Dec 2020 23:04:52 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id t9sm12466082pgh.41.2020.12.21.23.04.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Dec 2020 23:04:52 -0800 (PST)
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Subject: [PATCH v6 00/16] blkcg:Support to track FC storage blk io traffic
Date: Tue, 22 Dec 2020 05:41:42 +0530
Message-Id: <1608595918-21954-1-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201222_020500_370248_D0DA32FF 
X-CRM114-Status: GOOD (  17.36  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Muneendra <muneendra.kumar@broadcom.com>
Content-Type: multipart/mixed; boundary="===============6930192870210213934=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============6930192870210213934==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000012aec05b70831a3"

--000000000000012aec05b70831a3
Content-Type: text/plain; charset="US-ASCII"

This Patch added a unique application identifier i.e
app_id  knob to  blkcg which allows identification of traffic
sources at an individual cgroup based Applications
(ex:virtual machine (VM))level in both host and
fabric infrastructure.

Added a new sysfs attribute appid_store to set the application identfier
in  the blkcg associted with cgroup id
/sys/class/fc/fc_udev_device/*
With this new interface the user can set the application identfier
in  the blkcg associted with cgroup id.

This capability can be utilized by multiple block transport infrastructure
like fc,iscsi,roce.

Existing FC fabric will use this feature and the description of
the use case is below.

Various virtualization technologies used in Fibre Channel
SAN deployments have created the opportunity to identify
and associate traffic with specific virtualized applications.
The concepts behind the T11 Application Services standard is
to provide the general mechanisms needed to identify
virtualized services.
It enables the Fabric and the storage targets to
identify, monitor, and handle FC traffic
based on vm tags by inserting application specific identification
into the FC frame.

The patches were cut against  5.11/scsi-queue tree

v6:
Addressed the issues reported by kernel test robot
Modified the Kconfig files as per standard

v5:
Renamed the function cgroup_get_from_kernfs_id to
cgroup_get_from_id.

Moved the input validation at the beginning of the function in 
Renamed the arguments appropriatley.

Changed Return code to non-numeric/SymbolChanged Return code
to non-numeric/Symbol

Modified the comments.

v4:
Addressed the error reported by  kernel test robot

v3:
removed RFC.

Renamed the functions and app_id to more specific
Addressed the reference leaks in blkcg_set_app_identifier
Added a new config BLK_CGROUP_FC_APPID and made changes to 
select the same under SCSI_FC_ATTRS

V2:
renamed app_identifier to app_id.
removed the  sysfs interface blkio.app_identifie under
/sys/fs/cgroup/blkio
Ported the patch on top of 5.10/scsi-queue.
Removed redundant code due to changes since last submit.
Added a fix for issuing QFPA command.



Gaurav Srivastava (12):
  lpfc: vmid: Add the datastructure for supporting VMID in lpfc
  lpfc: vmid: Supplementary data structures for vmid and APIs
  lpfc: vmid: Forward declarations for APIs
  lpfc: vmid: VMID params initialization
  lpfc: vmid: Add support for vmid in mailbox command, does vmid
    resource allocation and vmid cleanup
  lpfc: vmid: Implements ELS commands for appid patch
  lpfc: vmid: Functions to manage vmids
  lpfc: vmid: Implements CT commands for appid.
  lpfc: vmid: Appends the vmid in the wqe before sending
  lpfc: vmid: Timeout implementation for vmid
  lpfc: vmid: Adding qfpa and vmid timeout check in worker thread
  lpfc: vmid: Introducing vmid in io path.

Muneendra (4):
  cgroup: Added cgroup_get_from_id
  blkcg: Added a app identifier support for blkcg
  nvme: Added a newsysfs attribute appid_store
  scsi: Made changes in Kconfig to select BLK_CGROUP_FC_APPID

 block/Kconfig                    |   9 +
 drivers/nvme/host/fc.c           |  73 +++++-
 drivers/scsi/Kconfig             |  13 ++
 drivers/scsi/lpfc/lpfc.h         | 121 ++++++++++
 drivers/scsi/lpfc/lpfc_attr.c    |  47 ++++
 drivers/scsi/lpfc/lpfc_crtn.h    |  11 +
 drivers/scsi/lpfc/lpfc_ct.c      | 252 +++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_disc.h    |   1 +
 drivers/scsi/lpfc/lpfc_els.c     | 369 ++++++++++++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_hbadisc.c | 153 +++++++++++++
 drivers/scsi/lpfc/lpfc_hw.h      | 124 ++++++++++-
 drivers/scsi/lpfc/lpfc_hw4.h     |  12 +
 drivers/scsi/lpfc/lpfc_init.c    | 109 +++++++++
 drivers/scsi/lpfc/lpfc_mbox.c    |   6 +
 drivers/scsi/lpfc/lpfc_scsi.c    | 334 ++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_sli.c     |  65 +++++-
 drivers/scsi/lpfc/lpfc_sli.h     |   8 +
 include/linux/blk-cgroup.h       |  56 +++++
 include/linux/cgroup.h           |   6 +
 kernel/cgroup/cgroup.c           |  26 +++
 20 files changed, 1782 insertions(+), 13 deletions(-)

-- 
2.26.2


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

--000000000000012aec05b70831a3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCBOWhFFM60iN1dgK13QQ4jp9h1U3l3EEa0kGnNM2RJ0pTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEyMjIwNzA0NTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAvXYfIc/wmVOncSyc
SOFPNH6OW0qKCZdAxtCRVGLLzbNBfXVqK/Wupmh5eQas0RdZ54rUR45euuvmaR2g8LPvMOlYvcpJ
cxA53TGE+jonyERZcodF1APoNxIMhSDx9OgNaxroPWcnhKgKVg9yNzdOmr4CjzOsA/W8w1pcz5yC
ArOsfCB8GV10mkyVY4ECJhOuXAFjCm5cG71CynhOKxkXi1692alCRbf6mpypVpeBaebtf3zZQkOa
fIn+5i9LWTEsiYUlXjm1HdrsCoYmqSpsvtPK9vGiQdyiUGXy4lnb4UiU/fOqduzpkjn8AI/0RaSb
uFvDvm/gjo3eoJRsx2CwNQ==
--000000000000012aec05b70831a3--


--===============6930192870210213934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============6930192870210213934==--

