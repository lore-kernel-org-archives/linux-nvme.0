Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7884FC25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 21:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pvAXrD5Xuq5329QH2fVWZdGIR/UXqDKpLuG/TDCAHWE=; b=iopXfxcIVsXOiyovUjPdbmz0m7
	4pzmv0hubFNH7KN/OpPb0GaJXKAVOMhG04dUUSpIC8nf4tYNN8l+lCzgdtv0k8Bsh8fg1r7gjMTn6
	y6egsM79QdXqEUTV9fVO2Cji/6JabF0hbcEWciJPDfmTjLZGIIiZPD89DcQoJ9IyTH4aagIegFJBn
	UjwpS90vCc3ZnLbbCXWasZb6LeOkFVAC+oucUNTbd0I7NvXZ/MXcQHmcUM4Ex3W8+ujcfXlMIjDAx
	qQQkMjNODSu8Vpwyl0zCE4af46radixQh8vfkobbkllN3P7oPuqPMhjpMAFV5yyFhMZrynbtNmGY5
	1Dp1//Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9tXn-000000049nl-2u7f;
	Wed, 22 May 2024 21:30:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9tXg-000000049nC-2Zc9
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 21:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716413434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pvAXrD5Xuq5329QH2fVWZdGIR/UXqDKpLuG/TDCAHWE=;
	b=LVoN9U60aWtjcnfOO4XVnJ/OGfF2HblNjy38cl+yBrqx88UnuKU6n9mHkHeWlalgE8eWZ4
	r9jp/kdvysq2RzeS0y5h/hd4sk5uoY8DhLFMBpUMk2xrOw0siQ2ISSuckeMPKtEV4vu/r0
	aEPfnlI+2XmgkOOYSeJoWivEVtBCJqw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-atTcrWgPNmSyH-dkSknOMA-1; Wed, 22 May 2024 17:28:49 -0400
X-MC-Unique: atTcrWgPNmSyH-dkSknOMA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4200e6a9901so72279675e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 14:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716413327; x=1717018127;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvAXrD5Xuq5329QH2fVWZdGIR/UXqDKpLuG/TDCAHWE=;
        b=AWBVPYBpKUuUo9qaNvfJhiu4KnammWI0aXEqwb47LrFMoX1216zjYS8spmJv2dtHgP
         1TgXvXmb+vobH9h4FdMWHSVF5lBg3xnj2SnTkaU4H+fQUdJs+HWl2hJ/Hh4NuUUjAAaD
         wbhLmEvEWnAA21dr5fCEkzG1UYB3Rgqiub1j0q3fZjwPDmVnRDi0T16w9NBMCuxyxJqW
         djYnp7CUMu35RirDzM2CxxGrM3yTwK2m9dhBxZHj/UOLUvqa9H2oMFyay78ggpDsOHtb
         VTYiGMdloSYdZ4MO8sFvesorLSuAB2pFJWCpcATwcjRMZg+6kDomRmgGFWuWq0znACrA
         86sA==
X-Gm-Message-State: AOJu0Yxyu0TOPvXxkPYK68Dz8fEBDQ4qA2QmuPv2VdlRIpbmmD5nfUbV
	MWqUNtMd35SlHCn14/PHLOI9IDZyW+mqFUciefg4hPSe3Psa1A236bDTsMpPe9b4zDbEACBqI1T
	UJjzp+1+YzQxRTBTunhQAYZ5ks35kA4EYFTxlavupvvlz9Lw41WZTaAf9aEN1pVqjHfdd0w/5H3
	YldpHZwRhfD4X0dSJ440H4gTmZ5624AkGM+niYbP2iecrSWr4gcw==
X-Received: by 2002:a05:600c:5353:b0:41a:c92:d323 with SMTP id 5b1f17b1804b1-420fd312f35mr25585645e9.10.1716413327421;
        Wed, 22 May 2024 14:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+9AJT1PSq6tBPo5dbbUZnD9TZ0m+QJHgdwLGFnCV3uruKinfXCE6iR4KSq8jZJsK2kap6TLgWQMkN1eiEem8=
