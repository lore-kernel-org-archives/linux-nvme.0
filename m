Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F36E63FE8
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mKGFGRC8Ir/bEzi2WUjXo1t2+zLxBk0Rpi89ZF+PFE=; b=ue9VfuM3HyzeXPI+Ervi60KWwM
	JqVhxuJTCzLOWgwQc8rxCzO0XFHjhrsIDd2S42rpGELsthE/BSkt1CfLs9dXLDh+waKXJK60AcQ+F
	ZFuGlG/CVpIVR8P9gehaXQjfjwDufg9p8RigHJjp6BZEITxyjakwH93y0WwtotmxATl4zOw3TeZL5
	JeSuIy68IkMO8z4OoD5YuUnDyFqQ3vBTkUFJ+rEbba0/2YZy4/p1iDUH6RCU3FknJX/591vpDu3zm
	gNmlRoNcLR3cVVTtLNt8bFSUVaxeyyp/PIE3drq/lK9/CykNvrM+wp97COvAqdo7xCfnHKA6wtGuB
	PLdnKbGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9LdZ-000000049iO-3r2d;
	Sun, 05 Apr 2026 11:27:29 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9LdX-000000049i2-2uJz
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 11:27:28 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-66e8cc714fbso1644140a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 04:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388445; cv=none;
        d=google.com; s=arc-20240605;
        b=HIzX7VjbNCxSXDBSPcnr3KCEJqTPse2sKm6nQstuZgCEKlHfXxk1h9unyTRjyyxwlV
         kBflLm1GyIqmEB2+Ym7NzsWACSeX630KN8h+vHhWbLYQhuFRR2/M+vGorYStR8TR/SXL
         P2QWdEBLyWUjWO8VaCya7blX3RFDdK3RssDJT8oqCl/EJnNhq+27zVO3L8PtmKtfnfe+
         gKraC6BAM918oUTMzOS/n/2siN0J/kmw5oVnEcDEmE4DZsGK+8SKAcMNLa0xTMXyBcY1
         JcwEnDA6JzINAf4dkPSR+w2nfDFpnAOsyVh61T7nXHSj+gc2D8YFpJR6wN3O8rwtHz+C
         33pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3mKGFGRC8Ir/bEzi2WUjXo1t2+zLxBk0Rpi89ZF+PFE=;
        fh=kIP+TZk1C1sekv06Com7+feg8m64Opjp35CVIFWK6UA=;
        b=L+RdG842ksT6tEUoXERPn2JHzLg37qri+hDHlVXTvgGFTJtPNLUVl8tHp/RSAZid1o
         afoaivCbcDlVl1O/Wni1kVe4AEKmk59513jLTQ2nLLSB6SeNemLUU5OQaIcPRb0VPZcb
         WpTDjeZ7CK7ZfY7s48Dgf6HIvZRqQYmWtpNBd4w6Vz9JbYSXwJBCF+nK6yWRxAff/Kd0
         VX1vSt0/INDMp0ixSROas7Bx+rUTuTNYri7d6TnS1YZk1yMgWZ628dN9Tql/O9UHkApZ
         fHkbnr8feYT9D0oOF7vNlsu6HVDLJacLYwVyDhQaxnpMI2HB6JEZ5bMg7ieuN85FRhZg
         0+VA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388445; x=1775993245; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mKGFGRC8Ir/bEzi2WUjXo1t2+zLxBk0Rpi89ZF+PFE=;
        b=mrvLdgSbR6J0RhUS6xEDrBTqDb4N25OKQnQxx4Tzhl3nMSZqYQl9HzA5Ri6hOFW5v5
         gyLSEtHM5hav/2+Lj3j5fCxgEGyRaYqIW9agvisAkkirRFaXzPVXGxIDhYYM0rHwgpo/
         dDGX+otFB33qWgzpWnEqZoej5wTwhvzC7c3CdUlHRRQyO37vLGt64q2+okkyiGXljeDi
         NtQOOdqKcypKynn9ll9bR9Wo/ts7rPsqblM/lGbjqoV9mJBiv+jbgBnsaGpf3eih6ptj
         Uqfqdn//VnMVR/KAIllYj9tYMSITMzBGd3lJEBa83UoIFBntjHBWdE9wolig2Ivw4kGt
         ZZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388445; x=1775993245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mKGFGRC8Ir/bEzi2WUjXo1t2+zLxBk0Rpi89ZF+PFE=;
        b=n/Wy36iAnReCJ+xTuQul/JaAB7STr0kKxOC1VVbUjQjPo/FayHXKehE5u+UKEFJzZ/
         H4cFq8rUe5YzqIdL9kAT9VhsgvwIFiM1ajCQfCLSIbFCSVklWGqwu5ag1eJFSy5vv73W
         ZtreBMlqaEGqvMVmczAXU0NCdeCE7JabJXwBLttGVr8zkaJ8sSo+xXZALExfoz+JuMEt
         CfrdzgikXrnJNoUf5BWk1cmowhXYpn9g0Bhxnbb0F2ulVE5KMA/NAlVVTkKZqlrryhhx
         m1tnR/xfgdz3enma2yJKsDK3krCKlVpRfEC9GBpoOt7zn889iXVBYZx8ySATOyEt6rUf
         lI6g==
