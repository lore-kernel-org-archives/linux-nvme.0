Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB6BCDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rnh2DvV69jH3ySHknTQbT8d2I7YvkXN5HKQ+0zAKMu4=; b=UyzFdYPCJ71DpmTHH3jRg2m85A
	CUEU9nZbFLf//lCBBu3n6NzmUY1yHltcTLeZ9r0/1hXuK1Ige+bZ8QY1iVTMw/0enN7Wja+bIXtl2
	dFSirjR7P+bEf0NMvGAdaRxu7FOXuEsNvLS2ss4Rd0xaxDKjeid3TfLWPFGUYMsoExlvoyImf46yM
	qUvADkhTMEAWr/Id0lrX45zzScJygWxveotm2qLhqw3C7pq9FGnpnJ+NdfV0DzUWuVzwC2+1uldeD
	b1J25i1vL9MUXA+vd2O0Nl9cKgDHxhHseEuicRQdfnNoQwRy0J4vRe00nwfKYcAx+pIfvfbYV4Vmy
	Bn3/sGhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc0Cn-00000006GTo-2c8U;
	Tue, 23 Jun 2026 12:26:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc0Cl-00000006GT8-07kw
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 12:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782217573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rnh2DvV69jH3ySHknTQbT8d2I7YvkXN5HKQ+0zAKMu4=;
	b=eEWY8qrABqUCTlAwXdlOexz/Rr1D3SeGpbfkGU8w/A/qWTR30UJ/4OhAqTgR0L1X7Iyi/K
	5lIfkrUy7cprJJcL46kF49kFFCJUmucI1kTlClUCuYR3i1qZEX9AUYBhYqw2Wl85ueBJen
	qQGso1l5IsCDKe19Qmdss4bZbMkSPds=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-r522sjg6NBeepJk8-n9Vbg-1; Tue, 23 Jun 2026 08:24:43 -0400
X-MC-Unique: r522sjg6NBeepJk8-n9Vbg-1
X-Mimecast-MFC-AGG-ID: r522sjg6NBeepJk8-n9Vbg_1782217482
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c0793772071so691167966b.0
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2026 05:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217482; x=1782822282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnh2DvV69jH3ySHknTQbT8d2I7YvkXN5HKQ+0zAKMu4=;
        b=k94WjrL6ebacNPZ9HslR5THryc95/spGtP7LWlEJGmBlNnTsDPO+Xa0BF4GJ2Sss3W
         fO5Hp5gf2DCzTC8nyHUbZlKHPGA0P9yLKWuGgDLhqTFhb4cnhPU0uIL7/31d1ZUqJsr4
         JZ4kclRWIBSEaYQ6nhAr0UdmofjiLnzujY/o3yIGmP9DI0w/oqXfU4TJRJb/yU48TkpS
         JpsGD/HXSzz/GW4GkOJMKOdwHxnF07pgrMPqAXwNf3xUTUbXIp5P2/+eGU1r+fnps9BO
         HYnoOLWS/LHIhYVIN+I7JGL6uBOz24JsSpQhyemioLoxwL5Kp9zIgcxUgvxWSfInENEK
         JwxA==
X-Gm-Message-State: AOJu0Yy4anndiUYr7nr90RtU6mMGD0VI9JlhJ0DJBzpLUB3kkrMlhTX3
	ydzxBXIP3Z5pN6/9vGlPjP9syMpbg3WCUY6oWqtF613p25yRgoYFCOWjZluTQVyjdF2Hh1+GJIw
	QSfi/yNhfULg+UktH+BoMa9HP1HItLWWM5W+6cCTI5ncR8PyShdE2RyIs1mL2oPSUSzgEnYsojH
	bwYCeef6RqgaIkoBicZo7Y4ylRdloDbiKDcuCDTnk65dYzIqY1qbMmXw==
X-Gm-Gg: AfdE7cn0hpO8uTYgmbbRa7tFA6BmGqodrKJ36F6gjLY5eghkaYNEHaMlWpQp501fFqp
	3FWf9k3M8MWBkG2nprgcqw+V6+NcJCpQ/Vkt4wn5yCuMbEfZA8XLz5j0f2H7eRGXh1qmlkFVZjj
	UbxqEh3QUFVVMMD6TtRApO/s0wlZIapNdxTombW3XlYEygKHKLP5i95FL8zUhbgB43+XDGsDdA6
	75J3dhqWGHfswoGq2yvtUNYDyw=
