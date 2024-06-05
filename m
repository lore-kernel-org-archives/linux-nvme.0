Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B61C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 05:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=sEN23IzU6l1jGC2k4XcpcBlSSK
	7H/hQRaSbzVRmnJ4usXpUDWCn+blXsI9kCyTZxd0xgBrO/6xcU49Vluo9ie1h9qPvASZQOz0fbqyb
	VxI8RN6dxVOks8AF833ipD+8RmIa04+SpBWEnwmlTfE3IseUdYTh5DS5vQZtFqaKWOJp8RbaC1sJJ
	0N0093Fv3Mc3VVD6u/dDE/Xddfy8nJlvuVwlhmws0BXbQLKayreu7FNPwj3WJWfRz/euJ0YlFs3q6
	HS8ZlxTS6pQP731XsktO6TkWe8grZdTCNYw5mA9TU2aw2tXB7/Uz8Tny2nZjaxar8nOfk6YZPUbt0
	mqJkxAJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5G1-00000008MzR-0TqI;
	Thu, 06 Jun 2024 05:01:49 +0000
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5Fy-00000008Mxj-2Ihl
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 05:01:47 +0000
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-250671a1bc7so217084fac.3
        for <linux-nvme@lists.infradead.org>; Wed, 05 Jun 2024 22:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717650105; x=1718254905; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
        b=k4i+rajwRMmW+1JkAJRai7wPg4PPyDCcsKyo9MtXtpsiRgYys4l4VS+Uz1WROjpfLw
         w0rPkooTHSeS7Rmj77JXqvn7znP2kkhDglU5GFrwmtjqFGg2yHu0tJp7H+WTLenwYdMs
         HRKZJGeIcL1n8gDdmRt6yYGLpAByOlQaopxMvYe2Z6RNX3z+etckOoP3fl9Ge9R0Lu8i
         FcUommT9XKZvlsON9lOHp/B0Mu7Rghnf1Nvf3mpIZ5efnAc8/1phpGcmRsKSaG9FH+F2
         aE99aT+hgvGhIFzWrDo29+u25aUppbhf7sXW0GfhcJh9vvOxNfX8VGv121dlTd7WnDhy
         XjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717650105; x=1718254905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
        b=aRX/sDGKW2MwohLacpKoh0ZDQ8GkVxBHriPi9/bdvX0r898otQ8ULZY73DjCvI+hja
         1o54VppAwYnCX1b3MnbMxhLvE7tCVoC8K/6cdPG37yuR/OWgOPJSqc889w/M1CiMun46
         jfFy6sy13iBW9t8ImIImTDqmaPubMvIUQ3lHwJcmJdGoz9gTSGCkaYzeRp6gVo7yORUZ
         nSTHzKkqYFDofGa7XR9+chAlM6zsS04IQDd9M1uY0ha8v4hPrSnJiQSJ+VPFuvJThG86
         HR0nbegaSgVoY9NDBQ1kOM5suxOoxzZAjm1lvLvksne0JQgVAxh1akLQ8OKal/N7TW6L
         BDpg==
X-Forwarded-Encrypted: i=1; AJvYcCXHciXnkVss7gfkuxxRT0oYmguEz5ksmjtPwaArWy+l0yyKLVck0kv7suF/JlQmniPv6lRTo+nC0nu3VtVSfamhPInUfD208ytpC0mJvlk=
X-Gm-Message-State: AOJu0YwuvkPZvshhfT7PWfVlDJ+NAt59PtNECLeBlJeaqSpuO90sZGTW
	kp8L5/KoLP+5q/3YBV2rl9uay/DG+9pl9hYU57tciQpLh/e1HFxY58v+g7cKpvRYGC3UWJBms0R
	hX8ZbxzJmkRHw3BQhIpVrtbOKurQ=
X-Google-Smtp-Source: AGHT+IG959oSX54MQq8GKfVWKo3o05hRklNZiBoCzbvR+OQgV8iL3zKUSZnj1CdwY90/HxmBqEYVn80Ozx7+RJmP7Ig=
X-Received: by 2002:a05:6870:970d:b0:24e:896f:6a25 with SMTP id
 586e51a60fabf-251220b9deemr5280914fac.58.1717650104968; Wed, 05 Jun 2024
 22:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-3-hch@lst.de>
In-Reply-To: <20240605063031.3286655-3-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 6 Jun 2024 05:01:18 +0530
Message-ID: <CA+1E3rLUA_hnGsXF7p14Hap9jKk1hHDTicYuHMque10QV3GEDQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] block: remove the unused BIP_{CTRL,DISK}_NOCHECK flags
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai3@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_220146_638287_74FDACBB 
X-CRM114-Status: UNSURE (   6.77  )
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

