Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8F0106ACEA
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 21:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bs5kbrxMvRUvJWoNKFWOVhPx2MWPEzwLx9p1OBH7opU=; b=G1fC0z8UqJalYAqZpkJNFG2G7X
	L8Vt2TghxJCIRwq4JJCLL3GNvlf1dwIhbJVOHveZ7Taf9Z7tEWlo8/sWDTnje5BomhnqNxh28Cail
	9rZuh1lRlUluR2iWPqwhVAKR7aaqP52JnE5avc36YHysDEMgDlKIcrEkt7OU/FYmo56Z+McTlO49/
	BIY8r2WzYwT3PoAQM3faEGasZMvlVpba0dh5jt0XyoeJh+xr8wOWfImGqtTEkHA2BhGYQeYlO2Mfx
	cYhNRYQE+B08mSDiW+2qgwinIbyKlN42aVFCderhUK7EzV2OMzlzvw+5uVSL303/VMnBXmI+pa2U3
	MDdeujmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nOW-0000000FQtj-2yXK;
	Thu, 12 Mar 2026 21:16:36 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nOT-0000000FQrf-0Xso
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 21:16:34 +0000
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-4671119c1c0so1124788b6e.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2026 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773350192; x=1773954992; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bs5kbrxMvRUvJWoNKFWOVhPx2MWPEzwLx9p1OBH7opU=;
        b=hzRqCcl6kJt4FZABskOqjC8wuC8uHeDaLJKJj8goOeDEPvECSBqZqwtR4Cbmv69SvC
         K1hG5s6cHI+58nH4quU1hdr8KSIJghVHjqVkCUMn+NXY3hK5JmMFRLkYcASDw21JEfeh
         /GGJY6DAB6qUO5R018Z/4qic5qGJJ5ZNThSvYF38yCXgBri3wG7UcT+fG1WTtvKyUCTN
         PFK6d2dl/AAT+dmKj1OVJHhLi0dYkQCjbq7d6iU0aZhKex7Fw6RYTin1cHTclBqX7a3S
         +B9wnr1btGW/tlxRl2HeiEydMem7kQAdOjoILRrIAC1hUZP7MD9IkRj9oIAuovbuSuu6
         /P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773350192; x=1773954992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bs5kbrxMvRUvJWoNKFWOVhPx2MWPEzwLx9p1OBH7opU=;
        b=iWNsmFvpjbb3GLFoPSZzRH7/v83pI5rJDiNgv7Fv1BI5u2HRFu9+1jd86fFg0pG6r9
         j1ZEblmqAWpJKs60Ij4SmykR3SmoY+qz08gDHRECTcAqNbbDd9IXD9h4QCO2dsJpQFsq
         TnANdCZ887Of9ysaULdWfOCQ0qjGGKzp60TsVPb4Fi3eB4JfhItv1ZwdVo1VJkn/N+HZ
         zVDRdrlJQGz9H6hnM4MKLhNK5kZUrJrDv1+E7eWqowkAZ4kiazEejBZiOGpXqaqgnVMv
         3Hwp7gUflf0QGMq7fVaZ9PkUyjYSPF/Diw4KnFuUY1d9lZDCcyR5Noeno4B2ERzJttO1
         /WJg==
X-Forwarded-Encrypted: i=1; AJvYcCWoA5Z++pbXUHfIFWoPU+j4Zrijc3k2SX9k6ctvwbArpGDzz8XCw/g+EE1cWzfZJaOKAL/MwWrDVo1H@lists.infradead.org
X-Gm-Message-State: AOJu0YwSGYBUgxCXCtDKCBCYc+Q0IxXYjRz3vEF7f+29vVfC4WjvlV1i
	Sg7hJk6Rm95cA8wHbowS5jgBCXCcBzbJHTKOhFNa/RubQwAV3/1K3dMD+sd3Hlsq5XI=
X-Gm-Gg: ATEYQzzTN3DPK+ovVnFiTpcZ6ljLO+DL4TRqgqYzNzRjGuwpueZvXgVdN40PJepv3Vd
	K1vWsd7n/yKjmmApCH2/SskdcoHw4lHIqY4QAXHnU9A8VSHpwSjXZ9i9jWBvw6RVGQ1o+5A4awx
	vms9igpfGxNTjuxnUQ0Qb9/4mi7pnz4xswl7t+/Na+bdzKATA2WO6huOMAESb+0aAiNrwvHjM/q
	brIYu3LzBjqYTRkx20tzQj+9S86RQCJ79CVfvlIL+qdPuXNn3RGaj+pvTnXY3fBtc/ONNRQttGh
	U/rn1vO9C7YO5aKeczKbriWirvPe9MZrxMqNm+/wvwwTiLzxOsIrtrmPKHc1OIRoXMNKJ53inId
	UiTBI9VseaJlRCjkYvkkt7WcQ8Oewh19A/0KRHC9aR5CLYdx+M5XdbUzvmz58ZJo9kMQ8i7H6TG
	cOrIlrayaOSKVsuHEQAjj4yp3VcDNHGON3x08fV08ys4s9Z04Tuw+/VmKmriFuHXl/uQW7DAoTF
	S/YrMTUJ+PIuFh9Ui/N
X-Received: by 2002:a05:6808:140a:b0:467:22fe:eb10 with SMTP id 5614622812f47-467572eb815mr448760b6e.34.1773350191627;
        Thu, 12 Mar 2026 14:16:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342c084asm3549685b6e.12.2026.03.12.14.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:16:31 -0700 (PDT)
Message-ID: <906199cf-834a-48a6-b7df-674feab19ead@kernel.dk>
Date: Thu, 12 Mar 2026 15:16:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.0
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <abMrH7YqnCQsGt-Z@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <abMrH7YqnCQsGt-Z@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_141633_453965_5C44CFE3 
X-CRM114-Status: GOOD (  10.05  )
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

On 3/12/26 3:07 PM, Keith Busch wrote:
> The following changes since commit 155a3bedccaf57c69aa0b590ba3fb579debf3a4d:
> 
>   ublk: don't clear GD_SUPPRESS_PART_SCAN for unprivileged daemons (2026-03-09 07:37:36 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.0-2026-03-12
> 
> for you to fetch changes up to fa655a9ca73f7df32b8ca4d14ce11742f9578288:
> 
>   nvme: Annotate struct nvme_dhchap_key with __counted_by (2026-03-10 08:20:29 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.0
> 
>  - Fix nvme-pci IRQ race and slab-out-of-bounds access (Sungwoo Kim)
>  - Fix recursive workqueue locking for target async events (Chaitanya)
>  - Various cleanups (Maurizio Lombardi, Thorsten Blum)

Pulled, thanks.

-- 
Jens Axboe