X-Received: by 2002:a05:600c:5353:b0:41a:c92:d323 with SMTP id
 5b1f17b1804b1-420fd312f35mr25585545e9.10.1716413327094; Wed, 22 May 2024
 14:28:47 -0700 (PDT)
MIME-Version: 1.0
From: Bryan Gurney <bgurney@redhat.com>
Date: Wed, 22 May 2024 17:28:36 -0400
Message-ID: <CAHhmqcRZ3daguYurdiQweB-=3pCHDxzRyekU7PW8fz1FSc1AJA@mail.gmail.com>
Subject: systemd pull request submitted for removing obsolete udev by-id
 symlink rules
To: linux-nvme <linux-nvme@lists.infradead.org>
Cc: kbusch@kernel.org, hare@kernel.org, John Meneghini <jmeneghi@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_143036_818885_EFC4B40B 
X-CRM114-Status: GOOD (  11.89  )
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

Hello,

I posted a pull request to the upstream systemd repository to remove
the udev rule in rules.d/60-persistent-storage.rules that would create
a symlink that would switch between the namespaces of a
multiple-namespace drive (as I demonstrated at LSF/MM/BPF 2024 last
week).

The URL to the pull request is here:

https://github.com/systemd/systemd/pull/32981

Ultimately, the commit in the pull request removes two rules, in six lines:

(Apologies ahead of time if my email client mangles the diff, but it
should be intact in the pull request to systemd:)

diff --git a/rules.d/60-persistent-storage.rules.in
b/rules.d/60-persistent-storage.rules.in
index 390c6e0034..b9933e5753 100644
--- a/rules.d/60-persistent-storage.rules.in
+++ b/rules.d/60-persistent-storage.rules.in
@@ -43,12 +43,6 @@ ATTRS{nsid}=="?*",         ENV{ID_NSID}="$attr{nsid}"

 ENV{ID_WWN}=="?*", SYMLINK+="disk/by-id/nvme-$env
{ID_WWN}$env{.PART_SUFFIX}"

-# obsolete symlink with non-escaped characters, kept for backward compatibility
-ENV{ID_MODEL}=="?*", ENV{ID_SERIAL_SHORT}=="?*",
ENV{ID_MODEL}!="*/*", ENV{ID_SERIAL_SHORT}!="*/*", \
-  ENV{ID_SERIAL}="$env{ID_MODEL}_$env{ID_SERIAL_SHORT}",
SYMLINK+="disk/by-id/nvme-$env{ID_SERIAL}$env{.PART_SUFFIX}"
-# obsolete symlink that might get overridden on adding a new nvme
controller, kept for backward compatibility
-ENV{ID_MODEL}=="?*", ENV{ID_SERIAL_SHORT}=="?*",
OPTIONS="string_escape=replace", \
-  ENV{ID_SERIAL}="$env{ID_MODEL}_$env{ID_SERIAL_SHORT}",
SYMLINK+="disk/by-id/nvme-$env{ID_SERIAL}$env{.PART_SUFFIX}"
 ENV{ID_MODEL}=="?*", ENV{ID_SERIAL_SHORT}=="?*", ENV{ID_NSID}=="?*",
OPTIONS="string_escape=replace", \
   ENV{ID_SERIAL}="$env{ID_MODEL}_$env{ID_SERIAL_SHORT}_$env{ID_NSID}",
SYMLINK+="disk/by-id/nvme-$env{ID_SERIAL}$env{.PART_SUFFIX}"


After removing those lines in my test system, I no longer see the
symlink with the "nvme-MODEL_SERIAL" name repoint to the different
multiple namespaces on the test drive.  (The "nvme-MODEL_SERIAL_1",
"..._2" symlinks still exist, and are pointing to the correct
namespaces.)

Please let me know if this looks good, or if there's other testing or
changes I need to perform.


Thanks,

Bryan Gurney
Senior Software Engineer
Red Hat


