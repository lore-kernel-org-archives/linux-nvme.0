Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B11C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=j1cQrIbHP0FvdqHCHxmjdtrEvB
	umxOz+OIeEATVE6hqT2WZAik7mdKEAHoWACGFXObQm2rO9soqexiS7DZl2OTbJrLA9egig05TM0wj
	hzoKA4Cl4NkvIfpSPjwxlEWC9IHlp91ZU/w86Q5D3DWjpm/9d1fzH+jRFbRuSsq/90w4/XeAD/tUC
	QapP9RgmK4zBHDrR1PNgNcqtlUKL1rxnIhiEPx8L2oMwpqImpcOd5k7u22+0ArdMrdc7NbFzy++Hd
	NaWpbqEnVJtdyf2p1CDrJ/cEktFiuOsrJcffrCyCPRmb3hy/qrTuWZD5u7Lc4dyi89HBatG9c03Tn
	2AVYdUdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naiWl-009mzR-DL; Sat, 02 Apr 2022 18:31:11 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naiWf-009myU-PQ
 for linux-nvme@lists.infradead.org; Sat, 02 Apr 2022 18:31:10 +0000
Received: by mail-ej1-f44.google.com with SMTP id r13so12154833ejd.5
 for <linux-nvme@lists.infradead.org>; Sat, 02 Apr 2022 11:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=D2UfXZQ7gznnfLfDzgkbHlydY+dQREqUnIEG19ZMq53jJkkBzgIXesgVvQtWU9x1Kk
 DtAk0qCvPpX1pR4Du7qWXEzUjNUBbDIdIRmz9AAqchEphMgWZ9RMbqNiIJ6jnFQ+J2Y3
 tD13b3jCp7WchIAjsSg881G8tzsdCpWbczRlkKZHhzPPmjIldfEh1w2QUt7KeA5a8cZ6
 zSpMpNG02U6CEJOtDIRVv+aRrkW8qK99GZ3teR3TkMaMfxLWuKCOUL04S9o931dFkXU0
 lYu+HGsAVGQViDtpjApmPTmbQPu+nKHjpgZNd/jXOh0psd6uAoFgyRxFIl5nbuPR62sV
 KZNw==
X-Gm-Message-State: AOAM530DNmlJcGSUiiGIaKf97t5X5yXZMlp/Xf8/24kTorfrmI4HrjpX
 GUWokaqweKfsGZ35He18SDQ=
X-Google-Smtp-Source: ABdhPJw2KHq1maylWaEjPp7SzFzrO/3Fjl+D+1nRD4C7N0rehiUOu+/91MSdf9C+7CYV7gN7EKIumA==
X-Received: by 2002:a17:907:9622:b0:6e0:b38b:df18 with SMTP id
 gb34-20020a170907962200b006e0b38bdf18mr4590801ejc.182.1648924258955; 
 Sat, 02 Apr 2022 11:30:58 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 h9-20020aa7c949000000b0041b4d8ae50csm2762005edt.34.2022.04.02.11.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Apr 2022 11:30:58 -0700 (PDT)
Message-ID: <b3a78dd7-acbb-43da-7e0e-0b01f658d30a@grimberg.me>
Date: Sat, 2 Apr 2022 21:30:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH blktests] nvme tests should use nvme_trtype when setting
 up passthru target
Content-Language: en-US
To: Alan Adamson <alan.adamson@oracle.com>, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, osandov@fb.com
References: <20220331214526.95529-1-alan.adamson@oracle.com>
 <20220331214526.95529-2-alan.adamson@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220331214526.95529-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_113105_870291_252B8504 
X-CRM114-Status: UNSURE (   5.97  )
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

