Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C26C27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQUOxKnD6CsmHDQ8zwTblKdKo9rITBkMiMcIVKNHWq0=; b=NderMP51KQnWve995392biLgGG
	6snSJam3zn4QETUC3BtAwTMhEtPgtzA/S+ZtYJJ4I12WPvDUH3JONMysu8fHa8RzEOyCV70kSsekX
	mbnHWEsYLJ/bWiNCaIdpmDDfBJFJb4wxp1S4aG4FJQCqWA8noHrjhv4rJr+lEsP7Cpv7kQFyu6cMD
	wsASjonbG5T0i4SqfHcQUA8w8LPI5aOszUzIVI9qVSyLh8npuhpTXKyHPdp9swH5cJWg8tWA5YaaF
	EHK1691AxO4Fe9MPhORHGTbTojiyEXkIUnLvAcXQVDrLkFK8JcZcCQOQfvQh4kmMpUj7TOSkVaFJF
	gj1RVyAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI67o-00000002l8v-3fy4;
	Fri, 14 Jun 2024 12:33:48 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI67l-00000002l87-1zp5
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 12:33:47 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1f6f38b6278so1925455ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Jun 2024 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718368424; x=1718973224; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQUOxKnD6CsmHDQ8zwTblKdKo9rITBkMiMcIVKNHWq0=;
        b=n89qAWXSF016phP8yia3NbWE9AWuSdg3UkdZM0hAL28K8VeFESvJKZC0YdAamnd6Io
         bJv2cF8UeUGGAUAxdh/GptB/8PYtYZedksWPcvn5PDHFXdLPZR3gk4bMARnpjxI9JShd
         UBdXZgQC91Tg3tPBZ2y7mrhfIIL0/y+fN+fip5HqWn3CTMvEpBVWkwZwpHriFRFRrAvh
         p/zyV4DT1kEKElW8JLCOHdJzsrxMgHOUAh3M0bUjsxm2OEMn3ZnZ6ZyCRM9wo0pdJR7A
         giKMnzHXmoiSMnu2XnhmJndOgmcFEdEvZptyJkBoEqb5bC8RD3vbwotuPTfNh4123xZD
         +5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368424; x=1718973224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQUOxKnD6CsmHDQ8zwTblKdKo9rITBkMiMcIVKNHWq0=;
        b=OQMFh9SS2dK1yYfxtpPzJ6h2Ok4gjEyn7JfrRsIbRn5ONYmOZyePyg4Cm9oqjszVIf
         LMZt8zr07Aw5gPd8e25AffG1N/XAqEEtdE4REDF3G6m8TMu1ZjdnIfqLMmtjklJqFNi3
         A+6I2XSe7sprlMOOumbFcW884B77Ajsep4J0KvXsON1jBRKhWbec4TtLERHEjSyskp8L
         Jg2l5fCbZyVRH1cNhwQcSqS+sIfClONBfrcT2jhTygAwiCvKFm2hOha8Bc1GTDlMA25g
         jUiTf6DKIwIuxjCE+ugW0XxyDcJR15A9nl53jRe3k1TG/P4tHlsf8sJYb1W/0Oli5g9l
         8SOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1FglW+tBwwE8rzItAQ/tmHjYleKBZTjPTClgeFI7ji1VLGhVIobn9nL0/BysjkiGmLnd/JCvSIPFxLwTOAMfNF3qlCMJ2/cihD6JMKLI=
X-Gm-Message-State: AOJu0Yz+aasQJpVL/Y1OAnTt3Ubu3WDrgXHsG8DXTu74E/yMtPMVTB06
	Qnip1iSnbhu5HwcHuR61RPMqEIwiXpdSfb3SzSrWtfvTM4i3lyz8xIMtUitK9hE=
X-Google-Smtp-Source: AGHT+IFgr4iSfGSF5IPV3zZl5qFPlqcnaulUtE1TfAC51U6Q4NBcINjOTwVkZv2IxHULMCAp2GZWSA==
X-Received: by 2002:a17:902:eccc:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1f862c30f6amr26779945ad.4.1718368424251;
        Fri, 14 Jun 2024 05:33:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55c3bsm31084685ad.57.2024.06.14.05.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:33:43 -0700 (PDT)
Message-ID: <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
Date: Fri, 14 Jun 2024 06:33:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: move integrity settings to queue_limits v3
To: Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240613084839.1044015-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240613084839.1044015-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_053345_787504_72760C9D 
X-CRM114-Status: GOOD (  22.03  )
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

On 6/13/24 2:48 AM, Christoph Hellwig wrote:
> Hi Jens, hi Martin,
> 
> this series converts the blk-integrity settings to sit in the queue
> limits and be updated through the atomic queue limits API.
> 
> I've mostly tested this with nvme, scsi is only covered by simple
> scsi_debug based tests.
> 
> For MD I found an pre-existing error handling bug when combining PI
> capable devices with not PI capable devices.  The fix was posted here
> (and is included in the git branch below):
> 
>    https://lore.kernel.org/linux-raid/20240604172607.3185916-1-hch@lst.de/
> 
> For dm-integrity my testing showed that even the baseline fails to create
> the luks-based dm-crypto with dm-integrity backing for the authentication
> data.  As the failure is non-fatal I've not addressed it here.
> 
> Note that the support for native metadata in dm-crypt by Mikulas will
> need a rebase on top of this, but as it already requires another
> block layer patch and the changes in this series will simplify it a bit
> I hope that is ok.
> 
> The series is based on top of my previously sent "convert the SCSI ULDs
> to the atomic queue limits API v2" API.

I was going to queue this up, but:

drivers/scsi/sd.c: In function ‘sd_revalidate_disk’:
drivers/scsi/sd.c:3658:45: error: ‘lim’ undeclared (first use in this function)
 3658 |                 sd_config_protection(sdkp, &lim);
      |                                             ^~~
drivers/scsi/sd.c:3658:45: note: each undeclared identifier is reported only once for each function it appears in

-- 
Jens Axboe


