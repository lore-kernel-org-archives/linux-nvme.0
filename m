Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3EBC48BF6
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Feb 2024 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=u8CYf+uZ9YH86t+xERuTMGB2gPG/8kNfKskED5Hz07I=; b=Gzj3l5w0ucq0JJ
	B9+P+983SAtGueqBaQxWuaRkXy+nYdk84Xn2BCRIznnkt9JehgTE2DMj9a45kMnZuUk63hUb9qnIb
	BQzkSCO8f3pxln4Tr/A+gkv5vB2GsWGkxGk80Kg67/K8nzXH0tOdOW0+7k8oWbxvi9V1/2D/Z1c/T
	5JBWkdfTf6/4voCuZj+F7gbV1Act8bHZoykuaIB5Fktp+lF6v+ex+A3g8N19Thqhxhclr2Wjkrv0l
	LfkDVqmwmE66zFM+2AuvOmipCgsa7z6xZ1W/lUM3MLS8F4MC/r9GqX6AYk917uZ4Xk0gPv0VdstQ6
	hQtTsdtmhoFyle3Pw+7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdwdP-0000000DPqT-0ocb;
	Sat, 24 Feb 2024 18:20:27 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdwdN-0000000DPq6-0nur
	for linux-nvme@lists.infradead.org;
	Sat, 24 Feb 2024 18:20:26 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d918008b99so12114325ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 24 Feb 2024 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708798824; x=1709403624; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u8CYf+uZ9YH86t+xERuTMGB2gPG/8kNfKskED5Hz07I=;
        b=cp6oNGQUE8azMb/rMReD4r66fEUI13E+KFH9ay5bIb9d8hMLhyGt3W8Jm9eR2zlOhb
         9P/YIUaoUJONtR53B51mR/UuVGinfpj/VgabUPzx3CKd3t7G9MJj021/xtZljV/FUVJI
         swUVl3e2QbH/UWO0uV6FdhtfGOmJEJt0Nb71e5OGcI8BPTjBRa1oWnkBXsuKE0jH79ZA
         NXtdND0ldQ1Z/0NjTy8qwMaLdAA8G64Sxyq5tTpaBUKUKJ0XZmiblbU6WEBybhfSUrlO
         ouw2TNiykSb+SP0cabIJc2tOPGL031/p9g78PvMuzKtqpL1kgtBC0Ez4rrGsDL/QuDR3
         aUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708798824; x=1709403624;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8CYf+uZ9YH86t+xERuTMGB2gPG/8kNfKskED5Hz07I=;
        b=VNC6zXz9HkiEKmsOlKCyaGcQniudhuPpLebh2IRZzZlJKMWd60dZH89Uaox2wiFW/9
         ojWrJrxV4T+j5ngtF+Mac5XVf5nYhQi0+d14Wzo2k8LsSzELE8HR3K4gLatfmrhAwxeC
         Bpzbujm0WyuIHtwstQiPoN02RhE+uYeGrvuVmi5EwUAHuJGtNHby6W492/Q/vy4Xr73+
         uXibe8O8KQ45ynNG3Ag0di29SJgVdIhsS9RTPKk2lC5vOJ+Q6Jf2SO7F2COf7er8LOAt
         jq06qHCqMDPaGaa8KhxoycHeoRykmV8VF5iXygx9O1QbOh9hYYE7gohNwfDgmpZVE0tj
         Qhyw==
X-Forwarded-Encrypted: i=1; AJvYcCVQeSneTabGRZ/VOq6F/UhkQV8zd84K6L+DAsxZmZUeXUVS4IX6VAwEnYDnNyzO+VeSGX3wbOgMaCBhBrn/fzf2GnNMhlRr8lSlOTK1aBY=
X-Gm-Message-State: AOJu0Yw7Z6LV2UbC/ICOBk09eSuP/GWeHpPiH5xsGmSTgPYXRROmzusu
	GDBVwiEgfwCRn4Xpwjt7pkoahTw8gMa8mXvRPMIWdYeH2YBavPua9GSXbdEI
X-Google-Smtp-Source: AGHT+IEWtpD6myPgKLDzuAWT+he2KacsEUL8k60CFxfg0quwBYfzNP4UtrxXc/p0r7aXaWfevFWhPQ==
X-Received: by 2002:a17:903:2281:b0:1d9:ce46:6ebd with SMTP id b1-20020a170903228100b001d9ce466ebdmr3808331plh.16.1708798824035;
        Sat, 24 Feb 2024 10:20:24 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902740200b001d9537cf238sm1264709pll.295.2024.02.24.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 10:20:23 -0800 (PST)
Date: Sat, 24 Feb 2024 23:50:15 +0530
Message-Id: <87r0h12080.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, Prasad Singamsetty <prasad.singamsetty@oracle.com>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 03/11] fs: Initial atomic write support
In-Reply-To: <87v86d20ek.fsf@doe.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240224_102025_264346_D41F37F3 
X-CRM114-Status: GOOD (  12.28  )
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

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> John Garry <john.g.garry@oracle.com> writes:
>
>> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
>>
>> An atomic write is a write issued with torn-write protection, meaning
>> that for a power failure or any other hardware failure, all or none of the
>> data from the write will be stored, but never a mix of old and new data.
>>
>> Userspace may add flag RWF_ATOMIC to pwritev2() to indicate that the
>> write is to be issued with torn-write prevention, according to special
>> alignment and length rules.
>>
>> For any syscall interface utilizing struct iocb, add IOCB_ATOMIC for
>> iocb->ki_flags field to indicate the same.
>>
>> A call to statx will give the relevant atomic write info for a file:
>> - atomic_write_unit_min
>> - atomic_write_unit_max
>> - atomic_write_segments_max
>>
>> Both min and max values must be a power-of-2.
>>
>> Applications can avail of atomic write feature by ensuring that the total
>> length of a write is a power-of-2 in size and also sized between
>> atomic_write_unit_min and atomic_write_unit_max, inclusive. Applications
>> must ensure that the write is at a naturally-aligned offset in the file
>> wrt the total write length. The value in atomic_write_segments_max
>> indicates the upper limit for IOV_ITER iovcnt.
>>
>> Add file mode flag FMODE_CAN_ATOMIC_WRITE, so files which do not have the
>> flag set will have RWF_ATOMIC rejected and not just ignored.
>>
>> Add a type argument to kiocb_set_rw_flags() to allows reads which have
>> RWF_ATOMIC set to be rejected.
>>
>> Helper function atomic_write_valid() can be used by FSes to verify
>> compliant writes.

Minor nit. 
maybe generic_atomic_write_valid()? 

