Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CCFC6FD1C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J7dxhXOhPm1rjnBhX708y4lq+UW0mc9qQ6mqHHtCoG4=; b=GwS8+qMj0H36NMTfGsZjtylBGr
	NA1YIKn4YYZYLkcGeD3sU2MZH9fJZvSHdY1iCHDvl/WfTnqS3os3GOcA/AKYuSHAwKN2yW0bS2XEp
	6euISj35Yd/wYCLcGgkua/GDX9iwd1b48xzjX/+DGsrCeOAmG9zI2DD7bzQiofKI96UEtOWzorGIx
	xQivpiYyJK1KvNWJrmCmSZb/IquRuQNrXuZZtvujf+/rWuTQ9KoGgsU200mwTj4lLTDYvm+M7pHlP
	toYFJwDTnzB2I4ayT8qkfOs9UNmEPi8pWSoAvipI8VpjAdpNjqpH+LuUxeMJ4VtLuT754GP/yq7sq
	kRCEI1mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfnMi-005SZt-1X;
	Fri, 24 Mar 2023 19:46:20 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfnMg-005SYy-0Z
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 19:46:19 +0000
Received: by mail-pl1-f180.google.com with SMTP id iw3so2814608plb.6
        for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 12:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7dxhXOhPm1rjnBhX708y4lq+UW0mc9qQ6mqHHtCoG4=;
        b=VZ9MZJhwJ2rzkrs3K2yEkl2S1GZjQbXrUAEWGASn36ND/zcj/VMuxtUowCiKuLgz3q
         aNmcsvV5dCY5ttORfAxcK5UfnGALyyGviw5PtHy5RshitFASL9GmR7GQAYEcGjYGYvkm
         BvyIG4jcifkWJmbh4yR0rQnzx0fwM6bLKzw/lkbgli1egYpDHHR1brl0kiAaj9tuBW77
         oRM93aiLgeGDeO1cLLMGNlEhokxsnK042pBy3sDa5fuMNVtXjEqHQMisN+UhdsNbkc1F
         RNMY0BpoihJfLTnA5syDSIHWKip7o8ipvNuV7F7WbhLnP+bg3YijyqAguUi8wJDW1GQU
         jg9A==
X-Gm-Message-State: AAQBX9cJpIMOUJluOHMbAkJYDPVtH3poJEStWvHsZW3sWsOscc+7xBWq
	akheaIRYB4aQTlx09VstcZg=
X-Google-Smtp-Source: AKy350YIsFGcV01ac5EKq37TJfDpDKKDtii9V8hYor/rYLrdjT6fks/kkJW+tmPAJbXZUh9YIxzmkQ==
X-Received: by 2002:a17:902:fb4e:b0:1a1:cd76:7880 with SMTP id lf14-20020a170902fb4e00b001a1cd767880mr3549674plb.15.1679687176657;
        Fri, 24 Mar 2023 12:46:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:386d:2249:7df8:ecf? ([2620:15c:211:201:386d:2249:7df8:ecf])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b0019c61616f82sm14572264plo.230.2023.03.24.12.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:46:16 -0700 (PDT)
Message-ID: <901b8d9d-dc20-f409-7dd4-000db8b03259@acm.org>
Date: Fri, 24 Mar 2023 12:46:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 02/18] block: Rename BLK_STS_NEXUS to
 BLK_STS_RESV_CONFLICT
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
 <20230324181741.13908-3-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230324181741.13908-3-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_124618_208449_28A28F55 
X-CRM114-Status: GOOD (  10.59  )
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

On 3/24/23 11:17, Mike Christie wrote:
> BLK_STS_NEXUS is used for NVMe/SCSI reservation conflicts and DASD's
> locking feature which works similar to NVMe/SCSI reservations where a
> host can get a lock on a device and when the lock is taken it will get
> failures.
> 
> This patch renames BLK_STS_NEXUS so it better reflects this type of
> use.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

