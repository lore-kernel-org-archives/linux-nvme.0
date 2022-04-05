Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0959CC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWlq9ObQo4afnrXzQf/uD0TPv521LBO3Zl1osjpId+M=; b=iF0KTDFy1XgGfdyShBTaKAJzhR
	cp8Q8ewyOF2RRr9GetuR4NTjcDOE0sbOSbCWQqx29nuw/kW72VAzqBLzamEX6qOFNkUIlOPF72UIN
	LRJGpDi4X63L5HcOSxS+QegYGJFl0pqeklcCs+r18XRRb8IL8TIofEfi/EGcO52xKXZfdUvU0yYS6
	3YqwGok4wEfaVF6wDmbAwIwTAoh20pOu+nodXfTs33G1PkmFimvgIZBttt4IKVuIRvkFC3bG5pMGA
	MLO5j3dtngIbhQsiKRLvNShj3RFm1OAPP3cXUHFYAa7H5jk9+kq8rQcRTQCfvxUU9xa/DX7hbFc7F
	3X96Ce+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nblFZ-001jc1-Vy; Tue, 05 Apr 2022 15:37:46 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nblFX-001jaX-FA
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 15:37:44 +0000
Received: by mail-oi1-x236.google.com with SMTP id w127so13756025oig.10
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lWlq9ObQo4afnrXzQf/uD0TPv521LBO3Zl1osjpId+M=;
 b=f9t+P/0nnhMmwaImxBnMDduZ729xpNc/xBpvNileyrBxML8g4Moo3kndoU5jpmb2a5
 4fh5FoXwB7HD6uwV93e9N9r1wH5Jy0DdigdXnGrlFvHn7O/9E/dOvkSflgR1rMwwflFj
 mD8VWY4BqPEKWEOitvCFG9m9aoNlRuZ1vcwC04WwCwyrwFUAGRQr2YNEJy6tdmzbbkvn
 QrUKWj8qc6TTnXw8HSOEaEN98XpplACtEKRh/Jf3TR52nfTuqcpr+WLfpiRHDzEvsYKX
 wtpG0L/MTzDys2y/bE46rldPEvoDPMcHP0skYAdlheG8AgmWPQyhy5/zgWiTQofyT+9v
 VGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lWlq9ObQo4afnrXzQf/uD0TPv521LBO3Zl1osjpId+M=;
 b=qfV0q2dMODCQ2qJYiSfgvX+suAZjoD2SFl7H0fNmDQ6Rfg2sVVRHQZ7cepUhXSXkL9
 9v0JPtmz+COts4GTJxNdM8cdojlcOvp98+TfmVBmV/+BeWk5qkh96D22R1qmTzQIvHK+
 8K66x1Uwml/PgKo/wLMLrofVoM8E/1Z3nrUkAVl8gHytLspeUG9GYpwx5DFhGUbK2W6w
 n8DRk4VU/s2DLlW9eD+0Gpr7i/Htdyq3lqeTwkDePwlKbAC70a7dxik4/5pQK4C5Kbub
 69APxls2QY4nkbV0bwW4jcWgwXYLM6wao63phDnTwYGTntdIMJppyymKInec6e2qPhAu
 ACgA==
X-Gm-Message-State: AOAM532Fc6HpMw3boPj52mvUBvjXTnajWf3YJ2eMRaMnF07evykgALLc
 w4b99eUMJJcLeaYD3BGqg2ZpvQcT755OkObVjqI=
X-Google-Smtp-Source: ABdhPJyOL6K6/rY7/NDmVIcAfJC8BhiebWpoBwDifTDaHUjUpPI1/7KVLBonGcmGfLfXSSX6WKnLdXdduFVvCgpq4us=
X-Received: by 2002:a05:6808:17a2:b0:2f9:27da:923e with SMTP id
 bg34-20020a05680817a200b002f927da923emr1673063oib.15.1649173061240; Tue, 05
 Apr 2022 08:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220401110829epcas5p39f3cf4d3f6eb8a5c59794787a2b72b15@epcas5p3.samsung.com>
 <20220401110310.611869-1-joshi.k@samsung.com> <20220404072152.GE444@lst.de>
In-Reply-To: <20220404072152.GE444@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 5 Apr 2022 21:07:15 +0530
Message-ID: <CA+1E3rJhw4gL_z8hk7a-4wuZ4a8C-_V8V8dX0c17ivOW2VEt=w@mail.gmail.com>
Subject: Re: [RFC 0/5] big-cqe based uring-passthru
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Pankaj Raghav <pankydev8@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_083743_550387_14BB1AF7 
X-CRM114-Status: GOOD (  12.44  )
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

On Mon, Apr 4, 2022 at 12:51 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I really can't get excited about the pdu thingy.  Here is a patch
> (on top of the series and the patch sent in reply to patch 4) that
> does away with it and just adds a oob_user field to struct io_uring_cmd
> to simplify the handling a fair bit:

Fine. We discussed the tradeoff before, and the concern was
generic-space reduction for other use-cases.
But this is kernel-only change, so we can alter this if/when a new
usecase requires more space.
It seems fine to move ahead with what you proposed.

