Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7B3C4829D
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Feb 2024 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=; b=gof8UiuOvvNfyzlBfTMJ9E3kGe
	Cu325berE9lR77nJVzVXAj2w6ND0QOOuaYNocJCcqJjctc928038zWC1YdXunXT1+P98nDH7RMuSo
	wGJwrBmAes8ozw5W/5MvmZChyCbAQio6VEbXqvq67dTIHd/MQRy+XafbJjsDfIrWby+zS6L3vsJTd
	thQBu68zWb9j09PYytAvOdJKf4DWeUe2A4w12s15Oct+ewC0rbAF8bpifpQWgq97F/DF0FOyBZorX
	+Id4lESicvT4qncnEqA81XqtQgDd9bDvLM3F7OOBYOnbOqVBEfq2cbEljpfnMrLBXOphUDPh728nQ
	t21idjDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZCNO-00000002zEj-3Okt;
	Sun, 11 Feb 2024 16:08:18 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXodP-0000000BlAP-2Zgs
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 20:35:08 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso982419a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 07 Feb 2024 12:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1707338105; x=1707942905; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=;
        b=MKvevtS5aAHg7JX7RIGlO8Jk/nvpovZbX203B5Q5a9goNr7ECUr8XBKRfkTN4teQXf
         UVvBDHxATH2R6BR48OPpQs4rfkp08vsgPHp1jxTrD+5t+32G3cSQL9E4QorTqEAZzaN/
         xIDt76xnemiz/BZonSAElHIAqekTRnvklhn97p5lM1wz7cqvmviknwqAaImwqIPuwYVM
         Pkd8kgG1FnT5CxTUoZmAG6nnflD8YHfH/OlqSeIjM9rSGViPfoNuNm3fHaARzUpIIGYy
         3jnDGZGSFltGLOwQoJs5gLL2lVq9gCK26QwYrr5shz7pMhHjjlPIpINNOIZTZf3B2D7r
         4UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338105; x=1707942905;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=;
        b=ItjLvbMvhXtbeeEXhW6bRNgSkXG8oWQELo6sePCWx6cILoXfKTxRGL05vXrKpXGQeJ
         K7KFuLqYe+1sl/N/4onh/UI6duaeEb0/DP4CNRZQeHkPmpmM9AQp3bIJge2b3ESuHN+/
         PJ6GcBkUhOz5bBY83GOiiZcRdjlezMDKRfkJk371UOW3icREbX234sNY2fUNNavR9reO
         OaTbdAlmnrvRmwxQ3cYIS+pZnYHrqFfRf93zOy1J1Rk7ystyaIdIflkVrs4ynwu1CTSt
         wdbqBRdMsijOUk0tsYRsdlujQDWXOlXckXWjpc+JC079k8VBLJ+7/EGp/QGlbxQwKwjH
         Fp0g==
X-Gm-Message-State: AOJu0Ywg5vDAO4k/IXlrTC+4DUHq30J2p+b0RQ+xTwbJSdg6VzMn6ZPw
	n87tH3ARsNnZaBC+6exVYPNZRyEps3x23TZ4f8qvr7merFbIWdj9GYlN+lV0uzW3YUunLhSgIZ7
	wkxIBmUTlYqZWjQgAgIhuWzcMEdV5PGTtGHBj9qTZxL40gWmWdpU=
X-Google-Smtp-Source: AGHT+IGG+jMugKQsGtnsDpLxeX635/9flpe9WYYdtfpZiAfBXQJ/h2yWeqKomRpEPSdDF0AvOQx/MxjPQQIih4x/IrE=
X-Received: by 2002:a05:6a20:e608:b0:19e:a3d8:fb5b with SMTP id
 my8-20020a056a20e60800b0019ea3d8fb5bmr3344322pzb.56.1707338105218; Wed, 07
 Feb 2024 12:35:05 -0800 (PST)
MIME-Version: 1.0
From: Jeremy Allison <jallison@ciq.com>
Date: Wed, 7 Feb 2024 12:34:54 -0800
Message-ID: <CADfv6Ka0M947muKa7hSuVv5Ot_tonmFNBYyrkzCQ5_KUVqN6YQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] async device shutdown support
To: linux-nvme@lists.infradead.org, Jeremy Allison <jallison@ciq.com>, jra@samba.org, 
	rafael@kernel.org, Tanjore Suresh <tansuresh@google.com>, linux-kernel@vger.kernel.org, 
	djeffery@redhat.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_123507_684667_3594647E 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 11 Feb 2024 08:08:17 -0800
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

> This is another attempt to implement an acceptable implementation of async
> device shutdown, inspired by a previous attempt by Tanjore Suresh. For
> systems with many disks, async shutdown can greatly reduce shutdown times
> from having slow operations run in parallel. The older patches were rejected,
> with this new implementation attempting to fix my understanding of the flaws
> in the older patches

Hi David,

It may have escaped your notice that I was shepherding a newer version
of Tanjore's original patchset through the nvme lists already. Please
look at version 5 here (I am working on version 6 currently).

https://lore.kernel.org/linux-nvme/20240129181953.1183084-1-jallison@ciq.com/

As your work is very similar (although has some of the same problems
that people already asked me to fix in earlier versions of the code)
maybe we can collaborate on getting a unified version of this work
reviewed.

Please take a look at the link above, and see if we can merge our efforts.

Thanks !

Jeremy Allison / CIQ.
Samba Team.

