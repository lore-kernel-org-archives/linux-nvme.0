Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEBCC433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Feb 2022 21:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MDfbIH+1rwGOBC6Y1aHVKe4Wbg5oKkRdr66WcviiZBc=; b=t5kQMsUrghK09p1aUuw0VLWSfC
	DwSkpsTovFnEce4qfMTVHiCi4D2t3ieH6X847bb2P4l81jcwbcSo33FQ2Xe0bHsrNDSU9bX3WdGmV
	15vDBoNE/3RFTmwJ4lvQeD0mi5V5stP3H+HAifjJDmt/czwmXb5D2BzVzJANXIRaxh5LiAQTay/Nr
	S2jJX8IJqIOYRvaM0+BmNtKft2h428MQVbpMx7s5YnFF0uy01jba8ZWySei0czm+l12bsXUXBjdAX
	AA/I35j+XTEbXMElVLbzUUMZuiNsEAP6kYzYtUE6kqnmC92bLXIyP9dsdEWAosLEiPO/+tQrOuEGu
	SGuyitBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIzXs-00AYEg-PG; Sat, 12 Feb 2022 21:03:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIzXp-00AYED-Md
 for linux-nvme@lists.infradead.org; Sat, 12 Feb 2022 21:03:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 47EC260E05;
 Sat, 12 Feb 2022 21:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466F1C340E7;
 Sat, 12 Feb 2022 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644699780;
 bh=soOkTierHC/obq+By1oORX6E7pYL9xn0OvQ3Pl07MRM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YkWNDPVdJek00rYbRliXWhYfSq9MgbBZMhn1FB0kKrHKcfkMkfk/hQditzO1SWwQI
 j/UXqtnhjw/d4gzqIiGbwi6OiS+lEeLq+GmLNrJ3UTuH7vEzf45mw7XoJSPcbVBekF
 s8k77C6YcyffBBkd3l5ZrC0EjdCuBd08aIv/POICekPMVTq1KeJqKqdoN3jrGaJHJP
 GqWYli9SHfd9wJ/3CXjk8UWh27AyQqzcgeztgl2IDv9O67RzknnxUDnZ6gVWamYPgr
 Kv3mxSTFaxUPdS6dIXn4u/oMlqJ+tmkg9b/V6GhwleMbHfUBBV4Sw81Ai9PYgw6fBx
 rT1eXGRLOc3hA==
Date: Sat, 12 Feb 2022 13:02:58 -0800
From: Keith Busch <kbusch@kernel.org>
To: Matt Waltz <matthewwaltzis@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix prp list allocation
Message-ID: <20220212210258.GA1660900@dhcp-10-100-145-180.wdc.com>
References: <20220212200649.541061-1-matthewwaltzis@gmail.com>
 <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
 <CABwBYcb0XhomznNOV62uH3Yo1J7XjHowuhF3H36owXtiVSp8JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABwBYcb0XhomznNOV62uH3Yo1J7XjHowuhF3H36owXtiVSp8JQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220212_130301_798069_13174306 
X-CRM114-Status: GOOD (  14.56  )
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

On Sat, Feb 12, 2022 at 01:53:59PM -0700, Matt Waltz wrote:
> That is the wrong part of the specification, describing the PRP entries,
> not the list pointer. 

The text for qword alignment rules specifically says "PRP List entry",
as is associated with command's prp2 field.

> The relevant portion of the spec (2.0a figure
> 109 page 129) says:
> 
>     If this entry is not the first PRP entry in the command or a
>     PRP List pointer in a command, then the Offset portion of this
>     field shall be cleared to 0h

That only applies to chaining list elements. It does not apply to the
"PRP list pointer in a command". The driver allocates from the 256B dma
pool only for the command's PRP list pointer, so we're fine.

