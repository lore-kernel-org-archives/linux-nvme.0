Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DB6C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j8Bkn47RORAytZ6W5dw8Xm60Tyr0SvikX9q/vl1dJng=; b=l0nu9Yle6Io4i4klf1m6/Cj5DS
	Wn5P7L9TeYG0cNZWF1NQSPB+cfrLgXjcPbtNBKzJsTW7P9gBTuOqDbrgqMfSuQ8qI9Lsg+MBwWjLh
	sFyiQnO2z/A5wTV6OT/MY4S4wp7Il1T39e8D25xI+8JDYpH7Gd1G0nWeL2WilLxowBRNN1AelTyTQ
	W3KZO3JC7SQQBuerUMJUTXQV/fFQH3nyWTklbII9+qQcyuuuNptVAA06hvrJ+rtiFsLZEbXZF6PBH
	jNnLGYMSpSw6Y7H3zNEtfrjjGwiJ0+sW3LQKd+crWvD+YAqCvdYFk4qJrg3EOQgwqWBw37PtlFtCO
	23mddsCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3gJc-006Hjg-AB; Tue, 21 Jun 2022 16:01:20 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3gJZ-006Hfp-EW
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 16:01:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 682DECE1B6D;
	Tue, 21 Jun 2022 16:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D931C341C0;
	Tue, 21 Jun 2022 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655827271;
	bh=LGiz934hlBHisxFb7PEGhPsxUhsmgRHhamF+gObPS/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlJz3DIkcpX84mhSG3iYsycsfekSJ1Ktlax7272SFpp3qYnu36g9aWVImfJf80cdm
	 mdrH89ZvLaGd1fcw2fkRrbzzU1OYzw1yc1M1YOLDS2Yay84MrLMhWDoHle+ZZ/xdrI
	 eCWfsjNMVwYtoz/+y4HLXfz0AwXM8g+4UWMfpf3BZ2eRdvgWqn04ycJreQtTP6QuQJ
	 Mp9BYVf7HV479gNuLLmqgFJ1bSSCLAjQ1gF9IvZevyVQugxOpzyHgbBB2Pv0itzANy
	 jtGH18p2/yovNAPRC03InG/5jjx1q3JkqySxu3CFpGT40Vct7++wEZ0OQYBC7Xr+x3
	 JW+X92cKD5vsA==
Date: Tue, 21 Jun 2022 10:01:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, gost.dev@samsung.com, linux-nvme@lists.infradead.org,
	joshi.k@samsung.com
Subject: Re: [PATCH v3] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Message-ID: <YrHrRUcn5kwu2d9V@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a@eucas1p1.samsung.com>
 <20220621070500.1381155-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621070500.1381155-1-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_090117_728636_9EBAC718 
X-CRM114-Status: UNSURE (   9.82  )
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

On Tue, Jun 21, 2022 at 09:05:00AM +0200, Joel Granados wrote:
> Adjust the values of NVME_CAP_CRMS_CRIMS and NVME_CAP_CRMS_CRWMS masks as
> they are different from the ones in TP4084 - Time-to-ready.
> 
> Fixes: 354201c53e61 ("nvme: add support for TP4084 - Time-to-Ready Enhancements").
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

