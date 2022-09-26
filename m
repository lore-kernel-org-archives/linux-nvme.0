Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5B9C32771
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AeGYPkz2x8jcvNXUE5KPVrnPBM5osWqcHiU7r2l4Ujs=; b=puw06UdvoEi3zAcJUzUefMiPaw
	UEgkNZdL5OX9arB1ms8ZQKZ++w8+8jALDInj3UxSjZw6qNX43p7oGMEHybCDbfjx91Y0uheTMAOYf
	H8udPcO3XZu7atFWbuwttN3Pkrb+DzVM3Pf84gmDbtkJzd+OFEdbKlDnn8BvQd1jV32mc277jU6hO
	L+4r/fF24onKwvLCWvF2ynV3qoqFEjDC+UhjZqWNhmh7fhrp/iJdk2ALmaDbZexpCouthXhRxFQes
	4WlLKviHmmVZuVAemYfqzBYlDopjhDIpI92g5MSfoxlOxZn8aWumKbZgp4NknxlMlRa0gKlVcE9fz
	Ul8vJg0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1octTF-006Yku-Na; Mon, 26 Sep 2022 19:08:49 +0000
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1octOj-006WgF-Pa
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 19:04:11 +0000
Received: by mail-lj1-x22f.google.com with SMTP id l12so8513195ljg.9
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AeGYPkz2x8jcvNXUE5KPVrnPBM5osWqcHiU7r2l4Ujs=;
        b=XYFoUF7rhLBiYKg3bdP9IKfPBnKpMmi9C52dIyzF4IOPmFbAANkfjxNTZLk6zCMmDl
         A3mq7wBdllf83I19p0J9fy81moHDQ6VFqmatYzDRmOiEjbRIB583+kVaLgJdlO4aESkO
         U4WoMdBdmJrTOi0b78lJjT5+BQmSGdxUcxzYStdXcWU3OeVlGZcF5VbQRjWs5tWnEVL6
         D96yOaTXgvA6RYsYbBtcy5275B8I9z+kV1Dup6ArESWHRsxQsObui/DPiQYR7B3toN1a
         kkxW/r0GTnJ0Oy1OwVKXToO7oK/rjbHSOXn4K5CbpWdL0h1QKkTgDPw0Qo/0Dy/yCyyT
         F/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AeGYPkz2x8jcvNXUE5KPVrnPBM5osWqcHiU7r2l4Ujs=;
        b=mtAqxN/ow/tJe1OFDlCKNNzXO0tNwp6K0QETemliCbahw+BstXIOnhnmUMt5p68EYv
         kZbd9Ks2gdwbqcfDCU8yjeGRaTlkIo5G0fkQUC9Dm+0t/L+HhnbPkip4SDh2z5BD79Dx
         NvDHQiDV4PntFNgxC4DbB8nvU1Uw0c2prsHsa58dDuNO/dWovM1JAzhZkrOckBEjKUr9
         w1uveK143JRAHRmhS5WVeKhpsDwJaUXXTofh50MQKxkXgrqKDvvh9iJ1kSLFDwWD2eWp
         rJsUIy2dVzad/V3gesZ+y8guLYBWbh+mCHdUZS2sTGdkfemxShqIbv7TXs2x+G1hUU/6
         N8Og==
X-Gm-Message-State: ACrzQf0MxXHxAILpqZOo2m2C9b0I/C1isGnFEDrOFO2SQGYQS/VvfUhQ
	2UzUkgVUHMpcaKY4DhhhVdBXHzMetkgjPA==
X-Google-Smtp-Source: AMsMyM4Exx0LUG/MKfdR62HORsHNUq7/T8J0dlOM8Y7tMjvWP9YsMaHOr+jd54V/Yx7HRvGTYCqRHg==
X-Received: by 2002:a2e:ba15:0:b0:26c:1798:b178 with SMTP id p21-20020a2eba15000000b0026c1798b178mr7710795lja.19.1664219045898;
        Mon, 26 Sep 2022 12:04:05 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b004896ed8dce3sm2623603lfg.2.2022.09.26.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:04:05 -0700 (PDT)
Date: Mon, 26 Sep 2022 22:04:02 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220926190402.zyngr6bq6sicv6uw@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
 <20220910123542.tzxg2blegw55z5fj@mobilestation>
 <20220912082909.GA10666@lst.de>
 <20220925222325.irltbraf4e2j4vtq@mobilestation>
 <20220926143959.GA19918@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926143959.GA19918@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_120409_868625_C5420F5C 
X-CRM114-Status: GOOD (  16.73  )
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

On Mon, Sep 26, 2022 at 04:39:59PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 01:23:25AM +0300, Serge Semin wrote:
> > IMO both the approaches seem unclear if a reader doesn't know what
> > they have been introduced for. Anyway do you insist on using the
> > kmalloc-ed buffer here instead? If so I'll resubmit the series with
> > this patch updated accordingly.
> 

> I don't like the __aligend version too much, but I can live with it if
> you strongly prefer it.

What about converting the NVME hwmon driver to using the kmalloc'ed
buffer (seeing the rest of the NVME core driver prefer kmallocing the
buffers) and adding the ____cacheline_aligned modifier to the opal_dev
buffers?

-Sergey

