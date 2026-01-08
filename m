Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C10CD232C1
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jan 2026 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5i/ybLFlkR1hRyFiuhAVAYP9FOrA4aBRdQ6o2otIQk=; b=heaA2zq/BghtbrAfJQb3Mqm+Ot
	a5/kfQAjciYQBUaDJAXu0vKKCUPFnvwc+H2xNCOJcVZ7D+/ocXdPftdUg9O00szWNrZHvBH5Y609n
	6c7gnj4kwtF1SiihpVfeORHIiYttEhPSHbz8yU4a98qdiFsmHwmUiprc8HIAuZdH+IccGLXhVkkq3
	DazjWPox6esRyPVGeeV87DiJEs2BT3J7orH/pTX3/PkntQlHnMfk3SS62y3G0CzRNlvfUBtt8T5lZ
	a1snW1t4bRG1eW9RmVy6hVomgdVjepLaj2t1iQ9F338TR/fnJgg0HmclFpYGvYP6baKkIwLcikxeV
	tqkZMEVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdyqj-00000000xnJ-292c;
	Thu, 08 Jan 2026 22:51:25 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdyqd-00000000xmw-0kKj
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jan 2026 22:51:23 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-81c5ff546f6so730802b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 08 Jan 2026 14:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767912677; x=1768517477; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5i/ybLFlkR1hRyFiuhAVAYP9FOrA4aBRdQ6o2otIQk=;
        b=mY4ZPHWMx5Nih3ImMe2ip240xu70GBqx8BlP8WEDLr9dYyi/hNwa6yipiw1kcuEQa0
         JZ46M9QVI9UMkt/9ybunTSOXjq6ZzSC9KXIPzApuUKYSOBA/RLGu0Xg8z5Ar/qPhDJli
         5NvPGueNNLdbKrderi/DU0EMdqScKz80L/+ACeVnRujyYPpgPsPmBl8iYO3ZAC1fVGfr
         YhWeGsx9x7jNwzhR+dhp77eW5eL8de3QCYacA+nbKLw1UkEBFAYtxZvUMDRPuRF8ifLd
         9BVhAP7KsqChnepoyFnJ4OxBp+6rPbDG2hgE+uyUnPmtvFgIhEOLql4RFIVyndrAnY/9
         4V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912677; x=1768517477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5i/ybLFlkR1hRyFiuhAVAYP9FOrA4aBRdQ6o2otIQk=;
        b=JeFzJ14IE+p/yiLotPmHmpDKZb+9olYeFuFCs37E+UtgD9OE47knJwFI/pYqXT7c4z
         rqw9HeMkclPdP8r4+IDuF8SYcbWezZVrYSMDp2LDYD4+uorV7Q6uJNXVa4qrMbKXcX3s
         0NlEPMebVQR/5MbcUESWX2YeR/bFxGZ3c9zO+9odPogK9gb8swY9XlpOlN3t6AR2AMFL
         65aq6cbDiIR7XGm2zdAk4Deih8W7BfCFeVdJFo3A37S08JvafwVtViCOFl4Lmlm1hgkN
         PNBm5ZVSyppWCk9AZK6F4+hL/W/ArdTKyNFOczRiq7W59sTEgdzvb7vi62avdxTkybmK
         5LrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX8TgoNbA7J4NmQ8+lVilNALOPYDRzbCqa3sMCj42PD+i2lFhZTc9gLo1AZQpt9q3giDDDf2r8b8Hx@lists.infradead.org
X-Gm-Message-State: AOJu0YzMBx78BGeElbhZBZ3lp9HSUExttk08n353o0Vy/b5FmTjFbgn6
	+qDjR5sgw7NDol9tcvfMklu4jtW1uW0s4OW5txFkwpobWu4vrjZWPd0u
X-Gm-Gg: AY/fxX6fPhiK9VR+LY/gh49UxO+j5O5F3CmID6XJ37Xed51sDsS3fJ8t7FCDDap4j3m
	rHzIYxRSNGs353XA2uVHBzti/QZb62pF2mihRp78/zeRAjBv78nCv+HmVNINOJz0ieZFmLTk8jI
	p/7YgvVFlORMKDkNUzVk+Me7WxQWRBauBWKZnUsrtZQYdnpJy3GrY7nSInac/ig+fH9z0TVoygd
	2cEgmxDuF6G4UyQ+R76D2vbo93a2yQWW+YesctdAXArUenr9LGJnGRPoFb6Fsz+x8ExwKU/18fF
	a1vHyRL7GctQ/bMFowNCzuTc/A3v6OqlfX9iAkMZVU6tYLgJHI03aSVYfXp4CHRq/0ALkR17z3T
	Aclr3BGKJ1nri/5nYT3nqboVaWU7hFQmFDTy3jRIVoF+3bF77Iisx4kZvgu3zTLwm3b9K3YsewU
	O0hX+2zHD6gzmuiZ1Ja95UWEMIdSiTbw==
X-Google-Smtp-Source: AGHT+IFFWRYCODeTEAq/SYuIwpfhNwUfdW4jrZJYDOtHaJsBtPLyMtQDy6vl/gckOiumqrvVlx4EBQ==
X-Received: by 2002:a05:6a00:ab03:b0:7e8:3fcb:bc4c with SMTP id d2e1a72fcca58-81b78e9ae88mr7819855b3a.33.1767912677376;
        Thu, 08 Jan 2026 14:51:17 -0800 (PST)
Received: from [10.69.70.117] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e4c0f183bsm10194b3a.42.2026.01.08.14.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 14:51:17 -0800 (PST)
Message-ID: <803071b4-6a13-48e1-ba93-c9f57202cb59@gmail.com>
Date: Thu, 8 Jan 2026 14:49:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset
 if init fails
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "justin.tee@broadcom.com" <justin.tee@broadcom.com>,
 "nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
 "paul.ely@broadcom.com" <paul.ely@broadcom.com>
References: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
 <ccf8741c-35f0-49bc-90dd-314085f1dbb0@nvidia.com>
 <cddd1db8-3da7-44a5-bcf9-210267c30625@gmail.com>
 <a2feda48-515d-4e48-876a-01ea6d8d8398@nvidia.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <a2feda48-515d-4e48-876a-01ea6d8d8398@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_145122_810441_5F252386 
X-CRM114-Status: UNSURE (   9.03  )
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

 > thanks for looking into this, it was observed when Yi reported the issue.
 >
 > Irrespective of whether it is repro issue, it's still a bug ?
 >
 > Can you please provide review comments ?

Yes, agreed after reviewing the current goto fail_ctrl path that there 
is a missing nvme_remove_admin_tag_set.  I can provide the Reviewed-by 
stamp.

I guess I’d prefer if we can prove this resolves the issue Yi reported.  
If Yi could re-rerun nvme-fc blktests on the original failing setup with 
this patch, that would be great to confirm.

Thanks,
Justin

