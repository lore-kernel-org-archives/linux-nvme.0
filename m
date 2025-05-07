Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2876C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZbTEcd6/01i+K+B3uSc11urmTj2zOxPIKRSXO0d7/A=; b=0NOaR20xvMbvT/tnnx0RAXmWEA
	nFtuaVqNVkZcDn1L5baW+DBnUcA4OIK0RnlUfHzZLfGOVErgsM4PtlhauhMLhYm7a9RBYchW4hOl8
	PrLM6N9Zy5aQxJI+SGXbaPRP5YOCA98P9PIgERny87sqOwVCRUXG1WXOMLfti8udUhIsBu4bg7kWv
	BTdz4GjTsNksJv/zcVBso6sddTZDO9JdAOo46XqVlKtOIBtPTi4NsbuusvFSfD8YKHdeFjzTIgwzc
	IwpG/SOJyo/tM0T73C8gPrWyxFtFQLVZujueS2jyvrU2zzcQoupk/DpNrU2Ld42sIWIGjVgtUR0b1
	AOG77Ktw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCiq5-0000000GNt1-2exC;
	Wed, 07 May 2025 17:45:49 +0000
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCiUR-0000000GHW7-3gHr
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 17:23:29 +0000
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e733a6ff491so147814276.2
        for <linux-nvme@lists.infradead.org>; Wed, 07 May 2025 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638606; x=1747243406; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZbTEcd6/01i+K+B3uSc11urmTj2zOxPIKRSXO0d7/A=;
        b=al6qm/WLcWR3du+6UWTK2MZRX+EAWLlkMD/wkUQkHfY8iAOvhD6n+693UotQLG0M/c
         SDFwVZ5FQQ1ELIl3pi4LhhGosu0vcePX0WudhvebQgSL1ULWiMz3JvfZi2Bao8sxwwQh
         7I2eENUcb01A74VOHDVAC5TJGKk7APpLS/HjOBT4ieGM6LDvUujksvNE5YM8ddzQpi1L
         AvIQis24Mfo1lAEaWDIJj/mx0GUyHv53wjBoB6x+yCJnDXUfuhBNiC+M8Kz188F77D3W
         S+q+6TSRQyWTUZf+B4ODHxq8S7w+xrihjQP77GdAWELPBJnPmB5L9o/1rlgf48Xdq8qb
         78fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638606; x=1747243406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZbTEcd6/01i+K+B3uSc11urmTj2zOxPIKRSXO0d7/A=;
        b=cbGYevuyEmp4Mz5aB2/8IhZkclj/MrGK4MyXj0iP3lQYA3k4mc3Ap7k3TvGYBIvzOh
         ZO5+SZdCwP9Mf8vkWMqedu6wvognTt7mznKEsf94yKDCEEdpNdDwbYvi5z4OQjbvDJcI
         GtoVNmi1VhLRiABYhdZi7yUOs97Pg2Py/RufsJpHkOdFMbCmo1Tm3X4aHHqFFsCuGmkJ
         DKLbpxxIoWj8e4rX4xYQ6bF5LJBiteYhUxCU3h+UmHeL6ZObrDjBkrwLnq0tD5uEfDEA
         xQC8ZvDgP+5G0VnfJNLfavg/rl3Y+/SBVuqrrh0iJ7+mQb+YsIHpC8tmSxlx1QSf9cgw
         5auQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWSxtCrPjaD9XowAKKMWHJfat0miCITz+CXczQl1tlar8w4WlEL6sdkap2+vwTM3Vf4PMbY18Ii3tD@lists.infradead.org
X-Gm-Message-State: AOJu0YzmAWg3RUeTz8b009alSL/VGpkJI4jHTDupcbXuw0B6pqTGvLMQ
	VKa8N9e5dJU47I8R3G6Ywr7CnQtYoUhjjPsFMqauhnbOskXN9kmwCOg9A17Jh+idVw0HzeHEcrC
	V8AjCL6HMcLClQhm0D+QAnLtb7cg=
X-Gm-Gg: ASbGncsBGXVDYmcH03VHyUh/kGJXKXgno9qqCi1iaNRaSE9bj9MJdtRlaaDpAo81reb
	Y2UDqwB0wUATkOil0QuDDG/AqZqC5DtXPM1HfyBveqyO1zpdfbvRhun+v14lewF4VkUFd6HFGNZ
	jSApRa8JuvUb2weeJEa564CrXcCKNFYpZzrg==
X-Google-Smtp-Source: AGHT+IF1ifTra58xZW6vXeL6NWmcDrzC/YQS5Ixnn0WJ2uD/sy+oSsBBdZj9LrNxDL9oBFZ9Ywefkw7+kxTZvmXZvRY=
X-Received: by 2002:a05:6902:2747:b0:e74:cc80:7b8b with SMTP id
 3f1490d57ef6-e7880c84564mr4957179276.8.1746638606000; Wed, 07 May 2025
 10:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250506153507.83094-1-hare@kernel.org> <20250506153507.83094-5-hare@kernel.org>
 <CABPRKS-ns8r6vQW1a3cpyQYXO0FszKyngY6CJ6aHhHofpB0Ejg@mail.gmail.com> <1c5cf65e-cdb8-413a-b1c9-5bdc570cc035@suse.de>
In-Reply-To: <1c5cf65e-cdb8-413a-b1c9-5bdc570cc035@suse.de>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 7 May 2025 10:21:25 -0700
X-Gm-Features: ATxdqUEIclbuzmVmZJOnB5t198hCVCrXE1f80B5e9WPPWjFZsNi-s13ia6VI36Y
Message-ID: <CABPRKS-1KimK_WxBtuem5=hg1xK9P9a0MNGPJ5ohdV2vZJWC9g@mail.gmail.com>
Subject: Re: [PATCH 4/5] lpfc: enable FPIN notification for NVMe
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Justin Tee <justin.tee@broadcom.com>, James Smart <james.smart@broadcom.com>, 
	Dick Kennedy <dick.kennedy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_102327_912150_3F0733B9 
X-CRM114-Status: UNSURE (   9.59  )
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

> Question, though: Why _should_ it be excluded? I would have thought that
> the target would be interested in link integrity notifications, no?
> (In general terms. Of course there is no code for it.)
Well, that=E2=80=99s along the lines of what I was thinking in that there=
=E2=80=99s no
code for it.  But conceptually, right, there=E2=80=99s no need to exclude
target mode from upcalling an FPIN.  Therefore, nevermind I=E2=80=99m fine
with this version of the patch.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