X-Forwarded-Encrypted: i=1; AJvYcCUmHVKLXAzLWo+rTczPg+bWUUmStfpL4mWzHEFFIJg8qbVNn6bN6X8CeYdlcp6aIZb4jzsRFuEdO5QJ@lists.infradead.org
X-Gm-Message-State: AOJu0YxZrXe9g7grY9CpYyBnG8DMfnOa9RhqRB2QIljeaZ5VTztJ8QZ4
	4bbIZo8Jol81p17P+RtgZSIHipKbZf0YNDO6Xw1/DU5TJ3/dKStXa6N2zyQuFM6ZldZ8w9pjwK5
	/Ml1cFZxDp8WRtygO1ZMm2rygcIj9xQ==
X-Gm-Gg: AeBDiev0gVnpXmhNnurpVz1kXqCibnhNRKFG/5weF9oLmLBYBh3JQz66L3Gh2Az3L9y
	Q97BU26WTkDKXCq3BsWtwbGdweORZ3xa9KwTKKSays/Na/9nE79pfwqh0MjI5FtdpiKRRk4iml2
	mvh6ZAVAbs/Kxo7Xps0lO1EnKPR+DYFGkI5aSLjHNhTM85NdbHm2jBCcMGf4zBbwxxUqE3PyJ/6
	nuaKD0LlxObuMa58+TyDY12Qw1gOw1jcFrwlT+gAxYfF/7ao7CKF3QMhjQtQj2IM2jwm/18p56p
	slQzZRM0XiF1nfx3wWasWtsj6gNRJ6FElhmahkAUNU5sUSO2lV79sxQUSL5pWW2wVe063w==
X-Received: by 2002:a05:6402:274e:b0:66e:dfdf:cf1e with SMTP id
 4fb4d7f45d1cf-66edfdfcfa5mr545956a12.27.1775388444505; Sun, 05 Apr 2026
 04:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:56:46 +0530
X-Gm-Features: AQROBzDs0E7EbtHWRnG-_oRVFkR49Vyn1zNqbc_cUv_MF4CXocoxU69uiac_8Sw
Message-ID: <CACzX3AvwQ87hL4GOBmpiGDYGqvb9O_HVjkS_e+-jLiJGgA7HPg@mail.gmail.com>
Subject: Re: [PATCH 0/6] block: fix integrity offset/length conversions
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_042727_783667_0A259C1F 
X-CRM114-Status: GOOD (  12.79  )
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

> The block layer's integrity code currently sets the seed (initial
> reference tag) in units of 512-byte sectors but increments it in units
> of integrity intervals. Not only do the T10 DIF formats require ref tags
> to be the lower bits of the logical block address, but mixing the two
> units means the ref tags used for a particular logical block vary based
> on its offset within a read/write request. This looks to be a
> longstanding bug affecting block devices that support integrity with
> block sizes > 512 bytes; I'm surprised it wasn't noticed before.
>
This likely went unnoticed because the remap path compensates for it:
blk_integrity_prepare() rewrites the host-side sector-based ref tag to
the correct device-visible interval/LBA value, and
blk_integrity_complete() rewrites it back on reads. So for block-auto
PI, and for the FS-PI path that goes through the same remap, the
device-facing ref tag still comes out correct even though the host-side
seed is semantically wrong.

