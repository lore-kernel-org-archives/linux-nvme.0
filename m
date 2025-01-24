Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AF4C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 07:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ubRIZX67/lM4fJq47Ix7ZDPFmL/NfR3tUkrfb3jQI14=; b=MTrK/wYu5o/czcb5gzE7w5lwdj
	J9Py+4fOkwPObycx00FI60ME069Q0+8Y9b24/sUXLVg/LhO22F/d7sPbUb5rhu2xLeXa4Px4weokj
	7TPHtA3KPGpIXRhIXtv+BuRplxxS7JfB+moyF5cC5MBbzihhD+GtRh8i9EsfBbd6AxhURiPM4SZe0
	67IJJpj9zv0LJMlD7SSUS4eB9pyJin48MZdlYhTS7xbMCkXsJD3w6WpAl4LTRNxVPVo57op9w+6LC
	+LuJmk8F8esetUXwosguT7y+c0uymHWw/h6AdauQGKEYb5+ZzMbol0c3x8rzlda/v8feNBpuO3D83
	qGDDYA6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbENk-0000000E9t9-1MuE;
	Fri, 24 Jan 2025 07:45:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbENh-0000000E9sn-3u0A
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 07:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737704731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubRIZX67/lM4fJq47Ix7ZDPFmL/NfR3tUkrfb3jQI14=;
	b=W8fUSYWhW4F9tJHIkJsVSizqfQRaNa9TRw+L0aOp1amyyBHs4MOst2ZoKL8nHTAIRDJHMx
	y2oxHK/iTvaenxi1CWU+hebqyWXrGzdhxKv8s22fB05e4s5yO4pTgAo68LMvTcEG9T8VCn
	4g6njItSbwArhFH195Z5AR5Zsy+Is84=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-EcOv7nACMI6LCHo6Et4LKg-1; Fri, 24 Jan 2025 02:45:30 -0500
X-MC-Unique: EcOv7nACMI6LCHo6Et4LKg-1
X-Mimecast-MFC-AGG-ID: EcOv7nACMI6LCHo6Et4LKg
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8f8b9d43aso34227606d6.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2025 23:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737704729; x=1738309529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubRIZX67/lM4fJq47Ix7ZDPFmL/NfR3tUkrfb3jQI14=;
        b=HwYOLJLL0DplPuwIVmVbZDoMsyyYZVAgHxllz/k+kU/QgDBzBUJ8ONpy0ISkDeB0D0
         cztkSfE2G0NfulxhziAO8hMRJZU6MdOwll04uHaoNXWVE2UkxCDQb7aDJJfPCAsT3gQW
         JThTKLym/me/nH2+scChEGP06Xu80dnN/vmWD5f3PEuniOlWB5ai4c0yU/cDTxcUDZQQ
         7XV9vHXuruDOSWdSASgj3q3rtJdwh/bMQ8ULW1ggSJKKUP+NjuYg+S1iNejsyGbtiCsc
         Q51sDtW0nfcLiLbTqN0QQrPvoIXOV9MfAWXXhLGkFxoFmuS9VrDaTDg2D3Q8KlDGSjNs
         TbQg==
X-Forwarded-Encrypted: i=1; AJvYcCVuW1KHC75R/AmRk/8RHa7L23/7k/Kszqo467Hzhfnq47zznjTmXy24jc5kBeFQwYrfoVHO2BwmgxtC@lists.infradead.org
X-Gm-Message-State: AOJu0YxV5QUgVBoWRRlghxb8FAV1HBGKj0j+crLoAyhivxD8ZK1RpKR5
	MVbfkbI8l5IWabq6BhL4Jw2YCqR1kd474qUdPOCciJm5VW0z9cyxQS4mFYFmvTNIAUEkf3IZhJj
	/WSnL4U1pZDheuB6B7uXRzgWbR7gQVbCHqS7XpNATpcXDjOh5gdh0PMiLQC6OF3udXW6FRGhGUn
	vxT+Svs8gyFRDzfbGM4j+Dma5SmLExVSkfWqm3fyU=
X-Gm-Gg: ASbGncuITeWL/47j7z/x1BSED0gHRcavy6sCndfRuF1VXpRSzKA6Er00TQv35xLE8Nm
	CTYgk8sZFNgkrwiZWfHitmAadU1G+2yNBolePpRGpGVIsXD0qXQm4+A==
X-Received: by 2002:a05:6214:3d87:b0:6d8:b562:efd7 with SMTP id 6a1803df08f44-6e1b2229dc0mr503294616d6.31.1737704729507;
        Thu, 23 Jan 2025 23:45:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmooFr7usjPhHkW8CvArzEgDuQUHGYTX8jxoW15JoOiUvwjN9FlzWB37lwNB9agHtrKRHrpHySg0n8iPh+jAE=
X-Received: by 2002:a05:6214:3d87:b0:6d8:b562:efd7 with SMTP id
 6a1803df08f44-6e1b2229dc0mr503294206d6.31.1737704729098; Thu, 23 Jan 2025
 23:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20250121134540.1280828-1-mlombard@redhat.com> <1a6d4180-8f47-4dab-a31b-32cb2808ba07@grimberg.me>
In-Reply-To: <1a6d4180-8f47-4dab-a31b-32cb2808ba07@grimberg.me>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 24 Jan 2025 08:45:18 +0100
X-Gm-Features: AWEUYZn1nSqyhlYQ8A2kpEZzGptOnTfqe00xBoagkPl7PjOSJLKuerydLKW-L2E
Message-ID: <CAFL455krVnOjTY9BkuRdcH-FfR3p-yX6DoXGskwnH+aF3qE40Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Prevent infinite loop if socket closes during
 CONNECTING state
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org, 
	hare@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SSAZ7weWGrn35HrEEcUGP-gkwEyUHKBWas4L_ORh8ts_1737704729
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_234534_040940_DD15BE71 
X-CRM114-Status: UNSURE (   7.84  )
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

=C4=8Dt 23. 1. 2025 v 23:33 odes=C3=ADlatel Sagi Grimberg <sagi@grimberg.me=
> napsal:
>
>
> Won't nvme_tcp_error_recover() fail to transition the state and exit
> before doing anything?

No, because it's called in nvme_tcp_try_send() when the call to
sock_sendmsg() fails,
so the controller has already transitioned to LIVE state.

I will modify the commit message to make it clearer.

Maurizio


