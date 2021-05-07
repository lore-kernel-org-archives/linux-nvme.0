Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE92C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 20:41:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47BC6140F
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 20:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47BC6140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XOBvChFoiSJTg7YFfiZsHad0sLJWgJA1Wo5zTbi9Vjw=; b=HzuvMGft3WNyO3rBKvHluOUgv
	e/3V32I7NjX12P1opc7z9GJJyvvM3vc0aP0iWMy8Zqozu28RaLz02GSl78UBT5EcjyyosYv4AY5rH
	PSMitOQ8HbhykEVaZMK6U1mGNK+crdVQYBJMing6YVLz/5yLGo4MywPkcBjrKYrhamUeBnaOEWtTk
	BPSlAKNPqPcXO7oME/IB/iksZcOvBaWS8uZwIzj6dzPNq5Ue/yF+YFSWQ0eOYGVQh2LSRWe2QrFyQ
	bK/sSdri9npweUDbVVyMGDEPYCEP/WZxTdI1lx7bFMbDUwGMGT2Qw+PnZc00wIFZu/M1+CV2PS8wR
	SWI+ElQhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf7HQ-0080o8-MS; Fri, 07 May 2021 20:41:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf7HO-0080nz-9q
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 20:40:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Op7WIh3uoJnPgaiOZpvCcREx/EJw+LIpVnYhpNKw7Qc=; b=G2flqU7avzgcYTKhdjg2x+QdUm
 +WGnq8QxH2WV4wd16wReE3ZI4TDBaHbnygvnuPCq+UNo1B0B3Ge2i8jrZf0vLmAn3tYeCqaDfFE/7
 7Uqjg2vWgo2e4uchGdigF+jaxI6lfpqgcJSLnaqp/EulXa+cEbqH9zLj1ahyFixu0Dq4iOJpwpsin
 3Glc7SX6tMGoMBOZK2bCuM4UAVqQ2bVckktKnnV2F+PCR9CUrdRJfMsJP4O41/CqhaJSt+7Cak1Rh
 6AXQK91Zr4QgRz6HK69o4kqeCj7HPwa8NyowQx9V4XqbC13SkvBNY8HBExtGUzLoZfDSo5nIln0Rv
 dXF/7GOQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf7HL-007AgO-PD
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 20:40:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5F4961451;
 Fri,  7 May 2021 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620420055;
 bh=kuhZl1cpux8KIahaPtnjkqBK3+KnZu5S/hlyXMn3NGc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FXyiiYiJ3Y5BsCajBgft+PmS4Sv/U1tkuNTGEOAmHEdLN2eIxz/oXUGnyRGMOijek
 2NMdcNZ61cvlDUiTXbvmXD4jAaY5/KMbMLmW0Gm1koVkPRZSlTsZuSTxoXo9KvCVSX
 LoJ6l0sKfEiCTunEuPdi9xn1lbCbTCS0kwutB5y9hMeGGsIpy5qML37ZjICfOaUcLw
 fX+zGhgGFccCV1y5IUTbkjrfaKNvyhWl2LmE39iYiazXBG637hrBrwkUwsMcYpFmi+
 kyn9qm5nc+YIUuPG2fVSJ7/EIib3uFzqUGKXLYJKeMpzJKn1OoB2qZBmVAzV7Fasrc
 xuW3pK2UPyxYQ==
Date: Fri, 7 May 2021 13:40:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, "Ewan D. Milne" <emilne@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_134055_863762_B2945FD0 
X-CRM114-Status: GOOD (  29.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 07, 2021 at 01:26:11PM -0700, Sagi Grimberg wrote:
> 
> > > > > I would also mention, that a crash is not even the scariest issue that
> > > > > we can see here, because if the request happened to be reused we are
> > > > > in the silent data corruption realm...
> > > > 
> > > > If this does happen, I think we have to come up with some way to
> > > > mitigate it. We're not utilizing the full 16 bits of the command_id, so
> > > > maybe we can append something like a generation sequence number that can
> > > > be checked for validity.
> > > 
> > > That's actually a great idea. scsi needs unique tags so it encodes the
> > > hwq in the upper 16 bits giving the actual tag the lower 16 bits which
> > > is more than enough for a single queue. We can do the same with
> > > a gencnt that will increment in both submission and completion and we
> > > can validate against it.
> > > 
> > > This will be useful for all transports, so maintaining it in
> > > nvme_req(rq)->genctr and introducing a helper like:
> > > rq = nvme_find_tag(tagset, cqe->command_id)
> > > That will filter genctr, locate the request.
> > > 
> > > Also:
> > > nvme_validate_request_gen(rq, cqe->command_id) that would
> > > compare against it.
> > > 
> > > 
> > > And then a helper to set the command_id like:
> > > cmd->common.command_id = nvme_request_command_id(rq)
> > > that will both increment the genctr and build a command_id
> > > from it.
> > > 
> > > Thoughts?
> > > 
> > 
> > Well, that would require a modification to the CQE specification, no?
> > fmds was not amused when I proposed that :-(
> 
> Why would that require a modification to the CQE? it's just using say
> 4 msbits of the command_id to a running sequence...

I think Hannes was under the impression that the counter proposal wasn't
part of the "command_id". The host can encode whatever it wants in that
value, and the controller just has to return the same value.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
