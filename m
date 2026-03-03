Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD79CE67A71
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 06:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UWoE6mn2375qZ/+kFXj+S+YU2oT2pZiLz3gYYgeg/c=; b=ulT7wYKjubsZSHh6jxtfnuPBkj
	d4+8pFjKlHy0Q8zwMJQ7fAefu3XzG8UcAdpSVMhQkuPKf4lgQBAYSplAnVfm2WJmFfYETPCmoIudM
	lBjg+AC9kKny9NOzMaEKzAojO9SYZefNUl3IZQdAZAyZYGaPqmdhnRDqZ6kq3qxjVG/z3T2ESFBzD
	BC4ROmTGSN2w02DNMzQI/cDf5/BpPBb53VPyvtSSeTUheJEilXPtL9GS+dTU24OxS57gkYkHTCAGX
	Vxs2LE8ZdhGHD739bD7pvoKk2EYzOWvVmLdpD7A1jpHYd2R/2FkD00VVZdHh8zS1ZI0+/JN4s472E
	R97wpR+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJhB-0000000EdtF-1ZHY;
	Tue, 03 Mar 2026 06:57:29 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxJgy-0000000EdsS-2j4i
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 06:57:22 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-48379a42f76so42661965e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 22:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772521034; x=1773125834; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UWoE6mn2375qZ/+kFXj+S+YU2oT2pZiLz3gYYgeg/c=;
        b=TWepLj7eriH/GWwnlXxbTfC6PgWvNt1+aH51f1IOVqQCPA17ELbgCIDfX9RkwFJvVV
         ITeYLyvzdbS05uIRwBpaSMpDUR57vU4sdtCK3nHtNuUd8VGM1EQQQrD4OKUh2fLsSCf5
         U7WZldHZEYUGuwX5Q1ocU9duuJwxpZpKfFlNMYqhxtZDeBcyvxHOfN+hNGOWqolUGuRZ
         Fq2A4VDQEDSJSMbMSPGqgsGZUZ5mzthuwIchxHLOodntdQzD+eBsNH4YTrC7q1wfKUKQ
         lwZuXUPKb1O8hoIdE+f6q11Pp5JfdvXLKOwMQOnFWMh7tjKIXFvujlM9IzEi0spqcQel
         q1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772521034; x=1773125834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UWoE6mn2375qZ/+kFXj+S+YU2oT2pZiLz3gYYgeg/c=;
        b=T11XL2o2DhwHnvanFA5UX1EoFEiK0FQNCqKEZ228+n+f77+s9KQ7EK5lUN/J/ULtf1
         7iYaghlYgjLrpyWEYV7qgBA7/mBCB0ao7yM725ZYOZts/vtWgyb0S4iK7ERumDO0V6tk
         lPoMyuffxfm3NBllnpo1tITvme/Ch1p4SRp9ZGb3Bo3J0o38MPgeKZCtiaDBaTfCbftt
         GbB/3aLrJUXsT6OJTHSuGNG84cIhDJ6Tzp14C1htnFdIr2vfOUGiCeOQJXuxJpblKy14
         oH+EzR+BNB5S2j2uwJtwld6in9TYf959msqFGKnWJ+2ZSknnFWq1pkEi76Pqs1zKArER
         uz0g==
X-Forwarded-Encrypted: i=1; AJvYcCVYQAAi7p+7XXCMvRiLsTG13RxXJrvF7dcwPqO2efQykei00Figl1YTeclv92c97S+UCDXyP9UOHpmC@lists.infradead.org
X-Gm-Message-State: AOJu0YyTJrQ6N0icxXDqtGtPH+LFEnQxbIAHDmTbpZEm/RZAB+54drDA
	0Bdk2C3NuUeUXnvyvI/tbTNdS8sJWABswo53+LihXUWHsD/dsSxM55RbvDVupmgiRo8=
X-Gm-Gg: ATEYQzwlSJ3fTzVB7SSFj8Xz6S008LQIaserAURDuKhkvbAdgT/yJnZoXo2835K6eQC
	yoVhuQOM6kRgtVmdRvcVtQus/YuSH38YNBAvwtVsqlmB0MLctpj6coTtkdcFWkrim2BwZjA/qSU
	k2y0p2POSDmnTk+vOFwhrvnQHEqsKIpPKLNmHV0Ffic8ApJDE3ZPvo+sBkA8D+9ennD8dIsJuwy
	gNJfHg0KrS9GBzzGqD+C97tmDI1hFxbsP2LBfa0Ww7mSq3xeWBB0geKrnJ/TyOTIxoy/7y2C1UU
	BpedH5WX0SHXJZcUZl7Sp3wc4rT5nRZTnVEB/54JEXNbPuMA1WjXV/QgcAIuHX45rFRjlQr6ze6
	lcU4Fy2SxUv0Pi0JQwSsW/mI5lQfERvqQDyb5vYVjJa/QQKzpcPRUdWwxr4QHI7jHo/eoXkxrCV
	nhWEGOfYV7Oz6yInVUMxrFosR60H7Ci5sAwrWnWaKv1MEUM/X7gzY/VPInhu5H616s+A==
X-Received: by 2002:a05:600c:8108:b0:483:7907:ea02 with SMTP id 5b1f17b1804b1-483c9bfa9eamr271767355e9.16.1772521034082;
        Mon, 02 Mar 2026 22:57:14 -0800 (PST)
Received: from [192.168.178.47] (aftr-82-135-83-117.dynamic.mnet-online.de. [82.135.83.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485132f202bsm16289535e9.0.2026.03.02.22.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 22:57:13 -0800 (PST)
Message-ID: <e22f5444-f8ff-4c91-b9ab-fa95714f2df7@suse.com>
Date: Tue, 3 Mar 2026 07:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] scsi-multipath: introduce basic SCSI device support
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260225153627.1032500-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_225716_725862_5472AC6E 
X-CRM114-Status: UNSURE (   9.45  )
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

On 2/25/26 16:36, John Garry wrote:
> For a scsi_device to support multipath, introduce structure
> scsi_mpath_device to hold multipath-specific details.
> 
> Like NS structure for NVME, scsi_mpath_device holds the mpath_device
> structure to device management and path selection.
> 
> Two module params are introduced to enable multipath:
> - scsi_multipath
> - scsi_multipath_always
> 
> SCSI multipath will only be available until the following conditions:
> - scsi_multipath enabled and ALUA supported and unique ID available in
>    VPD page 83.
> - scsi_multipath_always enabled and unique ID available in VPD page 83
> 
Why don't you merge these two options, and have
scsi_multipath=on
and
scsi_multipath=always
?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

