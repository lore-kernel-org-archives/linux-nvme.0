Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B53C77B6E
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CkZ9epVN8TkdRsJcbdQlduPOctGu1N9KX0JTrq0nz1g=; b=pHOyM+rIeGr6IxzXlqcZb3gxIV
	gUcYjT+/SVT+i5u/Aj12pb0hlzQPoouyWK0ozs8eI5omE/tDeV0uqVyl4UALz0sjXaWfGfKL/u7ye
	W9HGOB902W8DmXuH4TJRjdqcL1e3zBbR8AO7hcGl3llC598yOAuR+a2BRklh+e50GO67VOWTvMbjx
	LvHkM0o5Vu5PX8lAvvUU6QzmzY9i9No6w7rQp9M161iapg1CyopJHiMQ/DvRwct2fBO0fCkSGKhKf
	ECuzSJG7r20zXYRbsVni+dsK6jLgvD7ho+Gv/n1NyjY/IBLjGRa42CmmNQedamRToeHksceTIS+VH
	czIhSQyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pksNz-00B46l-0j;
	Fri, 07 Apr 2023 20:08:39 +0000
Received: from mail-pj1-f48.google.com ([209.85.216.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pksNw-00B43t-0g
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 20:08:37 +0000
Received: by mail-pj1-f48.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so44185909pjb.0
        for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 13:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898114; x=1683490114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkZ9epVN8TkdRsJcbdQlduPOctGu1N9KX0JTrq0nz1g=;
        b=F8CvtUHnk30WMW48aLPxJbs9qrJE2CAg/a7Y459H3Ubs2Jle/a3KSWTh77i1ib5I+n
         Zlxw7B2fD8p/2RCQ2j7An3fiYnsC/f9VyO4Is6rRxoxg7ZoIIf3offX17dzja9DomO6A
         6leYU8Oa3AS5aDy5JkMItmjoMQlNhuZB4MCcMLuBhZeCQF85zdLGi5G0/ZsiL8rkplcY
         xxKSIAWNdASIGHWaejIE1GoD+rX/wfWN+WHff4pm+mS6EyPrCsW5UWaSpEIkT/qIpDW/
         fsuCrNwFLyhq28pxnvOjM2PcACLyXR1ioStLhbUAOa13svLw5M9ixtw9oCQQ+0hMOjJD
         eGZA==
X-Gm-Message-State: AAQBX9fHngMCZktEJ8cylDZXTvFLR0++v9Vd4Dnqjw3eYabyI2vsxKWX
	rBwYxR3BAMdKYceleUjetWs=
X-Google-Smtp-Source: AKy350bkZ/dbg++B75vxCCybX1JJjWE1bjDcXVcXGtkaYO/su68D56optz/DjfTQFNhiuhs1ZBvehA==
X-Received: by 2002:a17:903:2309:b0:1a2:55c9:1808 with SMTP id d9-20020a170903230900b001a255c91808mr4182456plh.17.1680898113889;
        Fri, 07 Apr 2023 13:08:33 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f2c:4ac2:6000:5900? ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id ju20-20020a170903429400b0019aafc422fcsm3272871plb.240.2023.04.07.13.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 13:08:33 -0700 (PDT)
Message-ID: <0d7d40a3-bd58-03f2-5bf2-706ed2e6155f@acm.org>
Date: Fri, 7 Apr 2023 13:08:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 04/18] scsi: Move sd_pr_type to scsi_common
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-5-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230407200551.12660-5-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_130836_254898_74B304B2 
X-CRM114-Status: UNSURE (   9.96  )
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

On 4/7/23 13:05, Mike Christie wrote:
> LIO is going to want to do the same block to/from SCSI pr types as sd.c
> so this moves the sd_pr_type helper to scsi_common and renames it. The
> next patch will then also add a helper to go from the SCSI value to the
> block one for use with PERSISTENT_RESERVE_IN commands.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


