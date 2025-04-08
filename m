Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E761BC369A5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M6xR5Xe9P/3EIIh5swGspyIXMH0crqNW/0Evpig/XMs=; b=NRqgvcSPHWiAN66Lg4XPRO+Qtc
	PPCCuuVAyGqRuKH8uDQW1R7i1iDDMOnxJT5Uvj6Fx6lfomW9JORMugGrU9l8IztNeIDYdZ2FYPPAz
	gj3v+T8C/tW0EFA7vnRR9QCG0dWV6ZDtlEWpZqVIpNcr6Diby5L4fdKeHUGz9UAC7WcYlqA1HQuug
	b7MWC9fRCy6NFTCPFBKftdFtaMLO9fsitNgo48Gycd5CfbbeGSBmGy1sCZ42Qak+H8TPOmvs8KUYj
	MnqkKwfZ/YJeZERzYEtTp0FgKzM2THTvcpwUjDHKpYoEejfrTsLDpN3FARU9DgDH3SqOEeVOt7Nap
	FUXLbWzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u28m2-000000046OZ-15b4;
	Tue, 08 Apr 2025 13:13:54 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u26a6-00000003klk-0xy4
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 10:53:27 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-6fee50bfea5so44431107b3.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Apr 2025 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744109601; x=1744714401; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M6xR5Xe9P/3EIIh5swGspyIXMH0crqNW/0Evpig/XMs=;
        b=BXJ5IHDtIzPrlUQYyLZJDJ6unkEjDEvh9KXT+nxH0u2bCSP8surAlbsyUaP/o+jE5R
         gxQ4CPuuwlamcsJR88VE3D5S2cYGhoZnGc/Fyoz/J1v1HnextX3kUVSNKXBelV3t8ch1
         GZbjBsWVbWLAyoaldP/7/VXoWPQJHpUYUOhBGuQSOKxSyNa016W7z7s4imAdmcWBDjI2
         P0Obdz9yd7uXjb4RatLLRwSk14X/ImCCBqFHhdmmz9H7n2HwF/JdBJ31S3O8h1MnBpyc
         c4OqLqzCDJeey+3grvuzj1fTRlqPbd28BNlNJnDIGpGRA2KZvVlHYkp7abI69+tU9JYz
         MRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744109601; x=1744714401;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6xR5Xe9P/3EIIh5swGspyIXMH0crqNW/0Evpig/XMs=;
        b=H9444eFMwYTQ6+bo9Lc8vafMnFgJ3kJ68k0wiL+uiGb3szKzubHhTMmw9yAoPmDe4x
         GGaGiKzaTIpXEJD35iWLQVshvbg3C2h2gSUQ5AgR1xM4cMiXpPO62eVv3W2crOQiMPsU
         YPp/A/3VTy/W/mdxVeLEgCiAbgX9SypACtsM3qGdKlPxkfwK6pRmWRkL58degmnIicbw
         aoPd5W4PHENSJYf1MT5njF3SQJMKG1dnecvu1NkfK1OKWdN3h2HvHKjTfy0SRmSquJP7
         dExug4hVVwYYTOOP/JDNRa2kazvyEo5HvO0YNaP/yGGecJnmAtR1HBdAAw48O0Eu15Wt
         FhZA==
X-Gm-Message-State: AOJu0YywaE6gxHm/wg+0oJ+4K6J75F2VrcLdiDS9nUZBq4Y44y7UimQi
	j2iU7lw3hSh0n70kQcsCvXKGrFaGFlQ1XizwLm4J+trxmnHaBK//rEvmd/tMUSy0JQpHRn/a8RC
	uDHvwzJENSWkldrgMaq3ZkH/BnOZVqTVE
X-Gm-Gg: ASbGncvq/fzoLfP5mfhQsVLcMNLk+y58koBgepl/ToCYCEXLkBwyVGdRY/zRTHdBmU/
	o33RJXqDuMPbFWYAtQtRaPNrohuqqXV77JH1J9iP9Ofz7iUc2yae8EtVO7ZAJQwgpxJb6Syz1oD
	b1Zm3Gozlyf2sgPqntpRV566q/6xo=
X-Google-Smtp-Source: AGHT+IFaTbl2vTe9r6X9CjAjxjeU+EMmhlwWSWHX/qxzqZ9vaYYnjm5tQrVd8EM2iI89JuGFHEZsuAKBmJlMylyLGd4=
X-Received: by 2002:a05:690c:c01:b0:6fd:4485:9255 with SMTP id
 00721157ae682-703e1633bacmr254571637b3.24.1744109601298; Tue, 08 Apr 2025
 03:53:21 -0700 (PDT)
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 8 Apr 2025 13:53:09 +0300
X-Gm-Features: ATxdqUGOOG-U1tRopJGbkPDKekTTOtdhcB7uKP8bJ_xEy-7RWiFiLGEck_tjXxQ
Message-ID: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
Subject: nvmetcli restore fails in add_subsystem
To: linux-nvme@lists.infradead.org
Content-Type: multipart/mixed; boundary="0000000000003c545006324229b5"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_035326_279442_B23DF511 
X-CRM114-Status: UNSURE (   7.98  )
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

--0000000000003c545006324229b5
Content-Type: text/plain; charset="UTF-8"

Hello

I'm trying to set up an NVMe/FC target on Fedora Server 42 beta.
Config file attached.

