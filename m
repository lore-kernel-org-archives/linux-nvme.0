Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC33CA5FA2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EdVeXkgV9pi4EO1zLlRvey2I1xuy1Dyo+nGExdr17w8=; b=xGd4EGsl+7bTinQmV/wzTlYCt+
	x7jyGFR/6+0gK5fNxtEXEjEXzghTD8JyY9txFE6P5Gv6BXvDI/bPVQRBYrwamF3pnISjvlowneyjX
	FOJT2cdxXYmMoL+FqlG/KbMt0vo+0TWbIt5SfDRX1YAlHpvvf/ko6IjphBWJWRkKUJbhuWpsip2xN
	C6YTFn6R1kJPoxO+rY+p2dTUVJ01+yShWnCTT7ehrR4FhbC3Y88yE6wrTAHfYb/r7vKcq3fkXTFx2
	JN8LZife+rQI228jUyXwPf80KUAm17BSI1eRUaM7TlS4wsT7xno/gw9lKzlnQ8kjYhlEmCIh9j8Yb
	4C+hBVkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBGYN-00000001NjF-1Cy4;
	Mon, 28 Sep 2026 18:58:19 +0000
Received: from mail-qk2-x11.google.com ([2607:f8b0:4864:34::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBGYL-00000001Nip-1hmq
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 18:58:18 +0000
Received: by mail-qk2-x11.google.com with SMTP id d75a77b69052e-530fa0716f6so37782101cf.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 11:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621895; cv=none;
        d=google.com; s=arc-20260327;
        b=M16WXgzfMf7f4dZpIeLiPE584dzSlJ1DFN1+hc0MQOvBDt+lBmUm4gFCrc5e/jpSnz
         lmpmscZvHBCX7UfUrjpXMQResiUnQj8rzzGUdAavOXS+egY9agQgIQxRY3qGattK/4JB
         EKtcst8DRWz/qxiRrn+xJPXLA7ngCyEXu86ISgKxUFVZsvjMXzxHpJDFNbbD1zfq1bOg
         KzBwg3ZmoUFZUjzg41ETOMkMBIoEZHxGok/7DlRPDwAkrp8LqjJYQBARgOYfmZ6XF3GQ
         JcQcPmPCfkb06xm8J+zRz0ELvji7fLdpCl9SNqeljFrY1HJBVGLLm2n0MVrmMUxTWG80
         qhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EdVeXkgV9pi4EO1zLlRvey2I1xuy1Dyo+nGExdr17w8=;
        fh=4j9/EojBARSGfxVk7K2oX+hjwCvNMAwobNkVL4pfUcg=;
        b=d50w+6ZKHotAxf3wNOxU8b7CxXevUU3Ocam8HmEAVpqt3B7SRBl0lbjRCgEOvuSDa5
         Ro6UlOp9tmq8bsMyPIwa7F2YmogEXbrUlETVdGcPLBUADCh0iqFr//EG8wN/Fcm+Y1O7
         j0O3sTQancMibmcRlTkrpeA+7n3mjIeJofmqiBPG4Sz8mLXQuey6SXqXOa+ihekBb9wK
         hlYmyRHmeGGVp1iHMIegrjcwgIqlPElRtCAmfulbsCCKw6rDST15zCgK7mHv23mvj18A
         Qhh2zhbJ2Q9QMsynoDx+50/7MlcrYS0JVpAxL+ikrBGUvCt/cmzISc2M6Y871d+T1sSy
         kCsA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621895; x=1791226695; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EdVeXkgV9pi4EO1zLlRvey2I1xuy1Dyo+nGExdr17w8=;
        b=Q+L8F2sGF/ttNEgpkMfrfZItb1nIKkXx9UaWYokjR7ABPICbPCsupycdc19ZSDWJpS
         r0Z4VNNadQi2n1ZrEXRJHrgTig0CTUkqDnW4sNSv+yPTH5eBAy93tcV59VFTFaAvqcZL
         CeJSCQJlYBlw9GeFRykw/W/qPxYM/fF3RJcBl6XmEW6kS7vO79y9QYOlE7JslLUOnCDG
         NQCbquOk/tcQMUiYJW6X2hXf2HI7Mak0EGIbAAxESqy+D8vED78d0c9qydVXMEH125LD
         LmbgUV3PVzUzy3ep14O0IQWiSLE4r4+9264xpCmTL8euMz0cigtRzjUVYwrJDb9A85L7
         s49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621895; x=1791226695;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EdVeXkgV9pi4EO1zLlRvey2I1xuy1Dyo+nGExdr17w8=;
        b=0DecMr1XtMhCnC5V3EzItwyF8YOZQbAh8LhsRTuYcMcYu+gpd6kgLvTESeke9VSpfx
         7TiDy+6uFTfxteUfYHcqT0+wPydnXO1IQbpR1BdmvweTdSkhaE8TgPsVYh6fOUUBnT2A
         U1Mpuht0eNQTGYkCjrvghu4LRMHzH4vlfU10JNg+GdUf9V+CoQR/9qjO7B2yyAw3TcjA
         Vm40WBrz8Hbs5uUz3pC2u+Bw5dpJ3TBuUcAB90GIhppaSomycb+XVT9Y06yb9/YqeyrJ
         d8k3P2+4Qt271JzKGwjXTdtZ5ktF+4b470P9U2fcm5eWWJmYYiYpbXsTfjHvPvbb6mRB
         0U2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzfNM4DUl8vuKnMn0/jzYBNEsYhdx8X7J5j//2ogisUsW7N3938iuZkYAYej9+QfrMhd9iaWP6fjJjE@lists.infradead.org
X-Gm-Message-State: AFuF++lxIBXfrF3ZOeqpXAC88UnLAVS98BR8t+7dO+Pv9B6NykiYV9sA
	m2s6KMSxwcX3Xzi2+Le8aQVEa/3mwv5kz5X2SMC73rGpK+JjZA5Q8u/sZwTufnZ/5MTOmmlY2CD
	kBzeHIB2ZkbwdpW7Vdod3E71W+vd23XQ=
X-Gm-Gg: AYBFou34c5fOFAAHsLqwv5skqvL2XvNrUGFJP27R+2oriIh7ka7dXjxdc6V4uMkj6hE
	0ANwHihRppPuR4jaO+nd+PZztZVFUKT0nXVHkvDxzEK2FYeJkBp91MfILBUNYVKxOo5q+PoH+i0
	gWTqVUrm2ssIIc501Rj+ZEG0lorQEpbLyHqsF+g+qCQQzLFq0pOLA05lSLaASzPg5EWzKzmhpNS
	oUseWBwAlOu239t96BcYmJsWiUUf/6yqsr9tK4ARxAFknIpKd75bwqLcRExVUlf7ItZrv4jvmFC
	X4H2SSShalGegCIHPJPXRT6RnomuX7U+PkJxhtd5b9JSIPnGntaB2yCU
X-Received: by 2002:a05:622a:2615:b0:530:de5f:dba0 with SMTP id
 d75a77b69052e-5330b58b60bmr226374361cf.2.1790621895480; Mon, 28 Sep 2026
 11:58:15 -0700 (PDT)
MIME-Version: 1.0
From: Gustavo Bastidas <gustavobastidas1010@gmail.com>
Date: Mon, 28 Sep 2026 14:57:55 -0500
X-Gm-Features: AclHuK8v69cAbN6Mxv7Gj90kU5NZ6vMy_Cubm_xuaiRD9dC9SDQGP4911uFgLWc
Message-ID: <CAPPWt=30acAVth+nR5kQ5JLuJ=LRTfmSBD2AjntNJgSvcVgkhQ@mail.gmail.com>
Subject: [BUG] VMD: NVMe controller reset fails with "can't derive routing for
 PCI INT A" / "no GSI" - Bug 221996
To: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: bhelgaas@google.com, helgaas@kernel.org, kw@linux.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_115817_454996_7C165756 
X-CRM114-Status: UNSURE (   7.14  )
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

Hi,

I am writing to bring attention to Bugzilla #221996, which was
reported 15 days ago regarding a failure in the VMD / PCI routing for
NVMe on an HP Tiger Lake laptop.

Bugzilla Link: https://bugzilla.kernel.org/show_bug.cgi?id=221996

Summary of the issue:
The NVMe controller reset fails with "can't derive routing for PCI INT
A" / "no GSI", leading to the device being disabled after reset
failure (-19) and causing the filesystem to remount read-only.

System details:
- Laptop: HP Tiger Lake laptop
- Storage: Crucial P2 1TB SSD (CT1000P2SSD8, firmware P2CR033)
- Affected subsystem: PCI (VMD domain 10000:) / NVMe

The Bugzilla report includes all relevant attachments:
1. Complete boot dmesg logs showing the VMD GSI routing failures and
NVMe reset issue.
2. Full 'lspci -vvv' output showing PCI topology under Intel VMD.
3. 'nvme id-ctrl' capability data.

Please let me know if any additional logs or kernel parameter tests
(e.g. pci=...) are needed to debug this issue further.

Thanks,
Gustavo Bastidas

