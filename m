Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394C3C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rak2jXyVCxsu9w36iXtNJY2CyxL6z5W907r16DRdiwI=; b=UKK1vtJDp9Z/UCk/mvkGXBmmfT
	GROlBd9zDym6ndgDWVpydAmqtDo50d5u61XerrjC5o6kHHtZBnquADmRJA3xlkiu7oF++XRts/FUZ
	HZvWvbbsozXVMEMFyHSDn6nFYhMKiyiYYJyhqI+g0LpbDILzEITOlQY92gqCLKxDoNSSs3rteuydF
	JeV4YZYH8zfCnOrV7Yw+eoIwbfjt+kMKlXAeOBOol4OwkKmioUPdY9HK9wIZkd6W4Sd8a5XZHFeV0
	49jaKsZXElaLAUQIj2U0twErijE/0d500uumjnIdABaWKYsTV8nGJYQW9d5iJGaFj31bNHq2mTKwO
	kOoI6s3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okSng-00DjgK-Gu; Mon, 17 Oct 2022 16:17:12 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okSne-00DjdX-6B
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 16:17:11 +0000
Received: by mail-lf1-x129.google.com with SMTP id r14so18316573lfm.2
        for <linux-nvme@lists.infradead.org>; Mon, 17 Oct 2022 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rak2jXyVCxsu9w36iXtNJY2CyxL6z5W907r16DRdiwI=;
        b=qj3B3/oU2nQdqq2/EcGkEys8V2zPRYKApYztZr1sDPMYN5/CrNBtG7eB/6Ji3jIBBZ
         gIwmtUxbvubxV6rNRe66HkTwWZHR/5tGnjaB4VssHYmLTanlCxnY+c2+D14TEexwHjfs
         oqP1Z56YT0KnmfPy/0V2VoRxK4ljmlWedjGvrg/DQVrbKRMX8UPqSJzUfFqWls1Cwzuh
         2ICcU7flL1ktzlxt+Pn3BgCrK93edMP4Z0xs/de9TkUZqQg5nrKxRrPyuIudn93F0ilU
         xr7gvfQ/0CgO3WwdLQ0wXuaDMJCtOp9nATXbbwxWuoH0omfnDm2D7ko6sOp5bettvNO4
         LhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rak2jXyVCxsu9w36iXtNJY2CyxL6z5W907r16DRdiwI=;
        b=el9krDw1mVgcuvv+0KECHVGEiQ4hRBQnpjmZ1mEsKS39NUdw9HtYaAHqCZ7/a9ZgzW
         e7Srdt62bqZegjZjhg2ppcPPdbq6WPJ57rLQAaz3iO3BFvXK3/4YDHaLeqFTbYAeMyvV
         HAM9YBgmv6Wu8eQw1bSSmmJbs4aMKvroCqtuLZWVUyxjHCmDzh4+S1cpe8lrcsJw8fhI
         bAtUj/BMU1Nlkp9vJAQnPZ3Xq8LR5DNt6jbXZhZk+lQHxmf9tG2165tZ7c2CdPe7bn3z
         YJpiUXAOw2PNKq2kkW3ry0FIfyUwdwRkaXl++PzQl+sIa+NqE/LTlKkRmAjJNTlOumnp
         z2ZA==
X-Gm-Message-State: ACrzQf3Oy8/nFDc5sFkZkEjbkhOgCaAhpGtGKxDqhQdOswxSddTkPViN
	PtoJ5umxnHz4M7W9iDLnt/0=
X-Google-Smtp-Source: AMsMyM7rH16sORrYUdovJN8ltutGjWM1TqM0J/X0Vt6B0RjtC0AlAtQyoO0LT81uFeRNEmMZRtvaYQ==
X-Received: by 2002:a05:6512:3247:b0:4a2:8dc4:3889 with SMTP id c7-20020a056512324700b004a28dc43889mr3983880lfr.410.1666023419345;
        Mon, 17 Oct 2022 09:16:59 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651204c600b0049ae3ed42e8sm1482468lfq.180.2022.10.17.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:16:58 -0700 (PDT)
Date: Mon, 17 Oct 2022 19:16:56 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nvme-hwmon: Kmalloc the NVME SMART log buffer
Message-ID: <20221017161656.hzmsgqpuvqpmriqs@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-3-Sergey.Semin@baikalelectronics.ru>
 <20221017071832.GB30661@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017071832.GB30661@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_091710_249778_6DD83BC8 
X-CRM114-Status: GOOD (  12.02  )
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

Hello Christoph

On Mon, Oct 17, 2022 at 09:18:32AM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-6.1.

Please note the applied patch doesn't comply with the Keith' notes
Link: https://lore.kernel.org/linux-nvme/YzxueNRODpry8L0%2F@kbusch-mbp.dhcp.thefacebook.com/
Meanwhile without patch #1 (having only the accepted by you patch
applied) the NVME hwmon init now seems contradicting: it ignores one
kmalloc failure (returns zero) but fails on another one (returns
-ENOMEM). I asked you to have a look at the patches #1 and #2 of the
series
Link: https://lore.kernel.org/linux-nvme/20221007100134.faaekmuqyd5vy34m@mobilestation/
and give your opinion whether the re-spin was required: take the
Keith' notes or keep the patches as is. Could you please clarify the
situation?

-Sergey

