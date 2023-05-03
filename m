Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E84C77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5FYuBoy706BNjZQW8G4Brm2K3CMMFujMy+1qdI/x7nE=; b=RvFZLcU8pma40vsexeAU9hMGcF
	hc1sTkAuZmMImWyQIL/HwPPMDt4imLBqGRrhqxV0kOGne/oeq7udnQ0DLFFA2c3oRVFiWM6W2bOYr
	kHxqIyN38DEVzl38eWC55jh+RrFPRDEKEWd0lsVpTDiiz7YIKIO+0+o3n0N2wByBS/UAaCKlHG2Fb
	WUY89yKc5A9G+ItqZ/ka5lTuBA7ricw0Enkb5IJi1vIz/FqB+cB2sTbB49odGoou4OhxpUf6HxfEv
	IPlvLLQkqe5xlDcO+g7JxcPipaZRjEcvHToJYvn+ONY1NuTGM14xBsiqdPx6hNpBIgizsOoLAYQ3d
	jlxgxw3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puHYC-005UG0-1L;
	Wed, 03 May 2023 18:50:04 +0000
Received: from mail-pf1-f170.google.com ([209.85.210.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puHY9-005UEV-0b
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 18:50:02 +0000
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64115e652eeso7200385b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 May 2023 11:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139800; x=1685731800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FYuBoy706BNjZQW8G4Brm2K3CMMFujMy+1qdI/x7nE=;
        b=XHLExplN52borg7pW6hzx2lrHyM9IMV4WcjMWKKGYqY8PnV26503hYyFm3lPeVzhmB
         GWkjctHLlkF0rgCwcgBNhKjn6S9qNP/cA9Z2Y+dpXe55qpbr1GxahGwYp/rtyKgkPha7
         kv9FMAuxWre6Fq4lO39IEt1JDNBPkOf0HKz/dlvrAtkHpI6FcBNw/J7sF9UtnaFmvt45
         k0wjsPyCrvZe13kkrNh6dUdV6rIfIcEG3QwxB9sT+nbL4bhGwJk2oBjcQ6d2Kr1BbzKa
         HVIKbYSobAG6iWz0t0m9bajfmrq38SLzZ6ius8ZR6N3MMQUhwAOfSka4wrt623Ev3C7W
         RCYg==
X-Gm-Message-State: AC+VfDzbKo0aD/tG58MmC9NiU91jLeMrRGpCsrn40NcuB+gPFEQZS+CU
	/W39468EBGIKKNnVPHX+HLw=
X-Google-Smtp-Source: ACHHUZ6klmcPoNpDdFKQ5xArJAJNygpTD6IHFf4dsBUkLvzbtXVUDRVlRebTNnMEFNkXvN71piNtKQ==
X-Received: by 2002:a05:6a20:12c4:b0:ee:cc76:5023 with SMTP id v4-20020a056a2012c400b000eecc765023mr3789944pzg.22.1683139799941;
        Wed, 03 May 2023 11:49:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c683:a90b:5f41:5878? ([2620:15c:211:201:c683:a90b:5f41:5878])
        by smtp.gmail.com with ESMTPSA id t3-20020a056a00138300b006338e0a9728sm23946563pfg.109.2023.05.03.11.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 11:49:59 -0700 (PDT)
Message-ID: <ab663865-9099-8f6b-de1e-30c1356d5078@acm.org>
Date: Wed, 3 May 2023 11:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC 16/16] nvme: Support atomic writes
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
 jejb@linux.ibm.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, Alan Adamson <alan.adamson@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-17-john.g.garry@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230503183821.1473305-17-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_115001_221588_FC93DDA5 
X-CRM114-Status: UNSURE (   8.72  )
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

On 5/3/23 11:38, John Garry wrote:
> +			if (!(boundary & (boundary - 1))) {

Please use is_power_of_2() instead of open-coding it.

Thanks,

Bart.