X-Received: by 2002:a17:906:fe44:b0:bfb:b43a:b084 with SMTP id a640c23a62f3a-c097d1b4d19mr1108731566b.40.1782217482263;
        Tue, 23 Jun 2026 05:24:42 -0700 (PDT)
X-Received: by 2002:a17:906:fe44:b0:bfb:b43a:b084 with SMTP id
 a640c23a62f3a-c097d1b4d19mr1108727666b.40.1782217481659; Tue, 23 Jun 2026
 05:24:41 -0700 (PDT)
MIME-Version: 1.0
From: Tomas Hrnciar <thrnciar@redhat.com>
Date: Tue, 23 Jun 2026 14:24:28 +0200
X-Gm-Features: AVVi8CfndibfFXRKNI91g2JPerA9jpRFl4cbs3fLUmYOjYh691KCx98xiXJVmA4
Message-ID: <CALkDUM9r6NjVuPM15==o04eAGjhw8AeXeQEtQifksU6gd95V3A@mail.gmail.com>
Subject: [PATCH] Drop python2 support and the dependency on python-six
To: linux-nvme@lists.infradead.org
Cc: hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M_UvBxK-9KFblk16C7SrsngxbqdwrltA2rpi2JseJ-Y_1782217482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_052615_140355_9A101965 
X-CRM114-Status: GOOD (  12.96  )
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

Hi,

I'd like to propose a patch which removes support for Python 2 and
drops the dependency on python-six. Python 2 has been EOL since
January 2020 and we are trying to remove python-six from distribution.
This patch drops the remaining six usage.

Thanks,
Tom=C3=A1=C5=A1 Hrn=C4=8Diar
---
 README                 | 3 ---
 nvmet/nvme.py          | 7 +++----
 rpm/nvmetcli.spec.tmpl | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 6ebe666..7df25f1 100644
--- a/README
+++ b/README
@@ -14,9 +14,6 @@ using setup.py.

 Common Package Dependencies and Problems
 -----------------------------------------
-Both python2 and python3 are supported via use of the 'python-six'
-package.
-
 nvmetcli uses the 'pyparsing' package -- running nvmetcli without this
 package may produce hard-to-decipher errors.

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5..4c63eb1 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -23,7 +23,6 @@ import stat
 import uuid
 import json
 from glob import iglob as glob
-from six import iteritems, moves

 DEFAULT_SAVE_FILE =3D '/etc/nvmet/config.json'

@@ -220,7 +219,7 @@ class CFSNode(object):

     def _setup_attrs(self, attr_dict, err_func):
         for group in self.attr_groups:
-            for name, value in iteritems(attr_dict.get(group, {})):
+            for name, value in attr_dict.get(group, {}).items():
                 try:
                     self.set_attr(group, name, value)
                 except CFSError as e:
@@ -556,7 +555,7 @@ class Namespace(CFSNode):
                 raise CFSError("Need NSID for lookup")

             nsids =3D [n.nsid for n in subsystem.namespaces]
-            for index in moves.xrange(1, self.MAX_NSID + 1):
+            for index in range(1, self.MAX_NSID + 1):
                 if index not in nsids:
                     nsid =3D index
                     break
@@ -816,7 +815,7 @@ class ANAGroup(CFSNode):
                 raise CFSError("Need grpid for lookup")

             grpids =3D [n.grpid for n in port.ana_groups]
-            for index in moves.xrange(2, self.MAX_GRPID + 1):
+            for index in range(2, self.MAX_GRPID + 1):
                 if index not in grpids:
                     grpid =3D index
                     break
diff --git a/rpm/nvmetcli.spec.tmpl b/rpm/nvmetcli.spec.tmpl
index f1b5533..ce454a2 100644
--- a/rpm/nvmetcli.spec.tmpl
+++ b/rpm/nvmetcli.spec.tmpl
@@ -9,7 +9,7 @@ Source:         nvmetcli-%{version}.tar.gz
 BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-rpmroot
 BuildArch:      noarch
 BuildRequires:  python-devel python-setuptools systemd-units
-Requires:    python-configshell python-kmod python-six
+Requires:    python-configshell python-kmod
 Requires(post): systemd
 Requires(preun): systemd
 Requires(postun): systemd
--=20
2.53.0


