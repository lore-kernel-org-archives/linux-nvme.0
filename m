Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C05FC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED21520885
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lBzYZgvU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ma0S5xA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED21520885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HuKYibjYx1GrjWbaEONlY3g3YoVeF1gvcog1xU1AX0Q=; b=lBzYZgvUOWOSLm7DXRThBcETI4
	XfVVUaUN+96puRsjfafY24bOvdcgjfAV5UhWYWNU/TTgNeuzCybZBl9zhxDOcl38h+qHEZoJ/IYll
	x4DgWDXqPiknXa8+RB2qa4D3YIiPITOBvrnGjb+KgQQw2H7llmB49LOtR5Y0DS+aKdXDF27RD9etR
	AxuXmGiBcU8zMRM9wdycq05MPS19l08WRob4aJQLHvYmPLu4KIphQudEkaIo9d9PJKB+eRaTcShov
	jwuHbPxCJTr7jMO3Htz7vRrgt+2Fe+T7KoaBHzzhNedvEvSK7rDGfUvNImDlvM8SZU7bJvLd5agof
	4AIZ1EOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cwr-0006uS-3x; Mon, 10 Aug 2020 18:55:05 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cwn-0006ts-NM
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:55:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085701; x=1628621701;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NwVMfJuJqEcNz18MXoebg54Lc/snAlPy8FqKsfAEgHY=;
 b=Ma0S5xA9l8bizbMH7tPqf+psYfLnOvPdtz4+rak/PT7wEaFMOSljRJHR
 NJgnqUXk6Clui2KvIz2gFupkMrT07e8aA1oPatH9ZH5oL5DPDyp0/BtIf
 zj6MyFAt/qU06DDxt0xl21jJ590wKxeZ15tahSXv/rV2t8R36X54yN7G9
 9c8oivEq9N70K1gOd80+SyAtPEtjEYKLPxigo+5yi/Oyg9uqedoEGQNDX
 wkg/Akj61n3MCMgPczXVgxq+niqnX1dyfkYRT78UwJCtOW89NYxTU0wqA
 4LlBJG6MdgZiwx3rCsSaCgVwKO/se/ea1f3eEOOysGmBOQnDA0oISR9BE w==;
IronPort-SDR: PWO27m1+S0cM4I4uh+PYP4MoDcLw2IniVly2i7KT7B09wBkFaGxdIHoOYc5Rw3fgptlBN8TLMO
 ikDg5Yc1jMOb3oCDIM3pDoxes8Z2I7O/dv6By1/6V1wHa4Rja7qNbOLw+8RBWmzK7btIEi/8p2
 yteZBkiXormUflrPhmt819+rJIb0Q0UzR/KzROf04wXHN3yS0AH63/TIf47IDL4vLNueD/cSwN
 ASH1tcffioZI404ZJnuDPtOQKW0vY1QIH64xGyfbaIU3JFl6ywZyvpVPT60ZYsRBBRq766RHzJ
 +pU=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="253987831"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:54:59 +0800
IronPort-SDR: m60IhrJesMj+BWJnMZF1hZt6U4GqDStti468U0/PD6ughpFaCR1G0Ttxu31kDXSSilPPb2Bo2I
 pi1bCpZePO2g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:42:53 -0700
IronPort-SDR: i1+d0RA/Mv3ljITOgdKihENXoCZHW3LZjPU8O3GCSnzUDEQxv5yFT//SYEFeCFEAjQfkKGPlET
 Yu9Z69EDwC6Q==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:54:59 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 00/14] nvmet: passthru few fixes and improvements
