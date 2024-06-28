Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A47C30658
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jun 2024 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5l0qovf4jTVxYzo2d0+ddTKgfILRCCXgo0o1Ulo6Ekk=; b=hM7u746EvWiwrdfEELz3c6fyIm
	RBecwnZmwtcFMF2awnAhg1cCqMJO+b0wha62Cqcd9JYx02e1vv/gKq63SvZayXk5AYuzLABLkqC31
	F8QFzvhdAuMD9NqQEm0dBvj3OktVMRr9clpOiDIGA8y03dhgdtai/gVtR02IyDfSMwK9IsC+1SAbr
	hk2YJzANb77rIUtFSDG7vtuySlZFlUFbo1shi1e+2Ig24QVol2CxHIBapFaDr9kc6RYsotg3H1Xc0
	lkvVpIrXPKRkAo6BQhVFn1cZUfV14cyh5EYzia8laAnifdCwFHG6JvPU1kbE2BVB/TjTF374R+48D
	FitH5JYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNIKL-0000000Esyv-1z7t;
	Fri, 28 Jun 2024 20:36:13 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNIKI-0000000Esxz-1sJr
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jun 2024 20:36:11 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-254925e6472so107172fac.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Jun 2024 13:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719606969; x=1720211769; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l0qovf4jTVxYzo2d0+ddTKgfILRCCXgo0o1Ulo6Ekk=;
        b=WWBVa53jnEFUD6XjLX8TThxZHKKFBubyL2FgTb/X6Pwk71gPI+Bs1UYzin8Gc2IzeS
         pLrnzHtAnlDT06les1L44y+qWhULDTkeGlf7VASJ8RbGHboKc42R7Pz/6D05emuGUTXd
         MY68PLl5fv+VneUUuytEzZEIFAyeiFnLNnfCb/q5n9lqBCN/mwe8YUF4SulMSgvoBu6q
         q9jp6Y12JvpJ/I1Qd6gC/seC0PTbLaciQFdmfpnFoh2vhdReCY+ACcdy4Lr7v7xTiJWm
         y9UNvO7/eHW+Qb1kEmxzs2hUEh+WxVJaP141u0CjxhXlabO0kdL5XnYhzBVW+SO4IPxP
         oQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719606969; x=1720211769;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l0qovf4jTVxYzo2d0+ddTKgfILRCCXgo0o1Ulo6Ekk=;
        b=qOBovkZ0uSo3GC4ExwP9MTDlv0wsOG8345dJXDuwhB9FUEyfTeE1ov9YU2R3lQsiJT
         Mjs2WsWh7PUVVeBzxsVewZebWK3ljUsjmXvBuEqsGRdG3XarwtVtFh7xtOhtAY6lxFj+
         HJlV3XoRCclDGHdC7DrX+cZYgij52VP/rNYvHRlToyEhFsaNJ6M1X3Fm8u3cD6dHuIbI
         L5tErNGQP2mWFeitavx7TfzDw6S5aeo8UwPSNWxf9O+UzTRiqMqhPO08I5+KUz8BgMq+
         NGGDihIOD1VciqHj80jk6wuCw5FCtDaEuRP6jK3lSChVDnzzMl0Dnd5Sa4iudPM+Duk3
         w3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaTcUSe6Ft6j5klUpFGcHVOJqy+0jKMtJ2TYMFdu2akqmQ6zdBnyh6IhomFhZ453fQ1ENVh62SaH63OWifspvEXWtmA9J1zXCCc4+IZpc=
X-Gm-Message-State: AOJu0YwqXwXZzOa6vwGx6BaDFGNMAI24btQ3HRyVABQWEv61f3ZFc6NI
	WO3j6NdEU+ndbbzQARFEoswDIQntA1nABi1Wjq6XdZua+ehlLYX4LMv5CK4WHrc=
X-Google-Smtp-Source: AGHT+IH4WazrWMA1Jhl7+Mv0AnHm21EMJQcJF3b3HRLS4CUfPejixBcFUyOtlBC/ESyNwt5bq0+QDw==
X-Received: by 2002:a4a:c186:0:b0:5c2:25cb:e6c6 with SMTP id 006d021491bc7-5c225cbe811mr7965464eaf.0.1719606969571;
        Fri, 28 Jun 2024 13:36:09 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c4149c37c4sm367003eaf.42.2024.06.28.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:36:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, mpatocka@redhat.com, hch@lst.de, 
 kbusch@kernel.org, martin.petersen@oracle.com, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20240626100700.3629-1-anuj20.g@samsung.com>
References: <CGME20240626101415epcas5p3b06a963aa0b0196d6599fb86c90bc38c@epcas5p3.samsung.com>
 <20240626100700.3629-1-anuj20.g@samsung.com>
Subject: Re: (subset) [PATCH v2 00/10] Read/Write with meta/integrity
Message-Id: <171960696798.897195.9522006867615686131.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 14:36:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240628_133610_520052_48EDE9EE 
X-CRM114-Status: UNSURE (   7.22  )
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


On Wed, 26 Jun 2024 15:36:50 +0530, Anuj Gupta wrote:
> This adds a new io_uring interface to exchange meta along with read/write.
> 
> Interface:
> Meta information is represented using a newly introduced 'struct io_uring_meta'.
> Application sets up a SQE128 ring, and prepares io_uring_meta within unused
> portion of SQE. Application populates 'struct io_uring_meta' fields as below:
> 
> [...]

Applied, thanks!

[02/10] block: set bip_vcnt correctly
        commit: 3991657ae7074c3c497bf095093178bed37ea1b4

Best regards,
-- 
Jens Axboe




