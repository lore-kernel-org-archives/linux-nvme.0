Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D27C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0vQQkx+jTFQ392YcBDPfFQx7iotxSMrP46oEZAjKyk=; b=wiYtpWTIROAKieFYIFAOfN31JE
	ZMhfh20iw24DV6F5KMHdBHRonuRjNkD0mJRvbcLHDaBtFnPbBixkatMAeksm0/3OoiIzKyA/GGhFu
	XU4pWxO9V4sa/Wp8kioPgE9IQrQfM2nDZDcnHBP+n+sPhO9m96XGoqJUJ18h4TLEOQqlObqlU6VOz
	ITBKylpISbqURBsFdH4BRBtwnw30PwMbN6y+hjxWClLPXzpux0dO+j0fXRjhyWNr+lUaogstWgqfi
	5ChgCrPfyAVdptaLaMjT1WPPyCysc9ddkFPSvXHk3kUg0SjgrnzwRJ5qbpKlTvwukXDvhs4+W9OLb
	uUhLN1iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQ9SU-00AeBA-56; Fri, 04 Mar 2022 15:03:06 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQ9SR-00AeA0-Ny
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 15:03:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BC322B829BB;
 Fri,  4 Mar 2022 15:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA16C340E9;
 Fri,  4 Mar 2022 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646406180;
 bh=q/5HTsfHv6Qp7MvW9s/gAPx713GuVfILXBu+XgJHFHw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aRtpdfZxtf2YM6tfcM2HKnxubE4/UPqmqWo/cFlqL0fvmAMMZtISZN2CD1Dk3llXm
 GtsQ+tUb3UKDW6N0d04uVW08AzTmrBkfl5G+ksitG/UNI16/IpV3Lw8wmgGGD8oFUD
 9Lpj+UOtPPuRXrJLXVTrEYajLGUAzul9Gf0QzYE9ZH3PlG2xiY9e/EMsl2W0jz9hDD
 H/yUOW01blipNHdPeMnWy9orQKtWvJ14TJPAQaCw0RXpOL7RDT7apapITaZTBcmiHV
 rgur2JD4ziS6nKSygDiQsvoyT+lCRrm7sCk5pheSSZrGq9TPr4dQI9q/UbnPTJKJZ2
 EgGaqDJGUKPUA==
Date: Fri, 4 Mar 2022 07:02:57 -0800
From: Keith Busch <kbusch@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv4 5/8] lib: add rocksoft model crc64
Message-ID: <20220304150257.GD2824821@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-6-kbusch@kernel.org>
 <30e059eca211460780442e2ded092722@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e059eca211460780442e2ded092722@AcuMS.aculab.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_070303_944151_FB630FEC 
X-CRM114-Status: GOOD (  15.03  )
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

On Fri, Mar 04, 2022 at 07:53:44AM +0000, David Laight wrote:
> 
> That can be speeded up by using the identity:
> 	table[x ^ y] == table[x] ^ table[y]
> 
> something like:
> 	crc = poly;  /* actually crc(1) */
> 	table[0] = 0;
> 	table[1] = crc;
> 	for (i = 2; i < 8; i++) [
> 		crc = crc & 1 ? (crc >> 1) ^ poly : crc >> 1;
> 		for (j = 0; j < 1u << i; j++)
> 			table[j + (1i << i)] = table[j] ^ crc;
> 	}
> 
> I think the same code can be used for a normal MSB first crc
> provided both the polynomial and crc(1) are passed in.
> 
> OTOH initialisation speed may not matter.

I don't think speed is an issue here. This part is executed just once
for the initial kernel compile, then never again.