Date: Mon, 10 Aug 2020 11:54:42 -0700
Message-Id: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145502_003597_06FA1A84 
X-CRM114-Status: GOOD (  11.49  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksCgpPdmVyIHRoZSB3ZWVrZW5kIHdoaWxlIHRlc3RpbmcgSSBmb3VuZCBmZXcgZml4ZXMgYW5k
IGltcHJvdmVtZW50cyBvdmVyCnBhc3N0aHJ1LiBGb2xsb3dpbmcgaXMgdGhlIHBhdGNoIGRpc3Ry
aWJ1dGlvbjotCgoqIFBBVENIIDEtNyBBZGRzIGFubm90YXRpb25zLCBmaXhlcyB0eXBlIG1pc21h
dGNoLCB0cmltIGRvd25zIHRoZSBjb2RlICYKwqAgwqAgwqAgwqAgwqAgwqAgdXNlcyBudm1ldF9w
YXNzdGhydV9yZXFfZG9uZSgpIGluc3RlYWQgb2YgZHVwbGljYXRpbmcgdGhlIArCoCDCoCDCoCDC
oCDCoCDCoCBmdW5jdGlvbi4gTm8gZnVuY3Rpb25hbGl0eSBjaGFuZ2UuCgoqIFBhdGNoIDgtOSBV
cGRhdGVzIHRoZSBmbGFncyBzZXR0aW5nIGZvciB3cml0ZSBjb21tYW5kcyBpbiBmYXN0IHBhdGgu
CgoqIFBBVENIIDEwLTExIEZpeGVzIHRoZSBtb2R1bGUgcmVmIGNvdW50IE9vcHMgaW4gbG9hZC11
bmxvYWQgc2VxdWVuY2UuIAoKKiBQQVRDSCAxMi0xMyBUcmltcyBkb3duIHRoZSBiaW8gcmVxIGFw
cGVuZCBuIHRoZSBjb250ZXh0IG9mIHBhc3N0aHJ1IGluCsKgIMKgIMKgIMKgIMKgIMKgIMKgIGZh
c3QgcGF0aC4gTm8gZnVuY3Rpb25hbGl0eSBjaGFuZ2UsIHBlcmYgbnVtYmVycyBkb2VzIHNob3cK
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaW1wcm92ZW1lbnQuCgoqIFBBVENIIDE0IEF2b2lkcyBhbiBh
bGxvY2F0aW9uIGFuZCB1c2VzIGFuIGlubGluZS1idmVjLWJpbyBjb21iaW5hdGlvbgrCoCDCoCDC
oCDCoCDCoCDCoGZvciBmYXN0LXBhdGggd2hlbiBwb3NzaWJsZS4gwqAgwqAgwqAKCkkgY2FuIHNl
ZSBudm1lLTUuOSBhbmQgbnZtZS01LjktcmMgYnJhbmNoLCBJJ3ZlIGdlbmVyYXRlZCB0aGlzIHNl
cmllcyBvbgpudm1lLTUuOSArIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9s
aW51eC1udm1lLzIwMjAtQXVndXN0LzAxODcwOC5odG1sLgoKUmVnYXJkcywKQ2hhaXRhbnlhCgpD
aGFpdGFueWEgS3Vsa2FybmkgKDE0KToKICBudm1ldDogZm9yIHB0IEkvTyBjbWRzIGFubm90YXRl
IHJlcS0+c2dfY250IGxpa2VseQogIG52bWV0OiBmb3IgcHQgSS9PIGNvbW1hbmRzIHVzZSBsaWtl
bHkgZm9yIG5zIGNoZWNrCiAgbnZtZXQ6IHVzZSBjb25zaXN0ZW50IHR5cGUgd2l0aCBpZC0+bmxi
YWYKICBudm1ldDogdXNlIGNvbnNpc3RlbnQgdHlwZSBmb3Igb3BfZmxhZwogIG52bWV0OiBnZXQg
cmlkIG9mIHRoZSBleHRyYSB2YXJpYWJsZQogIG52bWV0OiB1c2UgdW5saWtlbHkgZm9yIHVuY29t
bW9uIGNvbW1hbmRzCiAgbnZtZXQ6IHJldXNlIHB0LXJlcS1kb25lIGZvciBycSBjb21wbGV0aW9u
CiAgbnZtZXQ6IHVzZSBudm1lIHdyaXRlIGNtZCBncm91cCBzZXR0aW5nIG9wX2ZsYWcKICBudm1l
dDogYmFzZWQgb24gcGFzc3RocnUgcmVxIGNvbnRyb2wgdXNlIFJFUV9GVUEKICBudm1ldDogcHJl
cCBwYXRjaCBmb3IgcHQgY3RybCBwdXQgd3JhcHBlcgogIG52bWV0OiBmaXggbnZtZSBtb2R1bGUg
cmVmIGNvdW50IE9vcHMKICBibG9jazogbW92ZSBibGtfcnFfYmlvX3ByZXAoKSB0byBsaW51eC9i
bGstbXEuaAogIG52bWV0OiB1c2UgbWluaW1pemVkIHZlcnNpb24gb2YgYmxrX3JxX2FwcGVuZF9i
aW8KICBudm1ldDogdXNlIGlubGluZSBiaW8gZm9yIHBhc3N0aHJ1IGZhc3QgcGF0aAoKIGJsb2Nr
L2Jsay5oICAgICAgICAgICAgICAgICAgICB8ICAxMiAtLS0tCiBkcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMgICAgICAgfCAgIDUgKysKIGRyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaCAgICB8ICAg
MSArCiBkcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgfCAxMDkgKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tCiBpbmNsdWRlL2xpbnV4L2Jsay1tcS5oICAgICAgICAgfCAgMTIg
KysrKwogNSBmaWxlcyBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkK
Ci0tIAoyLjIyLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
