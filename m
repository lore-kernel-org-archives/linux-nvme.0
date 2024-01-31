Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FD6C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 12:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=E09w431/SHclTHELRhcfHqbWbG
	d1X4Lk3HvfaJ9LgzgypgwOzIyIbSTVLCukAh+3PT6cuKny0DwwgoIRfyoFzQrHnTLQA76rQOpZHLK
	guRTVPCy7mCqxpkn7C/DCmZZzPM55U7aTJKFeiViwl+jwe7kQ+TZUrjEp/VQpXd5TcwrUiPscVR73
	85JOPm+jTvaWW2H7Guvn8MKikM9Skhpv80x75TnmNWWV9dPDrmMtjNIjZczlfA8zpjN5tgVvDRu2L
	w3+2a9KdZbz5B+G7e6r8ZPz23PpDvlx+U+TNIhumcwYJY+lu+U3oiQKMYuONbclIi5DgH71tud+7/
	aTG7W+2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV9wB-00000003PX9-1qZ5;
	Wed, 31 Jan 2024 12:43:31 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV9w8-00000003PVK-3I4S
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 12:43:29 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b0706a35dso78265f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 04:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705007; x=1707309807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=scSqE+YpAj2dyoI+IsS1mRhddA4BAGOtH5KXHqiW7nc/2zyZjPZAC6YBljg6CG1ZGX
         vezFg3CGR6R8uz07ftdVSJdMzT+fuW2M2FOgAMV/sxYD+9dIeTs2Xuv589M/B3H8tUad
         BaH1AR3ixAsnk7zMadrfcF0r2b8P9sQSOQ1xLAPYrPMCGsF5Uwp8u13AjqtoEvynlyFB
         Ozd4aAgjF6NrzVEmP9aglSgKihzY81qUmefElcOdUNAU/YIMhUiCqO/M014Pt3yNk1Rp
         b9Pyzuj8LkOzo+SLnlCU1VuRHMknOuYpV3NHEBbVP/HFJS6A+F+/Vw6BAFsHKCDO6iRs
         aXMA==
X-Gm-Message-State: AOJu0Yy/i4Of1X0X9cR16tvWE21xg2yyKfhwsIeHo6Up+EFgjZlW7r+n
	dRJ8Xe4guz5W5FU2ybgl/oHWczqVVLpdMUQme6TuWOFs97dSWtLq
X-Google-Smtp-Source: AGHT+IFwfA4qb0TBREO28lrjIs0bgdWaJlY6uqduBwDmhEfJmwPEi/lIrMh3W2X4Z9uUPBwvOX8sOA==
X-Received: by 2002:adf:ab19:0:b0:339:44e1:9541 with SMTP id q25-20020adfab19000000b0033944e19541mr1016634wrc.3.1706705007541;
        Wed, 31 Jan 2024 04:43:27 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b0033aedaea1b2sm7893801wrs.30.2024.01.31.04.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:43:27 -0800 (PST)
Message-ID: <c5e0651e-c3f6-4fe5-b9e4-e84ae5490d82@grimberg.me>
Date: Wed, 31 Jan 2024 14:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: allow integrity when PI is not in first bytes
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, martin.petersen@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20240130171206.4845-1-joshi.k@samsung.com>
 <CGME20240130171929epcas5p24f6c25d123d3cd6463cbef1aaf795276@epcas5p2.samsung.com>
 <20240130171206.4845-4-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240130171206.4845-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_044328_836183_9CEAF420 
X-CRM114-Status: UNSURE (   4.93  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

