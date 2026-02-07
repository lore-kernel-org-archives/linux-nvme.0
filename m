Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE99AEE0AE7
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ti3W7CEQr1WQDVZaiO+ddg10VMD3+jvwb8xoErsA9Iw=; b=Lbs8pFfW46IA75MGvmrmalQYzF
	DEDf++C9ywk3DwAjlcRM1kxkdg73iaQruZ8QYgNCOwq5ykomvKm/1Kxd0IiSSjG7wTgP1V3Hi7R3R
	NzDY6w6g7Xi4Q0OZMJHysvNYzW8wlU5XIl0UzD7Sqnh+Z0IWqQiAzYyanCdpD6Zu0cQWDtDMYJpX+
	ShIoMVEFAAgxIw0o/3R5JXqZTKP68+KXhF2OWIdYL3yo/2oKJQHuHaK8PZ7//lPzk4e6fHWVEmgRF
	Y0hlRIkmRYq8OorcNA1nplYw0cVeCcuODUYzqDunSvDuZRz5UpH3G3BvTpp7i6/ATBcpedplgjQxV
	xEU+0dxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voj46-0000000CWdd-2prw;
	Sat, 07 Feb 2026 14:13:38 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voj44-0000000CWdC-2qZv
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 14:13:37 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so23385405e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 06:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770473615; x=1771078415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti3W7CEQr1WQDVZaiO+ddg10VMD3+jvwb8xoErsA9Iw=;
        b=dwwUwPyS3oBTuBSF98+CQkYLLrkqxoa/tELT83eo8rXlR+nQ/o7TX5wA4LnFL+Cr1c
         75jilakFT5Jy4FPmZKL0O9i3WtYsFwDV+DKZtAV5IE49cbOryfUYkVifW41x4zJ6XKb+
         w5s+guR9wsM57c1UCii4QSZaIywMRRcJynrwV/MshCuEozFBDXOeregaawZUxBucoVzw
         Gsh7HEXi0N2bnPyTRPc/V2ABKFAGl0FHG6gjwtpTqyFVHz8bum45Uf+HDZ3LgWeFfwm6
         ZLeaL/n0rfF+qHDrOZ9ZFA2V712h1CtjnLPyL12FI5R45XtEIkD1OdAeh0YZvSb+ZGGY
         6DUg==
X-Forwarded-Encrypted: i=1; AJvYcCXLgvug7qLHCJLUQlkjfWPBnflL4xd4RxsS2zrKSPO5mLcDeQS63sqIj1bLr+oNRCb4nl8gErXRQBdl@lists.infradead.org
X-Gm-Message-State: AOJu0YxGBrS/pc2h2S59mUMhCqbe0x2EQSVbIngFZteqen6dlITftplL
	ACMjIMzQcdVMKMueZePf/L4dGYN8xrROGZto4ubfit5oug+J2eFzDHJOSmyLFA==
X-Gm-Gg: AZuq6aKf6J+B1svBRqYJVBVhNzKJmMS8/6Yfcp1TlFl4HKstP2Fl/9hw/VSeLkBDv4J
	lCpc/UfkFzLCK6Pl+hJLv1AWDlEn3wy0Yhr4XD/DoosorBT1MCST8BnpS+WKxIs3eCV7OcmYCVY
	eBpxoKvPcuxEddYd0gdbMuMoV/2bIl4eoVTN/eYJwcow9BmfLCeCsrSVDxnLDTUf3ghnwdtzNYa
	FuPHkLUOEVjiqIdP07J/nFvIJ33oZN1oKybTAjPK//vGU1Ap4Bb1UnKpLbceBzuz3e494JmsTp8
	lVLB+XP4AuwCyEhDJ77+tZO9u5CLI2A+bNoyJTK3wIKZbBBZJgxkfEE6Oz+6GIXbpFTu/gjUWpe
	/mp9E5IWA5Hb1HgzP7sG49HzXIlQY/78PmqcjkEwhwDdlVp/ctxalTaOoTOC0TY1453HK3oBwtx
	DW1b7dLpfv1wGo4u41cYInYC4XufkO0D/MsLBy1GQXgvA=
X-Received: by 2002:a05:600c:4fc1:b0:483:ea6:8767 with SMTP id 5b1f17b1804b1-48320228160mr95459525e9.36.1770473614737;
        Sat, 07 Feb 2026 06:13:34 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320978108sm62350935e9.7.2026.02.07.06.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 06:13:34 -0800 (PST)
Message-ID: <d6dc22d9-0e1d-4df3-92ca-b0c50d7202a5@grimberg.me>
Date: Sat, 7 Feb 2026 16:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] nvme: Rapid Path Failure Recovery read
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-7-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260130223531.2478849-7-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_061336_722852_60765F54 
X-CRM114-Status: UNSURE (   4.98  )
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

Aside from splitting CQT to a separate patch set:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

