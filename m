Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECD2C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=eF1tUMPQ5km75hzoGlP6DddnK+
	w3NAT6qEwX1uRWLIJnv5Hsi8cZx7bGtV3Im97DdDInNgVmKE760NBkdqIACKsoGZf++z71ueU6+TF
	O9Robl3rpb7bjWoSNM2mQy6AAzH35rab0iuV92qfpCZRgl8WTFzeKQJEyGZbYwzOAwONH8kO082Z5
	UQiDfEnh+3qWHTPf0KKET5JHvUaaS+3aUVObWWdQu24QRmA5ZU7GG1y5bS5Dk2CXoasTVS/A3gXB1
	lUkdM2ymp5TljKbjZuRlbTTSCKtCsYgsbirefSJzFUcfgQSftXhirZ4IjrlTNE3OQvelNyHJYtW03
	TlOKJyZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwPZ-0000000EwJD-1xTh;
	Sun, 23 Aug 2026 00:50:09 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwPX-0000000EwIc-2z6W
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:50:08 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso4054439a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446206; x=1788051006;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rWkm2Ymf0NuE+T9FHPGo//G4kPX/3042Ocykt3jRwLZEqvlGznI1JHqyMW1OBYWa0A
         i1chYs3ASQLqTUOE7+GML81MTERwfZK+Y55vP0TBHe2L8/8MEwn6c5RcRhFKdgiJCMtX
         EscWPj0laPuspsMfZBY0P1ycyLTVZ/vEPUwDF/0cL6E93KGx+iC1i4U04RIguIP/cnXM
         qMEmkpZ5qKIzxzFuFCeL9a17MHW4W3u4qSotHfbP+qvep7CzQJghl4mMNgPaaUARCJyE
         AsRJBgdy6pZi0Ir+beqm+7cOTflUfofE416x74Eq25Rcw5u+V5G69QUhtpyhZR8w0gDn
         /Dww==
X-Forwarded-Encrypted: i=1; AHgh+Ro2a8RUYUNc21VzERur1KjFFHHMXqe9WKkdp4tGHQxcKijA8I+PV4zx2FrFX6ijnKLA2S3GP/mihjVu@lists.infradead.org
X-Gm-Message-State: AFuF++m+zQNaDG0IuVNE8/2GzsXZGGyO+CCgv9tJrZhUy3sbQq5TDA8R
	k9gbHCI9oK0mZHHkP+GEb1+c/n2A85TTSeqK9aNhjqf78nDpLcOuQM2x
X-Gm-Gg: AR+sD11amLZge5LijcpoU1e7fDzVn1r6xQ/oIqiQ3fKD1ijkB6pDDUNN1Cswdbqw6KM
	7N947iQjdmPzZNxlM7usQlb26S/EB/ivvtD7XlKLBgioMad4XOCIe/gmsH44Rx3MdtDazpo/hS6
	qguvklIlwoyNS1ySLTEVrO3jRBHlBPntknYuMeeKJQbqGY3tWojImuYTwg4P3ngkGXBo64qatU8
	MOhljRDrg0oiibZpheKpa1+0FevJMH9Ivvf1RISOUAtKTk37+xqlQigAKw3A7RV4BSn3cucygOT
	ENOcQ15GJoOptWYVmEzLeSwItzySbNZGoNhk3a62gPlbEFILw1+KmVQ9/m0FB7PyBKvv+6Shads
	tgpkw2VBSivclgzY5Uu2y40IowF9aPsFxC8nhcyiQeSJ6TCxyALG0wQI0mosK9wbZkgUTfg6BpC
	AFySn9ghutoJzHyGY7atwxZ+YohEcR8e/EnuBUbvGEsT6NV4Wv8PbOJTxn+jXtNt4knJ8hn2jbo
	vQNYZcHVLeeNfM+QkPEx/hxeCfX1JuEGw==
X-Received: by 2002:a05:6402:2186:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a42f18a70cmr15544172a12.10.1787446205842;
        Sat, 22 Aug 2026 17:50:05 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e02a8fbsm622238a12.13.2026.08.22.17.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:50:05 -0700 (PDT)
Message-ID: <802c59ac-a1f1-4250-aa33-d5c717315cb3@grimberg.me>
Date: Sun, 23 Aug 2026 03:50:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/16] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-3-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-3-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_175007_755945_694EF118 
X-CRM114-Status: UNSURE (   4.90  )
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

