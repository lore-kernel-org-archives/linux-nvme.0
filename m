Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CFEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uKJt3OIqQjit/So46H/DQProgI0QsOAWMk1NWAvHSxg=; b=iBbdj0CeuPbCxjwSV5ArgMwDrU
	RiusaRYci2XrLsuUQC8uqzBu8oEKaUiDi5PFEPuu7SRSJ1kiGUhI+tPgB/2xdJYGe3NtF6Ijy7Wfq
	+BNbUWkLITj/9erVVnX+Ynabu6WaOmaq5Q/eNySpFmTWReHFU4fH6LcVrEpoCHcSIBChjxiXuTV+i
	1BPEJBOOyY5TWBBtg/RWDBlPperD4MLEb3GKMWkc1e0Pzz4vteLD/QlPP4BMcl7223gOFjO45vKEw
	reVRGZHenudSegwzJ2WfGjOLUDwEQhTNtFC9aKJii3ikTyKbAus1L5ltm+ZDWLVPakgLrbVxmcQFl
	s1JHywHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRd5J-005LCa-GK; Tue, 08 Mar 2022 16:53:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRczQ-005JEe-Hy
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 16:47:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646758030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=uKJt3OIqQjit/So46H/DQProgI0QsOAWMk1NWAvHSxg=;
 b=fG7LxXt2GwIbyCvQx22sFUGCbteGRxbILZYCf2B2h0rwSOYsNeQdmxfY8KMeeQcQi7qecq
 KN3IlnzDZFDh1uYLFGfGqOnnFJzRvHe6jooGgaSydOrZ3fBzWkMA4s3QIcwOF3MO8ZQ07x
 QAlclL3e6EpgEcG7/5QOuOkX2DmfHxA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-LdskJEJBPsihe1aaiSeUkQ-1; Tue, 08 Mar 2022 11:45:33 -0500
X-MC-Unique: LdskJEJBPsihe1aaiSeUkQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 m12-20020a1709062acc00b006cfc98179e2so9003356eje.6
 for <linux-nvme@lists.infradead.org>; Tue, 08 Mar 2022 08:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=uKJt3OIqQjit/So46H/DQProgI0QsOAWMk1NWAvHSxg=;
 b=68mwBBPmrmenqY0TE/ADlfazzT1L+QJh2Aa1pGXRqj16Jsq7d7Ph77+8JoEMaAnlx2
 UuI19SM6P/liQHYl1VWGRnuV/RGI4tRZXLOEotMqGZ4bdgp9JRukXjAIxDIv3AeubCxl
 tKtwz/EcMbT/yTwYpgEyrdIawL40y5Oha85K3IimwnK73D9gDUvjsaW5PIwXVm5NbtZq
 4SHdKXRd+UYVhawuutPyQiAN6WwZ/dixel/0TCgX4grBZgy8r/XgbARnfxcgtt1i95+x
 LL5gax+v1aMRjbYazIXze39wvnNQEqsbizhcu7q4+IZCrfs83k2bf2R95ZUlpffP+Klc
 2FHQ==
X-Gm-Message-State: AOAM530E92L+7CipfQS1fdimclQDllTk+J/509B8UnJECW/IhYJxEqxX
 sy2tzAU98DexScd5KT143AEH1+/e/ySdu48k4YBbhIapSSKtLehqmOCH3GJx6bcGXgOWE/CYNyK
 Zkv0etnjt2Xf25NEHQ9h8R3BhBqy0nVOjBWY5hcUdcso=
X-Received: by 2002:a50:fd0f:0:b0:416:e62:ccec with SMTP id
 i15-20020a50fd0f000000b004160e62ccecmr17019097eds.300.1646757931326; 
 Tue, 08 Mar 2022 08:45:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEAoba6WfULHBE6mVvucV9H66nUGVJ87MK4VhClPS3taL0gLCgWur8FX6sajEZxivPFlA059EkgNdDERev0Ck=
X-Received: by 2002:a50:fd0f:0:b0:416:e62:ccec with SMTP id
 i15-20020a50fd0f000000b004160e62ccecmr17019078eds.300.1646757931051; Tue, 08
 Mar 2022 08:45:31 -0800 (PST)
MIME-Version: 1.0
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 8 Mar 2022 17:45:20 +0100
Message-ID: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
Subject: nvme-host: disk corruptions when issuing IDENTIFY commands via ioctl()
To: linux-nvme@lists.infradead.org
Cc: axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_084712_763077_C9B03895 
X-CRM114-Status: GOOD (  10.74  )
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

I recently received a bug report complaining about disk corruptions when
issuing a NVME_IOCTL_ADMIN_CMD / IDENTIFY ioctl() with cmd.data_len =
8192 bytes and the buffer address not aligned to the page size.

This is the C program that we used to reproduce the issue (tested with
5.17.0-rc6): http://bsdbackstore.it/misc/nvme_ioctl_512.c

simply run it by passing a path to an nvme device:
./nvme_ioctl_512  /dev/nvme0n1

It appears to be very unpredictable. Sometimes I hit disk corruptions
after a few tries, sometimes it takes hours. Sometimes the ioctl()
returns success and sometimes it fails.

We suspect that the root cause is that the nvme-host driver doesn't
enforce the 4096 byte limit for the IDENTIFY commands as the
nvme-target does (see the nvmet_execute_identify() -->
nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE) code).
So if we pass a 8192-byte buffer not aligned to the page size, it will
need 3 pages on archs where page size is 4k and the nvme spec says
that the data buffer may not cross more than one page boundary.

Does it make sense to you? What's your opinion on this?

Thanks,
Maurizio Lombardi


