Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F023FCF6BE3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TR7W5r/PbAp95cVqq4bTecJLCOuOBBQ7DvJmY0gVsC0=; b=W1ZZbZrk1neQNORD9jfavJvSpB
	7l2gQK7Otp5KT1yRXeSOv0pSAi3E2tUIih3M34mQtsnSUHIv1PsDhxiBXs0TO78EemAMaWmW3y+tx
	zo2xX4jVgzvU6xa6iofh6UkozSos2+/6rtw2xG/Rx7W6GG0cKwvI4vi0439d9TcXdQNYVD6iysjvR
	MXOF4Zh0JAS6URgfDN/Ls6FaxzM+9nlJtWcmMf2gHz/gSEwge+jBMmYKvqoUejYo5TXW8k1Op4oLF
	GTuuwB+VLG1vCJOsxaQSnuX24IxfGarbC/C7hVbdlRw3ppNAAIqc8/xfkMeRXUKkVaIHanSRUPyOx
	YHYxadNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdIVl-0000000E1IQ-2D1v;
	Wed, 07 Jan 2026 01:38:57 +0000
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdIVi-0000000E1Hi-2Y8A
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 01:38:55 +0000
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-2ae38f81be1so1018796eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 17:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767749933; x=1768354733; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TR7W5r/PbAp95cVqq4bTecJLCOuOBBQ7DvJmY0gVsC0=;
        b=Ib5HaPzSsxBeeCP/BR3v4hdFPnrMvvWLjcUZdHYxXyS7KdzRTkD+PQSluv6gTwdFIu
         T+JQGTxiQliJ+1nZJQm+qaGpERx0IuUKigl9nHPGuaR3qIGjggL5Mt2wXzqT13wrlW0m
         X8NevYmve+3U2a1i28mdBz59fHa2gENXR/qqXPMDkqd2xrkcCPnkDARzUKjPHWiqizVS
         Qxc85i8wPsrzB74oaLHfm9XBWpCtjPPYAT3RI32IOk1LcUGyBm4d4+JOHr/sWxfgblWM
         88F1fErUJO8n1eHWUSsppMH/I2ONZkIWyJpAH8LH+2O/LEJ1IXZ3cqBABJMW2TNWjeMW
         9wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767749933; x=1768354733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TR7W5r/PbAp95cVqq4bTecJLCOuOBBQ7DvJmY0gVsC0=;
        b=MUAZ9kTxnSf8SolsoysiNtQ+PuhSLzjrc5tScKOiALNE96l+YZ3cxNfKldWMFNZoMm
         NM8tBGWj+MAmD5ROu92FuMvoo//6CttKw3VTFgo826quSqyqrO/Am1Ojpkyi7Ob399p0
         FmfXyATND/iRpEOhJzhr4dyFo+V7djS/DP7JmH39UaxsnmKDlVxws+a+S4MDpN1GAqDz
         X2LxlLRCVrZ9m/1UfJPNIt6I/2WVuxynVzJfByT0f9DGqkKrxUWsUtjTBj6ajxOQk9Gv
         0fhuM5fIGJs66vYMWxR1b7Z3zrjP28jBY6s5fo15UXskZtvXfI7bn2lp/hAy+4J9Jx1D
         USow==
X-Forwarded-Encrypted: i=1; AJvYcCXH9IfwN4zP6IjiDd2dX/Z65++NOX61pKATMb6jMh/+D5jy6wiQmbCViXKYT7AeS/baqlkwK65qGIqr@lists.infradead.org
X-Gm-Message-State: AOJu0Yxb7zb4dvbC9kkFsFo9+rZ1NYpfqn7xqvJsDFB1PrLVJamOW2B+
	6sIP0NH+Rojwutu6Ng68Rtu+ga9RaQ2RYURuuxG+UOLL/R2/CvTEQ7Ke
X-Gm-Gg: AY/fxX6JrE9l4l4SdKtnHH9tULqb3poEJey5npeLwoX647AuSwef8YoWsmRp4Yu8i1V
	ddiqk33DgrDFGHgFZPAZjcEd5Hm1nv5KNOW+v0RyuOof4T1ZPTGKVIRFOWer5pydSm4089GxyIy
	13uCxKup3j+BLCDY1cOORZQeR7ALBZ5iMg522qi2LHtHEuQ795wDRwXzw1YSuFw9hcPkDJb9FtS
	+qjaHgkB9YYwadyoFCho4CrYySaqEWn/GOQp9+xRxKgipqsdx1KQNDWdV88mgcn6Esrvud2cDf2
	KIAVlvTqw/nWyKxvd8EvcaWbkSoQAD7yur5NNcOZJLDDVu8NUa3hIJ/CDNJga32cPQfmCU1Xuin
	xAy3+fkUHSdRqZlN8KCKV6d/E1S3xDGrvp2Rm/p54ahhXGvm6/9U/PA+WqDuLBUzDgY8Gy9xH0Q
	A1HMil7byj5/PDY+yC432Jl6IYWey/wySBntmy9Sc=
X-Google-Smtp-Source: AGHT+IELfXr93RmAVEj9LLE7yGCjveWF6ss99k6WQLqwMYHXJ1aat3XiEBy89meyczf2HB9sDxhsFw==
X-Received: by 2002:a05:7301:1c0f:b0:2af:fbb:97d6 with SMTP id 5a478bee46e88-2b17d2e7a1dmr641520eec.42.1767749933090;
        Tue, 06 Jan 2026 17:38:53 -0800 (PST)
Received: from [10.69.79.61] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53cdsm5516546eec.11.2026.01.06.17.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 17:38:52 -0800 (PST)
Message-ID: <cddd1db8-3da7-44a5-bcf9-210267c30625@gmail.com>
Date: Tue, 6 Jan 2026 17:37:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset
 if init fails
To: "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "justin.tee@broadcom.com" <justin.tee@broadcom.com>,
 "nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
 "paul.ely@broadcom.com" <paul.ely@broadcom.com>
References: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
 <ccf8741c-35f0-49bc-90dd-314085f1dbb0@nvidia.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <ccf8741c-35f0-49bc-90dd-314085f1dbb0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_173854_650096_1429FFF5 
X-CRM114-Status: UNSURE (   4.89  )
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

Hi Yi,

Was there a specific nvme/fc blktest case that triggered this call 
trace?  Or, was this observed after stress running all nvme/fc blktests 
in a loop?

Regards,
Justin Tee


