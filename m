Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE4FC3600B
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A/aAKiiDoI4KPWq6jqFVCdNfYAoyus0vDjRYrE+nZrc=; b=0ERPcuV2qm+5uX4rhluiGynXfZ
	vzDJe+8wNqEs/IDVkH5ti4yqqH7+INB5r02IewW1k0Lw9hFDAJReXrV9WYnwz+wKrm7oKUFtIOoXb
	+mykmgtVsWje3TqwY5SCT6cNNp3q0J9AcAemN65EmcV/Ep2/TuguMtb50bdQ6WDS9HKhfS1p+T7Eu
	/qe7A1oE1KyCeMtSQKu6O1xcKrHnT6IfDBmd0+NipgmspYcZkSNuOOXYzoXobYD+8DsNkQ9LwELEA
	ubLMunc433kRqcS33j1Un/Q89coikh9f55E2XA/Nr/kc9UULI/uKjx7Pyhq+UE8dp6vdLF2smmYoJ
	n5bacang==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twiBq-00000003J7k-3mmy;
	Mon, 24 Mar 2025 13:50:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twiBn-00000003J73-3Ucu
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 13:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=A/aAKiiDoI4KPWq6jqFVCdNfYAoyus0vDjRYrE+nZrc=;
	b=TKYhMSmFG89evOcQv5PLHkpqGouzL9ow8Mn0EGcAOvIUVvJ7Z+WL88ISCmC+tH9COwIAXS
	Y+Ix4041adrSMG81nKB/QuWd7UdcicTvXr+PtXJa2meIC/OjsKVoNPgBcGVKBoOj3DFa+z
	3rk/yLO2aVba1uJfAXowzxhtKpzy7BI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-DuBTH8k0NQK1zTexLpSIiA-1; Mon, 24 Mar 2025 09:48:06 -0400
X-MC-Unique: DuBTH8k0NQK1zTexLpSIiA-1
X-Mimecast-MFC-AGG-ID: DuBTH8k0NQK1zTexLpSIiA_1742824085
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391345e3aa3so2435842f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 06:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824084; x=1743428884;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/aAKiiDoI4KPWq6jqFVCdNfYAoyus0vDjRYrE+nZrc=;
        b=qrdQGynnS6JR5ZbSGShsgpLaEBuQFtPV7Fxz2hrx0ogRplOZCkeyX2JJ7awtdfnj2h
         GjFJp+bzta1ppf4SSF50oS4AfRY1InkluKwZOgSR/Ske4jCE4toOEPJ8PfbGddL1HGm1
         fnDN46eEwMPWUD/vWa44pCh2A/G/a9R0gPJjbWjWcOFQVqnxRgdRnATWScygPpm1erLG
         6/v98vkz//Jtts5Ew1fVIqwU/Yyg+yg1WaTP4HqvI+7ZfZa45dqNd6ErJI9i96vVKhWo
         PMTFtWLYSCPxU1oC988XfCc1sjD1HuTfa35GP0fF0dxdeOlK4YTsZQXPqnUKY9AJFfRr
         fYVg==
X-Forwarded-Encrypted: i=1; AJvYcCUqffCur1xfhQ6MbF3L+T6UhjNoyg/txdP4gO+Yju+FtbORWFKxI8vUefsUyTbCWfDkn9DLmYqPMwd7@lists.infradead.org
X-Gm-Message-State: AOJu0YxgLHO83aWnHYCVu/cTIA+3BbTjI35EApLFz1l3KXz5t5O0JKoN
	qqF3jC1RgcH9JWcCP9FwLcHwySBErUzMk7ZVtJdMKnvpTKmMJYYgyUWBzQp92vv047ciITPKc6w
	ibwFXXOPT93s6mH8sM9iVTa3lB5IF7HqpSfxdntWpQMGgYJ5iKTamwuv7Fk7LbqvtRI4TFTCpkd
	ZkWVwf5pHgbUKCQawPeTVXCKp1qn5kJVH6uOdjU3kRM7MrZj52oQ==
X-Gm-Gg: ASbGncuDq7qDYV1udIfpv95hJUkKirsPAw7U34C33cZu9zW30B6QFWrPnsSwXnbOLzH
	/9ZF1WXnWNod8IrfW8GV4uxpQgZsnS5OJwoC3bSBmDfE6Fgzscwh8MFvdHVfYhVGnv5NM7bI=
X-Received: by 2002:a05:6000:42c2:b0:391:4052:a232 with SMTP id ffacd0b85a97d-3997f9424ffmr7919305f8f.55.1742824084121;
        Mon, 24 Mar 2025 06:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELmeYrq3xhh/MvAJU0DsKNT200sTHglGb+M2l1x5UKQ0C6BUH92XfhfIYAwuqL1uz7Oy0Dlt+DBBx8r+eaC3U=
X-Received: by 2002:a05:6000:42c2:b0:391:4052:a232 with SMTP id
 ffacd0b85a97d-3997f9424ffmr7919285f8f.55.1742824083637; Mon, 24 Mar 2025
 06:48:03 -0700 (PDT)
MIME-Version: 1.0
From: Bryan Gurney <bgurney@redhat.com>
Date: Mon, 24 Mar 2025 09:47:52 -0400
X-Gm-Features: AQ5f1JoBqVa-0uox-IC9RG5pg7cfJZZRLlHTmEe11AnR2_3PiU11j_tTIILiVU4
Message-ID: <CAHhmqcTd3eQRu1tpSbwMO8GTRVnpF=ELkVwA+mORUOmVHMOiKQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] NVMe Persistent Device Names II: Links and Quirks
To: lsf-pc@lists.linux-foundation.org, 
	linux-nvme <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IvOw8JAOhD-4rQ5B19W1GhAfk3kzHbUB119EJIJ5fGw_1742824085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_065003_941670_D411834B 
X-CRM114-Status: UNSURE (   5.95  )
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

(Re-sending to the correct lists, and updating to the correct
presentation title.)

I'm scheduled to present at the LSF/MM/BPF Summit's IO track, on the
topic of device symlinks and quirks (primarily NVMe, but also with a
Serial ATA example).

I will present the progress so far with NVMe udev symlink fixes, as
well as a few issues with upstream NVMe quirks (particularly
BOGUS_NID) that can cause problems for booting existing systems after
kernel upgrades, as well as provisioning existing systems via a known
identifier.

I'll go over a history of identifiers for NVMe solid state drive, and
I will show an example of how LVM was able to handle the "identifier
regression".  From there, I want to discuss next steps, in terms of
how to report NVMe device quirk status to userspace, and how to handle
these regressions in identifiers.


Thanks,

Bryan Gurney
Senior Software Engineer, Platform Storage
Red Hat


