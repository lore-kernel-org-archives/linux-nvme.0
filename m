Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FACCC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=crLVfxN9fm9fTijg1HrQ0nyI8CfzztjL+Ta28nC/v9c=; b=sdxuCOkv4gV9N4++BPOa+NNrSD
	beVQDASrODw6PAX8aoz0X+rVoVXoWi6Oc4scKOIROFVVokot1UBJSQSz72WkZb0LBS66fk5GFgIq/
	KgAt7vwTMXkBUeTq5WypegWuqvToSKk5u5M15GZvOzQnukxVAl9cQh0B+UfNeHoOto2QqZRI/8M6M
	UeARbRHrKa9fneINfPVvdbsyCd5hsUYcdBKJeIl61nh7ZmU7ImBvvzJA1C+e5Qj02x6Ab3pVpmNUw
	43RzmohA57xKfuxsjMbPquFbCm0/I3SS8vHftZi0EYH/q0VVCqN8af54pmN0aIPYAar9HHvP+qbkh
	KSWvTASg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFHsj-00G4M4-64; Wed, 02 Feb 2022 15:49:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFHlH-00G2Fl-N6
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 15:41:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CEB64615F9;
 Wed,  2 Feb 2022 15:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91563C004E1;
 Wed,  2 Feb 2022 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643816494;
 bh=q0vtIwN6HPkWQOS4+eyubzHjbM7ri9+tcZROTO3idNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cQFpyvzW+1ECeXH6pbXWrACYdlNLEh5hMaYxHQmnjbwBPYvuTmqBLFLTfmxiNf7bb
 5rIr1OakamGjK6T4tjEi5aCY6PZQX22APOgybADtQHMPmChGqjTKClxYPJW+Jgm8Pi
 2qtPwC2W1/RsCopYysJzyLMOhJ1RdoQZtGXKTp3esCouPqPNrf4PJcVgiORgBO5lNC
 X/4Idr6bB47BJO0VqXg9Tyr+CgI5vruq+i/sTGqS9QsS2ZPbQoNXM9yAO7+GgwXrBX
 LoQWddPi+52XF+MgyyntkSVP/Xoe4j6IjNjqBsjkrs1Er9LUoGzwYBdJb05cE3SB5k
 xIebLutsaw99Q==
Date: Wed, 2 Feb 2022 07:41:31 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv2 7/7] nvme: add support for enhanced metadata
Message-ID: <20220202154131.GA3077632@dhcp-10-100-145-180.wdc.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-8-kbusch@kernel.org>
 <aaf56d4b-8554-e677-119e-9d23c921fe0a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf56d4b-8554-e677-119e-9d23c921fe0a@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_074135_849345_4B696A9D 
X-CRM114-Status: GOOD (  18.97  )
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

On Wed, Feb 02, 2022 at 02:28:53PM +0100, Hannes Reinecke wrote:
> On 2/1/22 20:01, Keith Busch wrote:
> > +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > +			break;
> > +		case NVME_NVM_NS_64B_GUARD:
> > +			integrity.profile = &nvme_pi_type1_crc64

I just noticed this should be type3, not type1...

> > +			integrity.tag_size = sizeof(u16) + 6;
> > +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > +			break;
> > +		default:
> > +			integrity.profile = NULL;
> > +			break;
> > +		}
> >   		break;
> >   	case NVME_NS_DPS_PI_TYPE1:
> >   	case NVME_NS_DPS_PI_TYPE2:
> > -		integrity.profile = &t10_pi_type1_crc;
> > -		integrity.tag_size = sizeof(u16);
> > -		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > +		switch (ns->guard_type) {
> > +		case NVME_NVM_NS_16B_GUARD:
> > +			integrity.profile = &t10_pi_type1_crc;
> > +			integrity.tag_size = sizeof(u16);
> > +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > +			break;
> > +		case NVME_NVM_NS_64B_GUARD:
> > +			integrity.profile = &nvme_pi_type1_crc64;
> > +			integrity.tag_size = sizeof(u16);
> 
> Is that correct? Shouldn't it be '8' like in the above case?

For type1 and 2, I believe tag_size refers to the "application" tag,
which is 2 bytes here.

The reason it is 8 bytes for type3 is because there is no ref tag, so
that portion of the metadata becomes part of the opaque application
tag_size.

> > @@ -3104,7 +3218,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
> >   	if (ret < 0)
> >   		return ret;
> > -	ret = nvme_configure_acre(ctrl);
> > +	ret = nvme_configure_host_options(ctrl);
> >   	if (ret < 0)
> >   		return ret;
> 
> This could be made into a separate patch, is it's not directly related to PI
> support.

Well, the driver can't read the new PI formats without enabling host
supported features for it. Enabling the feature tells the controller
we're going to check for it, so I don't think we could reasonably split
this part into a prep patch from the part that sets up the PI formats.

