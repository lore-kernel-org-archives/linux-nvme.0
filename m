Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CD8CCF9EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 21:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LxgxfU9JMM/XXpT8Wu3S29fwvY9epDi1jI6+7QM3+XA=; b=R7qmaT/PyIgb9AsblVsuAlJlWs
	2bihE6d/8ILFTag5T/fMz3djs/Xns5DYi7wKzhWIQx0nhmN5//dM5KXvn10ajQjOjWgmheOQowt3U
	OM6VkR6HFulSbeEO19n5lQcwlCYYb20KHo2qo6ceKEQMIrdqQ3gXjnissBVVVapKXuIsvwwxY/K7V
	DoBly/kFQE7VCv9dJjv8qv6hf7swQv/559+qTRPk5zrKkwizGVkrH2Z9Sfx1fEm+JtyYAG4Y5Aiiv
	7HIdiNJtNWTaZz7RQxUIe4xvFXzuy3WiO/IC/63pvDuZnzcAb26cboXANMP3QHKQzQ9u2UHJYFRTf
	ANF/WuVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDV0g-0000000Entu-2UaN;
	Mon, 27 Oct 2025 21:44:14 +0000
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDV0e-0000000EntY-1dWP
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 21:44:13 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-63d97bcb898so8614981d50.0
        for <linux-nvme@lists.infradead.org>; Mon, 27 Oct 2025 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601451; x=1762206251; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LxgxfU9JMM/XXpT8Wu3S29fwvY9epDi1jI6+7QM3+XA=;
        b=ZSC7UA4bDnz8o9hRlPc/K4l5NOxProQhC9hXXbXMFi8hJHcFEISjxQPXByQC1iALnQ
         vfHfis6wbsGdUymAdjb2kk7kYJTAbAe8X6+LoWNWgWxqRDeH5WppJSl1UTdY2lqfS7oO
         /j/aAStsiIhsKiXKrBzM+dkhtIlnwp8MR4BxBuo4UTpPqYzmrHb1QU63UBrCd6kqOeZC
         S/3ZuLlE6m5HyGzcPxuTuA8HGVDfqF4rGG+n2em7f8Zu0bj6VDHrmGDeeh2PvphUPkUf
         mgKAZGDVAz2sjvUPLaCevV7taJf1Lb5veA2rZmwqC6ov1OYZE2ctuYvkiSI5Mkai6rFQ
         NYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601451; x=1762206251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxgxfU9JMM/XXpT8Wu3S29fwvY9epDi1jI6+7QM3+XA=;
        b=MVtD2ZjJwJu8B/URVnh1SeGDSng5hkDc0ISGAUBWmwF/eI0a0T4HcSiUmlvihQG67/
         qveyMm33kaiuG6xybUHE+EbYxlV6Ld3brcAJYtM1c0PjcnieLlO4KPIlxe6dPSmTCJOp
         fxn821maPxJJtzeOAKGvsE+n0e8ty5W0s1+heSDkuTA+RRumANlls5AiotpDr6ZydBT5
         DDFAiYnRNUobjc/4VAcVrbtx3EHxahE9oVJgslGGtVyMzWh4WcWah7uq/wLoGlc4TdZ1
         bHrvvYbh8B3q1MNWdZUPwfGxd3RyLFi0REo83l5ov4tJ8JdW7RbRf9nsxQEdDiola5nV
         c8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVkteDImX0oG7mWl3CG2PPojNLNd17jE0dwydQ25MNHGFGEPIdOy82DRmNkChd5U8vWgtlLrlD7Q1X/@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8xVhIhDhDfyQ+izk17+JhhalGJEmv9ZvlTKoyPVsk+6wVafFE
	FMmABwfB23EK9LCdlTMb2UARLNXzvYIineZDCXr3SrQf6rMIIrfsnlFBwELQlX2KDM4EokdKqGP
	/e6Nfqv4hmWaPeO2o/GuZKdevkXSkTUI=
X-Gm-Gg: ASbGnctL7oo4hcY52XWam7NXkG5eFC850Ul8ouNMh5A9DHiZatMr/up8e2X99QYPfEJ
	eWyxiHf0pJdFI/Vnm1T2Q5e7H+c6l3PUcfrGPwBINgCyOUyn+rZoMkL0X3RKVKqPf1r4lEgRbjg
	vlacftZ4kqmM72Jo4I31lOZ2B0FjQ/+PrQa90eaBiXXR67YtX80ionZDX+XNb0aCNc2ReYwb/6Y
	LRAUPmq3JKSW62qvdMXPVvSpX9a4Ll2tMsDY13+WDFWWiRWB+3JZF0LsTAlsg==
X-Google-Smtp-Source: AGHT+IE+xFiChCzxtr04Z/m0hJHXOGlxlY9sghAP+YSn081Tu2Yfu+cfyqhlLSp9kON5CcS1j+2jjKy17bEmWlTePus=
X-Received: by 2002:a53:c04a:0:10b0:63f:471b:c949 with SMTP id
 956f58d0204a3-63f6c616129mr746893d50.8.1761601450688; Mon, 27 Oct 2025
 14:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
In-Reply-To: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 27 Oct 2025 14:43:44 -0700
X-Gm-Features: AWmQ_bnvV0t5ky6UFYQzbXnCp5WgpWnjg1KKi8IcxED3HM8eS9psFtrfoDd9czM
Message-ID: <CABPRKS9aLHfaiTH6YSa6E3d5gQab-tUEmPYbr59X-ybg1p5ErQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] nvme-fc: fix blktests nvme/041
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Justin Tee <justin.tee@broadcom.com>, paul.ely@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_144412_434587_1125FC06 
X-CRM114-Status: UNSURE (   6.50  )
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

Hi Daniel,

Broadcom is currently evaluating this patchset and will provide feedback.

Thanks,
Justin

