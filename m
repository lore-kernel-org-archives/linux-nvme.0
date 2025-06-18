Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D34C7115A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jun 2025 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OzPBnj+Em8JJtvfSRSw0lSs8UPtPnNKRwnIhzFAnFrU=; b=vVcEDxSnXN2xdqoML/jmHjyg25
	TOJelurwSoyKa8u9ZPfsHD3i7ZxB9aMoV0EYCQ/mT6hVarID3FQDtvo3w465v3cVHmGMbTLVvAyk1
	FEO9cnyXIn4bGGar1EFPhPaaiT18sy/aHZ1N95ajT3VmZkiChyoKr2IR1O4/6EjLCvRfiDVSDHmLJ
	WWQTLqnFpFA2E7bFv/euou/VzykCE1UEp+xQgYRubvqgSejD5w9RKTcDs1X2+8vpaaPGpY+lY6JQm
	TdJahNefLrjs2PxdKru2JiXWFJD8MB5u4SK4vlMmcEmhzeWJroC4BGJDsjvE+UVXXOhpMEfm0p/+z
	hlFpxtKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRx6j-0000000B0lo-3YIf;
	Wed, 18 Jun 2025 18:01:57 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRuP1-0000000AYCp-1gjy
	for linux-nvme@lists.infradead.org;
	Wed, 18 Jun 2025 15:08:41 +0000
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B82361380400;
	Wed, 18 Jun 2025 11:08:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 18 Jun 2025 11:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1750259315; x=1750345715; bh=OzPBnj+Em8
	JJtvfSRSw0lSs8UPtPnNKRwnIhzFAnFrU=; b=SHf/ckNky8/1jlHCUeh7Zwfcfz
	AKfuG+c6iKqBxT9RSfATeOkeOwWnLMfZ1U8sP+KzIaBJBbNxLkZkb06qyXn5tpZI
	3iopyDt7YEiFu5/UC/v8Naq5J858nHzW1KCjebwcX9y9GhsunySGBsNwsmtuKNqs
	i+DJBB28kXGz53otGwbiLmsfpuyutRENjdgtf+d2qOMcdC9VZ3no6mEvx6/H3V+b
	4SUH77axM4wyRamb7N9GoxW9/Qg2QTVAW4ZStGvzc2TeOCo4PCGP2nt4EHf1B+Pu
	2i/uv5UEBAawALoD4TUmU1eaD4NvYvukocdXPrhEa/K12gHkOYMNJFsYMobA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1750259315; x=1750345715; bh=OzPBnj+Em8JJtvfSRSw0lSs8UPtP
	nNKRwnIhzFAnFrU=; b=DBGey04vxMLe2f4u3ls250tWpg5YCpZtcaWNRdbSlOJz
	pXSl4O6MGKmnM2t20QX2igvftL8eSVcTSIXN2TRFdwBTl1mwYOaKb+fl7H2uJ+gR
	mD/8idQ/VXNUt61K5AunyuRuKG8sGGbZoU/e+ar8OLPo34sLusIeNYGU2lOFfGzM
	eN2HiLPsBBfSCe+JhcpcgyuSlhxvGjKPYCVBZtgRSs/UxeFafhmn5WiDXPFwxzW6
	o0LpyZw9scNmyM48hNhnNjBMjsGOgTfJTjBt/XRMhXQL4A3xMpGNoL07CqU26syn
	P3hTzjZxKw6GUBvldPXEDLaak9RqU232WY0Ol6hw8g==
X-ME-Sender: <xms:c9ZSaNBLDaSrJ2nN4abUjrwfOA6Ey9_VT4Qqpoo4UFCs5AVihiC6pw>
    <xme:c9ZSaLhDfFc2OYThy6D0bBPa3kKx7SXfulmP2QI2HqAwY0Qq9jC6nNqZnZYOlGGYl
    yJmAUujHiCiVyFt5fs>
