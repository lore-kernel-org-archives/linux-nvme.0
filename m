Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31104606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yXXXvmFd;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RuHa0f6Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R+abyQo41ZdWflNXh8YnFNAO4pyEP29Qet8y18IA8to=; b=yXXXvmFddmvnvRkdzo2HqfhBF7
	l3T3N77KWmtWprTKWbUkK53zRbRzv0vMV42Y0kkJPZelSxOQnNZ0NawFOqGExMMilcua07fRfYyEv
	KQS9P/EQl4k0uh+NovfyGn/OOL81ceNq58dDk0yyhMZLFgcctlagvq3cLlLVSZtjIRVz+aTE6wNnI
	0Q41Ksi9qkfOZwqWMxigqt+7VrKEbkKYufvUFnE4NLwTST8BSQkynKu3wnQHjd8HKXJLjMq51meYs
	AyLCwXfgw2HIzOyEV3T6JcJA1KjQjxM+f2j3aSnJqJiL4ZrTnhxREgq6r7KMn+nf4XStCGeRsgVMi
	n+CMgCTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKBuc-0000000G56x-0QUK;
	Fri, 23 Oct 2026 09:50:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKBuV-0000000G550-25fc
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 09:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792749001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+abyQo41ZdWflNXh8YnFNAO4pyEP29Qet8y18IA8to=;
	b=RuHa0f6YscRMz9QyCPlAbzj2llCjuRTijOQLKd3CGeaSw13KYxfb6V8GBI7MAE9mR/nMqu
	akElp3ZGIh3XnXnm2PsFSoXoDe8Y5GjnCNiqWar60YyxVou62hyAQoH7NWZS1zWyA7FfZA
	qG91tn/uw+bdrUH7suTytrTI/6jfa58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-xov4jm2_NlOMeiQiCP0O5g-1; Fri,
 23 Oct 2026 05:48:15 -0400
X-MC-Unique: xov4jm2_NlOMeiQiCP0O5g-1
X-Mimecast-MFC-AGG-ID: xov4jm2_NlOMeiQiCP0O5g_1792748894
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DE171955EBA;
	Fri, 23 Oct 2026 09:48:13 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B763818002B6;
	Fri, 23 Oct 2026 09:48:10 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	axboe@kernel.dk,
	hch@lst.de,
	dwagner@suse.de
Subject: [PATCH 1/2] nvme-pci: fix early boot hang with nvme.quirks parameter
Date: Fri, 23 Oct 2026 11:48:05 +0200
Message-ID: <20261023094806.944563-2-mlombard@redhat.com>
In-Reply-To: <20261023094806.944563-1-mlombard@redhat.com>
References: <20261023094806.944563-1-mlombard@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IZ2ZZH2egY2Cl9IQX_dnxs-WVVb3ahUvKWJfvbhp1lE_1792748894
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_025003_614541_5DA02B25 
X-CRM114-Status: GOOD (  13.55  )
X-Spam-Score: 0.5 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Passing nvme.quirks on the kernel command line causes a silent boot
hang when the NVMe driver is compiled as a built-in module.

This happens because the parameter is currently registered using
module_param_cb(). For built-in modules, this macro flags the parameter
to be evaluated at initcall level -1. Consequently, quirks_param_set() is
called before the memory allocators are initialized.

Fix this by replacing module_param_cb() with device_param_cb(). This
defers the parameter parsing to initcall level 6, guaranteeing that
the system memory allocators are fully functional before the quirk
string is parsed and allocated.

Fixes: 7bb8c40f5ad8 ("nvme: add support for dynamic quirk configuration via module parameter")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..6699c7da4b5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -243,7 +243,7 @@ static struct kparam_string quirks_param_string = {
 	.string = quirks_param,
 };
 
-module_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0444);
+device_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0444);
 MODULE_PARM_DESC(quirks, "Enable/disable NVMe quirks by specifying "
 						"quirks=VID:DID:quirk_names");
 
-- 
2.56.0


