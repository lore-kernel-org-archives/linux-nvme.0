Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F332CCA473
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVZ/M5UnEWLUffzK99X6Uq4sxuTSRmPAM1uZigSmeUk=; b=ESKU7bKfzua4A16qZLKTUtK5GQ
	L8eC/EcFNNrRcXQgYV1L9G/oHSltBrUAibIM1GvKE5fXhcfjpDpykktR6kqZA91WpdqhhylW7K7jm
	PyU3hk7DaWjBBtlkL4qgg3qAQLYADv8+VlrXP/KGeQu8C0YcDccACOmLgQzDxf08odQrb3bOOLpbE
	0GoyM/fOMf5GirwZmjTlc6bLyYR+dg7+thfpTcFOB3vfrNaA9mkDR9vR+95ZMIPlkz2newAMS8wpD
	KolnvdvpIGb+87Nu053PiH+jxBxzUsiJtuuttbqWpVPRBI6vjP5aSPjJjcgsavaVJc+eQ8s9GNEvg
	l2KVDJiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ene-005r7T-C5; Tue, 21 Jun 2022 14:24:14 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ena-005r3N-FB
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 14:24:12 +0000
Received: by mail-ej1-f51.google.com with SMTP id pk21so4763537ejb.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jun 2022 07:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sVZ/M5UnEWLUffzK99X6Uq4sxuTSRmPAM1uZigSmeUk=;
        b=KTLg9Dm0CathEr66EUR3aLHjGpkEisO/0EODysYOeea9/xA0QJilLEByL9ieo6yXlN
         atsm83gKHs4aDnerfJI/CdSCOD+j0gjiquVfqpgUdIa8pmjNDKfFYmnZIoxg0xDvjH1S
         0Ki7BRsNrOKdteLl+eZVtDbhOJEQXUs/KAldMN48f3jD5yU5w4e0CZixho5rfW7OWHPI
         aRToZ9g23bWEkS4dFxHoBt4fGdeBx8PP1vDv1usuerDBWgQsSg3+LpCL0Lrt4VQZoOKZ
         +BfVuJomA4Aj7ccQrHtP0NdnLAVEBVNmPt5rFEAzwwFb0WgSRmBn2NHKPn+gIQvqg7+P
         HSYA==
X-Gm-Message-State: AJIora/TxC0+I5NYlxxC2XajtJB8RpNu+c9ht13PFb6m6+gCTjES8DsJ
	OKAIr4NYOlq/rbyqxrcq1aTI3sZhgtc=
X-Google-Smtp-Source: AGRyM1s7q7k8VoA+Gqw8Q+KV99DaKi0/P8+FU8k9dsmM0eemmdoyaQmawlbHiP1imkDW+GFBlMsD9w==
X-Received: by 2002:a17:907:2b05:b0:710:dabf:fde2 with SMTP id gc5-20020a1709072b0500b00710dabffde2mr25166890ejc.114.1655821446895;
        Tue, 21 Jun 2022 07:24:06 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090630d300b00722c44f9301sm3346368ejb.224.2022.06.21.07.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 07:24:06 -0700 (PDT)
Message-ID: <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
Date: Tue, 21 Jun 2022 17:24:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220621090255.69549-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_072410_625795_01FD2201 
X-CRM114-Status: UNSURE (   6.37  )
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

This one doesn't compile against nvme-5.20.

> +	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len, 0,
> +				     qid == 0 ? NVME_QID_ANY : qid,
> +				     0, flags);

here ^^^^^^^

