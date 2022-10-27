Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74384FA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uXblEfSydcm72odnX+OTB9/24pp2J4NP3/7dMqOcxWM=; b=AShVfu64vjDXw3nB4zYFmxQ6Qs
	bAoNIDjO34bBDHl3Wz4K3UDdL2VJreadZ5XUkEPl306dBI896S5MLy5ehhy0jxPDIXOe7JhFCk7mr
	VKcMCALdVyGyGBWf+cvQPrY8U+FnpZH6OuAJS6Cu8fxrytFsoafa+KA2oFuxzR6xmlogwcWtgzM7u
	h7UFti2sxsROKWVJLb+jBLG4FRx1pl61jIL/VtzHPb2TD/oOKZbksIG9tnxFfMGWKwH9xVr+Q5Oth
	XfmEj6ssRu3VNicoERHMY2q16bOYzdYaN1N0g3fszj4gzMZjNJW0V+gAAZiATYBaPy67hXxSmuPA/
	EXKEfjAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6K6-00EIHs-Pm; Thu, 27 Oct 2022 17:05:42 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6K2-00EIHO-Sd
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 17:05:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7BC12B82561;
	Thu, 27 Oct 2022 17:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378F8C433D6;
	Thu, 27 Oct 2022 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666890337;
	bh=S1ooH1MY4BzEoq2AVhkBgYAov+/dNn2DY4f3vpBzPTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NasyEgbzYmJY6qeIEUVRV8FbROhmKlmGXlHJJDzVA+beKF/XgGweQpHNXj2kze5p4
	 LvyOzax7MeAnzml3BXm7zFVfqARseyQub4BoF4DVhPY4xqdzLCfuBq7yjU1qH4wI0m
	 3tk8IYGXWIy1WpWN6k1uJ9u0XFQWhAiso3p+x8zVnfr/phuvdNbn+Im8PY8lamu567
	 RcwY4HWS7ISNo2nTXMn9wBXUPSyf9J7SBjro5wHu8kHrUmIZHodLBHCQ7TVi5pJ5W7
	 XdXEEiVZd2jPQRkNY9DRJyMRoJuI0TS2XbgUsd/g1q5J6LzKUgycgZ9/lmS6QPal8e
	 AMzP6093LHA/w==
Date: Thu, 27 Oct 2022 11:05:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 07/19] nvme: Don't hardcode the data len for pr
 commands
Message-ID: <Y1q6XsMuS6W1Tz8n@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-8-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-8-michael.christie@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_100539_093863_76F27C58 
X-CRM114-Status: UNSURE (   9.80  )
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

On Wed, Oct 26, 2022 at 06:19:33PM -0500, Mike Christie wrote:
> Reservation Report support needs to pass in a variable sized buffer, so
> this patch has the pr command helpers take a data length argument.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

