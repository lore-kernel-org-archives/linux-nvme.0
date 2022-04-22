Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A7C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Apr 2022 04:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tO/NuuzDUgzYZTtFS9xpepnA5UfTV+BH36AOHZcL8lI=; b=dXYt3L6RV7+BuzQvJr9IRv+eke
	hFUYQuEWyvNrVIPVrs/aC1mlR5AJdd3bi4PY2t2ZU5IYzVRtvHR+sSwJak+xZEQhXRakLBtd32yQo
	GXAOGxDSiZa1wFQUkQuDNRsZb1uRpUll75jOiSEe/FBhbUedUYaDR87k+BnjxgF6u0esYW2XXCAwT
	IDbePlh56+Y8whwLdhjcGjc/aCd1+pw+n18NyMi3G8V32aKfeBhN98eOMfEFFcEOSaU4UuDhiwfTQ
	Y+u5PdvEnhEtgFBW0iXaIsGyIAuncG06inT4bxutW8u7X+A0no8nJ7GS4A18PaFQK0HOzVO+f5gVu
	coJ9V7ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhlGC-00G7I3-Ad; Fri, 22 Apr 2022 04:51:12 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhlG9-00G7HC-P9
 for linux-nvme@lists.infradead.org; Fri, 22 Apr 2022 04:51:11 +0000
Received: by mail-io1-xd2d.google.com with SMTP id y85so7525689iof.3
 for <linux-nvme@lists.infradead.org>; Thu, 21 Apr 2022 21:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=databricks.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=tO/NuuzDUgzYZTtFS9xpepnA5UfTV+BH36AOHZcL8lI=;
 b=mjVnaXJlfArZKe/ASaSJt+i3eETKivF78Z+TUUyUy86NWAJoPhRuTyNW9IAc/BfCQ4
 ULEN+MO2xTOiZOK+sjqL9FsLhsXbrnpks95F3UFMPhtyZXd4mqd2Ue1WrJGTqkguRWwT
 fMRyjAZxHC1mca1J7sU8BllB9j3vSipnEQpjVS/qT+dAwbrMBMVIvleENH/UXBgpXWWK
 GL4+dyukavATgqVYkfaKBFqhPubBgctcNR6wJ6AvoJXxWuGtssGXY45KG/yi/L9Z43zm
 CKlB0UdyIC/yM1Ad2gA+nxv1snMokiW7ReYcyK1UYrw9kxi+sdOBmC0QWjBs/7P+Xla2
 v8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=tO/NuuzDUgzYZTtFS9xpepnA5UfTV+BH36AOHZcL8lI=;
 b=rer8jLvSF9WMhjL4uhK08hormpT8gdzyWNlcYpjaLkzAq/caxKVB4jzfFbI644c0Rn
 85Yx2V6oC7cxNByU/sUR4faPG7dQoJU2CT19nIJOlo7LRw/W5hm34mVaZxGl2CRQfoMZ
 C+mpppxgxJlGIt2c6BQEBElbvxHfy97T7D6RZJMg6SV0Trt2dDWL16hHaBPn+grCpg1G
 k9weSCmQg8tHTzp7ULrU+/WlpfgX1DySUjA5c33+kIWkNespyqA/MMTH5tI2qDwnFtwS
 EfzFEM3e5/3+XcGx9SEY/FNSJaCc2Qkw/AWuELfBoqGUwfZlJtmKoKvpfBskGebFEi0O
 CYhw==
X-Gm-Message-State: AOAM533tVaB7Ag5LPR6Kd1eFRcVxG0h8o+srexwXu6L5iA27bLQoFisg
 BaxcseNZqiUpiX9hhg5NHy4MC8FH8ab+CjUapMuECBrr+YvV4w==
X-Google-Smtp-Source: ABdhPJxE8xJLh0Rcnrr+Ts1PBv8XNywPxOX+aNUWQhAXTRUk0hHHRHLhR+qNLFZgZShcZ6NVvV59KvIafx7ByGrz/PA=
X-Received: by 2002:a05:6638:4815:b0:328:85fc:1915 with SMTP id
 cp21-20020a056638481500b0032885fc1915mr1290847jab.82.1650603068186; Thu, 21
 Apr 2022 21:51:08 -0700 (PDT)
MIME-Version: 1.0
From: Shuo Chen <shuo.chen@databricks.com>
Date: Thu, 21 Apr 2022 21:50:58 -0700
Message-ID: <CADb2eF902UkdnOpoj1w1MGT70fg0fdsoDhRBNjOK-jkE3HYF-g@mail.gmail.com>
Subject: Ask advise for disk safely reuse
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_215109_868560_A1ABBDF2 
X-CRM114-Status: UNSURE (   7.13  )
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

Hi teams,
I am investigating how to safely reuse the disk between different
customers and do a safe data cleaning. From the nvme-cli I see three
options:
nvme format
nvme sanitize
nvme write-zeros

I've tried all of these three methods and it looks like I can not read
any previous data by using the "dd" command anymore. I wonder what is
the difference between these three? My concern is writing zeros to the
whole disk is really time consuming, as a result, I wonder whether
"nvme format" is good enough to wipe the data.
Thanks