X-ME-Received: <xmr:c9ZSaIl9wNnLLe_QdAv_zV2-7380JsvojgBGtjxv2Hd3s_k-VE8Tu6e1bR83bCnUHTSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrthmvjhcuvegvphhluceomhgt
    vghplhestggvphhlrdgvuheqnecuggftrfgrthhtvghrnhepleffvddutdekhedvheehue
    dugffghefflefhgeejfedugeevudfhtdffffdujeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgtvghplhestggvphhlrdgvuhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    nhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhgtvg
    hplhestggvphhlrdgvuh
X-ME-Proxy: <xmx:c9ZSaHz17XSVMifAS_NNkxQkUjL6uXSiPIPrzn8bLOwCWr-QNYe4fA>
    <xmx:c9ZSaCSycqZ_ibnknj2uaRMpwQfTpMjQ3ygsaLO41MjnhRAo3wXx8A>
    <xmx:c9ZSaKbN-Nwo8XTbRsNIlN0oiJjuN6kkhfaSPE7iw09WAd3YmOkdQg>
    <xmx:c9ZSaDRFWJopnUtNMvppU01c5S3ignblij-Ca2lpIHLR4-MrXkapxw>
    <xmx:c9ZSaIp_7ttDh5QBHTY9oNe9dutPH-2H-RHha1GyYVjCxKTE4x6buGD->
Feedback-ID: i8c5e488c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 11:08:34 -0400 (EDT)
From: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
To: linux-nvme@lists.infradead.org
Cc: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
Subject: [PATCH] chore: remove use of the Python six package.
Date: Wed, 18 Jun 2025 17:08:11 +0200
Message-ID: <20250618150827.2476858-1-mcepl@cepl.eu>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_080840_067767_487D2653 
X-CRM114-Status: GOOD (  10.34  )
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

Python 2 has been truly and completely dead for over five years,
I don’t know about any Linux distribution which wouldn’t have
Python 3 as its default Python. Please, let it die.
---
 README                 | 3 +--
 nvmet/nvme.py          | 7 +++----
 rpm/nvmetcli.spec.tmpl | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 6ebe666..6a7beb1 100644
--- a/README
+++ b/README
@@ -14,8 +14,7 @@ using setup.py.
 
 Common Package Dependencies and Problems
 -----------------------------------------
-Both python2 and python3 are supported via use of the 'python-six'
-package.
+Python3 is supported.
 
 nvmetcli uses the 'pyparsing' package -- running nvmetcli without this
 package may produce hard-to-decipher errors.
diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5..a2e2b40 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -23,7 +23,6 @@ import stat
 import uuid
 import json
 from glob import iglob as glob
-from six import iteritems, moves
 
 DEFAULT_SAVE_FILE = '/etc/nvmet/config.json'
 
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
 
             nsids = [n.nsid for n in subsystem.namespaces]
-            for index in moves.xrange(1, self.MAX_NSID + 1):
+            for index in xrange(1, self.MAX_NSID + 1):
                 if index not in nsids:
                     nsid = index
                     break
@@ -816,7 +815,7 @@ class ANAGroup(CFSNode):
                 raise CFSError("Need grpid for lookup")
 
             grpids = [n.grpid for n in port.ana_groups]
-            for index in moves.xrange(2, self.MAX_GRPID + 1):
+            for index in xrange(2, self.MAX_GRPID + 1):
                 if index not in grpids:
                     grpid = index
                     break
diff --git a/rpm/nvmetcli.spec.tmpl b/rpm/nvmetcli.spec.tmpl
index f1b5533..ce454a2 100644
--- a/rpm/nvmetcli.spec.tmpl
+++ b/rpm/nvmetcli.spec.tmpl
@@ -9,7 +9,7 @@ Source:         nvmetcli-%{version}.tar.gz
 BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-rpmroot
 BuildArch:      noarch
 BuildRequires:  python-devel python-setuptools systemd-units
-Requires:	python-configshell python-kmod python-six
+Requires:	python-configshell python-kmod
 Requires(post): systemd
 Requires(preun): systemd
 Requires(postun): systemd
-- 
2.49.0