HBAs I use SN1600Q, and according to Marvell
(https://www.marvell.com/content/dam/marvell/en/public-collateral/hpe/hpe-marvell-datasheet-sn1600q-adapter-hpe.pdf)
it supports NVMe over FC.

[root@localhost anton]# nvmetcli restore nvme_fc_1_link
Traceback (most recent call last):
  File "/usr/lib/python3.13/site-packages/nvmet/nvme.py", line 668, in
add_subsystem
    os.symlink("%s/subsystems/%s" % (self.configfs_dir, nqn),
    ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
               "%s/subsystems/%s" % (self._path, nqn))
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
OSError: [Errno 6] No such device or address:
'/sys/kernel/config/nvmet/subsystems/testnqn' ->
'/sys/kernel/config/nvmet/ports/1/subsystems/testnqn'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/bin/nvmetcli", line 754, in <module>
    main()
    ~~~~^^
  File "/usr/bin/nvmetcli", line 736, in main
    funcs[sys.argv[1]](savefile)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/bin/nvmetcli", line 681, in restore
    errors = nvme.Root().restore_from_file(from_file)
  File "/usr/lib/python3.13/site-packages/nvmet/nvme.py", line 394, in
restore_from_file
    return self.restore(config, clear_existing=clear_existing,
           ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        abort_on_error=abort_on_error)
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.13/site-packages/nvmet/nvme.py", line 376, in restore
    Port.setup(self, t, err_func)
    ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.13/site-packages/nvmet/nvme.py", line 732, in setup
    port.add_subsystem(s)
    ~~~~~~~~~~~~~~~~~~^^^
  File "/usr/lib/python3.13/site-packages/nvmet/nvme.py", line 671, in
add_subsystem
    raise CFSError("Could not symlink %s in configFS: %s" % (nqn, e))
nvmet.nvme.CFSError: Could not symlink testnqn in configFS: [Errno 6]
No such device or address:
'/sys/kernel/config/nvmet/subsystems/testnqn' ->
'/sys/kernel/config/nvmet/ports/1/subsystems/testnqn'
[root@localhost anton]#

[root@localhost anton]#
[root@localhost anton]# rpm -qa|grep -i nvmetcli
nvmetcli-0.8-1.fc42.noarch
[root@localhost anton]#

[root@localhost anton]# rpm -qa|grep -i nvmetcli
nvmetcli-0.8-1.fc42.noarch
[root@localhost anton]# dmesg
[ 1094.242081] nvmet: adding nsid 1 to subsystem testnqn
[root@localhost anton]#
[root@localhost anton]# cat /var/log/messages
Apr  8 12:31:34 localhost kernel: nvmet: adding nsid 1 to subsystem testnqn
Apr  8 12:31:34 localhost python3[2198]: detected unhandled Python
exception in '/usr/bin/nvmetcli'
Apr  8 12:31:34 localhost abrt-server[2199]: Deleting problem
directory Python3-2025-04-08-12:31:34-2198 (dup of
Python3-2025-04-08-12:17:05-2084)
Apr  8 12:31:34 localhost systemd[1]: Started
dbus-:1.3-org.freedesktop.problems@2.service.
Apr  8 12:31:34 localhost audit[1]: SERVICE_START pid=1 uid=0
auid=4294967295 ses=4294967295 subj=kernel
msg='unit=dbus-:1.3-org.freedesktop.problems@2 comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
Apr  8 12:31:34 localhost abrt-notification[2211]: Process 2084
(nvmetcli) of user 0 encountered an uncaught
"%s/subsystems/%s" % (self._path, nqn)) exception

Anton

--0000000000003c545006324229b5
Content-Type: application/octet-stream; name=nvme_fc_1_link
Content-Disposition: attachment; filename=nvme_fc_1_link
Content-Transfer-Encoding: base64
Content-ID: <f_m98dq09x0>
X-Attachment-Id: f_m98dq09x0

ewogICJob3N0cyI6IFsKICAgIHsKICAgICAgIm5xbiI6ICJob3N0bnFuIgogICAgfQogIF0sCiAg
InBvcnRzIjogWwogICAgewogICAgICAiYWRkciI6IHsKICAgICAgICAiYWRyZmFtIjogImZjIiwK
ICAgICAgICAidHJhZGRyIjogIm5uLTB4NTE0MDJlYzAxNDg2NWY1Nzpwbi0weDUxNDAyZWMwMTQ4
NjVmNTYiLAogICAgICAgICJ0cmVxIjogIm5vdCBzcGVjaWZpZWQiLAogICAgICAgICJ0cnN2Y2lk
IjogIm5vbmUiLAogICAgICAgICJ0cnR5cGUiOiAiZmMiCiAgICAgIH0sCiAgICAgICJwb3J0aWQi
OiAxLAogICAgICAicmVmZXJyYWxzIjogW10sCiAgICAgICJzdWJzeXN0ZW1zIjogWwogICAgICAg
ICJ0ZXN0bnFuIgogICAgICBdCiAgICB9CiAgXSwKICAic3Vic3lzdGVtcyI6IFsKICAgIHsKICAg
ICAgImFsbG93ZWRfaG9zdHMiOiBbXSwKICAgICAgImF0dHIiOiB7CiAgICAgICAgImFsbG93X2Fu
eV9ob3N0IjogIjEiCiAgICAgIH0sCiAgICAgICJuYW1lc3BhY2VzIjogWwogICAgICAgIHsKICAg
ICAgICAgICJkZXZpY2UiOiB7CiAgICAgICAgICAgICJuZ3VpZCI6ICIiLAogICAgICAgICAgICAi
cGF0aCI6ICIvZGV2L252bWUwbjEiCiAgICAgICAgICB9LAogICAgICAgICAgImVuYWJsZSI6IDEs
CiAgICAgICAgICAibnNpZCI6IDEKICAgICAgICB9CiAgICAgIF0sCiAgICAgICJucW4iOiAidGVz
dG5xbiIKICAgIH0KICBdCn0K
--0000000000003c545006324229b5--

