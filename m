Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CEAC4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Nov 2023 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DO6xt+8UaXSfIekXCYnHWzjjj/SoZBInVpsXJN5LjXk=; b=l59jerTjuD8rOzE5RnCpz+bhvp
	APDLX51DH4saAR8KXQBr3P3stTIQlEyvG2f704MyLtVfOusKcZ6BwbDI679EAsJAPtu5NuUK4i4M+
	fhx9tmvLDElbq38WWJngnBEnBbCXOcAKj/4fmETkygYabghT14veGluDgvgoKsoweunKJV7NhO6u9
	f3EciGCpKwJhXEMVo8nbMVjMz8rTEIYiuowlqtMuiqzISikVEQB3fBSjYfxf5CWpNhct8ejixcqh8
	rfMQESfiv1KfFydNv0jxIIHKWPUhj6Zxas4HcZuC8NSvjNkMo6bD+qOUpB5s+Eqllzjj7i9omsHFs
	Mq0QkKVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyuha-00BWee-26;
	Fri, 03 Nov 2023 13:59:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyuhX-00BWdi-3C
	for linux-nvme@lists.infradead.org;
	Fri, 03 Nov 2023 13:59:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC89867373; Fri,  3 Nov 2023 14:58:57 +0100 (CET)
Date: Fri, 3 Nov 2023 14:58:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <20231103135857.GA1871@lst.de>
References: <20231030160044.20355-1-dwagner@suse.de> <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com> <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_065908_171170_DABB3C9B 
X-CRM114-Status: GOOD (  17.34  )
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

On Fri, Nov 03, 2023 at 01:11:02PM +0100, Daniel Wagner wrote:
> This particular firmware seem to interpret afi one based, while
> the this patch assumes it is zero based

>   Active Firmware Info (AFI): Specifies information about the active
>                               firmware revision.
> 
>   Bit 7    is reserved.
>   Bits 6:4 indicates the firmware slot that is going to be activated
>            at the next Controller Level Reset. If this field is 0h,
>            then the controller does not indicate the firmware slot that
>            is going to be activated at the next Controller Level Reset.
>   Bit 3    is reserved.
>   Bits 2:0 indicates the firmware slot from which the actively running
>            firmware revision was loaded.
> 
> 
> It's not clear to me if afi bits 2:0 is zero or one based. Bits 6:4
> indicate to be 1 based.

All 0's based (what a stupid term..) fields in NVMe are explicitly
marked as such.  And even if that wasn't the case I'd very much
expect the same encoding for the two sub-fields.

